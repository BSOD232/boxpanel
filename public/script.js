document.addEventListener('DOMContentLoaded', () => {
    fetch('/api/stats')
        .then(response => response.json())
        .then(data => {
            document.getElementById('cpu-usage').textContent = data.cpu + '%';
            document.getElementById('ram-usage').textContent = data.ram + '%';
            document.getElementById('storage-usage').textContent = data.storage + '%';
        })
        .catch(error => console.error('Error fetching stats:', error));
});
