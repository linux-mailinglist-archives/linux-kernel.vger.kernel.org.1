Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6812E2B61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 12:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgLYLrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 06:47:36 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9690 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgLYLrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 06:47:35 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4D2QB83FS6zkvrG;
        Fri, 25 Dec 2020 19:45:52 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.9) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 25 Dec 2020 19:46:39 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ARM: LPAE: use phys_addr_t instead of unsigned long in outercache hooks
Date:   Fri, 25 Dec 2020 19:44:58 +0800
Message-ID: <20201225114458.1334-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The outercache of some Hisilicon SOCs support physical addresses wider
than 32-bits. The unsigned long datatype is not sufficient for mapping
physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
use phys_addr_t instead of unsigned long in outercache functions") has
already modified the outercache functions. But the parameters of the
outercache hooks are not changed. This patch use phys_addr_t instead of
unsigned long in outercache hooks: inv_range, clean_range, flush_range.

To ensure the outercache that does not support LPAE works properly, do
cast phys_addr_t to unsigned long by adding a middle-tier function.
For example:
-static void l2c220_inv_range(unsigned long start, unsigned long end)
+static void __l2c220_inv_range(unsigned long start, unsigned long end)
 {
 	...
 }
+static void l2c220_inv_range(phys_addr_t start, phys_addr_t end)
+{
+  __l2c220_inv_range(start, end);
+}

Note that the outercache functions have been doing this cast before this
patch. So now, the cast is just moved to the middle-tier function.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/include/asm/outercache.h |  6 +--
 arch/arm/mm/cache-feroceon-l2.c   | 21 ++++++++--
 arch/arm/mm/cache-l2x0.c          | 83 ++++++++++++++++++++++++++++++++-------
 arch/arm/mm/cache-tauros2.c       | 21 ++++++++--
 arch/arm/mm/cache-uniphier.c      |  6 +--
 arch/arm/mm/cache-xsc3l2.c        | 21 ++++++++--
 6 files changed, 129 insertions(+), 29 deletions(-)

diff --git a/arch/arm/include/asm/outercache.h b/arch/arm/include/asm/outercache.h
index 3364637755e86aa..4cee1ea0c15449a 100644
--- a/arch/arm/include/asm/outercache.h
+++ b/arch/arm/include/asm/outercache.h
@@ -14,9 +14,9 @@
 struct l2x0_regs;
 
 struct outer_cache_fns {
-	void (*inv_range)(unsigned long, unsigned long);
-	void (*clean_range)(unsigned long, unsigned long);
-	void (*flush_range)(unsigned long, unsigned long);
+	void (*inv_range)(phys_addr_t, phys_addr_t);
+	void (*clean_range)(phys_addr_t, phys_addr_t);
+	void (*flush_range)(phys_addr_t, phys_addr_t);
 	void (*flush_all)(void);
 	void (*disable)(void);
 #ifdef CONFIG_OUTER_CACHE_SYNC
diff --git a/arch/arm/mm/cache-feroceon-l2.c b/arch/arm/mm/cache-feroceon-l2.c
index 5c1b7a7b9af6300..ab1d8051bf832c9 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -168,7 +168,7 @@ static unsigned long calc_range_end(unsigned long start, unsigned long end)
 	return range_end;
 }
 
