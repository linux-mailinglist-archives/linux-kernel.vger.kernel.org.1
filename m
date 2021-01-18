Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD47E2FAD57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 23:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbhARWcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 17:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbhARWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 17:32:10 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2603C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=5OB6dnbruF3yPyoZOK1PjkIG4Zqcs77HK1bNpumiVbo=; b=aI6GvslNozNk19WIThDWEBHcML
        BDx8Q22YLxQpyGELPOPMz4C/V6HY/4QuJKVhhguO0gbkxzIIggBxkG8Gn0AbdvgVck1LFX38DaGd2
        l2r9UB+0zYMZv9aRQW0gMMtd4iJaAbLKcJBtDQ409kpXcxClNZ84HdU5/vhZAKKKItId/Av9Tx8Vk
        GIESlFmOky+PoxXx1xOTIPgr7AXW5lm82XEGW/PTdHA6HYNogslJCqpJgu4dlMyukRF8Fy1/40x1n
        fet2PdNnsTPN5tEoyTQ1sq/IGED/LCPYTeu6pEZ6yj2QhReox4kw8ohpUEFS2td5j1UL2FMO5VR5I
        o7xPUvSA==;
Received: from [2601:1c0:6280:3f0::9abc]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l1d35-0003ly-T6; Mon, 18 Jan 2021 22:31:00 +0000
Subject: Re: [PATCH v7 01/18] docs: acrn: Introduce ACRN
To:     shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sen Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
 <20210106075055.47226-2-shuo.a.liu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <33ff89ab-db2d-ed9c-3632-014870a1c238@infradead.org>
Date:   Mon, 18 Jan 2021 14:30:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210106075055.47226-2-shuo.a.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/5/21 11:50 PM, shuo.a.liu@intel.com wrote:
> From: Shuo Liu <shuo.a.liu@intel.com>
> 
> Add documentation on the following aspects of ACRN:
> 
>   1) A brief introduction on the architecture of ACRN.
>   2) I/O request handling in ACRN.
>   3) CPUID functions of ACRN.
> 
> To learn more about ACRN, please go to ACRN project website
> https://projectacrn.org, or the documentation page
> https://projectacrn.github.io/.
> 
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Borislav Petkov <bp@suse.de>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Sen Christopherson <sean.j.christopherson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Fengwei Yin <fengwei.yin@intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Yu Wang <yu1.wang@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/virt/acrn/cpuid.rst        | 46 +++++++++++
>  Documentation/virt/acrn/index.rst        | 12 +++
>  Documentation/virt/acrn/introduction.rst | 43 +++++++++++
>  Documentation/virt/acrn/io-request.rst   | 97 ++++++++++++++++++++++++
>  Documentation/virt/index.rst             |  1 +
>  MAINTAINERS                              |  7 ++
>  6 files changed, 206 insertions(+)
>  create mode 100644 Documentation/virt/acrn/cpuid.rst
>  create mode 100644 Documentation/virt/acrn/index.rst
>  create mode 100644 Documentation/virt/acrn/introduction.rst
>  create mode 100644 Documentation/virt/acrn/io-request.rst
> 
> diff --git a/Documentation/virt/acrn/cpuid.rst b/Documentation/virt/acrn/cpuid.rst
> new file mode 100644
> index 000000000000..16727fc412f0
> --- /dev/null
> +++ b/Documentation/virt/acrn/cpuid.rst
> @@ -0,0 +1,46 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +ACRN CPUID bits
> +===============
> +
> +A guest VM running on an ACRN hypervisor, can check some of its features using

comma not needed/not wanted.

> +CPUID.
> +
> +ACRN cpuid functions are:
> +
> +function: 0x40000000
> +
> +returns::
> +
> +   eax = 0x40000010
> +   ebx = 0x4e524341
> +   ecx = 0x4e524341
> +   edx = 0x4e524341
> +
> +Note that this value in ebx, ecx and edx corresponds to the string
> +"ACRNACRNACRN". The value in eax corresponds to the maximum cpuid function
> +present in this leaf, and will be updated if more functions are added in the

except for the 0x4000000 bit?

