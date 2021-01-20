Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD3E2FD1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbhATNqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:46:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389953AbhATNbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:31:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE6A723357;
        Wed, 20 Jan 2021 13:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611149416;
        bh=0m9gBDn2ktHqq8A4lo37zpIrhywvXFJb7FUOoxiizYc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mk/De0QTX6HVHR1KzndJFHIuKhyrenNTYxX14hOIaQdhJFOZNMk/jXkASPBhhXxOD
         ge5IhFSdUNWGoYd0Jpay7SCZ0WHuyEMbjtmvsmx5RnAgtnnwhg0m8GjPMXu1r2DOCe
         +usbgzWdqFV7am0q+yfM/b38AmsdeM1SPCT0u0U5eFYmWH4aphQwFrOQWiKEeQJ57H
         DfzTBeVPn+EEgYKpnF2nO/NaAj1YiXhDtSMKxHJLQlcI1J4Be5B03DHGwhFK2dQnoR
         8x8EN9w4tKfooY9LEfH0dMgFai+rMS06CVl911KFxs/d2YVbavsYOpZcMQyVfPYkLz
         BJZS1w0mqdqzA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>
Subject: [PATCH 1/2] irqchip: remove sigma tango driver
Date:   Wed, 20 Jan 2021 14:30:07 +0100
Message-Id: <20210120133008.2421897-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120133008.2421897-1-arnd@kernel.org>
References: <20210120133008.2421897-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The tango platform is getting removed, so the driver is no
longer needed.

