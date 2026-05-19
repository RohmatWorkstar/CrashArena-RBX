const fs = require('fs');
const path = require('path');

const treeInputFile = String.raw`C:\Users\hary\.gemini\antigravity\brain\97645e54-0c84-461b-a650-7ef58c8a22dc\.system_generated\steps\121\output.txt`;
const outputDir = String.raw`C:\Users\hary\.gemini\antigravity\scratch\CrashArena`;

try {
    let rawData = fs.readFileSync(treeInputFile, 'utf8');
    
    let data;
    try {
        data = JSON.parse(rawData);
    } catch (e) {
        rawData = JSON.parse(rawData);
        data = JSON.parse(rawData);
    }

    const tree = Array.isArray(data) ? data : (data.tree || []);

    fs.writeFileSync(path.join(outputDir, 'tree.json'), JSON.stringify(tree, null, 2), 'utf8');
    console.log(`Successfully extracted ${tree.length} filtered tree nodes into tree.json.`);
} catch (error) {
    console.error('Error during tree extraction:', error);
}
