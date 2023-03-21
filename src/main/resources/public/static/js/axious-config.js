const configAxious = function (axios) {
    // 创建一个axios实例
    // const axios_instance = axios.create();


    var axios_instance = axios.create({
        timeout: 60000,
        withCredentials: false
    });

    // 请求拦截器
    axios_instance.interceptors.request.use(function (config) {
        // 在发送请求之前可以做一些事情
        config.headers.token = 'token';   // 在headers中携带token
        return config
    }, function (error) {
        // 处理请求错误
        return Promise.reject(error)
    });



    // 设置axios拦截器：请求拦截器
    // axios_instance.interceptors.request.use(config => {
    //     //请求拦截一般会有哪些操作
    //     // 1.比如config中的一些信息不符合服务器的要求,这里可以做一些修改
    //     // 2.比如每次发送网络请求时,都希望在界面中显示一个请求的图标(然后再响应拦截中取消显示)
    //     // 3.某些网络请求必须携带一些特殊的信息(如登录token),如果没有携带就可以拦截并作响应提示
    //
    //     // 给请求头添加token
    //     /*
    //     * 其中   /.*csrftoken=([^;.]*).*$/    是一个正则表达式，用于从cookie中获取csrftoken的值 ，
    //     * ([^;.]*) 是命名捕获，表示从匹配到的内容中 只获得 ()内的值。
    //     * string.match(regex) 得到的是一个数组， 第0项是匹配到的全部内容，第1项是通过命名捕获得到的内容，在这里就是csrftoken的值。
    //     * 这样就完成了使用axios发送请求的正确配置了，同时保证了网站免受csrf攻击的影响.
    //     */
    //     config.headers['X-Requested-With'] = 'XMLHttpRequest';
    //     let regex = /.*csrftoken=([^;.]*).*$/; // 用于从cookie中匹配 csrftoken值
    //     config.headers['X-CSRFToken'] = document.cookie.match(regex) === null ? null : document.cookie.match(regex)[1];
    //
    //     return config
    // }, err => {
    //     // 请求未成功发出，如：没有网络...
    //     return Promise.reject(err)
    // })
    //
    //
    // // 设置axios拦截器: 响应拦截器
    // axios_instance.interceptors.response.use(res => {
    //     // 成功响应的拦截
    //     return Promise.resolve(res.data)
    // }, err => {
    //     // 失败响应的拦截
    //     console.log(err)
    //     if (err.response) {
    //         // 失败响应的status需要在response中获得
    //         console.log(err.response)
    //         switch (err.response.status) {
    //             // 对得到的状态码的处理，具体的设置视自己的情况而定
    //             case 401:
    //                 console.log('未登录')
    //                 window.location.href = '/'
    //                 break
    //             case 404:
    //                 window.location.href = '/'
    //                 break
    //             case 405:
    //                 console.log('不支持的方法')
    //                 break
    //             // case ...
    //             default:
    //                 console.log('其他错误')
    //                 break
    //         }
    //     }
    //
    //     // 注意这里应该return promise.reject(),
    //     // 因为如果直接return err则在调用此实例时，响应失败了也会进入then(res=>{})而不是reject或catch方法
    //     return Promise.reject(err)
    // });


    return axios_instance;
}







const initAxios = () => {
  // 配置axios实例
  const axios = configAxious(window.axios);
  window.axios = axios;
}



const initVue = (config = {}) => {
     // 使用全局方法，解决Vue2.0 不再支持在 v-html 中使用过滤器，比如在 1.0 中是这样使用的：{{{ option.title | highlight }}}
     Vue.prototype.fileHref = function (fileItem) {
        // let href = downloadFile(fileItem.name);

        // return item.type === 'directory' ? '目录' : '文件';
        return fileItem.type === 'directory' ? '目录' : `<a href="${config.downloadFile(fileItem.name)}" target="_blank">${fileItem.name}</a>`;
    };
}


export {
    // configAxious,
    initAxios,
    initVue,
}