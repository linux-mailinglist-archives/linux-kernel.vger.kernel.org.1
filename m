Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECB32950A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444570AbgJUQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2444555AbgJUQV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:21:59 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED45C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p13so3171388edi.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ctEEpwCu2m+UGEAQqLgzNXgXDvvkBbjRVfAgqCEvH10=;
        b=BSaO1y3B/QG1IHhLPf2ECgY23OLMdpsc5MJlpyTNsmpSByjKefPgk+5uS1NlZ5eiJx
         PLz4ji/K99ZCc6hmJWlCumLjBC44Yp4kqUsACqziNydzwLp6CtI4borrrwL7XCYAyXXI
         VK+wsQ57JTIAS8KthOSHB3MPDyY1jkFBB+/QwJj/1esXgo0yAxHnn+uRy6+el3eJ/VA7
         WlxIIZSPSOSMETDdlWYAttacfNvOYxY8HYMgQ/6FKevzalobdk7KyDSzW+TyY0UIPJBY
         3RUSYsvA9HjWsRth0ERDulY9EcwdE1JYZardYOnMaU9FKCYwpO4APEKl5rF7DEit5ziN
         RGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ctEEpwCu2m+UGEAQqLgzNXgXDvvkBbjRVfAgqCEvH10=;
        b=b7Xj93dkYRhFADPmUtWOMQLi7oEy0NCS7AZ+UDHEcImfdNyyvmyHwhQCL2l6tfnqJ5
         vKa1igNCUXNnuoKiHcxR9ZM8bdeEXBtY77V0Fp1KlEBtUdgJYGhGaQcSBtNUg2+/3If6
         U8yPFO2fgB2D2UTkUpfaSjBpuZmoEobSb7jILv79gXtxGxQDCv9TohpvdDXjozqgm87A
         Q6flC3s5PTcyZkg45gzahAFUo9kHj5k148BZPNnfftmdZLB1Q65ilYQvvxIdEucF1P6N
         AC3+14plqr8dKDAXqWmKj9ppuWfthr/FL9Cio7sL2odbJccP4Ehgi1KRu3dm+7maT0Pa
         3NcQ==
X-Gm-Message-State: AOAM533eAEmhg5gkpKh0du+irMjXaPQ+FJ2yeN4AdBb1zi9FUST94/yI
        kOMM/NcumOAozGvZtjgKuOAkSQ==
X-Google-Smtp-Source: ABdhPJwc7T5NdEnRaXOwk0sP0IToOEippbCC/7KmSW9llV170+TKEo32IKW1qVilAaMAIS/Om3EhTg==
X-Received: by 2002:aa7:c915:: with SMTP id b21mr3868779edt.25.1603297318129;
        Wed, 21 Oct 2020 09:21:58 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id 11sm2566667ejy.19.2020.10.21.09.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:21:57 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v2 3/3] clk: meson: g12: drop use of __clk_lookup()
Date:   Wed, 21 Oct 2020 18:21:47 +0200
Message-Id: <20201021162147.563655-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201021162147.563655-1-jbrunet@baylibre.com>
References: <20201021162147.563655-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

g12 clock controller used __clk_lookup() to get struct clk from a
struct clk_hw. This type of hack is no longer required as CCF now provides
the necessary functions to get this.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/g12a.c | 68 +++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 36 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 28f976dbdd24..bbb75541dad9 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -5156,10 +5156,11 @@ static const struct reg_sequence g12a_init_regs[] = {
 	{ .reg = HHI_MPLL_CNTL0,	.def = 0x00000543 },
 };
 
