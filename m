Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215852F8AFF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 04:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbhAPDcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 22:32:11 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11027 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbhAPDcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 22:32:01 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHk875Psmzj7Qk;
        Sat, 16 Jan 2021 11:30:15 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 16 Jan 2021 11:31:09 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        "Haojian Zhuang" <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v5 1/4] ARM: LPAE: Use phys_addr_t instead of unsigned long in outercache hooks
Date:   Sat, 16 Jan 2021 11:27:37 +0800
Message-ID: <20210116032740.873-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210116032740.873-1-thunder.leizhen@huawei.com>
References: <20210116032740.873-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.176.220]
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
cast phys_addr_t to unsigned long by adding a group of temporary
variables. For example:
-static void l2c220_inv_range(unsigned long start, unsigned long end)
+static void l2c220_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;

Note that the outercache functions have been doing this cast before this
patch. So now, the cast is just moved into the outercache hook functions.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/include/asm/outercache.h |  6 ++--
 arch/arm/mm/cache-feroceon-l2.c   | 15 ++++++++--
 arch/arm/mm/cache-l2x0.c          | 50 ++++++++++++++++++++++---------
 arch/arm/mm/cache-tauros2.c       | 15 ++++++++--
 arch/arm/mm/cache-uniphier.c      |  6 ++--
 arch/arm/mm/cache-xsc3l2.c        | 12 ++++++--
 6 files changed, 75 insertions(+), 29 deletions(-)

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
index 5c1b7a7b9af6300..10f909744d5e963 100644
--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -168,8 +168,11 @@ static unsigned long calc_range_end(unsigned long start, unsigned long end)
 	return range_end;
 }
 
-static void feroceon_l2_inv_range(unsigned long start, unsigned long end)
+static void feroceon_l2_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
+
 	/*
 	 * Clean and invalidate partial first cache line.
 	 */
@@ -198,8 +201,11 @@ static void feroceon_l2_inv_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void feroceon_l2_clean_range(unsigned long start, unsigned long end)
+static void feroceon_l2_clean_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
+
 	/*
 	 * If L2 is forced to WT, the L2 will always be clean and we
 	 * don't need to do anything here.
@@ -217,8 +223,11 @@ static void feroceon_l2_clean_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void feroceon_l2_flush_range(unsigned long start, unsigned long end)
+static void feroceon_l2_flush_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
+
 	start &= ~(CACHE_LINE_SIZE - 1);
 	end = (end + CACHE_LINE_SIZE - 1) & ~(CACHE_LINE_SIZE - 1);
 	while (start != end) {
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 43d91bfd2360086..cdaddd772b09ede 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -184,8 +184,10 @@ static void __l2c210_op_pa_range(void __iomem *reg, unsigned long start,
 	}
 }
 
-static void l2c210_inv_range(unsigned long start, unsigned long end)
+static void l2c210_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	void __iomem *base = l2x0_base;
 
 	if (start & (CACHE_LINE_SIZE - 1)) {
@@ -203,8 +205,10 @@ static void l2c210_inv_range(unsigned long start, unsigned long end)
 	__l2c210_cache_sync(base);
 }
 
-static void l2c210_clean_range(unsigned long start, unsigned long end)
+static void l2c210_clean_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	void __iomem *base = l2x0_base;
 
 	start &= ~(CACHE_LINE_SIZE - 1);
@@ -212,8 +216,10 @@ static void l2c210_clean_range(unsigned long start, unsigned long end)
 	__l2c210_cache_sync(base);
 }
 
-static void l2c210_flush_range(unsigned long start, unsigned long end)
+static void l2c210_flush_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	void __iomem *base = l2x0_base;
 
 	start &= ~(CACHE_LINE_SIZE - 1);
@@ -304,8 +310,10 @@ static unsigned long l2c220_op_pa_range(void __iomem *reg, unsigned long start,
 	return flags;
 }
 
-static void l2c220_inv_range(unsigned long start, unsigned long end)
+static void l2c220_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
@@ -331,8 +339,10 @@ static void l2c220_inv_range(unsigned long start, unsigned long end)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void l2c220_clean_range(unsigned long start, unsigned long end)
+static void l2c220_clean_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
@@ -350,8 +360,10 @@ static void l2c220_clean_range(unsigned long start, unsigned long end)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-static void l2c220_flush_range(unsigned long start, unsigned long end)
+static void l2c220_flush_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	void __iomem *base = l2x0_base;
 	unsigned long flags;
 
@@ -464,8 +476,10 @@ static const struct l2c_init_data l2c220_data = {
  *	Affects: store buffer
  *	store buffer is not automatically drained.
  */
