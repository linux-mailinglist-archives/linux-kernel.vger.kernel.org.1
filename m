Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D032F4DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbhAMOxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbhAMOv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0008AC0617BE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:30 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 3so1853125wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=akZkn4hii3ygwpUSWjXzvWKSUmmw5HI5L5N5wIekgQ0=;
        b=EJcbDkfKRG16dlT8xRjZ2F6tm3CWsp8WqmfprIForTO/9Y2JsYYNwS4yJL/okHccdL
         rfFTr0ZxW+4KF1FLysPYPNS/5SpSbjq6qLF+qf8QQszV05GlO7M8iQ6PEmExS8y0nIg/
         sXKq7t7hD+h4zaMRifhvTSDH5Hdr8NcJnaksMh1Ba9J0+3WsIZOR3AdDg0zNFFyAxMq3
         3m3VnwwWhpB/6kSBEAN7ThxVncEhpfkBGoxPJwk7xzxy9b6Nmo2FutbwW08hTxYU1W9B
         sx8byNENSxrpQ60i3f4xICBSBhsYi8qdXOOmXcJnE7uFyNJ8w242AIOWEoe7QKSKVv1G
         7X2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akZkn4hii3ygwpUSWjXzvWKSUmmw5HI5L5N5wIekgQ0=;
        b=COrAdHrKPvAwv2glPsb+waqJMBt2X2g+5IG79Q5w8lVRa2A8wQ7IG24k17Tb33FMJP
         iCQBYMHUR5RYBfYZN0cw+H1hWlyPBeklfErUbEuTK/fZUAShnMWTWLIjzkR11g6rAUdR
         W7OsykbxID4FavkziQz8SrUctcL444IlJvqKylUa/S73LxeJoyIqqKshwacCRXE2uyGs
         z4dbhtm3ItEz/KSX2tC7rx+oiM9WdXgTg2HvbEPwRtDC7Hvf86PFdjzVOLqDsZNfsdRf
         vyC//fZfwNM0xmYTxQhaTvgrXurZUMZUoL6ptzOHwOjyRz+Ok9d8rM8URglOAcLt5Oh6
         HB+g==
X-Gm-Message-State: AOAM532HLEQUR4AcenlzTca7d1N11Xm2WoHhWWgL8hbFt7sni08HrBW7
        TuKufqrRbgWoILJX/cYOF8D8YYcrfcrVB8xp
X-Google-Smtp-Source: ABdhPJyCN8YgIewQREamnbFpDz4/uZeDkGL1R/LbeVSpIuV7ANhwmGVP6W2Xw1BS3pyVh28c7PuZPw==
X-Received: by 2002:a7b:c246:: with SMTP id b6mr2582589wmj.154.1610549429735;
        Wed, 13 Jan 2021 06:50:29 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        Jeff Garzik <jgarzik@pobox.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 10/31] video: fbdev: riva: riva_hw: Remove a bunch of unused variables
