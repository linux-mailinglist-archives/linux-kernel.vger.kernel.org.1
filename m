Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806BE279D28
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 02:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgI0AZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 20:25:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:12226 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbgI0AZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 20:25:12 -0400
IronPort-SDR: HQ4ajrjhaD6i7u2wudDcsVMvet+UpYynNvVV18zEix/XaVkkY6CUCbdp2gG0eS88TjRtWbc1u4
 NWgz/gB14hnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="149479796"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="149479796"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 17:25:07 -0700
IronPort-SDR: svSdsM3bYbpeJYiWx9WInXAegrAs9Pat/H6quQ2B3HKrTkplNQT1UhkLRtff1p+UoZtAwyOd4z
 42R6q0L6qHrQ==
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="488061063"
Received: from sliu49-mobl1.ccr.corp.intel.com (HELO [10.249.175.72]) ([10.249.175.72])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 17:25:05 -0700
Subject: Re: [PATCH v4 00/17] HSM driver for ACRN hypervisor
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
From:   "Liu, Shuo A" <shuo.a.liu@intel.com>
Message-ID: <8235ade4-eb61-aed1-bd9a-9db0134cb64a@intel.com>
Date:   Sun, 27 Sep 2020 08:24:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922114311.38804-1-shuo.a.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On 9/22/2020 19:42, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> ACRN is a Type 1 reference hypervisor stack, running directly on the bare-metal
> hardware, and is suitable for a variety of IoT and embedded device solutions.
> 
> ACRN implements a hybrid VMM architecture, using a privileged Service VM. The
> Service VM manages the system resources (CPU, memory, etc.) and I/O devices of
> User VMs. Multiple User VMs are supported, with each of them running Linux,
> Android OS or Windows. Both Service VM and User VMs are guest VM.
> 
> Below figure shows the architecture.
> 
>                 Service VM                    User VM
>       +----------------------------+  |  +------------------+
>       |        +--------------+    |  |  |                  |
>       |        |ACRN userspace|    |  |  |                  |
>       |        +--------------+    |  |  |                  |
>       |-----------------ioctl------|  |  |                  |   ...
>       |kernel space   +----------+ |  |  |                  |
>       |               |   HSM    | |  |  | Drivers          |
>       |               +----------+ |  |  |                  |
>       +--------------------|-------+  |  +------------------+
>   +---------------------hypercall----------------------------------------+
>   |                       ACRN Hypervisor                                |
>   +----------------------------------------------------------------------+
>   |                          Hardware                                    |
>   +----------------------------------------------------------------------+
> 
> There is only one Service VM which could run Linux as OS.
> 
> In a typical case, the Service VM will be auto started when ACRN Hypervisor is
> booted. Then the ACRN userspace (an application running in Service VM) could be
> used to start/stop User VMs by communicating with ACRN Hypervisor Service
> Module (HSM).
> 
> ACRN Hypervisor Service Module (HSM) is a middle layer that allows the ACRN
> userspace and Service VM OS kernel to communicate with ACRN Hypervisor
> and manage different User VMs. This middle layer provides the following
> functionalities,
>   - Issues hypercalls to the hypervisor to manage User VMs:
>       * VM/vCPU management
>       * Memory management
>       * Device passthrough
>       * Interrupts injection
>   - I/O requests handling from User VMs.
>   - Exports ioctl through HSM char device.
>   - Exports function calls for other kernel modules
> 
> ACRN is focused on embedded system. So it doesn't support some features.
> E.g.,
>   - ACRN doesn't support VM migration.
>   - ACRN doesn't support vCPU migration.
> 
> This patch set adds the HSM to the Linux kernel.
> 
> The basic ARCN support was merged to upstream already.
> https://lore.kernel.org/lkml/1559108037-18813-3-git-send-email-yakui.zhao@intel.com/
> 
> ChangeLog:
> v4:
>   - Used acrn_dev.this_device directly for dev_*() (Reinette)
>   - Removed the odd usage of {get|put}_device() on &acrn_dev->this_device (Greg)
>   - Removed unused log code. (Greg)
>   - Corrected the return error values. (Greg)
>   - Mentioned that HSM relies hypervisor for sanity check in acrn_dev_ioctl() comments (Greg)
> 
> v3:
>   - Used {get|put}_device() helpers on &acrn_dev->this_device
>   - Moved unused code from front patches to later ones.
>   - Removed self-defined pr_fmt() and dev_fmt()
>   - Provided comments for acrn_vm_list_lock.
> 
> v2:
>   - Removed API version related code. (Dave)
>   - Replaced pr_*() by dev_*(). (Greg)
>   - Used -ENOTTY as the error code of unsupported ioctl. (Greg)
> 
> Shuo Liu (16):
>   docs: acrn: Introduce ACRN
>   x86/acrn: Introduce acrn_{setup, remove}_intr_handler()
>   x86/acrn: Introduce hypercall interfaces
>   virt: acrn: Introduce ACRN HSM basic driver
>   virt: acrn: Introduce VM management interfaces
>   virt: acrn: Introduce an ioctl to set vCPU registers state
>   virt: acrn: Introduce EPT mapping management
>   virt: acrn: Introduce I/O request management
>   virt: acrn: Introduce PCI configuration space PIO accesses combiner
>   virt: acrn: Introduce interfaces for PCI device passthrough
>   virt: acrn: Introduce interrupt injection interfaces
>   virt: acrn: Introduce interfaces to query C-states and P-states
>     allowed by hypervisor
>   virt: acrn: Introduce I/O ranges operation interfaces
>   virt: acrn: Introduce ioeventfd
>   virt: acrn: Introduce irqfd
>   virt: acrn: Introduce an interface for Service VM to control vCPU
> 
> Yin Fengwei (1):
>   x86/acrn: Introduce an API to check if a VM is privileged
> 
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  Documentation/virt/acrn/index.rst             |  11 +
>  Documentation/virt/acrn/introduction.rst      |  40 ++
>  Documentation/virt/acrn/io-request.rst        |  97 +++
>  Documentation/virt/index.rst                  |   1 +
>  MAINTAINERS                                   |   9 +
>  arch/x86/include/asm/acrn.h                   |  74 ++
>  arch/x86/kernel/cpu/acrn.c                    |  35 +-
>  drivers/virt/Kconfig                          |   2 +
>  drivers/virt/Makefile                         |   1 +
>  drivers/virt/acrn/Kconfig                     |  15 +
>  drivers/virt/acrn/Makefile                    |   3 +
>  drivers/virt/acrn/acrn_drv.h                  | 229 +++++++
>  drivers/virt/acrn/hsm.c                       | 437 ++++++++++++
>  drivers/virt/acrn/hypercall.h                 | 254 +++++++
>  drivers/virt/acrn/ioeventfd.c                 | 273 ++++++++
>  drivers/virt/acrn/ioreq.c                     | 645 ++++++++++++++++++
>  drivers/virt/acrn/irqfd.c                     | 235 +++++++
>  drivers/virt/acrn/mm.c                        | 305 +++++++++
>  drivers/virt/acrn/vm.c                        | 126 ++++
>  include/uapi/linux/acrn.h                     | 486 +++++++++++++
>  21 files changed, 3278 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/virt/acrn/index.rst
>  create mode 100644 Documentation/virt/acrn/introduction.rst
>  create mode 100644 Documentation/virt/acrn/io-request.rst
>  create mode 100644 arch/x86/include/asm/acrn.h
>  create mode 100644 drivers/virt/acrn/Kconfig
>  create mode 100644 drivers/virt/acrn/Makefile
>  create mode 100644 drivers/virt/acrn/acrn_drv.h
>  create mode 100644 drivers/virt/acrn/hsm.c
>  create mode 100644 drivers/virt/acrn/hypercall.h
>  create mode 100644 drivers/virt/acrn/ioeventfd.c
>  create mode 100644 drivers/virt/acrn/ioreq.c
>  create mode 100644 drivers/virt/acrn/irqfd.c
>  create mode 100644 drivers/virt/acrn/mm.c
>  create mode 100644 drivers/virt/acrn/vm.c
>  create mode 100644 include/uapi/linux/acrn.h
> 
> 
> base-commit: 18445bf405cb331117bc98427b1ba6f12418ad17
> 
