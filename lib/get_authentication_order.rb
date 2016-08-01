# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/../config/environment')
require File.expand_path(File.dirname(__FILE__) + '/../app/models/order')

class GetAuthenticationOrder < DaemonSpawn::Base
  def start(args)
    puts "start : #{Time.now}"

    loop do
      orders = Order.where(target_identifier: 'sign', progress_result: 'waiting')
      orders.each do |order|
        #TODO オーダーに対する処理
      end
      sleep 5 #TODO 設定ファイルから取る
    end
  end

  def stop
    puts "stop  : #{Time.now}"
  end
end

GetAuthenticationOrder.spawn!({
    :working_dir => Rails.root, # これだけ必須オプション
    :pid_file => File.expand_path(File.dirname(__FILE__) + '/../tmp/get_authentication_order.pid'),
    :log_file => File.expand_path(File.dirname(__FILE__) + '/../log/get_authentication_order.log'),
    :sync_log => true,
    :singleton => true # これを指定すると多重起動しない
  })
