Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE741F91E2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 10:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgFOIm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 04:42:28 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:36147 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729253AbgFOIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:41:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id D204358014E;
        Mon, 15 Jun 2020 04:41:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 15 Jun 2020 04:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=jpsBvSjuZdjvu
        Uz+m34CG84fqvLwMCFTvls5DmLjq4c=; b=cSYrBtUwSjsUuSpUf9cMDu9qF/g4r
        EMmMHl/OARZ7PCXee97bZcLtBPyJhYcIRjCGsqPmj4m1lbt7YKDFHA6YN1Ms0rxl
        6iaSsutDR5bnpPlaHm2495bEK9aKoV49WJyfYl9nho+xyLpAgPSfZSuyFlk61YTw
        IV9vSHfytByfaNHAhzaqWR7Jn6Kf26CsxcdrvLIxl4xEAuLwpp+i29f4Cb2TLyqb
        tf6nnBGZEQmkh6AJYELk035DM/N4q4zdHtyItETCc/4K8m6lZMRE1dU5PWUdIhw5
        nslj4Vayl1R1egwicGtH0n9yx2SEDW1ZeXs/wH5V7LwlusP+j7aP9CUoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=jpsBvSjuZdjvuUz+m34CG84fqvLwMCFTvls5DmLjq4c=; b=UMDzrofU
        7fcVM79C80AZnxW3q/IKjL48HSyCqk3rurvjUpNaHkwKhtOJQ51JEmeYqfxKYO7+
        JKu1Xi2G6j4x5gwiVKbEVwm5PISzYB/Ne2oDQgzn2/rmg6XU50a13t3x0DJaawAo
        DcOyFpu9Qqef6YHgDaaJza5rcwbTVjvXU0+UK54pZ2QxvQdBe4VjuW8QE05XzYEV
        mqIQ1lWZEds5S25BzvSrKGdJbzpfsh6eaN7+g+ksiKI1kz0SHq/sicR4qneuOwci
        J4hV3DpIGlYeEnlavhHzQl5cKQc9PfoYq1c5w7kJoBgua8vA/0FGstYUfRP9n9tT
        0EFZP6+1SleuUA==
X-ME-Sender: <xms:UTTnXndIvUXbqkSPDFtz9axO2WBTXIPJxnAy75iGbmvXbakyMx6PKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeikedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UTTnXtPgXAjdcXdUTB3e0KwW20XdAusyE0Wd9Qd9RwCKb8CfPt701g>
    <xmx:UTTnXgikbTWZVpdLEplOo7UOKJB1Z9IUYvktvhTNzI_biQbZpagf4A>
    <xmx:UTTnXo9zUa1zXf2QzE5vsH81gsDWvna0s-FHpJa8SKE2bp5zrTEZ4Q>
    <xmx:UTTnXhKWdr5WHXfV1YF-eA9_pPWOwDv501z34YXhsaA2OFGVW_oGRg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E6E53060F09;
        Mon, 15 Jun 2020 04:41:53 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v5 21/27] clk: bcm: rpi: Discover the firmware clocks
Date:   Mon, 15 Jun 2020 10:41:01 +0200
Message-Id: <438d73962741a8c5f7c689319b7443b930a87fde.1592210452.git-series.maxime@cerno.tech>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RaspberryPi4 firmware actually exposes more clocks than are currently
handled by the driver and we will need to change some of them directly
based on the pixel rate for the display related clocks, or the load for the
GPU.

Since the firmware implements DVFS, this rate change can have a number of
side-effects, including adjusting the various PLL voltages or the PLL
parents. The firmware also implements thermal throttling, so even some
thermal pressure can change those parameters behind Linux back.

DVFS is currently implemented on the arm, core, h264, v3d, isp and hevc
clocks, so updating any of them using the MMIO driver (and thus behind the
firmware's back) can lead to troubles, the arm clock obviously being the
most problematic.

In order to make Linux play as nice as possible with those constraints, it
makes sense to rely on the firmware clocks as much as possible. However,
the firmware doesn't seem to provide some equivalents to their MMIO
counterparts, so we can't really replace that driver entirely.

Fortunately, the firmware has an interface to discover the clocks it
exposes.

Let's use it to discover, register the clocks in the clocks framework and
then expose them through the device tree for consumers to use them.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/bcm/clk-raspberrypi.c | 153 ++++++++++++++++++++++++++++---
 1 file changed, 141 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index eebd16040f8a..11a62bde5203 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -296,6 +296,144 @@ static struct clk_hw *raspberrypi_register_pllb_arm(struct raspberrypi_clk *rpi)
 	return &raspberrypi_clk_pllb_arm.hw;
 }
 
