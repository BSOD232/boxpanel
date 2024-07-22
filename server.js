const express = require('express');
const os = require('os');
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.static('public'));

app.get('/api/stats', (req, res) => {
    const cpuUsage = getCPUUsage();
    const ramUsage = getRAMUsage();
    const storageUsage = getStorageUsage();

    res.json({
        cpu: cpuUsage,
        ram: ramUsage,
        storage: storageUsage
    });
});

function getCPUUsage() {
    const cpus = os.cpus();
    let totalIdle = 0, totalTick = 0;

    cpus.forEach(cpu => {
        for (type in cpu.times) {
            totalTick += cpu.times[type];
        }
        totalIdle += cpu.times.idle;
    });

    return 100 - Math.round(100 * totalIdle / totalTick);
}

function getRAMUsage() {
    return Math.round((os.totalmem() - os.freemem()) / os.totalmem() * 100);
}

function getStorageUsage() {
    // For simplicity, using fixed value; In real scenario, use appropriate module to fetch storage details
    return 75;
}

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
