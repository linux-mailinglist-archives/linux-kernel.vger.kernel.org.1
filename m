Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0475D2EA385
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbhAEC6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:58:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:41794 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbhAEC6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:58:52 -0500
IronPort-SDR: mEPez/YvfDVEXY9eRwBXLKR8f6FKGkidw25NnBLyFK4/xHtYf6y3xETF7dyD4xiFpGRApuQqwR
 Y4lsjGBfm2hA==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156827505"
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="156827505"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 18:58:12 -0800
IronPort-SDR: 9Yf+A2hwhM98t8qSzTFtVclPeDNO4zcV8gfG0P//NSLzgk+JqhHQubPdGTaOsETp+TYz4B8aPo
 qxypU9cQGy9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="397632107"
Received: from txasoft-yocto.an.intel.com ([10.123.72.192])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jan 2021 18:58:11 -0800
From:   Mike Ximing Chen <mike.ximing.chen@intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, pierre-louis.bossart@linux.intel.com
Subject: [PATCH v8 00/20] dlb: introduce DLB device driver
Date:   Mon,  4 Jan 2021 20:58:19 -0600
Message-Id: <20210105025839.23169-1-mike.ximing.chen@intel.com>
X-Mailer: git-send-email 2.13.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new misc device driver for the Intel(r) Dynamic Load Balancer
(Intel(r) DLB). The Intel DLB is a PCIe device that provides
load-balanced, prioritized scheduling of core-to-core communication.

Intel DLB is an accelerator for the event-driven programming model of
DPDK's Event Device Library[2]. The library is used in packet processing
pipelines that arrange for multi-core scalability, dynamic load-balancing,
and variety of packet distribution and synchronization schemes

These distribution schemes include "parallel" (packets are load-balanced
across multiple cores and processed in parallel), "ordered" (similar to
"parallel" but packets are reordered into ingress order by the device), and
"atomic" (packet flows are scheduled to a single core at a time such that
locks are not required to access per-flow data, and dynamically migrated to
ensure load-balance).

This submission supports Intel DLB 2.0 only.

The Intel DLB consists of queues and arbiters that connect producer
cores and consumer cores. The device implements load-balanced queueing
features including:
- Lock-free multi-producer/multi-consumer operation.
- Multiple priority levels for varying traffic types.
- 'Direct' traffic (i.e. multi-producer/single-consumer)
- Simple unordered load-balanced distribution.
- Atomic lock free load balancing across multiple consumers.
- Queue element reordering feature allowing ordered load-balanced
  distribution.

The fundamental unit of communication through the device is a queue entry
(QE), which consists of 8B of data and 8B of metadata (destination queue,
priority, etc.). The data field can be any type that fits within 8B.

A core's interface to the device, a "port," consists of a memory-mappable
region through which the core enqueues a queue entry, and an in-memory
queue (the "consumer queue") to which the device schedules QEs. Each QE
is enqueued to a device-managed queue, and from there scheduled to a port.
Software specifies the "linking" of queues and ports; i.e. which ports the
device is allowed to schedule to for a given queue. The device uses a
credit scheme to prevent overflow of the on-device queue storage.

Applications can interface directly with the device by mapping the port's
memory and MMIO regions into the application's address space for enqueue
and dequeue operations, but call into the kernel driver for configuration
operations. An application can also be polling- or interrupt-driven;
Intel DLB supports both modes of operation.

Device resources -- i.e. ports, queues, and credits -- are contained within
a scheduling domain. Scheduling domains are isolated from one another; a
port can only enqueue to and dequeue from queues within its scheduling
domain. A scheduling domain's resources are configured through a scheduling
domain file, which is acquired through an ioctl.

Intel DLB supports SR-IOV and Scalable IOV, and allows for a flexible
division of its resources among the PF and its virtual devices. The virtual
devices are incapable of configuring the device directly; they use a
hardware mailbox to proxy configuration requests to the PF driver. This
driver supports both PF and virtual devices, as there is significant code
re-use between the two, with device-specific behavior handled through a
callback interface.  Virtualization support will be added in a later patch
set.

