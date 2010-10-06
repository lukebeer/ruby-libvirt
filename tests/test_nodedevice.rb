#!/usr/bin/ruby

# Test the nodedevice methods the bindings support

$: << File.dirname(__FILE__)

require 'libvirt'
require 'test_utils.rb'

conn = Libvirt::open("qemu:///system")

# TESTGROUP: conn.num_of_nodedevices
expect_too_many_args(conn, "num_of_nodedevices", 1, 2, 3)
expect_invalid_arg_type(conn, "num_of_nodedevices", 1)
expect_invalid_arg_type(conn, "num_of_nodedevices", 'foo', 'bar')
expect_success(conn, "no args", "num_of_nodedevices")

# TESTGROUP: conn.list_nodedevices
expect_too_many_args(conn, "list_nodedevices", 1, 2, 3)
expect_invalid_arg_type(conn, "list_nodedevices", 1)
expect_invalid_arg_type(conn, "list_nodedevices", 'foo', 'bar')
expect_success(conn, "no args", "list_nodedevices")

# TESTGROUP: conn.lookup_nodedevice_by_name
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(conn, "lookup_nodedevice_by_name", 1, 2)
expect_too_few_args(conn, "lookup_nodedevice_by_name")
expect_invalid_arg_type(conn, "lookup_nodedevice_by_name", 1)
expect_fail(conn, Libvirt::RetrieveError, "non-existent name arg", "lookup_nodedevice_by_name", "foobarbazsucker")

expect_success(conn, "name arg", "lookup_nodedevice_by_name", testnode.name)

# TESTGROUP: conn.create_nodedevice_xml
expect_too_many_args(conn, "create_nodedevice_xml", 1, 2, 3)
expect_too_few_args(conn, "create_nodedevice_xml")
expect_invalid_arg_type(conn, "create_nodedevice_xml", 1)
expect_invalid_arg_type(conn, "create_nodedevice_xml", "foo", 'bar')
expect_fail(conn, Libvirt::Error, "invalid XML", "create_nodedevice_xml", "hello")

#expect_success(conn, "nodedevice XML", "create_nodedevice_xml", "<nodedevice/>")

# TESTGROUP: nodedevice.name
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "name", 1)
expect_success(testnode, "no args", "name")

# TESTGROUP: nodedevice.parent
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "parent", 1)
expect_success(testnode, "no args", "parent")

# TESTGROUP: nodedevice.num_of_caps
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "num_of_caps", 1)
expect_success(testnode, "no args", "num_of_caps")

# TESTGROUP: nodedevice.list_caps
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "list_caps", 1)
expect_success(testnode, "no args", "list_caps")

# TESTGROUP: nodedevice.xml_desc
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "xml_desc", 1, 2)
expect_invalid_arg_type(testnode, "xml_desc", 'foo')
expect_success(testnode, "no args", "xml_desc")

# TESTGROUP: nodedevice.detach
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "detach", 1)

#expect_success(testnode, "no args", "detach")

# TESTGROUP: nodedevice.reattach
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "reattach", 1)

#expect_success(testnode, "no args", "reattach")

# TESTGROUP: nodedevice.reset
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "reset", 1)

#expect_success(testnode, "no args", "reset")

# TESTGROUP: nodedevice.destroy
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "destroy", 1)

#expect_success(testnode, "no args", "destroy")

# TESTGROUP: nodedevice.free
testnode = conn.lookup_nodedevice_by_name(conn.list_nodedevices[0])

expect_too_many_args(testnode, "free", 1)

expect_success(testnode, "no args", "free")

conn.close

finish_tests
