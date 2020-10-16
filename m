Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED2D2901B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405819AbgJPJSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395009AbgJPJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:18:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7ED4C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:18:41 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 1so957287ple.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hserBQdTEW9AsTQ36FTR+4nQGY1DffaxGbmIC1KLT7s=;
        b=lagTdDTlSZMSt6s3AWUZJg1jTmR1sY7a3/MhohEjooPBDyTBLQ3jy4Bvk/z4AWXh68
         q7vr0OOAMEACFFcMaujXlurc2C3ICisMchCrTj/cBuCFB6kqe1FS1DaVatoTZGYj+9dK
         E+6SW+fpDyfHnb+7UeItIZrMDcDdrpQffmexxmgvPoNNZ16sB2E+NXAiXnQir//LVqS2
         TMFNrL9tR+0TuN5OupbEIk2ypei9EPNvzvAA4kqSSgBXeTyis6B5MwpH32xFAOYtCmyv
         7crEDlC7YHEN6g41D6tB4UhdM+i1EUA/3BH3S1flBClYZGvexByYkFUT/4s3WK3E+Q9s
         sztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hserBQdTEW9AsTQ36FTR+4nQGY1DffaxGbmIC1KLT7s=;
        b=P/3GbgRQkVgRHyVyyl3In0DYRsOrQ1jrUJGF9iHI+iXPNxsWBd3xu4HS7FrDv8x/gD
         M+J/SRBo7JXAJfLaQ0/s/MxJogYGs5HfQEmReA+fv1NlzTS3md3geD6rOvRviajeZWsG
         A8P9LgMD2xa0u49NtSR6/1dbDGJ+pb5ZiVLpS7S+V/cC576PGoxmF2ha/zrsbolk54k3
         yVnwKlYfNOs+Nb1sFoHitKznK1ac1L6Ih12vwsKiwpKDt40c30dK0AC0/bBRxz2Kf+Ld
         FWWXJ5+D2gwOwbKHIjtkrN8iimDMEJFpDYOaksZJu53Mg9NQfZaARUM1Lkto25WFIt1P
         pXdA==
X-Gm-Message-State: AOAM531KFyfS3hLKSFMgYL20GXnZqJMAkmbJl8/e4o4OK49MZQ4XbueR
        nyQ/EhEjQQvWnY9aIqDbT36fgg==
X-Google-Smtp-Source: ABdhPJxNv1gd8tfR31PlXHnSFmHYU4xv0VUQkEBD5xr0qZ/Ge1q0o4e0BcAwYuA39IssTNsypJSVSg==
X-Received: by 2002:a17:902:7042:b029:d5:c0e6:8e35 with SMTP id h2-20020a1709027042b02900d5c0e68e35mr2934273plt.9.1602839921352;
        Fri, 16 Oct 2020 02:18:41 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id h5sm2093263pfh.9.2020.10.16.02.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 02:18:40 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com, sboyd@kernel.org,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH 4/4] clk: sifive: Refactor __prci_clock array by using macro
Date:   Fri, 16 Oct 2020 17:18:26 +0800
Message-Id: <8ad64f9814137c5255d43d4ba670b5fcd15837ab.1602838910.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1602838910.git.zong.li@sifive.com>
References: <cover.1602838910.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor code by using DEFINE_PRCI_CLOCK to define each clock
and reduce duplicate code.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 drivers/clk/sifive/fu540-prci.c  | 38 ++++++----------
 drivers/clk/sifive/fu540-prci.h  |  2 +-
 drivers/clk/sifive/fu740-prci.c  | 74 ++++++++++++--------------------
 drivers/clk/sifive/fu740-prci.h  |  2 +-
 drivers/clk/sifive/sifive-prci.c |  2 +-
 drivers/clk/sifive/sifive-prci.h | 10 ++++-
 6 files changed, 53 insertions(+), 75 deletions(-)

diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
index 840b97bfff85..d43b9a9984f6 100644
--- a/drivers/clk/sifive/fu540-prci.c
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -54,29 +54,19 @@ static const struct clk_ops sifive_fu540_prci_tlclksel_clk_ops = {
 	.recalc_rate = sifive_prci_tlclksel_recalc_rate,
 };
 
