Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732212FCE1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732179AbhATKRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 05:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731471AbhATJeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:34:04 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31E6C0617B1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l12so17143581wry.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 01:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mu8xCztc0AgIARBS5szSrpdQPwfSUoIoG1rzTMM/Vwk=;
        b=EsuZKp4rqkAfbLaJ6Zgg5MUQDUQ1/lPYc0Ira44cBcDWzwVjzSxYL48gc6q2rTNexX
         Egeklkm7Eb73cstVN6foJSJ9PKGHytPoZRp4cGufOh28Yuv+4AEvAC06zXmebdyYAz9G
         n6EMZx0foqpyjP0Rn53FRFj4XP5zSCiG1dQBMHU5DY0T6ZholCFVudiPK8Jlgif4nRpL
         +x5CabDVTNH4NV2eOAFbwIe89W0ZIFo8GUMfTViy4nNJIXtv1pqj0f8tPu51cIr/jSmP
         Gvxm7tAz3n01OiAvzYl/7a/HTMWebH7RGtVKZ8zGBOYFAE6fIXQR2zwDCMYtOwpLdAgI
         4iFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mu8xCztc0AgIARBS5szSrpdQPwfSUoIoG1rzTMM/Vwk=;
        b=FNv2pkb2WVbKhvfUBxb6TuhBNq/7u3quGP2tWp6oE08UpTKUUdC2Wwx91Ot95kRHKL
         wcj0OxWZrPXvyQTISrOfIgjUctH7sDVthSmF0qIN0zp6HPC0S02xRrn9LdZJLMS11kYX
         0E3nqUucq7Z8rmhtwMzVS/oQJXtGf1ROAA0GIUjJrj44nrQu3D3A8pMsu+y7oo3pL0Eb
         yhnVVXkXylf6Yg9kf+blp6gE6I0C4hiVJqEwbZdNTgyvXCxrN81YkODKMPofEDhoK7x2
         WisFHdEVWR+OgrW0E8wjiSLl+M6UbPR4OjYFYBrlyJc4va47qOQpEynhjoWFKkzLKf7k
         CXDw==
X-Gm-Message-State: AOAM533SFTuKNScvMcfR9bIR8ikmJvVFtCEC4Y3LIzXAyQBVejk6FbzH
        bHIw1PKId1ng9t8Zfk/+0NZrrA==
X-Google-Smtp-Source: ABdhPJwqoP/VfLcHNwCpfnTCoMaX1/gJf0um8tj8jdmEDVhpdjgfnb6XiTOC2d6IV4znwXTumkOMhg==
X-Received: by 2002:a05:6000:108b:: with SMTP id y11mr8137126wrw.379.1611135060418;
        Wed, 20 Jan 2021 01:31:00 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id z130sm2889201wmb.33.2021.01.20.01.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 01:30:59 -0800 (PST)
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
Subject: [PATCH 14/20] clk: sunxi: clk-sunxi: Demote a bunch of non-conformant kernel-doc headers
Date:   Wed, 20 Jan 2021 09:30:34 +0000
Message-Id: <20210120093040.1719407-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210120093040.1719407-1-lee.jones@linaro.org>
References: <20210120093040.1719407-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/clk/sunxi/clk-sunxi.c:34: warning: Function parameter or member 'req' not described in 'sun4i_get_pll1_factors'
 drivers/clk/sunxi/clk-sunxi.c:81: warning: Function parameter or member 'req' not described in 'sun6i_a31_get_pll1_factors'
 drivers/clk/sunxi/clk-sunxi.c:158: warning: Function parameter or member 'req' not described in 'sun8i_a23_get_pll1_factors'
 drivers/clk/sunxi/clk-sunxi.c:202: warning: Function parameter or member 'req' not described in 'sun4i_get_pll5_factors'
 drivers/clk/sunxi/clk-sunxi.c:229: warning: Function parameter or member 'req' not described in 'sun6i_a31_get_pll6_factors'
 drivers/clk/sunxi/clk-sunxi.c:250: warning: Function parameter or member 'req' not described in 'sun5i_a13_get_ahb_factors'
 drivers/clk/sunxi/clk-sunxi.c:289: warning: Function parameter or member 'req' not described in 'sun6i_get_ahb1_factors'
 drivers/clk/sunxi/clk-sunxi.c:328: warning: Function parameter or member 'req' not described in 'sun6i_ahb1_recalc'
 drivers/clk/sunxi/clk-sunxi.c:346: warning: Function parameter or member 'req' not described in 'sun4i_get_apb1_factors'
 drivers/clk/sunxi/clk-sunxi.c:385: warning: Function parameter or member 'req' not described in 'sun7i_a20_get_out_factors'
 drivers/clk/sunxi/clk-sunxi.c:415: warning: cannot understand function prototype: 'const struct clk_factors_config sun4i_pll1_config = '
 drivers/clk/sunxi/clk-sunxi.c:724: warning: cannot understand function prototype: 'struct div_data '
 drivers/clk/sunxi/clk-sunxi.c:945: warning: Function parameter or member 'node' not described in 'sunxi_divs_clk_setup'
 drivers/clk/sunxi/clk-sunxi.c:945: warning: Function parameter or member 'data' not described in 'sunxi_divs_clk_setup'

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
 drivers/clk/sunxi/clk-sunxi.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
