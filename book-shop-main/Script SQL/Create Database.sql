CREATE SCHEMA `bookstore` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;

CREATE TABLE `bookstore`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(30) NOT NULL,
  `image` VARCHAR(2000) NULL,
  `address` NVARCHAR(100) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  `password` VARCHAR(20) NOT NULL,
   CHECK (LENGTH(`password`) >= 8),
  `isRole` INT NOT NULL,
  `active` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;

CREATE TABLE `bookstore`.`product` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idCategory` INT NULL,
  `name` NVARCHAR(200) NOT NULL,
  `image` VARCHAR(2000) NULL,
  `Productcol` VARCHAR(45) NULL,
  `originalPrice` INT NOT NULL,
  `salePrice` INT NOT NULL,
  `discription` NVARCHAR(2000) NULL,
  `quantity` INT NOT NULL,
  `active` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`));
  
  CREATE TABLE `bookstore`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`));
  
  CREATE TABLE `bookstore`.`cartitem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `idProduct` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` INT NOT NULL,
    PRIMARY KEY(`id`)
  -- PRIMARY KEY (`idUser`, `idProduct`)
  );

CREATE TABLE `bookstore`.`delivery` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(100) NOT NULL,
  `shipFee` INT NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `bookstore`.`paymethod` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` NVARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`));
  
  CREATE TABLE `bookstore`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idUser` INT NOT NULL,
  `idSeller` INT NOT NULL,
  `createTime` DATE NOT NULL,
  `phone` VARCHAR(10) NOT NULL,
  `address` NVARCHAR(100) NOT NULL,
  `contactName` NVARCHAR(50) NOT NULL,
  `receiveDate` DATE NOT NULL,
  `idMethod` INT NOT NULL,
  `idDelivery` INT NOT NULL,
  `totalPay` INT NOT NULL,
  `status` INT NOT NULL,
  PRIMARY KEY (`id`));

CREATE TABLE `bookstore`.`orderitem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idOrder` INT NOT NULL,
  `idProduct` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY(`id`)
--   PRIMARY KEY (`idOrder`, `idProduct`)
  );

-- Thêm Khóa ngoại cho bảng Order
ALTER TABLE `bookstore`.`order` 
ADD INDEX `fk_OrderDelivery_idx` (`idDelivery` ASC) VISIBLE,
ADD INDEX `fk_OrderMethod_idx` (`idMethod` ASC) VISIBLE,
ADD INDEX `fk_OrderUser_idx` (`idUser` ASC) VISIBLE;
;
ALTER TABLE `bookstore`.`order` 
ADD CONSTRAINT `fk_OrderDelivery`
  FOREIGN KEY (`idDelivery`)
  REFERENCES `bookstore`.`delivery` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_OrderMethod`
  FOREIGN KEY (`idMethod`)
  REFERENCES `bookstore`.`paymethod` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_OrderUser`
  FOREIGN KEY (`idUser`)
  REFERENCES `bookstore`.`user` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
-- Thêm Khóa ngoại cho bảng OrderItem
ALTER TABLE `bookstore`.`orderitem` 
ADD INDEX `fk_OrderItem-Product_idx` (`idProduct` ASC) VISIBLE;
;
ALTER TABLE `bookstore`.`orderitem` 
ADD CONSTRAINT `fk_OrderItem-Order`
  FOREIGN KEY (`idOrder`)
  REFERENCES `bookstore`.`order` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_OrderItem-Product`
  FOREIGN KEY (`idProduct`)
  REFERENCES `bookstore`.`product` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- Thêm Khóa ngoại cho bảng Product
ALTER TABLE `bookstore`.`product` 
ADD INDEX `idCategory_idx` (`idCategory` ASC) VISIBLE;
;
ALTER TABLE `bookstore`.`product` 
ADD CONSTRAINT `idCategory`
  FOREIGN KEY (`idCategory`)
  REFERENCES `bookstore`.`category` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- Thêm Khóa ngoại cho bảng CartItem
ALTER TABLE `bookstore`.`cartitem` 
ADD INDEX `fk_CartItem-Product_idx` (`idProduct` ASC) VISIBLE;
;
ALTER TABLE `bookstore`.`cartitem` 
ADD CONSTRAINT `fk_CartItem-User`
  FOREIGN KEY (`idUser`)
  REFERENCES `bookstore`.`user` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_CartItem-Product`
  FOREIGN KEY (`idProduct`)
  REFERENCES `bookstore`.`product` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;


