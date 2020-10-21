Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135232950F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503031AbgJUQi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503032AbgJUQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:38:56 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BF1C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:38:56 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h24so4167166ejg.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bmUTvMmlGLQ9tv2GMEVx5tSGz9QfWz+dgoSRCgpsLM=;
        b=lPxbJARnZj8JhrahTb3CjQMfx4CZRZOYvvm8mjwTYwa8kdX0yMwbt7TCZZYwkXfp6d
         4uBWD01DtroiklOaL04FsnIhXq4U0IbcH3ijPSWYpFKzVXi12Lhkd9zjFHa6ED8pLTPR
         1NENAgPG0doUEG1O3YMt7Zs2Lp1qruYCDiwG8Gq1E4r0cy9SsKTjud5/ALTHjvmhe7Eb
         PB2EK9lVlIcQBRYJLyqBdXf6AeRZVc794I1sMVm5D1kY8amgYLr9VIMe1kDGRgucd+tD
         jt3dHTd0k5W1YObSv6pV2AOK2KKBTXZ0ClPwkJ4AMOaGrLUaGrXlRgqrccLQec9IXSNg
         k0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bmUTvMmlGLQ9tv2GMEVx5tSGz9QfWz+dgoSRCgpsLM=;
        b=TOc2cQutJKy0mmMKuWiYnW+nR7+iFu5OH7ZXdpbQBJZucf6ix1sjMC7DWXoHmPo6Sj
         kQnLKHoYmWC5Ez/M2cnU3yzJ2ZbBnshsJB0RMbppeQewZbrhtbh03bLYp7f5s8qhfxa5
         1dedrHRcMbagQQzdnjAbE5tdtuGuIECs/j1Oma1gVTqcTDCQp4f1ndMOhpr8ehtLo4Ew
         wnujRhxaqY9Q++soKV27VKK611zhunyjYrnBM/xiQN91v/AJxd1xDqF/GfBrLsNWJvoc
         6NOsz5AoAL+Yq6MuUEFT6Wshtu8nGX63Vaosv+8dc8EiyG9T6EM7xImPpa7posSt8ZF5
         ksMA==
X-Gm-Message-State: AOAM530gAo+36MhdHNQ5VbOfZbAkCHzgJU5oJ/xjY5qgWnrDRqbQbGZw
        K2MP6yoV5ZeGy+nLIVBuaDgJrg==
X-Google-Smtp-Source: ABdhPJziCr8SmylxJQYZgyuvCkU84PCcMSnmPqhvy6/7Z6BFqIqIijfs88QhRpuWwaRtfMv4imMi6A==
X-Received: by 2002:a17:906:5594:: with SMTP id y20mr3928287ejp.196.1603298334729;
        Wed, 21 Oct 2020 09:38:54 -0700 (PDT)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id f26sm2549747ejx.23.2020.10.21.09.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 09:38:54 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH 2/2] clk: meson: g12: use devm variant to register notifiers
Date:   Wed, 21 Oct 2020 18:38:47 +0200
Message-Id: <20201021163847.595189-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201021163847.595189-1-jbrunet@baylibre.com>
References: <20201021163847.595189-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until now, nothing was done to unregister the dvfs clock notifiers of the
Amlogic g12 SoC family. This is not great but this driver was not really
expected to be unloaded. With the ongoing effort to build everything as
module for this platform, this needs to be cleanly handled.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

 This clean application of this patch depends on
 https://lore.kernel.org/r/20201021162147.563655-4-jbrunet@baylibre.com

 drivers/clk/meson/g12a.c | 34 ++++++++++++++++++++--------------
 include/linux/clk.h      | 10 +++++++++-
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index bbb75541dad9..bb4fa19442be 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -5171,8 +5171,8 @@ static int meson_g12a_dvfs_setup_common(struct device *dev,
 	g12a_cpu_clk_postmux0_nb_data.xtal = xtal;
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_cpu_clk_postmux0.hw,
 					   DVFS_CON_ID);
-	ret = clk_notifier_register(notifier_clk,
-				    &g12a_cpu_clk_postmux0_nb_data.nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &g12a_cpu_clk_postmux0_nb_data.nb);
 	if (ret) {
 		dev_err(dev, "failed to register the cpu_clk_postmux0 notifier\n");
 		return ret;
@@ -5181,7 +5181,8 @@ static int meson_g12a_dvfs_setup_common(struct device *dev,
 	/* Setup clock notifier for cpu_clk_dyn mux */
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_cpu_clk_dyn.hw,
 					   DVFS_CON_ID);
-	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &g12a_cpu_clk_mux_nb);
 	if (ret) {
 		dev_err(dev, "failed to register the cpu_clk_dyn notifier\n");
 		return ret;
@@ -5207,7 +5208,8 @@ static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 	/* Setup clock notifier for cpu_clk mux */
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_cpu_clk.hw,
 					   DVFS_CON_ID);
