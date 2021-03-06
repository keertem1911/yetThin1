<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/css/bootstrap.min.css">
	<style>
		body {
			background-color: #ffffff;
		}
		tr {
			text-align: center;
		}
		th{
			text-align: center;

		}
		.red {
			background-color: 
		}
		#mune1 {
			position: absolute;
			display: none;
			border: 1px solid #123475;
		}
		#mune1 ul {
			padding: 0;
			margin: 0;
			background-color: #fff;
		}
		#mune1 li {
			list-style: none;
			padding: 10px 40px;
			cursor: pointer;
			border-bottom: 1px solid #999;
		}
		#mune1 li:hover {
			background-color: #ccc;
		}
		#mune2 {
			position: absolute;
			display: none;
			border: 1px solid #123475;
		}
		#mune2 ul {
			padding: 0;
			margin: 0;
			background-color: #fff;
		}
		#mune2 li {
			list-style: none;
			padding: 10px 40px;
			cursor: pointer;
			border-bottom: 1px solid #999;
		}
		#mune2 li:hover {
			background-color: #ccc;
		}
	</style>
</head>
<body>
	<div class="one" v-on:click.stop=hideMenu>
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-8 col-xs-12">
					<div class="row">
						<div class="col-xs-12">
							<h3>持仓信息</h3>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-12" v-on:contextmenu.prevent="menu(true)">
							<table class="table table-hover table-bordered">
								<thead>
									<tr align="center">
										<th>用户名</th>
										<th>股票代码</th>
										<th>持仓</th>
										<th>市值</th>
										<th>市价</th>
										<th>未实现盈亏</th>
										<th>已实现盈亏</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="item in one" v-bind:class="{ 'danger ' :item.chicang*item.shijia + item.yishixian < 0 } " data-mark = '{{ $index }}'>
										<td>{{ item.name }}</td>
										<td>{{ item.code }}</td>	
										<td>{{ item.chicang }}</td>	
										<td>{{ item.chicang * item.shijia | xiaoshu }}</td>	
										<td>{{ item.shijia | xiaoshu  }}</td>	
										<td>{{ item.chicang*item.shijia + item.yishixian | xiaoshu }}</td>	
										<td>{{ item.yishixian }}</td>	
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="col-md-4 col-xs-12">
					<div class="row">
						<div class="col-xs-12">
							<h3>汇总信息</h3>
						</div>
					</div>
					<div class="row">
						<dir class="col-xs-12">
							<table class="table table-hover table-bordered">
								<thead>
									<tr>
										<th>用户名</th>
										<th>总未实现盈亏</th>
										<th>总已实现盈亏</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="item in two" v-bind:class="{ 'danger ' :item.weishixian < 0 } ">
										<td>{{ item.name }}</td>
										<td>{{ item.weishixian | xiaoshu }}</td>
										<td>{{ item.yishixian | xiaoshu }}</td>
									</tr>
								</tbody>
							</table>
						</dir>
					</div>
				</div>
				<div class="col-md-12 col-xs-12">
					<div class="row">
						<div class="col-xs-12">
							<h3>用户订单信息</h3>
						</div>
					</div>
					<div class="row" style="height:400px;overflow: auto">
						<div class="col-xs-12"  v-on:contextmenu.prevent="menu(false)">
							<table class="table table-hover table-bordered">
								<thead>
									<tr>
										<th></th>
										<th>用户名</th>
										<th>用户编号</th>
										<th>股票代码</th>
										<th>订单编号</th>
										<th>订单状态</th>
										<th>价格</th>
										<th>交易总量</th>
										<th>交易方向</th>
										<th>平均成交价</th>
									</tr>
								</thead>
								<tbody>
									<tr v-for="(index, item) in three" v-bind:class="{ 
										'text-success' :item.state == 1 , 
										'text-info ' :item.state == 2 ,
										'text-danger ' :item.state == 3 ,
										'text-default ' :item.state == 4 ,
									}"  data-mark2 = '{{ index }}'>
										<td>{{index+1}}</td>
										<td>{{item.name}}</td>
										<td>{{item.nameNum}}</td>
										<td>{{item.code}}</td>
										<td>{{item.orderCode}}</td>
										<td>{{item.state | state}}</td>
										<td>{{item.char}}</td>
										<td>{{item.tradeNum}}</td>
										<td>{{item.tradeDirect | buy}}</td>
										<td>{{item.charQue}}</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<div id="mune1" v-bind:style="styleObject">
		<ul>
			<li v-on:click="jinggao">警告</li>
			<li v-on:click="pingcang">平仓</li>
		</ul>
	</div>

	<div id="mune2" v-bind:style="sObject">
		<ul>
			<li v-on:click="chedan">撤单</li>
		</ul>
	</div>

	<!-- <script src="js/jquery-1.11.3.js"></script>
	<script src="js/bootstrap.min.js"></script> -->
	<script src="${pageContext.request.contextPath }/js/vue.js"></script>
	<script>

		Vue.filter('xiaoshu', function (value) {
			// console.log(value);
			return parseFloat(value).toFixed(2);
		})
		Vue.filter('state', function (value) {
			if(value == 1){
				return 'filled'
			} else if(value == 2){
				return 'submited'
			} else if(value == 3){
				return 'canceled'
			} else if(value == 4){
				return 'rejected'
			}
		})
		Vue.filter('buy', function (value) {
			if(value == 1){
				return 'BUY'
			} else if(value == 2){
				return 'SELL'
			}
		})
		new Vue({
			el: 'body',
			ready: function(){
				var _this = this;
				setInterval(function(){
					_this.traded();
				}, 3000);
			},
			data: {
				one: [
					{
						name: 'tp7',
						code: 430719,
						chicang: -1443300,
						shijia: 7.96,
						yishixian: 11434.57
					},
					{
						name: 'tp6',
						code: 430719,
						chicang: 56800,
						shijia: 8.17,
						yishixian: -21086.81
					},
					{
						name: 'tp5',
						code: 430719,
						chicang: 1493500,
						shijia: 8.13,
						yishixian: 14795.75
					},
					{
						name: 'tp4',
						code: 430719,
						chicang: -10000,
						shijia: 8.12,
						yishixian: 3320.00
					},
					{
						name: 'tp4',
						code: 830899,
						chicang: 69100,
						shijia: 0,
						yishixian: 2938080.98
					},
					{
						name: 'tp3',
						code: 430719,
						chicang: -717800,
						shijia: 8.12,
						yishixian: 14166463.64
					},
					{
						name: 'tp3',
						code: 830899,
						chicang: -97000,
						shijia: 0,
						yishixian: 1661892.41
					},
					{
						name: 'tp2',
						code: 430719,
						chicang: -10700,
						shijia: 8.12,
						yishixian: 2716524.32
					},
					{
						name: 'tp2',
						code: 830899,
						chicang: 106900,
						shijia: 12,
						yishixian: -83768.32
					},
					{
						name: 'tp1',
						code: 430719,
						chicang: 34300,
						shijia: 8.13,
						yishixian: -3775162.78
					},
					{
						name: 'tp1',
						code: 830899,
						chicang: 69600,
						shijia: 0,
						yishixian: -611.57
					}
				],
				three: [
					{
						name: 'tp2',
						nameNum: 3,
						code: 430719,
						orderCode: 112437,
						state: 1,
						char: 10.02,
						tradeNum: 1000,
						tradeDirect: 1,
						charQue:　10.02
					},
					{
						name: 'tp2',
						nameNum: 3,
						code: 430719,
						orderCode: 112436,
						state: 2,
						char: 10.01,
						tradeNum: 1000,
						tradeDirect: 2,
						charQue:　10.01
					},
					{
						name: 'tp2',
						nameNum: 3,
						code: 430719,
						orderCode: 112435,
						state: 4,
						char: 10.00,
						tradeNum: 1000,
						tradeDirect: 2,
						charQue:　10.01
					},
					{
						name: 'tp2',
						nameNum: 3,
						code: 430719,
						orderCode: 112434,
						state: 3,
						char: 9.99,
						tradeNum: 3000,
						tradeDirect: 2,
						charQue:　10.01
					}
				],
				styleObject: {},
				sObject: {},
				mark: null,
				mark2: null
			},
			computed: {
				two: function(){
					var arr = [];
					for(var i = 0; i < this.one.length-1; i++){
						var casual = {};
						if( i < 4 ){
							casual.name = this.one[i].name,
							casual.yishixian = this.one[i].yishixian;
							casual.weishixian = (this.one[i].chicang * this.one[i].shijia + this.one[i].yishixian).toFixed(2);
							arr.push(casual);
						} else if(i == 4 || i == 6 || i == 8) {
							casual.name = this.one[i].name,
							casual.yishixian = this.one[i].yishixian + this.one[i+1].yishixian;
							casual.weishixian = (this.one[i].chicang * this.one[i].shijia + this.one[i].yishixian).toFixed(2)+
												(this.one[i+1].chicang * this.one[i+1].shijia + this.one[i+1].yishixian).toFixed(2);
							arr.push(casual);
							i++;
						}
					}
					// arr.push
					return arr;
				}
			},
			methods: {
				traded: function(){
					var _this = this;
					// three
					var obj = {};
					var sub = Math.random()*0.1;
					var sub2 = Math.random();

					obj.name = 'tp2';
					obj.nameNum = 3;
					obj.code = 40719;
					obj.orderCode = this.three[0].orderCode + 1;
					obj.state = (function(){
						function a(){
							return Math.ceil(Math.random()*4);
						}
						var b = a();

						if(b == 4 || b == 1) b = a();

						return b;
					})()
					// console.log('~~~~~~~~~~~~~~');
					// console.log(parseInt(this.three[0].char));
					// console.log(sub)
					// console.log('~~~~~~~~~!!!!!!');
					obj.char = (parseFloat(this.three[0].char) + ( sub < 0.05 ? -sub : sub)).toFixed(2);
					obj.tradeNum = Math.random() < 0.5 ? 3000 : 1000;
					obj.tradeDirect = sub2 < 0.5 ? 1 : 2;
					var sub1 = Math.ceil(Math.random()*4);
					obj.charQue = (parseFloat(this.three[0].charQue) + ( sub1 == 1 ? 0.02 : sub1 == 2 ? -0.02 : 0 )).toFixed(2) ;
					// console.log(obj);
					var arr = [];
					arr.push(obj);
					arr = arr.concat(this.three);

					// console.log(arr);

					this.$set('three', arr);



					// one

					function c(){
						var len = _this.one.length;
						var sup;
						while (true){
							sup = Math.ceil(Math.random()*len);
							if(sup == 4 || sup == 6 || sup == 8 || sup == 10 ){
								break;
							} 
						}

						return sup-1;

					}

					var sup = c();
					var chg = parseFloat((Math.random()*0.05).toFixed(2));
					this.one[0].shijia = parseFloat(this.one[sup].shijia) + chg;
					this.one[1].shijia = parseFloat(this.one[sup].shijia) + chg;
					this.one[2].shijia = parseFloat(this.one[sup].shijia) + chg;
					this.one[3].shijia = parseFloat(this.one[sup].shijia) + chg;
					this.one[5].shijia = parseFloat(this.one[sup].shijia) + chg;
					this.one[7].shijia = parseFloat(this.one[sup].shijia) + chg;
					this.one[9].shijia = parseFloat(this.one[sup].shijia) + chg;

				},
				menu: function(is){
					this.jinggao();
					var obj = event.srcElement ||event.target;
					var scrollX = document.documentElement.scrollLeft || document.body.scrollLeft;
					if(is){
						this.$set('mark', obj.parentNode.getAttribute('data-mark'));
						this.$set('styleObject', {
							'display': 'block',
							'left': event.clientX + scrollX + 'px',
							'top': event.clientY + scrollY + 'px'
						})
					} else {
						this.$set('mark2', obj.parentNode.getAttribute('data-mark2'));
						if(this.three[this.mark2].state == 2){
							this.$set('sObject', {
								'display': 'block',
								'left': event.clientX + scrollX + 'px',
								'top': event.clientY + scrollY + 'px'
							})
						}
					}
				},

				pingcang: function(){
					this.one[this.mark].chicang = 0;
					this.$set('styleObject', {
						'display': 'none'
					})
				},

				hideMenu: function(){
					this.$set('styleObject', {
						'display': 'none'
					})
					this.$set('sObject', {
						'display': 'none'
					})
				},
				jinggao: function(){
					this.$set('styleObject', {
						'display': 'none'
					})
					this.$set('sObject', {
						'display': 'none'
					})
				},
				chedan: function(){
					console.log(this.mark2);
					this.three[this.mark2].state = 3;
					this.$set('sObject', {
						'display': 'none'
					})
				}

			}
		})

		
	</script>
</body>
</html>