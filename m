Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BAE2E8BAF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbhACKbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:31:52 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53985 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbhACKbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:31:51 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id EE00A5803BF;
        Sun,  3 Jan 2021 05:31:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Y4pZ6uULfhPuZ
        wkwAB7QYOSQwOvjxtBHA8kMUNhNGaQ=; b=SEe0Jy6tpZrCSbDDz2xqBElTK4U3Z
        aGMrVstJvJPmXp6jIVu/Yy9NxYU3TF5TqKKj2NHDRc66Bojq9U6wKoIZAVSR19Ep
        Lfoo7J3MV348uwfu4Z531mExY9oz8Ev518C/2I0inbRF9RA6y6lDd5IJbayl4kIQ
        rVJ7iqff8QRoSt9j6G+tebD47196O2k8EN4e6Jj5xsir6aUjnDF2O5jMGlf0YACo
        Oo7TMBhPL0OoZWBPRpKO/mTfR08igIeO6MAn7UY3V1fS4P6VkrOTmKwbyv8qA5jl
        ytdzhXKvtUd+ZUHK2lGqhsSl8I3oZ29YWxg2EVksptM7vV/uSsnxzVIiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Y4pZ6uULfhPuZwkwAB7QYOSQwOvjxtBHA8kMUNhNGaQ=; b=Qk7EZYFv
        CZlzpV42nDas2JfHP8i/MPRl1SBOXvTGWL6YMs3XOSXLAXJFKm2iFIU5041kTwOW
        jrQMsnOAGvL34xhnei93iGZMqcakVZ0FgLOJ5NpSuGy2dRK6Ogz2FNIdMG80bH3X
        cu2YafHUv3p7FUOZu6kBVof1ZYLo36nZ6WNSHTQmIZAV9+sSv6naE7P/8L2R1xhR
        xpmqpfAHNqKlIrx314Sg7tJlDKlWIwlFH30o/Bgg3WmZ3vdum7Olgaqfw/jtAiLz
        V/dcH1F0y3A5ZDtEVaA7NYX6LHZr5rwU0GeVHmkAQOEmrNOMqs1NILZ8lcXMe39K
        72HPenzFxl0+NA==
X-ME-Sender: <xms:6JzxX9g_CpADx8jtMVdoTqjQKsc3gg4K7rMU-c3GQlKiGtrSkMcCXw>
    <xme:6JzxXyBbz_wcIw_36nCaEymRD4iiund8LTLjn-p8pKB9s5ZornBgBr1gmqa9RE9yG
    Ymv-h_C09L-xO808w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:6JzxX9HkCKmYvP2lSeGFjJfOmgRT_l60tBuEAl_eFmWcTKvaXsK2MQ>
    <xmx:6JzxXySf7GlLbAn6RNkZGvfQ3CpJXaqOkrY_izvrAHhuGInk2fAy2Q>
    <xmx:6JzxX6zeLdqktbr-D-S00rPsDHjjiubdJpKRBJ9b0EZmX05D8lW-pA>
    <xmx:6JzxX1oQH9oBVbm8NGNxxDYs4ZaigpkOo7Wbssn6MgnWAj8latzSEQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 354781080066;
        Sun,  3 Jan 2021 05:31:04 -0500 (EST)
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
Subject: [PATCH v3 04/10] irqchip/sun6i-r: Add wakeup support
Date:   Sun,  3 Jan 2021 04:30:55 -0600
Message-Id: <20210103103101.33603-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103103101.33603-1-samuel@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maintain bitmaps of wake-enabled IRQs and mux inputs, and program them
to the hardware during the syscore phase of suspend and shutdown. Then
restore the original set of enabled IRQs (only the NMI) during resume.

This serves two purposes. First, it lets power management firmware
running on the ARISC coprocessor know which wakeup sources Linux wants
to have enabled. That way, it can avoid turning them off when it shuts
down the remainder of the clock tree. Second, it preconfigures the
coprocessor's interrupt controller, so the firmware's wakeup logic
is as simple as waiting for an interrupt to arrive.

The suspend/resume logic is not conditional on PM_SLEEP because it is
identical to the init/shutdown logic. Wake IRQs may be enabled during
shutdown to allow powering the board back on. As an example, see
commit a5c5e50cce9d ("Input: gpio-keys - add shutdown callback").

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/irqchip/irq-sun6i-r.c | 90 ++++++++++++++++++++++++++++++++++-
 1 file changed, 88 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index 7490ade7b254..70be0fd228c2 100644
--- a/drivers/irqchip/irq-sun6i-r.c
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -3,12 +3,14 @@
 // R_INTC driver for Allwinner A31 and newer SoCs
 //
 
+#include <linux/bitmap.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/syscore_ops.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -40,9 +42,18 @@
 
 #define SUN6I_NMI_IRQ_BIT		BIT(0)
 
+struct sun6i_r_intc_variant {
+	u32	first_mux_irq;
+	u32	nr_mux_irqs;
+	u32	mux_valid[BITS_TO_U32(SUN6I_NR_MUX_INPUTS)];
+};
+
 static void __iomem *base;
 static irq_hw_number_t nmi_hwirq;
 static u32 nmi_type;
+static DECLARE_BITMAP(wake_irq_enabled, SUN6I_NR_IRQS);
+static DECLARE_BITMAP(wake_mux_enabled, SUN6I_NR_MUX_INPUTS);
+static DECLARE_BITMAP(wake_mux_valid, SUN6I_NR_MUX_INPUTS);
 
 static struct irq_chip sun6i_r_intc_edge_chip;
 static struct irq_chip sun6i_r_intc_level_chip;