+DEFINE_PRCI_CLOCK(fu540, corepll, hfclk,
+		  &sifive_fu540_prci_wrpll_clk_ops, &__prci_corepll_data);
+DEFINE_PRCI_CLOCK(fu540, ddrpll, hfclk,
+		  &sifive_fu540_prci_wrpll_ro_clk_ops, &__prci_ddrpll_data);
+DEFINE_PRCI_CLOCK(fu540, gemgxlpll, hfclk,
+		  &sifive_fu540_prci_wrpll_clk_ops, &__prci_gemgxlpll_data);
+DEFINE_PRCI_CLOCK(fu540, tlclk, corepll,
+		  &sifive_fu540_prci_tlclksel_clk_ops, NULL);
+
 /* List of clock controls provided by the PRCI */
-struct __prci_clock __prci_init_clocks_fu540[] = {
-	[PRCI_CLK_COREPLL] = {
-		.name = "corepll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu540_prci_wrpll_clk_ops,
-		.pwd = &__prci_corepll_data,
-	},
-	[PRCI_CLK_DDRPLL] = {
-		.name = "ddrpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu540_prci_wrpll_ro_clk_ops,
-		.pwd = &__prci_ddrpll_data,
-	},
-	[PRCI_CLK_GEMGXLPLL] = {
-		.name = "gemgxlpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu540_prci_wrpll_clk_ops,
-		.pwd = &__prci_gemgxlpll_data,
-	},
-	[PRCI_CLK_TLCLK] = {
-		.name = "tlclk",
-		.parent_name = "corepll",
-		.ops = &sifive_fu540_prci_tlclksel_clk_ops,
-	},
+struct __prci_clock *__prci_init_clocks_fu540[] = {
+	[PRCI_CLK_COREPLL]	= &fu540_corepll,
+	[PRCI_CLK_DDRPLL]	= &fu540_ddrpll,
+	[PRCI_CLK_GEMGXLPLL]	= &fu540_gemgxlpll,
+	[PRCI_CLK_TLCLK]	= &fu540_tlclk,
 };
diff --git a/drivers/clk/sifive/fu540-prci.h b/drivers/clk/sifive/fu540-prci.h
index c8271efa7bdc..281200cd8848 100644
--- a/drivers/clk/sifive/fu540-prci.h
+++ b/drivers/clk/sifive/fu540-prci.h
@@ -11,7 +11,7 @@
 
 #define NUM_CLOCK_FU540	4
 
-extern struct __prci_clock __prci_init_clocks_fu540[NUM_CLOCK_FU540];
+extern struct __prci_clock *__prci_init_clocks_fu540[NUM_CLOCK_FU540];
 
 static const struct prci_clk_desc prci_clk_fu540 = {
 	.clks = __prci_init_clocks_fu540,
diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
index 3b87e273c3eb..676cad2c3886 100644
--- a/drivers/clk/sifive/fu740-prci.c
+++ b/drivers/clk/sifive/fu740-prci.c
@@ -71,52 +71,32 @@ static const struct clk_ops sifive_fu740_prci_hfpclkplldiv_clk_ops = {
 	.recalc_rate = sifive_prci_hfpclkplldiv_recalc_rate,
 };
 
+
+DEFINE_PRCI_CLOCK(fu740, corepll, hfclk,
+		  &sifive_fu740_prci_wrpll_clk_ops, &__prci_corepll_data);
+DEFINE_PRCI_CLOCK(fu740, ddrpll, hfclk,
+		  &sifive_fu740_prci_wrpll_ro_clk_ops, &__prci_ddrpll_data);
+DEFINE_PRCI_CLOCK(fu740, gemgxlpll, hfclk,
+		  &sifive_fu740_prci_wrpll_clk_ops, &__prci_gemgxlpll_data);
+DEFINE_PRCI_CLOCK(fu740, dvfscorepll, hfclk,
+		  &sifive_fu740_prci_wrpll_clk_ops, &__prci_dvfscorepll_data);
+DEFINE_PRCI_CLOCK(fu740, hfpclkpll, hfclk,
+		  &sifive_fu740_prci_wrpll_clk_ops, &__prci_hfpclkpll_data);
+DEFINE_PRCI_CLOCK(fu740, cltxpll, hfclk,
+		  &sifive_fu740_prci_wrpll_clk_ops, &__prci_cltxpll_data);
+DEFINE_PRCI_CLOCK(fu740, tlclk, corepll,
+		  &sifive_fu740_prci_tlclksel_clk_ops, NULL);
+DEFINE_PRCI_CLOCK(fu740, pclk, hfpclkpll,
+		  &sifive_fu740_prci_hfpclkplldiv_clk_ops, NULL);
+
 /* List of clock controls provided by the PRCI */
-struct __prci_clock __prci_init_clocks_fu740[] = {
-	[PRCI_CLK_COREPLL] = {
-		.name = "corepll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_corepll_data,
-	},
-	[PRCI_CLK_DDRPLL] = {
-		.name = "ddrpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_ro_clk_ops,
-		.pwd = &__prci_ddrpll_data,
-	},
-	[PRCI_CLK_GEMGXLPLL] = {
-		.name = "gemgxlpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_gemgxlpll_data,
-	},
-	[PRCI_CLK_DVFSCOREPLL] = {
-		.name = "dvfscorepll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_dvfscorepll_data,
-	},
-	[PRCI_CLK_HFPCLKPLL] = {
-		.name = "hfpclkpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_hfpclkpll_data,
-	},
-	[PRCI_CLK_CLTXPLL] = {
-		.name = "cltxpll",
-		.parent_name = "hfclk",
-		.ops = &sifive_fu740_prci_wrpll_clk_ops,
-		.pwd = &__prci_cltxpll_data,
-	},
-	[PRCI_CLK_TLCLK] = {
-		.name = "tlclk",
-		.parent_name = "corepll",
-		.ops = &sifive_fu740_prci_tlclksel_clk_ops,
-	},
-	[PRCI_CLK_PCLK] = {
-		.name = "pclk",
-		.parent_name = "hfpclkpll",
-		.ops = &sifive_fu740_prci_hfpclkplldiv_clk_ops,
-	},
+struct __prci_clock *__prci_init_clocks_fu740[] = {
+	[PRCI_CLK_COREPLL]	= &fu740_corepll,
+	[PRCI_CLK_DDRPLL]	= &fu740_ddrpll,
+	[PRCI_CLK_GEMGXLPLL]	= &fu740_gemgxlpll,
+	[PRCI_CLK_DVFSCOREPLL]	= &fu740_dvfscorepll,
+	[PRCI_CLK_HFPCLKPLL]	= &fu740_hfpclkpll,
+	[PRCI_CLK_CLTXPLL]	= &fu740_cltxpll,
+	[PRCI_CLK_TLCLK]	= &fu740_tlclk,
+	[PRCI_CLK_PCLK]		= &fu740_pclk,
 };
diff --git a/drivers/clk/sifive/fu740-prci.h b/drivers/clk/sifive/fu740-prci.h
index 13ef971f7764..3f03295f719a 100644
--- a/drivers/clk/sifive/fu740-prci.h
+++ b/drivers/clk/sifive/fu740-prci.h
@@ -11,7 +11,7 @@
 
 #define NUM_CLOCK_FU740	8
 
-extern struct __prci_clock __prci_init_clocks_fu740[NUM_CLOCK_FU740];
+extern struct __prci_clock *__prci_init_clocks_fu740[NUM_CLOCK_FU740];
 
 static const struct prci_clk_desc prci_clk_fu740 = {
 	.clks = __prci_init_clocks_fu740,
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index 4098dbc5881a..2ef3f9f91b33 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -431,7 +431,7 @@ static int __prci_register_clocks(struct device *dev, struct __prci_data *pd,
 
 	/* Register PLLs */
 	for (i = 0; i < desc->num_clks; ++i) {
-		pic = &(desc->clks[i]);
+		pic = desc->clks[i];
 
 		init.name = pic->name;
 		init.parent_names = &pic->parent_name;
diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index bc0646bc9c3e..e6c9f72e20de 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -253,6 +253,14 @@ struct __prci_clock {
 	struct __prci_data *pd;
 };
 
+#define DEFINE_PRCI_CLOCK(_platform, _name, _parent, _ops, _pwd)	\
+	static struct __prci_clock _platform##_##_name = {		\
+		.name = #_name,						\
+		.parent_name = #_parent,				\
+		.ops = _ops,						\
+		.pwd = _pwd,						\
+	}								\
+
 #define clk_hw_to_prci_clock(pwd) container_of(pwd, struct __prci_clock, hw)
 
 /*
@@ -261,7 +269,7 @@ struct __prci_clock {
  * @num_clks: the number of element of clks
  */
 struct prci_clk_desc {
-	struct __prci_clock *clks;
+	struct __prci_clock **clks;
 	size_t num_clks;
 };
 
-- 
2.28.0

