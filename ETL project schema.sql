

CREATE TABLE cavideos (
  ID VARCHAR (50) PRIMARY KEY,
  TrendingDate varchar(50),
  Title VARCHAR (100),
  CategoryID INT,
  PublishedDate varchar(50),
  Views INT,
  Likes INT,
  Dislikes INT,
  CommentCount INT
);


CREATE TABLE gbvideos (
  ID VARCHAR (50) PRIMARY KEY,
  TrendingDate varchar(50),
  Title VARCHAR (100),
  CategoryID INT,
  PublishedDate varchar(50),
  Views INT,
  Likes INT,
  Dislikes INT,
  CommentCount INT
);


CREATE TABLE usvideos (
  ID VARCHAR (50) PRIMARY KEY,
  TrendingDate varchar(50),
  Title VARCHAR (100),
  CategoryID INT,
  PublishedDate varchar(50),
  Views INT,
  Likes INT,
  Dislikes INT,
  CommentCount INT
);