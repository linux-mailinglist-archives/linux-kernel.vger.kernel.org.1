Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413A32D786F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436714AbgLKPAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406448AbgLKO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:59:38 -0500
Date:   Fri, 11 Dec 2020 14:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gB0CCCgK+0dYdljhvmAJKjFlKIxM13RRGs4HPIhIW7g=;
        b=XbwMpsykyP4rExJ612ztzOTuPTm7dKnQJL/T62n7VFZAVC54oUg/SOptk0+P3T74aQe8C6
        9xi/0twy79mDUbRH8xfB3gVLMGDBa8qEkpgVB/qPzPlLoxh4O+jru6jJ7BVpP3K7AITH7x
        fFF0FBiXzLcJk4lIRnvc3Jw52TBjjkqM1wYZ48Kzhx+BxukqQHoIIIke13SlnN1KrpmTmA
        XEVF/aD0+KlQCNqkDn3KUbhaaisN9w+C3uMvFmVU1U03D5cxGbIkMzSSnhZoICCWBuEkXo
        9UtWWeikOYrF5Y6oRwVx/W2IFcQ/sQPFtrYz8d51ag4RobKoRqhIhdVgImS2KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gB0CCCgK+0dYdljhvmAJKjFlKIxM13RRGs4HPIhIW7g=;
        b=nDwnZmkMdpRHUyrIbWsYFtF1YQ9CIhT3ZeplWZ0gLFJ6uObFonfrWzo35lkJ0ijO9mg6Rc
        z64jjiRaEhVPA3DA==
From:   "irqchip-bot for Gregory CLEMENT" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] irqchip/ocelot: prepare to support more SoC
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marc Zyngier <maz@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        tglx@linutronix.de
In-Reply-To: <20201125103206.136498-4-gregory.clement@bootlin.com>
References: <20201125103206.136498-4-gregory.clement@bootlin.com>
MIME-Version: 1.0
Message-ID: <160769872491.3364.10449555775345746809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     5f0c75e7a1333f5ebb5303af55d8c863ea292c23
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/5f0c75e7a1333f5ebb5303af55d8c863ea292c23
Author:        Gregory CLEMENT <gregory.clement@bootlin.com>
AuthorDate:    Wed, 25 Nov 2020 11:32:03 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:49 

irqchip/ocelot: prepare to support more SoC

This patch extends irqchip driver for oceleot to be used with other
vcoreiii base platforms.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201125103206.136498-4-gregory.clement@bootlin.com
---
 drivers/irqchip/irq-mscc-ocelot.c | 76 +++++++++++++++++++++---------
 1 file changed, 54 insertions(+), 22 deletions(-)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 88143c0..6d4029a 100644
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
 
@@ -115,4 +140,11 @@ err_domain_remove:
 
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