ALTER TABLE `bookstore`.`product` 
DROP COLUMN `Productcol`;

ALTER TABLE `bookstore`.`product` 
DROP FOREIGN KEY `idCategory`;
ALTER TABLE `bookstore`.`product` 
ADD CONSTRAINT `idCategory`
  FOREIGN KEY (`idCategory`)
  REFERENCES `bookstore`.`category` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
  
ALTER TABLE `bookstore`.`product` 
DROP FOREIGN KEY `idCategory`;
ALTER TABLE `bookstore`.`product` 
CHANGE COLUMN `idCategory` `idCategory` INT NOT NULL ;
ALTER TABLE `bookstore`.`product` 
ADD CONSTRAINT `idCategory`
  FOREIGN KEY (`idCategory`)
  REFERENCES `bookstore`.`category` (`id`);
  
ALTER TABLE `bookstore`.`product` 
CHANGE COLUMN `active` `active` BIT(1) NOT NULL DEFAULT b'1' ;

ALTER TABLE `bookstore`.`user` 
CHANGE COLUMN `active` `active` BIT(1) NOT NULL DEFAULT b'1' ;

ALTER TABLE bookstore.`order` 
CHANGE COLUMN idSeller
idSeller INT NULL ,
CHANGE COLUMN createTime
createTime DATE NULL ,
CHANGE COLUMN receiveDate
receiveDate DATE NULL ,
CHANGE COLUMN status
status INT NOT NULL DEFAULT 1 ;

INSERT INTO `bookstore`.`category` (`id`, `name`) VALUES ('1', 'Tư duy - kỹ năng sống');
INSERT INTO `bookstore`.`category` (`id`, `name`) VALUES ('2', 'Kiến thức - Bách khoa');
INSERT INTO `bookstore`.`category` (`id`, `name`) VALUES ('3', 'Tiểu thuyết');

