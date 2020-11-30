Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711442C7FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 09:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgK3IZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 03:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgK3IZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 03:25:00 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEC6C061A4A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:23:50 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id e20so917762pjt.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 00:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPhbw/l4Lmoi4e3/ZDqFT/uzpAV6A+cExXYfeDkimJ8=;
        b=bDI0Qxgmr4Zz15nwVbhI3DwedTksGKQvS15CPyaHvnqPCATZE0qCNzDIuuM3EGFwR0
         bO+8PFVJcPid4cAw4o3QCdY+tYYv65rw3NiFgjk4EQKQ6kgtwWeq4xBQyq9+ywrzD4Gs
         FqP7i6NztduFqn8o4AXFz4VXPbL9zyPcENsxtfy/QnFNxKOORWNRGH0jAQfX3GzRGUuA
         NxF+NZ6lgCZ1F4iTQS2AdW4y4Ene+ByNQM8CglsKJ/sAg+z23OUJEJkM3mYcF/XtUnP9
         OeodXGTAZfSa4rfK0Bnva2uU/vdI9ESQ+NzC+p+N6OKBMCsrmZDSyuRnZlepmr8ZvKLC
         dsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPhbw/l4Lmoi4e3/ZDqFT/uzpAV6A+cExXYfeDkimJ8=;
        b=avGko0oTBJQRK1wfZrMnrRRnLD1Z3GG2t08spg4Ap/BL1vG/92MVh/l+XiMjz8XfTj
         scdg2F48DRl2QK1ri0P5HA7Ap4y0n+NcSW/DP0loNyc+AHbMuOzqUJ92cQaF1o0RZJQC
         a+QhcYlfidrVZQDHBlaSdSbWdDf0xOcUHQrZzBi9z9egZl6MRuptcKkJ/m+aldDrKuWD
         Bp0Fqganz9VvJz06c0ZlIfhLgPy4N2W99kVny0GRFumpOD+PYHXjghnZZNyhBiPujTfR
         7cxhqCDaWrkAv2QMVe+7uZqpk5BKcdy9ntuzWFTlfx5z0H8/jmKDnZM+ByDfbpS74a8g
         lKGw==
X-Gm-Message-State: AOAM533HQxa0Hkxd+ai+lWJUAUj5+nDPO/0JExx2uVvfzxykq4w9b5fc
        nrefxs+BQZFh/L1EZx0eilW5Qg==
X-Google-Smtp-Source: ABdhPJwOoZAq8B7P8OuprJhybILl7K+wH2zjntso/w2s9RHGMlj9VDlfelwVzqDn7bgjUZT5uUg1yw==
X-Received: by 2002:a17:90a:b118:: with SMTP id z24mr15191256pjq.14.1606724630483;
        Mon, 30 Nov 2020 00:23:50 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id u1sm21265338pjn.40.2020.11.30.00.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 00:23:50 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, sboyd@kernel.org,
        schwab@linux-m68k.org, pragnesh.patel@openfive.com,
        aou@eecs.berkeley.edu, mturquette@baylibre.com,
        yash.shah@sifive.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Pragnesh Patel <pragnesh.patel@sifive.com>
Subject: [PATCH v5 5/5] clk: sifive: Add clock enable and disable ops
Date:   Mon, 30 Nov 2020 16:23:30 +0800
Message-Id: <20201130082330.77268-6-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130082330.77268-1-zong.li@sifive.com>
References: <20201130082330.77268-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pragnesh Patel <pragnesh.patel@sifive.com>

Add new functions "sifive_prci_clock_enable(), sifive_prci_clock_disable()
and sifive_clk_is_enabled()" to enable or disable the PRCI clock

Signed-off-by: Pragnesh Patel <pragnesh.patel@sifive.com>
---
 drivers/clk/sifive/fu540-prci.c  |  6 +++
 drivers/clk/sifive/fu740-prci.c  |  9 ++++
 drivers/clk/sifive/sifive-prci.c | 91 ++++++++++++++++++++++++++++----
 drivers/clk/sifive/sifive-prci.h | 12 +++++
 4 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/sifive/fu540-prci.c b/drivers/clk/sifive/fu540-prci.c
