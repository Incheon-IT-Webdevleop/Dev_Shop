
//월별 매출 목록 조회 API
const getOderByMonth= () => {
    console.log("get oeder by month");

    fetch(`/api/admin/order/getOderByMonth.do`)
        .then(response => response.json())
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.log(error)
        })

}

// 1:1 문의사항 전체목록 조회API
const findAllInquery = () => {
    console.log("find all inquery");

    fetch(`/api/admin/inquery/findAll.do`)
        .then(response => response.json())
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.log(error)
        })

}

// 리뷰 전체목록 조회 API
// 1:1 문의사항 전체목록 조회API
const findAllReview = () => {
    console.log("find all review");

    fetch(`/api/admin/review/findAll.do`)
        .then(response => response.json())
        .then(data => {
            console.log(data);
        })
        .catch(error => {
            console.log(error)
        })

}

getOderByMonth();
findAllInquery();
findAllReview();