Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7060300133
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbhAVLIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:08:02 -0500
Received: from mga09.intel.com ([134.134.136.24]:15900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727487AbhAVLCR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:02:17 -0500
IronPort-SDR: 6tUFsAYyRllfBlVMfXDwwAi4z22T3E5NqoDk+23MQwVHcqcIvTFwPIvBDPy+a9KLkcge64dwLY
 Zr61UbaVouww==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179574494"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="179574494"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 03:01:29 -0800
IronPort-SDR: icWcl1UThiJJpFt9liWamdTlDdRzVBCiXnODrpN7xLP812U+2VUvoCnGXX7XMD/XoZzpDoDPrU
 cSGHrdAx1kCg==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; 
   d="scan'208";a="356985752"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 03:01:26 -0800
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH v8 00/18] HSM driver for ACRN hypervisor
Date:   Fri, 22 Jan 2021 19:01:04 +0800
Message-Id: <20210122110122.45800-1-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shuo Liu <shuo.a.liu@intel.com>

ACRN is a Type 1 reference hypervisor stack, running directly on the bare-metal
hardware, and is suitable for a variety of IoT and embedded device solutions.

ACRN implements a hybrid VMM architecture, using a privileged Service VM. The
Service VM manages the system resources (CPU, memory, etc.) and I/O devices of
User VMs. Multiple User VMs are supported, with each of them running Linux,
Android OS or Windows. Both Service VM and User VMs are guest VM.

Below figure shows the architecture.

                Service VM                    User VM
      +----------------------------+  |  +------------------+
      |        +--------------+    |  |  |                  |
      |        |ACRN userspace|    |  |  |                  |
      |        +--------------+    |  |  |                  |
      |-----------------ioctl------|  |  |                  |   ...
      |kernel space   +----------+ |  |  |                  |
      |               |   HSM    | |  |  | Drivers          |
      |               +----------+ |  |  |                  |
      +--------------------|-------+  |  +------------------+
  +---------------------hypercall----------------------------------------+
  |                       ACRN Hypervisor                                |
  +----------------------------------------------------------------------+
  |                          Hardware                                    |
  +----------------------------------------------------------------------+

There is only one Service VM which could run Linux as OS.

In a typical case, the Service VM will be auto started when ACRN Hypervisor is
booted. Then the ACRN userspace (an application running in Service VM) could be
used to start/stop User VMs by communicating with ACRN Hypervisor Service
Module (HSM).

ACRN Hypervisor Service Module (HSM) is a middle layer that allows the ACRN
userspace and Service VM OS kernel to communicate with ACRN Hypervisor
and manage different User VMs. This middle layer provides the following
functionalities,
  - Issues hypercalls to the hypervisor to manage User VMs:
      * VM/vCPU management
      * Memory management
      * Device passthrough
      * Interrupts injection
  - I/O requests handling from User VMs.
  - Exports ioctl through HSM char device.
  - Exports function calls for other kernel modules

ACRN is focused on embedded system. So it doesn't support some features.
E.g.,
  - ACRN doesn't support VM migration.
  - ACRN doesn't support vCPU migration.

This patch set adds the HSM to the Linux kernel.
I also added a simple example to launch a small guest (with several instructions
as payload) on ACRN with demonstration ioctl usage.

The basic ARCN support was merged to upstream already.
https://lore.kernel.org/lkml/1559108037-18813-3-git-send-email-yakui.zhao@intel.com/


ChangeLog:
v8:
  - Minor improved in documentation. (Randy)
  - Improved public header documentation. (Greg)
  - Verified more reserved fields of ioctls. (Greg)
  - Change tasklet to a high prio workqueue due to tasklets are deprecated. (Davidlohr)
  - Add Copyright for public header file. (Greg)

v7:
  - Typo fixed in documentation. (Boris)
  - Verified some reserved fields of ioctls. (Greg)
  - Rebased to v5.11-rc2.

v6:
  - Added the cpuid.rst documentation (Boris)
  - Deleted exported acrn_is_privileged_vm(), user detects feature bits by cpuid_eax() directly (Boris)
  - Used 'g' as the hcall_id constrain in hypercall definitions (Boris, Segher)
  - Removed unnecessary reserved fields from structures. Sorted some fields for alignment (Greg)
  - Used built-in kernel guid_t types (Greg)
  - Specified the endian of some fields in user/kernel interface structures (Greg)
  - Removed the alignment attribute from user/kernel interface structures (Greg)
  - Set reserved fields to zero (Greg)
  - Added a ioctl interface usage sample in the last patch (Greg)
  - Used pin_user_pages*() instead of get_user_pages*().

v5:
  - Corrected typo in documentation.
  - Removed unused pr_fmt().
  - Used supported constraint with a explicit MOV to R8 at beginning of ASM for hypercall interface.
  - Used dev_dbg() to replace dev_err() in places which might cause a DoS.
  - Introduced acrn_vm_list_lock as a mutex for friendly review.
  - Changed to use default attribute group list to add attribute files.

