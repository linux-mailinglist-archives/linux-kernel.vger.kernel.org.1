Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E62DFFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgLUShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgLUShN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:37:13 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF74C061282;
        Mon, 21 Dec 2020 10:36:33 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id x16so14805930ejj.7;
        Mon, 21 Dec 2020 10:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TdgDI/McFhUeexbzSYTEtY9heEpnkFcddZvRw8i20ns=;
        b=MQz6bQ8GADRYR90oyzlMuiTZ1uUlYVAv73wP6+N+0RlsFEzChKBh0Bmzm4JJeTqkN8
         xsSowKsYskPo7cIj98tbs3tK/xqolnxYCj9ha5dIbHyw0Zf1gGK6MSyrnWI1Sjvy/ems
         5LOjXEZnM/GToC/wfT/eEZtNK37Rp4Kn9G+6GWqCI3FW3gmGlQ1oesosZtbA8G1nW0zg
         nUrakCJ0ExfgDWy07LjjPByIbgfsDfkh16T8U3FWnJlBTOjz+4D5HLfXDGRsiX+Mu1PJ
         VUjxTRNJgf7730pzrs/clNjpAjLeyjB0tJXT94Ljx/sYBzAsF/0N/nTY0L6MPbpruPgz
         Sk1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TdgDI/McFhUeexbzSYTEtY9heEpnkFcddZvRw8i20ns=;
        b=KqCFgqBDxqTAbS+XcO73VokBWgEgnmkKERgm4v3CvAFBVW/YKeoNXBLN+QsSHGaRhc
         rmN4LcPNTBMyRblregBO8oQveans1wXKqyfvY4cq5644vaSTUMArH9vUJnzvbJ81/3vI
         koB7S5ElC2mj3KS8KwG4NWv0FBU3QCvOClLvZwu7VxHALKMe/15e9XV+ftQaZY0MgLye
         ytdDYC99VDCDG0237gWh/GsGO2yuN2/eM4Tr+NHalrIldeXiPIZHusai9mnLQ5AhaM8S
         s74td3L3/FIPq3HS1CTlW8gakxKh2hDwjjcbP3UAWFACwqn4M1B9tKbFARHHRZcNxhmt
         fD+Q==
X-Gm-Message-State: AOAM533ikqISbmZicXuLHatFFb7Km8ZzDGRYv3gmxHhRRRQhC3gTAHFm
        qYoPYCjzzDbJGYRCQBLl7YY=
X-Google-Smtp-Source: ABdhPJzXaIRSxn3VSSLu2oxo6c8Ae0X+hkHuFxgqD+iWgmBEQHVio08aIDmO8JHkXyN6HL9K537arg==
X-Received: by 2002:a17:906:a192:: with SMTP id s18mr15900027ejy.249.1608575792252;
        Mon, 21 Dec 2020 10:36:32 -0800 (PST)
Received: from localhost.localdomain (p200300f137019000428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3701:9000:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id ld2sm9390408ejb.73.2020.12.21.10.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 10:36:31 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, jbrunet@baylibre.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] clk: meson: meson8b: remove compatibility code for old .dtbs
Date:   Mon, 21 Dec 2020 19:36:23 +0100
Message-Id: <20201221183624.932649-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221183624.932649-1-martin.blumenstingl@googlemail.com>
References: <20201221183624.932649-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XTAL clock is provided via .dts since Linux 5.6. Remove
compatibility code for .dtbs which are older than that.

The switch to the HHI syscon has been done with Linux 5.1. Also remove
any code needed to support .dtbs that have not switched to the HHI
syscon yet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 45 +++++--------------------------------
 1 file changed, 5 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 862f0756b50f..a844d35b553a 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -52,15 +52,6 @@ static const struct pll_params_table sys_pll_params_table[] = {
 	{ /* sentinel */ },
 };
 
