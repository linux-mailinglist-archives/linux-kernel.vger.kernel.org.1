Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0816A2F8419
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbhAOSUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbhAOSOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:39 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C091C061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:28 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id h17so8028338wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZ4SXqHjDfEhTUNGWQvOBhYeab3UcCqVCuaDiiVfWAQ=;
        b=fSoRh3q4uz6YIds/3B+belP3eN9OBqn0u5m7KCnG8CbRMmEvaqB7U80UUa6QIW3gTh
         kjqT2NQYZK2IbR+DpvFCnwsVGmUveVCyBZYD6Dyr212ln1LTaB2qGLUx2J5d8EutCb/p
         fVS8KDR4Dg2VQ+mK6CRyyfsRi/s5yrSTcl4jKymczHxftpNGvUcODxvmxtTJk0ph3XO1
         LohbVA6FPotDa1Hq2Dqj9DUrzWgCaSynqxdoHmVrt8dEmxtfuidOplLkYDk2zJ87+D4E
         Hh7hHNDbC85FOcWHYZYJKcgJOcs0Pdhd1i85xa66akt6YUzqQ/0jFcH+/aDf8gBFU2Vi
         DOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZ4SXqHjDfEhTUNGWQvOBhYeab3UcCqVCuaDiiVfWAQ=;
        b=uNCLvSNi3PbYGUZ1+NZdSbJHJxF8sUOIg6T+D5fqo2Q01vmOlaY5zDwkGuuJ5IRp5g
         9whgDUTtNAfXMThwqKzxZ0oYhS+qVALWm76j8ZbLYYpPm3wyzeao9LjiNJuOr/J7JExN
         y7nR5HMPieavlB4wr4hVFqqvfbzebSgbHtXKF8zVnRcrg4P5PDgbWfggQu7UiJB86863
         TUm2nP8GRk99mHv17ch/JPRu+zfgrIVV7LGuDF54bx9sM9iF6wKCMoffX0thFgegBSHc
         rPlzfuLEAcxPHLC1+/1spoA/QZ1xXzXxBf2lK1zpGdtBMOio6Qikilef2Ih0BtwkQ95u
         1DoA==
X-Gm-Message-State: AOAM530+i+SodJFUum3DYLYwcxCYR2Lb2wtd/UnL+WwVicxGveiR2qOV
        wVcgUEl0E4K8rzVPtUvNlYZ0hg==
X-Google-Smtp-Source: ABdhPJyaMwGma3U8BAl3CJHR4ESpN+NLARQ+4qCjJY0g6+kivNVYS2BSZ8FkjhlA05W7/6smJjC3uQ==
X-Received: by 2002:a7b:ce92:: with SMTP id q18mr9611096wmj.113.1610734407001;
        Fri, 15 Jan 2021 10:13:27 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:26 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/40] drm/vmwgfx/vmwgfx_drv: Fix some kernel-doc misdemeanours
Date:   Fri, 15 Jan 2021 18:12:41 +0000
Message-Id: <20210115181313.3431493-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:164: warning: Function parameter or member 'ioctl' not described in 'VMW_IOCTL_DEF'
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:164: warning: Function parameter or member 'func' not described in 'VMW_IOCTL_DEF'
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:164: warning: Function parameter or member 'flags' not described in 'VMW_IOCTL_DEF'
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:170: warning: cannot understand function prototype: 'const struct drm_ioctl_desc vmw_ioctls[] = '
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:542: warning: Function parameter or member 'dev_priv' not described in 'vmw_get_initial_size'
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:611: warning: Function parameter or member 'dev_priv' not described in 'vmw_dma_masks'
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:611: warning: Excess function parameter 'dev' description in 'vmw_dma_masks'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
index 8c3eb00e8b54d..a77b70347aab0 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_drv.c
@@ -153,7 +153,7 @@
 	DRM_IOWR(DRM_COMMAND_BASE + DRM_VMW_MSG,			\
 		struct drm_vmw_msg_arg)
 
-/**
+/*
  * The core DRM version of this macro doesn't account for
  * DRM_COMMAND_BASE.
  */
@@ -161,7 +161,7 @@
 #define VMW_IOCTL_DEF(ioctl, func, flags) \
   [DRM_IOCTL_NR(DRM_IOCTL_##ioctl) - DRM_COMMAND_BASE] = {DRM_IOCTL_##ioctl, flags, func}
 
-/**
+/*
  * Ioctl definitions.
  */
 
@@ -526,7 +526,7 @@ static void vmw_release_device_late(struct vmw_private *dev_priv)
 	vmw_fifo_release(dev_priv, &dev_priv->fifo);
 }
 
-/**
+/*
  * Sets the initial_[width|height] fields on the given vmw_private.
  *
  * It does so by reading SVGA_REG_[WIDTH|HEIGHT] regs and then
@@ -599,7 +599,7 @@ static int vmw_dma_select_mode(struct vmw_private *dev_priv)
 /**
  * vmw_dma_masks - set required page- and dma masks
  *
- * @dev: Pointer to struct drm-device
+ * @dev_priv: Pointer to struct drm-device
  *
  * With 32-bit we can only handle 32 bit PFNs. Optionally set that
  * restriction also for 64-bit systems.
-- 
2.25.1