-static int meson_g12a_dvfs_setup_common(struct platform_device *pdev,
+#define DVFS_CON_ID "dvfs"
+
+static int meson_g12a_dvfs_setup_common(struct device *dev,
 					struct clk_hw **hws)
 {
-	const char *notifier_clk_name;
 	struct clk *notifier_clk;
 	struct clk_hw *xtal;
 	int ret;
@@ -5168,21 +5169,21 @@ static int meson_g12a_dvfs_setup_common(struct platform_device *pdev,
 
 	/* Setup clock notifier for cpu_clk_postmux0 */
 	g12a_cpu_clk_postmux0_nb_data.xtal = xtal;
-	notifier_clk_name = clk_hw_get_name(&g12a_cpu_clk_postmux0.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_cpu_clk_postmux0.hw,
+					   DVFS_CON_ID);
 	ret = clk_notifier_register(notifier_clk,
 				    &g12a_cpu_clk_postmux0_nb_data.nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the cpu_clk_postmux0 notifier\n");
+		dev_err(dev, "failed to register the cpu_clk_postmux0 notifier\n");
 		return ret;
 	}
 
 	/* Setup clock notifier for cpu_clk_dyn mux */
-	notifier_clk_name = clk_hw_get_name(&g12a_cpu_clk_dyn.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_cpu_clk_dyn.hw,
+					   DVFS_CON_ID);
 	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the cpu_clk_dyn notifier\n");
+		dev_err(dev, "failed to register the cpu_clk_dyn notifier\n");
 		return ret;
 	}
 
@@ -5192,33 +5193,33 @@ static int meson_g12a_dvfs_setup_common(struct platform_device *pdev,
 static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 {
 	struct clk_hw **hws = g12b_hw_onecell_data.hws;
-	const char *notifier_clk_name;
+	struct device *dev = &pdev->dev;
 	struct clk *notifier_clk;
 	struct clk_hw *xtal;
 	int ret;
 
-	ret = meson_g12a_dvfs_setup_common(pdev, hws);
+	ret = meson_g12a_dvfs_setup_common(dev, hws);
 	if (ret)
 		return ret;
 
 	xtal = clk_hw_get_parent_by_index(hws[CLKID_CPU_CLK_DYN1_SEL], 0);
 
 	/* Setup clock notifier for cpu_clk mux */
-	notifier_clk_name = clk_hw_get_name(&g12b_cpu_clk.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_cpu_clk.hw,
+					   DVFS_CON_ID);
 	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the cpu_clk notifier\n");
+		dev_err(dev, "failed to register the cpu_clk notifier\n");
 		return ret;
 	}
 
 	/* Setup clock notifier for sys1_pll */
-	notifier_clk_name = clk_hw_get_name(&g12b_sys1_pll.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_sys1_pll.hw,
+					   DVFS_CON_ID);
 	ret = clk_notifier_register(notifier_clk,
 				    &g12b_cpu_clk_sys1_pll_nb_data.nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the sys1_pll notifier\n");
+		dev_err(dev, "failed to register the sys1_pll notifier\n");
 		return ret;
 	}
 
@@ -5226,40 +5227,37 @@ static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 
 	/* Setup clock notifier for cpub_clk_postmux0 */
 	g12b_cpub_clk_postmux0_nb_data.xtal = xtal;
-	notifier_clk_name = clk_hw_get_name(&g12b_cpub_clk_postmux0.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_cpub_clk_postmux0.hw,
+					   DVFS_CON_ID);
 	ret = clk_notifier_register(notifier_clk,
 				    &g12b_cpub_clk_postmux0_nb_data.nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the cpub_clk_postmux0 notifier\n");
+		dev_err(dev, "failed to register the cpub_clk_postmux0 notifier\n");
 		return ret;
 	}
 
 	/* Setup clock notifier for cpub_clk_dyn mux */
-	notifier_clk_name = clk_hw_get_name(&g12b_cpub_clk_dyn.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_cpub_clk_dyn.hw, "dvfs");
 	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the cpub_clk_dyn notifier\n");
+		dev_err(dev, "failed to register the cpub_clk_dyn notifier\n");
 		return ret;
 	}
 
 	/* Setup clock notifier for cpub_clk mux */
-	notifier_clk_name = clk_hw_get_name(&g12b_cpub_clk.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_cpub_clk.hw, DVFS_CON_ID);
 	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the cpub_clk notifier\n");
+		dev_err(dev, "failed to register the cpub_clk notifier\n");
 		return ret;
 	}
 
 	/* Setup clock notifier for sys_pll */
-	notifier_clk_name = clk_hw_get_name(&g12a_sys_pll.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_sys_pll.hw, DVFS_CON_ID);
 	ret = clk_notifier_register(notifier_clk,
 				    &g12b_cpub_clk_sys_pll_nb_data.nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the sys_pll notifier\n");
+		dev_err(dev, "failed to register the sys_pll notifier\n");
 		return ret;
 	}
 
@@ -5269,29 +5267,27 @@ static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 static int meson_g12a_dvfs_setup(struct platform_device *pdev)
 {
 	struct clk_hw **hws = g12a_hw_onecell_data.hws;
-	const char *notifier_clk_name;
+	struct device *dev = &pdev->dev;
 	struct clk *notifier_clk;
 	int ret;
 
-	ret = meson_g12a_dvfs_setup_common(pdev, hws);
+	ret = meson_g12a_dvfs_setup_common(dev, hws);
 	if (ret)
 		return ret;
 
 	/* Setup clock notifier for cpu_clk mux */
-	notifier_clk_name = clk_hw_get_name(&g12a_cpu_clk.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_cpu_clk.hw, DVFS_CON_ID);
 	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the cpu_clk notifier\n");
+		dev_err(dev, "failed to register the cpu_clk notifier\n");
 		return ret;
 	}
 
 	/* Setup clock notifier for sys_pll */
-	notifier_clk_name = clk_hw_get_name(&g12a_sys_pll.hw);
-	notifier_clk = __clk_lookup(notifier_clk_name);
+	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_sys_pll.hw, DVFS_CON_ID);
 	ret = clk_notifier_register(notifier_clk, &g12a_sys_pll_nb_data.nb);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to register the sys_pll notifier\n");
+		dev_err(dev, "failed to register the sys_pll notifier\n");
 		return ret;
 	}
 
-- 
2.25.4

