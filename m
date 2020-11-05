Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179CC2A8501
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbgKERfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:35:14 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:33510 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730862AbgKERfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:35:14 -0500
Received: from relay10.mail.gandi.net (unknown [217.70.178.230])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 00CF83B2ED1;
        Thu,  5 Nov 2020 17:16:20 +0000 (UTC)
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E2E4524001A;
        Thu,  5 Nov 2020 17:15:57 +0000 (UTC)
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
Subject: [PATCH 4/6] irqchip: ocelot: Add support for Luton platforms
Date:   Thu,  5 Nov 2020 18:15:33 +0100
Message-Id: <20201105171535.923570-5-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105171535.923570-1-gregory.clement@bootlin.com>
References: <20201105171535.923570-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends irqchip driver for oceleot to be used with an other
vcoreiii base platform: Luton.

Based on a larger patch from Lars Povlsen <lars.povlsen@microchip.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/irqchip/irq-mscc-ocelot.c | 145 +++++++++++++++++++++++++-----
 1 file changed, 123 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 88143c0b700c..9964800c53c2 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -12,39 +12,115 @@
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
+#define ICPU_CFG_INTR_DST_INTR_IDENT(_p, x)	(_p->reg_off_ident + 0x4 * (x))
+#define ICPU_CFG_INTR_INTR_TRIGGER(_p, x)	(_p->reg_off_trigger + 0x4 * (x))
+
+#define FLAGS_NEED_INIT_ENABLE	BIT(0)
+#define FLAGS_FORCE_LUTON_STYLE	BIT(1)
+#define FLAGS_HAS_TRIGGER	BIT(2)
+
+struct chip_props {
+	u32 flags;
+	u32 reg_off_sticky;
+	u32 reg_off_ena;
+	u32 reg_off_ena_clr;
+	u32 reg_off_ena_set;
+	u32 reg_off_ident;
+	u32 reg_off_trigger;
+	u32 reg_off_force;
+	u32 reg_off_ena_irq0;
+	u32 n_irq;
+};
+
+static const struct chip_props ocelot_props = {
+	.flags			= FLAGS_HAS_TRIGGER,
+	.reg_off_sticky		= 0x10,
+	.reg_off_ena		= 0x18,
+	.reg_off_ena_clr	= 0x1c,
+	.reg_off_ena_set	= 0x20,
+	.reg_off_ident		= 0x38,
+	.reg_off_trigger	= 0x5c,
+	.reg_off_force		= 0xc,
+	.n_irq			= 24,
+};
+
+static const struct chip_props luton_props = {
+	.flags			= FLAGS_NEED_INIT_ENABLE |
+				  FLAGS_FORCE_LUTON_STYLE,
+	.reg_off_sticky		= 0,
+	.reg_off_ena		= 0x4,
+	.reg_off_ena_clr	= 0x8,
+	.reg_off_ena_set	= 0xc,
+	.reg_off_ident		= 0x18,
+	.reg_off_trigger	= 0,
+	.reg_off_force		= 0x38,
+	.reg_off_ena_irq0	= 0x14,
+	.n_irq			= 28,
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
-	if (!(val & mask))
-		irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_STICKY);
+	if (p->flags & FLAGS_HAS_TRIGGER) {
+		val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 0)) |
+			irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 1));
+		if (!(val & mask))
+			irq_reg_writel(gc, mask, p->reg_off_sticky);
+	}
 
 	*ct->mask_cache &= ~mask;
-	irq_reg_writel(gc, mask, ICPU_CFG_INTR_INTR_ENA_SET);
+	irq_reg_writel(gc, mask, p->reg_off_ena_set);
 	irq_gc_unlock(gc);
 }
 
