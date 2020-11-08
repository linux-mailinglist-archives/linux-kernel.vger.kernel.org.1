Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131442AABE0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 16:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728505AbgKHPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 10:24:57 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgKHPY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 10:24:56 -0500
Date:   Sun, 08 Nov 2020 15:23:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604849093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MlJ/6VPCxzf9d0uie+mVaxnrb9pAWfPXJSf+RQY2pbs=;
        b=PPOmH50TOJFIx1LEWXg5O9QphUth7j4J8ARlGIg/CycrvSSvYVcLz17QO+CvKc7pgNC9Re
        PgDwnyl8u0S/o2WBmHX2QIy6X+e+JpTkgavjPyx52Y78tGyvJJNd0fW5SG1dw2g1YnGDPH
        C0TLGhwP/9b/4tQwwuVyOj4gxC1JZis41TsWHUd6NLX14USYORntCGI5wEgsceXvLhtDER
        F18lN45iVMpYrBOR2Hq8eEc/2TcgMeYnFALD6B1q1oRFC/KRnNZj2XVNv33u33qwsxhDZW
        RB4qkjpz0ML1c1m1X24PP7stzbouRsbBb0aphOAXvVqyGXda83sUEOhJgUwg3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604849093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=MlJ/6VPCxzf9d0uie+mVaxnrb9pAWfPXJSf+RQY2pbs=;
        b=4cceS7Fdl6In2vjAlwUJJWOzX8qiKKaeVBU+a5uUd+EqNIJmo06cUBAF6S/Ssev/btx+1X
        K3cVTtokUDS6OTDQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] irq/urgent for 5.10-rc3
References: <160484899473.4262.9790266201913163807.tglx@nanos>
Message-ID: <160484899593.4262.17407262771838227894.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest irq/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-urgent-2020-11-08

up to:  82768a86c646: dt-bindings: irqchip: ti, sci-inta: Fix diagram indentation for unmapped events


A set of fixes for interrupt chip drivers:

 - Fix the fallout of the IPI as interrupt conversion in Kconfig and the
   BCM2836 interrupt chip driver/

 - Fixes for interrupt affinity setting and the handling of hierarchical
   irq domains in the SiFive PLIC driver.

 - Make the unmapped event handling in the TI SCI driver work correctly.

 - A few minor fixes and cleanups in various chip drivers and Kconfig.

Thanks,

	tglx

------------------>
Fabrice Gasnier (1):
      irqchip/stm32-exti: Add all LP timer exti direct events support

Geert Uytterhoeven (2):
      irqchip/mst: MST_IRQ should depend on ARCH_MEDIATEK or ARCH_MSTARV7
      irqchip/renesas-intc-irqpin: Merge irlm_bit and needs_irlm

Greentime Hu (2):
      irqchip/sifive-plic: Fix broken irq_set_affinity() callback
      irqchip/sifive-plic: Fix chip_data access within a hierarchy

Marc Zyngier (4):
      genirq: Let GENERIC_IRQ_IPI select IRQ_DOMAIN_HIERARCHY
      irqchip/mst: Make mst_intc_of_init static
      irqchip/mips: Drop selection of IRQ_DOMAIN_HIERARCHY
      irqchip/bcm2836: Fix missing __init annotation

Peter Ujfalusi (3):
      dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handling
      irqchip/ti-sci-inta: Add support for unmapped event handling
      dt-bindings: irqchip: ti, sci-inta: Fix diagram indentation for unmapped events


 .../bindings/interrupt-controller/ti,sci-inta.yaml | 10 +++
 drivers/irqchip/Kconfig                            |  3 +-
 drivers/irqchip/irq-bcm2836.c                      |  2 +-
 drivers/irqchip/irq-mst-intc.c                     |  4 +-
 drivers/irqchip/irq-renesas-intc-irqpin.c          |  8 +--
 drivers/irqchip/irq-sifive-plic.c                  | 10 +--
 drivers/irqchip/irq-stm32-exti.c                   |  4 ++
 drivers/irqchip/irq-ti-sci-inta.c                  | 83 +++++++++++++++++++++-
 kernel/irq/Kconfig                                 |  1 +
 9 files changed, 107 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index c7cd05656a3e..8d90bc593c6e 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -32,6 +32,11 @@ description: |
                        | | vint  | bit  |  | 0 |.....|63| vintx  |
                        | +--------------+  +------------+        |
                        |                                         |
