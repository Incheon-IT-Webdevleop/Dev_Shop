const ctx = document.getElementById('myChart');

<<<<<<< HEAD
let mainChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['2025-02', '2025-03', '2025-04', '2025-05', '2025-06', '2025-07'],
      datasets: [{
        label: '주문량',
        data: [12, 19, 3, 5, 2, 3],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        y: {
          beginAtZero: true
        }
      }
    }
  });
=======
new Chart(ctx, {
	type: 'bar',
	data: {
		labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
		datasets: [{
			label: '# of Votes',
			data: [12, 19, 3, 5, 2, 3],
			borderWidth: 1
		}]
	},
	options: {
		scales: {
			y: {
				beginAtZero: true
			}
		}
	}
});
>>>>>>> main

console.log('mainView.js load')



//월별 매출 목록 조회 API
const getOderByMonth= () => {
    console.log("get oeder by month");

    fetch(`/api/admin/order/getOderByMonth.do`)
        .then(response => response.json())
        .then(data => {
            console.log(data);

            // 테이블 렌더링
            renderOrderTable(data);

            // 차트 업데이트
            updateChart(data);
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


// 최신 주문 현황 테이블
const renderOrderTable = (data) => {
  console.log('render oder table')
  const tableBody = document.querySelector('.oderStatusTable tbody');

  tableBody.innerHTML = '';

  // 데이터 없을 때 렌더랑
  if(!data || data.length === 0){ 
    tableBody.innerHTML = `
      <tr>
        <td colspan="2" class="text-center text-muted">
          조회된 데이터가 없습니다.
        </td>
      </tr>
    `;
    return;
  }

  // 데이터 렌더링
  data.forEach(item => {
    const row = document.createElement('tr');
    row.innerHTML = `
      <th scope="row">${item.yearMonth || '-'}</th>
      <td>
        <div>주문량 : ${formatNumber(item.monthlyOrderCount || 0)}건</div>
        <div class="text-success">금액 : ${formatNumber(item.monthlyTotalAmount || 0)}원</div>
      </td>
    `;
    tableBody.appendChild(row);
  });
}

// 주문현황 차트 업데이트
const updateChart = (data) => {
  console.log('update chart')

  // 데이터 없을 때
  if(!data || data.length === 0) return;

  const labels = data.map(item => item.yearMonth);
  const orderCounts = data.map(item =>item.monthlyOrderCount || 0);

  mainChart.data.labels = labels;
  mainChart.data.datasets[0].data = orderCounts;
  mainChart.update();
}


// 천단위 콤마 formatter
const formatNumber = (number) => {
  return new Intl.NumberFormat('ko-KR').format(number);
}

// datetime formatter 
const formatDateTime = (dateTimeString) => {
   if (!dateTimeString) return '-';
   
   const date = new Date(dateTimeString);
   
   const year = date.getFullYear();
   const month = String(date.getMonth() + 1).padStart(2, '0');
   const day = String(date.getDate()).padStart(2, '0');
   const hours = String(date.getHours()).padStart(2, '0');
   const minutes = String(date.getMinutes()).padStart(2, '0');
   
   return `${year}/${month}/${day} ${hours}:${minutes}`;
}


getOderByMonth();
findAllInquery();
findAllReview();

