Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74DC3269F7F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgIOHRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:17:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12260 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726062AbgIOHRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:17:05 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7EDE4213A5CEF33B6F5B;
        Tue, 15 Sep 2020 15:17:00 +0800 (CST)
Received: from [10.174.176.220] (10.174.176.220) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 15:16:53 +0800
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
 kdump
To:     <catalin.marinas@arm.com>, <dyoung@redhat.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
CC:     <will@kernel.org>, <james.morse@arm.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bhe@redhat.com>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <bhsharma@redhat.com>, <horms@verge.net.au>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <nsaenzjulienne@suse.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <05b1fdbb-5bb3-1345-14ac-9bf91df16aa4@huawei.com>
Date:   Tue, 15 Sep 2020 15:16:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200907134745.25732-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/7 21:47, Chen Zhou wrote:
> There are following issues in arm64 kdump:
> 1. We use crashkernel=X to reserve crashkernel below 4G, which
> will fail when there is no enough low memory.
> 2. If reserving crashkernel above 4G, in this case, crash dump
> kernel will boot failure because there is no low memory available
> for allocation.
> 3. Since commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32"),
> if the memory reserved for crash dump kernel falled in ZONE_DMA32,
> the devices in crash dump kernel need to use ZONE_DMA will alloc
> fail.
>
> To solve these issues, change the behavior of crashkernel=X.
> crashkernel=X tries low allocation in DMA zone, and fall back to
> high allocation if it fails.
> If requized size X is too large and leads to very little low memory
> in DMA zone after low allocation, the system may not work normally.
> So add a threshold and go for high allocation directly if the required
> size is too large. The value of threshold is set as the half of
> the low memory.
>
> We can also use "crashkernel=X,high" to select a high region above
> DMA zone, which also tries to allocate at least 256M low memory in
> DMA zone automatically.
> "crashkernel=Y,low" can be used to allocate specified size low memory.
> For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.
>
> When reserving crashkernel in high memory, some low memory is reserved
> for crash dump kernel devices. So there may be two regions reserved for
> crash dump kernel.
> In order to distinct from the high region and make no effect to the use
> of existing kexec-tools, rename the low region as "Crash kernel (low)",
> and pass the low region by reusing DT property
> "linux,usable-memory-range". We made the low memory region as the last
> range of "linux,usable-memory-range" to keep compatibility with existing
> user-space and older kdump kernels.
>
> Besides, we need to modify kexec-tools:
> arm64: support more than one crash kernel regions(see [1])
>
> Another update is document about DT property 'linux,usable-memory-range':
> schemas: update 'linux,usable-memory-range' node schema(see [2])
>
> This patchset contains the following nine patches:
> 0001-x86-kdump-move-CRASH_ALIGN-to-2M.patch
> 0002-x86-kdump-make-the-lower-bound-of-crash-kernel-reser.patch
> 0003-x86-kdump-use-macro-CRASH_ADDR_LOW_MAX-in-functions-.patch
> 0004-x86-kdump-move-reserve_crashkernel-_low-into-crash_c.patch
> 0005-arm64-kdump-introduce-some-macroes-for-crash-kernel-.patch
> 0006-arm64-kdump-reimplement-crashkernel-X.patch
> 0007-kdump-add-threshold-for-the-required-memory.patch
> 0008-arm64-kdump-add-memory-for-devices-by-DT-property-li.patch
> 0009-kdump-update-Documentation-about-crashkernel.patch
>
> 0001-0003 are some x86 cleanups which prepares for making
> functionsreserve_crashkernel[_low]() generic.
>
> 0004 makes functions reserve_crashkernel[_low]() generic.
> 0005-0006 reimplements crashkernel=X.
> 0007 adds threshold for the required memory.
> 0008 adds memory for devices by DT property linux,usable-memory-range.
> 0009 updates the doc.
Hi Catalin and Dave,

Any other suggestions about this patchset? Let me know if you have any questions.

