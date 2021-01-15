Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36FC2F8394
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbhAOSOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387713AbhAOSOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:48 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E93C0617A3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:39 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 190so8223857wmz.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xM/nZ90UZtBcAp5QNv/pK0XIOjFNxIv5JhwEyUdhjVM=;
        b=jjY6jrbjNmOrQiQDYOGRkAAIiAp/6KDE3vmYhx4DqYAVJjpaPO83rezynTkZus38Qc
         t4wRn0YT/RSRwfnRTuWoEOpz/oXXr745uuuvPdCu+12MhIBHFSt2gJEvgsBLyW/9NYTv
         ly0ALvUs7CphR/MaClnLwLV8D5t+U1d613DS5Ggu7iVr21IFw0AJkn2+X1AVVVnIYVy7
         g5brib7pVjxVa/FshrKlb7Rwar9BQtK7rSn4J+HPC4TEdSofTkNVdXk5EfoJXoj/pd6L
         QoZ0ZMeczQrR7iFB5Q3YWBBBQnw5ClVzOK+CTQ2dAlRZP7Yi5bldSl6piHZfCrjplOtm
         eoDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xM/nZ90UZtBcAp5QNv/pK0XIOjFNxIv5JhwEyUdhjVM=;
        b=Gg/VJ98CfOKNrm5zn7Kv9LohJ5I9aEFkpuzOi62wkQ2YYecAJovlkPSaBkRaCjdbXt
         lpFuJKAIgEwC9cgyI2jQu7Ro4hf0AMEWTGFaYtO1Eivui/OjTNfOj6ZWDEQEn3xyuKzg
         kKtoYy1pl7qAH4EpspWdOFe3QFWGwnJ6LLF4hoGzY2D6Hd4THyuo/cHktwBA036Sf4FS
         lNH3IpdeG+5KIm0/sZY9HjiZ67AtSkVuOgG0FPjw54OhBWJHABu6pz81ge7p49lv3BpD
         4IwfS5nVWVO7Rzyg5Ukv8a+kBEQQ7JOWPASf/Gui5vaQJgNymauqaWcysVFWIuA91vhW
         GtaQ==
X-Gm-Message-State: AOAM530K1wAUMo5fxb4Yhvr3DuU/X/1WsDQojxFwIgensgSkYIbUqrMy
        9yAK3Bac+IdqiSr2AJcuOX+Oag==
X-Google-Smtp-Source: ABdhPJyz6t3vpry+yHHvZkuxg824UAQtjwFbNBG9Psqyj5I2KEjDtM4i6aE0P4Q7B9LdiEt4kTRXPg==
X-Received: by 2002:a1c:356:: with SMTP id 83mr10209410wmd.31.1610734417929;
        Fri, 15 Jan 2021 10:13:37 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 14/40] drm/gma500/framebuffer: Fix some possible doc-rot issues
Date:   Fri, 15 Jan 2021 18:12:47 +0000
Message-Id: <20210115181313.3431493-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/framebuffer.c:171: warning: Function parameter or member 'obj' not described in 'psb_framebuffer_init'
 drivers/gpu/drm/gma500/framebuffer.c:171: warning: Excess function parameter 'gt' description in 'psb_framebuffer_init'
 drivers/gpu/drm/gma500/framebuffer.c:212: warning: Function parameter or member 'obj' not described in 'psb_framebuffer_create'
 drivers/gpu/drm/gma500/framebuffer.c:212: warning: Excess function parameter 'gt' description in 'psb_framebuffer_create'
 drivers/gpu/drm/gma500/framebuffer.c:262: warning: Function parameter or member 'fb_helper' not described in 'psbfb_create'
 drivers/gpu/drm/gma500/framebuffer.c:262: warning: Excess function parameter 'fbdev' description in 'psbfb_create'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/framebuffer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/framebuffer.c b/drivers/gpu/drm/gma500/framebuffer.c
index 22c80e87aeb41..ebe9dccf2d830 100644
--- a/drivers/gpu/drm/gma500/framebuffer.c
+++ b/drivers/gpu/drm/gma500/framebuffer.c
@@ -159,7 +159,7 @@ static const struct fb_ops psbfb_unaccel_ops = {
  *	@dev: our DRM device
  *	@fb: framebuffer to set up
  *	@mode_cmd: mode description
- *	@gt: backing object
+ *	@obj: backing object
  *
  *	Configure and fill in the boilerplate for our frame buffer. Return
  *	0 on success or an error code if we fail.
@@ -197,7 +197,7 @@ static int psb_framebuffer_init(struct drm_device *dev,
  *	psb_framebuffer_create	-	create a framebuffer backed by gt
  *	@dev: our DRM device
  *	@mode_cmd: the description of the requested mode
- *	@gt: the backing object
+ *	@obj: the backing object
  *
  *	Create a framebuffer object backed by the gt, and fill in the
  *	boilerplate required
@@ -252,7 +252,7 @@ static struct gtt_range *psbfb_alloc(struct drm_device *dev, int aligned_size)
 
 /**
  *	psbfb_create		-	create a framebuffer
- *	@fbdev: the framebuffer device
+ *	@fb_helper: the framebuffer helper
  *	@sizes: specification of the layout
  *
  *	Create a framebuffer to the specifications provided
-- 
2.25.1

