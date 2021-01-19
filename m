Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3995B2FAE5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 02:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392212AbhASBhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 20:37:08 -0500
Received: from mga06.intel.com ([134.134.136.31]:46604 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729202AbhASBhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 20:37:05 -0500
IronPort-SDR: AbVkaheUr/xHEwHVy2k7ZKLIbsLwfu+1y5VDH+ek8HfO0KSWMovMRlukR6l5BRQDifjD6za/FO
 GbnXp9gDYEdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="240405321"
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="240405321"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 17:36:24 -0800
IronPort-SDR: 2gyO3qQfL+vvI06qtcL6hY5xcI+DVuNdyofOeMg3kn0vXpg+Z3ZdvoF38ykX0E7Hz8oPVae1dx
 PWz68wuF+jdA==
X-IronPort-AV: E=Sophos;i="5.79,357,1602572400"; 
   d="scan'208";a="383741805"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 17:36:18 -0800
Date:   Tue, 19 Jan 2021 09:36:15 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: Re: [PATCH v7 01/18] docs: acrn: Introduce ACRN
Message-ID: <20210119013615.GG22447@shuo-intel.sh.intel.com>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
 <20210106075055.47226-2-shuo.a.liu@intel.com>
 <33ff89ab-db2d-ed9c-3632-014870a1c238@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <33ff89ab-db2d-ed9c-3632-014870a1c238@infradead.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

Thanks for review.

On Mon 18.Jan'21 at 14:30:51 -0800, Randy Dunlap wrote:
>On 1/5/21 11:50 PM, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> Add documentation on the following aspects of ACRN:
>>
>>   1) A brief introduction on the architecture of ACRN.
>>   2) I/O request handling in ACRN.
>>   3) CPUID functions of ACRN.
>>
>> To learn more about ACRN, please go to ACRN project website
>> https://projectacrn.org, or the documentation page
>> https://projectacrn.github.io/.
>>
>> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> Reviewed-by: Zhi Wang <zhi.a.wang@intel.com>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Reviewed-by: Borislav Petkov <bp@suse.de>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Sen Christopherson <sean.j.christopherson@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Fengwei Yin <fengwei.yin@intel.com>
>> Cc: Zhi Wang <zhi.a.wang@intel.com>
>> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> Cc: Yu Wang <yu1.wang@intel.com>
>> Cc: Reinette Chatre <reinette.chatre@intel.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>  Documentation/virt/acrn/cpuid.rst        | 46 +++++++++++
>>  Documentation/virt/acrn/index.rst        | 12 +++
>>  Documentation/virt/acrn/introduction.rst | 43 +++++++++++
>>  Documentation/virt/acrn/io-request.rst   | 97 ++++++++++++++++++++++++
>>  Documentation/virt/index.rst             |  1 +
>>  MAINTAINERS                              |  7 ++
>>  6 files changed, 206 insertions(+)
>>  create mode 100644 Documentation/virt/acrn/cpuid.rst
>>  create mode 100644 Documentation/virt/acrn/index.rst
>>  create mode 100644 Documentation/virt/acrn/introduction.rst
>>  create mode 100644 Documentation/virt/acrn/io-request.rst
>>
>> diff --git a/Documentation/virt/acrn/cpuid.rst b/Documentation/virt/acrn/cpuid.rst
>> new file mode 100644
>> index 000000000000..16727fc412f0
>> --- /dev/null
>> +++ b/Documentation/virt/acrn/cpuid.rst
>> @@ -0,0 +1,46 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===============
>> +ACRN CPUID bits
>> +===============
>> +
>> +A guest VM running on an ACRN hypervisor, can check some of its features using
>
>comma not needed/not wanted.

Removed.

>
>> +CPUID.
>> +
>> +ACRN cpuid functions are:
>> +
>> +function: 0x40000000
>> +
>> +returns::
>> +
>> +   eax = 0x40000010
>> +   ebx = 0x4e524341
>> +   ecx = 0x4e524341
>> +   edx = 0x4e524341
>> +
>> +Note that this value in ebx, ecx and edx corresponds to the string
>> +"ACRNACRNACRN". The value in eax corresponds to the maximum cpuid function
>> +present in this leaf, and will be updated if more functions are added in the
>
>except for the 0x4000000 bit?