Date:   Wed, 13 Jan 2021 14:49:48 +0000
Message-Id: <20210113145009.1272040-11-lee.jones@linaro.org>
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
 drivers/video/fbdev/riva/riva_hw.c:849:9: warning: variable ‘pclks_2_top_fifo’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:848:43: warning: variable ‘vus_pipe’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:848:21: warning: variable ‘us_pipe’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:848:9: warning: variable ‘craw’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:846:27: warning: variable ‘vlwm’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:844:37: warning: variable ‘video_drain_rate’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:841:21: warning: variable ‘us_extra’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:840:55: warning: variable ‘vbs’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/riva/riva_hw.c:839:25: warning: variable ‘cas’ set but not used [-Wunused-but-set-variable]

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/riva/riva_hw.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/riva/riva_hw.c b/drivers/video/fbdev/riva/riva_hw.c
index bcf9c4b4de311..4ee63f7d84d3e 100644
--- a/drivers/video/fbdev/riva/riva_hw.c
+++ b/drivers/video/fbdev/riva/riva_hw.c
@@ -836,17 +836,17 @@ static void nv10CalcArbitration
     nv10_sim_state *arb
 )
 {
-    int data, pagemiss, cas,width, video_enable, bpp;
-    int nvclks, mclks, pclks, vpagemiss, crtpagemiss, vbs;
-    int nvclk_fill, us_extra;
+    int data, pagemiss, width, video_enable, bpp;
+    int nvclks, mclks, pclks, vpagemiss, crtpagemiss;
+    int nvclk_fill;
     int found, mclk_extra, mclk_loop, cbs, m1;
     int mclk_freq, pclk_freq, nvclk_freq, mp_enable;
-    int us_m, us_m_min, us_n, us_p, video_drain_rate, crtc_drain_rate;
+    int us_m, us_m_min, us_n, us_p, crtc_drain_rate;
     int vus_m, vus_n, vus_p;
-    int vpm_us, us_video, vlwm, cpm_us, us_crt,clwm;
+    int vpm_us, us_video, cpm_us, us_crt,clwm;
     int clwm_rnd_down;
-    int craw, m2us, us_pipe, us_pipe_min, vus_pipe, p1clk, p2;
-    int pclks_2_top_fifo, min_mclk_extra;
+    int m2us, us_pipe_min, p1clk, p2;
+    int min_mclk_extra;
     int us_min_mclk_extra;
 
     fifo->valid = 1;
@@ -854,16 +854,13 @@ static void nv10CalcArbitration
     mclk_freq = arb->mclk_khz;
     nvclk_freq = arb->nvclk_khz;
     pagemiss = arb->mem_page_miss;
-    cas = arb->mem_latency;
     width = arb->memory_width/64;
     video_enable = arb->enable_video;
     bpp = arb->pix_bpp;
     mp_enable = arb->enable_mp;
     clwm = 0;
-    vlwm = 1024;
 
     cbs = 512;
-    vbs = 512;
 
     pclks = 4; /* lwm detect. */
 
@@ -924,17 +921,13 @@ static void nv10CalcArbitration
       us_min_mclk_extra = min_mclk_extra *1000*1000 / mclk_freq;
       us_n = nvclks*1000*1000 / nvclk_freq;/* nvclk latency in us */
       us_p = pclks*1000*1000 / pclk_freq;/* nvclk latency in us */
-      us_pipe = us_m + us_n + us_p;
       us_pipe_min = us_m_min + us_n + us_p;
-      us_extra = 0;
 
       vus_m = mclk_loop *1000*1000 / mclk_freq; /* Mclk latency in us */
       vus_n = (4)*1000*1000 / nvclk_freq;/* nvclk latency in us */
       vus_p = 0*1000*1000 / pclk_freq;/* pclk latency in us */
-      vus_pipe = vus_m + vus_n + vus_p;
 
       if(video_enable) {
-        video_drain_rate = pclk_freq * 4; /* MB/s */
         crtc_drain_rate = pclk_freq * bpp/8; /* MB/s */
 
         vpagemiss = 1; /* self generating page miss */
@@ -993,7 +986,6 @@ static void nv10CalcArbitration
               else if(crtc_drain_rate * 100  >= nvclk_fill * 98) {
                   clwm = 1024;
                   cbs = 512;
-                  us_extra = (cbs * 1000 * 1000)/ (8*width)/mclk_freq ;
               }
           }
       }
@@ -1010,7 +1002,6 @@ static void nv10CalcArbitration
 
       m1 = clwm + cbs -  1024; /* Amount of overfill */
       m2us = us_pipe_min + us_min_mclk_extra;
-      pclks_2_top_fifo = (1024-clwm)/(8*width);
 
       /* pclk cycles to drain */
       p1clk = m2us * pclk_freq/(1000*1000); 
@@ -1038,14 +1029,13 @@ static void nv10CalcArbitration
               min_mclk_extra--;
         }
       }
-      craw = clwm;
 
       if(clwm < (1024-cbs+8)) clwm = 1024-cbs+8;
       data = (int)(clwm);
       /*  printf("CRT LWM: %f bytes, prog: 0x%x, bs: 256\n", clwm, data ); */
       fifo->graphics_lwm = data;   fifo->graphics_burst_size = cbs;
 
-      /*  printf("VID LWM: %f bytes, prog: 0x%x, bs: %d\n, ", vlwm, data, vbs ); */
+      /*  printf("VID LWM: 1024 bytes, prog: 0x%x, bs: 512\n, ", data); */
       fifo->video_lwm = 1024;  fifo->video_burst_size = 512;
     }
 }
-- 
2.25.1

