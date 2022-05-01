// Generated by gencpp from file aro_msgs/PlanPath.msg
// DO NOT EDIT!


#ifndef ARO_MSGS_MESSAGE_PLANPATH_H
#define ARO_MSGS_MESSAGE_PLANPATH_H

#include <ros/service_traits.h>


#include <aro_msgs/PlanPathRequest.h>
#include <aro_msgs/PlanPathResponse.h>


namespace aro_msgs
{

struct PlanPath
{

typedef PlanPathRequest Request;
typedef PlanPathResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct PlanPath
} // namespace aro_msgs


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::aro_msgs::PlanPath > {
  static const char* value()
  {
    return "fbdf89b8655c8e7d5298541bcdc5e6da";
  }

  static const char* value(const ::aro_msgs::PlanPath&) { return value(); }
};

template<>
struct DataType< ::aro_msgs::PlanPath > {
  static const char* value()
  {
    return "aro_msgs/PlanPath";
  }

  static const char* value(const ::aro_msgs::PlanPath&) { return value(); }
};


// service_traits::MD5Sum< ::aro_msgs::PlanPathRequest> should match
// service_traits::MD5Sum< ::aro_msgs::PlanPath >
template<>
struct MD5Sum< ::aro_msgs::PlanPathRequest>
{
  static const char* value()
  {
    return MD5Sum< ::aro_msgs::PlanPath >::value();
  }
  static const char* value(const ::aro_msgs::PlanPathRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::aro_msgs::PlanPathRequest> should match
// service_traits::DataType< ::aro_msgs::PlanPath >
template<>
struct DataType< ::aro_msgs::PlanPathRequest>
{
  static const char* value()
  {
    return DataType< ::aro_msgs::PlanPath >::value();
  }
  static const char* value(const ::aro_msgs::PlanPathRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::aro_msgs::PlanPathResponse> should match
// service_traits::MD5Sum< ::aro_msgs::PlanPath >
template<>
struct MD5Sum< ::aro_msgs::PlanPathResponse>
{
  static const char* value()
  {
    return MD5Sum< ::aro_msgs::PlanPath >::value();
  }
  static const char* value(const ::aro_msgs::PlanPathResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::aro_msgs::PlanPathResponse> should match
// service_traits::DataType< ::aro_msgs::PlanPath >
template<>
struct DataType< ::aro_msgs::PlanPathResponse>
{
  static const char* value()
  {
    return DataType< ::aro_msgs::PlanPath >::value();
  }
  static const char* value(const ::aro_msgs::PlanPathResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // ARO_MSGS_MESSAGE_PLANPATH_H
