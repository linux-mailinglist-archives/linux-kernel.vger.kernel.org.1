Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F163C213265
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 05:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgGCDx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 23:53:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6813 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725915AbgGCDx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:53:57 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CDE8C5EF4ABF00F4FB22;
        Fri,  3 Jul 2020 11:53:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Jul 2020 11:53:47 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <nsaenzjulienne@suse.de>, <corbet@lwn.net>, <bhsharma@redhat.com>,
        <horms@verge.net.au>
CC:     <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH v10 0/5] support reserving crashkernel above 4G on arm64 kdump
Date:   Fri, 3 Jul 2020 11:58:11 +0800
Message-ID: <20200703035816.31289-1-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enable reserving crashkernel above 4G in arm64.

There are following issues in arm64 kdump:
1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
when there is no enough low memory.
2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
in this case, if swiotlb or DMA buffers are required, crash dump kernel
will boot failure because there is no low memory available for allocation.
3. commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32") broken
the arm64 kdump. If the memory reserved for crash dump kernel falled in
ZONE_DMA32, the devices in crash dump kernel need to use ZONE_DMA will alloc
fail.

To solve these issues, introduce crashkernel=X,low to reserve specified
size low memory.
Crashkernel=X tries to reserve memory for the crash dump kernel under
4G. If crashkernel=Y,low is specified simultaneously, reserve spcified
size low memory for crash kdump kernel devices firstly and then reserve
memory above 4G.

When crashkernel is reserved above 4G in memory and crashkernel=X,low
is specified simultaneously, kernel should reserve specified size low memory
for crash dump kernel devices. So there may be two crash kernel regions, one
is below 4G, the other is above 4G.
In order to distinct from the high region and make no effect to the use of
kexec-tools, rename the low region as "Crash kernel (low)", and pass the
low region by reusing DT property "linux,usable-memory-range". We made the low
memory region as the last range of "linux,usable-memory-range" to keep
compatibility with existing user-space and older kdump kernels.

Besides, we need to modify kexec-tools:
arm64: support more than one crash kernel regions(see [1])

Another update is document about DT property 'linux,usable-memory-range':
schemas: update 'linux,usable-memory-range' node schema(see [2])

The previous changes and discussions can be retrieved from:

Changes since [v9]
- Patch 1 add Acked-by from Dave.
- Update patch 5 according to Dave's comments.
- Update chosen schema.

Changes since [v8]
- Reuse DT property "linux,usable-memory-range".
Suggested by Rob, reuse DT property "linux,usable-memory-range" to pass the low
memory region.
- Fix kdump broken with ZONE_DMA reintroduced.
- Update chosen schema.

Changes since [v7]
- Move x86 CRASH_ALIGN to 2M
Suggested by Dave and do some test, move x86 CRASH_ALIGN to 2M.
- Update Documentation/devicetree/bindings/chosen.txt.
Add corresponding documentation to Documentation/devicetree/bindings/chosen.txt
suggested by Arnd.
- Add Tested-by from Jhon and pk.

Changes since [v6]
- Fix build errors reported by kbuild test robot.

Changes since [v5]
- Move reserve_crashkernel_low() into kernel/crash_core.c.
- Delete crashkernel=X,high.
- Modify crashkernel=X,low.
If crashkernel=X,low is specified simultaneously, reserve spcified size low
memory for crash kdump kernel devices firstly and then reserve memory above 4G.
In addition, rename crashk_low_res as "Crash kernel (low)" for arm64, and then
pass to crash dump kernel by DT property "linux,low-memory-range".
- Update Documentation/admin-guide/kdump/kdump.rst.

Changes since [v4]
- Reimplement memblock_cap_memory_ranges for multiple ranges by Mike.

Changes since [v3]
- Add memblock_cap_memory_ranges back for multiple ranges.
- Fix some compiling warnings.

Changes since [v2]
- Split patch "arm64: kdump: support reserving crashkernel above 4G" as
two. Put "move reserve_crashkernel_low() into kexec_core.c" in a separate
patch.

Changes since [v1]:
- Move common reserve_crashkernel_low() code into kernel/kexec_core.c.
- Remove memblock_cap_memory_ranges() i added in v1 and implement that
in fdt_enforce_memory_region().
There are at most two crash kernel regions, for two crash kernel regions
case, we cap the memory range [min(regs[*].start), max(regs[*].end)]
and then remove the memory range in the middle.

[1]: http://lists.infradead.org/pipermail/kexec/2020-June/020737.html
[2]: https://github.com/robherring/dt-schema/pull/19 
[v1]: https://lkml.org/lkml/2019/4/2/1174
[v2]: https://lkml.org/lkml/2019/4/9/86
[v3]: https://lkml.org/lkml/2019/4/9/306
[v4]: https://lkml.org/lkml/2019/4/15/273
[v5]: https://lkml.org/lkml/2019/5/6/1360
[v6]: https://lkml.org/lkml/2019/8/30/142
[v7]: https://lkml.org/lkml/2019/12/23/411
[v8]: https://lkml.org/lkml/2020/5/21/213
[v9]: https://lkml.org/lkml/2020/6/28/73

Chen Zhou (5):
  x86: kdump: move reserve_crashkernel_low() into crash_core.c
  arm64: kdump: reserve crashkenel above 4G for crash dump kernel
  arm64: kdump: add memory for devices by DT property
    linux,usable-memory-range
  arm64: kdump: fix kdump broken with ZONE_DMA reintroduced
  kdump: update Documentation about crashkernel on arm64

 Documentation/admin-guide/kdump/kdump.rst     | 14 ++-
 .../admin-guide/kernel-parameters.txt         | 17 +++-
 arch/arm64/kernel/setup.c                     |  8 +-
 arch/arm64/mm/init.c                          | 74 ++++++++++++---
 arch/x86/kernel/setup.c                       | 66 ++------------
 include/linux/crash_core.h                    |  3 +
 include/linux/kexec.h                         |  2 -
 kernel/crash_core.c                           | 90 +++++++++++++++++++
 kernel/kexec_core.c                           | 17 ----
 9 files changed, 197 insertions(+), 94 deletions(-)

-- 
2.20.1

