Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00E3321A14B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 15:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGINye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgGINyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 09:54:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2569C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 06:54:30 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k18so1816742qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 06:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mgDv4Rf3fgP1WVv6wT9BRKGCzb8IU1E1hjosgtpH4Dg=;
        b=OQXOF8ahr95KuMAL8sZAZpdCk/2JDt696IvuRcPtP4hNBFcyXEPd6Jf/to3dMMl9ut
         qeZL9wdSgJ+mlTgyHcW7Ezcgh78zexvAaTEmIj3kfCPpzRxb4rx/EUSrR5kg002NbV10
         fmBvyrUGfndEQv98n8apbqZ5Ri8Sh8MXvUCv5W4N/31PBmHaJWolFnnUUHVRSx8d3KPy
         ELgkMgpuH4FMoyL4NNBEptrAY8J2c7Ly9PVAIFZUunNLAwl++WJ2XaHdcGUiRC86G9oi
         +weu4uVqMb03Uw8/1gbyBBogh6oQ0i7tfJucUIxu89zwU6QBkDGnSlzoY27DMvk0ISEW
         sUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mgDv4Rf3fgP1WVv6wT9BRKGCzb8IU1E1hjosgtpH4Dg=;
        b=Bml3+P8wjpwHIlxj7x+DT/Z8oNpYOG9Im+Zm51IN7kgT0zbVvLPyofPHrm6H9h+4kJ
         n8w8Jb+1pSKuPC2+jQ81xbYPGjH5oMZragazgAqI3+FDtDWFauy9B2MlM+bcnc1T0Pf4
         N6GlUHJrVD8l9clld5MhlNX6EM8eZqnfE77pTxvDt5QTY88VlobSJ3Lfwj6Phr8A1rPj
         W3flDyYSdLcByw51Ib+1R5FuNl7dGkeYxvd+DD9LaAluyPptSToOfEoIDfvFFqQ1Y+js
         igix6uwRCQVnHda+3auaUmoTziekbbuHEABClEzKDU92ei/euA9aZbOjvjMVDbJw+GPa
         ZIww==
X-Gm-Message-State: AOAM533VrMdMTXaTrmXu2UCWFFWWj+3c1owwWS8RovWA1GkAyY3Kae62
        9XEJFTFrj4XH3DUUtVdhn3mIAQ==
X-Google-Smtp-Source: ABdhPJxD5JD36EmJTsF7RGw74iT977lAA8uYtkzFZ1sn0lK5Nc1gUsiLDHAqguz3is8krlj+u+ePbw==
X-Received: by 2002:a05:620a:4151:: with SMTP id k17mr62551151qko.305.1594302870137;
        Thu, 09 Jul 2020 06:54:30 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 130sm3632735qkn.82.2020.07.09.06.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 06:54:29 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 03/14] clk: qcom: clk-alpha-pll: same regs and ops for trion and lucid
Date:   Thu,  9 Jul 2020 09:52:34 -0400
Message-Id: <20200709135251.643-4-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200709135251.643-1-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed ops were already identical, this adds support for non-fixed ops by
sharing between trion and lucid.

This also changes the names for trion ops to be consistent with the rest.

Note LUCID_PCAL_DONE is renamed to TRION_PCAL_DONE because it is wrong for
lucid, LUCID_PCAL_DONE should be BIT(27). Next patch will address this.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/clk/qcom/clk-alpha-pll.c | 58 ++++++++++----------------------
 drivers/clk/qcom/clk-alpha-pll.h | 17 ++++++----
 drivers/clk/qcom/gcc-sm8150.c    |  8 ++---
 3 files changed, 32 insertions(+), 51 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 1325139173c9..be7ffeae21b1 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -101,21 +101,6 @@ const u8 clk_alpha_pll_regs[][PLL_OFF_MAX_REGS] = {
 		[PLL_OFF_FRAC] = 0x38,
 	},
 	[CLK_ALPHA_PLL_TYPE_TRION] = {
-		[PLL_OFF_L_VAL] = 0x04,
-		[PLL_OFF_CAL_L_VAL] = 0x08,
-		[PLL_OFF_USER_CTL] = 0x0c,
-		[PLL_OFF_USER_CTL_U] = 0x10,
-		[PLL_OFF_USER_CTL_U1] = 0x14,
-		[PLL_OFF_CONFIG_CTL] = 0x18,
-		[PLL_OFF_CONFIG_CTL_U] = 0x1c,
-		[PLL_OFF_CONFIG_CTL_U1] = 0x20,
-		[PLL_OFF_TEST_CTL] = 0x24,
-		[PLL_OFF_TEST_CTL_U] = 0x28,
-		[PLL_OFF_STATUS] = 0x30,
-		[PLL_OFF_OPMODE] = 0x38,
-		[PLL_OFF_ALPHA_VAL] = 0x40,
-	},
-	[CLK_ALPHA_PLL_TYPE_LUCID] =  {
 		[PLL_OFF_L_VAL] = 0x04,
 		[PLL_OFF_CAL_L_VAL] = 0x08,
 		[PLL_OFF_USER_CTL] = 0x0c,
@@ -154,9 +139,9 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_regs);
 #define PLL_OUT_MASK		0x7
 #define PLL_RATE_MARGIN		500
 
