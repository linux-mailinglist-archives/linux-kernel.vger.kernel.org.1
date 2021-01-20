Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 407ED2FCE4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732929AbhATKU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730340AbhATKLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 05:11:38 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3950EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 02:10:58 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2AS0-00EMcY-Cm
        for linux-kernel@vger.kernel.org; Wed, 20 Jan 2021 11:10:56 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2ARg-00EMZO-44; Wed, 20 Jan 2021 11:10:36 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l2ARf-000zqn-KS; Wed, 20 Jan 2021 11:10:35 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v3 2/2] irqchip: Add support for Realtek RTL838x/RTL839x interrupt controller
Date:   Wed, 20 Jan 2021 11:10:18 +0100
Message-Id: <20210120101018.237693-3-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120101018.237693-1-bert@biot.com>
References: <20210120101018.237693-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 drivers/irqchip/Makefile          |   1 +
 drivers/irqchip/irq-realtek-rtl.c | 180 ++++++++++++++++++++++++++++++
 2 files changed, 181 insertions(+)
 create mode 100644 drivers/irqchip/irq-realtek-rtl.c

diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0ac93bfaec61..4fc1086bed7e 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -113,3 +113,4 @@ obj-$(CONFIG_LOONGSON_PCH_PIC)		+= irq-loongson-pch-pic.o
 obj-$(CONFIG_LOONGSON_PCH_MSI)		+= irq-loongson-pch-msi.o
 obj-$(CONFIG_MST_IRQ)			+= irq-mst-intc.o
 obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
