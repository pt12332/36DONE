
function scrollSlider(direction) {
    const slider = document.getElementById('movieSlider');
    const itemWidth = slider.querySelector('.movie-item').offsetWidth + 40;
    slider.scrollLeft += direction * itemWidth * 5; // Scroll by 5 items
}

function toggleContact() {
    const box = document.getElementById('contactBox');
    box.style.display = (box.style.display === "block") ? "none" : "block";
}

// Ẩn khi click bên ngoài
document.addEventListener('click', function (event) {
    const box = document.getElementById('contactBox');
    const button = document.querySelector('.btn-danger');
    if (!box.contains(event.target) && !button.contains(event.target)) {
        box.style.display = 'none';
    }
});



document.getElementById('contactForm').addEventListener('submit', function (e) {
    e.preventDefault(); // Ngăn reload

    const name = document.getElementById('userName').value;
    const email = document.getElementById('userEmail').value;

    // Xử lý gửi dữ liệu ở đây (AJAX, fetch, alert,...)
    alert(`Thông tin đã gửi:\nHọ tên: ${name}\nEmail: ${email}`);

    // Đóng modal
    const modal = bootstrap.Modal.getInstance(document.getElementById('contactModal'));
    modal.hide();

    // Reset form
    this.reset();
});


document.addEventListener("DOMContentLoaded", function () {
    const menuLinks = document.querySelectorAll(".dropdown-menu a");
    const sections = document.querySelectorAll(".product-section");
    const movieSection = document.querySelector(".movie-section");

    menuLinks.forEach(link => {
        link.addEventListener("click", function (e) {
            e.preventDefault();
            const targetId = this.getAttribute("href").substring(1);

            // Ẩn tất cả các section sản phẩm
            sections.forEach(section => section.classList.add("d-none"));

            // Hiện section được chọn
            const targetSection = document.getElementById(targetId);
            if (targetSection) {
                targetSection.classList.remove("d-none");
                targetSection.scrollIntoView({ behavior: 'smooth' });
            }

            // Ẩn phần movie-section nếu có
            if (movieSection) {
                movieSection.classList.add("d-none");
            }
        });
    });
});


let currentProductInfo = '';
let currentProductPackage1 = '';
let currentProductPackage2 = '';

function showProduct(infoImg, packageImg1, packageImg2) {
    currentProductInfo = infoImg;
    currentProductPackage1 = packageImg1;
    currentProductPackage2 = packageImg2;
}


function showImageModal(imageSrcs) {
    const imgContainer = document.getElementById("modalImageContainer");
    imgContainer.innerHTML = ''; // Xóa nội dung cũ

    if (Array.isArray(imageSrcs)) {
        const row = document.createElement("div");
        row.className = "d-flex flex-wrap justify-content-center gap-3";
        
        imageSrcs.forEach(src => {
            const img = document.createElement("img");
            img.src = src;
            img.className = "rounded shadow";
            img.style.maxHeight = "800px";
            img.style.maxWidth = "800px";
            img.style.objectFit = "contain";
            row.appendChild(img);
        });

        imgContainer.appendChild(row);
    } else {
        const img = document.createElement("img");
        img.src = imageSrcs;
        img.className = "rounded shadow w-100";
        img.style.maxHeight = "800px";
        img.style.objectFit = "contain";
        imgContainer.appendChild(img);
    }

    const modal = new bootstrap.Modal(document.getElementById('imageModal'));
    modal.show();
}



