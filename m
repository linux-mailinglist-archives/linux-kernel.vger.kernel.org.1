Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5812F9994
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbhARF4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:56:09 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:34831 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732300AbhARFvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:51:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id A33501647;
        Mon, 18 Jan 2021 00:50:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=NhZTng3QcHtM7
        S8qNbqwFqCQJ4eNJuxEfotIZGF9K94=; b=JKKnL/Cu+sIrW7RI+N7vxYXx59LjF
        2OOrvnMjqBeHMlM5zNVyQMgnx8x8Nwdp3y+7gPSlYEVnv9aFtCFUCy5vRBJtV6Wh
        Kyps0sR/v2ko55dACO/O7zeqh7jRQOiuaEnaJqN4avyaaW2R+2rojKDpyIm7pdqb
        9HAM2vy0FWGeqoiSnevwSWlnb9udaZCPkc6NK46xqn5hIRZGCIXp2YP7fdJX14F4
        eAzo3ZXK2+XtE97mJNKWXJVl65b8tHNaBpnQ57wlblXS8QXcCAZq2QW4mElp/DSp
        TDTQqP49Gm2ZM2CwWUt9OZCqTlnEfXuJS3ne/A03oRUImBtqOhcVbNjIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=NhZTng3QcHtM7S8qNbqwFqCQJ4eNJuxEfotIZGF9K94=; b=X8YhlcmY
        f/nSbFAwT7E/Ab13mz4AtKvBJ+kjNiunazsUEeTgygpdaONv4Vs963wOLbwVU8Yr
        GBV5zDJoWS1oiqFA3F+CODwhE6kgMolQtz7UFUMGPISFLJhpoBlSPiWpbrVm73jc
        pSKtFZs6DEcWYQ3S3eDIaennBbn0R9Cz3uczt3Fj1VKs0Bqnazym/2cZMGAbTpf8
        +Y8/AM0vMTYvu+MitATG4DsdNiCJcvL885sL+FPBku+zjh69EcElJpXJVYjN+8Fm
        /vgU6gMKXMav6AKNkhgxlRpdt43A8WsZG1LJ7KZHU2/yFd5UtKNjOdd3nvu25/8j
        dQD7bALCJV3CWw==
X-ME-Sender: <xms:syEFYM6WOwsq_lwx3nP1ZsLgngkstGKQfB7_FNTM4k5t8xvzPZqP2w>
    <xme:syEFYN5lukNPu46lTlHyLFw4-9RCuLYaCqbz5SbY2TUyAoLC78koDNPA-pApf2uV6
    HiIHcqgPh4ySoG0hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:syEFYLcr67GweXFYYT0ix2R6lQTAHNHpt_gifvhqsSHuCgrVYcH70A>
    <xmx:syEFYBJz_02qYh3Lc1iBHU7JxksWDqNvqGCRVrs9JcWnRbrRfS76VA>
    <xmx:syEFYALvAaRSauk-_oDy6kxAePP0R9AlGn0WoS_h7e1VBk7NqKyUtw>
    <xmx:syEFYP9vqKmu8k_4XqHNawY7WzGbVEAjTwK37dvP0BtBOR0vgGg3KmCURi8>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 924D724005D;
        Mon, 18 Jan 2021 00:50:42 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 03/10] irqchip/sun6i-r: Use a stacked irqchip driver
Date:   Sun, 17 Jan 2021 23:50:33 -0600
Message-Id: <20210118055040.21910-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210118055040.21910-1-samuel@sholland.org>
References: <20210118055040.21910-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_INTC in the A31 and newer sun8i/sun50i SoCs is more similar to the
original sun4i interrupt controller than the sun7i/sun9i NMI controller.
It is used for two distinct purposes:
 - To control the trigger, latch, and mask for the NMI input pin
 - To provide the interrupt input for the ARISC coprocessor

As this interrupt controller is not documented, information about it
comes from vendor-provided firmware blobs and from experimentation.

Differences from the sun4i interrupt controller appear to be:
 - It only has one or two registers of each kind (max 32 or 64 IRQs)
 - Multiplexing logic is added to support additional inputs
 - There is no FIQ-related logic
 - There is no interrupt priority logic

