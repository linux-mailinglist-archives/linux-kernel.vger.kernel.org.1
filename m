Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9C12906F0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 16:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408699AbgJPONL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 10:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408614AbgJPONJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 10:13:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D940FC0613DA
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:13:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q5so3161350wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=csBLm3ebHLvfnJwPW+GEPGSRmaYpvOkO16WRyubpNjA=;
        b=jCjzqcNL3iczaFS9JnMzZxi14XrBwh6PymeoF2RT1H0/QG7D8NXJrQlSFIICo6fCje
         VSwaeZBsX7kgRyl/muJVSBdlOZLyv6SBkKHNvNJQgZJoPEYIMLUZ3PvI9N8XUAnOWl34
         rr+V3YDkQJUo/JIKTJQm0nmWTv40JBy98of/EI0pHKaQ12Os/6Yy/3/NIZFTPiRUZeHZ
         feUAitr8HCDmZ3MN1y/2/EV8HGpOTtSzQMeHev6ZtCefBcjOwK3mo68KlOZs9gpPvFSG
         ZlvVi658Ux+XtMnfLUO5x9nBd+Ka3cZsCmx4MuAoBWIjfvKAr14p8bOsV6IckMsr4Bja
         H1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=csBLm3ebHLvfnJwPW+GEPGSRmaYpvOkO16WRyubpNjA=;
        b=ZeMDXJnfjLBNnmFY67reZNNDjCfhcBwLrijj1HDy9vgk3RuH5PYnubAsDJVOZ1ZKPN
         NfqjcW6Tf2O8t7gYihZ8Yfw/6AiD1MdYOh+V8PiEsD81L6Ae26r1/g/fAOKFsAXQ+aRS
         BFHxggfvHR1DgMn3sJdgQgCfLGW8YGuxUGyXJkcn0quowPCPM4OwgOR7WKM6l9o6txNf
         iWRRvkHE3hXZ4qssXmohCFKAhG/vxcsDis0rtzoyWAri4kYhis44qT/HgTAbq4fr0JMI
         1Ax6eZE0h/fOZdQk1p92jPRYiaJ4h20Qj4Urx3U5JWzXSqbe3M37G1j/AyOkbunBG6u5
         ezkA==
X-Gm-Message-State: AOAM531Wsb9bavPRq4nSa6SC8rTThalRSq/Ls8csy47vgXAnyPO7km/T
        bE6SFZvp62dBG6T4Qk/SI4qsLg==
X-Google-Smtp-Source: ABdhPJztJYMzw77XeJJ3pv8HapvOVXwLIeNdsf+UvYW+xSxEtrOnGrmLbSV0sKAdo4muyM3bs/vyow==
X-Received: by 2002:a1c:c28a:: with SMTP id s132mr3958670wmf.67.1602857582631;
        Fri, 16 Oct 2020 07:13:02 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id p9sm2982284wma.12.2020.10.16.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 07:13:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     bjorn.andersson@linaro.org, mturquette@baylibre.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/4] clk: qcom: Add support to LPASS AON_CC Glitch Free Mux clocks
Date:   Fri, 16 Oct 2020 15:12:41 +0100
Message-Id: <20201016141241.5839-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201016141241.5839-1-srinivas.kandagatla@linaro.org>
References: <20201016141241.5839-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPASS Always ON Clock controller has one GFM mux to control VA
and TX clocks to codec macro on LPASS.
This patch adds support to this mux.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/clk/qcom/lpass-gfm-sm8250.c | 63 +++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/clk/qcom/lpass-gfm-sm8250.c b/drivers/clk/qcom/lpass-gfm-sm8250.c
index 48a73dd97d0d..d366c7c2abc7 100644
--- a/drivers/clk/qcom/lpass-gfm-sm8250.c
+++ b/drivers/clk/qcom/lpass-gfm-sm8250.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/of_device.h>
 #include <dt-bindings/clock/qcom,sm8250-lpass-audiocc.h>
+#include <dt-bindings/clock/qcom,sm8250-lpass-aoncc.h>
 
 struct lpass_gfm {
 	struct device *dev;
@@ -65,6 +66,46 @@ static const struct clk_ops clk_gfm_ops = {
 	.determine_rate = __clk_mux_determine_rate,
 };
 
+static struct clk_gfm lpass_gfm_va_mclk = {
+	.mux_reg = 0x20000,
+	.mux_mask = BIT(0),
+	.hw.init = &(struct clk_init_data) {
+		.name = "VA_MCLK",
+		.ops = &clk_gfm_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		.num_parents = 2,
+		.parent_data = (const struct clk_parent_data[]){
+			{
+				.index = 0,
+				.fw_name = "LPASS_CLK_ID_TX_CORE_MCLK",
+			}, {
+				.index = 1,
+				.fw_name = "LPASS_CLK_ID_VA_CORE_MCLK",
+			},
+		},
+	},
+};
+
+static struct clk_gfm lpass_gfm_tx_npl = {
+	.mux_reg = 0x20000,
+	.mux_mask = BIT(0),
+	.hw.init = &(struct clk_init_data) {
+		.name = "TX_NPL",
+		.ops = &clk_gfm_ops,
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE,
+		.parent_data = (const struct clk_parent_data[]){
+			{
+				.index = 0,
+				.fw_name = "LPASS_CLK_ID_TX_CORE_NPL_MCLK",
+			}, {
+				.index = 1,
+				.fw_name = "LPASS_CLK_ID_VA_CORE_2X_MCLK",
+			},
+		},
+		.num_parents = 2,
+	},
+};
+
 static struct clk_gfm lpass_gfm_wsa_mclk = {
 	.mux_reg = 0x220d8,
 	.mux_mask = BIT(0),
@@ -145,6 +186,19 @@ static struct clk_gfm lpass_gfm_rx_npl = {
 	},
 };
 
+static struct clk_gfm *aoncc_gfm_clks[] = {
+	[LPASS_CDC_VA_MCLK]		= &lpass_gfm_va_mclk,
+	[LPASS_CDC_TX_NPL]		= &lpass_gfm_tx_npl,
+};
+
+static struct clk_hw_onecell_data aoncc_hw_onecell_data = {
+	.hws = {
+		[LPASS_CDC_VA_MCLK]	= &lpass_gfm_va_mclk.hw,
+		[LPASS_CDC_TX_NPL]	= &lpass_gfm_tx_npl.hw,
+	},
+	.num = ARRAY_SIZE(aoncc_gfm_clks),
+};
+
 static struct clk_gfm *audiocc_gfm_clks[] = {
 	[LPASS_CDC_WSA_NPL]		= &lpass_gfm_wsa_npl,
 	[LPASS_CDC_WSA_MCLK]		= &lpass_gfm_wsa_mclk,
@@ -172,6 +226,11 @@ static struct lpass_gfm_data audiocc_data = {
 	.gfm_clks = audiocc_gfm_clks,
 };
 
+static struct lpass_gfm_data aoncc_data = {
+	.onecell_data = &aoncc_hw_onecell_data,
+	.gfm_clks = aoncc_gfm_clks,
+};
+
 static int lpass_gfm_clk_driver_probe(struct platform_device *pdev)
 {
 	const struct lpass_gfm_data *data;
@@ -233,6 +292,10 @@ static int lpass_gfm_clk_driver_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id lpass_gfm_clk_match_table[] = {
+	{
+		.compatible = "qcom,sm8250-lpass-aoncc",
+		.data = &aoncc_data,
+	},
 	{
 		.compatible = "qcom,sm8250-lpass-audiocc",
 		.data = &audiocc_data,
-- 
2.21.0

