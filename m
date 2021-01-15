Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC4D2F83C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388181AbhAOSPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388033AbhAOSPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:09 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E203BC061385
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:15 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id r4so8374085wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dkKAWRNMkHThiFz1M9uddp3Rd+YUVjBVQ8G0RRd1tPg=;
        b=o7PuaCI40GcwIe5PjjeOUWjBVVmNduFjVrX6LvSBREgDSRwEdcNazPXmpCSJJ3Abqp
         jHvxty8xwYtPpKoc8z0rMM48pZooE9DKPitlXD33YwkvNDAxgNfkzj2mDrBh2Z2o1FMo
         hPV/x2CCq7i4Jk5E7vLIuVQG8MfdtET82/eo1sYvUXNGPgNynkqb2VEZdnTcVRjFaECE
         VA6D/pnRGbVutsRAQDoVguz3v4iUPTtJFq7Jtx6ClYl3xKwV9kmQRHguoB/YAAtgkVYq
         xmNd+4nEIrsGksJR0dszRBUb7U8iqVNiILWrdJB1Pr3DcAo+GE8dKXLPiM3qthrpjTzS
         QUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkKAWRNMkHThiFz1M9uddp3Rd+YUVjBVQ8G0RRd1tPg=;
        b=cQo0B96yO4lSIljnKhG7mjCKQyPeLFlKQ2EalJgyWgqK6Gvk1Uv9m/iV1T0PqcMjU1
         ojyiJ/hSEskGGAKs9e80L/DVpgDl+t49qiyyXB/vNHwKuA/OXJBneEtoxfUXm83DM0HQ
         PkZBNoYrY23QAmwH/SM59LJYetabRkcy+Oei8vo+ClsOnMuRkmws4F6qXx+Yn2DrLHhE
         +e5q4Lqvnww8sGi7JU0XG9WQqm4LOCXU+Dw2r02RoxZgwzXoC4KTH/XzGlRzrn1aHuhS
         a1P/5rAH7EmOewTy0fdqqZtCUI9F7v9QPT6RLeyRAbctFhrad1RcNf/ry7Q7siz8xUyL
         IkEQ==
X-Gm-Message-State: AOAM531k1Y5xc/JfY6VdOc6rlC7y78PNe9XwDKPOK6Qi9lH8rsmqKxIB
        9gnr0+FQ9x4y9AeOsCFoPmBn1A==
X-Google-Smtp-Source: ABdhPJyKfyhmRu1cvc+Cry6amUJ6hGG93mmiVURVcRG8yFp5kRHmojpm3WIR7qhof1KcethsJwFtcQ==
X-Received: by 2002:a7b:c2e8:: with SMTP id e8mr9709934wmk.103.1610734454715;
        Fri, 15 Jan 2021 10:14:14 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:14:14 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 40/40] drm/vmwgfx/vmwgfx_stdu: Add some missing param/member descriptions
Date:   Fri, 15 Jan 2021 18:13:13 +0000
Message-Id: <20210115181313.3431493-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:77: warning: Function parameter or member 'pitch' not described in 'vmw_stdu_dirty'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:125: warning: Function parameter or member 'content_fb_type' not described in 'vmw_screen_target_display_unit'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:125: warning: Function parameter or member 'display_width' not described in 'vmw_screen_target_display_unit'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:125: warning: Function parameter or member 'display_height' not described in 'vmw_screen_target_display_unit'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:125: warning: Function parameter or member 'cpp' not described in 'vmw_screen_target_display_unit'
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c:682: warning: Function parameter or member 'user_fence_rep' not described in 'vmw_kms_stdu_dma'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
index fbe9778813648..01567534f4fae 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c
@@ -61,6 +61,7 @@ enum stdu_content_type {
  * @bottom: Bottom side of bounding box.
  * @fb_left: Left side of the framebuffer/content bounding box
  * @fb_top: Top of the framebuffer/content bounding box
+ * @pitch: framebuffer pitch (stride)
  * @buf: buffer object when DMA-ing between buffer and screen targets.
  * @sid: Surface ID when copying between surface and screen targets.
  */
@@ -109,8 +110,11 @@ struct vmw_stdu_update_gb_image {
  *               content_vfbs dimensions, then this is a pointer into the
  *               corresponding field in content_vfbs.  If not, then this
  *               is a separate buffer to which content_vfbs will blit to.
- * @content_type:  content_fb type
- * @defined:  true if the current display unit has been initialized
+ * @content_fb_type: content_fb type
+ * @display_width:  display width
+ * @display_height: display height
+ * @defined:     true if the current display unit has been initialized
+ * @cpp:         Bytes per pixel
  */
 struct vmw_screen_target_display_unit {
 	struct vmw_display_unit base;
@@ -652,6 +656,7 @@ static void vmw_stdu_bo_cpu_commit(struct vmw_kms_dirty *dirty)
  * @file_priv: Pointer to a struct drm-file identifying the caller. May be
  * set to NULL, but then @user_fence_rep must also be set to NULL.
  * @vfb: Pointer to the buffer-object backed framebuffer.
+ * @user_fence_rep: User-space provided structure for fence information.
  * @clips: Array of clip rects. Either @clips or @vclips must be NULL.
  * @vclips: Alternate array of clip rects. Either @clips or @vclips must
  * be NULL.
-- 
2.25.1