INSERT INTO `bookstore`.`product` (`id`, `idCategory`, `name`, `image`, `originalPrice`, `salePrice`, `discription`, `quantity`, `active`) VALUES ('1', '1', 'Tâm Lý Học Hành Vi', 'https://salt.tikicdn.com/cache/w1200/ts/product/cd/72/24/a9f929f98397d1be047e47602989a5e0.jpg', '67500', '81500', 'Tâm Lý Học Hành Vi.Cuốn sách giúp bạn thấu hiểu bản thân mình và tâm lý những người xung quanh!Được chấp bút bởi bậc thầy tâm lý hàng đầu Trung Quốc Khương Nguy.', '50', 1);
INSERT INTO `bookstore`.`product` (`id`, `idCategory`, `name`, `image`, `originalPrice`, `salePrice`, `discription`, `quantity`, `active`) VALUES ('2', '1', 'Người trong muôn nghề', 'https://salt.tikicdn.com/cache/w1200/ts/product/07/3e/ae/26cc99e58483d0030de5e8dc777e3d81.jpg', '155000', '169000', 'Chọn nghề là giúp mình tìm được điểm giao thoa giữa năng lực, sở thích cá nhân với nhu cầu của xã hội.Người Trong Muôn Nghề hi vọng có thể kéo bạn lại gần hơn với mục đích bản chất ấy. Cuốn sách là tuyển tập những câu chuyện đi làm tâm huyết đến từ những cây viết dày dặn kinh nghiệm trong các lĩnh vực chuyên môn và những môi trường làm việc khác nhau. Những chia sẻ này sẽ giúp các bạn học sinh, sinh viên có một cái nhìn toàn diện hơn về thế giới công việc thực thụ', '100', 1);
INSERT INTO `bookstore`.`product` (`id`, `idCategory`, `name`, `image`, `originalPrice`, `salePrice`, `discription`, `quantity`, `active`) VALUES ('3', '2', 'Luật Tâm Thức - Giải Mã Ma Trận Vũ Trụ', 'https://salt.tikicdn.com/cache/w1200/ts/product/4f/b0/bf/dbff1a3a306b9adc591620553ce99a9d.jpg', '220000', '227000', 'Cuốn sách này sẽ giúp bạn thấy rằng những kiến thức của người xưa không hề cao siêu huyền bí mà vô cùng đơn giản và liên quan chặt chẽ tới khoa học hiện đại.Việc của bạn chỉ là đọc với một tâm trí cởi mở để thức tỉnh, vượt qua những rào cản của tâm trí, những niềm tin cố hữu của mình', '150', b'1');
INSERT INTO `bookstore`.`product` (`id`, `idCategory`, `name`, `image`, `originalPrice`, `salePrice`, `discription`, `quantity`, `active`) VALUES ('4', '2', 'Nhập môn Triết học', 'https://salt.tikicdn.com/cache/w1200/ts/product/31/1f/d7/fbf6adcd3880d84b851c02e4b2324f8a.png', '90000', '97500', 'NHẬP MÔN TRIẾT HỌC QUA 101 C U ĐỐ KINH ĐIỂN, ấn bản thứ tư của Martin Cohen giới thiệu triết học theo cách giải trí nhưng bổ ích và kích thích tư duy. Sử dụng các câu đố hóc búa và nghịch lý, ông đã khéo léo mở ra một số bí ẩn của chủ đề này, từ những gì chúng ta biết – hoặc nghĩ rằng chúng ta biết – cho đến những thí nghiệm tư duy “xoắn não” về đạo đức, khoa học và bản chất của tâm trí', '98', 1);
INSERT INTO `bookstore`.`product` (`id`, `idCategory`, `name`, `image`, `originalPrice`, `salePrice`, `discription`, `quantity`, `active`) VALUES ('5', '3', 'Mặt Nạ - Tiểu Thuyết', 'https://salt.tikicdn.com/cache/w1200/ts/product/79/cb/7f/219f98e7f609290fd8a513fa25c41b17.jpg', '70000', '77500', 'Họ có thực sự hạnh phúc với hình tượng mình gây dựng bao lâu nay trong mắt mọi người? Mỗi buổi sáng thức dậy, đứng trước gương họ thầm nhủ hôm nay mình sẽ diễn vai gì? Một cô gái cá tính hay thục nữ yêu kiều? Một chàng trai phong trần hay quân tử hảo hán? Mọi hỷ - nộ - ái - ố trong lòng, bạn có thực sự muốn chia sẻ với người khác?', '80', 1);
INSERT INTO `bookstore`.`user` (`name`, `address`, `email`, `phone`, `password`,`isRole`, `active`) 
	VALUES ('Ngọc Anh', 'Đống Đa, Hà Nội', 'ngocanh@gmail.com', '0365894523', '0235256124','3', default);
    
INSERT INTO `bookstore`.`user` (`name`, `address`, `email`, `phone`, `password`,`isRole`, `active`) 
	VALUES ('Võ Lâm', 'Đà Nẵng', 'lamvo@gmail.com', '0875325142', '12345678','2', default);
    
INSERT INTO `bookstore`.`user` (`name`, `address`, `email`, `phone`, `password`,`isRole`, `active`) 
VALUES ('Trúc Anh', 'TP.HCM', 'trucanh@gmail.com', '0321525478', '12345678','1', default);


