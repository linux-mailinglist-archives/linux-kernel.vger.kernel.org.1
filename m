Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0672F4DD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbhAMOwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbhAMOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:12 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930DEC061387
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:37 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id y187so1856062wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dqYcKMvvBegfm3VenU/QB6olxRoFuHKFr2cjTUmqS/8=;
        b=S9AVj327o2YowF2UVDBy78wryMVcbl0h9+66FkKjsJ6i8WFxR9bdMBpvD09HQSKrBK
         vo1ZGwrQgRIbO8nXV14mGFMY7xN/8efJxg72LA+jGfLxFGqANW5Hq1Sp7x03fIgx6wh9
         GIQHviMB4xL7Ezvs1yhHlV4tpH+kRDmAfbGsmQRRzOL0kTysvdv5asLys1CLRMxMQw3j
         KSElJsxQsL2ag8A2zAltelJHGfRZI0Wa5LkJq72Dlg5v5NEk61ys0mgDyU45DAojoCL2
         n+AyXgib6ItiEzC+zdVYwT+v/wpNd5HLgmYqxPkzAM1ka3F9mHglqwUXvhnOweZ6cRBz
         nA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dqYcKMvvBegfm3VenU/QB6olxRoFuHKFr2cjTUmqS/8=;
        b=Ca5PBNlz0VBupQ0nRgX7tBxg4G/wwddsN+zONB3n7+8380jBIBVQ7gDP2vcRwZA5I0
         6TXwgd3QsaIOaKblitNmWCSMXG3N8MmpZTqy04/VwdGmyyvsfn7G+eGerS6db186LHJg
         snIBvh5lY1jqmrMi6ApdN0n82KfYEpSl97WGWQxpHxa8jZhqFVH44n6Kt7yB528/6MSl
         8JAd/7Ho/BPYw1fuwHJc/lsrm8Ml3DRRQefLsfVIpxyBMQ7aOoBSNqaA10UL3tVHAZRE
         praomtd09qiwpNn/wQj13sl0DYCg6MBTpLUT5sy7qvN4O7Mft/N20bWe4mUSDciTmpxb
         pdJQ==
X-Gm-Message-State: AOAM533RstDHLsuzg5WINARkl8dQKm3KJ8yTHZiDeCtbZCF0tWAIWlDe
        61T3v0sZoLG6Vx8AeZcuX5kI1A==
X-Google-Smtp-Source: ABdhPJy4RotZ5wPboUC1kdYhrUWx9GlS9eDgIJqXfbaNL8FlpjQa2No/+N3798NUVzIh33Csn1WwcA==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr2599659wmm.122.1610549436394;
        Wed, 13 Jan 2021 06:50:36 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, daniel.mantione@freepascal.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 14/31] video: fbdev: aty: mach64_ct: Remove some set but unused variables
Date:   Wed, 13 Jan 2021 14:49:52 +0000
Message-Id: <20210113145009.1272040-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/aty/mach64_ct.c: In function ‘aty_init_pll_ct’:
 drivers/video/fbdev/aty/mach64_ct.c:405:46: warning: variable ‘vga_dsp_on_off’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/aty/mach64_ct.c:405:30: warning: variable ‘vga_dsp_config’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/aty/mach64_ct.c:405:18: warning: variable ‘dsp_on_off’ set but not used [-Wunused-but-set-variable]

Cc: daniel.mantione@freepascal.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/aty/mach64_ct.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/aty/mach64_ct.c b/drivers/video/fbdev/aty/mach64_ct.c
index f87cc81f4fa2b..23eececa1e9d7 100644
--- a/drivers/video/fbdev/aty/mach64_ct.c
+++ b/drivers/video/fbdev/aty/mach64_ct.c
@@ -402,7 +402,7 @@ static int aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u8 mpost_div, xpost_div, sclk_post_div_real;
 	u32 q, memcntl, trp;
-	u32 dsp_config, dsp_on_off, vga_dsp_config, vga_dsp_on_off;
+	u32 dsp_config;
 #ifdef DEBUG
 	int pllmclk, pllsclk;
 #endif
@@ -488,25 +488,10 @@ static int aty_init_pll_ct(const struct fb_info *info, union aty_pll *pll)
 
 	/* Allow BIOS to override */
 	dsp_config = aty_ld_le32(DSP_CONFIG, par);
-	dsp_on_off = aty_ld_le32(DSP_ON_OFF, par);
-	vga_dsp_config = aty_ld_le32(VGA_DSP_CONFIG, par);
-	vga_dsp_on_off = aty_ld_le32(VGA_DSP_ON_OFF, par);
 
 	if (dsp_config)
 		pll->ct.dsp_loop_latency = (dsp_config & DSP_LOOP_LATENCY) >> 16;
-#if 0
-	FIXME: is it relevant for us?
-	if ((!dsp_on_off && !M64_HAS(RESET_3D)) ||
-		((dsp_on_off == vga_dsp_on_off) &&
-		(!dsp_config || !((dsp_config ^ vga_dsp_config) & DSP_XCLKS_PER_QW)))) {
-		vga_dsp_on_off &= VGA_DSP_OFF;
-		vga_dsp_config &= VGA_DSP_XCLKS_PER_QW;
-		if (ATIDivide(vga_dsp_on_off, vga_dsp_config, 5, 1) > 24)
-			pll->ct.fifo_size = 32;
-		else
-			pll->ct.fifo_size = 24;
-	}
-#endif
+
 	/* Exit if the user does not want us to tamper with the clock
 	rates of her chip. */
 	if (par->mclk_per == 0) {
-- 
2.25.1

