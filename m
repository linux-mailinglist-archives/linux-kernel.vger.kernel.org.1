Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455CB2E8BDB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 12:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhACLHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 06:07:36 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33389 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbhACLHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 06:07:25 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id AF126514;
        Sun,  3 Jan 2021 06:06:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 06:06:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=7SvhTIDFXD6wc
        1Hcq2TPDMxEHxB+DmYYUXL05Wstfc8=; b=SSM6G6BRvnEacDEyLPtxk4J1fLMku
        8k5GeCL7ttGGcKBCETs6KFhT9mV6RXumJfaWZzL9Cwz+EQlQJZsdZpGKmUI2xL7A
        9QZoiRgDiVXJZRG8Ml4zVBrQHmn/5vibAmqmRkF5WMgj0k/19z0RfvC8zAJlAgAG
        LFNfu3mpVOxZxdgTEqIuy8otmw5L8Kgvf4Pmf27JH9W/WL/TnlTObmNBOm2DLygC
        MAJsNvKvlZU/hcSXfagkarH3s66wi8/HTOg51qLLxYSsbPY7A89DmvKoTNSdohMh
        JbgNSMsjPg8JT1sYRhebE0XAAZeiO2htIo8aoYxC6stUp7zhIvWEeuN/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=7SvhTIDFXD6wc1Hcq2TPDMxEHxB+DmYYUXL05Wstfc8=; b=acrkg0Fm
        iI9N1ScvTG9oC0/1K30sKXAPO6qqq0t4Pmftd2yLA4itcEWPgriW6JHMVpHn5KCi
        YNFUNSsB9lmBtR6KKBTpzktMQOZSs56kLUZtWb8klRAWi7Apomb/Y89W5JaWx4Zb
        xWapKgUZto9wAi7F7/Hcuqi8jaI6jzf8KGIwc+l98MJG6isTJDHePYDh1bAGAPc5
        kLXzZ32PEK0NIw/yk+yTEcWl1eTCJ+4AQpRnUzp0WZsLW48IG/DeM57GOCOyjwdS
        RhrJYUla9zIq9T73nAkoNLwwR7y9YbBl7LWm5hmDg/SmWn+NWcxiFW2EXoxjIJKl
        yuc94ekw4LiqEQ==
X-ME-Sender: <xms:PaXxX1T0vc_wOGCBviEpK45rKaFwFK6koZtrtvNbiC-rKoh1m51pIA>
    <xme:PaXxX-ybynqMABVPiYLZateHQJ_LqzeCxmlZrdJsEr9ezS2TLFLLynYsvSIqAPgdP
    foOp6Kl7hLpG0lmng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:PaXxX63DSq2lFrKREm3q-j_SVWCpu-Lfm8sB59cOnlezoT8qMMROhw>
    <xmx:PaXxX9AqAqPiUrPcH927xs0wgDb0qgPffsvVhhBLWvfKjNQQV9sjFw>
    <xmx:PaXxX-jeZm7_7BPvFhuN7k5Z0lLA_51mNnOleHqN0-Y6jOFjc4N4kA>
    <xmx:PqXxXwajSs33lbK3ploMAQkcXaIp98gqFIcJpBSzBfetVZ1yPuYtFw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC83F24005D;
        Sun,  3 Jan 2021 06:06:36 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 2/4] bus: sunxi-rsb: Split out controller init/exit functions
Date:   Sun,  3 Jan 2021 05:06:33 -0600
Message-Id: <20210103110635.34823-3-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103110635.34823-1-samuel@sholland.org>
References: <20210103110635.34823-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This separates the resource acquisition from the hardware initialization
phase, so the hardware initialization can be repeated after system
suspend/resume. The same is done for the exit/remove function, except
that there is no resource deallocation phase due to the use of devres.

The requested RSB clock frequency is stored in `struct sunxi_rsb` so it
will be available when reinitializing the hardware.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/bus/sunxi-rsb.c | 127 ++++++++++++++++++++++------------------
 1 file changed, 71 insertions(+), 56 deletions(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index c13340cab27a..3f290da45619 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -126,6 +126,7 @@ struct sunxi_rsb {
 	struct completion complete;
 	struct mutex lock;
 	unsigned int status;
+	u32 clk_freq;
 };
 
 /* bus / slave device related functions */
@@ -614,16 +615,74 @@ static int of_rsb_register_devices(struct sunxi_rsb *rsb)
 	return 0;
 }
 
