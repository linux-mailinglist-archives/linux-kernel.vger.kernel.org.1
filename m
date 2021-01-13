Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037A72F4DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 15:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbhAMOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 09:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbhAMOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:24 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBADC061360
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i9so2420123wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruS/5Q88or74bT1MGQpJfhS5CAkw8vidMq7dDib2fZs=;
        b=dw+awuMm/xszxko06x1zbZDXJLrY8h9w46Ii0r1I8t7M23qIokSEWF+lctfR7ifEG+
         10hTw/DwZRUnEFPhAVSO68dOG3xRMSECzOqgPEZGcaXkIwEZpNzwO47CVeLh022fRJlH
         jDBbte4+oRAEKQsXCuHQ59dmP92NSYRrJJV3l5taYJRqGkZfD+TVnytK3qk0j65GJPKu
         2f+mh5IUw8l2pURTp/2Vx0/xKSO+Pb15iZss30ox0FSMT0+dZ7zRgUjqCFkx8UoasarG
         0QTSmkjRG6zgnWk6plq18kDAdy0dxgi5AzQNxp96r0OLZ3jhu/aqmtWdmf/vSBNmKOFD
         AtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruS/5Q88or74bT1MGQpJfhS5CAkw8vidMq7dDib2fZs=;
        b=YQQ4qFOdA5o4yCpoxRHV6FVgqveHi52gZII5jXvivRhBgqiKcSVsAzJdy/1NWrKz7N
         3ud0Ii9w03l2X4DT490CgSdlzhRNYVv+VSDDO8ZnfN7GVkNmyoNyRQRtkeAsyvoYMUgd
         20b4Gvn9R3PaZ9wyO9QFM6u3iU586jGQxHyztyb6PV3DSmeD3z/ZGXZRQMyvWHZTNf/a
         AiZoyFoT9nozOVFIPIPlbYuzTQmfEwOFSB9esA1nMwIZQS02TMWOumkBICVtybw5CfJo
         EqLGvDfkLYOulwqlh3rvzjRtk08EJNfdJAJSr2xfNLoJf6LvN438FBpULp6svaje0UjX
         s1NA==
X-Gm-Message-State: AOAM531m1o3Ij/ZDkrYZm+GYtJQhcDxHn+C8yirZfxSmAmPsOi+Fxjcc
        wJ23SLBUuJ051HZYBOXgSy15hw==
X-Google-Smtp-Source: ABdhPJxI76cMcy6SPfmM5W3HPZ9oHq45qLxC2KpwnypdTX8IGDVuElLlSdIgg82G0B9F5jmQLXJfmQ==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr3034474wrv.54.1610549457244;
        Wed, 13 Jan 2021 06:50:57 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:56 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Software Engineering <lg@denx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 31/31] video: fbdev: mx3fb: Fix some kernel-doc issues
Date:   Wed, 13 Jan 2021 14:50:09 +0000
Message-Id: <20210113145009.1272040-32-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/mx3fb.c:738: warning: Function parameter or member 'fbi' not described in 'mx3fb_set_fix'
 drivers/video/fbdev/mx3fb.c:738: warning: Excess function parameter 'info' description in 'mx3fb_set_fix'
 drivers/video/fbdev/mx3fb.c:1109: warning: Function parameter or member 'blank' not described in 'mx3fb_blank'
 drivers/video/fbdev/mx3fb.c:1109: warning: Function parameter or member 'fbi' not described in 'mx3fb_blank'
 drivers/video/fbdev/mx3fb.c:1134: warning: Function parameter or member 'fbi' not described in 'mx3fb_pan_display'
 drivers/video/fbdev/mx3fb.c:1134: warning: Excess function parameter 'info' description in 'mx3fb_pan_display'
 drivers/video/fbdev/mx3fb.c:1393: warning: Function parameter or member 'dev' not described in 'mx3fb_init_fbinfo'
 drivers/video/fbdev/mx3fb.c:1393: warning: Function parameter or member 'ops' not described in 'mx3fb_init_fbinfo'

Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Software Engineering <lg@denx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/mx3fb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/mx3fb.c b/drivers/video/fbdev/mx3fb.c
index d1c8f7a969ac3..a0fad25136fe5 100644
--- a/drivers/video/fbdev/mx3fb.c
+++ b/drivers/video/fbdev/mx3fb.c
@@ -731,7 +731,7 @@ static int mx3fb_unmap_video_memory(struct fb_info *fbi);
 
 /**
  * mx3fb_set_fix() - set fixed framebuffer parameters from variable settings.
- * @info:	framebuffer information pointer
+ * @fbi:	framebuffer information pointer
  * @return:	0 on success or negative error code on failure.
  */
 static int mx3fb_set_fix(struct fb_info *fbi)
@@ -1104,6 +1104,8 @@ static void __blank(int blank, struct fb_info *fbi)
 
 /**
  * mx3fb_blank() - blank the display.
+ * @blank:	blank mode (unblank, normal, {v,h}sync_suspend, powerdown)
+ * @fbi:	framebuffer information pointer
  */
 static int mx3fb_blank(int blank, struct fb_info *fbi)
 {
@@ -1125,7 +1127,7 @@ static int mx3fb_blank(int blank, struct fb_info *fbi)
 /**
  * mx3fb_pan_display() - pan or wrap the display
  * @var:	variable screen buffer information.
- * @info:	framebuffer information pointer.
+ * @fbi:	framebuffer information pointer.
  *
  * We look only at xoffset, yoffset and the FB_VMODE_YWRAP flag
  */
@@ -1384,7 +1386,7 @@ static int mx3fb_unmap_video_memory(struct fb_info *fbi)
 	return 0;
 }
 
-/**
+/*
  * mx3fb_init_fbinfo() - initialize framebuffer information object.
  * @return:	initialized framebuffer structure.
  */
-- 
2.25.1