-	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &g12a_cpu_clk_mux_nb);
 	if (ret) {
 		dev_err(dev, "failed to register the cpu_clk notifier\n");
 		return ret;
@@ -5216,8 +5218,8 @@ static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 	/* Setup clock notifier for sys1_pll */
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_sys1_pll.hw,
 					   DVFS_CON_ID);
-	ret = clk_notifier_register(notifier_clk,
-				    &g12b_cpu_clk_sys1_pll_nb_data.nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &g12b_cpu_clk_sys1_pll_nb_data.nb);
 	if (ret) {
 		dev_err(dev, "failed to register the sys1_pll notifier\n");
 		return ret;
@@ -5229,8 +5231,8 @@ static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 	g12b_cpub_clk_postmux0_nb_data.xtal = xtal;
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_cpub_clk_postmux0.hw,
 					   DVFS_CON_ID);
-	ret = clk_notifier_register(notifier_clk,
-				    &g12b_cpub_clk_postmux0_nb_data.nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &g12b_cpub_clk_postmux0_nb_data.nb);
 	if (ret) {
 		dev_err(dev, "failed to register the cpub_clk_postmux0 notifier\n");
 		return ret;
@@ -5238,7 +5240,8 @@ static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 
 	/* Setup clock notifier for cpub_clk_dyn mux */
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_cpub_clk_dyn.hw, "dvfs");
-	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &g12a_cpu_clk_mux_nb);
 	if (ret) {
 		dev_err(dev, "failed to register the cpub_clk_dyn notifier\n");
 		return ret;
@@ -5246,7 +5249,8 @@ static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 
 	/* Setup clock notifier for cpub_clk mux */
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12b_cpub_clk.hw, DVFS_CON_ID);
-	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &g12a_cpu_clk_mux_nb);
 	if (ret) {
 		dev_err(dev, "failed to register the cpub_clk notifier\n");
 		return ret;
@@ -5254,8 +5258,8 @@ static int meson_g12b_dvfs_setup(struct platform_device *pdev)
 
 	/* Setup clock notifier for sys_pll */
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_sys_pll.hw, DVFS_CON_ID);
-	ret = clk_notifier_register(notifier_clk,
-				    &g12b_cpub_clk_sys_pll_nb_data.nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &g12b_cpub_clk_sys_pll_nb_data.nb);
 	if (ret) {
 		dev_err(dev, "failed to register the sys_pll notifier\n");
 		return ret;
@@ -5277,7 +5281,8 @@ static int meson_g12a_dvfs_setup(struct platform_device *pdev)
 
 	/* Setup clock notifier for cpu_clk mux */
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_cpu_clk.hw, DVFS_CON_ID);
-	ret = clk_notifier_register(notifier_clk, &g12a_cpu_clk_mux_nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+				    &g12a_cpu_clk_mux_nb);
 	if (ret) {
 		dev_err(dev, "failed to register the cpu_clk notifier\n");
 		return ret;
@@ -5285,7 +5290,8 @@ static int meson_g12a_dvfs_setup(struct platform_device *pdev)
 
 	/* Setup clock notifier for sys_pll */
 	notifier_clk = devm_clk_hw_get_clk(dev, &g12a_sys_pll.hw, DVFS_CON_ID);
-	ret = clk_notifier_register(notifier_clk, &g12a_sys_pll_nb_data.nb);
+	ret = devm_clk_notifier_register(dev, notifier_clk,
+					 &g12a_sys_pll_nb_data.nb);
 	if (ret) {
 		dev_err(dev, "failed to register the sys_pll notifier\n");
 		return ret;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 79fb52f93053..db113495d315 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -117,7 +117,8 @@ int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
  *
  * Returns 0 on success, -EERROR otherwise
  */
-int devm_clk_notifier_register(struct device *dev, struct clk *clk, struct notifier_block *nb);
+int devm_clk_notifier_register(struct device *dev, struct clk *clk,
+			       struct notifier_block *nb);
 
 /**
  * clk_get_accuracy - obtain the clock accuracy in ppb (parts per billion)
@@ -196,6 +197,13 @@ static inline int clk_notifier_unregister(struct clk *clk,
 	return -ENOTSUPP;
 }
 
+static inline int devm_clk_notifier_register(struct device *dev,
+					     struct clk *clk,
+					     struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
 static inline long clk_get_accuracy(struct clk *clk)
 {
 	return -ENOTSUPP;
-- 
2.25.4

