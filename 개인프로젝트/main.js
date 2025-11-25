const express = require("express");
const db = require("./db.js");
const cors = require("cors");
const path = require("path");

const app = express(); // 웹서버기능(인스턴스).
const port = 3000;

app.use(cors()); // cors 원칙.
app.use(express.json()); // body-parser json 처리.
app.use(express.urlencoded()); // key=val&key=val&.....

// public 폴더 내의 파일들을 / 경로를 통해 접근 가능하게 합니다.(설정추가 11월20일)
app.use(express.static(path.join(__dirname, "public")));

// url : 실행함수 = 라우팅.
app.get("/users", (req, res) => {
  res.send("/호출됨.");
});

/*// board 목록 조회.
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
});*/

// // board 단건 조회.
// app.get("/board/:id", async (req, res) => {
//   console.log(req.params.id); // :id가 파라미터
//   const searchId = req.params.id;
//   let connection;
//   try {
//     connection = await db.getConnection();
//     let result = await connection.execute(
//       `select * from board where board_id = ${searchId}`
//     );
//     console.log(result.rows);
//     //res.send("조회완료");
//     res.json(result.rows); // 웹 화면 보여짐
//   } catch (err) {
//     console.log(err);
//     res.send("예외발생");
//   } finally {
//     if (connection) {
//       await connection.close();
//     }
//   }
// });

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
// 중복체크
app.post("/boards", async (req, res) => {
  console.log(req.body); // :id가 파라미터
  const { id } = req.body;

  console.log(id);
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `SELECT id FROM users where id = :id`,
      [id]
    );
    connection.commit(); // 커밋.
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

// 회원가입
app.post("/boardd", async (req, res) => {
  console.log(req.body); // :id가 파라미터
  const { id, pw, name, address } = req.body;

  console.log(id, pw, name, address);
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `insert into users(id, pw, name, address)
       values (:id, :pw, :name, :address)`,
      [id, pw, name, address],
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

// login
app.post("/loging", async (req, res) => {
  console.log(req.body); // :id가 파라미터
  const { id, pw } = req.body;

  console.log(id, pw);
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `SELECT id, pw FROM users where id = :id and pw = :pw`,
      [id, pw]
    );
    connection.commit(); // 커밋.
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

// 글작성
app.post("/write", async (req, res) => {
  console.log(req.body); // :id가 파라미터
  const { title, author, categories, variety, gender, age, content } = req.body;

  console.log(title, author, categories, variety, gender, age, content);
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `insert into board (title, author, categories, variety, gender, age, content, idx)
       values (:title, :author, :categories, :variety, :gender, :age, :content, (select max(idx) +1 from board))`,
      [title, author, categories, variety, gender, age, content],
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

app.get("/count", async (req, res) => {
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `SELECT idx
FROM BOARD`
    );
    console.log(result.rows);
    //res.send("조회완료"); // txt, html....
    res.json(result.rows); // json 문자열로 응답.
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    // 정상실행/ 예외발생
    if (connection) {
      await connection.close();
    }
  }
});

// 게시판 목록
app.get("/paging/:values", async (req, res) => {
  let { values } = req.params;
  console.log(values);
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `SELECT rownum rn, a.title, a.author, a.dday, a.categories, a.idx
       FROM (SELECT idx, title, author, dday, categories
       FROM board
       WHERE categories = :category OR '전체' = :category 
       ORDER BY IDX)a`,
      [values, values]
    );
    console.log(result.rows);
    //res.send("조회완료"); // txt, html....
    res.json(result.rows); // json 문자열로 응답.
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    // 정상실행/ 예외발생
    if (connection) {
      await connection.close();
    }
  }
});

// 게시판 상세페이지
app.get("/boardpage/:data", async (req, res) => {
  let { data } = req.params;
  console.log(data);
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `SELECT title, author, dday, categories, variety, gender, age, content, idx
       FROM board
      WHERE idx = :idx`,
      [data]
    );
    console.log(result.rows);
    //res.send("조회완료"); // txt, html....
    res.json(result.rows); // json 문자열로 응답.
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    // 정상실행/ 예외발생
    if (connection) {
      await connection.close();
    }
  }
});

// 게시판 삭제
app.post("/boardDelete", async (req, res) => {
  let connection;
  const { idx } = req.body;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `DELETE FROM BOARD
       WHERE idx = :idx`,
      [idx],
      { autoCommit: true }
    );
    console.log(result);
    //res.send("조회완료"); // txt, html....
    res.json(result); // json 문자열로 응답.
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    // 정상실행/ 예외발생
    if (connection) {
      await connection.close();
    }
  }
});

// 페이징
app.get("/paging/:values/:page", async (req, res) => {
  let { values, page } = req.params;
  console.log(page);
  let connection;
  try {
    connection = await db.getConnection();
    let result = await connection.execute(
      `SELECT b.*
       FROM (SELECT rownum rn, a.title, a.author, a.dday, a.categories,a.idx
             FROM (SELECT idx, title, author, dday, categories
                   FROM board
                   WHERE categories = :category OR '전체' = :category
                   ORDER BY idx) a ) b
       WHERE b.rn > (:page - 1) * 10
       AND   b.rn <= (:page * 10)`,
      [values, values, page, page]
    );
    console.log(result.rows);
    //res.send("조회완료"); // txt, html....
    res.json(result.rows); // json 문자열로 응답.
  } catch (err) {
    console.log(err);
    res.send("예외발생");
  } finally {
    // 정상실행/ 예외발생
    if (connection) {
      await connection.close();
    }
  }
});

// // 수정
// app.put("/", async (req, res) => {
//   console.log(req.body); // :id가 파라미터
//   const { title, content, author, id } = req.body;

//   console.log(title, content, author, id);
//   let connection;
//   try {
//     connection = await db.getConnection();
//     let result = await connection.execute(
//       `update board
//        set       title = :title,
//                  content = :content,
//                  author = :author
//        where board_id = :id`,
//       [title, content, author, id],
//       { autoCommit: true } // 자동커밋
//     );
//     //connection.commit(); // 커밋.
//     console.log(result);
//     // res.send("조회완료");
//     res.json(result); // 웹 화면 보여짐
//   } catch (err) {
//     console.log(err);
//     res.send("예외발생");
//   } finally {
//     if (connection) {
//       await connection.close();
//     }
//   }
// });

app.listen(port, () => {
  console.log(`Express 서버가 실행중....http://localhost:${port}`);
});