index 34dc4ea6a3af..3fbee1da9701 100644
--- a/drivers/clk/sifive/fu540-prci.c
+++ b/drivers/clk/sifive/fu540-prci.c
@@ -33,16 +33,19 @@
 
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
@@ -51,6 +54,9 @@ static const struct clk_ops sifive_fu540_prci_wrpll_clk_ops = {
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
index cc4b4c6b4437..5922be9edc17 100644
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
@@ -199,16 +213,73 @@ int sifive_prci_wrpll_set_rate(struct clk_hw *hw,
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
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&pd->lock, flags);
+
+	if (sifive_clk_is_enabled(hw)) {
+		spin_unlock_irqrestore(&pd->lock, flags);
+		return 0;
+	}
+
+	__prci_wrpll_write_cfg1(pd, pwd, PRCI_COREPLLCFG1_CKE_MASK);
+
 	if (pwd->disable_bypass)
 		pwd->disable_bypass(pd);
 
+	spin_unlock_irqrestore(&pd->lock, flags);
+
 	return 0;
 }
 
+void sifive_prci_clock_disable(struct clk_hw *hw)
+{
+	struct __prci_clock *pc = clk_hw_to_prci_clock(hw);
+	struct __prci_wrpll_data *pwd = pc->pwd;
+	struct __prci_data *pd = pc->pd;
+	unsigned long flags = 0;
+	u32 r;
+
+	spin_lock_irqsave(&pd->lock, flags);
+
+	r = __prci_readl(pd, pwd->cfg1_offs);
+	r &= ~PRCI_COREPLLCFG1_CKE_MASK;
+
+	__prci_wrpll_write_cfg1(pd, pwd, r);
+
+	if (pwd->enable_bypass)
+		pwd->enable_bypass(pd);
+
+	spin_unlock_irqrestore(&pd->lock, flags);
+}
+
 /* TLCLKSEL clock integration */
 
 unsigned long sifive_prci_tlclksel_recalc_rate(struct clk_hw *hw,
@@ -427,7 +498,7 @@ static int __prci_register_clocks(struct device *dev, struct __prci_data *pd,
 		pic->pd = pd;
 
 		if (pic->pwd)
-			__prci_wrpll_read_cfg(pd, pic->pwd);
+			__prci_wrpll_read_cfg0(pd, pic->pwd);
 
 		r = devm_clk_hw_register(dev, &pic->hw);
 		if (r) {
@@ -483,6 +554,8 @@ static int sifive_prci_probe(struct platform_device *pdev)
 	if (IS_ERR(pd->va))
 		return PTR_ERR(pd->va);
 
+	spin_lock_init(&pd->lock);
+
 	r = __prci_register_clocks(dev, pd, desc);
 	if (r) {
 		dev_err(dev, "could not register clocks: %d\n", r);
diff --git a/drivers/clk/sifive/sifive-prci.h b/drivers/clk/sifive/sifive-prci.h
index 88493f3b9edf..4180486047e4 100644
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
@@ -205,12 +210,14 @@
 /**
  * struct __prci_data - per-device-instance data
  * @va: base virtual address of the PRCI IP block
+ * @lock: spin lock for all clocks
  * @hw_clks: encapsulates struct clk_hw records
  *
  * PRCI per-device instance data
  */
 struct __prci_data {
 	void __iomem *va;
+	spinlock_t lock;
 	struct clk_hw_onecell_data hw_clks;
 };
 
@@ -220,6 +227,7 @@ struct __prci_data {
  * @enable_bypass: fn ptr to code to bypass the WRPLL (if applicable; else NULL)
  * @disable_bypass: fn ptr to code to not bypass the WRPLL (or NULL)
  * @cfg0_offs: WRPLL CFG0 register offset (in bytes) from the PRCI base address
+ * @cfg1_offs: WRPLL CFG1 register offset (in bytes) from the PRCI base address
  *
  * @enable_bypass and @disable_bypass are used for WRPLL instances
  * that contain a separate external glitchless clock mux downstream
@@ -230,6 +238,7 @@ struct __prci_wrpll_data {
 	void (*enable_bypass)(struct __prci_data *pd);
 	void (*disable_bypass)(struct __prci_data *pd);
 	u8 cfg0_offs;
+	u8 cfg1_offs;
 };
 
 /**
@@ -279,6 +288,9 @@ long sifive_prci_wrpll_round_rate(struct clk_hw *hw, unsigned long rate,
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

