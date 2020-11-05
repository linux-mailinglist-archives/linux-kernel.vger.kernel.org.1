Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C7D2A88E0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 22:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbgKEVWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 16:22:20 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47162 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgKEVWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 16:22:19 -0500
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 323CCC008F;
        Thu,  5 Nov 2020 21:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1604611338; bh=fyTwVAwOCEBuyIL7L7IGZXFLyc22o/eT5cCTL6DoEOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fp79djYQXBxpi7P9zD1Vm/AtB4p8IwXLEFI+QOmEiNqEN+LrWhL5+EZoyyF1B4HAf
         Verx9uVJLdLecFX2RKsyIZNDcS2wZslp/49PcccfsRdI9tm7LC/1bTSP9F/+X2g5tC
         2W5yZYO1ybs/u0x98bAfi/QxjZMtay2VVE3T93R4cK9/bhbtU+WRO26FBlr6Jk5OXf
         yhL7U3a2KR+QpLjJ885k3MvLixURASLjLO5wLzICfhNJibS8N4U1MvzUnHMbRm8A3W
         6c03tF4ZyQI3LWN/9CaQf98/DvRoc7m4tmcVM8fsSaIIdt9mv1iV5ZTV9G4HFhD1SO
         BV90YlLJjpNew==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id B6D04A006F;
        Thu,  5 Nov 2020 21:22:17 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: [PATCH 2/3] drivers/irqchip: Remove EZChip NPS interrupt controller
Date:   Thu,  5 Nov 2020 13:22:09 -0800
Message-Id: <20201105212210.1891598-3-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201105212210.1891598-1-vgupta@synopsys.com>
References: <20201105212210.1891598-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPS platform has been removed from ARC port and there are no in-tree
users of it now. So RIP !

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 drivers/irqchip/Kconfig     |   7 --
 drivers/irqchip/Makefile    |   1 -
 drivers/irqchip/irq-eznps.c | 165 ------------------------------------
 3 files changed, 173 deletions(-)
 delete mode 100644 drivers/irqchip/irq-eznps.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c6098eee0c7c..7920c3a3017d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -389,13 +389,6 @@ config LS_SCFG_MSI
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
index 94c2885882ee..0ac93bfaec61 100644
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
index 2a7a38830a8d..000000000000
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
-- 
2.25.1