+obj-$(CONFIG_MACH_REALTEK_RTL)		+= irq-realtek-rtl.o
diff --git a/drivers/irqchip/irq-realtek-rtl.c b/drivers/irqchip/irq-realtek-rtl.c
new file mode 100644
index 000000000000..bafe9ee4a85a
--- /dev/null
+++ b/drivers/irqchip/irq-realtek-rtl.c
@@ -0,0 +1,180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2006-2012 Tony Wu <tonywu@realtek.com>
+ * Copyright (C) 2020 Birger Koblitz <mail@birger-koblitz.de>
+ * Copyright (C) 2020 Bert Vermeulen <bert@biot.com>
+ * Copyright (C) 2020 John Crispin <john@phrozen.org>
+ */
+
+#include <linux/of_irq.h>
+#include <linux/irqchip.h>
+#include <linux/spinlock.h>
+#include <linux/of_address.h>
+#include <linux/irqchip/chained_irq.h>
+
+/* Global Interrupt Mask Register */
+#define RTL_ICTL_GIMR		0x00
+/* Global Interrupt Status Register */
+#define RTL_ICTL_GISR		0x04
+/* Interrupt Routing Registers */
+#define RTL_ICTL_IRR0		0x08
+#define RTL_ICTL_IRR1		0x0c
+#define RTL_ICTL_IRR2		0x10
+#define RTL_ICTL_IRR3		0x14
+
+#define REG(x)		(realtek_ictl_base + x)
+
+static DEFINE_RAW_SPINLOCK(irq_lock);
+static void __iomem *realtek_ictl_base;
+
+static void realtek_ictl_unmask_irq(struct irq_data *i)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&irq_lock, flags);
+
+	value = readl(REG(RTL_ICTL_GIMR));
+	value |= BIT(i->hwirq);
+	writel(value, REG(RTL_ICTL_GIMR));
+
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+}
+
+static void realtek_ictl_mask_irq(struct irq_data *i)
+{
+	unsigned long flags;
+	u32 value;
+
+	raw_spin_lock_irqsave(&irq_lock, flags);
+
+	value = readl(REG(RTL_ICTL_GIMR));
+	value &= ~BIT(i->hwirq);
+	writel(value, REG(RTL_ICTL_GIMR));
+
+	raw_spin_unlock_irqrestore(&irq_lock, flags);
+}
+
+static struct irq_chip realtek_ictl_irq = {
+	.name = "realtek-rtl-intc",
+	.irq_mask = realtek_ictl_mask_irq,
+	.irq_unmask = realtek_ictl_unmask_irq,
+};
+
+static int intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(hw, &realtek_ictl_irq, handle_level_irq);
+
+	return 0;
+}
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.map = intc_map,
+	.xlate = irq_domain_xlate_onecell,
+};
+
+static void realtek_irq_dispatch(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irq_domain *domain;
+	unsigned int pending;
+
+	chained_irq_enter(chip, desc);
+	pending = readl(REG(RTL_ICTL_GIMR)) & readl(REG(RTL_ICTL_GISR));
+	if (unlikely(!pending)) {
+		spurious_interrupt();
+		goto out;
+	}
+	domain = irq_desc_get_handler_data(desc);
+	generic_handle_irq(irq_find_mapping(domain, __ffs(pending)));
+
+out:
+	chained_irq_exit(chip, desc);
+}
+
+/*
+ * SoC interrupts are cascaded to MIPS CPU interrupts according to the
+ * interrupt-map in the device tree. Each SoC interrupt gets 4 bits for
+ * the CPU interrupt in an Interrupt Routing Register. Max 32 SoC interrupts
+ * thus go into 4 IRRs.
+ */
+static int __init map_interrupts(struct device_node *node)
+{
+	struct device_node *cpu_ictl;
+	const __be32 *imap;
+	u32 imaplen, soc_int, cpu_int, tmp, regs[4];
+	int ret, i, irr_regs[] = {
+		RTL_ICTL_IRR3,
+		RTL_ICTL_IRR2,
+		RTL_ICTL_IRR1,
+		RTL_ICTL_IRR0,
+	};
+
+	ret = of_property_read_u32(node, "#address-cells", &tmp);
+	if (ret || tmp)
+		return -EINVAL;
+
+	imap = of_get_property(node, "interrupt-map", &imaplen);
+	if (!imap || imaplen % 3)
+		return -EINVAL;
+
+	memset(regs, 0, sizeof(regs));
+	for (i = 0; i < imaplen; i += 3 * sizeof(u32)) {
+		soc_int = be32_to_cpup(imap);
+		if (soc_int > 31)
+			return -EINVAL;
+
+		cpu_ictl = of_find_node_by_phandle(be32_to_cpup(imap + 1));
+		if (!cpu_ictl)
+			return -EINVAL;
+		ret = of_property_read_u32(cpu_ictl, "#interrupt-cells", &tmp);
+		if (ret || tmp != 1)
+			return -EINVAL;
+		of_node_put(cpu_ictl);
+
+		cpu_int = be32_to_cpup(imap + 2);
+		if (cpu_int > 7)
+			return -EINVAL;
+
+		regs[(soc_int * 4) / 32] |= cpu_int << (soc_int * 4) % 32;
+		imap += 3;
+	}
+
+	for (i = 0; i < 4; i++)
+		writel(regs[i], REG(irr_regs[i]));
+
+	return 0;
+}
+
+static int __init realtek_rtl_of_init(struct device_node *node, struct device_node *parent)
+{
+	struct irq_domain *domain;
+	int ret;
+
+	domain = irq_domain_add_simple(node, 32, 0,
+				       &irq_domain_ops, NULL);
+	irq_set_chained_handler_and_data(2, realtek_irq_dispatch, domain);
+	irq_set_chained_handler_and_data(3, realtek_irq_dispatch, domain);
+	irq_set_chained_handler_and_data(4, realtek_irq_dispatch, domain);
+	irq_set_chained_handler_and_data(5, realtek_irq_dispatch, domain);
+
+	realtek_ictl_base = of_iomap(node, 0);
+	if (!realtek_ictl_base)
+		return -ENXIO;
+
+	/* Disable all cascaded interrupts */
+	writel(0, REG(RTL_ICTL_GIMR));
+
+	ret = map_interrupts(node);
+	if (ret) {
+		pr_err("invalid interrupt map\n");
+		return ret;
+	}
+
+	/* Clear timer interrupt */
+	write_c0_compare(0);
+
+	return 0;
+}
+
+IRQCHIP_DECLARE(realtek_rtl_intc, "realtek,rtl-intc", realtek_rtl_of_init);
-- 
2.25.1

