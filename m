Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E346C2F4DE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbhAMOxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbhAMOwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:17 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24E3C061359
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g10so1856105wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiTAiO1+djM4LYXjGKueW16bvgv2sBtNiLbtIOEARdk=;
        b=IDza5YLilamkwPDT+g2/a0lofmuncKNpAv/y/6ZQX7PTgZHHrzIscPArIaLwzgGk21
         +PTQkWm+NELC+KC9BFDcWCwiEBGUoc7D99iVhf/b8Zau/fF4+imDj62ocQwZfhj48s7p
         G301bdVxqdgcGdeZ0mOu5lmhiQU2WC/WPRGqNZpFfUOiJAjYflnQOI3iCRme45LwRAT5
         UA87z3v5OeC740plgM+jScryysn9swGK41grynXPhZPBHzL1uyI195awHeRx0r0D+KV6
         M3YDyk1IDQxUtVgKliH+QZdMV6naG94aZh3W2EpFGPxDHMNQ6+AhIUIbY31cyP7lq5uP
         Fxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiTAiO1+djM4LYXjGKueW16bvgv2sBtNiLbtIOEARdk=;
        b=M7Mkln7q1kLNYiSp82AzclhhhAuB2ZdaZ/lQ/QcMYUlo2znsrAVCv8H0AApqrWS04n
         JrD/ufAwLnp94oh+XxrH1sC2/0wrLu76bjXVsUUHSHKxbIfxBZ7fJmSwDf4nj0w08o6i
         xK5lvNJjabmIZijgUNONm33YPDCLygTwR9FVETFPXC+jCVS0piqXDSPDQ2Krc9b20aCl
         8nFtW4KmfbEGi0Bvy7faiOA/shfRnKSLjYBtaGNOeTQ7d+l1knAB+SrtqRL88l1kOFdn
         lZS83/pVO/LZJMAt3MsTSBmth5ySjm+4FLw4gdy8/vPpUUIErEktSj9hfAkRakRQjz6Q
         JrmA==
X-Gm-Message-State: AOAM531vDM05DaqsTwPDIPEpaFonoS9dSslbvSv4QuAs/vreqU/q71HX
        OIH+p6ykfjZFiss9JgsNvbvydA==
X-Google-Smtp-Source: ABdhPJzn0hsHSArPV+PdoU3MwAI+uaM7MfxzC+Q9pFqpa5/9nfQ0iIqmvEqP+hOl9RxA7AZoMzJjNw==
X-Received: by 2002:a1c:988f:: with SMTP id a137mr2554157wme.130.1610549450459;
        Wed, 13 Jan 2021 06:50:50 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        Jeff Garzik <jgarzik@pobox.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 26/31] video: fbdev: riva: riva_hw: Remove set but unused variables 'vus_p' and 'vus_n'
Date:   Wed, 13 Jan 2021 14:50:04 +0000
Message-Id: <20210113145009.1272040-27-lee.jones@linaro.org>
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

 drivers/video/fbdev/riva/riva_hw.c: In function ‘nv10CalcArbitration’:
 drivers/video/fbdev/riva/riva_hw.c:845:23: warning: variable ‘vus_p’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:845:16: warning: variable ‘vus_n’ set but not used [-Wunused-but-set-variable]

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/riva/riva_hw.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index 4ee63f7d84d3e..2bc510c24aa9e 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -842,7 +842,7 @@ static void nv10CalcArbitration
     int found, mclk_extra, mclk_loop, cbs, m1;
     int mclk_freq, pclk_freq, nvclk_freq, mp_enable;
     int us_m, us_m_min, us_n, us_p, crtc_drain_rate;
-    int vus_m, vus_n, vus_p;
+    int vus_m;
     int vpm_us, us_video, cpm_us, us_crt,clwm;
     int clwm_rnd_down;
     int m2us, us_pipe_min, p1clk, p2;
@@ -924,8 +924,6 @@ static void nv10CalcArbitration
       us_pipe_min = us_m_min + us_n + us_p;
 
       vus_m = mclk_loop *1000*1000 / mclk_freq; /* Mclk latency in us */
-      vus_n = (4)*1000*1000 / nvclk_freq;/* nvclk latency in us */
-      vus_p = 0*1000*1000 / pclk_freq;/* pclk latency in us */
 
       if(video_enable) {
         crtc_drain_rate = pclk_freq * bpp/8; /* MB/s */
-- 
2.25.1

