// Generated by gencpp from file aro_msgs/GenerateFrontierRequest.msg
// DO NOT EDIT!


#ifndef ARO_MSGS_MESSAGE_GENERATEFRONTIERREQUEST_H
#define ARO_MSGS_MESSAGE_GENERATEFRONTIERREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace aro_msgs
{
template <class ContainerAllocator>
struct GenerateFrontierRequest_
{
  typedef GenerateFrontierRequest_<ContainerAllocator> Type;

  GenerateFrontierRequest_()
    {
    }
  GenerateFrontierRequest_(const ContainerAllocator& _alloc)
    {
  (void)_alloc;
    }







  typedef boost::shared_ptr< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> const> ConstPtr;

}; // struct GenerateFrontierRequest_

typedef ::aro_msgs::GenerateFrontierRequest_<std::allocator<void> > GenerateFrontierRequest;

typedef boost::shared_ptr< ::aro_msgs::GenerateFrontierRequest > GenerateFrontierRequestPtr;
typedef boost::shared_ptr< ::aro_msgs::GenerateFrontierRequest const> GenerateFrontierRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


} // namespace aro_msgs

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "d41d8cd98f00b204e9800998ecf8427e";
  }

  static const char* value(const ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xd41d8cd98f00b204ULL;
  static const uint64_t static_value2 = 0xe9800998ecf8427eULL;
};

template<class ContainerAllocator>
struct DataType< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "aro_msgs/GenerateFrontierRequest";
  }

  static const char* value(const ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "\n"
;
  }

  static const char* value(const ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream&, T)
    {}

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct GenerateFrontierRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream&, const std::string&, const ::aro_msgs::GenerateFrontierRequest_<ContainerAllocator>&)
  {}
};

} // namespace message_operations
} // namespace ros

#endif // ARO_MSGS_MESSAGE_GENERATEFRONTIERREQUEST_H
