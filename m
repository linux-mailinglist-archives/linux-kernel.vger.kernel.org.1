Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D8C2C67A5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 15:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgK0OPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 09:15:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:54271 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730407AbgK0OPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 09:15:48 -0500
X-UUID: 93f309c979224ceda2e7286845cc29d7-20201127
X-UUID: 93f309c979224ceda2e7286845cc29d7-20201127
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hanks.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1622439158; Fri, 27 Nov 2020 22:15:36 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 27 Nov 2020 22:15:33 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Nov 2020 22:15:32 +0800
From:   Hanks Chen <hanks.chen@mediatek.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Hanks Chen <hanks.chen@mediatek.com>
Subject: [PATCH v1 1/3] irqchip/gic: enable irq target all
Date:   Fri, 27 Nov 2020 22:15:29 +0800
Message-ID: <1606486531-25719-2-git-send-email-hanks.chen@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com>
References: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support for interrupt distribution design for SMP system solutions.

With this feature enabled ,the SPI interrupts would be routed to
all the cores rather than boot core to achieve better
load balance of interrupt handling.
That is, interrupts might be serviced simultaneously on different CPUs.

Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
---
 drivers/irqchip/Kconfig            |  12 ++++
 drivers/irqchip/irq-gic-v3.c       | 107 +++++++++++++++++++++--------
 include/linux/irqchip/arm-gic-v3.h |   1 +
 kernel/irq/cpuhotplug.c            |  22 ++++++
 kernel/irq/manage.c                |   7 ++
 5 files changed, 122 insertions(+), 27 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index c6098eee0c7c..c88ee7731e92 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -597,4 +597,16 @@ config MST_IRQ
 	help
 	  Support MStar Interrupt Controller.
 
+config ARM_IRQ_TARGET_ALL
+	bool "Distribute interrupts across processors on SMP system"
+	depends on SMP && ARM_GIC_V3
+	help
+	  Support for interrupt distribution design for
+	  SMP system solutions. With this feature enabled ,the
+	  SPI interrupts would be routed to all the cores rather
+	  than boot cpu to achieve better load balance of interrupt
+	  handling
+
+	  If you don't know what to do here, say N.
+
 endmenu
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 16fecc0febe8..62a878ce4681 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -381,6 +381,12 @@ static inline bool gic_supports_nmi(void)
 	       static_branch_likely(&supports_pseudo_nmis);
 }
 
+static inline bool gic_supports_1n(void)
+{
+	return (IS_ENABLED(CONFIG_ARM_IRQ_TARGET_ALL) &&
+		~(readl_relaxed(gic_data.dist_base + GICD_TYPER) & GICD_TYPER_No1N));
+}
+
 static int gic_irq_set_irqchip_state(struct irq_data *d,
 				     enum irqchip_irq_state which, bool val)
 {
@@ -716,6 +722,7 @@ static void __init gic_dist_init(void)
 {
 	unsigned int i;
 	u64 affinity;
+
 	void __iomem *base = gic_data.dist_base;
 	u32 val;
 
@@ -759,16 +766,27 @@ static void __init gic_dist_init(void)
 	/* Enable distributor with ARE, Group1 */
 	writel_relaxed(val, base + GICD_CTLR);
 
-	/*
-	 * Set all global interrupts to the boot CPU only. ARE must be
-	 * enabled.
-	 */
-	affinity = gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
-	for (i = 32; i < GIC_LINE_NR; i++)
-		gic_write_irouter(affinity, base + GICD_IROUTER + i * 8);
+	if (!gic_supports_1n()) {
+		/*
+		 * Set all global interrupts to the boot CPU only. ARE must be
+		 * enabled.
+		 */
+		affinity = gic_mpidr_to_affinity(cpu_logical_map(smp_processor_id()));
+		for (i = 32; i < GIC_LINE_NR; i++)
+			gic_write_irouter(affinity, base + GICD_IROUTER + i * 8);
 
-	for (i = 0; i < GIC_ESPI_NR; i++)
-		gic_write_irouter(affinity, base + GICD_IROUTERnE + i * 8);
+		for (i = 0; i < GIC_ESPI_NR; i++)
+			gic_write_irouter(affinity, base + GICD_IROUTERnE + i * 8);
+	} else {
+		/* default set target all for all SPI */
+		for (i = 32; i < GIC_LINE_NR; i++)
+			gic_write_irouter(GICD_IROUTER_SPI_MODE_ANY,
+					  base + GICD_IROUTER + i * 8);
+
+		for (i = 0; i < GIC_ESPI_NR; i++)
+			gic_write_irouter(GICD_IROUTER_SPI_MODE_ANY,
+					  base + GICD_IROUTERnE + i * 8);
+	}
 }
 
 static int gic_iterate_rdists(int (*fn)(struct redist_region *, void __iomem *))
@@ -1191,29 +1209,64 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 	if (gic_irq_in_rdist(d))
 		return -EINVAL;
 
-	/* If interrupt was enabled, disable it first */
-	enabled = gic_peek_irq(d, GICD_ISENABLER);
-	if (enabled)
-		gic_mask_irq(d);
+	if (!gic_supports_1n()) {
+		/* If interrupt was enabled, disable it first */
+		enabled = gic_peek_irq(d, GICD_ISENABLER);
+		if (enabled)
+			gic_mask_irq(d);
 
-	offset = convert_offset_index(d, GICD_IROUTER, &index);
-	reg = gic_dist_base(d) + offset + (index * 8);
-	val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
+		offset = convert_offset_index(d, GICD_IROUTER, &index);
+		reg = gic_dist_base(d) + offset + (index * 8);
+		val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
 
-	gic_write_irouter(val, reg);
+		gic_write_irouter(val, reg);
 
-	/*
-	 * If the interrupt was enabled, enabled it again. Otherwise,
-	 * just wait for the distributor to have digested our changes.
-	 */
-	if (enabled)
-		gic_unmask_irq(d);
-	else
-		gic_dist_wait_for_rwp();
+		/*
+		 * If the interrupt was enabled, enabled it again. Otherwise,
+		 * just wait for the distributor to have digested our changes.
+		 */
+		if (enabled)
+			gic_unmask_irq(d);
+		else
+			gic_dist_wait_for_rwp();
+
+		irq_data_update_effective_affinity(d, cpumask_of(cpu));
+
+	} else {
+		/*
+		 * no need to update when:
+		 * input mask is equal to the current setting
+		 */
+		if (cpumask_equal(irq_data_get_affinity_mask(d), mask_val))
+			return IRQ_SET_MASK_OK_NOCOPY;
+
+		/* If interrupt was enabled, disable it first */
+		enabled = gic_peek_irq(d, GICD_ISENABLER);
+		if (enabled)
+			gic_mask_irq(d);
+
+		offset = convert_offset_index(d, GICD_IROUTER, &index);
+		reg = gic_dist_base(d) + offset + (index * 8);
 
-	irq_data_update_effective_affinity(d, cpumask_of(cpu));
+		/* GICv3 supports target is 1 or all */
+		if (cpumask_weight(mask_val) > 1)
+			val = GICD_IROUTER_SPI_MODE_ANY;
+		else
+			val = gic_mpidr_to_affinity(cpu_logical_map(cpu));
+
+		gic_write_irouter(val, reg);
+
+		/*
+		 * If the interrupt was enabled, enabled it again. Otherwise,
+		 * just wait for the distributor to have digested our changes.
+		 */
+		if (enabled)
+			gic_unmask_irq(d);
+		else
+			gic_dist_wait_for_rwp();
+	}
 
-	return IRQ_SET_MASK_OK_DONE;
+	return IRQ_SET_MASK_OK;
 }
 #else
 #define gic_set_affinity	NULL
diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index f6d092fdb93d..c24336d506a3 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -80,6 +80,7 @@
 #define GICD_CTLR_ENABLE_SS_G0		(1U << 0)
 
 #define GICD_TYPER_RSS			(1U << 26)
+#define GICD_TYPER_No1N			(1U << 25)
 #define GICD_TYPER_LPIS			(1U << 17)
 #define GICD_TYPER_MBIS			(1U << 16)
 #define GICD_TYPER_ESPI			(1U << 8)
diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 02236b13b359..779512e44960 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -87,6 +87,18 @@ static bool migrate_one_irq(struct irq_desc *desc)
 		return false;
 	}
 
+#ifdef CONFIG_ARM_IRQ_TARGET_ALL
+	/*
+	 * No move required, if interrupt is 1 of N IRQ.
+	 * write current cpu_online_mask into affinity mask.
+	 */
+	if (cpumask_weight(desc->irq_common_data.affinity) > 1) {
+		cpumask_copy(desc->irq_common_data.affinity, cpu_online_mask);
+
+		return false;
+	}
+#endif
+
 	/*
 	 * Complete an eventually pending irq move cleanup. If this
 	 * interrupt was moved in hard irq context, then the vectors need
@@ -191,6 +203,16 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
 	struct irq_data *data = irq_desc_get_irq_data(desc);
 	const struct cpumask *affinity = irq_data_get_affinity_mask(data);
 
+#ifdef CONFIG_ARM_IRQ_TARGET_ALL
+	/*
+	 * No restore required, if interrupt is 1 of N IRQ.
+	 */
+	if (cpumask_weight(affinity) > 1) {
+		cpumask_set_cpu(cpu, irq_data_get_affinity_mask(data));
+		return;
+	}
+#endif
+
 	if (!irqd_affinity_is_managed(data) || !desc->action ||
 	    !irq_data_get_irq_chip(data) || !cpumask_test_cpu(cpu, affinity))
 		return;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c460e0496006..770b97e326bd 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -270,7 +270,14 @@ int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 	switch (ret) {
 	case IRQ_SET_MASK_OK:
 	case IRQ_SET_MASK_OK_DONE:
+#ifndef CONFIG_ARM_IRQ_TARGET_ALL
 		cpumask_copy(desc->irq_common_data.affinity, mask);
+#else
+		if (cpumask_weight(mask) > 1)
+			cpumask_copy(desc->irq_common_data.affinity, cpu_online_mask);
+		else
+			cpumask_copy(desc->irq_common_data.affinity, mask);
+#endif
 		fallthrough;
 	case IRQ_SET_MASK_OK_NOCOPY:
 		irq_validate_effective_affinity(data);
-- 
2.18.0