index e1aa1fbac48a0..5fe7049ea693a 100644
--- a/drivers/clk/sunxi/clk-sunxi.c
+++ b/drivers/clk/sunxi/clk-sunxi.c
@@ -23,7 +23,7 @@ static DEFINE_SPINLOCK(clk_lock);
 /* Maximum number of parents our clocks have */
 #define SUNXI_MAX_PARENTS	5
 
-/**
+/*
  * sun4i_get_pll1_factors() - calculates n, k, m, p factors for PLL1
  * PLL1 rate is calculated as follows
  * rate = (parent_rate * n * (k + 1) >> p) / (m + 1);
@@ -71,7 +71,7 @@ static void sun4i_get_pll1_factors(struct factors_request *req)
 	req->n = div / 4;
 }
 
-/**
+/*
  * sun6i_a31_get_pll1_factors() - calculates n, k and m factors for PLL1
  * PLL1 rate is calculated as follows
  * rate = parent_rate * (n + 1) * (k + 1) / (m + 1);
@@ -147,7 +147,7 @@ static void sun6i_a31_get_pll1_factors(struct factors_request *req)
 	}
 }
 
-/**
+/*
  * sun8i_a23_get_pll1_factors() - calculates n, k, m, p factors for PLL1
  * PLL1 rate is calculated as follows
  * rate = (parent_rate * (n + 1) * (k + 1) >> p) / (m + 1);
@@ -191,7 +191,7 @@ static void sun8i_a23_get_pll1_factors(struct factors_request *req)
 	req->n = div / 4 - 1;
 }
 
-/**
+/*
  * sun4i_get_pll5_factors() - calculates n, k factors for PLL5
  * PLL5 rate is calculated as follows
  * rate = parent_rate * n * (k + 1)
@@ -218,7 +218,7 @@ static void sun4i_get_pll5_factors(struct factors_request *req)
 	req->n = DIV_ROUND_UP(div, (req->k + 1));
 }
 
-/**
+/*
  * sun6i_a31_get_pll6_factors() - calculates n, k factors for A31 PLL6x2
  * PLL6x2 rate is calculated as follows
  * rate = parent_rate * (n + 1) * (k + 1)
@@ -240,7 +240,7 @@ static void sun6i_a31_get_pll6_factors(struct factors_request *req)
 	req->n = DIV_ROUND_UP(div, (req->k + 1)) - 1;
 }
 
-/**
+/*
  * sun5i_a13_get_ahb_factors() - calculates m, p factors for AHB
  * AHB rate is calculated as follows
  * rate = parent_rate >> p
@@ -276,7 +276,7 @@ static void sun5i_a13_get_ahb_factors(struct factors_request *req)
 
 #define SUN6I_AHB1_PARENT_PLL6	3
 
-/**
+/*
  * sun6i_a31_get_ahb_factors() - calculates m, p factors for AHB
  * AHB rate is calculated as follows
  * rate = parent_rate >> p
@@ -320,7 +320,7 @@ static void sun6i_get_ahb1_factors(struct factors_request *req)
 	req->m = calcm - 1;
 }
 
-/**
+/*
  * sun6i_ahb1_recalc() - calculates AHB clock rate from m, p factors and
  *			 parent index
  */
@@ -336,7 +336,7 @@ static void sun6i_ahb1_recalc(struct factors_request *req)
 	req->rate >>= req->p;
 }
 
-/**
+/*
  * sun4i_get_apb1_factors() - calculates m, p factors for APB1
  * APB1 rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
@@ -375,7 +375,7 @@ static void sun4i_get_apb1_factors(struct factors_request *req)
 
 
 
-/**
+/*
  * sun7i_a20_get_out_factors() - calculates m, p factors for CLK_OUT_A/B
  * CLK_OUT rate is calculated as follows
  * rate = (parent_rate >> p) / (m + 1);
@@ -408,7 +408,7 @@ static void sun7i_a20_get_out_factors(struct factors_request *req)
 	req->p = calcp;
 }
 
-/**
+/*
  * sunxi_factors_clk_setup() - Setup function for factor clocks
  */
 
@@ -625,7 +625,7 @@ CLK_OF_DECLARE(sun7i_out, "allwinner,sun7i-a20-out-clk",
 	       sun7i_out_clk_setup);
 
 
-/**
+/*
  * sunxi_mux_clk_setup() - Setup function for muxes
  */
 
@@ -717,7 +717,7 @@ CLK_OF_DECLARE(sun8i_ahb2, "allwinner,sun8i-h3-ahb2-clk",
 	       sun8i_ahb2_clk_setup);
 
 
-/**
+/*
  * sunxi_divider_clk_setup() - Setup function for simple divider clocks
  */
 
@@ -853,7 +853,7 @@ CLK_OF_DECLARE(sun8i_axi, "allwinner,sun8i-a23-axi-clk",
 
 
 
-/**
+/*
  * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
  */
 
@@ -863,7 +863,7 @@ struct gates_data {
 	DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
 };
 
-/**
+/*
  * sunxi_divs_clk_setup() helper data
  */
 
@@ -929,7 +929,7 @@ static const struct divs_data sun6i_a31_pll6_divs_data __initconst = {
 	}
 };
 
-/**
+/*
  * sunxi_divs_clk_setup() - Setup function for leaf divisors on clocks
  *
  * These clocks look something like this
-- 
2.25.1

