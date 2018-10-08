#!/opt/ruby_2.2.3/bin/ruby -w
# coding: utf-8
require 'drb/drb'
分布式_slave1_路径="druby://192.168.137.38:8787"


	class C_分布式_slave1类
	  def 求和(参数=100)
	  	i=0
	  	参数.times {|x|
	  		i += x

	  	}
		return [__FILE__,i]
	  end
	end
	
		分布式_slave1_实例=C_分布式_slave1类.new
		
		DRb.start_service(分布式_slave1_路径, 分布式_slave1_实例)	#将实例放到端口上
		loop {
		sleep 10
		}
		#分布式_slave1_服务.stop_service
