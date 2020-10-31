Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AA92A1406
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 08:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgJaHjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 03:39:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6683 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgJaHjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 03:39:17 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CNWJz45YZz15PLx;
        Sat, 31 Oct 2020 15:39:15 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 31 Oct 2020 15:39:06 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <bhsharma@redhat.com>, <prabhakar.pkin@gmail.com>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <chenzhou10@huawei.com>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>,
        John Donnelly <John.p.donnelly@oracle.com>
Subject: [PATCH v13 7/8] arm64: kdump: add memory for devices by DT property linux,usable-memory-range
Date:   Sat, 31 Oct 2020 15:44:36 +0800
Message-ID: <20201031074437.168008-8-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201031074437.168008-1-chenzhou10@huawei.com>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reserving crashkernel in high memory, some low memory is reserved
for crash dump kernel devices and never mapped by the first kernel.
This memory range is advertised to crash dump kernel via DT property
under /chosen,
	linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>

We reused the DT property linux,usable-memory-range and made the low
memory region as the second range "BASE2 SIZE2", which keeps compatibility
with existing user-space and older kdump kernels.

Crash dump kernel reads this property at boot time and call memblock_add()
to add the low memory region after memblock_cap_memory_range() has been
called.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
---
 arch/arm64/mm/init.c | 43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 888c4f7eadc3..794f992cb200 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -69,6 +69,15 @@ static void __init reserve_crashkernel(void)
 }
 #endif
 
+/*
+ * The main usage of linux,usable-memory-range is for crash dump kernel.
+ * Originally, the number of usable-memory regions is one. Now there may
+ * be two regions, low region and high region.
+ * To make compatibility with existing user-space and older kdump, the low
+ * region is always the last range of linux,usable-memory-range if exist.
+ */
+#define MAX_USABLE_RANGES	2
+
 #ifdef CONFIG_CRASH_DUMP
 static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
 		const char *uname, int depth, void *data)
@@ -184,9 +193,9 @@ early_param("mem", early_mem);
 static int __init early_init_dt_scan_usablemem(unsigned long node,
 		const char *uname, int depth, void *data)
 {
-	struct memblock_region *usablemem = data;
-	const __be32 *reg;
-	int len;
+	struct memblock_region *usable_rgns = data;
+	const __be32 *reg, *endp;
+	int len, nr = 0;
 
 	if (depth != 1 || strcmp(uname, "chosen") != 0)
 		return 0;
@@ -195,22 +204,36 @@ static int __init early_init_dt_scan_usablemem(unsigned long node,
 	if (!reg || (len < (dt_root_addr_cells + dt_root_size_cells)))
 		return 1;
 
-	usablemem->base = dt_mem_next_cell(dt_root_addr_cells, &reg);
-	usablemem->size = dt_mem_next_cell(dt_root_size_cells, &reg);
+	endp = reg + (len / sizeof(__be32));
+	while ((endp - reg) >= (dt_root_addr_cells + dt_root_size_cells)) {
+		usable_rgns[nr].base = dt_mem_next_cell(dt_root_addr_cells, &reg);
+		usable_rgns[nr].size = dt_mem_next_cell(dt_root_size_cells, &reg);
+
+		if (++nr >= MAX_USABLE_RANGES)
+			break;
+	}
 
 	return 1;
 }
 
 static void __init fdt_enforce_memory_region(void)
 {
-	struct memblock_region reg = {
-		.size = 0,
+	struct memblock_region usable_rgns[MAX_USABLE_RANGES] = {
+		{ .size = 0 },
+		{ .size = 0 }
 	};
 
-	of_scan_flat_dt(early_init_dt_scan_usablemem, &reg);
+	of_scan_flat_dt(early_init_dt_scan_usablemem, &usable_rgns);
 
-	if (reg.size)
-		memblock_cap_memory_range(reg.base, reg.size);
+	/*
+	 * The first range of usable-memory regions is for crash dump
+	 * kernel with only one region or for high region with two regions,
+	 * the second range is dedicated for low region if exist.
+	 */
+	if (usable_rgns[0].size)
+		memblock_cap_memory_range(usable_rgns[0].base, usable_rgns[0].size);
+	if (usable_rgns[1].size)
+		memblock_add(usable_rgns[1].base, usable_rgns[1].size);
 }
 
 void __init arm64_memblock_init(void)
-- 
2.20.1

