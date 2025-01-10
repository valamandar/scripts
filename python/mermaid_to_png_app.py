import sys
import os
import subprocess
from PyQt5.QtWidgets import QApplication, QMainWindow, QTextEdit, QPushButton, QVBoxLayout, QWidget, QFileDialog, QMessageBox
from PyQt5.QtCore import Qt

class MermaidToPngApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Mermaid to PNG Converter")
        self.setGeometry(100, 100, 800, 600)
        self.initUI()

    def initUI(self):
        # Main widget and layout setup
        main_widget = QWidget()
        self.setCentralWidget(main_widget)
        layout = QVBoxLayout(main_widget)

        # TextEdit for Mermaid input
        self.mermaid_input = QTextEdit(self)
        layout.addWidget(self.mermaid_input)

        # Button to generate PNG
        generate_png_button = QPushButton("Generate PNG", self)
        generate_png_button.clicked.connect(self.generate_png)
        layout.addWidget(generate_png_button)

    def generate_png(self):
        # Retrieve Mermaid text
        mermaid_text = self.mermaid_input.toPlainText().strip()

        if not mermaid_text:
            QMessageBox.warning(self, "Input Error", "Please enter Mermaid content before generating a PNG.")
            return

        # Write Mermaid content to a file
        mermaid_file = 'diagram.mmd'
        self.write_mermaid_to_file(mermaid_text, mermaid_file)

        # Convert Mermaid to PNG using mmdc
        png_file, _ = QFileDialog.getSaveFileName(self, "Save PNG", "", "PNG Files (*.png)")
        if png_file:
            self.convert_mermaid_to_png(mermaid_file, png_file)
            QMessageBox.information(self, "Success", f"PNG generated successfully at {png_file}")

        # Clean up intermediate files
        self.clean_up([mermaid_file])

    def write_mermaid_to_file(self, mermaid_text, filename):
        with open(filename, 'w', encoding='utf-8') as f:
            f.write(mermaid_text)
        print(f"Mermaid content written to {filename}")

    def convert_mermaid_to_png(self, input_mmd, output_png):
        try:
            # Run mermaid-cli to convert the Mermaid diagram to a PNG
            subprocess.run(["mmdc", "-i", input_mmd, "-o", output_png], check=True)
            print(f"Successfully converted {input_mmd} to {output_png}")
        except subprocess.CalledProcessError as e:
            QMessageBox.critical(self, "Error", f"Failed to convert Mermaid to PNG: {str(e)}")
            raise

    def clean_up(self, files):
        for file in files:
            if os.path.exists(file):
                os.remove(file)
                print(f"Removed file: {file}")
            else:
                print(f"File not found: {file}")

def main():
    app = QApplication(sys.argv)
    window = MermaidToPngApp()
    window.show()
    sys.exit(app.exec_())

if __name__ == "__main__":
    main()
