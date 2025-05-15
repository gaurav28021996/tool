<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Ultimate Tools Hub - 100+ Free Online Tools</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    :root {
      --primary-color: #2563eb;
      --hover-color: #1d4ed8;
      --bg-light: #ffffff;
      --text-light: #2d3748;
      --bg-dark: #1a202c;
      --text-dark: #e2e8f0;
    }

    [data-theme="dark"] {
      background: var(--bg-dark);
      color: var(--text-dark);
    }

    [data-theme="dark"] .card {
      background: #2d3748;
      border: 1px solid #4a5568;
    }

    .tool-card {
      transition: transform 0.2s, box-shadow 0.2s;
      cursor: pointer;
      height: 100%;
    }

    .tool-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .search-container {
      position: sticky;
      top: 0;
      background: var(--bg-light);
      z-index: 1000;
      padding: 1rem 0;
    }

    [data-theme="dark"] .search-container {
      background: var(--bg-dark);
    }

    .loading-overlay {
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.5);
      display: none;
      place-items: center;
      z-index: 9999;
    }
  </style>
</head>
<body data-theme="light">
  <!-- Header -->
  <header class="bg-primary text-white p-3">
    <div class="container d-flex justify-content-between align-items-center">
      <h1 class="mb-0">🔧 ToolHub</h1>
      <div>
        <button class="btn btn-light" onclick="toggleTheme()">🌓</button>
      </div>
    </div>
  </header>

  <!-- Search -->
  <div class="search-container">
    <div class="container">
      <input type="text" id="search" class="form-control" placeholder="🔍 Search 100+ tools...">
    </div>
  </div>

  <!-- Tools Grid -->
  <div class="container mt-4">
    <div class="row g-4" id="toolsContainer"></div>
  </div>

  <!-- Loading Overlay -->
  <div class="loading-overlay text-white">
    <div class="text-center">
      <div class="spinner-border" style="width: 3rem; height: 3rem;"></div>
      <h3 class="mt-3">Processing...</h3>
    </div>
  </div>

  <!-- Footer -->
  <footer class="bg-dark text-white mt-5 p-4">
    <div class="container text-center">
      <p>© 2024 ToolHub | <a href="#" class="text-white">Privacy Policy</a></p>
    </div>
  </footer>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <!-- App Logic -->
  <script>
    // Tool Database (100+ entries - 5 shown for demo)
    const tools = [
      {
        id: 1,
        name: "Image to PNG",
        category: "Image Tools",
        tags: ["convert", "png", "image"],
        icon: "🖼️",
        function: "imageToPNG()"
      },
      {
        id: 2,
        name: "Word Counter",
        category: "Text Tools",
        tags: ["text", "count", "analysis"],
        icon: "📝",
        function: "wordCounter()"
      },
      {
        id: 3,
        name: "BMI Calculator",
        category: "Health",
        tags: ["health", "calculator", "bmi"],
        icon: "⚖️",
        function: "bmiCalculator()"
      },
      {
        id: 4,
        name: "JSON Formatter",
        category: "Developer",
        tags: ["code", "format", "json"],
        icon: "👨💻",
        function: "jsonFormatter()"
      },
      {
        id: 5,
        name: "Password Generator",
        category: "Security",
        tags: ["security", "password", "generator"],
        icon: "🔒",
        function: "passwordGenerator()"
      }
    ];

    // Initialize
    document.addEventListener('DOMContentLoaded', () => {
      renderTools();
      initSearch();
      loadTheme();
    });

    // Render Tools Grid
    function renderTools() {
      const container = document.getElementById('toolsContainer');
      let html = '';
      
      tools.forEach(tool => {
        html += `
          <div class="col-6 col-md-4 col-lg-3" 
               data-category="${tool.category}" 
               data-tags="${tool.tags.join(' ')}">
            <div class="card tool-card p-3" onclick="${tool.function}">
              <div class="card-body text-center">
                <div class="fs-1 mb-3">${tool.icon}</div>
                <h5 class="card-title">${tool.name}</h5>
                <small class="text-muted">${tool.category}</small>
              </div>
            </div>
          </div>
        `;
      });

      container.innerHTML = html;
    }

    // Search Functionality
    function initSearch() {
      const searchInput = document.getElementById('search');
      searchInput.addEventListener('input', (e) => {
        const term = e.target.value.toLowerCase();
        document.querySelectorAll('[data-category]').forEach(tool => {
          const name = tool.querySelector('.card-title').textContent.toLowerCase();
          const tags = tool.getAttribute('data-tags').toLowerCase();
          tool.style.display = (name.includes(term) || tags.includes(term)) ? 'block' : 'none';
        });
      });
    }

    // Theme Management
    function toggleTheme() {
      const newTheme = document.body.getAttribute('data-theme') === 'dark' ? 'light' : 'dark';
      document.body.setAttribute('data-theme', newTheme);
      localStorage.setItem('theme', newTheme);
    }

    function loadTheme() {
      const savedTheme = localStorage.getItem('theme') || 'light';
      document.body.setAttribute('data-theme', savedTheme);
    }

    // Loading State
    function showLoading(show) {
      document.querySelector('.loading-overlay').style.display = show ? 'grid' : 'none';
    }

    // Tool Implementations
    function imageToPNG() {
      showToolUI(`
        <h2>🖼️ Image to PNG Converter</h2>
        <input type="file" class="form-control" id="imageInput" accept="image/*">
        <div id="conversionResult" class="mt-3"></div>
      `);

      document.getElementById('imageInput').addEventListener('change', async () => {
        showLoading(true);
        try {
          const file = document.getElementById('imageInput').files[0];
          if (!file) return;

          const img = await loadImage(file);
          const pngBlob = await convertToPNG(img);
          const url = URL.createObjectURL(pngBlob);

          document.getElementById('conversionResult').innerHTML = `
            <a href="${url}" download="converted.png" class="btn btn-success mt-3">
              Download PNG
            </a>
          `;
        } catch (error) {
          document.getElementById('conversionResult').innerHTML = `
            <div class="alert alert-danger mt-3">${error.message}</div>
          `;
        }
        showLoading(false);
      });
    }

    function wordCounter() {
      showToolUI(`
        <h2>📝 Word Counter</h2>
        <textarea class="form-control" rows="5" id="textInput"></textarea>
        <div class="mt-3">
          <div>Words: <span id="wordCount">0</span></div>
          <div>Characters: <span id="charCount">0</span></div>
        </div>
      `);

      document.getElementById('textInput').addEventListener('input', function(e) {
        const text = e.target.value.trim();
        document.getElementById('wordCount').textContent = text.split(/\s+/).length;
        document.getElementById('charCount').textContent = text.length;
      });
    }

    function bmiCalculator() {
      showToolUI(`
        <h2>⚖️ BMI Calculator</h2>
        <div class="row g-3">
          <div class="col-md-6">
            <input type="number" class="form-control" id="weight" placeholder="Weight (kg)">
          </div>
          <div class="col-md-6">
            <input type="number" class="form-control" id="height" placeholder="Height (cm)">
          </div>
          <button class="btn btn-primary" onclick="calculateBMI()">Calculate</button>
          <div id="bmiResult" class="mt-3"></div>
        </div>
      `);
    }

    function calculateBMI() {
      const weight = parseFloat(document.getElementById('weight').value);
      const height = parseFloat(document.getElementById('height').value) / 100;
      const resultDiv = document.getElementById('bmiResult');
      
      try {
        if (!weight || !height) throw new Error('Please enter valid values');
        const bmi = weight / (height * height);
        resultDiv.innerHTML = `<div class="alert alert-info">BMI: ${bmi.toFixed(1)}</div>`;
      } catch (error) {
        resultDiv.innerHTML = `<div class="alert alert-danger">${error.message}</div>`;
      }
    }

    function passwordGenerator() {
      showToolUI(`
        <h2>🔒 Password Generator</h2>
        <div class="row g-3">
          <div class="col-12">
            <input type="number" id="length" class="form-control" value="12" min="6">
          </div>
          <div class="col-md-6">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" id="uppercase" checked>
              <label class="form-check-label">Uppercase</label>
            </div>
          </div>
          <div class="col-md-6">
            <div class="form-check">
              <input class="form-check-input" type="checkbox" id="symbols" checked>
              <label class="form-check-label">Symbols</label>
            </div>
          </div>
          <button class="btn btn-primary" onclick="generatePassword()">Generate</button>
          <div id="passwordOutput" class="mt-3"></div>
        </div>
      `);
    }

    function generatePassword() {
      const length = document.getElementById('length').value;
      const charset = 'abcdefghijklmnopqrstuvwxyz' +
        (document.getElementById('uppercase').checked ? 'ABCDEFGHIJKLMNOPQRSTUVWXYZ' : '') +
        (document.getElementById('symbols').checked ? '!@#$%^&*()' : '');
      
      let password = '';
      for (let i = 0; i < length; i++) {
        password += charset.charAt(Math.floor(Math.random() * charset.length));
      }
      document.getElementById('passwordOutput').innerHTML = `
        <div class="alert alert-success">
          ${password} <button onclick="navigator.clipboard.writeText('${password}')" 
          class="btn btn-sm btn-success float-end">Copy</button>
        </div>
      `;
    }

    // Helper Functions
    function showToolUI(content) {
      document.getElementById('toolsContainer').innerHTML = `
        <div class="col-12">
          <div class="card">
            <div class="card-body">
              <button class="btn btn-secondary mb-3" onclick="renderTools()">← Back</button>
              ${content}
            </div>
          </div>
        </div>
      `;
    }

    async function loadImage(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader();
        reader.onload = (e) => {
          const img = new Image();
          img.onload = () => resolve(img);
          img.onerror = reject;
          img.src = e.target.result;
        };
        reader.readAsDataURL(file);
      });
    }

    async function convertToPNG(img) {
      return new Promise(resolve => {
        const canvas = document.createElement('canvas');
        canvas.width = img.width;
        canvas.height = img.height;
        canvas.getContext('2d').drawImage(img, 0, 0);
        canvas.toBlob(resolve, 'image/png');
      });
    }
  </script>
</body>
</html>