The dlb driver uses ioctls as its primary interface (it makes use of sysfs
as well, to a lesser extent). The dlb device file supports a different
ioctl interface than the scheduling domain file; the dlb device file
is used for device-wide operations (including scheduling domain creation),
and the scheduling domain file supports operations on the scheduling
domain's resources (primarily resource configuration). Scheduling domains
are created dynamically (using a dlb device file ioctl) by user-space
software, and the scheduling domain file is created from an anonymous file
that is installed in the ioctl's calling process's file descriptor table.

[1] https://builders.intel.com/docs/networkbuilders/SKU-343247-001US-queue-management-and-load-balancing-on-intel-architecture.pdf
[2] https://doc.dpdk.org/guides/prog_guide/eventdev.html

v8:
- Add a functional block diagram in dlb.rst 
- Modify change logs to reflect the links between patches and DPDK
  eventdev library.
- Add a check of power-of-2 for CQ depth.
- Move call to INIT_WORK() to dlb_open().
- Clean dlb workqueue by calling flush_scheduled_work().
- Add unmap_mapping_range() in dlb_port_close().

v7 (Intel internal version):
- Address all of Dan's feedback, including
-- Drop DLB 2.0 throughout the patch set, use DLB only.
-- Fix license and copyright statements
-- Use pcim_enable_device() and pcim_iomap_regions(), instead of
   unmanaged version.
-- Move cdev_add() to dlb_init() and add all devices at once.
-- Fix Makefile, using "+=" style.
-- Remove FLR description and mention movdir64/enqcmd usage in doc.
-- Make the permission for the domain same as that for device for
   ioctl access.
-- Use idr instead of ida.
-- Add a lock in dlb_close() to prevent driver unbinding while ioctl
   coomands are in progress.
-- Remove wrappers that are used for code sharing between kernel driver
   and DPDK. 
- Address Pierre-Louis' feedback, including
-- Clean the warinings from checkpatch
-- Fix the warnings from "make W=1"

v6 (Intel internal version):
- Change the module name to dlb(from dlb2), which currently supports Intel
  DLB 2.0 only.
- Address all of Pierre-Louis' feedback on v5, including
-- Consolidate the two near-identical for loops in dlb2_release_domain_memory().
-- Remove an unnecessary "port = NULL" initialization
-- Consistently use curly braces on the *_LIST_FOR macros
   when the for-loop contents spans multiple lines.
-- Add a comment to the definition of DLB2FS_MAGIC
-- Remove always true if statemnets
-- Move the get_cos_bw mutex unlock call earlier to shorten the critical
   section.
- Address all of Dan's feedbacks, including
-- Replace the unions for register bits access with bitmask and shifts
-- Centralize the "to/from" user memory copies for ioctl functions.
-- Review ioctl design against Documentation/process/botching-up-ioctls.rst
-- Remove wraper functions for memory barriers.
-- Use ilog() to simplify a switch code block.
-- Add base-commit to cover letter.

v5 (Intel internal version):
- Reduce the scope of the initial patch set (drop the last 8 patches)
- Further decompose some of the remaining patches into multiple patches.
- Address all of Pierre-Louis' feedback, including:
-- Move kerneldoc to *.c files
-- Fix SPDX comment style
-- Add BAR macros
-- Improve/clarify struct dlb2_dev and struct device variable naming
-- Add const where missing
-- Clarify existing comments and add new ones in various places
-- Remove unnecessary memsets and zero-initialization
-- Remove PM abstraction, fix missing pm_runtime_allow(), and don't
   update PM refcnt when port files are opened and closed.
-- Convert certain ternary operations into if-statements
-- Out-line the CQ depth valid check
-- De-duplicate the logic in dlb2_release_device_memory()
-- Limit use of devm functions to allocating/freeing struct dlb2
- Address Ira's comments on dlb2.rst and correct commit messages that
  don't use the imperative voice.

v4:
- Move PCI device ID definitions into dlb2_hw_types.h, drop the VF definition
- Remove dlb2_dev_list
- Remove open/close functions and fops structure (unused)
- Remove "(char *)" cast from PCI driver name
- Unwind init failures properly
- Remove ID alloc helper functions and call IDA interfaces directly instead