It's the maximum cpuid function value. So it's 0x40000010.

>
>> +future.
>> +
>> +function: define ACRN_CPUID_FEATURES (0x40000001)
>> +
>> +returns::
>> +
>> +          ebx, ecx, edx
>> +          eax = an OR'ed group of (1 << flag)
>> +
>> +where ``flag`` is defined as below:
>> +
>> +================================= =========== ================================
>> +flag                              value       meaning
>> +================================= =========== ================================
>> +ACRN_FEATURE_PRIVILEGED_VM        0           guest VM is a privileged VM
>> +================================= =========== ================================
>> +
>> +function: 0x40000010
>> +
>> +returns::
>> +
>> +          ebx, ecx, edx
>> +          eax = (Virtual) TSC frequency in kHz.
>> diff --git a/Documentation/virt/acrn/index.rst b/Documentation/virt/acrn/index.rst
>> new file mode 100644
>> index 000000000000..b5f793e73df5
>> --- /dev/null
>> +++ b/Documentation/virt/acrn/index.rst
>> @@ -0,0 +1,12 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +===============
>> +ACRN Hypervisor
>> +===============
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>> +   introduction
>> +   io-request
>> +   cpuid
>> diff --git a/Documentation/virt/acrn/introduction.rst b/Documentation/virt/acrn/introduction.rst
>> new file mode 100644
>> index 000000000000..f8d081bc084d
>> --- /dev/null
>> +++ b/Documentation/virt/acrn/introduction.rst
>> @@ -0,0 +1,43 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +ACRN Hypervisor Introduction
>> +============================
>> +
>> +The ACRN Hypervisor is a Type 1 hypervisor, running directly on bare-metal
>> +hardware. It has a privileged management VM, called Service VM, to manage User
>> +VMs and do I/O emulation.
>> +
>> +ACRN userspace is an application running in the Service VM that emulates
>> +devices for a User VM based on command line configurations. ACRN Hypervisor
>> +Service Module (HSM) is a kernel module in the Service VM which provides
>> +hypervisor services to the ACRN userspace.
>> +
>> +Below figure shows the architecture.
>> +
>> +::
>> +
>> +                Service VM                    User VM
>> +      +----------------------------+  |  +------------------+
>> +      |        +--------------+    |  |  |                  |
>> +      |        |ACRN userspace|    |  |  |                  |
>> +      |        +--------------+    |  |  |                  |
>> +      |-----------------ioctl------|  |  |                  |   ...
>> +      |kernel space   +----------+ |  |  |                  |
>> +      |               |   HSM    | |  |  | Drivers          |
>> +      |               +----------+ |  |  |                  |
>> +      +--------------------|-------+  |  +------------------+
>> +  +---------------------hypercall----------------------------------------+
>> +  |                         ACRN Hypervisor                              |
>> +  +----------------------------------------------------------------------+
>> +  |                          Hardware                                    |
>> +  +----------------------------------------------------------------------+
>> +
>> +ACRN userspace allocates memory for the User VM, configures and initializes the
>> +devices used by the User VM, loads the virtual bootloader, initializes the
>> +virtual CPU state and handles I/O request accesses from the User VM. It uses
>> +ioctls to communicate with the HSM. HSM implements hypervisor services by
>> +interacting with the ACRN Hypervisor via hypercalls. HSM exports a char device
>> +interface (/dev/acrn_hsm) to userspace.
>> +
>> +The ACRN hypervisor is open for contribution from anyone. The source repo is
>> +available at https://github.com/projectacrn/acrn-hypervisor.
>> diff --git a/Documentation/virt/acrn/io-request.rst b/Documentation/virt/acrn/io-request.rst
>> new file mode 100644
>> index 000000000000..79022a671ea7
>> --- /dev/null
>> +++ b/Documentation/virt/acrn/io-request.rst
>> @@ -0,0 +1,97 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +I/O request handling
>> +====================
>> +
>> +An I/O request of a User VM, which is constructed by the hypervisor, is
>> +distributed by the ACRN Hypervisor Service Module to an I/O client
>> +corresponding to the address range of the I/O request. Details of I/O request
>> +handling are described in the following sections.
>> +
>> +1. I/O request
>> +--------------
>> +
>> +For each User VM, there is a shared 4-KByte memory region used for I/O requests
>> +communication between the hypervisor and Service VM. An I/O request is a
>> +256-byte structure buffer, which is 'struct acrn_io_request', that is filled by
>> +an I/O handler of the hypervisor when a trapped I/O access happens in a User
>> +VM. ACRN userspace in the Service VM first allocates a 4-KByte page and passes
>> +the GPA (Guest Physical Address) of the buffer to the hypervisor. The buffer is
>> +used as an array of 16 I/O request slots with each I/O request slot being 256
>> +bytes. This array is indexed by vCPU ID.
>> +
>> +2. I/O clients
>> +--------------
>> +
>> +An I/O client is responsible for handling User VM I/O requests whose accessed
>> +GPA falls in a certain range. Multiple I/O clients can be associated with each
>> +User VM. There is a special client associated with each User VM, called the
>> +default client, that handles all I/O requests that do not fit into the range of
>> +any other clients. The ACRN userspace acts as the default client for each User
>> +VM.
>> +
>> +Below illustration shows the relationship between I/O requests shared buffer,
>> +I/O requests and I/O clients.
>> +
>> +::
>> +
>> +     +------------------------------------------------------+
>> +     |                                       Service VM     |
>> +     |+--------------------------------------------------+  |
>> +     ||      +----------------------------------------+  |  |
>> +     ||      | shared page            ACRN userspace  |  |  |
>> +     ||      |    +-----------------+  +------------+ |  |  |
>> +     ||   +----+->| acrn_io_request |<-+  default   | |  |  |
>> +     ||   |  | |  +-----------------+  | I/O client | |  |  |
>> +     ||   |  | |  |       ...       |  +------------+ |  |  |
>> +     ||   |  | |  +-----------------+                 |  |  |
>> +     ||   |  +-|--------------------------------------+  |  |
>> +     ||---|----|-----------------------------------------|  |
>> +     ||   |    |                             kernel      |  |
>> +     ||   |    |            +----------------------+     |  |
>> +     ||   |    |            | +-------------+  HSM |     |  |
>> +     ||   |    +--------------+             |      |     |  |
>> +     ||   |                 | | I/O clients |      |     |  |
>> +     ||   |                 | |             |      |     |  |
>> +     ||   |                 | +-------------+      |     |  |
>> +     ||   |                 +----------------------+     |  |
>> +     |+---|----------------------------------------------+  |
>> +     +----|-------------------------------------------------+
>> +          |
>> +     +----|-------------------------------------------------+
>> +     |  +-+-----------+                                     |
>> +     |  | I/O handler |              ACRN Hypervisor        |
>> +     |  +-------------+                                     |
>> +     +------------------------------------------------------+
>> +
>> +3. I/O request state transition
>> +-------------------------------
>> +
>> +The state transitions of an ACRN I/O request are as follows.
>> +
>> +::
>> +
>> +   FREE -> PENDING -> PROCESSING -> COMPLETE -> FREE -> ...
>> +
>> +- FREE: this I/O request slot is empty
>> +- PENDING: a valid I/O request is pending in this slot
>> +- PROCESSING: the I/O request is being processed
>> +- COMPLETE: the I/O request has been processed
>> +
>> +An I/O request in COMPLETE or FREE state is owned by the hypervisor. HSM and
>> +ACRN userspace are in charge of processing the others.
>> +
>> +4. Processing flow of I/O requests
>> +-------------------------------
>
>add 3 more '-' above, please.

Sure. Thanks.

shuo
