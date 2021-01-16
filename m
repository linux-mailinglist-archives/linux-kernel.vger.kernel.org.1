Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4FC2F8AFA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 04:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbhAPDcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 22:32:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11028 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbhAPDcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 22:32:01 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DHk87620yzj7ZC;
        Sat, 16 Jan 2021 11:30:15 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.176.220) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 16 Jan 2021 11:31:12 +0800
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
Subject: [PATCH v5 4/4] ARM: Add support for Hisilicon Kunpeng L3 cache controller
Date:   Sat, 16 Jan 2021 11:27:40 +0800
Message-ID: <20210116032740.873-5-thunder.leizhen@huawei.com>
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

Add support for the Hisilicon Kunpeng L3 cache controller as used with
Kunpeng506 and Kunpeng509 SoCs.

These Hisilicon SoCs support LPAE, so the physical addresses is wider than
32-bits, but the actual bit width does not exceed 36 bits. When the cache
operation is performed based on the address range, the upper 30 bits of
the physical address are recorded in registers L3_MAINT_START and
L3_MAINT_END, and ignore the lower 6 bits cacheline offset.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 arch/arm/mm/Kconfig            |  10 +++
 arch/arm/mm/Makefile           |   1 +
 arch/arm/mm/cache-kunpeng-l3.c | 153 +++++++++++++++++++++++++++++++++
 arch/arm/mm/cache-kunpeng-l3.h |  30 +++++++
 4 files changed, 194 insertions(+)
 create mode 100644 arch/arm/mm/cache-kunpeng-l3.c
 create mode 100644 arch/arm/mm/cache-kunpeng-l3.h

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 02692fbe2db5c59..d2082503de053d2 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1070,6 +1070,16 @@ config CACHE_XSC3L2
 	help
 	  This option enables the L2 cache on XScale3.
 
+config CACHE_KUNPENG_L3
+	bool "Enable the Hisilicon Kunpeng L3 cache controller"
+	depends on ARCH_KUNPENG50X && OF
+	default y
+	select OUTER_CACHE
+	help
+	  This option enables the Kunpeng L3 cache controller on Hisilicon
+	  Kunpeng506 and Kunpeng509 SoCs. It supports a maximum of 36-bit
+	  physical addresses.
+
 config ARM_L1_CACHE_SHIFT_6
 	bool
 	default y if CPU_V7
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index 3510503bc5e688b..ececc5489e353eb 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -112,6 +112,7 @@ obj-$(CONFIG_CACHE_L2X0_PMU)	+= cache-l2x0-pmu.o
 obj-$(CONFIG_CACHE_XSC3L2)	+= cache-xsc3l2.o
 obj-$(CONFIG_CACHE_TAUROS2)	+= cache-tauros2.o
 obj-$(CONFIG_CACHE_UNIPHIER)	+= cache-uniphier.o
