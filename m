Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A7C303E46
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392525AbhAZNMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:12:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391912AbhAZMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:47:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6EDC0698CE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id 7so16317531wrz.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 04:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/Y+6T8TTSu8d83A2XzlHvv9/Bw0gU//w5nr9fAJlo4=;
        b=cVPSG987Hn12pzJnrmO1fa88QJIfdteE/Aaioqfl1kcNfsviHd1mC1LiGhGi0xNZhm
         CiMDsua6PlSMR1n9vusdYumF1G9vaagTMm8U6M6FQ0/JrsgTzw+1xtupGZvy1D4kSaYB
         +1xqsmoWpZJB+RdHTaYO19hQ7vL7Bb/mK2xDfY4DE5pmVgYVjVOSJJymzZbRNt4I8sov
         ZwohflbP98Bo41S/k0OarAYMMTeeXa6oJANxqzSiubZ7FDmRkKS1cW57/6FCHjihfuGx
         zDbwSdPTj0NVyrihOrtIrq4NREv0Slo0NEpp5Nc/ZnJDaEo7HcemWCwd7OwdhuKSOzL+
         N0yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/Y+6T8TTSu8d83A2XzlHvv9/Bw0gU//w5nr9fAJlo4=;
        b=hadhPXmkAIwHIMdAnpe3vi6Fmp7K4oqaUL5Tm2qUvYwrVweCZWL0NScEh+keKGMIFj
         3pQnD2EgY0pc5tlCNmHuIqkF9y5Z+ehK07yTD9vRRJ8YIoxt80r9uLKZu8kKoKLJI54D
         FsEkpjaCIpdWIcbBQ9PpsoaSNazqeaZNcDp2g+SHhMkxPH0Lc+xDIexUmZz+h3caAL77
         bFqZ2LCqNI4SODlPmSFWKBHPGZUgetqC9C6G3aWHTXIwmVUG1sx4IaG2T3a+Lu93N2+m
         2VzsyjLk6PMYv+OpxyFR5k9PiFJPSIkOM0arUgMeW5o3ZfnMtCpZCxpOQpaDR3ESUQ9t
         +Qkw==
X-Gm-Message-State: AOAM531AE4TA1TlysvZ0nDQPdslFnNZIKUoonUYvuFLqqg49o1IKpFt2
        7YKuyIqBvuz1RTT2LZZynWE/5A==
X-Google-Smtp-Source: ABdhPJzX2sNvznoB78FA81m7YLor2FvymMTtY+0KWuz+yiWb/aVjjszjTWnGjJWcV7IO8TapAXXogg==
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr5809009wrx.239.1611665150925;
        Tue, 26 Jan 2021 04:45:50 -0800 (PST)
Received: from dell.default ([91.110.221.188])
        by smtp.gmail.com with ESMTPSA id i131sm3263073wmi.25.2021.01.26.04.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 04:45:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio@elopez.com.ar>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/21] clk: sunxi: clk-sun9i-core: Demote non-conformant kernel-doc headers
Date:   Tue, 26 Jan 2021 12:45:24 +0000
Message-Id: <20210126124540.3320214-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210126124540.3320214-1-lee.jones@linaro.org>
References: <20210126124540.3320214-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Headers must describe their parameters.

Fixes the following W=1 kernel build warning(s):

 drivers/clk/sunxi/clk-sun9i-core.c:27: warning: Function parameter or member 'req' not described in 'sun9i_a80_get_pll4_factors'
 drivers/clk/sunxi/clk-sun9i-core.c:100: warning: Function parameter or member 'req' not described in 'sun9i_a80_get_gt_factors'
 drivers/clk/sunxi/clk-sun9i-core.c:155: warning: Function parameter or member 'req' not described in 'sun9i_a80_get_ahb_factors'
 drivers/clk/sunxi/clk-sun9i-core.c:235: warning: Function parameter or member 'req' not described in 'sun9i_a80_get_apb1_factors'

Cc: "Emilio López" <emilio@elopez.com.ar>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>
Cc: linux-clk@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/clk/sunxi/clk-sun9i-core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sun9i-core.c b/drivers/clk/sunxi/clk-sun9i-core.c
index 305ad78d5fb4f..d93c7a53c6c02 100644
--- a/drivers/clk/sunxi/clk-sun9i-core.c
+++ b/drivers/clk/sunxi/clk-sun9i-core.c
@@ -14,7 +14,7 @@
 #include "clk-factors.h"
 
 
-/**
+/*
  * sun9i_a80_get_pll4_factors() - calculates n, p, m factors for PLL4
  * PLL4 rate is calculated as follows
  * rate = (parent_rate * n >> p) / (m + 1);
@@ -90,7 +90,7 @@ static void __init sun9i_a80_pll4_setup(struct device_node *node)
 CLK_OF_DECLARE(sun9i_a80_pll4, "allwinner,sun9i-a80-pll4-clk", sun9i_a80_pll4_setup);
 
 
-/**
+/*
  * sun9i_a80_get_gt_factors() - calculates m factor for GT
  * GT rate is calculated as follows
  * rate = parent_rate / (m + 1);
@@ -145,7 +145,7 @@ static void __init sun9i_a80_gt_setup(struct device_node *node)
 CLK_OF_DECLARE(sun9i_a80_gt, "allwinner,sun9i-a80-gt-clk", sun9i_a80_gt_setup);
 
 
-/**
+/*
  * sun9i_a80_get_ahb_factors() - calculates p factor for AHB0/1/2
  * AHB rate is calculated as follows
  * rate = parent_rate >> p;
@@ -225,7 +225,7 @@ static void __init sun9i_a80_apb0_setup(struct device_node *node)
 CLK_OF_DECLARE(sun9i_a80_apb0, "allwinner,sun9i-a80-apb0-clk", sun9i_a80_apb0_setup);
 
 
-/**
+/*
  * sun9i_a80_get_apb1_factors() - calculates m, p factors for APB1
  * APB1 rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
-- 
2.25.1

