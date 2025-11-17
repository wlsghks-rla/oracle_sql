const express = require("express");
const db = require("./db.js");
const cors = require("cors");

const app = express(); // 웹서버기능(인스턴스).
const port = 3000;

app.use(cors()); // cors 원칙.
app.use(express.json()); // body-parser json 처리.
//app.use(express.urlencoded()); // key=val&key=val&.....

// url : 실행함수 = 라우팅.
app.get("/", (req, res) => {
  res.send("/호출됨.");
});

// board 목록 조회.
app.get("/boards", async (req, res) => {
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(`select * from board order by 1`);
    console.log(result.rows);
    //res.send("조회완료");
    res.json(result.rows); // 웹 화면 보여짐
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    if (connection) {
      await connection.close();
    }
  }
});

// board 단건 조회.
app.get("/board/:id", async (req, res) => {
  console.log(req.params.id); // :id가 파라미터
  const searchId = req.params.id;
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `select * from board where board_id = ${searchId}`
    );
    console.log(result.rows);
    //res.send("조회완료");
    res.json(result.rows); // 웹 화면 보여짐
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    if (connection) {
      await connection.close();
    }
  }
});

// 글 등록
/*app.get("/board/:title/:content/:author", async (req, res) => {
  console.log(req.params); // :id가 파라미터
  const { title, content, author } = req.params; // 객체 구조분해.
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `insert into board(board_id, title, content, author)
       values ((select max(board_id) +1 from board) , :title, :content, :author)`,
      [title, content, author],
      { autoCommit: true } // 자동커밋
    );
    //connection.commit(); // 커밋.
    console.log(result);
    //res.send("조회완료");
    res.json(result); // 웹 화면 보여짐
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    if (connection) {
      await connection.close();
    }
  }
});*/

app.post("/board", async (req, res) => {
  console.log(req.body); // :id가 파라미터
  const { title, content, author } = req.body;

  console.log(title, content, author);
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `insert into board(board_id, title, content, author)
       values ((select max(board_id) +1 from board) , :title, :content, :author)`,
      [title, content, author],
      { autoCommit: true } // 자동커밋
    );
    //connection.commit(); // 커밋.
    console.log(result);
    //res.send("조회완료");
    res.json(result); // 웹 화면 보여짐
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    if (connection) {
      await connection.close();
    }
  }
});

// 수정
app.listen(port, () => {
  console.log(`Express 서버가 실행중....http://localhost:${port}`);
});
