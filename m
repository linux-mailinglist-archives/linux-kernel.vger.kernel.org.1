Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 498022FDDCE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 01:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732335AbhAUAVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 19:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403966AbhATXV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 18:21:57 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A9AC0617A1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:37:35 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id a109so25026201otc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dk3qEQlAxZmfI82OkyXmz2gwMMTg8wFXIlLMCIVZCs=;
        b=D54trIQyKNCQBtrdVoW8dxM3SpF4NsCBDQTflV5Ceg4ElKwbkYO74DJxzFvEhwdZR3
         UB3hYh+IPwfJhSLHqa6aIqOYb/gLyCQ2NegN2tsVPs92+gnFV94Gt6hU9GB3HE48hYgU
         M8AO0DnOEkYBrgNaw4bkfZGUCFgP56swCIH6zqt8hOa9XBT+Es5oHtQTtTkWGsvE2PKw
         RMkYzz5mYqgiwKW7+sQ9/iZ2JoKsDLumfa05+Q05Afe+tJVlvHVARF4k0+QTg1M1NZUa
         QYpX+A11Qnuxjnw7F+XInftjpF5hiXCyshTMvkmPpUMA2MnVrxvMhMH4ItLB0Hr4CEZF
         FdxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dk3qEQlAxZmfI82OkyXmz2gwMMTg8wFXIlLMCIVZCs=;
        b=LGw+LCNXZzCU0yftFFEiOhlh0RVo1jadw/DrQyJ8TQPEviSEcWOIlqhkGGQ7gCjvcy
         fa39Mzz/j6rjrMvtbTMO+bQhuDCu1kJVwP/OPrYV/45fcBFiOvkJULV8EszlVZCg43Fv
         NHzAyWzc9tY3dupjNErsET2KiV6m7o1ZZz8yGpgBRx2ABNzRc0REgV2vmkYlyse6sUd6
         bJgfirWrunF0/uiHZKFxefc6o5br7taUBNdWG57FrcHZ/Afv8mt5cjRlRfoer1BPdab6
         Y8Tz+RJQEhdJ/61ePt4GYkfTwPTgK97XnHrQJiMdh57/4Ij3m8OZsvX42Ji6TB+3D/4E
         7xJA==
X-Gm-Message-State: AOAM531EsizX1ZIz4ToitXjgJA5eSIjsaRTsA0YsrwkgC7nly0r5ZHpr
        n+4/PfMXu2QPpGYThV0xaNhNvw==
X-Google-Smtp-Source: ABdhPJzTj+jVlL6gEbqCpPhh5IQwO3ePGGnx/6S5K8uwgZeKw4aGYU4mpGn0M82xs6Emw12s/LRugA==
X-Received: by 2002:a9d:65:: with SMTP id 92mr8393081ota.207.1611182254456;
        Wed, 20 Jan 2021 14:37:34 -0800 (PST)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j9sm614894ooq.1.2021.01.20.14.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 14:37:33 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: qcom: rpmhcc: Add sc8180x rpmh clocks
Date:   Wed, 20 Jan 2021 14:37:41 -0800
Message-Id: <20210120223741.1610344-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120223741.1610344-1-bjorn.andersson@linaro.org>
References: <20210120223741.1610344-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks provides by RPMH in the Qualcomm SC8180x platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/clk-rpmh.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index 6a2a13c5058e..e356291f3ce7 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -348,6 +348,10 @@ DEFINE_CLK_RPMH_VRM(sdm845, rf_clk1, rf_clk1_ao, "rfclka1", 1);
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk2, rf_clk2_ao, "rfclka2", 1);
 DEFINE_CLK_RPMH_VRM(sdm845, rf_clk3, rf_clk3_ao, "rfclka3", 1);
 DEFINE_CLK_RPMH_VRM(sm8150, rf_clk3, rf_clk3_ao, "rfclka3", 1);
+DEFINE_CLK_RPMH_VRM(sc8180x, rf_clk1, rf_clk1_ao, "rfclkd1", 1);
+DEFINE_CLK_RPMH_VRM(sc8180x, rf_clk2, rf_clk2_ao, "rfclkd2", 1);
+DEFINE_CLK_RPMH_VRM(sc8180x, rf_clk3, rf_clk3_ao, "rfclkd3", 1);
+DEFINE_CLK_RPMH_VRM(sc8180x, rf_clk4, rf_clk4_ao, "rfclkd4", 1);
 DEFINE_CLK_RPMH_BCM(sdm845, ipa, "IP0");
 DEFINE_CLK_RPMH_BCM(sdm845, ce, "CE0");
 
@@ -431,6 +435,26 @@ static const struct clk_rpmh_desc clk_rpmh_sc7180 = {
 	.num_clks = ARRAY_SIZE(sc7180_rpmh_clocks),
 };
 
+static struct clk_hw *sc8180x_rpmh_clocks[] = {
+	[RPMH_CXO_CLK]		= &sdm845_bi_tcxo.hw,
+	[RPMH_CXO_CLK_A]	= &sdm845_bi_tcxo_ao.hw,
+	[RPMH_LN_BB_CLK2]	= &sdm845_ln_bb_clk2.hw,
+	[RPMH_LN_BB_CLK2_A]	= &sdm845_ln_bb_clk2_ao.hw,
+	[RPMH_LN_BB_CLK3]	= &sdm845_ln_bb_clk3.hw,
+	[RPMH_LN_BB_CLK3_A]	= &sdm845_ln_bb_clk3_ao.hw,
+	[RPMH_RF_CLK1]		= &sc8180x_rf_clk1.hw,
+	[RPMH_RF_CLK1_A]	= &sc8180x_rf_clk1_ao.hw,
+	[RPMH_RF_CLK2]		= &sc8180x_rf_clk2.hw,
+	[RPMH_RF_CLK2_A]	= &sc8180x_rf_clk2_ao.hw,
+	[RPMH_RF_CLK3]		= &sc8180x_rf_clk3.hw,
+	[RPMH_RF_CLK3_A]	= &sc8180x_rf_clk3_ao.hw,
+};
+
+static const struct clk_rpmh_desc clk_rpmh_sc8180x = {
+	.clks = sc8180x_rpmh_clocks,
+	.num_clks = ARRAY_SIZE(sc8180x_rpmh_clocks),
+};
+
 DEFINE_CLK_RPMH_VRM(sm8250, ln_bb_clk1, ln_bb_clk1_ao, "lnbclka1", 2);
 
 static struct clk_hw *sm8250_rpmh_clocks[] = {
@@ -570,6 +594,7 @@ static int clk_rpmh_probe(struct platform_device *pdev)
 
 static const struct of_device_id clk_rpmh_match_table[] = {
 	{ .compatible = "qcom,sc7180-rpmh-clk", .data = &clk_rpmh_sc7180},
+	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = &clk_rpmh_sc8180x},
 	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
 	{ .compatible = "qcom,sdx55-rpmh-clk",  .data = &clk_rpmh_sdx55},
 	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
-- 
2.29.2

