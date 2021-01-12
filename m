Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B5E2F281B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389781AbhALGAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:00:41 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:60915 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730979AbhALGAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:00:40 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 03F7E58055B;
        Tue, 12 Jan 2021 00:59:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jan 2021 00:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=/0Z5BCxz8WuCb
        22aaUC78cmR3ShB9vJmj0kAUg62Cvc=; b=LGRNbyWaqV8RcYOWwmtoUmnrXgXrJ
        9HyGVOWTvfa8mHKsCvIdLjK8U24hyzpxHj4+kIAchGNmE4BJnfsmtn4+5jEKyrro
        Xmepvl8aGTTzcuykfS5O4k2vsFwoTbjzOyo04wNzgm3RspA25JN8ayodVpTQkvE5
        WlidxcXmPoQ1ul2eEPEADI5NzYTPHW8X7IpUkMIK6enFAR8xzuLtwHtENZ+8CX2u
        HoL/4k6Sb9ticBSssPOUTKf2hEOSIxmLBK5qilbpN7qv1WoFC8ntce/q5q4aW7sm
        XeKaj0iUw2ildvfDKQ14ao3TKprMAAt/zvxdgWRgqW6JxnSFA8DcLGTOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=/0Z5BCxz8WuCb22aaUC78cmR3ShB9vJmj0kAUg62Cvc=; b=ojQ7ilTQ
        vyIo5A2nfTHOmPrhNJhYjeADBa3wuZp5vyG6Zex4E8sCF5eOV8Kq3gfoM0SVchoj
        ljcMYNvCre5uHIdXmXWH7TfMAs7oZWv+Lbm9nF3Pt7EIoKzyt8n24RD+C9nrasWx
        iaGo9jPavyPI8fLcYT2xF9GRybV9AqXTmY2JStOkiDLe6JbBfK1r/CWGZoQFsfmA
        lxdRTV/CCiT/tA8RS2NsvMm96ueUUCJ21lUWExZ/CPbT1qnqEvr8tjpZN+cVIATc
        uo20pqRdFcrFn0tGSrWmzVFXworbr2mqvMQb0Zf2ghGBc2kqeE3es4et7uPq8QMj
        JNZK+GSKxNm77w==
X-ME-Sender: <xms:2Tr9X0muRa03xd1NzuTx2VFVfYYNrF6KsiA_BNku-9Jk4SwbxRynAw>
    <xme:2Tr9Xz3ngqKvLpmm_AvpTT8TK5fHECkcNQhXXwNK1rxLRKAP_yNwe-RAbY4OE9EIn
    9QcZzDuW9EbUgJ_Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:2Tr9XyqbGddM1B4PTv8TfD9VIOeNvVCjwkBWg0vS15C8NH6ERTN7IA>
    <xmx:2Tr9Xwk56lLiw6FyRk6g2tnFKb0fx0u_c-DQBNjqjAL5yNYFF9wQ1g>
    <xmx:2Tr9Xy0jiFtVaETwbRhvwxh-_7g2VDRoO7c68eWH2AySrVLAbSlsMw>
    <xmx:2Tr9XzKibRfHk3P9lJOZcnT1LvT7ZahiqkCHb2FEtHUcJHi8ujMPWg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5431F24005B;
        Tue, 12 Jan 2021 00:59:53 -0500 (EST)
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
Subject: [PATCH v4 04/10] irqchip/sun6i-r: Add wakeup support
Date:   Mon, 11 Jan 2021 23:59:44 -0600
Message-Id: <20210112055950.21209-5-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112055950.21209-1-samuel@sholland.org>
References: <20210112055950.21209-1-samuel@sholland.org>
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
 drivers/irqchip/irq-sun6i-r.c | 107 ++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-sun6i-r.c b/drivers/irqchip/irq-sun6i-r.c
index d04d067423f4..a1b58c98d6ca 100644
--- a/drivers/irqchip/irq-sun6i-r.c
+++ b/drivers/irqchip/irq-sun6i-r.c
@@ -39,6 +39,7 @@
  * set of 128 mux bits. This requires a second set of top-level registers.
  */
 
+#include <linux/bitmap.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
@@ -46,6 +47,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/syscore_ops.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
@@ -67,8 +69,17 @@
 #define SUN6I_NR_DIRECT_IRQS		16
 #define SUN6I_NR_MUX_BITS		128
 
+struct sun6i_r_intc_variant {
+	u32		first_mux_irq;
+	u32		nr_mux_irqs;
+	u32		mux_valid[BITS_TO_U32(SUN6I_NR_MUX_BITS)];
+};
+
 static void __iomem *base;
 static irq_hw_number_t nmi_hwirq;