+static void luton_irq_force(struct irq_data *data,
+			    struct irq_chip_generic *gc,
+			    struct chip_props *p)
+{
+	int off = p->reg_off_force + (data->hwirq * sizeof(u32));
+	u32 val = irq_reg_readl(gc, off);
+
+	irq_reg_writel(gc, val | BIT(3), off);
+}
+
+static int ocelot_irq_force(struct irq_data *data,
+			    enum irqchip_irq_state which, bool state)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
+	struct irq_domain *d = data->domain;
+	struct chip_props *p = d->host_data;
+	int ret = -EINVAL;
+
+	/* Only supports triggering */
+	if ((which == IRQCHIP_STATE_PENDING ||
+	     which == IRQCHIP_STATE_ACTIVE) &&
+	    state && p->reg_off_force) {
+		if (p->flags & FLAGS_FORCE_LUTON_STYLE)
+			/* Config register style */
+			luton_irq_force(data, gc, p);
+		else
+			/* New, bitmask style */
+			irq_reg_writel(gc, data->mask, p->reg_off_force);
+		ret = 0;
+	}
+
+	return ret;
+}
+
 static void ocelot_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
+	struct chip_props *p = d->host_data;
 	struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, 0);
-	u32 reg = irq_reg_readl(gc, ICPU_CFG_INTR_DST_INTR_IDENT(0));
+	u32 reg = irq_reg_readl(gc, ICPU_CFG_INTR_DST_INTR_IDENT(p, 0));
 
 	chained_irq_enter(chip, desc);
 
@@ -58,25 +134,28 @@ static void ocelot_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int __init ocelot_irq_init(struct device_node *node,
-				  struct device_node *parent)
+static int __init vcoreiii_irq_init(struct device_node *node,
+				    struct device_node *parent,
+				    const struct chip_props *p)
 {
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
 	int parent_irq, ret;
 
+	pr_info("%s: Load, %d irqs\n", node->name, p->n_irq);
+
 	parent_irq = irq_of_parse_and_map(node, 0);
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
@@ -92,16 +171,23 @@ static int __init ocelot_irq_init(struct device_node *node,
 		goto err_gc_free;
 	}
 
-	gc->chip_types[0].regs.ack = ICPU_CFG_INTR_INTR_STICKY;
-	gc->chip_types[0].regs.mask = ICPU_CFG_INTR_INTR_ENA_CLR;
+	gc->chip_types[0].regs.ack = p->reg_off_sticky;
+	gc->chip_types[0].regs.mask = p->reg_off_ena_clr;
 	gc->chip_types[0].chip.irq_ack = irq_gc_ack_set_bit;
 	gc->chip_types[0].chip.irq_mask = irq_gc_mask_set_bit;
 	gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
+	gc->chip_types[0].chip.irq_unmask = ocelot_irq_unmask;
+	gc->chip_types[0].chip.irq_set_irqchip_state = ocelot_irq_force;
 
 	/* Mask and ack all interrupts */
-	irq_reg_writel(gc, 0, ICPU_CFG_INTR_INTR_ENA);
-	irq_reg_writel(gc, 0xffffffff, ICPU_CFG_INTR_INTR_STICKY);
+	irq_reg_writel(gc, 0, p->reg_off_ena);
+	irq_reg_writel(gc, 0xffffffff, p->reg_off_sticky);
+
+	/* Overall init */
+	if (p->flags & FLAGS_NEED_INIT_ENABLE)
+		irq_reg_writel(gc, BIT(0), p->reg_off_ena_irq0);
 
+	domain->host_data = (void *)p;
 	irq_set_chained_handler_and_data(parent_irq, ocelot_irq_handler,
 					 domain);
 
@@ -115,4 +201,19 @@ static int __init ocelot_irq_init(struct device_node *node,
 
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
+
+static int __init luton_irq_init(struct device_node *node,
+				 struct device_node *parent)
+{
+	return vcoreiii_irq_init(node, parent, &luton_props);
+}
+
+IRQCHIP_DECLARE(luton_icpu, "mscc,luton-icpu-intr", luton_irq_init);
-- 
2.28.0

