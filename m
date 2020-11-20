Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E12BB0C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgKTQlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:41:20 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:58185 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730075AbgKTQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:41:20 -0500
Received: from localhost (lfbn-lyo-1-1010-39.w86-194.abo.wanadoo.fr [86.194.86.39])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 07F65200010;
        Fri, 20 Nov 2020 16:41:16 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v4 3/6] irqchip: ocelot: prepare to support more SoC
Date:   Fri, 20 Nov 2020 17:41:05 +0100
Message-Id: <20201120164108.2096359-4-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120164108.2096359-1-gregory.clement@bootlin.com>
References: <20201120164108.2096359-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends irqchip driver for oceleot to be used with other
vcoreiii base platforms.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/irqchip/irq-mscc-ocelot.c | 76 ++++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 88143c0b700c..6d4029a2ded0 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -12,30 +12,51 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/interrupt.h>
 
-#define ICPU_CFG_INTR_INTR_STICKY	0x10
-#define ICPU_CFG_INTR_INTR_ENA		0x18
-#define ICPU_CFG_INTR_INTR_ENA_CLR	0x1c
-#define ICPU_CFG_INTR_INTR_ENA_SET	0x20
-#define ICPU_CFG_INTR_DST_INTR_IDENT(x)	(0x38 + 0x4 * (x))
-#define ICPU_CFG_INTR_INTR_TRIGGER(x)	(0x5c + 0x4 * (x))
-
-#define OCELOT_NR_IRQ 24
+#define ICPU_CFG_INTR_DST_INTR_IDENT(_p, x) ((_p)->reg_off_ident + 0x4 * (x))
+#define ICPU_CFG_INTR_INTR_TRIGGER(_p, x)   ((_p)->reg_off_trigger + 0x4 * (x))
+
+#define FLAGS_HAS_TRIGGER	BIT(0)
+
+struct chip_props {
+	u8 flags;
+	u8 reg_off_sticky;
+	u8 reg_off_ena;
+	u8 reg_off_ena_clr;
+	u8 reg_off_ena_set;
+	u8 reg_off_ident;
+	u8 reg_off_trigger;
+	u8 reg_off_ena_irq0;
+	u8 n_irq;
+};
+
+static struct chip_props ocelot_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0x10,
+	.reg_off_ena		= 0x18,
+	.reg_off_ena_clr	= 0x1c,
+	.reg_off_ena_set	= 0x20,
+	.reg_off_ident		= 0x38,
+	.reg_off_trigger	= 0x5c,
+	.n_irq			= 24,
+};
 
 static void ocelot_irq_unmask(struct irq_data *data)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct irq_domain *d = data->domain;
+	struct chip_props *p = d->host_data;
 	struct irq_chip_type *ct = irq_data_get_chip_type(data);
 	unsigned int mask = data->mask;
 	u32 val;
 
 	irq_gc_lock(gc);
-	val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(0)) |
-	      irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(1));
+	val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 0)) |
+		irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 1));
 	if (!(val & mask))
-		irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_STICKY);
+		irq_reg_writel(gc, mask, p->reg_off_sticky);
 
 	*ct->mask_cache &= ~mask;
-	irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_ENA_SET);
+	irq_reg_writel(gc, mask, p->reg_off_ena_set);
 	irq_gc_unlock(gc);
 }
 
@@ -43,8 +64,9 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
+	struct chip_props *p = d->host_data;
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, 0);
-	u32 reg = irq_reg_readl(gc, ICPU_CFG_INTR_DST_INTR_IDENT(0));
+	u32 reg = irq_reg_readl(gc, ICPU_CFG_INTR_DST_INTR_IDENT(p, 0));
 
 	chained_irq_enter(chip, desc);
 
@@ -58,8 +80,9 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int __init ocelot_irq_init(struct device_node *node,
-				  struct device_node *parent)
+static int __init vcoreiii_irq_init(struct device_node *node,
+				    struct device_node *parent,
+				    struct chip_props *p)
 {
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
@@ -69,14 +92,14 @@ static int __init ocelot_irq_init(struct device_node *node,
 	if (!parent_irq)
 		return -EINVAL;
 
-	domain = irq_domain_add_linear(node, OCELOT_NR_IRQ,
+	domain = irq_domain_add_linear(node, p->n_irq,
 				       &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("%pOFn: unable to add irq domain\n", node);
 		return -ENOMEM;
 	}
 
-	ret = irq_alloc_domain_generic_chips(domain, OCELOT_NR_IRQ, 1,
+	ret = irq_alloc_domain_generic_chips(domain, p->n_irq, 1,
 					     "icpu", handle_level_irq,
 					     0, 0, 0);
 	if (ret) {
@@ -92,16 +115,18 @@ static int __init ocelot_irq_init(struct device_node *node,
 		goto err_gc_free;
 	}
 
-	gc->chip_types[0].regs.ack = ICPU_CFG_INTR_INTR_STICKY;
-	gc->chip_types[0].regs.mask = ICPU_CFG_INTR_INTR_ENA_CLR;
+	gc->chip_types[0].regs.ack = p->reg_off_sticky;
+	gc->chip_types[0].regs.mask = p->reg_off_ena_clr;
 	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
-	gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
+	if (p->flags & FLAGS_HAS_TRIGGER)
+		gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
 
 	/* Mask and ack all interrupts */
-	irq_reg_writel(gc, 0, ICPU_CFG_INTR_INTR_ENA);
-	irq_reg_writel(gc, 0xffffffff, ICPU_CFG_INTR_INTR_STICKY);
+	irq_reg_writel(gc, 0, p->reg_off_ena);
+	irq_reg_writel(gc, 0xffffffff, p->reg_off_sticky);
 
+	domain->host_data = p;
 	irq_set_chained_handler_and_data(parent_irq, ocelot_irq_handler,
 					 domain);
 
@@ -115,4 +140,11 @@ static int __init ocelot_irq_init(struct device_node *node,
 
 	return ret;
 }
+
+static int __init ocelot_irq_init(struct device_node *node,
+				  struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &ocelot_props);
+}
+
 IRQCHIP_DECLARE(ocelot_icpu, "mscc,ocelot-icpu-intr", ocelot_irq_init);
-- 
2.29.2

