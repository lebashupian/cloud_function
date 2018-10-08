#!/opt/ruby_2.2.3/bin/ruby -w
# coding: utf-8
begin
	require 'drb/drb'
	if ARGV[0] != nil
		计算量=ARGV[0].to_i
	end

	计算量 ||= 1000

	暂停时间 = ARGV[1].to_f if ARGV[1] != nil

	暂停时间 ||= 1




	分布式_slave1_路径="druby://192.168.137.38:8787"
	分布式_slave2_路径="druby://192.168.137.39:8788"
	分布式_slave3_路径="druby://192.168.137.37:8787"
	分布式_slave4_路径="druby://192.168.137.41:8787"

	分布式_slave1_网络服务 = DRbObject.new_with_uri(分布式_slave1_路径)
	分布式_slave2_网络服务 = DRbObject.new_with_uri(分布式_slave2_路径)
	分布式_slave3_网络服务 = DRbObject.new_with_uri(分布式_slave3_路径)
	分布式_slave4_网络服务 = DRbObject.new_with_uri(分布式_slave4_路径)

	线程组=[]

	#
	# 引入互斥，防止多线程在打印的过程中，出现冲突 
	#
	互斥系统 = Mutex.new

	500.times {|x|
	x=x+1
	puts "-----------第#{x}次循环------------"
	总和=0
	线程组 << Thread.new{ 
		变量=分布式_slave1_网络服务.求和(计算量)
		互斥系统.synchronize {
			p 变量
		}
		总和 += 变量[1]
	}
	线程组 << Thread.new{ 
		变量=分布式_slave2_网络服务.求和(计算量)
		互斥系统.synchronize {
			p 变量
		}
		总和 += 变量[1]
	}
	线程组 << Thread.new{
	 	变量=分布式_slave3_网络服务.求和(计算量)
		互斥系统.synchronize {
			p 变量
		}
		总和 += 变量[1]
	}
	线程组 << Thread.new{
		变量=分布式_slave4_网络服务.求和(计算量)
		互斥系统.synchronize {
			p 变量
		}
		总和 += 变量[1]
	}
	线程组.each {|y| y.join}

	puts "总和：#{总和}"
	puts "---------------暂停---------------"
	sleep 暂停时间
	}
rescue Exception => e
	p e
end