v4:
  - Used acrn_dev.this_device directly for dev_*() (Reinette)
  - Removed the odd usage of {get|put}_device() on &acrn_dev->this_device (Greg)
  - Removed unused log code. (Greg)
  - Corrected the return error values. (Greg)
  - Mentioned that HSM relies hypervisor for sanity check in acrn_dev_ioctl() comments (Greg)

v3:
  - Used {get|put}_device() helpers on &acrn_dev->this_device
  - Moved unused code from front patches to later ones.
  - Removed self-defined pr_fmt() and dev_fmt()
  - Provided comments for acrn_vm_list_lock.

v2:
  - Removed API version related code. (Dave)
  - Replaced pr_*() by dev_*(). (Greg)
  - Used -ENOTTY as the error code of unsupported ioctl. (Greg)

Shuo Liu (17):
  docs: acrn: Introduce ACRN
  x86/acrn: Introduce acrn_{setup, remove}_intr_handler()
  x86/acrn: Introduce hypercall interfaces
  virt: acrn: Introduce ACRN HSM basic driver
  virt: acrn: Introduce VM management interfaces
  virt: acrn: Introduce an ioctl to set vCPU registers state
  virt: acrn: Introduce EPT mapping management
  virt: acrn: Introduce I/O request management
  virt: acrn: Introduce PCI configuration space PIO accesses combiner
  virt: acrn: Introduce interfaces for PCI device passthrough
  virt: acrn: Introduce interrupt injection interfaces
  virt: acrn: Introduce interfaces to query C-states and P-states
    allowed by hypervisor
  virt: acrn: Introduce I/O ranges operation interfaces
  virt: acrn: Introduce ioeventfd
  virt: acrn: Introduce irqfd
  virt: acrn: Introduce an interface for Service VM to control vCPU
  sample/acrn: Introduce a sample of HSM ioctl interface usage

Yin Fengwei (1):
  x86/acrn: Introduce acrn_cpuid_base() and hypervisor feature bits

 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 Documentation/virt/acrn/cpuid.rst             |  46 ++
 Documentation/virt/acrn/index.rst             |  12 +
 Documentation/virt/acrn/introduction.rst      |  43 ++
 Documentation/virt/acrn/io-request.rst        |  97 +++
 Documentation/virt/index.rst                  |   1 +
 MAINTAINERS                                   |   9 +
 arch/x86/include/asm/acrn.h                   |  78 +++
 arch/x86/kernel/cpu/acrn.c                    |  16 +-
 drivers/virt/Kconfig                          |   2 +
 drivers/virt/Makefile                         |   1 +
 drivers/virt/acrn/Kconfig                     |  15 +
 drivers/virt/acrn/Makefile                    |   3 +
 drivers/virt/acrn/acrn_drv.h                  | 227 ++++++
 drivers/virt/acrn/hsm.c                       | 463 ++++++++++++
 drivers/virt/acrn/hypercall.h                 | 254 +++++++
 drivers/virt/acrn/ioeventfd.c                 | 273 ++++++++
 drivers/virt/acrn/ioreq.c                     | 657 ++++++++++++++++++
 drivers/virt/acrn/irqfd.c                     | 235 +++++++
 drivers/virt/acrn/mm.c                        | 306 ++++++++
 drivers/virt/acrn/vm.c                        | 126 ++++
 include/uapi/linux/acrn.h                     | 580 ++++++++++++++++
 samples/acrn/Makefile                         |  12 +
 samples/acrn/guest.ld                         |   9 +
 samples/acrn/payload.ld                       |   9 +
 samples/acrn/vm-sample.c                      | 136 ++++
 26 files changed, 3610 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/virt/acrn/cpuid.rst
 create mode 100644 Documentation/virt/acrn/index.rst
 create mode 100644 Documentation/virt/acrn/introduction.rst
 create mode 100644 Documentation/virt/acrn/io-request.rst
 create mode 100644 arch/x86/include/asm/acrn.h
 create mode 100644 drivers/virt/acrn/Kconfig
 create mode 100644 drivers/virt/acrn/Makefile
 create mode 100644 drivers/virt/acrn/acrn_drv.h
 create mode 100644 drivers/virt/acrn/hsm.c
 create mode 100644 drivers/virt/acrn/hypercall.h
 create mode 100644 drivers/virt/acrn/ioeventfd.c
 create mode 100644 drivers/virt/acrn/ioreq.c
 create mode 100644 drivers/virt/acrn/irqfd.c
 create mode 100644 drivers/virt/acrn/mm.c
 create mode 100644 drivers/virt/acrn/vm.c
 create mode 100644 include/uapi/linux/acrn.h
 create mode 100644 samples/acrn/Makefile
 create mode 100644 samples/acrn/guest.ld
 create mode 100644 samples/acrn/payload.ld
 create mode 100644 samples/acrn/vm-sample.c


base-commit: 9f1abbe97c08ba7ed609791627533a805a1b2c66
-- 
2.28.0

