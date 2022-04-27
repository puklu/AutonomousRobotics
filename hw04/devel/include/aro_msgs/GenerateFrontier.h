// Generated by gencpp from file aro_msgs/GenerateFrontier.msg
// DO NOT EDIT!


#ifndef ARO_MSGS_MESSAGE_GENERATEFRONTIER_H
#define ARO_MSGS_MESSAGE_GENERATEFRONTIER_H

#include <ros/service_traits.h>


#include <aro_msgs/GenerateFrontierRequest.h>
#include <aro_msgs/GenerateFrontierResponse.h>


namespace aro_msgs
{

struct GenerateFrontier
{

typedef GenerateFrontierRequest Request;
typedef GenerateFrontierResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct GenerateFrontier
} // namespace aro_msgs


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::aro_msgs::GenerateFrontier > {
  static const char* value()
  {
    return "9c696f8357da6184167237a9d05c73bc";
  }

  static const char* value(const ::aro_msgs::GenerateFrontier&) { return value(); }
};

template<>
struct DataType< ::aro_msgs::GenerateFrontier > {
  static const char* value()
  {
    return "aro_msgs/GenerateFrontier";
  }

  static const char* value(const ::aro_msgs::GenerateFrontier&) { return value(); }
};


// service_traits::MD5Sum< ::aro_msgs::GenerateFrontierRequest> should match
// service_traits::MD5Sum< ::aro_msgs::GenerateFrontier >
template<>
struct MD5Sum< ::aro_msgs::GenerateFrontierRequest>
{
  static const char* value()
  {
    return MD5Sum< ::aro_msgs::GenerateFrontier >::value();
  }
  static const char* value(const ::aro_msgs::GenerateFrontierRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::aro_msgs::GenerateFrontierRequest> should match
// service_traits::DataType< ::aro_msgs::GenerateFrontier >
template<>
struct DataType< ::aro_msgs::GenerateFrontierRequest>
{
  static const char* value()
  {
    return DataType< ::aro_msgs::GenerateFrontier >::value();
  }
  static const char* value(const ::aro_msgs::GenerateFrontierRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::aro_msgs::GenerateFrontierResponse> should match
// service_traits::MD5Sum< ::aro_msgs::GenerateFrontier >
template<>
struct MD5Sum< ::aro_msgs::GenerateFrontierResponse>
{
  static const char* value()
  {
    return MD5Sum< ::aro_msgs::GenerateFrontier >::value();
  }
  static const char* value(const ::aro_msgs::GenerateFrontierResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::aro_msgs::GenerateFrontierResponse> should match
// service_traits::DataType< ::aro_msgs::GenerateFrontier >
template<>
struct DataType< ::aro_msgs::GenerateFrontierResponse>
{
  static const char* value()
  {
    return DataType< ::aro_msgs::GenerateFrontier >::value();
  }
  static const char* value(const ::aro_msgs::GenerateFrontierResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // ARO_MSGS_MESSAGE_GENERATEFRONTIER_H