Thanks,
Chen Zhou
>
> Changes since [v11]
> - Rebased on top of 5.9-rc4.
> - Make the function reserve_crashkernel() of x86 generic.
> Suggested by Catalin, make the function reserve_crashkernel() of x86 generic
> and arm64 use the generic version to reimplement crashkernel=X.
>
> Changes since [v10]
> - Reimplement crashkernel=X suggested by Catalin, Many thanks to Catalin.
>
> Changes since [v9]
> - Patch 1 add Acked-by from Dave.
> - Update patch 5 according to Dave's comments.
> - Update chosen schema.
>
> Changes since [v8]
> - Reuse DT property "linux,usable-memory-range".
> Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
> memory region.
> - Fix kdump broken with ZONE_DMA reintroduced.
> - Update chosen schema.
>
> Changes since [v7]
> - Move x86 CRASH_ALIGN to 2M
> Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
> - Update Documentation/devicetree/bindings/chosen.txt.
> Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
> suggested by Arnd.
> - Add Tested-by from Jhon and pk.
>
> Changes since [v6]
> - Fix build errors reported by kbuild test robot.
>
> Changes since [v5]
> - Move reserve_crashkernel_low() into kernel/crash_core.c.
> - Delete crashkernel=X,high.
> - Modify crashkernel=X,low.
> If crashkernel=X,low is specified simultaneously, reserve spcified size low
> memory for crash kdump kernel devices firstly and then reserve memory above 4G.
> In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
> pass to crash dump kernel by DT property "linux,low-memory-range".
> - Update Documentation/admin-guide/kdump/kdump.rst.
>
> Changes since [v4]
> - Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.
>
> Changes since [v3]
> - Add memblock_cap_memory_ranges back for multiple ranges.
> - Fix some compiling warnings.
>
> Changes since [v2]
> - Split patch "arm64: kdump: support reserving crashkernel above 4G" as
> two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
> patch.
>
> Changes since [v1]:
> - Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
> - Remove memblock_cap_memory_ranges() i added in v1 and implement that
> in fdt_enforce_memory_region().
> There are at most two crash kernel regions, for two crash kernel regions
> case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
> and then remove the memory range in the middle.
>
> [1]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html
> [2]: https://github.com/robherring/dt-schema/pull/19 
> [v1]: https://lkml.org/lkml/2019/4/2/1174
> [v2]: https://lkml.org/lkml/2019/4/9/86
> [v3]: https://lkml.org/lkml/2019/4/9/306
> [v4]: https://lkml.org/lkml/2019/4/15/273
> [v5]: https://lkml.org/lkml/2019/5/6/1360
> [v6]: https://lkml.org/lkml/2019/8/30/142
> [v7]: https://lkml.org/lkml/2019/12/23/411
> [v8]: https://lkml.org/lkml/2020/5/21/213
> [v9]: https://lkml.org/lkml/2020/6/28/73
> [v10]: https://lkml.org/lkml/2020/7/2/1443
> [v11]: https://lkml.org/lkml/2020/8/1/150
>
> Chen Zhou (9):
>   x86: kdump: move CRASH_ALIGN to 2M
>   x86: kdump: make the lower bound of crash kernel reservation
>     consistent
>   x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
>     reserve_crashkernel[_low]()
>   x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
>   arm64: kdump: introduce some macroes for crash kernel reservation
>   arm64: kdump: reimplement crashkernel=X
>   kdump: add threshold for the required memory
>   arm64: kdump: add memory for devices by DT property
>     linux,usable-memory-range
>   kdump: update Documentation about crashkernel
>
>  Documentation/admin-guide/kdump/kdump.rst     |  25 ++-
>  .../admin-guide/kernel-parameters.txt         |  13 +-
>  arch/arm64/include/asm/kexec.h                |  15 ++
>  arch/arm64/include/asm/processor.h            |   1 +
>  arch/arm64/kernel/setup.c                     |  13 +-
>  arch/arm64/mm/init.c                          | 105 ++++------
>  arch/arm64/mm/mmu.c                           |   4 +
>  arch/x86/include/asm/kexec.h                  |  28 +++
>  arch/x86/kernel/setup.c                       | 165 +--------------
>  include/linux/crash_core.h                    |   4 +
>  include/linux/kexec.h                         |   2 -
>  kernel/crash_core.c                           | 192 ++++++++++++++++++
>  kernel/kexec_core.c                           |  17 --
>  13 files changed, 328 insertions(+), 256 deletions(-)
>

