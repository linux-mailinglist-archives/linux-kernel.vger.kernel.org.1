Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175102F83CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbhAOSP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388118AbhAOSPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:15:19 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546F2C0617AA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:49 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 91so10212756wrj.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DX8peXw6vQkx3jgWc3AcDMwXWV0VAjfbUs3tjUz1hsU=;
        b=ueBZVZqMr1lRsNLHjtgml8MUHZ8WPI5E1fhSjTu3fXUJMjMMvwHI/uSOLq9dNiDaBZ
         l8D48/8MD8sGUTJ7ok+RfTlAepBXTN0/ReLbpyiQ1n5RfIrI7AU71FkZBZlsTKbFbl9C
         GX699dS+59SbIwW+me01VcUegxQz5X+mAv7xP7fiqrUmFKVcuWVZuN5rxP/oyPjX3Xmb
         N4jiZhb9Y3K5PK6yRxA1B+pKsXR7dGiJ+EJyQsUhFa7erqWQesY0p9ab6HkI1sTX/xCW
         pKLVT6RzBila8u6b82o61DhEIKLiKLrfc20PA2LnNCSJ/9d8omqrEejSGYsA5Uprv/26
         pQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DX8peXw6vQkx3jgWc3AcDMwXWV0VAjfbUs3tjUz1hsU=;
        b=l+6s7B1Edisx6citRyktQIAVBTdl+a3MkwN8lNqejNi4KeFQqvlTet06j/uC6TRbhy
         rmMYqh0fzqvJ8vjDVZrakEUt1nszKklKWe0LArOVuUk6H1oFr2Z1XgfNAxOyIpJ/7SoO
         yXm5XgGS5V0NEL0ILJAU2ONsgsEMU2508Ow4TTAFqaheZ3MnWsHmaF6GHmsGhO9T/Xhv
         pSaYD6IC7r481qeDSY/ZNh92DcM9Wc1Y2Df8p75nF3VPDb1Yh+znDh8V10s1UoEtHXyW
         RAixt5Ay/MVPCBR6sLGu57BjnvlAIo88S/pPLxWpOL7YE6pWSej88mMqyFdn5uiIpBxC
         fLyQ==
X-Gm-Message-State: AOAM532dLXZynWkvRZDyjB9++3JAARj8kD2yTyAUCSDyOEcpLNB3+omg
        b8I26Jj8TtaiQ0aeOPA0CfgFwOc2oB2P1IEo
X-Google-Smtp-Source: ABdhPJwpTvCHhrRMhMhC083vAOcxnBNtkEy10vvuPrBOfIVJBD37uYFht6hVp6TUpt/pPyifOrjx+w==
X-Received: by 2002:a5d:6607:: with SMTP id n7mr14020998wru.206.1610734428099;
        Fri, 15 Jan 2021 10:13:48 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/40] drm/vmwgfx/vmwgfx_kms: Update worthy function headers and demote others
Date:   Fri, 15 Jan 2021 18:12:53 +0000
Message-Id: <20210115181313.3431493-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:37:
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:483: warning: Function parameter or member 'new_state' not described in 'vmw_du_cursor_plane_atomic_check'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:483: warning: Excess function parameter 'state' description in 'vmw_du_cursor_plane_atomic_check'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1069: warning: Function parameter or member 'vfb' not described in 'vmw_framebuffer_pin'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1281: warning: Function parameter or member 'dev_priv' not described in 'vmw_kms_srf_ok'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1907: warning: Function parameter or member 'crtc' not described in 'vmw_get_vblank_counter'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1915: warning: Function parameter or member 'crtc' not described in 'vmw_enable_vblank'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:1923: warning: Function parameter or member 'crtc' not described in 'vmw_disable_vblank'
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c:2131: warning: Function parameter or member 'mode' not described in 'vmw_guess_mode_timing'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
index 9293dc19a7683..84143b707cd32 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_kms.c
@@ -467,7 +467,7 @@ int vmw_du_primary_plane_atomic_check(struct drm_plane *plane,
  * vmw_du_cursor_plane_atomic_check - check if the new state is okay
  *
  * @plane: cursor plane
- * @state: info on the new plane state
+ * @new_state: info on the new plane state
  *
  * This is a chance to fail if the new cursor state does not fit
  * our requirements.
@@ -1057,7 +1057,7 @@ static const struct drm_framebuffer_funcs vmw_framebuffer_bo_funcs = {
 	.dirty = vmw_framebuffer_bo_dirty_ext,
 };
 
-/**
+/*
  * Pin the bofer in a location suitable for access by the
  * display system.
  */
@@ -1267,6 +1267,7 @@ static int vmw_kms_new_framebuffer_bo(struct vmw_private *dev_priv,
 /**
  * vmw_kms_srf_ok - check if a surface can be created
  *
+ * @dev_priv: Pointer to device private struct.
  * @width: requested width
  * @height: requested height
  *
@@ -1896,7 +1897,7 @@ bool vmw_kms_validate_mode_vram(struct vmw_private *dev_priv,
 }
 
 
-/**
+/*
  * Function called by DRM code called with vbl_lock held.
  */
 u32 vmw_get_vblank_counter(struct drm_crtc *crtc)
@@ -1904,7 +1905,7 @@ u32 vmw_get_vblank_counter(struct drm_crtc *crtc)
 	return 0;
 }
 
-/**
+/*
  * Function called by DRM code called with vbl_lock held.
  */
 int vmw_enable_vblank(struct drm_crtc *crtc)
@@ -1912,7 +1913,7 @@ int vmw_enable_vblank(struct drm_crtc *crtc)
 	return -EINVAL;
 }
 
-/**
+/*
  * Function called by DRM code called with vbl_lock held.
  */
 void vmw_disable_vblank(struct drm_crtc *crtc)
@@ -2120,7 +2121,7 @@ static struct drm_display_mode vmw_kms_connector_builtin[] = {
  * vmw_guess_mode_timing - Provide fake timings for a
  * 60Hz vrefresh mode.
  *
- * @mode - Pointer to a struct drm_display_mode with hdisplay and vdisplay
+ * @mode: Pointer to a struct drm_display_mode with hdisplay and vdisplay
  * members filled in.
  */
 void vmw_guess_mode_timing(struct drm_display_mode *mode)
-- 
2.25.1