-static void feroceon_l2_inv_range(unsigned long start, unsigned long end)
+static void __feroceon_l2_inv_range(unsigned long start, unsigned long end)
 {
 	/*
 	 * Clean and invalidate partial first cache line.
@@ -198,7 +198,12 @@ static void feroceon_l2_inv_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void feroceon_l2_clean_range(unsigned long start, unsigned long end)
+static void feroceon_l2_inv_range(phys_addr_t start, phys_addr_t end)
+{
+	__feroceon_l2_inv_range(start, end);
+}
+
+static void __feroceon_l2_clean_range(unsigned long start, unsigned long end)
 {
 	/*
 	 * If L2 is forced to WT, the L2 will always be clean and we
@@ -217,7 +222,12 @@ static void feroceon_l2_clean_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void feroceon_l2_flush_range(unsigned long start, unsigned long end)
+static void feroceon_l2_clean_range(phys_addr_t start, phys_addr_t end)
+{
+	__feroceon_l2_clean_range(start, end);
+}
+
+static void __feroceon_l2_flush_range(unsigned long start, unsigned long end)
 {
 	start &= ~(CACHE_LINE_SIZE - 1);
 	end = (end + CACHE_LINE_SIZE - 1) & ~(CACHE_LINE_SIZE - 1);
@@ -232,6 +242,11 @@ static void feroceon_l2_flush_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
+static void feroceon_l2_flush_range(phys_addr_t start, phys_addr_t end)
+{
+	__feroceon_l2_flush_range(start, end);
+}
+
 
 /*
  * Routines to disable and re-enable the D-cache and I-cache at run
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 43d91bfd2360086..644d857dcbd6bf0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -184,7 +184,7 @@ static void __l2c210_op_pa_range(void __iomem *reg, unsigned long start,
 	}
 }
 
-static void l2c210_inv_range(unsigned long start, unsigned long end)
+static void __l2c210_inv_range(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
 
@@ -203,7 +203,12 @@ static void l2c210_inv_range(unsigned long start, unsigned long end)
 	__l2c210_cache_sync(base);
 }
 
-static void l2c210_clean_range(unsigned long start, unsigned long end)
+static void l2c210_inv_range(phys_addr_t start, phys_addr_t end)
+{
+	__l2c210_inv_range(start, end);
+}
+
+static void __l2c210_clean_range(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
 
@@ -212,7 +217,12 @@ static void l2c210_clean_range(unsigned long start, unsigned long end)
 	__l2c210_cache_sync(base);
 }
 
-static void l2c210_flush_range(unsigned long start, unsigned long end)
+static void l2c210_clean_range(phys_addr_t start, phys_addr_t end)
+{
+	__l2c210_clean_range(start, end);
+}
+
+static void __l2c210_flush_range(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
 
@@ -221,6 +231,11 @@ static void l2c210_flush_range(unsigned long start, unsigned long end)
 	__l2c210_cache_sync(base);
 }
 
+static void l2c210_flush_range(phys_addr_t start, phys_addr_t end)
+{
+	__l2c210_flush_range(start, end);
+}
+
 static void l2c210_flush_all(void)
 {
 	void __iomem *base = l2x0_base;
@@ -304,7 +319,7 @@ static unsigned long l2c220_op_pa_range(void __iomem *reg, unsigned long start,
 	return flags;
 }
 
-static void l2c220_inv_range(unsigned long start, unsigned long end)
+static void __l2c220_inv_range(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
@@ -331,7 +346,12 @@ static void l2c220_inv_range(unsigned long start, unsigned long end)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void l2c220_clean_range(unsigned long start, unsigned long end)
+static void l2c220_inv_range(phys_addr_t start, phys_addr_t end)
+{
+	__l2c220_inv_range(start, end);
+}
+
+static void __l2c220_clean_range(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
@@ -350,7 +370,12 @@ static void l2c220_clean_range(unsigned long start, unsigned long end)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void l2c220_flush_range(unsigned long start, unsigned long end)
+static void l2c220_clean_range(phys_addr_t start, phys_addr_t end)
+{
+	__l2c220_clean_range(start, end);
+}
+
+static void __l2c220_flush_range(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
@@ -369,6 +394,11 @@ static void l2c220_flush_range(unsigned long start, unsigned long end)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void l2c220_flush_range(phys_addr_t start, phys_addr_t end)
+{
+	__l2c220_flush_range(start, end);
+}
+
 static void l2c220_flush_all(void)
 {
 	l2c220_op_way(l2x0_base, L2X0_CLEAN_INV_WAY);
@@ -464,7 +494,7 @@ static void l2c220_unlock(void __iomem *base, unsigned num_lock)
  *	Affects: store buffer
  *	store buffer is not automatically drained.
  */
-static void l2c310_inv_range_erratum(unsigned long start, unsigned long end)
+static void __l2c310_inv_range_erratum(unsigned long start, unsigned long end)
 {
 	void __iomem *base = l2x0_base;
 
@@ -496,7 +526,12 @@ static void l2c310_inv_range_erratum(unsigned long start, unsigned long end)
 	__l2c210_cache_sync(base);
 }
 
-static void l2c310_flush_range_erratum(unsigned long start, unsigned long end)
+static void l2c310_inv_range_erratum(phys_addr_t start, phys_addr_t end)
+{
+	__l2c310_inv_range_erratum(start, end);
+}
+
+static void __l2c310_flush_range_erratum(unsigned long start, unsigned long end)
 {
 	raw_spinlock_t *lock = &l2x0_lock;
 	unsigned long flags;
@@ -523,6 +558,11 @@ static void l2c310_flush_range_erratum(unsigned long start, unsigned long end)
 	__l2c210_cache_sync(base);
 }
 
+static void l2c310_flush_range_erratum(phys_addr_t start, phys_addr_t end)
+{
+	__l2c310_flush_range_erratum(start, end);
+}
+
 static void l2c310_flush_all_erratum(void)
 {
 	void __iomem *base = l2x0_base;
@@ -1400,12 +1440,12 @@ static void aurora_pa_range(unsigned long start, unsigned long end,
 		start = range_end;
 	}
 }
-static void aurora_inv_range(unsigned long start, unsigned long end)
+static void aurora_inv_range(phys_addr_t start, phys_addr_t end)
 {
 	aurora_pa_range(start, end, AURORA_INVAL_RANGE_REG);
 }
 
-static void aurora_clean_range(unsigned long start, unsigned long end)
+static void aurora_clean_range(phys_addr_t start, phys_addr_t end)
 {
 	/*
 	 * If L2 is forced to WT, the L2 will always be clean and we
@@ -1415,7 +1455,7 @@ static void aurora_clean_range(unsigned long start, unsigned long end)
 		aurora_pa_range(start, end, AURORA_CLEAN_RANGE_REG);
 }
 
-static void aurora_flush_range(unsigned long start, unsigned long end)
+static void aurora_flush_range(phys_addr_t start, phys_addr_t end)
 {
 	if (l2_wt_override)
 		aurora_pa_range(start, end, AURORA_INVAL_RANGE_REG);
@@ -1604,7 +1644,7 @@ static inline unsigned long bcm_l2_phys_addr(unsigned long addr)
 		return addr + BCM_VC_EMI_OFFSET;
 }
 
-static void bcm_inv_range(unsigned long start, unsigned long end)
+static void __bcm_inv_range(unsigned long start, unsigned long end)
 {
 	unsigned long new_start, new_end;
 
@@ -1631,7 +1671,12 @@ static void bcm_inv_range(unsigned long start, unsigned long end)
 		new_end);
 }
 
-static void bcm_clean_range(unsigned long start, unsigned long end)
+static void bcm_inv_range(phys_addr_t start, phys_addr_t end)
+{
+	__bcm_inv_range(start, end);
+}
+
+static void __bcm_clean_range(unsigned long start, unsigned long end)
 {
 	unsigned long new_start, new_end;
 
@@ -1658,7 +1703,12 @@ static void bcm_clean_range(unsigned long start, unsigned long end)
 		new_end);
 }
 
-static void bcm_flush_range(unsigned long start, unsigned long end)
+static void bcm_clean_range(phys_addr_t start, phys_addr_t end)
+{
+	__bcm_clean_range(start, end);
+}
+
+static void __bcm_flush_range(unsigned long start, unsigned long end)
 {
 	unsigned long new_start, new_end;
 
@@ -1690,6 +1740,11 @@ static void bcm_flush_range(unsigned long start, unsigned long end)
 		new_end);
 }
 
+static void bcm_flush_range(phys_addr_t start, phys_addr_t end)
+{
+	__bcm_flush_range(start, end);
+}
+
 /* Broadcom L2C-310 start from ARMs R3P2 or later, and require no fixups */
 static const struct l2c_init_data of_bcm_l2x0_data __initconst = {
 	.type = "BCM-L2C-310",
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 88255bea65e41e6..145008d9f92690c 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -66,7 +66,7 @@ static inline void tauros2_inv_pa(unsigned long addr)
  */
 #define CACHE_LINE_SIZE		32
 
-static void tauros2_inv_range(unsigned long start, unsigned long end)
+static void __tauros2_inv_range(unsigned long start, unsigned long end)
 {
 	/*
 	 * Clean and invalidate partial first cache line.
@@ -95,7 +95,12 @@ static void tauros2_inv_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void tauros2_clean_range(unsigned long start, unsigned long end)
+static void tauros2_inv_range(phys_addr_t start, phys_addr_t end)
+{
+	__tauros2_inv_range(start, end);
+}
+
+static void __tauros2_clean_range(unsigned long start, unsigned long end)
 {
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
@@ -106,7 +111,12 @@ static void tauros2_clean_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void tauros2_flush_range(unsigned long start, unsigned long end)
+static void tauros2_clean_range(phys_addr_t start, phys_addr_t end)
+{
+	__tauros2_clean_range(start, end);
+}
+
+static void __tauros2_flush_range(unsigned long start, unsigned long end)
 {
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
@@ -117,6 +127,11 @@ static void tauros2_flush_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
+static void tauros2_flush_range(phys_addr_t start, phys_addr_t end)
+{
+	__tauros2_flush_range(start, end);
+}
+
 static void tauros2_disable(void)
 {
 	__asm__ __volatile__ (
diff --git a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
index ff2881458504329..e2508358e9f4082 100644
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -250,17 +250,17 @@ static void uniphier_cache_maint_all(u32 operation)
 		__uniphier_cache_maint_all(data, operation);
 }
 
-static void uniphier_cache_inv_range(unsigned long start, unsigned long end)
+static void uniphier_cache_inv_range(phys_addr_t start, phys_addr_t end)
 {
 	uniphier_cache_maint_range(start, end, UNIPHIER_SSCOQM_CM_INV);
 }
 
-static void uniphier_cache_clean_range(unsigned long start, unsigned long end)
+static void uniphier_cache_clean_range(phys_addr_t start, phys_addr_t end)
 {
 	uniphier_cache_maint_range(start, end, UNIPHIER_SSCOQM_CM_CLEAN);
 }
 
-static void uniphier_cache_flush_range(unsigned long start, unsigned long end)
+static void uniphier_cache_flush_range(phys_addr_t start, phys_addr_t end)
 {
 	uniphier_cache_maint_range(start, end, UNIPHIER_SSCOQM_CM_FLUSH);
 }
diff --git a/arch/arm/mm/cache-xsc3l2.c b/arch/arm/mm/cache-xsc3l2.c
index d20d7af02d10fc0..095a9a125174502 100644
--- a/arch/arm/mm/cache-xsc3l2.c
+++ b/arch/arm/mm/cache-xsc3l2.c
@@ -83,7 +83,7 @@ static inline unsigned long l2_map_va(unsigned long pa, unsigned long prev_va)
 #endif
 }
 
-static void xsc3_l2_inv_range(unsigned long start, unsigned long end)
+static void __xsc3_l2_inv_range(unsigned long start, unsigned long end)
 {
 	unsigned long vaddr;
 
@@ -127,7 +127,12 @@ static void xsc3_l2_inv_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void xsc3_l2_clean_range(unsigned long start, unsigned long end)
+static void xsc3_l2_inv_range(phys_addr_t start, phys_addr_t end)
+{
+	__xsc3_l2_inv_range(start, end);
+}
+
+static void __xsc3_l2_clean_range(unsigned long start, unsigned long end)
 {
 	unsigned long vaddr;
 
@@ -145,6 +150,11 @@ static void xsc3_l2_clean_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
+static void xsc3_l2_clean_range(phys_addr_t start, phys_addr_t end)
+{
+	__xsc3_l2_clean_range(start, end);
+}
+
 /*
  * optimize L2 flush all operation by set/way format
  */
@@ -165,7 +175,7 @@ static inline void xsc3_l2_flush_all(void)
 	dsb();
 }
 
-static void xsc3_l2_flush_range(unsigned long start, unsigned long end)
+static void __xsc3_l2_flush_range(unsigned long start, unsigned long end)
 {
 	unsigned long vaddr;
 
@@ -189,6 +199,11 @@ static void xsc3_l2_flush_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
+static void xsc3_l2_flush_range(phys_addr_t start, phys_addr_t end)
+{
+	__xsc3_l2_flush_range(start, end);
+}
+
 static int __init xsc3_l2_init(void)
 {
 	if (!cpu_is_xsc3() || !xsc3_l2_present())
-- 
1.8.3


