class SpeakerLogin {
    constructor() {
        this.form = document.getElementById('speakerLoginForm');
        this.errorMessage = document.getElementById('errorMessage');
        this.init();
    }
    
    init() {
        this.form.addEventListener('submit', this.handleLogin.bind(this));
        
        // Auto-format speaker code input
        const codeInput = document.getElementById('speakerCode');
        if (codeInput) {
            codeInput.addEventListener('input', this.formatSpeakerCode.bind(this));
        }

        // Recovery Modal Bindings
        const forgotHelpLink = document.getElementById('forgotHelpLink');
        const recoveryModal = document.getElementById('recoveryModal');
        const closeRecoveryBtn = document.getElementById('closeRecoveryBtn');
        const recoveryForm = document.getElementById('recoveryForm');

        if (forgotHelpLink && recoveryModal) {
            forgotHelpLink.addEventListener('click', (e) => {
                e.preventDefault();
                recoveryModal.style.display = 'flex';
            });
        }

        if (closeRecoveryBtn && recoveryModal) {
            closeRecoveryBtn.addEventListener('click', () => {
                recoveryModal.style.display = 'none';
            });
            recoveryModal.addEventListener('click', (e) => {
                if (e.target === recoveryModal) {
                    recoveryModal.style.display = 'none';
                }
            });
        }

        if (recoveryForm) {
            recoveryForm.addEventListener('submit', this.handleRecoverySubmit.bind(this));
        }
    }
    
    formatSpeakerCode(event) {
        let value = event.target.value.toUpperCase();
        // Remove non-alphanumeric characters
        value = value.replace(/[^A-Z0-9]/g, '');
        
        // Ensure SP prefix
        if (value && !value.startsWith('SP')) {
            if (value.match(/^\d/)) {
                value = 'SP' + value;
            }
        }
        
        event.target.value = value;
    }
    
    async handleLogin(event) {
        event.preventDefault();
        
        const speakerCode = document.getElementById('speakerCode').value.trim();
        const password = document.getElementById('password').value.trim();
        
        if (!speakerCode) {
            this.showError('Please enter your speaker code');
            return;
        }
        
        if (!password) {
            this.showError('Please enter your password');
            return;
        }
        
        // Validate format
        if (!speakerCode.match(/^SP\d{3}$/)) {
            this.showError('Speaker code must be in format: SP001, SP002, etc.');
            return;
        }
        
        this.setLoading(true);
        this.hideError();
        
        try {
            const response = await fetch(`/api/speaker/login`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ speakerCode, password })
            });
            
            const data = await response.json();
            
            if (response.ok) {
                // Store speaker info
                localStorage.setItem('speakerData', JSON.stringify(data));
                localStorage.setItem('speakerCode', speakerCode);
                localStorage.setItem('speakerToken', data.token);
                
                // Redirect to dashboard
                window.location.href = 'speaker-dashboard.html';
            } else {
                this.showError(data.error || 'Invalid credentials');
            }
        } catch (error) {
            console.error('Login error:', error);
            this.showError('Network error. Please try again.');
        } finally {
            this.setLoading(false);
        }
    }
    
    setLoading(isLoading) {
        const submitBtn = this.form.querySelector('.login-submit-btn');
        const btnText = submitBtn.querySelector('.btn-text');
        const btnLoader = submitBtn.querySelector('.btn-loader');
        
        if (isLoading) {
            btnText.style.display = 'none';
            btnLoader.style.display = 'inline';
            submitBtn.disabled = true;
        } else {
            btnText.style.display = 'inline';
            btnLoader.style.display = 'none';
            submitBtn.disabled = false;
        }
    }

    async handleRecoverySubmit(event) {
        event.preventDefault();
        const submitBtn = document.getElementById('recoverySubmitBtn');
        const btnText = submitBtn.querySelector('.btn-text');
        const btnLoader = submitBtn.querySelector('.btn-loader');
        
        const full_name = document.getElementById('recoveryName').value.trim();
        const email = document.getElementById('recoveryEmail').value.trim();
        const message = document.getElementById('recoveryMessage').value.trim();

        btnText.style.display = 'none';
        btnLoader.style.display = 'inline';
        submitBtn.disabled = true;

        try {
            const response = await fetch('/api/recovery-requests', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ full_name, email, message })
            });

            if (response.ok) {
                alert('Recovery request sent to the admin successfully!');
                document.getElementById('recoveryModal').style.display = 'none';
                document.getElementById('recoveryForm').reset();
            } else {
                const err = await response.json();
                alert('Failed to send request: ' + (err.error || 'Unknown error'));
            }
        } catch (error) {
            console.error('Recovery error:', error);
            alert('Network error. Please try again.');
        } finally {
            btnText.style.display = 'inline';
            btnLoader.style.display = 'none';
            submitBtn.disabled = false;
        }
    }
    
    showError(message) {
        this.errorMessage.textContent = message;
        this.errorMessage.style.display = 'block';
    }
    
    hideError() {
        this.errorMessage.style.display = 'none';
    }
}

// Initialize when page loads
document.addEventListener('DOMContentLoaded', () => {
    new SpeakerLogin();
});