@@ -126,6 +137,21 @@ static int sun6i_r_intc_irq_set_type(struct irq_data *data, unsigned int type)
 	return irq_chip_set_type_parent(data, type);
 }
 
+static int sun6i_r_intc_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	unsigned long offset_from_nmi = data->hwirq - nmi_hwirq;
+
+	if (offset_from_nmi < SUN6I_NR_DIRECT_IRQS)
+		assign_bit(offset_from_nmi, wake_irq_enabled, on);
+	else if (test_bit(data->hwirq, wake_mux_valid))
+		assign_bit(data->hwirq, wake_mux_enabled, on);
+	else
+		/* Not wakeup capable. */
+		return -EPERM;
+
+	return 0;
+}
+
 static struct irq_chip sun6i_r_intc_edge_chip = {
 	.name			= "sun6i-r-intc",
 	.irq_mask		= sun6i_r_intc_irq_mask,
@@ -135,6 +161,7 @@ static struct irq_chip sun6i_r_intc_edge_chip = {
 	.irq_set_type		= sun6i_r_intc_irq_set_type,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
 	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.flags			= IRQCHIP_SET_TYPE_MASKED,
 };
@@ -148,6 +175,7 @@ static struct irq_chip sun6i_r_intc_level_chip = {
 	.irq_set_type		= sun6i_r_intc_irq_set_type,
 	.irq_get_irqchip_state	= irq_chip_get_parent_state,
 	.irq_set_irqchip_state	= irq_chip_set_parent_state,
+	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
 	.irq_set_vcpu_affinity	= irq_chip_set_vcpu_affinity_parent,
 	.flags			= IRQCHIP_SET_TYPE_MASKED,
 };
@@ -212,6 +240,22 @@ static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
+static int sun6i_r_intc_suspend(void)
+{
+	u32 buf[BITS_TO_U32(max(SUN6I_NR_IRQS, SUN6I_NR_MUX_INPUTS))];
+	int i;
+
+	/* Wake IRQs are enabled during system sleep and shutdown. */
+	bitmap_to_arr32(buf, wake_irq_enabled, SUN6I_NR_IRQS);
+	for (i = 0; i < BITS_TO_U32(SUN6I_NR_IRQS); ++i)
+		writel_relaxed(buf[i], base + SUN6I_IRQ_ENABLE(i));
+	bitmap_to_arr32(buf, wake_mux_enabled, SUN6I_NR_MUX_INPUTS);
+	for (i = 0; i < BITS_TO_U32(SUN6I_NR_MUX_INPUTS); ++i)
+		writel_relaxed(buf[i], base + SUN6I_MUX_ENABLE(i));
+
+	return 0;
+}
+
 static void sun6i_r_intc_resume(void)
 {
 	int i;
@@ -222,8 +266,20 @@ static void sun6i_r_intc_resume(void)
 		writel_relaxed(0, base + SUN6I_IRQ_ENABLE(i));
 }
 
+static void sun6i_r_intc_shutdown(void)
+{
+	sun6i_r_intc_suspend();
+}
+
+static struct syscore_ops sun6i_r_intc_syscore_ops = {
+	.suspend	= sun6i_r_intc_suspend,
+	.resume		= sun6i_r_intc_resume,
+	.shutdown	= sun6i_r_intc_shutdown,
+};
+
 static int __init sun6i_r_intc_init(struct device_node *node,
-				    struct device_node *parent)
+				    struct device_node *parent,
+				    const struct sun6i_r_intc_variant *v)
 {
 	struct irq_domain *domain, *parent_domain;
 	struct of_phandle_args parent_irq;
@@ -253,6 +309,9 @@ static int __init sun6i_r_intc_init(struct device_node *node,
 	sun6i_r_intc_nmi_ack();
 	sun6i_r_intc_resume();
 
+	bitmap_set(wake_irq_enabled, v->first_mux_irq, v->nr_mux_irqs);
+	bitmap_from_arr32(wake_mux_valid, v->mux_valid, SUN6I_NR_MUX_INPUTS);
+
 	domain = irq_domain_add_hierarchy(parent_domain, 0,
 					  SUN6I_NR_HWIRQS, node,
 					  &sun6i_r_intc_domain_ops, NULL);
@@ -262,6 +321,33 @@ static int __init sun6i_r_intc_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
+	register_syscore_ops(&sun6i_r_intc_syscore_ops);
+
 	return 0;
 }
-IRQCHIP_DECLARE(sun6i_r_intc, "allwinner,sun6i-a31-r-intc", sun6i_r_intc_init);
+
+static const struct sun6i_r_intc_variant sun6i_a31_r_intc_variant __initconst = {
+	.first_mux_irq	= 19,
+	.nr_mux_irqs	= 13,
+	.mux_valid	= { 0xffffffff, 0xfff80000, 0xffffffff, 0x0000000f },
+};
+
+static int __init sun6i_a31_r_intc_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return sun6i_r_intc_init(node, parent, &sun6i_a31_r_intc_variant);
+}
+IRQCHIP_DECLARE(sun6i_a31_r_intc, "allwinner,sun6i-a31-r-intc", sun6i_a31_r_intc_init);
+
+static const struct sun6i_r_intc_variant sun50i_h6_r_intc_variant __initconst = {
+	.first_mux_irq	= 21,
+	.nr_mux_irqs	= 16,
+	.mux_valid	= { 0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff },
+};
+
+static int __init sun50i_h6_r_intc_init(struct device_node *node,
+					struct device_node *parent)
+{
+	return sun6i_r_intc_init(node, parent, &sun50i_h6_r_intc_variant);
+}
+IRQCHIP_DECLARE(sun50i_h6_r_intc, "allwinner,sun50i-h6-r-intc", sun50i_h6_r_intc_init);
-- 
2.26.2