-/* LUCID PLL specific settings and offsets */
-#define LUCID_PLL_CAL_VAL	0x44
-#define LUCID_PCAL_DONE		BIT(26)
+/* TRION PLL specific settings and offsets */
+#define TRION_PLL_CAL_VAL	0x44
+#define TRION_PCAL_DONE		BIT(26)
 
 #define pll_alpha_width(p)					\
 		((PLL_ALPHA_VAL_U(p) - PLL_ALPHA_VAL(p) == 4) ?	\
@@ -910,14 +895,14 @@ const struct clk_ops clk_alpha_pll_hwfsm_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_hwfsm_ops);
 
-const struct clk_ops clk_trion_fixed_pll_ops = {
+const struct clk_ops clk_alpha_pll_fixed_trion_ops = {
 	.enable = clk_trion_pll_enable,
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
 	.round_rate = clk_alpha_pll_round_rate,
 };
-EXPORT_SYMBOL_GPL(clk_trion_fixed_pll_ops);
+EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_trion_ops);
 
 static unsigned long
 clk_alpha_pll_postdiv_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
@@ -1337,12 +1322,12 @@ clk_trion_pll_postdiv_set_rate(struct clk_hw *hw, unsigned long rate,
 				  val << PLL_POST_DIV_SHIFT);
 }
 
-const struct clk_ops clk_trion_pll_postdiv_ops = {
+const struct clk_ops clk_alpha_pll_postdiv_trion_ops = {
 	.recalc_rate = clk_trion_pll_postdiv_recalc_rate,
 	.round_rate = clk_trion_pll_postdiv_round_rate,
 	.set_rate = clk_trion_pll_postdiv_set_rate,
 };
-EXPORT_SYMBOL_GPL(clk_trion_pll_postdiv_ops);
+EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_trion_ops);
 
 static long clk_alpha_pll_postdiv_fabia_round_rate(struct clk_hw *hw,
 				unsigned long rate, unsigned long *prate)
@@ -1397,13 +1382,13 @@ EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
  * @regmap: register map
  * @config: configuration to apply for pll
  */
-void clk_lucid_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+void clk_trion_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config)
 {
 	if (config->l)
 		regmap_write(regmap, PLL_L_VAL(pll), config->l);
 
-	regmap_write(regmap, PLL_CAL_L_VAL(pll), LUCID_PLL_CAL_VAL);
+	regmap_write(regmap, PLL_CAL_L_VAL(pll), TRION_PLL_CAL_VAL);
 
 	if (config->alpha)
 		regmap_write(regmap, PLL_ALPHA_VAL(pll), config->alpha);
@@ -1456,13 +1441,13 @@ void clk_lucid_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 	/* Place the PLL in STANDBY mode */
 	regmap_update_bits(regmap, PLL_MODE(pll), PLL_RESET_N, PLL_RESET_N);
 }
-EXPORT_SYMBOL_GPL(clk_lucid_pll_configure);
+EXPORT_SYMBOL_GPL(clk_trion_pll_configure);
 
 /*
- * The Lucid PLL requires a power-on self-calibration which happens when the
+ * The TRION PLL requires a power-on self-calibration which happens when the
  * PLL comes out of reset. Calibrate in case it is not completed.
  */
-static int alpha_pll_lucid_prepare(struct clk_hw *hw)
+static int alpha_pll_trion_prepare(struct clk_hw *hw)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
 	u32 regval;
@@ -1470,7 +1455,7 @@ static int alpha_pll_lucid_prepare(struct clk_hw *hw)
 
 	/* Return early if calibration is not needed. */
 	regmap_read(pll->clkr.regmap, PLL_STATUS(pll), &regval);
-	if (regval & LUCID_PCAL_DONE)
+	if (regval & TRION_PCAL_DONE)
 		return 0;
 
 	/* On/off to calibrate */
@@ -1481,7 +1466,7 @@ static int alpha_pll_lucid_prepare(struct clk_hw *hw)
 	return ret;
 }
 