In order to fulfill its two purposes, this hardware block combines four
types of IRQs. First, the NMI pin is routed to the "IRQ 0" input on this
chip, with a trigger type controlled by the NMI_CTRL_REG. The "IRQ 0
pending" output from this chip, if enabled, is then routed to a SPI IRQ
input on the GIC. In other words, bit 0 of IRQ_ENABLE_REG *does* affect
the NMI IRQ seen at the GIC.

The NMI is followed by a contiguous block of 15 "direct" (my name for
them) IRQ inputs that are connected in parallel to both R_INTC and the
GIC. Or in other words, these bits of IRQ_ENABLE_REG *do not* affect the
IRQs seen at the GIC.

Following the direct IRQs are the ARISC's copy of banked IRQs for shared
peripherals. These are not relevant to Linux. The remaining IRQs are
connected to a multiplexer and provide access to the first (up to) 128
SPIs from the ARISC. This range of SPIs overlaps with the direct IRQs.

Because of the 1:1 correspondence between R_INTC and GIC inputs, this is
a perfect scenario for using a stacked irqchip driver. We want to hook
into setting the NMI trigger type, but not actually handle any IRQ here.

To allow access to all multiplexed IRQs, this driver requires a new
binding where the interrupt number matches the GIC interrupt number.
(This moves the NMI from number 0 to 32 or 96, depending on the SoC.)
For simplicity, copy the three-cell GIC binding; this disambiguates
interrupt 0 in the old binding (the NMI) from interrupt 0 in the new
binding (SPI 0) by the number of cells.

Since R_INTC is in the always-on power domain, and its output is visible
to the power management coprocessor, a stacked irqchip driver provides a
simple way to add wakeup support to any of its IRQs. That is the next
patch; for now, just the NMI is moved over.

This commit mostly reverts commit 173bda53b340 ("irqchip/sunxi-nmi:
Support sun6i-a31-r-intc compatible").

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/mach-sunxi/Kconfig     |   2 +
 arch/arm64/Kconfig.platforms    |   2 +
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-sun6i-r.c   | 284 ++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-sunxi-nmi.c |  26 +--
 5 files changed, 292 insertions(+), 23 deletions(-)
 create mode 100644 drivers/irqchip/irq-sun6i-r.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index eeadb1a4dcfe..e5c2fce281cd 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,6 +6,8 @@ menuconfig ARCH_SUNXI
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select PM_OPP
 	select SUN4I_TIMER
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6eecdef538bd..f2aa1518c6f4 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -17,6 +17,8 @@ config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
+	select IRQ_FASTEOI_HIERARCHY_HANDLERS
 	select PINCTRL
 	select RESET_CONTROLLER
 	help
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 0ac93bfaec61..95221e74ee99 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_OR1K_PIC)			+= irq-or1k-pic.o
 obj-$(CONFIG_ORION_IRQCHIP)		+= irq-orion.o
 obj-$(CONFIG_OMAP_IRQCHIP)		+= irq-omap-intc.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun4i.o
+obj-$(CONFIG_ARCH_SUNXI)		+= irq-sun6i-r.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi-nmi.o
 obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