-static void l2c310_inv_range_erratum(unsigned long start, unsigned long end)
+static void l2c310_inv_range_erratum(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	void __iomem *base = l2x0_base;
 
 	if ((start | end) & (CACHE_LINE_SIZE - 1)) {
@@ -496,8 +510,10 @@ static void l2c310_inv_range_erratum(unsigned long start, unsigned long end)
 	__l2c210_cache_sync(base);
 }
 
-static void l2c310_flush_range_erratum(unsigned long start, unsigned long end)
+static void l2c310_flush_range_erratum(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	raw_spinlock_t *lock = &l2x0_lock;
 	unsigned long flags;
 	void __iomem *base = l2x0_base;
@@ -1400,12 +1416,12 @@ static void aurora_pa_range(unsigned long start, unsigned long end,
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
@@ -1415,7 +1431,7 @@ static void aurora_clean_range(unsigned long start, unsigned long end)
 		aurora_pa_range(start, end, AURORA_CLEAN_RANGE_REG);
 }
 
-static void aurora_flush_range(unsigned long start, unsigned long end)
+static void aurora_flush_range(phys_addr_t start, phys_addr_t end)
 {
 	if (l2_wt_override)
 		aurora_pa_range(start, end, AURORA_INVAL_RANGE_REG);
@@ -1604,8 +1620,10 @@ static inline unsigned long bcm_l2_phys_addr(unsigned long addr)
 		return addr + BCM_VC_EMI_OFFSET;
 }
 
-static void bcm_inv_range(unsigned long start, unsigned long end)
+static void bcm_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	unsigned long new_start, new_end;
 
 	BUG_ON(start < BCM_SYS_EMI_START_ADDR);
@@ -1631,8 +1649,10 @@ static void bcm_inv_range(unsigned long start, unsigned long end)
 		new_end);
 }
 
-static void bcm_clean_range(unsigned long start, unsigned long end)
+static void bcm_clean_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	unsigned long new_start, new_end;
 
 	BUG_ON(start < BCM_SYS_EMI_START_ADDR);
@@ -1658,8 +1678,10 @@ static void bcm_clean_range(unsigned long start, unsigned long end)
 		new_end);
 }
 
-static void bcm_flush_range(unsigned long start, unsigned long end)
+static void bcm_flush_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	unsigned long new_start, new_end;
 
 	BUG_ON(start < BCM_SYS_EMI_START_ADDR);
diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 88255bea65e41e6..d768bbb5e05c690 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -66,8 +66,11 @@ static inline void tauros2_inv_pa(unsigned long addr)
  */
 #define CACHE_LINE_SIZE		32
 
-static void tauros2_inv_range(unsigned long start, unsigned long end)
+static void tauros2_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
+
 	/*
 	 * Clean and invalidate partial first cache line.
 	 */
@@ -95,8 +98,11 @@ static void tauros2_inv_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void tauros2_clean_range(unsigned long start, unsigned long end)
+static void tauros2_clean_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
+
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
 		tauros2_clean_pa(start);
@@ -106,8 +112,11 @@ static void tauros2_clean_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void tauros2_flush_range(unsigned long start, unsigned long end)
+static void tauros2_flush_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
+
 	start &= ~(CACHE_LINE_SIZE - 1);
 	while (start < end) {
 		tauros2_clean_inv_pa(start);
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
index d20d7af02d10fc0..5814731653d9091 100644
--- a/arch/arm/mm/cache-xsc3l2.c
+++ b/arch/arm/mm/cache-xsc3l2.c
@@ -83,8 +83,10 @@ static inline unsigned long l2_map_va(unsigned long pa, unsigned long prev_va)
 #endif
 }
 
-static void xsc3_l2_inv_range(unsigned long start, unsigned long end)
+static void xsc3_l2_inv_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	unsigned long vaddr;
 
 	if (start == 0 && end == -1ul) {
@@ -127,8 +129,10 @@ static void xsc3_l2_inv_range(unsigned long start, unsigned long end)
 	dsb();
 }
 
-static void xsc3_l2_clean_range(unsigned long start, unsigned long end)
+static void xsc3_l2_clean_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	unsigned long vaddr;
 
 	vaddr = -1;  /* to force the first mapping */
@@ -165,8 +169,10 @@ static inline void xsc3_l2_flush_all(void)
 	dsb();
 }
 
-static void xsc3_l2_flush_range(unsigned long start, unsigned long end)
+static void xsc3_l2_flush_range(phys_addr_t pa_start, phys_addr_t pa_end)
 {
+	unsigned long start = pa_start;
+	unsigned long end = pa_end;
 	unsigned long vaddr;
 
 	if (start == 0 && end == -1ul) {
-- 
2.26.0.106.g9fadedd


