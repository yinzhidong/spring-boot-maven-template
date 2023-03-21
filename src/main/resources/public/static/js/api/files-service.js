const baseURL = "http://localhost:8080";


const parseURL = (uri) => {
    return `${baseURL}${uri}`;
}


const getFileList = async (dirName) => {
    let response = await axios.get(parseURL('/api/files/list'), {
        params: {
            path: dirName
        }
    });
    // console.log('getFileList response==', response);

    return response.data;
}


const downloadFile = (filename) => {
    let url = parseURL('/api/files/download');
    return `${url}/${filename}`;

    // window.open(`${url}/filename`, "_blank", "resizable,scrollbars,status");
    // window.open(`${url}/filename`, "_blank");
}


const editPath = async (path) => {
    let url = parseURL('/api/files/editPath');
    
    let response = await axios.get(url, {
        params: {
            path
        }
    });
    console.log('editPath response==', response);
    return response.data;
}


export {
    getFileList,
    downloadFile,
    editPath,
}