const fs = require('fs');
const path = require('path');

const inputFile = String.raw`C:\Users\hary\.gemini\antigravity\brain\97645e54-0c84-461b-a650-7ef58c8a22dc\.system_generated\steps\100\output.txt`;
const outputDir = String.raw`C:\Users\hary\.gemini\antigravity\scratch\CrashArena`;

try {
    let rawData = fs.readFileSync(inputFile, 'utf8');
    
    let data;
    try {
        data = JSON.parse(rawData);
    } catch (e) {
        rawData = JSON.parse(rawData);
        data = JSON.parse(rawData);
    }

    // data should be an array of scripts
    const scripts = Array.isArray(data) ? data : (data.scripts || []);

    console.log(`Found ${scripts.length} scripts to extract.`);

    for (const script of scripts) {
        const scriptPath = script.path;
        let source = script.source;

        if (source === null || source === undefined) {
            source = "-- [Empty or unreadable source]";
        } else if (typeof source !== 'string') {
            source = String(source);
        }

        // We clean up 'game.' from the path if present to keep it neat
        let cleanPath = scriptPath;
        if (cleanPath.startsWith('game.')) {
            cleanPath = cleanPath.slice(5);
        }

        const parts = cleanPath.split('.');
        const filename = parts[parts.length - 1] + '.lua';

        let dirPath = path.join(outputDir, 'scripts');
        if (parts.length > 1) {
            const dirParts = parts.slice(0, parts.length - 1);
            dirPath = path.join(dirPath, ...dirParts);
        }

        fs.mkdirSync(dirPath, { recursive: true });

        const filePath = path.join(dirPath, filename);
        fs.writeFileSync(filePath, source, 'utf8');
        console.log(`Extracted: ${scriptPath} -> ${filePath}`);
    }

    console.log(`Successfully extracted all ${scripts.length} scripts.`);
} catch (error) {
    console.error('Error during extraction:', error);
}