> +future.
> +
> +function: define ACRN_CPUID_FEATURES (0x40000001)
> +
> +returns::
> +
> +          ebx, ecx, edx
> +          eax = an OR'ed group of (1 << flag)
> +
> +where ``flag`` is defined as below:
> +
> +================================= =========== ================================
> +flag                              value       meaning
> +================================= =========== ================================
> +ACRN_FEATURE_PRIVILEGED_VM        0           guest VM is a privileged VM
> +================================= =========== ================================
> +
> +function: 0x40000010
> +
> +returns::
> +
> +          ebx, ecx, edx
> +          eax = (Virtual) TSC frequency in kHz.
> diff --git a/Documentation/virt/acrn/index.rst b/Documentation/virt/acrn/index.rst
> new file mode 100644
> index 000000000000..b5f793e73df5
> --- /dev/null
> +++ b/Documentation/virt/acrn/index.rst
> @@ -0,0 +1,12 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===============
> +ACRN Hypervisor
> +===============
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   introduction
> +   io-request
> +   cpuid
> diff --git a/Documentation/virt/acrn/introduction.rst b/Documentation/virt/acrn/introduction.rst
> new file mode 100644
> index 000000000000..f8d081bc084d
> --- /dev/null
> +++ b/Documentation/virt/acrn/introduction.rst
> @@ -0,0 +1,43 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +ACRN Hypervisor Introduction
> +============================
> +
> +The ACRN Hypervisor is a Type 1 hypervisor, running directly on bare-metal
> +hardware. It has a privileged management VM, called Service VM, to manage User
> +VMs and do I/O emulation.
> +
> +ACRN userspace is an application running in the Service VM that emulates
> +devices for a User VM based on command line configurations. ACRN Hypervisor
> +Service Module (HSM) is a kernel module in the Service VM which provides
> +hypervisor services to the ACRN userspace.
> +
> +Below figure shows the architecture.
> +
> +::
> +
> +                Service VM                    User VM
> +      +----------------------------+  |  +------------------+
> +      |        +--------------+    |  |  |                  |
> +      |        |ACRN userspace|    |  |  |                  |
> +      |        +--------------+    |  |  |                  |
> +      |-----------------ioctl------|  |  |                  |   ...
> +      |kernel space   +----------+ |  |  |                  |
> +      |               |   HSM    | |  |  | Drivers          |
> +      |               +----------+ |  |  |                  |
> +      +--------------------|-------+  |  +------------------+
> +  +---------------------hypercall----------------------------------------+
> +  |                         ACRN Hypervisor                              |
> +  +----------------------------------------------------------------------+
> +  |                          Hardware                                    |
> +  +----------------------------------------------------------------------+
> +
> +ACRN userspace allocates memory for the User VM, configures and initializes the
> +devices used by the User VM, loads the virtual bootloader, initializes the
> +virtual CPU state and handles I/O request accesses from the User VM. It uses
> +ioctls to communicate with the HSM. HSM implements hypervisor services by
> +interacting with the ACRN Hypervisor via hypercalls. HSM exports a char device
> +interface (/dev/acrn_hsm) to userspace.
> +
> +The ACRN hypervisor is open for contribution from anyone. The source repo is
> +available at https://github.com/projectacrn/acrn-hypervisor.
> diff --git a/Documentation/virt/acrn/io-request.rst b/Documentation/virt/acrn/io-request.rst
> new file mode 100644
> index 000000000000..79022a671ea7
> --- /dev/null
> +++ b/Documentation/virt/acrn/io-request.rst
> @@ -0,0 +1,97 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +I/O request handling
> +====================
> +
> +An I/O request of a User VM, which is constructed by the hypervisor, is
> +distributed by the ACRN Hypervisor Service Module to an I/O client
> +corresponding to the address range of the I/O request. Details of I/O request
> +handling are described in the following sections.
> +
> +1. I/O request
> +--------------
> +
> +For each User VM, there is a shared 4-KByte memory region used for I/O requests
> +communication between the hypervisor and Service VM. An I/O request is a
> +256-byte structure buffer, which is 'struct acrn_io_request', that is filled by
> +an I/O handler of the hypervisor when a trapped I/O access happens in a User
> +VM. ACRN userspace in the Service VM first allocates a 4-KByte page and passes
> +the GPA (Guest Physical Address) of the buffer to the hypervisor. The buffer is
> +used as an array of 16 I/O request slots with each I/O request slot being 256
> +bytes. This array is indexed by vCPU ID.
> +
> +2. I/O clients
> +--------------
> +
> +An I/O client is responsible for handling User VM I/O requests whose accessed
> +GPA falls in a certain range. Multiple I/O clients can be associated with each
> +User VM. There is a special client associated with each User VM, called the
> +default client, that handles all I/O requests that do not fit into the range of
> +any other clients. The ACRN userspace acts as the default client for each User
> +VM.
> +
> +Below illustration shows the relationship between I/O requests shared buffer,
> +I/O requests and I/O clients.
> +
> +::
> +
> +     +------------------------------------------------------+
> +     |                                       Service VM     |
> +     |+--------------------------------------------------+  |
> +     ||      +----------------------------------------+  |  |
> +     ||      | shared page            ACRN userspace  |  |  |
> +     ||      |    +-----------------+  +------------+ |  |  |
> +     ||   +----+->| acrn_io_request |<-+  default   | |  |  |
> +     ||   |  | |  +-----------------+  | I/O client | |  |  |
> +     ||   |  | |  |       ...       |  +------------+ |  |  |
> +     ||   |  | |  +-----------------+                 |  |  |
> +     ||   |  +-|--------------------------------------+  |  |
> +     ||---|----|-----------------------------------------|  |
> +     ||   |    |                             kernel      |  |
> +     ||   |    |            +----------------------+     |  |
> +     ||   |    |            | +-------------+  HSM |     |  |
> +     ||   |    +--------------+             |      |     |  |
> +     ||   |                 | | I/O clients |      |     |  |
> +     ||   |                 | |             |      |     |  |
> +     ||   |                 | +-------------+      |     |  |
> +     ||   |                 +----------------------+     |  |
> +     |+---|----------------------------------------------+  |
> +     +----|-------------------------------------------------+
> +          |
> +     +----|-------------------------------------------------+
> +     |  +-+-----------+                                     |
> +     |  | I/O handler |              ACRN Hypervisor        |
> +     |  +-------------+                                     |
> +     +------------------------------------------------------+
> +
> +3. I/O request state transition
> +-------------------------------
> +
> +The state transitions of an ACRN I/O request are as follows.
> +
> +::
> +
> +   FREE -> PENDING -> PROCESSING -> COMPLETE -> FREE -> ...
> +
> +- FREE: this I/O request slot is empty
> +- PENDING: a valid I/O request is pending in this slot
> +- PROCESSING: the I/O request is being processed
> +- COMPLETE: the I/O request has been processed
> +
> +An I/O request in COMPLETE or FREE state is owned by the hypervisor. HSM and
> +ACRN userspace are in charge of processing the others.
> +
> +4. Processing flow of I/O requests
> +-------------------------------

add 3 more '-' above, please.

> +
> +a. The I/O handler of the hypervisor will fill an I/O request with PENDING
> +   state when a trapped I/O access happens in a User VM.
> +b. The hypervisor makes an upcall, which is a notification interrupt, to
> +   the Service VM.
> +c. The upcall handler schedules a tasklet to dispatch I/O requests.
> +d. The tasklet looks for the PENDING I/O requests, assigns them to different
> +   registered clients based on the address of the I/O accesses, updates
> +   their state to PROCESSING, and notifies the corresponding client to handle.
> +e. The notified client handles the assigned I/O requests.
> +f. The HSM updates I/O requests states to COMPLETE and notifies the hypervisor
> +   of the completion via hypercalls.
> diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
> index 350f5c869b56..edea7fea95a8 100644
> --- a/Documentation/virt/index.rst
> +++ b/Documentation/virt/index.rst
> @@ -12,6 +12,7 @@ Linux Virtualization Support
>     paravirt_ops
>     guest-halt-polling
>     ne_overview
> +   acrn/index
>  
>  .. only:: html and subproject

thanks for the docs.

-- 
~Randy
You can't do anything without having to do something else first.
-- Belefant's Law
