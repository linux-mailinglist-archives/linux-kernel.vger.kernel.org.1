Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD1E2C4F8B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 08:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbgKZH35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 02:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388549AbgKZH34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:29:56 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82413C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:29:55 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id q10so888332pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 23:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Q56A6z74jHoYoTkjeOjzuUuAU4EjwzNgIpCUrXAkjI=;
        b=DSZFXoWBQfOoKrMRTL/0z2aJtdI09llrIbN/1cFjI95AaMp1gS3j3dWJ2sXRVXnFjl
         49/4p/o+MsKImJjeOSwXytGjhW/ejF9R5cnlDzET88ULLubp28jIjJDhBI8cMJdB+bOg
         iHxNs9l716nzFlgF+zIav7QSs2p6W82mWW2AciEFgdhvnx9M8J/b77QD3zwAHUDaiNjx
         bPBL2qv1WGPpTsbj5sG7mks/tKRztJEUaZUbZJb2O6f5BBhxLQRDpYe+Z51vxoWxXb60
         SM7W5nzGcMzJYZynlkC5e2PIYhEAROPqUPlfCAU0lZB6phxphRyIIUH9H9yLD0lLqtQX
         oO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Q56A6z74jHoYoTkjeOjzuUuAU4EjwzNgIpCUrXAkjI=;
        b=T+GAj7eGeRvnEWM6lxaW5d1o7p8Qb3PDrhCj/0aUbrWsWM0xVmKU5apo1VxAPEgSBn
         fJe82LrU7Av22eMo2Cy2g7cxZFXbbzDLojcwgHdSdn4NQVxCkX7KD+vYIiZWXuFICniU
         RK9GCTGbCulbUKS1GH2LQMydEjXtF/vRNZjRZKGRy/78dkILWQjB00Yi/toJv12PTn0H
         o0/7dELsuN+gw+wd74GJtugPz0yEw34iw6gOqDTF9iz0n5j5ZsESqFYj2NIfXMu+7UEa
         iKd6LFL6qVAAQLxjzUNWnK6OsotvVCglFfhu2ikfuv4/Ygt9aeuQ76Vee27BCKTxtBTr
         wfZg==
X-Gm-Message-State: AOAM533WsB50SV88M4Cfymslr6ltwajfDRQV2/hRJwmjCmCNGCmF4DcD
        iPsqd6NM+qAAFisb50nGRJ3Q
X-Google-Smtp-Source: ABdhPJyyef25prNIm5wj3g1X2/u5YRl7ivxYvtiMRgrQO5oWcmGOxd8p4v0aIqxLhW7qfcKtKbQ+kw==
X-Received: by 2002:a62:15d8:0:b029:198:30d:b49d with SMTP id 207-20020a6215d80000b0290198030db49dmr1665896pfv.5.1606375795032;
        Wed, 25 Nov 2020 23:29:55 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6e95:f2a:3996:9d7f:e389:7f7d])
        by smtp.gmail.com with ESMTPSA id t9sm5508097pjq.46.2020.11.25.23.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 23:29:54 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [RESEND PATCH v4 6/6] clk: qcom: Add GDSC support for SDX55 GCC
Date:   Thu, 26 Nov 2020 12:58:44 +0530
Message-Id: <20201126072844.35370-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126072844.35370-1-manivannan.sadhasivam@linaro.org>
References: <20201126072844.35370-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add GDSC support to control the power supply of power domains in SDX55
GCC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/qcom/Kconfig     |  1 +
 drivers/clk/qcom/gcc-sdx55.c | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 7897a3947e6d..05055fd18e6e 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -415,6 +415,7 @@ config SDM_LPASSCC_845
 
 config SDX_GCC_55
 	tristate "SDX55 Global Clock Controller"
+	select QCOM_GDSC
 	help
 	  Support for the global clock controller on SDX55 devices.
 	  Say Y if you want to use peripheral devices such as UART,
diff --git a/drivers/clk/qcom/gcc-sdx55.c b/drivers/clk/qcom/gcc-sdx55.c
index bf114165e24b..e3b9030b2bae 100644
--- a/drivers/clk/qcom/gcc-sdx55.c
+++ b/drivers/clk/qcom/gcc-sdx55.c
@@ -17,6 +17,7 @@
 #include "clk-pll.h"
 #include "clk-rcg.h"
 #include "clk-regmap.h"
+#include "gdsc.h"
 #include "reset.h"
 
 enum {
@@ -1455,6 +1456,30 @@ static struct clk_branch gcc_xo_pcie_link_clk = {
 	},
 };
 
+static struct gdsc usb30_gdsc = {
+	.gdscr = 0x0b004,
+	.pd = {
+		.name = "usb30_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc pcie_gdsc = {
+	.gdscr = 0x37004,
+	.pd = {
+		.name = "pcie_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
+static struct gdsc emac_gdsc = {
+	.gdscr = 0x47004,
+	.pd = {
+		.name = "emac_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+};
+
 static struct clk_regmap *gcc_sdx55_clocks[] = {
 	[GCC_AHB_PCIE_LINK_CLK] = &gcc_ahb_pcie_link_clk.clkr,
 	[GCC_BLSP1_AHB_CLK] = &gcc_blsp1_ahb_clk.clkr,
@@ -1560,6 +1585,12 @@ static const struct qcom_reset_map gcc_sdx55_resets[] = {
 	[GCC_USB_PHY_CFG_AHB2PHY_BCR] = { 0xe000 },
 };
 
+static struct gdsc *gcc_sdx55_gdscs[] = {
+	[USB30_GDSC] = &usb30_gdsc,
+	[PCIE_GDSC] = &pcie_gdsc,
+	[EMAC_GDSC] = &emac_gdsc,
+};
+
 static const struct regmap_config gcc_sdx55_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1574,6 +1605,8 @@ static const struct qcom_cc_desc gcc_sdx55_desc = {
 	.num_clks = ARRAY_SIZE(gcc_sdx55_clocks),
 	.resets = gcc_sdx55_resets,
 	.num_resets = ARRAY_SIZE(gcc_sdx55_resets),
+	.gdscs = gcc_sdx55_gdscs,
+	.num_gdscs = ARRAY_SIZE(gcc_sdx55_gdscs),
 };
 
 static const struct of_device_id gcc_sdx55_match_table[] = {
-- 
2.25.1