Cc: Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Mans Rullgard <mans@mansr.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../sigma,smp8642-intc.txt                    |  48 ----
 drivers/irqchip/Kconfig                       |   5 -
 drivers/irqchip/Makefile                      |   1 -
 drivers/irqchip/irq-tango.c                   | 227 ------------------
 4 files changed, 281 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt
 delete mode 100644 drivers/irqchip/irq-tango.c

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt
deleted file mode 100644
index 355c18a3a4d3..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/sigma,smp8642-intc.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Sigma Designs SMP86xx/SMP87xx secondary interrupt controller
-
-Required properties:
-- compatible: should be "sigma,smp8642-intc"
-- reg: physical address of MMIO region
-- ranges: address space mapping of child nodes
-- interrupt-controller: boolean
-- #address-cells: should be <1>
-- #size-cells: should be <1>
-
-One child node per control block with properties:
-- reg: address of registers for this control block
-- interrupt-controller: boolean
-- #interrupt-cells: should be <2>, interrupt index and flags per interrupts.txt
-- interrupts: interrupt spec of primary interrupt controller
-
-Example:
-
-interrupt-controller@6e000 {
-	compatible = "sigma,smp8642-intc";
-	reg = <0x6e000 0x400>;
-	ranges = <0x0 0x6e000 0x400>;
-	interrupt-parent = <&gic>;
-	interrupt-controller;
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	irq0: interrupt-controller@0 {
-		reg = <0x000 0x100>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	irq1: interrupt-controller@100 {
-		reg = <0x100 0x100>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
-	};
-
-	irq2: interrupt-controller@300 {
-		reg = <0x300 0x100>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-	};
-};
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 94920a51c628..f95d114c63ed 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -260,11 +260,6 @@ config ST_IRQCHIP
 	help
 	  Enables SysCfg Controlled IRQs on STi based platforms.
 
-config TANGO_IRQ
-	bool
-	select IRQ_DOMAIN
-	select GENERIC_IRQ_CHIP
-
 config TB10X_IRQC
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0ac93bfaec61..084e11774071 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -55,7 +55,6 @@ obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
 obj-$(CONFIG_ARCH_NSPIRE)		+= irq-zevio.o
 obj-$(CONFIG_ARCH_VT8500)		+= irq-vt8500.o
 obj-$(CONFIG_ST_IRQCHIP)		+= irq-st.o
-obj-$(CONFIG_TANGO_IRQ)			+= irq-tango.o
 obj-$(CONFIG_TB10X_IRQC)		+= irq-tb10x.o
 obj-$(CONFIG_TS4800_IRQ)		+= irq-ts4800.o
 obj-$(CONFIG_XTENSA)			+= irq-xtensa-pic.o
diff --git a/drivers/irqchip/irq-tango.c b/drivers/irqchip/irq-tango.c
deleted file mode 100644
index 34290f09b853..000000000000
--- a/drivers/irqchip/irq-tango.c
+++ /dev/null
@@ -1,227 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2014 Mans Rullgard <mans@mansr.com>
- */
-
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/irqchip.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/ioport.h>
-#include <linux/io.h>
-#include <linux/of_address.h>
-#include <linux/of_irq.h>
-#include <linux/slab.h>
-
-#define IRQ0_CTL_BASE		0x0000
-#define IRQ1_CTL_BASE		0x0100
-#define EDGE_CTL_BASE		0x0200
-#define IRQ2_CTL_BASE		0x0300
-
-#define IRQ_CTL_HI		0x18
-#define EDGE_CTL_HI		0x20
-
-#define IRQ_STATUS		0x00
-#define IRQ_RAWSTAT		0x04
-#define IRQ_EN_SET		0x08
-#define IRQ_EN_CLR		0x0c
-#define IRQ_SOFT_SET		0x10
-#define IRQ_SOFT_CLR		0x14
-
-#define EDGE_STATUS		0x00
-#define EDGE_RAWSTAT		0x04
-#define EDGE_CFG_RISE		0x08
-#define EDGE_CFG_FALL		0x0c
-#define EDGE_CFG_RISE_SET	0x10
-#define EDGE_CFG_RISE_CLR	0x14
-#define EDGE_CFG_FALL_SET	0x18
-#define EDGE_CFG_FALL_CLR	0x1c
-
-struct tangox_irq_chip {
-	void __iomem *base;
-	unsigned long ctl;
-};
-
-static inline u32 intc_readl(struct tangox_irq_chip *chip, int reg)
-{
-	return readl_relaxed(chip->base + reg);
-}
-
-static inline void intc_writel(struct tangox_irq_chip *chip, int reg, u32 val)
-{
-	writel_relaxed(val, chip->base + reg);
-}
-
-static void tangox_dispatch_irqs(struct irq_domain *dom, unsigned int status,
-				 int base)
-{
-	unsigned int hwirq;
-	unsigned int virq;
-
-	while (status) {
-		hwirq = __ffs(status);
-		virq = irq_find_mapping(dom, base + hwirq);
-		if (virq)
-			generic_handle_irq(virq);
-		status &= ~BIT(hwirq);
-	}
-}
-
-static void tangox_irq_handler(struct irq_desc *desc)
-{
-	struct irq_domain *dom = irq_desc_get_handler_data(desc);
-	struct irq_chip *host_chip = irq_desc_get_chip(desc);
-	struct tangox_irq_chip *chip = dom->host_data;
-	unsigned int status_lo, status_hi;
-
-	chained_irq_enter(host_chip, desc);
-
-	status_lo = intc_readl(chip, chip->ctl + IRQ_STATUS);
-	status_hi = intc_readl(chip, chip->ctl + IRQ_CTL_HI + IRQ_STATUS);
-
-	tangox_dispatch_irqs(dom, status_lo, 0);
-	tangox_dispatch_irqs(dom, status_hi, 32);
-
-	chained_irq_exit(host_chip, desc);
-}
-
-static int tangox_irq_set_type(struct irq_data *d, unsigned int flow_type)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct tangox_irq_chip *chip = gc->domain->host_data;
-	struct irq_chip_regs *regs = &gc->chip_types[0].regs;
-
-	switch (flow_type & IRQ_TYPE_SENSE_MASK) {
-	case IRQ_TYPE_EDGE_RISING:
-		intc_writel(chip, regs->type + EDGE_CFG_RISE_SET, d->mask);
-		intc_writel(chip, regs->type + EDGE_CFG_FALL_CLR, d->mask);
-		break;
-
-	case IRQ_TYPE_EDGE_FALLING:
-		intc_writel(chip, regs->type + EDGE_CFG_RISE_CLR, d->mask);
-		intc_writel(chip, regs->type + EDGE_CFG_FALL_SET, d->mask);
-		break;
-
-	case IRQ_TYPE_LEVEL_HIGH:
-		intc_writel(chip, regs->type + EDGE_CFG_RISE_CLR, d->mask);
-		intc_writel(chip, regs->type + EDGE_CFG_FALL_CLR, d->mask);
-		break;
-
-	case IRQ_TYPE_LEVEL_LOW:
-		intc_writel(chip, regs->type + EDGE_CFG_RISE_SET, d->mask);
-		intc_writel(chip, regs->type + EDGE_CFG_FALL_SET, d->mask);
-		break;
-
-	default:
-		pr_err("Invalid trigger mode %x for IRQ %d\n",
-		       flow_type, d->irq);
-		return -EINVAL;
-	}
-
-	return irq_setup_alt_chip(d, flow_type);
-}
-
-static void __init tangox_irq_init_chip(struct irq_chip_generic *gc,
-					unsigned long ctl_offs,
-					unsigned long edge_offs)
-{
-	struct tangox_irq_chip *chip = gc->domain->host_data;
-	struct irq_chip_type *ct = gc->chip_types;
-	unsigned long ctl_base = chip->ctl + ctl_offs;
-	unsigned long edge_base = EDGE_CTL_BASE + edge_offs;
-	int i;
-
-	gc->reg_base = chip->base;
-	gc->unused = 0;
-
-	for (i = 0; i < 2; i++) {
-		ct[i].chip.irq_ack = irq_gc_ack_set_bit;
-		ct[i].chip.irq_mask = irq_gc_mask_disable_reg;
-		ct[i].chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
-		ct[i].chip.irq_unmask = irq_gc_unmask_enable_reg;
-		ct[i].chip.irq_set_type = tangox_irq_set_type;
-		ct[i].chip.name = gc->domain->name;
-
-		ct[i].regs.enable = ctl_base + IRQ_EN_SET;
-		ct[i].regs.disable = ctl_base + IRQ_EN_CLR;
-		ct[i].regs.ack = edge_base + EDGE_RAWSTAT;
-		ct[i].regs.type = edge_base;
-	}
-
-	ct[0].type = IRQ_TYPE_LEVEL_MASK;
-	ct[0].handler = handle_level_irq;
-
-	ct[1].type = IRQ_TYPE_EDGE_BOTH;
-	ct[1].handler = handle_edge_irq;
-
-	intc_writel(chip, ct->regs.disable, 0xffffffff);
-	intc_writel(chip, ct->regs.ack, 0xffffffff);
-}
-
-static void __init tangox_irq_domain_init(struct irq_domain *dom)
-{
-	struct irq_chip_generic *gc;
-	int i;
-
-	for (i = 0; i < 2; i++) {
-		gc = irq_get_domain_generic_chip(dom, i * 32);
-		tangox_irq_init_chip(gc, i * IRQ_CTL_HI, i * EDGE_CTL_HI);
-	}
-}
-
-static int __init tangox_irq_init(void __iomem *base, struct resource *baseres,
-				  struct device_node *node)
-{
-	struct tangox_irq_chip *chip;
-	struct irq_domain *dom;
-	struct resource res;
-	int irq;
-	int err;
-
-	irq = irq_of_parse_and_map(node, 0);
-	if (!irq)
-		panic("%pOFn: failed to get IRQ", node);
-
-	err = of_address_to_resource(node, 0, &res);
-	if (err)
-		panic("%pOFn: failed to get address", node);
-
-	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
-	chip->ctl = res.start - baseres->start;
-	chip->base = base;
-
-	dom = irq_domain_add_linear(node, 64, &irq_generic_chip_ops, chip);
-	if (!dom)
-		panic("%pOFn: failed to create irqdomain", node);
-
-	err = irq_alloc_domain_generic_chips(dom, 32, 2, node->name,
-					     handle_level_irq, 0, 0, 0);
-	if (err)
-		panic("%pOFn: failed to allocate irqchip", node);
-
-	tangox_irq_domain_init(dom);
-
-	irq_set_chained_handler_and_data(irq, tangox_irq_handler, dom);
-
-	return 0;
-}
-
-static int __init tangox_of_irq_init(struct device_node *node,
-				     struct device_node *parent)
-{
-	struct device_node *c;
-	struct resource res;
-	void __iomem *base;
-
-	base = of_iomap(node, 0);
-	if (!base)
-		panic("%pOFn: of_iomap failed", node);
-
-	of_address_to_resource(node, 0, &res);
-
-	for_each_child_of_node(node, c)
-		tangox_irq_init(base, &res, c);
-
-	return 0;
-}
-IRQCHIP_DECLARE(tangox_intc, "sigma,smp8642-intc", tangox_of_irq_init);
-- 
2.29.2