-static int alpha_pll_lucid_set_rate(struct clk_hw *hw, unsigned long rate,
+static int alpha_pll_trion_set_rate(struct clk_hw *hw, unsigned long rate,
 				    unsigned long prate)
 {
 	struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
@@ -1535,26 +1520,17 @@ static int alpha_pll_lucid_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-const struct clk_ops clk_alpha_pll_lucid_ops = {
-	.prepare = alpha_pll_lucid_prepare,
+const struct clk_ops clk_alpha_pll_trion_ops = {
+	.prepare = alpha_pll_trion_prepare,
 	.enable = clk_trion_pll_enable,
 	.disable = clk_trion_pll_disable,
 	.is_enabled = clk_trion_pll_is_enabled,
 	.recalc_rate = clk_trion_pll_recalc_rate,
 	.round_rate = clk_alpha_pll_round_rate,
-	.set_rate = alpha_pll_lucid_set_rate,
+	.set_rate = alpha_pll_trion_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_lucid_ops);
 
-const struct clk_ops clk_alpha_pll_fixed_lucid_ops = {
-	.enable = clk_trion_pll_enable,
-	.disable = clk_trion_pll_disable,
-	.is_enabled = clk_trion_pll_is_enabled,
-	.recalc_rate = clk_trion_pll_recalc_rate,
-	.round_rate = clk_alpha_pll_round_rate,
-};
-EXPORT_SYMBOL_GPL(clk_alpha_pll_fixed_lucid_ops);
-
 const struct clk_ops clk_alpha_pll_postdiv_lucid_ops = {
 	.recalc_rate = clk_alpha_pll_postdiv_fabia_recalc_rate,
 	.round_rate = clk_alpha_pll_postdiv_fabia_round_rate,
diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
index 704674a153b6..67f1fd271931 100644
--- a/drivers/clk/qcom/clk-alpha-pll.h
+++ b/drivers/clk/qcom/clk-alpha-pll.h
@@ -14,7 +14,7 @@ enum {
 	CLK_ALPHA_PLL_TYPE_BRAMMO,
 	CLK_ALPHA_PLL_TYPE_FABIA,
 	CLK_ALPHA_PLL_TYPE_TRION,
-	CLK_ALPHA_PLL_TYPE_LUCID,
+	CLK_ALPHA_PLL_TYPE_LUCID = CLK_ALPHA_PLL_TYPE_TRION,
 	CLK_ALPHA_PLL_TYPE_MAX,
 };
 
@@ -128,18 +128,23 @@ extern const struct clk_ops clk_alpha_pll_fabia_ops;
 extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
 extern const struct clk_ops clk_alpha_pll_postdiv_fabia_ops;
 
-extern const struct clk_ops clk_alpha_pll_lucid_ops;
-extern const struct clk_ops clk_alpha_pll_fixed_lucid_ops;
+extern const struct clk_ops clk_alpha_pll_trion_ops;
+extern const struct clk_ops clk_alpha_pll_fixed_trion_ops;
+extern const struct clk_ops clk_alpha_pll_postdiv_trion_ops;
+
+#define clk_alpha_pll_lucid_ops clk_alpha_pll_trion_ops
+#define clk_alpha_pll_fixed_lucid_ops clk_alpha_pll_fixed_trion_ops
 extern const struct clk_ops clk_alpha_pll_postdiv_lucid_ops;
 
 void clk_alpha_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config);
 void clk_fabia_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 				const struct alpha_pll_config *config);
-void clk_lucid_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
+void clk_trion_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
 			     const struct alpha_pll_config *config);
+#define clk_lucid_pll_configure(pll, regmap, config) \
+	clk_trion_pll_configure(pll, regmap, config)
+
 
-extern const struct clk_ops clk_trion_fixed_pll_ops;
-extern const struct clk_ops clk_trion_pll_postdiv_ops;
 
 #endif
diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8150.c
index 55e9d6d75a0c..d7778def37da 100644
--- a/drivers/clk/qcom/gcc-sm8150.c
+++ b/drivers/clk/qcom/gcc-sm8150.c
@@ -53,7 +53,7 @@ static struct clk_alpha_pll gpll0 = {
 				.name = "bi_tcxo",
 			},
 			.num_parents = 1,
-			.ops = &clk_trion_fixed_pll_ops,
+			.ops = &clk_alpha_pll_fixed_trion_ops,
 		},
 	},
 };
@@ -79,7 +79,7 @@ static struct clk_alpha_pll_postdiv gpll0_out_even = {
 			.hw = &gpll0.clkr.hw,
 		},
 		.num_parents = 1,
-		.ops = &clk_trion_pll_postdiv_ops,
+		.ops = &clk_alpha_pll_postdiv_trion_ops,
 	},
 };
 
@@ -98,7 +98,7 @@ static struct clk_alpha_pll gpll7 = {
 				.name = "bi_tcxo",
 			},
 			.num_parents = 1,
-			.ops = &clk_trion_fixed_pll_ops,
+			.ops = &clk_alpha_pll_fixed_trion_ops,
 		},
 	},
 };
@@ -118,7 +118,7 @@ static struct clk_alpha_pll gpll9 = {
 				.name = "bi_tcxo",
 			},
 			.num_parents = 1,
-			.ops = &clk_trion_fixed_pll_ops,
+			.ops = &clk_alpha_pll_fixed_trion_ops,
 		},
 	},
 };
-- 
2.26.1

