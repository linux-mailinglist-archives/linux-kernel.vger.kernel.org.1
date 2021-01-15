Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8162F83FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388258AbhAOSUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733304AbhAOSOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:14:41 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F56C06179E
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:31 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e15so1995632wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o+NaOzslIuLS5J9pNZb4fvgzik/FyZn/jqm9ZPQuWdU=;
        b=gcPt2Yf87b/ShsbMtAB8DSJHWxzobsp+uEVJTJI8p8rCo2GuGHF5+eKwGBC0VlyZ90
         KDq7HXSj5S5B5z9bM2lVkWFOT+UmimXzXqfmrecElufbv02xRhPOpxQg7CcLG8e+U+ah
         C9Kpj3hgXdSl0ykXUVVW9CjYz6qDFtjFEVaVW8Zgl+qJsPUsHaQV1vUkEgdMXHD1LMOS
         lkIXZiIMAMNE+cU+Ll0q/wWAvibFwPRmW6z7fGevaAskVyng7rIdQnkX1n86PRss8Bl5
         RSwJ215w8Wz6Q1NxFC80W47W5e146q5CCR/k4Wc5N+wJNIFR+LA1WsGr9Jn2ZBSLwh3R
         R+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o+NaOzslIuLS5J9pNZb4fvgzik/FyZn/jqm9ZPQuWdU=;
        b=YpdndgHDc4+pELSDd8lHOhTI6RvLt4QOi1vFz3PfLo0VJGB7hZ2x5G18kt6XeWPcu+
         iOds+3m9X5gFP+giQwuxdVxem8DSiaSbxdCRfmwc3V3trwvLZlhEI4NPmgp8yFbYQ8SR
         ZPObFSaS1Df3HKRBeJTiXS7mcToc2piL2O7HEtYbDc8BtaOBsKu5TtyV01XxJ5Vo7tCB
         Tv/VoeK10eFeXqa2Ffv3Baafqt2JeaiK/v3QJsLh5pVUV6FzZDYTNSq73x3xk9DjHQJL
         UxYt9Z+DMqHkB72kglHoWzvy9KnZnHYoweIjriZyB5RkMJgZkw5IGFy0BzNevaLNFfZA
         UKLQ==
X-Gm-Message-State: AOAM5302atmc0tCX0Q8AIz/cGnKEW6NuzSCtPcJjPcXXHA3Ywc3zyO9U
        Mn9/vk2PpvX4fjhd3lLMN03K4g==
X-Google-Smtp-Source: ABdhPJzGeywxTj78fCoWwOftGOvl39aKwyJAUaPf5IIxOSdz6of+4VeNXyJx53GaVOJfH7xZcWlJkw==
X-Received: by 2002:a1c:de09:: with SMTP id v9mr10274031wmg.0.1610734409886;
        Fri, 15 Jan 2021 10:13:29 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id j2sm16123484wrh.78.2021.01.15.10.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:13:29 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 10/40] drm/vmwgfx/vmwgfx_resource: Fix worthy function headers demote some others
Date:   Fri, 15 Jan 2021 18:12:43 +0000
Message-Id: <20210115181313.3431493-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181313.3431493-1-lee.jones@linaro.org>
References: <20210115181313.3431493-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:215: warning: Excess function parameter 'obj_type' description in 'vmw_resource_init'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:303: warning: Excess function parameter 'p_res' description in 'vmw_user_resource_noref_lookup_handle'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:328: warning: Function parameter or member 'dev_priv' not described in 'vmw_user_lookup_handle'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:328: warning: Function parameter or member 'tfile' not described in 'vmw_user_lookup_handle'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:328: warning: Function parameter or member 'handle' not described in 'vmw_user_lookup_handle'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:328: warning: Function parameter or member 'out_surf' not described in 'vmw_user_lookup_handle'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:328: warning: Function parameter or member 'out_buf' not described in 'vmw_user_lookup_handle'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:398: warning: Function parameter or member 'dirtying' not described in 'vmw_resource_do_validate'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:601: warning: Function parameter or member 'interruptible' not described in 'vmw_resource_reserve'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:601: warning: Function parameter or member 'no_backup' not described in 'vmw_resource_reserve'
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c:987: warning: Function parameter or member 'interruptible' not described in 'vmw_resource_pin'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
index d1e7b9608145b..c4df51a2a9262 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_resource.c
@@ -202,7 +202,6 @@ int vmw_resource_alloc_id(struct vmw_resource *res)
  *
  * @dev_priv:       Pointer to a device private struct.
  * @res:            The struct vmw_resource to initialize.
- * @obj_type:       Resource object type.
  * @delay_id:       Boolean whether to defer device id allocation until
  *                  the first validation.
  * @res_free:       Resource destructor.
@@ -288,8 +287,6 @@ int vmw_user_resource_lookup_handle(struct vmw_private *dev_priv,
  * @tfile:        Pointer to a struct ttm_object_file identifying the caller
  * @handle:       The TTM user-space handle
  * @converter:    Pointer to an object describing the resource type
- * @p_res:        On successful return the location pointed to will contain
- *                a pointer to a refcounted struct vmw_resource.
  *
  * If the handle can't be found or is associated with an incorrect resource
  * type, -EINVAL will be returned.
@@ -315,7 +312,7 @@ vmw_user_resource_noref_lookup_handle(struct vmw_private *dev_priv,
 	return converter->base_obj_to_res(base);
 }
 
-/**
+/*
  * Helper function that looks either a surface or bo.
  *
  * The pointer this pointed at by out_surf and out_buf needs to be null.
@@ -388,6 +385,7 @@ static int vmw_resource_buf_alloc(struct vmw_resource *res,
  * @res:            The resource to make visible to the device.
  * @val_buf:        Information about a buffer possibly
  *                  containing backup data if a bind operation is needed.
+ * @dirtying:       Transfer dirty regions.
  *
  * On hardware resource shortage, this function returns -EBUSY and
  * should be retried once resources have been freed up.
@@ -586,7 +584,7 @@ vmw_resource_check_buffer(struct ww_acquire_ctx *ticket,
 	return ret;
 }
 
-/**
+/*
  * vmw_resource_reserve - Reserve a resource for command submission
  *
  * @res:            The resource to reserve.
@@ -973,7 +971,7 @@ void vmw_resource_evict_all(struct vmw_private *dev_priv)
 	mutex_unlock(&dev_priv->cmdbuf_mutex);
 }
 
-/**
+/*
  * vmw_resource_pin - Add a pin reference on a resource
  *
  * @res: The resource to add a pin reference on
-- 
2.25.1

