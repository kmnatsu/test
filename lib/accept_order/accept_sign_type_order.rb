# coding: utf-8
#require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
#require File.expand_path(File.dirname(__FILE__) + '/../../app/models/order')

class AcceptSignTypeOrder < DaemonSpawn::Base
  def start(args)
    puts "start : #{Time.now}"

    loop do
      puts "loop start"
      
      # 処理対象のリストを生成する
      target_identifier_list = make_target_identifier_list()
      
      # 処理対象毎にオーダー処理を依頼する
      target_identifier_list.each do |target_identifier|
        request_execution_order(target_identifier)
      end
      
      sleep 5 #TODO 設定ファイルから取る
      puts "loop end"
    end
  end

  def stop
    puts "stop  : #{Time.now}"
  end
  
  private
  
  # 処理対象のリストを生成する
  # return
  #   [List<String>] 処理対象を特定する識別子のリスト
  def make_target_identifier_list()
    target_orders = Order.where(target_type: Order::TARGET_TYPE_SIGN, progress_status: [Order::PROGRESS_STATUS_WAITING, Order::PROGRESS_STATUS_PROCESSING])
    target_orders.group(:target_identifier).pluck(:target_identifier)
  end
  
  # オーダー処理を依頼する
  # params
  #   [String] 対象を一意に識別するID
  def request_execution_order(target_identifier)
    ExecOrder::ExecSignTypeOrder.new().execute(target_identifier)
  end
end

AcceptSignTypeOrder.spawn!({
    :working_dir => Rails.root, # これだけ必須オプション
    :pid_file => File.expand_path(File.dirname(__FILE__) + '/../../tmp/accept_sign_type_order.pid'),
    :log_file => File.expand_path(File.dirname(__FILE__) + '/../../log/accept_sign_type_order.log'),
    :sync_log => true,
    :singleton => true # これを指定すると多重起動しない
})
