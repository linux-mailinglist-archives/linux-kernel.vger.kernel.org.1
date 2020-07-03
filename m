Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367E0213E1F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 19:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgGCRFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 13:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgGCRFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:05:23 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06392C061794;
        Fri,  3 Jul 2020 10:05:23 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id ga4so34923019ejb.11;
        Fri, 03 Jul 2020 10:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B7NBrdc7VXVNc0FDEMqTWiO6aTnKq9Ylxgg36xB6XLk=;
        b=guGCDufGhATBWSaqg4zJ1p49wZYXb+HGR88LOsxk08rjf6EM4z/cbJn2aGxOQXrjtc
         I84TSYrmoWRTbS4XcH7GSHyiFg46uAJISxk76MNE3nzOsydm9hj6RxArPW1OrTIVxXCK
         lYHa3+3acQ8pmTE3XuqoG8fQDUiAcDBInkkknAI4mYero/noYwtct1GOsckMgHLTqUo+
         LECS+rMXXo9q+019Kp1FjoEUZuDijdl23VHlfg3kvDUf/a5UZl8vfcld1oHDtmz/pvwk
         7Uv02zjD3YRfQN7xZababJBI/mOlaINAD+jsV4m8nmjPAGYVzu3TdRTt5GOECIfkfKUT
         ObdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B7NBrdc7VXVNc0FDEMqTWiO6aTnKq9Ylxgg36xB6XLk=;
        b=n2lg+N6lFoo/4f9Ynb8m6wPID6ukhKXQj6hznxJaCfAiMLrU2Dl0yjJrhDY/o+s6wY
         TIs6w7EqGmZ0vVjACPikpi7P7hlxu7FmJ0QPC3Xpk7ol8gh1IS8r+HUdX3xb2qPo+NmK
         ce8Yl9B/z/Djueak2fcUUg7DSsEsSUuDYg8L4/MpHKggGQJh32EKKKKNMz1+H+P0CILW
         66npNav7lPwZiM7WqKuarboQ+CQ76gQkJI5fzEzqPFKw1fn4pynlRGexQLYc64tRsDIy
         DVDrL6MlbXrGGJxXnWtoA1CIHcjyJuxsbdVfOU7UJ4MNI5QkduuXEAFpdXk9bsRqhymC
         qiFA==
X-Gm-Message-State: AOAM530ed8zjtPAyY8Dw6YVq08JwZLS6AV2g7QdJsJIqEB8LcYTadQMx
        HrNERPzzhfcn26WpFLXtg44=
X-Google-Smtp-Source: ABdhPJynmwimCQc9kbDJSuDutP9tWbkwH5OwyiRj2aooovH/QVWHdulitJ81cNmf162JfbFhfknb0g==
X-Received: by 2002:a17:906:1455:: with SMTP id q21mr16587339ejc.139.1593795921770;
        Fri, 03 Jul 2020 10:05:21 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id dg8sm14342272edb.56.2020.07.03.10.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 10:05:21 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: [PATCH v3 5/6] clk: actions: Add Actions S500 SoC Reset Management Unit support
Date:   Fri,  3 Jul 2020 20:05:11 +0300
Message-Id: <3fba2e6f0edfac97cb8c6ce60f95c24852578eac.1593788312.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Management Unit (RMU) support for Actions Semi S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Changes in v3:
 - Added Mani's Reviewed-by tag

Changes in v2:
 - Removed copyright as indicated by Stephen

 drivers/clk/actions/owl-s500.c | 78 ++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
index 025a8f6d6482..61bb224f6330 100644
--- a/drivers/clk/actions/owl-s500.c
+++ b/drivers/clk/actions/owl-s500.c
@@ -23,8 +23,10 @@
 #include "owl-gate.h"
 #include "owl-mux.h"
 #include "owl-pll.h"
+#include "owl-reset.h"
 
 #include <dt-bindings/clock/actions,s500-cmu.h>
+#include <dt-bindings/reset/actions,s500-reset.h>
 
 #define CMU_COREPLL			(0x0000)
 #define CMU_DEVPLL			(0x0004)
@@ -497,20 +499,96 @@ static struct clk_hw_onecell_data s500_hw_clks = {
 	.num = CLK_NR_CLKS,
 };
 
