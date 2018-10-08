#!/opt/ruby_2.2.3/bin/ruby -w
# coding: utf-8

开始时间=Time.new

def exit_msg(参数=nil)
	puts "#{参数}"
end

def 判断合数(参数=nil)
	执行过程=nil
	数字=参数
	判断=nil
	shuzu=Range.new(2,数字-1)
	shuzu.each {|x|
		if (数字/x)*x == 数字
			判断=true
			执行过程='over'
			break
		end
	}
	判断=false if 执行过程 != 'over'
	return 数字,判断
end

数组=[]
Range.new(3,10000).each {|x|
	开始=Time.new
	结果=判断合数 x
	结束=Time.new
	#p (结束-开始).to_i
	
	if 结果[1]==false
		puts "#{结果[0]}"
	end
	#puts "判断是数字是#{x},判断的结果是#{结果[1]},判断的时间是#{(结束-开始)}" if 结果[1]==false
	#数组 << 结果[0] % 10 if 结果[1]==false
	#sleep 0.001
}
exit
p 数组.uniq!.sort!

结束时间=Time.new
时间差=(结束时间-开始时间).to_i
puts "共耗时: #{时间差} 秒"