Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84CB2D789E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436997AbgLKPA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436744AbgLKPAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE69C06179C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:46 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNikn8TCkMxjxjhIjrW1BHago/f7/Hd86y7ugtlQ9tY=;
        b=D9TNCecy0kG0JF1zA9CmE6cYdz8fffAZOhC3wB4A2dHE9Y86sEKuAznzeLERabVRNuwqBn
        sk11KoOZnQoofJWboqBzHNePTkgMt40pqx8dB5y+OmHBvwxMn5+7m5eErjGtMwiHLHjYzL
        VBI9Zx/i2CrMw+7GhdIsuKpTXJvARcOyfoiKCXZFaNdRNdETquNN0blBuSmib4v3FVbFuS
        YJWuzfmwQtuIjbeuWhkkpN6+5RfBm5DI85p0oGEje2RcmtHKef5zqH5L5YOhVs6s28ie7p
        DDctCkYenQsS2/YxtmyVg9ixfhs7zbQTjcwee8v54WsqaL48t42k0u1LL35PHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698723;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HNikn8TCkMxjxjhIjrW1BHago/f7/Hd86y7ugtlQ9tY=;
        b=2tDLBFCzeUJoW0/Z/uAOcJLEm1E0AcoGqcEpRFnWhMZjJK+endinvKyDHG3h1tBxzpwgxe
        0SxqR7buOiOlb8AQ==
From:   "irqchip-bot for Vineet Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] drivers/irqchip: Remove EZChip NPS
 interrupt controller
Cc:     Vineet Gupta <vgupta@synopsys.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201105212210.1891598-3-vgupta@synopsys.com>
References: <20201105212210.1891598-3-vgupta@synopsys.com>
MIME-Version: 1.0
Message-ID: <160769872331.3364.1587336659453711321.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     04e7f423f4a96ad492fd51bf2234b8982400ab5f
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/04e7f423f4a96ad492fd51bf2234b8982400ab5f
Author:        Vineet Gupta <Vineet.Gupta1@synopsys.com>
AuthorDate:    Thu, 05 Nov 2020 13:22:09 -08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:50 

drivers/irqchip: Remove EZChip NPS interrupt controller

NPS platform has been removed from ARC port and there are no in-tree
users of it now. So RIP !

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/20201105212210.1891598-3-vgupta@synopsys.com
---
 drivers/irqchip/Kconfig     |   7 +-
 drivers/irqchip/Makefile    |   1 +-
 drivers/irqchip/irq-eznps.c | 165 +-----------------------------------
 3 files changed, 173 deletions(-)
 delete mode 100644 drivers/irqchip/irq-eznps.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 2aa79c3..94920a5 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -387,13 +387,6 @@ config LS_SCFG_MSI
 config PARTITION_PERCPU
 	bool
 
-config EZNPS_GIC
-	bool "NPS400 Global Interrupt Manager (GIM)"
-	depends on ARC || (COMPILE_TEST && !64BIT)
-	select IRQ_DOMAIN
-	help
-	  Support the EZchip NPS400 global interrupt controller
-
 config STM32_EXTI
 	bool
 	select IRQ_DOMAIN
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 94c2885..0ac93bf 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -86,7 +86,6 @@ obj-$(CONFIG_MVEBU_PIC)			+= irq-mvebu-pic.o
 obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