+static int raspberrypi_fw_dumb_determine_rate(struct clk_hw *hw,
+					      struct clk_rate_request *req)
+{
+	/*
+	 * The firmware will do the rounding but that isn't part of
+	 * the interface with the firmware, so we just do our best
+	 * here.
+	 */
+	req->rate = clamp(req->rate, req->min_rate, req->max_rate);
+	return 0;
+}
+
+static const struct clk_ops raspberrypi_firmware_clk_ops = {
+	.is_prepared	= raspberrypi_fw_is_prepared,
+	.recalc_rate	= raspberrypi_fw_get_rate,
+	.determine_rate	= raspberrypi_fw_dumb_determine_rate,
+	.set_rate	= raspberrypi_fw_set_rate,
+};
+
+static struct clk_hw *raspberrypi_clk_register(struct raspberrypi_clk *rpi,
+					       unsigned int parent,
+					       unsigned int id)
+{
+	struct raspberrypi_clk_data *data;
+	struct clk_init_data init = {};
+	u32 min_rate, max_rate;
+	int ret;
+
+	if (id == RPI_FIRMWARE_ARM_CLK_ID) {
+		struct clk_hw *hw;
+
+		hw = raspberrypi_register_pllb(rpi);
+		if (IS_ERR(hw)) {
+			dev_err(rpi->dev, "Failed to initialize pllb, %ld\n",
+				PTR_ERR(hw));
+			return hw;
+		}
+
+		return raspberrypi_register_pllb_arm(rpi);
+	}
+
+	data = devm_kzalloc(rpi->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return ERR_PTR(-ENOMEM);
+	data->rpi = rpi;
+	data->id = id;
+
+	init.name = devm_kasprintf(rpi->dev, GFP_KERNEL, "fw-clk-%u", id);
+	init.ops = &raspberrypi_firmware_clk_ops;
+	init.flags = CLK_GET_RATE_NOCACHE;
+
+	data->hw.init = &init;
+
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_MIN_CLOCK_RATE,
+					 &min_rate);
+	if (ret) {
+		dev_err(rpi->dev, "Failed to get clock %d min freq: %d",
+			id, ret);
+		return ERR_PTR(ret);
+	}
+
+	ret = raspberrypi_clock_property(rpi->firmware, data,
+					 RPI_FIRMWARE_GET_MAX_CLOCK_RATE,
+					 &max_rate);
+	if (ret) {
+		dev_err(rpi->dev, "Failed to get clock %d max freq: %d\n",
+			id, ret);
+		return ERR_PTR(ret);
+	}
+
+	ret = devm_clk_hw_register(rpi->dev, &data->hw);
+	if (ret)
+		return ERR_PTR(ret);
+
+	clk_hw_set_rate_range(&data->hw, min_rate, max_rate);
+
+	if (id == RPI_FIRMWARE_ARM_CLK_ID) {
+		ret = devm_clk_hw_register_clkdev(rpi->dev, &data->hw,
+						  NULL, "cpu0");
+		if (ret) {
+			dev_err(rpi->dev, "Failed to initialize clkdev\n");
+			return ERR_PTR(ret);
+		}
+	}
+
+	return &data->hw;
+}
+
+struct rpi_firmware_get_clocks_response {
+	u32 parent;
+	u32 id;
+};
+
+static int raspberrypi_discover_clocks(struct raspberrypi_clk *rpi,
+				       struct clk_hw_onecell_data *data)
+{
+	struct rpi_firmware_get_clocks_response *clks;
+	int ret;
+
+	clks = devm_kcalloc(rpi->dev,
+			    sizeof(*clks), RPI_FIRMWARE_NUM_CLK_ID,
+			    GFP_KERNEL);
+	if (!clks)
+		return -ENOMEM;
+
+	ret = rpi_firmware_property(rpi->firmware, RPI_FIRMWARE_GET_CLOCKS,
+				    clks,
+				    sizeof(*clks) * RPI_FIRMWARE_NUM_CLK_ID);
+	if (ret)
+		return ret;
+
+	while (clks->id) {
+		struct clk_hw *hw;
+
+		switch (clks->id) {
+		case RPI_FIRMWARE_ARM_CLK_ID:
+		case RPI_FIRMWARE_CORE_CLK_ID:
+		case RPI_FIRMWARE_M2MC_CLK_ID:
+		case RPI_FIRMWARE_V3D_CLK_ID:
+			hw = raspberrypi_clk_register(rpi, clks->parent,
+						      clks->id);
+			if (IS_ERR(hw))
+				return PTR_ERR(hw);
+
+			data->hws[clks->id] = hw;
+			data->num = clks->id + 1;
+			fallthrough;
+
+		default:
+			clks++;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int raspberrypi_clk_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -303,7 +441,6 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *firmware;
 	struct raspberrypi_clk *rpi;
-	struct clk_hw *hw;
 	int ret;
 
 	/*
@@ -340,17 +477,9 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 	if (!clk_data)
 		return -ENOMEM;
 
-	hw = raspberrypi_register_pllb(rpi);
-	if (IS_ERR(hw)) {
-		dev_err(dev, "Failed to initialize pllb, %ld\n", PTR_ERR(hw));
-		return PTR_ERR(hw);
-	}
-
-	hw = raspberrypi_register_pllb_arm(rpi);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
-	clk_data->hws[RPI_FIRMWARE_ARM_CLK_ID] = hw;
-	clk_data->num = RPI_FIRMWARE_ARM_CLK_ID + 1;
+	ret = raspberrypi_discover_clocks(rpi, clk_data);
+	if (ret)
+		return ret;
 
 	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 					  clk_data);
-- 
git-series 0.9.1
