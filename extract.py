import json
import os

input_file = r"C:\Users\hary\.gemini\antigravity\brain\97645e54-0c84-461b-a650-7ef58c8a22dc\.system_generated\steps\34\output.txt"
output_dir = r"C:\Users\hary\.gemini\antigravity\scratch\CrashArena"

with open(input_file, 'r', encoding='utf-8') as f:
    data_str = f.read()

# Since the string might have quotes at the start/end from Luau string serialization, let's load it properly.
try:
    data = json.loads(data_str)
except json.JSONDecodeError:
    # If it's a string containing JSON, load it twice
    data_str = json.loads(data_str)
    data = json.loads(data_str)

tree = data.get("tree", [])
scripts = data.get("scripts", [])

# Save the full tree as a JSON file
with open(os.path.join(output_dir, "tree.json"), "w", encoding="utf-8") as f:
    json.dump(tree, f, indent=4)

# Create folders and save scripts
for script in scripts:
    path = script["path"]
    source = script["source"]
    
    # Path format: game.Workspace.Dev_Arena_CyberCity...
    # Let's split by dot and create folders.
    parts = path.split(".")
    
    # Filename is the last part + .lua
    filename = parts[-1] + ".lua"
    
    # Directory path
    if len(parts) > 1:
        dir_parts = parts[:-1]
        dir_path = os.path.join(output_dir, "scripts", *dir_parts)
    else:
        dir_path = os.path.join(output_dir, "scripts")
        
    os.makedirs(dir_path, exist_ok=True)
    
    file_path = os.path.join(dir_path, filename)
    with open(file_path, "w", encoding="utf-8") as f:
        f.write(source)

print(f"Successfully extracted {len(tree)} tree nodes and {len(scripts)} scripts.")
