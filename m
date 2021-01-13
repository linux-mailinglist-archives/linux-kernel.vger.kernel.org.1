Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71D42F4DB0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727102AbhAMOvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:51:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbhAMOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:17 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6D6C0617B9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:25 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g10so1854728wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41nyWegGgkKSptjKwd6Aeq/y24rv95GTAFlb1D5g4Jo=;
        b=pafm/yTul1VI6VgZ+awVR07fmX3mqTQQWpRtjlYSoHGu/InZpKlZn+TF3rRl17XSwP
         nVwCaHHy9o1NrbzI5Kqe7jaZlv2VbjcglCPPckq0exelBS2rP9Xphp3ItgG6M8CLTIda
         FwhjulzLUtcgvHitUQ8ektKlAMQXC7BiliexBGYJjJwdb+W/YgPFIvtHlO2IzbtQIst3
         2lSsdNd4+01TS9ZC+VwxrTVSuKXlQqv7Nl4gEzF2GdRsihWAM07i9laFCMuZ/apY4wep
         urDKWRfnc3vXE09BZNPfdVc8mjTIaiELGUowzaRoZqOiyF9oz78MBZlpqlJsYGj2kyLL
         xurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=41nyWegGgkKSptjKwd6Aeq/y24rv95GTAFlb1D5g4Jo=;
        b=rnxoSXkzOdd7daaxquGB5bCMkNvRUrDF7DuTQWIz2ErvaDafCJN5KCLB90+yYJeG4/
         RcVpDWvtlu/xavdgxjng4shE0LbDAmkH/IMi0AAzatazfsHc7I28ursxeah5Ryx7WEbp
         QlNC6IJ4Pf+drK3MEs+BAnnZ19cXoS5I0HEWGwVCkwUAiy6pV5duxYZ7yX1amAyBbDJJ
         UveWzw3qXgYJquR7RblwDrZ0/pC6tM+cMoqzW3MQtEGG/hfUtMWSvP87UwBvRbeoc200
         2brfKb9qm0bXmtUnWn6zBylHEnJikZWELQrSUvkmLuGow2i69QlD5ZZWG7rpUWpdes93
         JQbg==
X-Gm-Message-State: AOAM533uHFEcSra8sdOhcxOMkz7bRWeptdK31fSiP0si/GHoTa5jRA1x
        pMEoff4nr2iBPGOka3oHwSckpqg9AVKiHZ2n
X-Google-Smtp-Source: ABdhPJzywTsfi9Vnx2cWTPz0rA/vBrZ4+HLSZp3gHQQkVIeaDidlu8J3N598S3+EfWlm4YxHB5jcVA==
X-Received: by 2002:a1c:a145:: with SMTP id k66mr2551920wme.18.1610549423835;
        Wed, 13 Jan 2021 06:50:23 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@gmail.com>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 07/31] video: fbdev: riva: fbdev: Fix some kernel-doc misdemeanours
Date:   Wed, 13 Jan 2021 14:49:45 +0000
Message-Id: <20210113145009.1272040-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/riva/fbdev.c:485: warning: Function parameter or member 'data8' not described in 'rivafb_load_cursor_image'
 drivers/video/fbdev/riva/fbdev.c:485: warning: Excess function parameter 'data' description in 'rivafb_load_cursor_image'
 drivers/video/fbdev/riva/fbdev.c:863: warning: Function parameter or member 'var' not described in 'rivafb_do_maximize'
 drivers/video/fbdev/riva/fbdev.c:863: warning: Function parameter or member 'nom' not described in 'rivafb_do_maximize'
 drivers/video/fbdev/riva/fbdev.c:1229: warning: Excess function parameter 'con' description in 'rivafb_pan_display'

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Ani Joshi <ajoshi@shell.unixbox.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/riva/fbdev.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index ce55b9d2e862b..8adf9cf353410 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -464,12 +464,12 @@ static inline void reverse_order(u32 *l)
 
 /**
  * rivafb_load_cursor_image - load cursor image to hardware
- * @data: address to monochrome bitmap (1 = foreground color, 0 = background)
+ * @data8: address to monochrome bitmap (1 = foreground color, 0 = background)
  * @par:  pointer to private data
- * @w:    width of cursor image in pixels
- * @h:    height of cursor image in scanlines
  * @bg:   background color (ARGB1555) - alpha bit determines opacity
  * @fg:   foreground color (ARGB1555)
+ * @w:    width of cursor image in pixels
+ * @h:    height of cursor image in scanlines
  *
  * DESCRIPTiON:
  * Loads cursor image based on a monochrome source and mask bitmap.  The
@@ -840,19 +840,15 @@ static void riva_update_var(struct fb_var_screeninfo *var,
 	NVTRACE_LEAVE();
 }
 
-/**
- * rivafb_do_maximize - 
+/*
+ * rivafb_do_maximize
  * @info: pointer to fb_info object containing info for current riva board
- * @var:
- * @nom:
- * @den:
  *
  * DESCRIPTION:
  * .
  *
  * RETURNS:
  * -EINVAL on failure, 0 on success
- * 
  *
  * CALLED FROM:
  * rivafb_check_var()
@@ -1214,7 +1210,6 @@ static int rivafb_set_par(struct fb_info *info)
 /**
  * rivafb_pan_display
  * @var: standard kernel fb changeable data
- * @con: TODO
  * @info: pointer to fb_info object containing info for current riva board
  *
  * DESCRIPTION:
-- 
2.25.1