-obj-$(CONFIG_EZNPS_GIC)			+= irq-eznps.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
diff --git a/drivers/irqchip/irq-eznps.c b/drivers/irqchip/irq-eznps.c
deleted file mode 100644
index 2a7a388..0000000
--- a/drivers/irqchip/irq-eznps.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * Copyright (c) 2016, Mellanox Technologies. All rights reserved.
- *
- * This software is available to you under a choice of one of two
- * licenses.  You may choose to be licensed under the terms of the GNU
- * General Public License (GPL) Version 2, available from the file
- * COPYING in the main directory of this source tree, or the
- * OpenIB.org BSD license below:
- *
- *     Redistribution and use in source and binary forms, with or
- *     without modification, are permitted provided that the following
- *     conditions are met:
- *
- *      - Redistributions of source code must retain the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer.
- *
- *      - Redistributions in binary form must reproduce the above
- *        copyright notice, this list of conditions and the following
- *        disclaimer in the documentation and/or other materials
- *        provided with the distribution.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
- * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
- * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
- * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
- * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
- * SOFTWARE.
- */
-
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/irq.h>
-#include <linux/irqdomain.h>
-#include <linux/irqchip.h>
-#include <soc/nps/common.h>
-
-#define NPS_NR_CPU_IRQS 8  /* number of interrupt lines of NPS400 CPU */
-#define NPS_TIMER0_IRQ  3
-
-/*
- * NPS400 core includes an Interrupt Controller (IC) support.
- * All cores can deactivate level irqs at first level control
- * at cores mesh layer called MTM.
- * For devices out side chip e.g. uart, network there is another
- * level called Global Interrupt Manager (GIM).
- * This second level can control level and edge interrupt.
- *
- * NOTE: AUX_IENABLE and CTOP_AUX_IACK are auxiliary registers
- * with private HW copy per CPU.
- */
-
-static void nps400_irq_mask(struct irq_data *irqd)
-{
-	unsigned int ienb;
-	unsigned int irq = irqd_to_hwirq(irqd);
-
-	ienb = read_aux_reg(AUX_IENABLE);
-	ienb &= ~(1 << irq);
-	write_aux_reg(AUX_IENABLE, ienb);
-}
-
-static void nps400_irq_unmask(struct irq_data *irqd)
-{
-	unsigned int ienb;
-	unsigned int irq = irqd_to_hwirq(irqd);
-
-	ienb = read_aux_reg(AUX_IENABLE);
-	ienb |= (1 << irq);
-	write_aux_reg(AUX_IENABLE, ienb);
-}
-
-static void nps400_irq_eoi_global(struct irq_data *irqd)
-{
-	unsigned int __maybe_unused irq = irqd_to_hwirq(irqd);
-
-	write_aux_reg(CTOP_AUX_IACK, 1 << irq);
-
-	/* Don't ack GIC before all device access attempts are done */
-	mb();
-
-	nps_ack_gic();
-}
-
-static void nps400_irq_ack(struct irq_data *irqd)
-{
-	unsigned int __maybe_unused irq = irqd_to_hwirq(irqd);
-
-	write_aux_reg(CTOP_AUX_IACK, 1 << irq);
-}
-
-static struct irq_chip nps400_irq_chip_fasteoi = {
-	.name		= "NPS400 IC Global",
-	.irq_mask	= nps400_irq_mask,
-	.irq_unmask	= nps400_irq_unmask,
-	.irq_eoi	= nps400_irq_eoi_global,
-};
-
-static struct irq_chip nps400_irq_chip_percpu = {
-	.name		= "NPS400 IC",
-	.irq_mask	= nps400_irq_mask,
-	.irq_unmask	= nps400_irq_unmask,
-	.irq_ack	= nps400_irq_ack,
-};
-
-static int nps400_irq_map(struct irq_domain *d, unsigned int virq,
-			  irq_hw_number_t hw)
-{
-	switch (hw) {
-	case NPS_TIMER0_IRQ:
-#ifdef CONFIG_SMP
-	case NPS_IPI_IRQ:
-#endif
-		irq_set_percpu_devid(virq);
-		irq_set_chip_and_handler(virq, &nps400_irq_chip_percpu,
-					 handle_percpu_devid_irq);
-		break;
-	default:
-		irq_set_chip_and_handler(virq, &nps400_irq_chip_fasteoi,
-					 handle_fasteoi_irq);
-		break;
-	}
-
-	return 0;
-}
-
-static const struct irq_domain_ops nps400_irq_ops = {
-	.xlate = irq_domain_xlate_onecell,
-	.map = nps400_irq_map,
-};
-
-static int __init nps400_of_init(struct device_node *node,
-				 struct device_node *parent)
-{
-	struct irq_domain *nps400_root_domain;
-
-	if (parent) {
-		pr_err("DeviceTree incore ic not a root irq controller\n");
-		return -EINVAL;
-	}
-
-	nps400_root_domain = irq_domain_add_linear(node, NPS_NR_CPU_IRQS,
-						   &nps400_irq_ops, NULL);
-
-	if (!nps400_root_domain) {
-		pr_err("nps400 root irq domain not avail\n");
-		return -ENOMEM;
-	}
-
-	/*
-	 * Needed for primary domain lookup to succeed
-	 * This is a primary irqchip, and can never have a parent
-	 */
-	irq_set_default_host(nps400_root_domain);
-
-#ifdef CONFIG_SMP
-	irq_create_mapping(nps400_root_domain, NPS_IPI_IRQ);
-#endif
-
-	return 0;
-}
-IRQCHIP_DECLARE(ezchip_nps400_ic, "ezchip,nps400-ic", nps400_of_init);
