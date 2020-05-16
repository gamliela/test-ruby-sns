require 'aws-sdk-sns'

sns = Aws::SNS::Resource.new(region: ENV["REGION"])

topic = sns.topic(ENV["TOPIC"])

def publish(topic)
  start = Time.now
  begin
    msg = topic.publish({ message: 'Hello!' })

    [Time.now - start, "success: #{msg[:message_id]}"]
  rescue StandardError => e
    [Time.now - start, e.message]
  end
end

while true do
  puts publish(topic).join(' ')
  sleep 1
end
