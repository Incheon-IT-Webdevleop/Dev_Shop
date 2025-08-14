// 매입 목록 페이지
console.log('purchaseList.js load')

const selectAll = () => {
    console.log("purchase selectAll")
    
    fetch(`/api/purchase/selectAll.do`)
        .then(response => response.json())
        .then(data => {
            console.log(data)
        })
        .catch(error => {
            console.log(error);
        })
}

selectAll();