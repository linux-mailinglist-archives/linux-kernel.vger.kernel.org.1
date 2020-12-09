Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D09C2D3F27
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgLIJu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729575AbgLIJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:50:50 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB83BC0611C5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 01:49:40 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id p6so649520plr.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 01:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwreMoeH4SnT56tBufLQOBW9SIF240mbv2RWRaQ2f/M=;
        b=CI52kNmB7EbEIN2jyrwNoUUfmXXlJVm1iKRJnzskst9EDmWRrgVorWDeMetPI0Osmy
         lwoVRnbcdBvvb4qy/8fRqR/XPHR8hiJWfJqoGVL+zfSX+GpYp/eb7rU33Oc/bKJTBWLG
         whbwKN29MOEqrXacQb0zvynpbXGereg9CwXLDc4dFTUtvFSsWne1JFWn6l9jTAcLhURq
         57KPpZfLRVx519LNI9UlioQZeT9DujXsgzMX45Ib4dxWzSTHRfxrHtA0G2692qplC7D5
         FRr8IRYmRopj7+CGhrl6+yopk9gweYoN0btgkyyeQ4IvLuDr/WI6cqd03jZ1yZ3kh1/p
         Rh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwreMoeH4SnT56tBufLQOBW9SIF240mbv2RWRaQ2f/M=;
        b=BYi325LK21E5SocnT3A3Ty/phEjkrz/jHgVn1rAkIinvGawr/8ZWZ+rBX3DAObr0fP
         VUWUqn35f3FOPlAYByxDVBRjInrf/9NyR4qigvPJpp+7ef0FtsHYDEJ8wupFKwmHk06A
         fpE+0cJdkiTHxPQzCR95AvdUQDvXNJklCwzsNNaIJeEt4G8Re+CzwMeWvoSXd7TdjBQc
         111lyTSQKommIU3fxBZf0YiFpAakLS22TdWz+1RCSxmsf94cKsxqkzHdLw8P294EWzUs
         xPi2BZdAPjjjGpm9u5RtvGhDhFY8kmb42X7QDcNIc/7tsgys8RmmT3EOfUCo0iCqNrM/
         hvnQ==
X-Gm-Message-State: AOAM5335X9ZUFq8BoIR9w3aQi1nwU3LVCEFmGwuBkrVEk4BAmDrGbKA/
        h926/3UHJp5skHBGXyvpIF7dlg==
X-Google-Smtp-Source: ABdhPJyAicWXXxfxVP6rs/YKrefEekTOct1d2JzBTNca9RLcSvuUwLn1a7bU7jvpM5TtZaTdqxivKg==
X-Received: by 2002:a17:902:6903:b029:da:f458:798c with SMTP id j3-20020a1709026903b02900daf458798cmr1274906plk.68.1607507380463;
        Wed, 09 Dec 2020 01:49:40 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 129sm1890354pfw.86.2020.12.09.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 01:49:40 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH v7 5/5] clk: sifive: Add clock enable and disable ops
Date:   Wed,  9 Dec 2020 17:49:16 +0800
Message-Id: <20201209094916.17383-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209094916.17383-1-zong.li@sifive.com>
References: <20201209094916.17383-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pragnesh Patel <pragnesh.patel@sifive.com>

Add new functions "sifive_prci_clock_enable(), sifive_prci_clock_disable()
and sifive_clk_is_enabled()" to enable or disable the PRCI clock

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
Tested-by: Zong Li <zong.li@sifive.com>
---
 drivers/clk/sifive/fu540-prci.c  |  6 +++
 drivers/clk/sifive/fu740-prci.c  |  9 ++++
 drivers/clk/sifive/sifive-prci.c | 77 ++++++++++++++++++++++++++++----
 drivers/clk/sifive/sifive-prci.h | 10 +++++
 4 files changed, 93 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