new file mode 100644
index 000000000000..284b56905eb7
--- /dev/null
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * The R_INTC in Allwinner A31 and newer SoCs manages several types of
+ * interrupts, as shown below:
+ *
+ *             NMI IRQ                DIRECT IRQs           MUXED IRQs
+ *              bit 0                  bits 1-15^           bits 19-31
+ *
+ *   +---------+                      +---------+    +---------+  +---------+
+ *   | NMI Pad |                      |  IRQ d  |    |  IRQ m  |  | IRQ m+7 |
+ *   +---------+                      +---------+    +---------+  +---------+
+ *        |                             |     |         |    |      |    |
+ *        |                             |     |         |    |......|    |
+ * +------V------+ +------------+       |     |         | +--V------V--+ |
+ * |   Invert/   | | Write 1 to |       |     |         | |  AND with  | |
+ * | Edge Detect | | PENDING[0] |       |     |         | |  MUX[m/8]  | |
+ * +-------------+ +------------+       |     |         | +------------+ |
+ *            |       |                 |     |         |       |        |
+ *         +--V-------V--+           +--V--+  |      +--V--+    |     +--V--+
+ *         | Set    Reset|           | GIC |  |      | GIC |    |     | GIC |
+ *         |    Latch    |           | SPI |  |      | SPI |... |  ...| SPI |
+ *         +-------------+           | N+d |  |      |  m  |    |     | m+7 |
+ *             |     |               +-----+  |      +-----+    |     +-----+
+ *             |     |                        |                 |
+ *     +-------V-+ +-V----------+   +---------V--+     +--------V--------+
+ *     | GIC SPI | |  AND with  |   |  AND with  |     |    AND with     |
+ *     | N (=32) | |  ENABLE[0] |   |  ENABLE[d] |     |  ENABLE[19+m/8] |
+ *     +---------+ +------------+   +------------+     +-----------------+
+ *                        |                |                    |
+ *                 +------V-----+   +------V-----+     +--------V--------+
+ *                 |    Read    |   |    Read    |     |     Read        |
+ *                 | PENDING[0] |   | PENDING[d] |     | PENDING[19+m/8] |
+ *                 +------------+   +------------+     +-----------------+
+ *
+ * ^ bits 16-18 are direct IRQs for peripherals with banked interrupts, such as
+ *   the MSGBOX. These IRQs do not map to any GIC SPI.
+ *
+ * The H6 variant adds two more (banked) direct IRQs and implements the full
+ * set of 128 mux bits. This requires a second set of top-level registers.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define SUN6I_NMI_CTRL			(0x0c)
+#define SUN6I_IRQ_PENDING(n)		(0x10 + 4 * (n))
+#define SUN6I_IRQ_ENABLE(n)		(0x40 + 4 * (n))
+#define SUN6I_MUX_ENABLE(n)		(0xc0 + 4 * (n))
+
+#define SUN6I_NMI_SRC_TYPE_LEVEL_LOW	0
+#define SUN6I_NMI_SRC_TYPE_EDGE_FALLING	1
+#define SUN6I_NMI_SRC_TYPE_LEVEL_HIGH	2
+#define SUN6I_NMI_SRC_TYPE_EDGE_RISING	3
+
+#define SUN6I_NMI_BIT			BIT(0)
+
+#define SUN6I_NMI_NEEDS_ACK		((void *)1)
+
+#define SUN6I_NR_TOP_LEVEL_IRQS		64
+#define SUN6I_NR_DIRECT_IRQS		16
+#define SUN6I_NR_MUX_BITS		128
+
+static void __iomem *base;
+static irq_hw_number_t nmi_hwirq;
+
+static void sun6i_r_intc_ack_nmi(void)
+{
+	writel_relaxed(SUN6I_NMI_BIT, base + SUN6I_IRQ_PENDING(0));
+}
+
+static void sun6i_r_intc_nmi_ack(struct irq_data *data)
+{
+	if (irqd_get_trigger_type(data) & IRQ_TYPE_EDGE_BOTH)
+		sun6i_r_intc_ack_nmi();
+	else
+		data->chip_data = SUN6I_NMI_NEEDS_ACK;
+}
+
+static void sun6i_r_intc_nmi_eoi(struct irq_data *data)
+{
+	/* For oneshot IRQs, delay the ack until the IRQ is unmasked. */
+	if (data->chip_data == SUN6I_NMI_NEEDS_ACK && !irqd_irq_masked(data)) {
+		data->chip_data = NULL;
+		sun6i_r_intc_ack_nmi();
+	}
+
+	irq_chip_eoi_parent(data);
+}
+
+static void sun6i_r_intc_nmi_unmask(struct irq_data *data)
+{
+	if (data->chip_data == SUN6I_NMI_NEEDS_ACK) {
+		data->chip_data = NULL;
+		sun6i_r_intc_ack_nmi();
+	}
+
+	irq_chip_unmask_parent(data);
+}
+
+static int sun6i_r_intc_nmi_set_type(struct irq_data *data, unsigned int type)
+{
+	u32 nmi_src_type;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		nmi_src_type = SUN6I_NMI_SRC_TYPE_EDGE_RISING;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		nmi_src_type = SUN6I_NMI_SRC_TYPE_EDGE_FALLING;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		nmi_src_type = SUN6I_NMI_SRC_TYPE_LEVEL_HIGH;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		nmi_src_type = SUN6I_NMI_SRC_TYPE_LEVEL_LOW;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	writel_relaxed(nmi_src_type, base + SUN6I_NMI_CTRL);
+
+	/*
+	 * The "External NMI" GIC input connects to a latch inside R_INTC, not
+	 * directly to the pin. So the GIC trigger type does not depend on the
+	 * NMI pin trigger type.
+	 */
+	return irq_chip_set_type_parent(data, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static int sun6i_r_intc_nmi_set_irqchip_state(struct irq_data *data,
+					      enum irqchip_irq_state which,
+					      bool state)
+{
+	if (which == IRQCHIP_STATE_PENDING && !state)
+		sun6i_r_intc_ack_nmi();
+
+	return irq_chip_set_parent_state(data, which, state);
+}
+
+static struct irq_chip sun6i_r_intc_nmi_chip = {
+	.name			= "sun6i-r-intc",
+	.irq_ack		= sun6i_r_intc_nmi_ack,
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= sun6i_r_intc_nmi_unmask,
+	.irq_eoi		= sun6i_r_intc_nmi_eoi,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= sun6i_r_intc_nmi_set_type,
+	.irq_set_irqchip_state	= sun6i_r_intc_nmi_set_irqchip_state,
+	.flags			= IRQCHIP_SET_TYPE_MASKED |
+				  IRQCHIP_SKIP_SET_WAKE,
+};
+
+static int sun6i_r_intc_domain_translate(struct irq_domain *domain,
+					 struct irq_fwspec *fwspec,
+					 unsigned long *hwirq,
+					 unsigned int *type)
+{
+	/* Accept the old two-cell binding for the NMI only. */
+	if (fwspec->param_count == 2 && fwspec->param[0] == 0) {
+		*hwirq = nmi_hwirq;
+		*type  = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		return 0;
+	}
+
+	/* Otherwise this binding should match the GIC SPI binding. */
+	if (fwspec->param_count < 3)
+		return -EINVAL;
+	if (fwspec->param[0] != GIC_SPI)
+		return -EINVAL;
+
+	*hwirq = fwspec->param[1];
+	*type  = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+
+	return 0;
+}
+
+static int sun6i_r_intc_domain_alloc(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *arg)
+{
+	struct irq_fwspec *fwspec = arg;
+	struct irq_fwspec gic_fwspec;
+	unsigned long hwirq;
+	unsigned int type;
+	int i, ret;
+
+	ret = sun6i_r_intc_domain_translate(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+	if (hwirq + nr_irqs > SUN6I_NR_MUX_BITS)
+		return -EINVAL;
+
+	/* Construct a GIC-compatible fwspec from this fwspec. */
+	gic_fwspec = (struct irq_fwspec) {
+		.fwnode      = domain->parent->fwnode,
+		.param_count = 3,
+		.param       = { GIC_SPI, hwirq, type },
+	};
+
+	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_fwspec);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; ++i, ++hwirq, ++virq) {
+		if (hwirq == nmi_hwirq) {
+			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+						      &sun6i_r_intc_nmi_chip, 0);
+			irq_set_handler(virq, handle_fasteoi_ack_irq);
+		} else {
+			/* Only the NMI is currently supported. */
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
+	.translate	= sun6i_r_intc_domain_translate,
+	.alloc		= sun6i_r_intc_domain_alloc,
+	.free		= irq_domain_free_irqs_common,
+};
+
+static void sun6i_r_intc_resume(void)
+{
+	int i;
+
+	/* Only the NMI is relevant during normal operation. */
+	writel_relaxed(SUN6I_NMI_BIT, base + SUN6I_IRQ_ENABLE(0));
+	for (i = 1; i < BITS_TO_U32(SUN6I_NR_TOP_LEVEL_IRQS); ++i)
+		writel_relaxed(0, base + SUN6I_IRQ_ENABLE(i));
+}
+
+static int __init sun6i_r_intc_init(struct device_node *node,
+				    struct device_node *parent)
+{
+	struct irq_domain *domain, *parent_domain;
+	struct of_phandle_args nmi_parent;
+	int ret;
+
+	/* Extract the NMI hwirq number from the OF node. */
+	ret = of_irq_parse_one(node, 0, &nmi_parent);
+	if (ret)
+		return ret;
+	if (nmi_parent.args_count < 3 ||
+	    nmi_parent.args[0] != GIC_SPI ||
+	    nmi_parent.args[2] != IRQ_TYPE_LEVEL_HIGH)
+		return -EINVAL;
+	nmi_hwirq = nmi_parent.args[1];
+
+	parent_domain = irq_find_host(parent);
+	if (!parent_domain) {
+		pr_err("%pOF: Failed to obtain parent domain\n", node);
+		return -ENXIO;
+	}
+
+	base = of_io_request_and_map(node, 0, NULL);
+	if (IS_ERR(base)) {
+		pr_err("%pOF: Failed to map MMIO region\n", node);
+		return PTR_ERR(base);
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0, 0, node,
+					  &sun6i_r_intc_domain_ops, NULL);
+	if (!domain) {
+		pr_err("%pOF: Failed to allocate domain\n", node);
+		iounmap(base);
+		return -ENOMEM;
+	}
+
+	sun6i_r_intc_ack_nmi();
+	sun6i_r_intc_resume();
+
+	return 0;
+}
+IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc", sun6i_r_intc_init);
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index a412b5d5d0fa..9f2bd0c5d289 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -27,18 +27,12 @@
 
 #define SUNXI_NMI_IRQ_BIT	BIT(0)
 
-#define SUN6I_R_INTC_CTRL	0x0c
-#define SUN6I_R_INTC_PENDING	0x10
-#define SUN6I_R_INTC_ENABLE	0x40
-
 /*
  * For deprecated sun6i-a31-sc-nmi compatible.
- * Registers are offset by 0x0c.
  */
-#define SUN6I_R_INTC_NMI_OFFSET	0x0c
-#define SUN6I_NMI_CTRL		(SUN6I_R_INTC_CTRL - SUN6I_R_INTC_NMI_OFFSET)
-#define SUN6I_NMI_PENDING	(SUN6I_R_INTC_PENDING - SUN6I_R_INTC_NMI_OFFSET)
-#define SUN6I_NMI_ENABLE	(SUN6I_R_INTC_ENABLE - SUN6I_R_INTC_NMI_OFFSET)
+#define SUN6I_NMI_CTRL		0x00
+#define SUN6I_NMI_PENDING	0x04
+#define SUN6I_NMI_ENABLE	0x34
 
 #define SUN7I_NMI_CTRL		0x00
 #define SUN7I_NMI_PENDING	0x04
@@ -61,12 +55,6 @@ struct sunxi_sc_nmi_reg_offs {
 	u32 enable;
 };
 
-static const struct sunxi_sc_nmi_reg_offs sun6i_r_intc_reg_offs __initconst = {
-	.ctrl	= SUN6I_R_INTC_CTRL,
-	.pend	= SUN6I_R_INTC_PENDING,
-	.enable	= SUN6I_R_INTC_ENABLE,
-};
-
 static const struct sunxi_sc_nmi_reg_offs sun6i_reg_offs __initconst = {
 	.ctrl	= SUN6I_NMI_CTRL,
 	.pend	= SUN6I_NMI_PENDING,
@@ -232,14 +220,6 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
 	return ret;
 }
 
-static int __init sun6i_r_intc_irq_init(struct device_node *node,
-					struct device_node *parent)
-{
-	return sunxi_sc_nmi_irq_init(node, &sun6i_r_intc_reg_offs);
-}
-IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc",
-		sun6i_r_intc_irq_init);
-
 static int __init sun6i_sc_nmi_irq_init(struct device_node *node,
 					struct device_node *parent)
 {
-- 
2.26.2