+static DECLARE_BITMAP(wake_irq_enabled, SUN6I_NR_TOP_LEVEL_IRQS);
+static DECLARE_BITMAP(wake_mux_enabled, SUN6I_NR_MUX_BITS);
+static DECLARE_BITMAP(wake_mux_valid, SUN6I_NR_MUX_BITS);
 
 static void sun6i_r_intc_ack_nmi(void)
 {
@@ -145,6 +156,21 @@ static int sun6i_r_intc_nmi_set_irqchip_state(struct irq_data *data,
 	return irq_chip_set_parent_state(data, which, state);
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
 static struct irq_chip sun6i_r_intc_nmi_chip = {
 	.name			= "sun6i-r-intc",
 	.irq_ack		= sun6i_r_intc_nmi_ack,
@@ -154,8 +180,19 @@ static struct irq_chip sun6i_r_intc_nmi_chip = {
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 	.irq_set_type		= sun6i_r_intc_nmi_set_type,
 	.irq_set_irqchip_state	= sun6i_r_intc_nmi_set_irqchip_state,
-	.flags			= IRQCHIP_SET_TYPE_MASKED |
-				  IRQCHIP_SKIP_SET_WAKE,
+	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
+};
+
+static struct irq_chip sun6i_r_intc_wakeup_chip = {
+	.name			= "sun6i-r-intc",
+	.irq_mask		= irq_chip_mask_parent,
+	.irq_unmask		= irq_chip_unmask_parent,
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= irq_chip_set_affinity_parent,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_wake		= sun6i_r_intc_irq_set_wake,
+	.flags			= IRQCHIP_SET_TYPE_MASKED,
 };
 
 static int sun6i_r_intc_domain_translate(struct irq_domain *domain,
@@ -215,8 +252,8 @@ static int sun6i_r_intc_domain_alloc(struct irq_domain *domain,
 						      &sun6i_r_intc_nmi_chip, 0);
 			irq_set_handler(virq, handle_fasteoi_ack_irq);
 		} else {
-			/* Only the NMI is currently supported. */
-			return -EINVAL;
+			irq_domain_set_hwirq_and_chip(domain, virq, hwirq,
+						      &sun6i_r_intc_wakeup_chip, 0);
 		}
 	}
 
@@ -229,6 +266,22 @@ static const struct irq_domain_ops sun6i_r_intc_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
+static int sun6i_r_intc_suspend(void)
+{
+	u32 buf[BITS_TO_U32(max(SUN6I_NR_TOP_LEVEL_IRQS, SUN6I_NR_MUX_BITS))];
+	int i;
+
+	/* Wake IRQs are enabled during system sleep and shutdown. */
+	bitmap_to_arr32(buf, wake_irq_enabled, SUN6I_NR_TOP_LEVEL_IRQS);
+	for (i = 0; i < BITS_TO_U32(SUN6I_NR_TOP_LEVEL_IRQS); ++i)
+		writel_relaxed(buf[i], base + SUN6I_IRQ_ENABLE(i));
+	bitmap_to_arr32(buf, wake_mux_enabled, SUN6I_NR_MUX_BITS);
+	for (i = 0; i < BITS_TO_U32(SUN6I_NR_MUX_BITS); ++i)
+		writel_relaxed(buf[i], base + SUN6I_MUX_ENABLE(i));
+
+	return 0;
+}
+
 static void sun6i_r_intc_resume(void)
 {
 	int i;
@@ -239,8 +292,20 @@ static void sun6i_r_intc_resume(void)
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
 	struct of_phandle_args nmi_parent;
@@ -256,6 +321,9 @@ static int __init sun6i_r_intc_init(struct device_node *node,
 		return -EINVAL;
 	nmi_hwirq = nmi_parent.args[1];
 
+	bitmap_set(wake_irq_enabled, v->first_mux_irq, v->nr_mux_irqs);
+	bitmap_from_arr32(wake_mux_valid, v->mux_valid, SUN6I_NR_MUX_BITS);
+
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		pr_err("%pOF: Failed to obtain parent domain\n", node);
@@ -276,9 +344,36 @@ static int __init sun6i_r_intc_init(struct device_node *node,
 		return -ENOMEM;
 	}
 
+	register_syscore_ops(&sun6i_r_intc_syscore_ops);
+
 	sun6i_r_intc_ack_nmi();
 	sun6i_r_intc_resume();
 
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

