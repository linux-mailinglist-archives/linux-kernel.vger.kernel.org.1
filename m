Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BFC2E8BAC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbhACKcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:32:17 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:44465 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbhACKcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:32:11 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4C31C5803BE;
        Sun,  3 Jan 2021 05:31:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=YbKJwkg71GmYc
        s8V6wopwnz7cNxIxpalOm5ZROk8UH8=; b=MbzGLFvdGNbBzwHRtMRhTVs7x+rkQ
        6EtuxQbLwnXhnrSy8nnlZ+ZztnxRYMBDmQ2SWIK+Z/S2cSK/5KlMSOxKWGwf44zV
        lK9HiJwNwT4/oqSkSYDNhCk3nXWPol+nAkm0EzgQWfCd02l3dxLMF2P9RZVqOURP
        I3Z+tEc0nT6+OGXSi5T4EyPPipIQ+sazEQ95j5u99BkkX7BBIGLOnjUdh055NVxH
        6HSSGzlhjiV71z/t8pmbqpbKsYqUmzn+/TXheSBJ/ora+nHdt7BJDPLOsFW2JBu7
        f+8vYnE5rC13XWG9I+KQo6mTOUXNK+9EfjHxCGisocQujvJBvaDbq1KJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=YbKJwkg71GmYcs8V6wopwnz7cNxIxpalOm5ZROk8UH8=; b=DNxDD67y
        xoacFY4ilXtvOtV1pAUlWtIxhtOxM6PR/X1W5OBBD8GywkKDotOgWyUztNTgvisH
        ZlVMav5vhmrz4x0nIOktF5oYsbKWn5qhFkte9jt1owVQ2NuPmRAThpPl7GspLwfG
        oXWOVYZdTJ1tRcwlC25EKE9YMvD71djqcCyQawcbXe4tqaConjhbn3dhl17SEra2
        UL63zxWUVPrDgv0UjC4zu6BdTL58frDda77ceeE64QpEvjKRJFcWHwLPpPJA/fOo
        1qqkm/e6vbpcilQHIQBdAXBZow7JzZ+m0kVFZmW9Vo95NqmwSe4Qy+/h+k+l4Ylw
        VAlYWWqF1Gssgw==
X-ME-Sender: <xms:6JzxXyFpAeF9yDK_BaGy-OS1HgzohVBtFLW67zOfnFEvW1tM9ECK1A>
    <xme:6JzxXzfqCqXW3PESqqdZQlX727KvBjEdDBu_dfORDU_6bI5kH4eQoUMbDc9yCRN-k
    2LLVuYACU9qyF73Vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:6JzxX0Etmh661Uk6jFPS69YOGer2HfQgZWipZxazeYBlc-6hAn1LhA>
    <xmx:6JzxX0VraAWCo2xh8lzbsliSAqQ2J71UBn1F38PjpLxh6tdpD3TPLw>
    <xmx:6JzxXzK4W0UyFGbpzKEeAW_dEz2PerOpKt0xilwzEOvKme0K2P5vxg>
    <xmx:6JzxX1YWHNtlB5FPqKDPV41buNlQfaXAm_M9yKMzI9gq2JfWK_lUyQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9C33A1080063;
        Sun,  3 Jan 2021 05:31:03 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 03/10] irqchip/sun6i-r: Use a stacked irqchip driver
Date:   Sun,  3 Jan 2021 04:30:54 -0600
Message-Id: <20210103103101.33603-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103103101.33603-1-samuel@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
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

Like the original sun4i interrupt controller, it has:
 - A VECTOR_REG at 0x00 (configurable via the BASE_ADDR_REG at 0x04)
 - A NMI_CTRL_REG, PENDING_REG, and ENABLE_REG as used by both the
   sun4i and sunxi-nmi drivers
 - A MASK_REG at 0x50
 - A RESP_REG at 0x60

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

Finally, the global "IRQ pending" output from R_INTC, after being masked
by MASK_REG and RESP_REG, is connected to the "external interrupt" input
of the ARISC CPU. This path is also irrelevant to Linux.

Because of the 1:1 correspondence between R_INTC and GIC inputs, this is
a perfect scenario for using a stacked irqchip driver. We want to hook
into enabling/disabling IRQs to add more features to the GIC
(specifically to allow masking the NMI and setting its trigger type),
but we don't need to actually handle the IRQ in this driver.