+                       |      Unmap                              |
+                       | +--------------+                        |
+  Unmapped events ---->| |   umapidx    |-------------------------> Globalevents
+                       | +--------------+                        |
+                       |                                         |
                        +-----------------------------------------+
 
   Configuration of these Intmap registers that maps global events to vint is
@@ -70,6 +75,11 @@ properties:
         - description: |
             "limit" specifies the limit for translation
 
+  ti,unmapped-event-sources:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+    description:
+      Array of phandles to DMA controllers where the unmapped events originate.
+
 required:
   - compatible
   - reg
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 570a7706875c..38785a0fbb2a 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -180,7 +180,6 @@ config IRQ_MIPS_CPU
 	select GENERIC_IRQ_CHIP
 	select GENERIC_IRQ_IPI if SYS_SUPPORTS_MULTITHREADING
 	select IRQ_DOMAIN
-	select IRQ_DOMAIN_HIERARCHY if GENERIC_IRQ_IPI
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
 
 config CLPS711X_IRQCHIP
@@ -307,7 +306,6 @@ config KEYSTONE_IRQ
 config MIPS_GIC
 	bool
 	select GENERIC_IRQ_IPI
-	select IRQ_DOMAIN_HIERARCHY
 	select MIPS_CM
 
 config INGENIC_IRQ
@@ -583,6 +581,7 @@ config LOONGSON_PCH_MSI
 
 config MST_IRQ
 	bool "MStar Interrupt Controller"
+	depends on ARCH_MEDIATEK || ARCH_MSTARV7 || COMPILE_TEST
 	default ARCH_MEDIATEK
 	select IRQ_DOMAIN
 	select IRQ_DOMAIN_HIERARCHY
diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 97838eb705f9..cbc7c740e4dc 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -244,7 +244,7 @@ static int bcm2836_cpu_dying(unsigned int cpu)
 
 #define BITS_PER_MBOX	32
 
