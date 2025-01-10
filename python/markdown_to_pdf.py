import sys
import os
import subprocess
from PyQt5.QtWidgets import (
    QApplication,
    QMainWindow,
    QTextEdit,
    QPushButton,
    QVBoxLayout,
    QWidget,
    QFileDialog,
    QMessageBox,
)
from PyQt5.QtCore import Qt


class MarkdownToPdfApp(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("Markdown to PDF Converter")
        self.setGeometry(100, 100, 800, 600)
        self.initUI()

    def initUI(self):
        # Main widget and layout setup
        main_widget = QWidget()
        self.setCentralWidget(main_widget)
        layout = QVBoxLayout(main_widget)

        # TextEdit for Markdown input
        self.markdown_input = QTextEdit(self)
        layout.addWidget(self.markdown_input)

        # Button to generate PDF
        generate_pdf_button = QPushButton("Generate PDF", self)
        generate_pdf_button.clicked.connect(self.generate_pdf)
        layout.addWidget(generate_pdf_button)

    def generate_pdf(self):
        # Retrieve Markdown text
        markdown_text = self.markdown_input.toPlainText().strip()

        if not markdown_text:
            QMessageBox.warning(
                self,
                "Input Error",
                "Please enter Markdown content before generating a PDF.",
            )
            return

        # Write Markdown content to a file
        markdown_file = "generated/example.md"
        self.write_markdown_to_file(markdown_text, markdown_file)

        # Convert Markdown to HTML using Pandoc
        html_file = "generated/example.html"
        self.convert_md_to_html(markdown_file, html_file)

        # Convert HTML to PDF using wkhtmltopdf
        pdf_file, _ = QFileDialog.getSaveFileName(
            self, "Save PDF", "", "PDF Files (*.pdf)"
        )
        if pdf_file:
            self.convert_html_to_pdf(html_file, pdf_file)
            QMessageBox.information(
                self, "Success", f"PDF generated successfully at {pdf_file}"
            )

        # Clean up intermediate files
        self.clean_up([markdown_file, html_file])

    def write_markdown_to_file(self, markdown_text, filename):
        with open(filename, "w", encoding="utf-8") as f:
            f.write(markdown_text)
        print(f"Markdown content written to {filename}")

    def convert_md_to_html(self, input_md, output_html):
        css_styles = self.get_css_styles()
        css_file = "generated/styles.css"

        # Write CSS to a file
        with open(css_file, "w", encoding="utf-8") as f:
            f.write(css_styles)
        print(f"CSS styles written to {css_file}")

        # Convert Markdown to HTML using Pandoc
        try:
            subprocess.run(
                [
                    "pandoc",
                    input_md,
                    "-o",
                    output_html,
                    "--css",
                    css_file,
                    "--self-contained",
                ],
                check=True,
            )
            print(f"Successfully converted {input_md} to {output_html} with CSS")
        except subprocess.CalledProcessError as e:
            QMessageBox.critical(
                self, "Error", f"Failed to convert Markdown to HTML: {str(e)}"
            )
            raise

    def convert_html_to_pdf(self, input_html, output_pdf):
        try:
            subprocess.run(["wkhtmltopdf", input_html, output_pdf], check=True)
            print(f"Successfully converted {input_html} to {output_pdf}")
        except subprocess.CalledProcessError as e:
            QMessageBox.critical(
                self, "Error", f"Failed to convert HTML to PDF: {str(e)}"
            )
            raise

    def clean_up(self, files):
        for file in files:
            if os.path.exists(file):
                os.remove(file)
                print(f"Removed file: {file}")
            else:
                print(f"File not found: {file}")

    def get_css_styles(self):
        return """
        body { font-family: Arial, sans-serif; margin: 40px; line-height: 1.6; color: #333; background-color: #f9f9f9; }
        h1, h2, h3, h4, h5, h6 { color: #2c3e50; font-weight: bold; margin-top: 20px; margin-bottom: 10px; }
        h1 { font-size: 2.5em; border-bottom: 2px solid #e74c3c; padding-bottom: 10px; }
        h2 { font-size: 2em; border-bottom: 1px solid #e74c3c; padding-bottom: 5px; }
        p { margin-bottom: 15px; color: #555; }
        a { color: #3498db; text-decoration: none; }
        a:hover { text-decoration: underline; }
        ul, ol { margin-bottom: 20px; margin-left: 20px; }
        ul li, ol li { margin-bottom: 5px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; color: #333; }
        code { font-family: 'Courier New', Courier, monospace; background-color: #f4f4f4; padding: 2px 4px; border-radius: 4px; }
        pre { background-color: #f4f4f4; padding: 10px; overflow-x: auto; }
        blockquote { margin: 0; padding: 10px; background-color: #e9ecef; border-left: 5px solid #e74c3c; }
        img { max-width: 100%; height: auto; display: block; margin: 20px auto; }
        hr { border: 0; height: 1px; background: #ddd; margin: 30px 0; }
        """


def main():
    app = QApplication(sys.argv)
    window = MarkdownToPdfApp()
    window.show()
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()