+obj-$(CONFIG_CACHE_KUNPENG_L3)	+= cache-kunpeng-l3.o
 
 KASAN_SANITIZE_kasan_init.o	:= n
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm/mm/cache-kunpeng-l3.c b/arch/arm/mm/cache-kunpeng-l3.c
new file mode 100644
index 000000000000000..cb81f15d26a0cf2
--- /dev/null
+++ b/arch/arm/mm/cache-kunpeng-l3.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Hisilicon Limited.
+ */
+
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/io.h>
+#include <linux/of_address.h>
+
+#include <asm/cacheflush.h>
+
+#include "cache-kunpeng-l3.h"
+
+static DEFINE_SPINLOCK(l3cache_lock);
+static void __iomem *l3_ctrl_base;
+
+
+static void l3cache_maint_common(u32 range, u32 op_type)
+{
+	u32 reg;
+
+	reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
+	reg &= ~(L3_MAINT_RANGE_MASK | L3_MAINT_TYPE_MASK);
+	reg |= range | op_type;
+	reg |= L3_MAINT_STATUS_START;
+	writel(reg, l3_ctrl_base + L3_MAINT_CTRL);
+
+	/* Wait until the hardware maintenance operation is complete. */
+	do {
+		cpu_relax();
+		reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
+	} while ((reg & L3_MAINT_STATUS_MASK) != L3_MAINT_STATUS_END);
+}
+
+static void l3cache_maint_range(phys_addr_t start, phys_addr_t end, u32 op_type)
+{
+	start = start >> L3_CACHE_LINE_SHITF;
+	end = ((end - 1) >> L3_CACHE_LINE_SHITF) + 1;
+
+	writel(start, l3_ctrl_base + L3_MAINT_START);
+	writel(end, l3_ctrl_base + L3_MAINT_END);
+
+	l3cache_maint_common(L3_MAINT_RANGE_ADDR, op_type);
+}
+
+static inline void l3cache_flush_all_nolock(void)
+{
+	l3cache_maint_common(L3_MAINT_RANGE_ALL, L3_MAINT_TYPE_FLUSH);
+}
+
+static void l3cache_flush_all(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&l3cache_lock, flags);
+	l3cache_flush_all_nolock();
+	spin_unlock_irqrestore(&l3cache_lock, flags);
+}
+
+static void l3cache_inv_range(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&l3cache_lock, flags);
+	l3cache_maint_range(start, end, L3_MAINT_TYPE_INV);
+	spin_unlock_irqrestore(&l3cache_lock, flags);
+}
+
+static void l3cache_clean_range(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&l3cache_lock, flags);
+	l3cache_maint_range(start, end, L3_MAINT_TYPE_CLEAN);
+	spin_unlock_irqrestore(&l3cache_lock, flags);
+}
+
+static void l3cache_flush_range(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&l3cache_lock, flags);
+	l3cache_maint_range(start, end, L3_MAINT_TYPE_FLUSH);
+	spin_unlock_irqrestore(&l3cache_lock, flags);
+}
+
+static void l3cache_disable(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&l3cache_lock, flags);
+	l3cache_flush_all_nolock();
+	writel(L3_CTRL_DISABLE, l3_ctrl_base + L3_CTRL);
+	spin_unlock_irqrestore(&l3cache_lock, flags);
+}
+
+static const struct of_device_id l3cache_ids[] __initconst = {
+	{.compatible = "hisilicon,kunpeng-l3cache", .data = NULL},
+	{}
+};
+
+static int __init l3cache_init(void)
+{
+	u32 reg;
+	struct device_node *node;
+
+	node = of_find_matching_node(NULL, l3cache_ids);
+	if (!node)
+		return -ENODEV;
+
+	l3_ctrl_base = of_iomap(node, 0);
+	if (!l3_ctrl_base) {
+		pr_err("failed to map Kunpeng L3 cache controller registers\n");
+		return -ENOMEM;
+	}
+
+	reg = readl(l3_ctrl_base + L3_CTRL);
+	if (!(reg & L3_CTRL_ENABLE)) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&l3cache_lock, flags);
+
+		/*
+		 * Ensure that no L3 cache hardware maintenance operations are
+		 * being performed before enabling the L3 cache. Wait for it to
+		 * finish.
+		 */
+		do {
+			cpu_relax();
+			reg = readl(l3_ctrl_base + L3_MAINT_CTRL);
+		} while ((reg & L3_MAINT_STATUS_MASK) != L3_MAINT_STATUS_END);
+
+		reg = readl(l3_ctrl_base + L3_AUCTRL);
+		reg |= L3_AUCTRL_EVENT_EN | L3_AUCTRL_ECC_EN;
+		writel(reg, l3_ctrl_base + L3_AUCTRL);
+
+		writel(L3_CTRL_ENABLE, l3_ctrl_base + L3_CTRL);
+
+		spin_unlock_irqrestore(&l3cache_lock, flags);
+	}
+
+	outer_cache.inv_range = l3cache_inv_range;
+	outer_cache.clean_range = l3cache_clean_range;
+	outer_cache.flush_range = l3cache_flush_range;
+	outer_cache.flush_all = l3cache_flush_all;
+	outer_cache.disable = l3cache_disable;
+
+	pr_info("Hisilicon Kunpeng L3 cache controller enabled\n");
+
+	return 0;
+}
+arch_initcall(l3cache_init);
diff --git a/arch/arm/mm/cache-kunpeng-l3.h b/arch/arm/mm/cache-kunpeng-l3.h
new file mode 100644
index 000000000000000..9ef6a53e7d4db49
--- /dev/null
+++ b/arch/arm/mm/cache-kunpeng-l3.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __CACHE_KUNPENG_L3_H
+#define __CACHE_KUNPENG_L3_H
+
+#define L3_CACHE_LINE_SHITF		6
+
+#define L3_CTRL				0x0
+#define L3_CTRL_ENABLE			(1U << 0)
+#define L3_CTRL_DISABLE			(0U << 0)
+
+#define L3_AUCTRL			0x4
+#define L3_AUCTRL_EVENT_EN		BIT(23)
+#define L3_AUCTRL_ECC_EN		BIT(8)
+
+#define L3_MAINT_CTRL			0x20
+#define L3_MAINT_RANGE_MASK		GENMASK(3, 3)
+#define L3_MAINT_RANGE_ALL		(0U << 3)
+#define L3_MAINT_RANGE_ADDR		(1U << 3)
+#define L3_MAINT_TYPE_MASK		GENMASK(2, 1)
+#define L3_MAINT_TYPE_CLEAN		(1U << 1)
+#define L3_MAINT_TYPE_INV		(2U << 1)
+#define L3_MAINT_TYPE_FLUSH		(3U << 1)
+#define L3_MAINT_STATUS_MASK		GENMASK(0, 0)
+#define L3_MAINT_STATUS_START		(1U << 0)
+#define L3_MAINT_STATUS_END		(0U << 0)
+
+#define L3_MAINT_START			0x24
+#define L3_MAINT_END			0x28
+
+#endif
-- 
2.26.0.106.g9fadedd