And since R_INTC is in the always-on power domain, and its output is
connected directly in to the power management coprocessor, a stacked
irqchip driver provides a simple way to add wakeup support to this set
of IRQs. That is the next patch; for now, just the NMI is moved over.

To allow access to all multiplexed IRQs, this driver requires a new
binding where the interrupt number matches the GIC interrupt number.
(This moves the NMI number from 0 to 32 or 96, depending on the SoC.)
For simplicity, copy the three-cell GIC binding; this disambiguates
interrupt 0 in the old binding (the NMI) from interrupt 0 in the new
binding (SPI 0) by the number of cells.

This commit mostly reverts commit 173bda53b340 ("irqchip/sunxi-nmi:
Support sun6i-a31-r-intc compatible").

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/mach-sunxi/Kconfig     |   1 +
 arch/arm64/Kconfig.platforms    |   1 +
 drivers/irqchip/Makefile        |   1 +
 drivers/irqchip/irq-sun6i-r.c   | 267 ++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-sunxi-nmi.c |  26 +---
 5 files changed, 273 insertions(+), 23 deletions(-)
 create mode 100644 drivers/irqchip/irq-sun6i-r.c

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index eeadb1a4dcfe..ef1cc25902b5 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -6,6 +6,7 @@ menuconfig ARCH_SUNXI
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select GPIOLIB
+	select IRQ_DOMAIN_HIERARCHY
 	select PINCTRL
 	select PM_OPP
 	select SUN4I_TIMER
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6eecdef538bd..eec63d2d9d96 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -17,6 +17,7 @@ config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
 	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN_HIERARCHY
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
index 000000000000..7490ade7b254
--- /dev/null
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -0,0 +1,267 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// R_INTC driver for Allwinner A31 and newer SoCs
+//
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/*
+ * The R_INTC manages between 32 and 64 IRQs, divided into four groups. Example
+ * bit numbers are for the original variant in the A31:
+ *
+ *   Bit      0: The "External NMI" input, connected in series to a GIC SPI.
+ *   Bits  1-15: "Direct" IRQs for ARISC peripherals, connected in parallel to
+ *               the GIC and mapped 1:1 to SPIs numerically following the NMI.
+ *   Bits 16-18: "Banked" IRQs for peripherals that have separate interfaces
+ *               for the ARM CPUs and ARISC. These do not map to any GIC SPI.
+ *   Bits 19-31: "Muxed" IRQs, each corresponding to a group of up to 8 SPIs.
+ *               Later variants added a second PENDING and ENABLE register to
+ *               make use of all 128 mux inputs (16 IRQ lines).
+ *
+ * Since the direct IRQs are inside the muxed IRQ range, they do not increase
+ * the number of HWIRQs needed.
+ */
+#define SUN6I_NR_IRQS			64
+#define SUN6I_NR_DIRECT_IRQS		16
+#define SUN6I_NR_MUX_INPUTS		128
+#define SUN6I_NR_HWIRQS			SUN6I_NR_MUX_INPUTS
+
+#define SUN6I_NMI_CTRL			(0x0c)
+#define SUN6I_IRQ_PENDING(n)		(0x10 + 4 * (n))
+#define SUN6I_IRQ_ENABLE(n)		(0x40 + 4 * (n))
+#define SUN6I_MUX_ENABLE(n)		(0xc0 + 4 * (n))
+
+#define SUN6I_NMI_IRQ_BIT		BIT(0)
+
+static void __iomem *base;
+static irq_hw_number_t nmi_hwirq;
+static u32 nmi_type;
+
+static struct irq_chip sun6i_r_intc_edge_chip;
+static struct irq_chip sun6i_r_intc_level_chip;
+
+static void sun6i_r_intc_nmi_ack(void)
+{
+	/*
+	 * The NMI channel has a latch separate from its trigger type.
+	 * This latch must be cleared to clear the signal to the GIC.
+	 */
+	writel_relaxed(SUN6I_NMI_IRQ_BIT, base + SUN6I_IRQ_PENDING(0));
+}
+
+static void sun6i_r_intc_irq_mask(struct irq_data *data)
+{
+	if (data->hwirq == nmi_hwirq)
+		sun6i_r_intc_nmi_ack();
+
+	irq_chip_mask_parent(data);
+}
+
+static void sun6i_r_intc_irq_unmask(struct irq_data *data)
+{
+	if (data->hwirq == nmi_hwirq)
+		sun6i_r_intc_nmi_ack();
+
+	irq_chip_unmask_parent(data);
+}
+
+static int sun6i_r_intc_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	/*
+	 * The GIC input labeled "External NMI" connects to bit 0 of the R_INTC
+	 * PENDING register, not to the pin directly. So the trigger type of the
+	 * GIC input does not depend on the trigger type of the NMI pin itself.
+	 *
+	 * Only the NMI channel is routed through this interrupt controller on
+	 * its way to the GIC. Other IRQs are routed to the GIC and R_INTC in
+	 * parallel; they must have a trigger type appropriate for the GIC.
+	 */
+	if (data->hwirq == nmi_hwirq) {
+		struct irq_chip *chip;
+		u32 nmi_src_type;
+
+		switch (type) {
+		case IRQ_TYPE_LEVEL_LOW:
+			chip = &sun6i_r_intc_level_chip;
+			nmi_src_type = 0;
+			break;
+		case IRQ_TYPE_EDGE_FALLING:
+			chip = &sun6i_r_intc_edge_chip;
+			nmi_src_type = 1;
+			break;
+		case IRQ_TYPE_LEVEL_HIGH:
+			chip = &sun6i_r_intc_level_chip;
+			nmi_src_type = 2;
+			break;
+		case IRQ_TYPE_EDGE_RISING:
+			chip = &sun6i_r_intc_edge_chip;
+			nmi_src_type = 3;
+			break;
+		default:
+			pr_err("%pOF: invalid trigger type %d for IRQ %d\n",
+			       irq_domain_get_of_node(data->domain), type,
+			       data->irq);
+			return -EBADR;
+		}
+
+		irq_set_chip_handler_name_locked(data, chip,
+						 handle_fasteoi_irq, NULL);
+
+		writel_relaxed(nmi_src_type, base + SUN6I_NMI_CTRL);
+
+		/*
+		 * Use the trigger type from the OF node for the NMI's
+		 * R_INTC to GIC connection.
+		 */
+		type = nmi_type;
+	}
+
+	return irq_chip_set_type_parent(data, type);
+}
+
+static struct irq_chip sun6i_r_intc_edge_chip = {
+	.name			= "sun6i-r-intc",
+	.irq_mask		= sun6i_r_intc_irq_mask,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= sun6i_r_intc_irq_set_type,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static struct irq_chip sun6i_r_intc_level_chip = {
+	.name			= "sun6i-r-intc",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= sun6i_r_intc_irq_unmask,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= sun6i_r_intc_irq_set_type,
+	.irq_get_irqchip_state	= irq_chip_get_parent_state,
+	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
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
+		*type = fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
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
+	*type = fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
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
+	if (hwirq + nr_irqs > SUN6I_NR_HWIRQS)
+		return -EINVAL;
+
+	/* Construct a GIC-compatible fwspec from this fwspec. */
+	gic_fwspec = (struct irq_fwspec) {
+		.fwnode      = domain->parent->fwnode,
+		.param_count = 3,
+		.param       = { GIC_SPI, hwirq, type },
+	};
+
+	for (i = 0; i < nr_irqs; ++i)
+		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
+					      &sun6i_r_intc_level_chip, NULL);
+
+	return irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &gic_fwspec);
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
+	writel_relaxed(SUN6I_NMI_IRQ_BIT, base + SUN6I_IRQ_ENABLE(0));
+	for (i = 1; i < BITS_TO_U32(SUN6I_NR_IRQS); ++i)
+		writel_relaxed(0, base + SUN6I_IRQ_ENABLE(i));
+}
+
+static int __init sun6i_r_intc_init(struct device_node *node,
+				    struct device_node *parent)
+{
+	struct irq_domain *domain, *parent_domain;
+	struct of_phandle_args parent_irq;
+	int ret;
+
+	/* Extract the NMI's R_INTC to GIC mapping from the OF node. */
+	ret = of_irq_parse_one(node, 0, &parent_irq);
+	if (ret)
+		return ret;
+	if (parent_irq.args_count < 3 || parent_irq.args[0] != GIC_SPI)
+		return -EINVAL;
+	nmi_hwirq = parent_irq.args[1];
+	nmi_type = parent_irq.args[2];
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
+	sun6i_r_intc_nmi_ack();
+	sun6i_r_intc_resume();
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0,
+					  SUN6I_NR_HWIRQS, node,
+					  &sun6i_r_intc_domain_ops, NULL);
+	if (!domain) {
+		pr_err("%pOF: Failed to allocate domain\n", node);
+		iounmap(base);
+		return -ENOMEM;
+	}
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

