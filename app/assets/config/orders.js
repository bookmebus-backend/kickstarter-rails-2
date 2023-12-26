document.addEventListener('DOMContentLoaded', function () {
    const statusCells = document.querySelectorAll('.editable-status');
  
    statusCells.forEach((cell) => {
      const orderId = cell.dataset.orderId;
      const displayDiv = cell.querySelector('.status-display');
      const editDiv = cell.querySelector('.status-edit');
  
      displayDiv.addEventListener('click', () => {
        displayDiv.style.display = 'none';
        editDiv.style.display = 'block';
      });
  
      document.addEventListener('click', (event) => {
        if (!cell.contains(event.target)) {
          displayDiv.style.display = 'block';
          editDiv.style.display = 'none';
        }
      });
    });
  });
  