-static void bcm2836_arm_irqchip_smp_init(void)
+static void __init bcm2836_arm_irqchip_smp_init(void)
 {
 	struct irq_fwspec ipi_fwspec = {
 		.fwnode		= intc.domain->fwnode,
diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
index 4be077591898..143657b0cf28 100644
--- a/drivers/irqchip/irq-mst-intc.c
+++ b/drivers/irqchip/irq-mst-intc.c
@@ -154,8 +154,8 @@ static const struct irq_domain_ops mst_intc_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
-int __init
-mst_intc_of_init(struct device_node *dn, struct device_node *parent)
+static int __init mst_intc_of_init(struct device_node *dn,
+				   struct device_node *parent)
 {
 	struct irq_domain *domain, *domain_parent;
 	struct mst_intc_chip_data *cd;
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 3819185bfd02..cb7f60b3b4a9 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -71,8 +71,7 @@ struct intc_irqpin_priv {
 };
 
 struct intc_irqpin_config {
-	unsigned int irlm_bit;
-	unsigned needs_irlm:1;
+	int irlm_bit;		/* -1 if non-existent */
 };
 
 static unsigned long intc_irqpin_read32(void __iomem *iomem)
@@ -349,11 +348,10 @@ static const struct irq_domain_ops intc_irqpin_irq_domain_ops = {
 
 static const struct intc_irqpin_config intc_irqpin_irlm_r8a777x = {
 	.irlm_bit = 23, /* ICR0.IRLM0 */
-	.needs_irlm = 1,
 };
 
 static const struct intc_irqpin_config intc_irqpin_rmobile = {
-	.needs_irlm = 0,
+	.irlm_bit = -1,
 };
 
 static const struct of_device_id intc_irqpin_dt_ids[] = {
@@ -470,7 +468,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	}
 
 	/* configure "individual IRQ mode" where needed */
-	if (config && config->needs_irlm) {
+	if (config && config->irlm_bit >= 0) {
 		if (io[INTC_IRQPIN_REG_IRLM])
 			intc_irqpin_read_modify_write(p, INTC_IRQPIN_REG_IRLM,
 						      config->irlm_bit, 1, 1);
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index eaa3e9fe54e9..6f432d2a5ceb 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -99,7 +99,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 				   struct irq_data *d, int enable)
 {
 	int cpu;
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	writel(enable, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
@@ -115,7 +115,7 @@ static void plic_irq_unmask(struct irq_data *d)
 {
 	struct cpumask amask;
 	unsigned int cpu;
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	cpumask_and(&amask, &priv->lmask, cpu_online_mask);
 	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
@@ -127,7 +127,7 @@ static void plic_irq_unmask(struct irq_data *d)
 
 static void plic_irq_mask(struct irq_data *d)
 {
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	plic_irq_toggle(&priv->lmask, d, 0);
 }
@@ -138,7 +138,7 @@ static int plic_set_affinity(struct irq_data *d,
 {
 	unsigned int cpu;
 	struct cpumask amask;
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	cpumask_and(&amask, &priv->lmask, mask_val);
 
@@ -151,7 +151,7 @@ static int plic_set_affinity(struct irq_data *d,
 		return -EINVAL;
 
 	plic_irq_toggle(&priv->lmask, d, 0);
-	plic_irq_toggle(cpumask_of(cpu), d, 1);
+	plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));
 
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 0c2c61db26b4..8662d7b7b262 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -195,6 +195,10 @@ static const struct stm32_desc_irq stm32mp1_desc_irq[] = {
 	{ .exti = 25, .irq_parent = 107, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 30, .irq_parent = 52, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 47, .irq_parent = 93, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 48, .irq_parent = 138, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 50, .irq_parent = 139, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 52, .irq_parent = 140, .chip = &stm32_exti_h_chip_direct },
+	{ .exti = 53, .irq_parent = 141, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 54, .irq_parent = 135, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 61, .irq_parent = 100, .chip = &stm32_exti_h_chip_direct },
 	{ .exti = 65, .irq_parent = 144, .chip = &stm32_exti_h_chip },
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index e0cceb81c648..b2ab8db439d9 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -85,6 +85,17 @@ struct ti_sci_inta_vint_desc {
  * @base:		Base address of the memory mapped IO registers
  * @pdev:		Pointer to platform device.
  * @ti_sci_id:		TI-SCI device identifier
+ * @unmapped_cnt:	Number of @unmapped_dev_ids entries
+ * @unmapped_dev_ids:	Pointer to an array of TI-SCI device identifiers of
+ *			unmapped event sources.
+ *			Unmapped Events are not part of the Global Event Map and
+ *			they are converted to Global event within INTA to be
+ *			received by the same INTA to generate an interrupt.
+ *			In case an interrupt request comes for a device which is
+ *			generating Unmapped Event, we must use the INTA's TI-SCI
+ *			device identifier in place of the source device
+ *			identifier to let sysfw know where it has to program the
+ *			Global Event number.
  */
 struct ti_sci_inta_irq_domain {
 	const struct ti_sci_handle *sci;
@@ -96,11 +107,37 @@ struct ti_sci_inta_irq_domain {
 	void __iomem *base;
 	struct platform_device *pdev;
 	u32 ti_sci_id;
+
+	int unmapped_cnt;
+	u16 *unmapped_dev_ids;
 };
 
 #define to_vint_desc(e, i) container_of(e, struct ti_sci_inta_vint_desc, \
 					events[i])
 
+static u16 ti_sci_inta_get_dev_id(struct ti_sci_inta_irq_domain *inta, u32 hwirq)
+{
+	u16 dev_id = HWIRQ_TO_DEVID(hwirq);
+	int i;
+
+	if (inta->unmapped_cnt == 0)
+		return dev_id;
+
+	/*
+	 * For devices sending Unmapped Events we must use the INTA's TI-SCI
+	 * device identifier number to be able to convert it to a Global Event
+	 * and map it to an interrupt.
+	 */
+	for (i = 0; i < inta->unmapped_cnt; i++) {
+		if (dev_id == inta->unmapped_dev_ids[i]) {
+			dev_id = inta->ti_sci_id;
+			break;
+		}
+	}
+
+	return dev_id;
+}
+
 /**
  * ti_sci_inta_irq_handler() - Chained IRQ handler for the vint irqs
  * @desc:	Pointer to irq_desc corresponding to the irq
@@ -251,7 +288,7 @@ static struct ti_sci_inta_event_desc *ti_sci_inta_alloc_event(struct ti_sci_inta
 	u16 dev_id, dev_index;
 	int err;
 
-	dev_id = HWIRQ_TO_DEVID(hwirq);
+	dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
 	dev_index = HWIRQ_TO_IRQID(hwirq);
 
 	event_desc = &vint_desc->events[free_bit];
@@ -352,14 +389,15 @@ static void ti_sci_inta_free_irq(struct ti_sci_inta_event_desc *event_desc,
 {
 	struct ti_sci_inta_vint_desc *vint_desc;
 	struct ti_sci_inta_irq_domain *inta;
+	u16 dev_id;
 
 	vint_desc = to_vint_desc(event_desc, event_desc->vint_bit);
 	inta = vint_desc->domain->host_data;
+	dev_id = ti_sci_inta_get_dev_id(inta, hwirq);
 	/* free event irq */
 	mutex_lock(&inta->vint_mutex);
 	inta->sci->ops.rm_irq_ops.free_event_map(inta->sci,
-						 HWIRQ_TO_DEVID(hwirq),
-						 HWIRQ_TO_IRQID(hwirq),
+						 dev_id, HWIRQ_TO_IRQID(hwirq),
 						 inta->ti_sci_id,
 						 vint_desc->vint_id,
 						 event_desc->global_event,
@@ -574,6 +612,41 @@ static struct msi_domain_info ti_sci_inta_msi_domain_info = {
 	.chip	= &ti_sci_inta_msi_irq_chip,
 };
 
+static int ti_sci_inta_get_unmapped_sources(struct ti_sci_inta_irq_domain *inta)
+{
+	struct device *dev = &inta->pdev->dev;
+	struct device_node *node = dev_of_node(dev);
+	struct of_phandle_iterator it;
+	int count, err, ret, i;
+
+	count = of_count_phandle_with_args(node, "ti,unmapped-event-sources", NULL);
+	if (count <= 0)
+		return 0;
+
+	inta->unmapped_dev_ids = devm_kcalloc(dev, count,
+					      sizeof(*inta->unmapped_dev_ids),
+					      GFP_KERNEL);
+	if (!inta->unmapped_dev_ids)
+		return -ENOMEM;
+
+	i = 0;
+	of_for_each_phandle(&it, err, node, "ti,unmapped-event-sources", NULL, 0) {
+		u32 dev_id;
+
+		ret = of_property_read_u32(it.node, "ti,sci-dev-id", &dev_id);
+		if (ret) {
+			dev_err(dev, "ti,sci-dev-id read failure for %pOFf\n", it.node);
+			of_node_put(it.node);
+			return ret;
+		}
+		inta->unmapped_dev_ids[i++] = dev_id;
+	}
+
+	inta->unmapped_cnt = count;
+
+	return 0;
+}
+
 static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 {
 	struct irq_domain *parent_domain, *domain, *msi_domain;
@@ -629,6 +702,10 @@ static int ti_sci_inta_irq_domain_probe(struct platform_device *pdev)
 	if (IS_ERR(inta->base))
 		return PTR_ERR(inta->base);
 
+	ret = ti_sci_inta_get_unmapped_sources(inta);
+	if (ret)
+		return ret;
+
 	domain = irq_domain_add_linear(dev_of_node(dev),
 				       ti_sci_get_num_resources(inta->vint),
 				       &ti_sci_inta_irq_domain_ops, inta);
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 10a5aff4eecc..164a031cfdb6 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -82,6 +82,7 @@ config IRQ_FASTEOI_HIERARCHY_HANDLERS
 # Generic IRQ IPI support
 config GENERIC_IRQ_IPI
 	bool
+	select IRQ_DOMAIN_HIERARCHY
 
 # Generic MSI interrupt support
 config GENERIC_MSI_IRQ