+static const struct owl_reset_map s500_resets[] = {
+	[RESET_DMAC]	= { CMU_DEVRST0, BIT(0) },
+	[RESET_NORIF]	= { CMU_DEVRST0, BIT(1) },
+	[RESET_DDR]	= { CMU_DEVRST0, BIT(2) },
+	[RESET_NANDC]	= { CMU_DEVRST0, BIT(3) },
+	[RESET_SD0]	= { CMU_DEVRST0, BIT(4) },
+	[RESET_SD1]	= { CMU_DEVRST0, BIT(5) },
+	[RESET_PCM1]	= { CMU_DEVRST0, BIT(6) },
+	[RESET_DE]	= { CMU_DEVRST0, BIT(7) },
+	[RESET_LCD]	= { CMU_DEVRST0, BIT(8) },
+	[RESET_SD2]	= { CMU_DEVRST0, BIT(9) },
+	[RESET_DSI]	= { CMU_DEVRST0, BIT(10) },
+	[RESET_CSI]	= { CMU_DEVRST0, BIT(11) },
+	[RESET_BISP]	= { CMU_DEVRST0, BIT(12) },
+	[RESET_KEY]	= { CMU_DEVRST0, BIT(14) },
+	[RESET_GPIO]	= { CMU_DEVRST0, BIT(15) },
+	[RESET_AUDIO]	= { CMU_DEVRST0, BIT(17) },
+	[RESET_PCM0]	= { CMU_DEVRST0, BIT(18) },
+	[RESET_VDE]	= { CMU_DEVRST0, BIT(19) },
+	[RESET_VCE]	= { CMU_DEVRST0, BIT(20) },
+	[RESET_GPU3D]	= { CMU_DEVRST0, BIT(22) },
+	[RESET_NIC301]	= { CMU_DEVRST0, BIT(23) },
+	[RESET_LENS]	= { CMU_DEVRST0, BIT(26) },
+	[RESET_PERIPHRESET] = { CMU_DEVRST0, BIT(27) },
+	[RESET_USB2_0]	= { CMU_DEVRST1, BIT(0) },
+	[RESET_TVOUT]	= { CMU_DEVRST1, BIT(1) },
+	[RESET_HDMI]	= { CMU_DEVRST1, BIT(2) },
+	[RESET_HDCP2TX]	= { CMU_DEVRST1, BIT(3) },
+	[RESET_UART6]	= { CMU_DEVRST1, BIT(4) },
+	[RESET_UART0]	= { CMU_DEVRST1, BIT(5) },
+	[RESET_UART1]	= { CMU_DEVRST1, BIT(6) },
+	[RESET_UART2]	= { CMU_DEVRST1, BIT(7) },
+	[RESET_SPI0]	= { CMU_DEVRST1, BIT(8) },
+	[RESET_SPI1]	= { CMU_DEVRST1, BIT(9) },
+	[RESET_SPI2]	= { CMU_DEVRST1, BIT(10) },
+	[RESET_SPI3]	= { CMU_DEVRST1, BIT(11) },
+	[RESET_I2C0]	= { CMU_DEVRST1, BIT(12) },
+	[RESET_I2C1]	= { CMU_DEVRST1, BIT(13) },
+	[RESET_USB3]	= { CMU_DEVRST1, BIT(14) },
+	[RESET_UART3]	= { CMU_DEVRST1, BIT(15) },
+	[RESET_UART4]	= { CMU_DEVRST1, BIT(16) },
+	[RESET_UART5]	= { CMU_DEVRST1, BIT(17) },
+	[RESET_I2C2]	= { CMU_DEVRST1, BIT(18) },
+	[RESET_I2C3]	= { CMU_DEVRST1, BIT(19) },
+	[RESET_ETHERNET] = { CMU_DEVRST1, BIT(20) },
+	[RESET_CHIPID]	= { CMU_DEVRST1, BIT(21) },
+	[RESET_USB2_1]	= { CMU_DEVRST1, BIT(22) },
+	[RESET_WD0RESET] = { CMU_DEVRST1, BIT(24) },
+	[RESET_WD1RESET] = { CMU_DEVRST1, BIT(25) },
+	[RESET_WD2RESET] = { CMU_DEVRST1, BIT(26) },
+	[RESET_WD3RESET] = { CMU_DEVRST1, BIT(27) },
+	[RESET_DBG0RESET] = { CMU_DEVRST1, BIT(28) },
+	[RESET_DBG1RESET] = { CMU_DEVRST1, BIT(29) },
+	[RESET_DBG2RESET] = { CMU_DEVRST1, BIT(30) },
+	[RESET_DBG3RESET] = { CMU_DEVRST1, BIT(31) },
+};
+
 static struct owl_clk_desc s500_clk_desc = {
 	.clks	    = s500_clks,
 	.num_clks   = ARRAY_SIZE(s500_clks),
 
 	.hw_clks    = &s500_hw_clks,
+
+	.resets     = s500_resets,
+	.num_resets = ARRAY_SIZE(s500_resets),
 };
 
 static int s500_clk_probe(struct platform_device *pdev)
 {
 	struct owl_clk_desc *desc;
+	struct owl_reset *reset;
+	int ret;
 
 	desc = &s500_clk_desc;
 	owl_clk_regmap_init(pdev, desc);
 
+	reset = devm_kzalloc(&pdev->dev, sizeof(*reset), GFP_KERNEL);
+	if (!reset)
+		return -ENOMEM;
+
+	reset->rcdev.of_node = pdev->dev.of_node;
+	reset->rcdev.ops = &owl_reset_ops;
+	reset->rcdev.nr_resets = desc->num_resets;
+	reset->reset_map = desc->resets;
+	reset->regmap = desc->regmap;
+
+	ret = devm_reset_controller_register(&pdev->dev, &reset->rcdev);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to register reset controller\n");
+
 	return owl_clk_probe(&pdev->dev, desc->hw_clks);
 }
 
-- 
2.27.0