v3:
- Remove DLB2_PCI_REG_READ/WRITE macros

v2:
- Change driver license to GPLv2 only
- Expand Kconfig help text and remove unnecessary (R)s
- Remove unnecessary prints
- Add a new entry in ioctl-number.rst
- Convert the ioctl handler into a switch statement
- Correct some instances of IOWR that should have been IOR
- Align macro blocks
- Don't break ioctl ABI when introducing new commands
- Remove indirect pointers from ioctl data structures
- Remove the get-sched-domain-fd ioctl command

Mike Ximing Chen (20):
  dlb: add skeleton for DLB driver
  dlb: initialize device
  dlb: add resource and device initialization
  dlb: add device ioctl layer and first three ioctls
  dlb: add scheduling domain configuration
  dlb: add domain software reset
  dlb: add low-level register reset operations
  dlb: add runtime power-management support
  dlb: add queue create, reset, get-depth ioctls
  dlb: add register operations for queue management
  dlb: add ioctl to configure ports and query poll mode
  dlb: add register operations for port management
  dlb: add port mmap support
  dlb: add start domain ioctl
  dlb: add queue map, unmap, and pending unmap operations
  dlb: add port map/unmap state machine
  dlb: add static queue map register operations
  dlb: add dynamic queue map register operations
  dlb: add queue unmap register operations
  dlb: queue map/unmap workqueue

 Documentation/misc-devices/dlb.rst            |  259 +
 Documentation/misc-devices/index.rst          |    1 +
 .../userspace-api/ioctl/ioctl-number.rst      |    1 +
 MAINTAINERS                                   |    8 +
 drivers/misc/Kconfig                          |    1 +
 drivers/misc/Makefile                         |    1 +
 drivers/misc/dlb/Kconfig                      |   18 +
 drivers/misc/dlb/Makefile                     |   11 +
 drivers/misc/dlb/dlb_bitmap.h                 |  210 +
 drivers/misc/dlb/dlb_file.c                   |  150 +
 drivers/misc/dlb/dlb_file.h                   |   18 +
 drivers/misc/dlb/dlb_hw_types.h               |  313 +
 drivers/misc/dlb/dlb_ioctl.c                  |  542 ++
 drivers/misc/dlb/dlb_ioctl.h                  |   13 +
 drivers/misc/dlb/dlb_main.c                   |  635 ++
 drivers/misc/dlb/dlb_main.h                   |  166 +
 drivers/misc/dlb/dlb_pf_ops.c                 |  303 +
 drivers/misc/dlb/dlb_regs.h                   | 3640 +++++++++++
 drivers/misc/dlb/dlb_resource.c               | 5685 +++++++++++++++++
 drivers/misc/dlb/dlb_resource.h               |  125 +
 include/uapi/linux/dlb.h                      |  595 ++
 21 files changed, 12695 insertions(+)
 create mode 100644 Documentation/misc-devices/dlb.rst
 create mode 100644 drivers/misc/dlb/Kconfig
 create mode 100644 drivers/misc/dlb/Makefile
 create mode 100644 drivers/misc/dlb/dlb_bitmap.h
 create mode 100644 drivers/misc/dlb/dlb_file.c
 create mode 100644 drivers/misc/dlb/dlb_file.h
 create mode 100644 drivers/misc/dlb/dlb_hw_types.h
 create mode 100644 drivers/misc/dlb/dlb_ioctl.c
 create mode 100644 drivers/misc/dlb/dlb_ioctl.h
 create mode 100644 drivers/misc/dlb/dlb_main.c
 create mode 100644 drivers/misc/dlb/dlb_main.h
 create mode 100644 drivers/misc/dlb/dlb_pf_ops.c
 create mode 100644 drivers/misc/dlb/dlb_regs.h
 create mode 100644 drivers/misc/dlb/dlb_resource.c
 create mode 100644 drivers/misc/dlb/dlb_resource.h
 create mode 100644 include/uapi/linux/dlb.h


base-commit: 4429f14aeea979b63bcafdcf9f09677fcf8fd475
-- 
2.17.1

