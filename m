Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116AA29DAEE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgJ1Xin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390563AbgJ1Xhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:37:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D02C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:37:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x23so409215plr.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 16:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aD/m2VgCYiafD5XJrexC8xG2hc+36DzQpHElqK1SRuE=;
        b=v23DjL4BqoRVxPR9GiRf0kU1JhgymDI0xiYjXnCz4Q785C1+xKWhpKU6Km8WPOp58w
         xGur69N7GeI8fwXXwA+kVV+RcFy4HsedaSVvKdI47qTsXih/LGVM3DGC0btx4VoxTYxJ
         cLSx2YmlYZW9A8eUFhVGuOquAzmHZ8jND6vyejb2sKUqdSR/CFagLZUEYBVJKs/2kDc6
         JGC5vPGT+PpvhNxJJFT4rYUlvHhjTjPn8MOkZc/uu565J5yhEcMDFCxPX6kKim6nGVzT
         NCdS4ntm1tBymmjYUg6XJ53cjrMCeKuIT63npvN/BqgJ9tqRhjtf3+wNAzJBxOxVCa+y
         0RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aD/m2VgCYiafD5XJrexC8xG2hc+36DzQpHElqK1SRuE=;
        b=PdMjAfpV3lceRxhZU8v6gVJKEP4A+/et0PgUL129mXbJv2DvXLUcBuiGKKzLzgFViI
         B3nJfYdr6WVIhkwgGraSNz6s1v2ujiK19y9yplI5qjdjdBFGJreTJ2GaXC4gUsKr58FG
         nGbNoELqzW3tIRTU2nMmmwBh/YfUV/weWQYXP/h/PjrDqsmDM1PZEEFpW6M65j/SDrUx
         MWxuSt/PRgEb9GadCuiYO8Fb4cxq6Qd0qBjM7aJHe77QdGfHAUF+WfjWsVZdaHOKI89f
         vZZILhRSFRDNrJb9QTgc3Y3O0IaQo1WXBGVLUVuW1plE67yPWmfIGO13JgQcjouUHihP
         6uiA==
X-Gm-Message-State: AOAM533iHagap7Xa0/Ss3o4ZZTE7aLQNdrBNxbwOy+oop2zlnOUNPZSS
        FJbW135fAeJnjgjt9Q8vmvKSzUtPjUKN
X-Google-Smtp-Source: ABdhPJz8bqfzm3rNPe2a2hytHwPw1HH8gsns4sap2sQtA7nMk9rNUILQwS2zVPM5K3yckVKsL3p6JQ==
X-Received: by 2002:aa7:911a:0:b029:155:8521:ba6c with SMTP id 26-20020aa7911a0000b02901558521ba6cmr5161777pfh.8.1603870995286;
        Wed, 28 Oct 2020 00:43:15 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id e7sm4289579pgj.19.2020.10.28.00.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 00:43:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/4] clk: qcom: Add support for SDX55 RPMh clocks
Date:   Wed, 28 Oct 2020 13:12:32 +0530
Message-Id: <20201028074232.22922-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201028074232.22922-1-manivannan.sadhasivam@linaro.org>
References: <20201028074232.22922-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for clocks maintained by RPMh in SDX55 SoCs.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index e2c669b08aff..88d010178b59 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -432,6 +432,25 @@ static const struct clk_rpmh_desc clk_rpmh_sm8250 = {
 	.num_clks = ARRAY_SIZE(sm8250_rpmh_clocks),
 };
 
+DEFINE_CLK_RPMH_VRM(sdx55, rf_clk1, rf_clk1_ao, "rfclkd1", 1);
+DEFINE_CLK_RPMH_VRM(sdx55, rf_clk2, rf_clk2_ao, "rfclkd2", 1);
+DEFINE_CLK_RPMH_BCM(sdx55, qpic_clk, "QP0");
+
+static struct clk_hw *sdx55_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
+	[RPMH_CXO_CLK_A]	= &sdm845_bi_tcxo_ao.hw,
+	[RPMH_RF_CLK1]		= &sdx55_rf_clk1.hw,
+	[RPMH_RF_CLK1_A]	= &sdx55_rf_clk1_ao.hw,
+	[RPMH_RF_CLK2]		= &sdx55_rf_clk2.hw,
+	[RPMH_RF_CLK2_A]	= &sdx55_rf_clk2_ao.hw,
+	[RPMH_QPIC_CLK]		= &sdx55_qpic_clk.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sdx55 = {
+	.clks = sdx55_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sdx55_rpmh_clocks),
+};
+
 static struct clk_hw *of_clk_rpmh_hw_get(struct of_phandle_args *clkspec,
 					 void *data)
 {
@@ -519,6 +538,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
 	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
 	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
+	{ .compatible = "qcom,sdx55-rpmh-clk", .data = &clk_rpmh_sdx55},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, clk_rpmh_match_table);
-- 
2.17.1