+static int sunxi_rsb_hw_init(struct sunxi_rsb *rsb)
+{
+	struct device *dev = rsb->dev;
+	unsigned long p_clk_freq;
+	u32 clk_delay, reg;
+	int clk_div, ret;
+
+	ret = clk_prepare_enable(rsb->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clk: %d\n", ret);
+		return ret;
+	}
+
+	ret = reset_control_deassert(rsb->rstc);
+	if (ret) {
+		dev_err(dev, "failed to deassert reset line: %d\n", ret);
+		goto err_clk_disable;
+	}
+
+	/* reset the controller */
+	writel(RSB_CTRL_SOFT_RST, rsb->regs + RSB_CTRL);
+	readl_poll_timeout(rsb->regs + RSB_CTRL, reg,
+			   !(reg & RSB_CTRL_SOFT_RST), 1000, 100000);
+
+	/*
+	 * Clock frequency and delay calculation code is from
+	 * Allwinner U-boot sources.
+	 *
+	 * From A83 user manual:
+	 * bus clock frequency = parent clock frequency / (2 * (divider + 1))
+	 */
+	p_clk_freq = clk_get_rate(rsb->clk);
+	clk_div = p_clk_freq / rsb->clk_freq / 2;
+	if (!clk_div)
+		clk_div = 1;
+	else if (clk_div > RSB_CCR_MAX_CLK_DIV + 1)
+		clk_div = RSB_CCR_MAX_CLK_DIV + 1;
+
+	clk_delay = clk_div >> 1;
+	if (!clk_delay)
+		clk_delay = 1;
+
+	dev_info(dev, "RSB running at %lu Hz\n", p_clk_freq / clk_div / 2);
+	writel(RSB_CCR_SDA_OUT_DELAY(clk_delay) | RSB_CCR_CLK_DIV(clk_div - 1),
+	       rsb->regs + RSB_CCR);
+
+	return 0;
+
+err_clk_disable:
+	clk_disable_unprepare(rsb->clk);
+
+	return ret;
+}
+
+static void sunxi_rsb_hw_exit(struct sunxi_rsb *rsb)
+{
+	reset_control_assert(rsb->rstc);
+	clk_disable_unprepare(rsb->clk);
+}
+
 static int sunxi_rsb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct resource *r;
 	struct sunxi_rsb *rsb;
-	unsigned long p_clk_freq;
-	u32 clk_delay, clk_freq = 3000000;
-	int clk_div, irq, ret;
-	u32 reg;
+	u32 clk_freq = 3000000;
+	int irq, ret;
 
 	of_property_read_u32(np, "clock-frequency", &clk_freq);
 	if (clk_freq > RSB_MAX_FREQ) {
@@ -638,6 +697,7 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	rsb->dev = dev;
+	rsb->clk_freq = clk_freq;
 	platform_set_drvdata(pdev, rsb);
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	rsb->regs = devm_ioremap_resource(dev, r);
@@ -655,63 +715,27 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(rsb->clk);
-	if (ret) {
-		dev_err(dev, "failed to enable clk: %d\n", ret);
-		return ret;
-	}
-
-	p_clk_freq = clk_get_rate(rsb->clk);
-
 	rsb->rstc = devm_reset_control_get(dev, NULL);
 	if (IS_ERR(rsb->rstc)) {
 		ret = PTR_ERR(rsb->rstc);
 		dev_err(dev, "failed to retrieve reset controller: %d\n", ret);
-		goto err_clk_disable;
-	}
-
-	ret = reset_control_deassert(rsb->rstc);
-	if (ret) {
-		dev_err(dev, "failed to deassert reset line: %d\n", ret);
-		goto err_clk_disable;
+		return ret;
 	}
 
 	init_completion(&rsb->complete);
 	mutex_init(&rsb->lock);
 
-	/* reset the controller */
-	writel(RSB_CTRL_SOFT_RST, rsb->regs + RSB_CTRL);
-	readl_poll_timeout(rsb->regs + RSB_CTRL, reg,
-			   !(reg & RSB_CTRL_SOFT_RST), 1000, 100000);
-
-	/*
-	 * Clock frequency and delay calculation code is from
-	 * Allwinner U-boot sources.
-	 *
-	 * From A83 user manual:
-	 * bus clock frequency = parent clock frequency / (2 * (divider + 1))
-	 */
-	clk_div = p_clk_freq / clk_freq / 2;
-	if (!clk_div)
-		clk_div = 1;
-	else if (clk_div > RSB_CCR_MAX_CLK_DIV + 1)
-		clk_div = RSB_CCR_MAX_CLK_DIV + 1;
-
-	clk_delay = clk_div >> 1;
-	if (!clk_delay)
-		clk_delay = 1;
-
-	dev_info(dev, "RSB running at %lu Hz\n", p_clk_freq / clk_div / 2);
-	writel(RSB_CCR_SDA_OUT_DELAY(clk_delay) | RSB_CCR_CLK_DIV(clk_div - 1),
-	       rsb->regs + RSB_CCR);
-
 	ret = devm_request_irq(dev, irq, sunxi_rsb_irq, 0, RSB_CTRL_NAME, rsb);
 	if (ret) {
 		dev_err(dev, "can't register interrupt handler irq %d: %d\n",
 			irq, ret);
-		goto err_reset_assert;
+		return ret;
 	}
 
+	ret = sunxi_rsb_hw_init(rsb);
+	if (ret)
+		return ret;
+
 	/* initialize all devices on the bus into RSB mode */
 	ret = sunxi_rsb_init_device_mode(rsb);
 	if (ret)
@@ -720,14 +744,6 @@ static int sunxi_rsb_probe(struct platform_device *pdev)
 	of_rsb_register_devices(rsb);
 
 	return 0;
-
-err_reset_assert:
-	reset_control_assert(rsb->rstc);
-
-err_clk_disable:
-	clk_disable_unprepare(rsb->clk);
-
-	return ret;
 }
 
 static int sunxi_rsb_remove(struct platform_device *pdev)
@@ -735,8 +751,7 @@ static int sunxi_rsb_remove(struct platform_device *pdev)
 	struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
 
 	device_for_each_child(rsb->dev, NULL, sunxi_rsb_remove_devices);
-	reset_control_assert(rsb->rstc);
-	clk_disable_unprepare(rsb->clk);
+	sunxi_rsb_hw_exit(rsb);
 
 	return 0;
 }
-- 
2.26.2

