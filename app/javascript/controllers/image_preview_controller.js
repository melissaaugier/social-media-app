import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "preview"];

  connect() {
    console.log('image');
  }

  preview() {
    const file = this.inputTarget.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = (e) => {
        this.previewTarget.src = e.target.result;
        this.previewTarget.style.display = "block";
      };
      reader.readAsDataURL(file);
    } else {
      this.previewTarget.src = "#";
      this.previewTarget.style.display = "none";
    }
  }
}