index e2353dee8c52..3b558835984b 100644
--- a/drivers/clk/sifive/fu540-prci.c
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -24,16 +24,19 @@
 
 static struct __prci_wrpll_data __prci_corepll_data = {
 	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_COREPLLCFG1_OFFSET,
 	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
 	.disable_bypass = sifive_prci_coreclksel_use_corepll,
 };
 
 static struct __prci_wrpll_data __prci_ddrpll_data = {
 	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_DDRPLLCFG1_OFFSET,
 };
 
 static struct __prci_wrpll_data __prci_gemgxlpll_data = {
 	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
 };
 
 /* Linux clock framework integration */
@@ -42,6 +45,9 @@ static const struct clk_ops sifive_fu540_prci_wrpll_clk_ops = {
 	.set_rate = sifive_prci_wrpll_set_rate,
 	.round_rate = sifive_prci_wrpll_round_rate,
 	.recalc_rate = sifive_prci_wrpll_recalc_rate,
+	.enable = sifive_prci_clock_enable,
+	.disable = sifive_prci_clock_disable,
+	.is_enabled = sifive_clk_is_enabled,
 };
 
 static const struct clk_ops sifive_fu540_prci_wrpll_ro_clk_ops = {
diff --git a/drivers/clk/sifive/fu740-prci.c b/drivers/clk/sifive/fu740-prci.c
index 41ddd4431497..db8300223745 100644
--- a/drivers/clk/sifive/fu740-prci.c
+++ b/drivers/clk/sifive/fu740-prci.c
@@ -12,32 +12,38 @@
 
 static struct __prci_wrpll_data __prci_corepll_data = {
 	.cfg0_offs = PRCI_COREPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_COREPLLCFG1_OFFSET,
 	.enable_bypass = sifive_prci_coreclksel_use_hfclk,
 	.disable_bypass = sifive_prci_coreclksel_use_final_corepll,
 };
 
 static struct __prci_wrpll_data __prci_ddrpll_data = {
 	.cfg0_offs = PRCI_DDRPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_DDRPLLCFG1_OFFSET,
 };
 
 static struct __prci_wrpll_data __prci_gemgxlpll_data = {
 	.cfg0_offs = PRCI_GEMGXLPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_GEMGXLPLLCFG1_OFFSET,
 };
 
 static struct __prci_wrpll_data __prci_dvfscorepll_data = {
 	.cfg0_offs = PRCI_DVFSCOREPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_DVFSCOREPLLCFG1_OFFSET,
 	.enable_bypass = sifive_prci_corepllsel_use_corepll,
 	.disable_bypass = sifive_prci_corepllsel_use_dvfscorepll,
 };
 
 static struct __prci_wrpll_data __prci_hfpclkpll_data = {
 	.cfg0_offs = PRCI_HFPCLKPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_HFPCLKPLLCFG1_OFFSET,
 	.enable_bypass = sifive_prci_hfpclkpllsel_use_hfclk,
 	.disable_bypass = sifive_prci_hfpclkpllsel_use_hfpclkpll,
 };
 
 static struct __prci_wrpll_data __prci_cltxpll_data = {
 	.cfg0_offs = PRCI_CLTXPLLCFG0_OFFSET,
+	.cfg1_offs = PRCI_CLTXPLLCFG1_OFFSET,
 };
 
 /* Linux clock framework integration */
@@ -46,6 +52,9 @@ static const struct clk_ops sifive_fu740_prci_wrpll_clk_ops = {
 	.set_rate = sifive_prci_wrpll_set_rate,
 	.round_rate = sifive_prci_wrpll_round_rate,
 	.recalc_rate = sifive_prci_wrpll_recalc_rate,
+	.enable = sifive_prci_clock_enable,
+	.disable = sifive_prci_clock_disable,
+	.is_enabled = sifive_clk_is_enabled,
 };
 
 static const struct clk_ops sifive_fu740_prci_wrpll_ro_clk_ops = {
diff --git a/drivers/clk/sifive/sifive-prci.c b/drivers/clk/sifive/sifive-prci.c
index cc4b4c6b4437..c78b042750e2 100644
--- a/drivers/clk/sifive/sifive-prci.c
+++ b/drivers/clk/sifive/sifive-prci.c
@@ -113,7 +113,7 @@ static u32 __prci_wrpll_pack(const struct wrpll_cfg *c)
 }
 
 /**
- * __prci_wrpll_read_cfg() - read the WRPLL configuration from the PRCI
+ * __prci_wrpll_read_cfg0() - read the WRPLL configuration from the PRCI
  * @pd: PRCI context
  * @pwd: PRCI WRPLL metadata
  *
@@ -124,14 +124,14 @@ static u32 __prci_wrpll_pack(const struct wrpll_cfg *c)
  * Context: Any context.  Caller must prevent the records pointed to by
  *          @pd and @pwd from changing during execution.
  */
-static void __prci_wrpll_read_cfg(struct __prci_data *pd,
-				  struct __prci_wrpll_data *pwd)
+static void __prci_wrpll_read_cfg0(struct __prci_data *pd,
+				   struct __prci_wrpll_data *pwd)
 {
 	__prci_wrpll_unpack(&pwd->c, __prci_readl(pd, pwd->cfg0_offs));
 }
 
 /**
- * __prci_wrpll_write_cfg() - write WRPLL configuration into the PRCI
+ * __prci_wrpll_write_cfg0() - write WRPLL configuration into the PRCI
  * @pd: PRCI context
  * @pwd: PRCI WRPLL metadata
  * @c: WRPLL configuration record to write
@@ -144,15 +144,29 @@ static void __prci_wrpll_read_cfg(struct __prci_data *pd,
  * Context: Any context.  Caller must prevent the records pointed to by
  *          @pd and @pwd from changing during execution.
  */
-static void __prci_wrpll_write_cfg(struct __prci_data *pd,
-				   struct __prci_wrpll_data *pwd,
-				   struct wrpll_cfg *c)
+static void __prci_wrpll_write_cfg0(struct __prci_data *pd,
+				    struct __prci_wrpll_data *pwd,
+				    struct wrpll_cfg *c)
 {
 	__prci_writel(__prci_wrpll_pack(c), pwd->cfg0_offs, pd);
 
 	memcpy(&pwd->c, c, sizeof(*c));
 }
 
+/**
+ * __prci_wrpll_write_cfg1() - write Clock enable/disable configuration
+ * into the PRCI
+ * @pd: PRCI context
+ * @pwd: PRCI WRPLL metadata
+ * @enable: Clock enable or disable value
+ */
+static void __prci_wrpll_write_cfg1(struct __prci_data *pd,
+				    struct __prci_wrpll_data *pwd,
+				    u32 enable)
+{
+	__prci_writel(enable, pwd->cfg1_offs, pd);
+}
+
 /*
  * Linux clock framework integration
  *
@@ -199,16 +213,61 @@ int sifive_prci_wrpll_set_rate(struct clk_hw *hw,
 	if (pwd->enable_bypass)
 		pwd->enable_bypass(pd);
 
-	__prci_wrpll_write_cfg(pd, pwd, &pwd->c);
+	__prci_wrpll_write_cfg0(pd, pwd, &pwd->c);
 
 	udelay(wrpll_calc_max_lock_us(&pwd->c));
 
+	return 0;
+}
+
+int sifive_clk_is_enabled(struct clk_hw *hw)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_wrpll_data *pwd = pc->pwd;
+	struct __prci_data *pd = pc->pd;
+	u32 r;
+
+	r = __prci_readl(pd, pwd->cfg1_offs);
+
+	if (r & PRCI_COREPLLCFG1_CKE_MASK)
+		return 1;
+	else
+		return 0;
+}
+
+int sifive_prci_clock_enable(struct clk_hw *hw)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_wrpll_data *pwd = pc->pwd;
+	struct __prci_data *pd = pc->pd;
+
+	if (sifive_clk_is_enabled(hw))
+		return 0;
+
+	__prci_wrpll_write_cfg1(pd, pwd, PRCI_COREPLLCFG1_CKE_MASK);
+
 	if (pwd->disable_bypass)
 		pwd->disable_bypass(pd);
 
 	return 0;
 }
 
+void sifive_prci_clock_disable(struct clk_hw *hw)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_wrpll_data *pwd = pc->pwd;
+	struct __prci_data *pd = pc->pd;
+	u32 r;
+
+	if (pwd->enable_bypass)
+		pwd->enable_bypass(pd);
+
+	r = __prci_readl(pd, pwd->cfg1_offs);
+	r &= ~PRCI_COREPLLCFG1_CKE_MASK;
+
+	__prci_wrpll_write_cfg1(pd, pwd, r);
+}
+
 /* TLCLKSEL clock integration */
 
 unsigned long sifive_prci_tlclksel_recalc_rate(struct clk_hw *hw,
@@ -427,7 +486,7 @@ static int __prci_register_clocks(struct device *dev, struct __prci_data *pd,
 		pic->pd = pd;
 
 		if (pic->pwd)
-			__prci_wrpll_read_cfg(pd, pic->pwd);
+			__prci_wrpll_read_cfg0(pd, pic->pwd);
 
 		r = devm_clk_hw_register(dev, &pic->hw);
 		if (r) {
diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index 88493f3b9edf..dbdbd1722688 100644
--- a/drivers/clk/sifive/sifive-prci.h
+++ b/drivers/clk/sifive/sifive-prci.h
@@ -40,6 +40,11 @@
 #define PRCI_COREPLLCFG0_LOCK_SHIFT	31
 #define PRCI_COREPLLCFG0_LOCK_MASK	(0x1 << PRCI_COREPLLCFG0_LOCK_SHIFT)
 
+/* COREPLLCFG1 */
+#define PRCI_COREPLLCFG1_OFFSET		0x8
+#define PRCI_COREPLLCFG1_CKE_SHIFT	31
+#define PRCI_COREPLLCFG1_CKE_MASK	(0x1 << PRCI_COREPLLCFG1_CKE_SHIFT)
+
 /* DDRPLLCFG0 */
 #define PRCI_DDRPLLCFG0_OFFSET		0xc
 #define PRCI_DDRPLLCFG0_DIVR_SHIFT	0
@@ -220,6 +225,7 @@ struct __prci_data {
  * @enable_bypass: fn ptr to code to bypass the WRPLL (if applicable; else NULL)
  * @disable_bypass: fn ptr to code to not bypass the WRPLL (or NULL)
  * @cfg0_offs: WRPLL CFG0 register offset (in bytes) from the PRCI base address
+ * @cfg1_offs: WRPLL CFG1 register offset (in bytes) from the PRCI base address
  *
  * @enable_bypass and @disable_bypass are used for WRPLL instances
  * that contain a separate external glitchless clock mux downstream
@@ -230,6 +236,7 @@ struct __prci_wrpll_data {
 	void (*enable_bypass)(struct __prci_data *pd);
 	void (*disable_bypass)(struct __prci_data *pd);
 	u8 cfg0_offs;
+	u8 cfg1_offs;
 };
 
 /**
@@ -279,6 +286,9 @@ long sifive_prci_wrpll_round_rate(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *parent_rate);
 int sifive_prci_wrpll_set_rate(struct clk_hw *hw, unsigned long rate,
 			       unsigned long parent_rate);
+int sifive_clk_is_enabled(struct clk_hw *hw);
+int sifive_prci_clock_enable(struct clk_hw *hw);
+void sifive_prci_clock_disable(struct clk_hw *hw);
 unsigned long sifive_prci_wrpll_recalc_rate(struct clk_hw *hw,
 					    unsigned long parent_rate);
 unsigned long sifive_prci_tlclksel_recalc_rate(struct clk_hw *hw,
-- 
2.29.2

