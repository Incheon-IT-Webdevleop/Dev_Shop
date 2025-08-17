// 매입 목록 페이지
console.log('purchaseList.js load')

const selectAll = () => {
    console.log("purchase selectAll")
    
    fetch(`/api/purchase/selectAll.do`)
        .then(response => response.json())
        .then(data => {
            console.log(data)
            
            // 조회테이블 렌더링
            renderPurchaseTable(data);
        })
        .catch(error => {
            console.log(error);
        })
}

// 매입 전체목록 테이블 렌더링
const renderPurchaseTable = (data) => {
    console.log("rander purchase table");
    
    const tableBody = document.querySelector('.purchaseListTable tbody');;

    tableBody.innerHTML = '';

    // 데이터 없을 때 렌더랑
    if(!data || data.length === 0){ 
        tableBody.innerHTML = `
        <tr>
            <td colspan="2" class="text-center text-muted">
            조회된 매입 데이터가 없습니다.
            </td>
        </tr>
        `;
        return;
    }

    // 데이터 렌더링
    data.list.forEach(item => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <th scope="row">${item.purchaseIdx}</th>
            <td>${formatDateTime(item.purchaseDate)}</td>
            <td>${item.productIdx}</td>
            <td>${formatNumber(item.quantity || 0)}건</td>
            <td>${formatNumber(item.productCost || 0)}원</td>
            <td>${item.status ? "매입 확정" : "입시저장"}</td>
        `
        tableBody.appendChild(row);
    });
}



selectAll();