create database Quanlyhocvien2;

CREATE TABLE `quanlyhocvien2`.`test` (
  `TestID` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`TestID`));

CREATE TABLE `quanlyhocvien2`.`student` (
  `RN` INT NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Age` INT NULL,
  `Status` VARCHAR(45) NULL,
  PRIMARY KEY (`RN`));

Create table StudentTest (
RN INT,
TestID INT,
primary key(RN, TestID),
Date Date,
Mark float 
);

-- 2. Hiển thị danh sách các học viên đã tham gia thi, các môn thi được thi bởi các học viên đó
Create View DSdiemThi as
select student.Name,test.Name Nametest,studenttest.mark,studenttest.Date
 from studenttest join test on studenttest.testid = test.testid join student  on studenttest.RN = student.RN;

-- 3. Hiển thị danh sách các bạn học viên chưa thi môn nào
Select *from student 
where not exists (select * from studenttest where student.RN = studenttest.RN);

-- 4. Hiển thị danh sách học viên phải thi lại, tên môn học phải thi lại và điểm  thi lại là điểm nhỏ hơn 5;
select S.name , T.name , ST.mark, ST.date
from studenttest ST join  test T on ST.testid = T.testID join student S on ST.RN = S.RN
where ST.mark < 5;

-- 5. Hiển thị danh sách học viên và điểm trung bình(Average) của các môn đã thi. Danh sách phải sắp xếp theo thứ tự điểm trung bình giảm dần
create view DanhSachDiemTB as 
select student.Name , avg(mark) as 'DiemTB'
from studenttest join student on studenttest.RN = student.RN
group by name ;
select * from DanhSachDiemTB ;

-- 6. Hiển thị tên và điểm trung bình của học viên có điểm trung bình lớn nhất 
select DanhSachDiemTB.name , max(DiemTB) as 'MarkMax'
from DanhSachDiemTB;

-- 7. Hiển thị điểm thi cao nhất của từng môn học
select dsdiemthi.Nametest,max(mark) as 'maxmark'
from dsdiemthi
group by dsdiemthi.Nametest
order by  dsdiemthi.Nametest ASC;

-- 8.Hiển thị danh sách tất cả các học viên và môn học mà các học viên đó đã thi nếu học viên chưa thi môn nào thì phần tên môn học để Null 

-- 9.Sửa (Update) tuổi của tất cả các học viên mỗi người lên một tuổi.
update student set age = age + 2
where RN >0;

-- 10.Thêm trường tên là Status có kiểu Varchar(10) vào bảng Student.
alter table student add status varchar(10);

-- 11.Cập nhật(Update) trường Status sao cho những học viên nhỏ hơn 30 tuổi sẽ nhận giá trị ‘Young’, trường hợp còn lại nhận giá trị ‘Old’ sau đó hiển thị toàn bộ nội dung bảng Student
update student set status = 'young'
where Age < 30 and RN>0;
update student set status = 'old'
where Age >= 30 and RN>0;

-- 12. Tạo view tên là vwStudentTestList hiển thị danh sách học viên và điểm thi, dánh sách phải sắp xếp tăng dần theo ngày thi 
CREATE VIEW vwStudentTestList AS
select * from dsdiemthi
order by  dsdiemthi.date ASC;
select * from vwStudentTestList;