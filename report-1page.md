Mục tiêu

Bài thực hành này nhằm giúp sinh viên hiểu quy trình cơ bản của thuật toán mã hóa và giải mã AES-128. Chương trình tập trung vào việc xử lý block 128-bit, mở rộng khóa (Key Expansion), các phép biến đổi trong từng vòng mã hóa và cơ chế padding đơn giản. Thông qua bài lab, sinh viên có thể quan sát cách plaintext được chuyển thành ciphertext và cách dữ liệu được khôi phục lại thông qua quá trình giải mã.

Phương pháp thực hiện

Repo gồm ba file mã nguồn chính: encrypt.cpp, decrypt.cpp và structures.h.

encrypt.cpp thực hiện chức năng mã hóa plaintext và ghi ciphertext vào file message.aes.
decrypt.cpp đọc file message.aes và thực hiện giải mã để khôi phục dữ liệu ban đầu.
structures.h chứa các thành phần cốt lõi của AES như S-box, inverse S-box, bảng tra cứu phép nhân trong GF(2^8), hằng số RCon và hàm KeyExpansion.

Cấu trúc repo được tổ chức lại theo mẫu starter repo của FIT4012 Lab 4 nhằm tăng tính chuyên nghiệp và dễ bảo trì. Repo bao gồm:

Makefile
CMakeLists.txt
thư mục tests/
thư mục logs/
thư mục scripts/
GitHub Actions CI để tự động build và kiểm tra chương trình

Cách tổ chức này giúp chương trình dễ kiểm thử, dễ mở rộng và hỗ trợ tự động hóa quá trình phát triển.

Kết quả

Chương trình có thể được biên dịch thành công bằng cả Makefile và CMake.

Khi chạy thử với plaintext hello FIT4012 AES, chương trình mã hóa tạo ra file message.aes. Sau đó, chương trình giải mã đọc file này và khôi phục chính xác plaintext ban đầu. Do độ dài plaintext chưa đủ để lấp đầy block 128-bit nên sau giải mã xuất hiện thêm các byte padding 0x00 ở cuối block.

Các bài kiểm tra cơ bản đã được thực hiện gồm:

Kiểm tra biên dịch chương trình
Kiểm tra encrypt/decrypt round-trip
Kiểm tra plaintext nhiều block
Kiểm tra trường hợp sai khóa
Kiểm tra ciphertext bị chỉnh sửa

Kết quả cho thấy chương trình mô phỏng đúng quy trình hoạt động cơ bản của AES-128.

Kết luận

Bài lab phù hợp để minh họa cơ chế hoạt động của AES-128 và giúp sinh viên hiểu mối liên hệ giữa mã hóa, giải mã, mở rộng khóa và xử lý block dữ liệu. Ngoài ra, cấu trúc repo cũng thể hiện cách tổ chức project theo hướng chuyên nghiệp với hỗ trợ build tự động và kiểm thử cơ bản.

Tuy nhiên, chương trình hiện vẫn còn một số hạn chế. Việc xử lý ciphertext bằng C-style string chưa thật sự an toàn đối với dữ liệu binary. Trong tương lai có thể cải tiến bằng cách:

Sử dụng byte vector để đọc/ghi dữ liệu binary an toàn hơn
Thêm cơ chế PKCS#7 padding
Bổ sung AES official test vectors
Cải thiện xử lý lỗi và kiểm tra dữ liệu đầu vào

Tổng thể, bài lab cung cấp nền tảng tốt để tiếp cận mật mã khóa đối xứng và hiểu cách triển khai AES-128 trong thực tế.