-static struct clk_fixed_rate meson8b_xtal = {
-	.fixed_rate = 24000000,
-	.hw.init = &(struct clk_init_data){
-		.name = "xtal",
-		.num_parents = 0,
-		.ops = &clk_fixed_rate_ops,
-	},
-};
-
 static struct clk_regmap meson8b_fixed_pll_dco = {
 	.data = &(struct meson_clk_pll_data){
 		.en = {
@@ -2715,7 +2706,6 @@ static MESON_GATE(meson8b_ao_iface, HHI_GCLK_AO, 3);
 
 static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 	.hws = {
-		[CLKID_XTAL] = &meson8b_xtal.hw,
 		[CLKID_PLL_FIXED] = &meson8b_fixed_pll.hw,
 		[CLKID_PLL_VID] = &meson8b_vid_pll.hw,
 		[CLKID_PLL_SYS] = &meson8b_sys_pll.hw,
@@ -2922,7 +2912,6 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 
 static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 	.hws = {
-		[CLKID_XTAL] = &meson8b_xtal.hw,
 		[CLKID_PLL_FIXED] = &meson8b_fixed_pll.hw,
 		[CLKID_PLL_VID] = &meson8b_vid_pll.hw,
 		[CLKID_PLL_SYS] = &meson8b_sys_pll.hw,
@@ -3140,7 +3129,6 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 
 static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 	.hws = {
-		[CLKID_XTAL] = &meson8b_xtal.hw,
 		[CLKID_PLL_FIXED] = &meson8b_fixed_pll.hw,
 		[CLKID_PLL_VID] = &meson8b_vid_pll.hw,
 		[CLKID_PLL_SYS] = &meson8b_sys_pll.hw,
@@ -3725,36 +3713,19 @@ static struct meson8b_nb_data meson8b_cpu_nb_data = {
 	.nb.notifier_call = meson8b_cpu_clk_notifier_cb,
 };
 
-static const struct regmap_config clkc_regmap_config = {
-	.reg_bits       = 32,
-	.val_bits       = 32,
-	.reg_stride     = 4,
-};
-
 static void __init meson8b_clkc_init_common(struct device_node *np,
 			struct clk_hw_onecell_data *clk_hw_onecell_data)
 {
 	struct meson8b_clk_reset *rstc;
 	const char *notifier_clk_name;
 	struct clk *notifier_clk;
-	void __iomem *clk_base;
 	struct regmap *map;
 	int i, ret;
 
 	map = syscon_node_to_regmap(of_get_parent(np));
 	if (IS_ERR(map)) {
-		pr_info("failed to get HHI regmap - Trying obsolete regs\n");
-
-		/* Generic clocks, PLLs and some of the reset-bits */
-		clk_base = of_iomap(np, 1);
-		if (!clk_base) {
-			pr_err("%s: Unable to map clk base\n", __func__);
-			return;
-		}
-
-		map = regmap_init_mmio(NULL, clk_base, &clkc_regmap_config);
-		if (IS_ERR(map))
-			return;
+		pr_err("failed to get HHI regmap - Trying obsolete regs\n");
+		return;
 	}
 
 	rstc = kzalloc(sizeof(*rstc), GFP_KERNEL);
@@ -3778,16 +3749,10 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 		meson8b_clk_regmaps[i]->map = map;
 
 	/*
-	 * always skip CLKID_UNUSED and also skip XTAL if the .dtb provides the
-	 * XTAL clock as input.
+	 * register all clks and start with the first used ID (which is
+	 * CLKID_PLL_FIXED)
 	 */
-	if (!IS_ERR(of_clk_get_by_name(np, "xtal")))
-		i = CLKID_PLL_FIXED;
-	else
-		i = CLKID_XTAL;
-
-	/* register all clks */
-	for (; i < CLK_NR_CLKS; i++) {
+	for (i = CLKID_PLL_FIXED; i < CLK_NR_CLKS; i++) {
 		/* array might be sparse */
 		if (!clk_hw_onecell_data->hws[i])
 			continue;
-- 
2.29.2

