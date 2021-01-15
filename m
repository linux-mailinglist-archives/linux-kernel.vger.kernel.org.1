Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A11F2F83DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388507AbhAOSRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387939AbhAOSRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:11 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06730C061799
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:13 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k10so8219445wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7KYIRZUMjvLyRUbCXd5tQbvxw5rYCxBLXlaIwYega2M=;
        b=cTyl8yMKBSAZ/N4WjkxQV07ASPFJSu6cXq/VF6UavPGKyKj9xHoyv1C9SnOJI2EP+D
         QXX4nloc+pgoc/fRoNjV5hsa5nE7Hv1mp8iFj/rzBJ1Z0Hw2PBVhJNm+ct2ECGxivHiX
         zRHyN+UUp8nxQqkLrLkzaHWGW+jc5yZXthAM2JAh1LBD1yaKQeGBDcw3Ro9YupeEhqAx
         d7gbPjmPIfjs2KG+Mu/Q0wa5Z+LuODjn0Qpq6f173gwZAqeQXgFsFaxPgX9hLZi69fO3
         iBPC7PvSJ3Bf37KxOS9ZcM7don7A7lyZ70Xx0tjmUI2xI7H9mMFrNUMx/H5GiFai0E1r
         ARsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7KYIRZUMjvLyRUbCXd5tQbvxw5rYCxBLXlaIwYega2M=;
        b=hVGbFrYMR0WhpFm/RY9PEEDv7h3RJ7QeyWsdoCDyQjd3yzu2wcqHNmOx/ynfaF1TVP
         Y46m5Z6oz2go+ovBhUy487TlB2Ci41uJCM2H62tZIULRHUel/b+oTie6PxZOP5anh1H6
         G5cRzpnMD1XwNdhhd/Na9eTVuMujGFCNpVUHFviEmFF7KpCjpp6ZCeMaWOCAt6uxcL2v
         rs9L2vL6kF2+Nm/YF88QpHd1XgyrO3ixBM09RWCiWY3t3hh91QgyOLYgH1pzEN470Bc5
         WvT1UgTVIpCe+nwMqqWZEot1DRRapwjBsBy4PDrmOpLHQ3Vvvwao7R6/xceSwHzBEqIm
         V77A==
X-Gm-Message-State: AOAM530iIej8asoDLckH88ymGNN9b919fxRwbThmvHlZrtxJNgHNUY11
        Fk5S9sp78HDbdxy3FBe58iaHNg==
X-Google-Smtp-Source: ABdhPJzib4ExSirn3o55kUR1rs78it0ufIN6Hyy67qU+KiaF5tSw6dgVq0LjBf4ReP+FWzqYltO5zQ==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr9963732wmc.14.1610734571743;
        Fri, 15 Jan 2021 10:16:11 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:11 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/29] drm/vmwgfx/vmwgfx_binding: Provide some missing param descriptions and remove others
Date:   Fri, 15 Jan 2021 18:15:36 +0000
Message-Id: <20210115181601.3432599-5-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:340: warning: Function parameter or member 'shader_slot' not described in 'vmw_binding_add'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:340: warning: Function parameter or member 'slot' not described in 'vmw_binding_add'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:376: warning: Function parameter or member 'from' not described in 'vmw_binding_transfer'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:498: warning: Function parameter or member 'to' not described in 'vmw_binding_state_commit'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:498: warning: Excess function parameter 'ctx' description in 'vmw_binding_state_commit'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:498: warning: Excess function parameter 'scrubbed' description in 'vmw_binding_state_commit'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:520: warning: Function parameter or member 'cbs' not described in 'vmw_binding_rebind_all'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:520: warning: Excess function parameter 'ctx' description in 'vmw_binding_rebind_all'
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c:795: warning: Function parameter or member 'shader_slot' not described in 'vmw_emit_set_sr'

Cc: VMware Graphics <linux-graphics-maintainer@vmware.com>
Cc: Roland Scheidegger <sroland@vmware.com>
Cc: Zack Rusin <zackr@vmware.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_binding.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c b/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
index 180f6dbc9460d..81f525a82b77f 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_binding.c
@@ -330,6 +330,8 @@ static void vmw_binding_drop(struct vmw_ctx_bindinfo *bi)
  *
  * @cbs: Pointer to the context binding state tracker.
  * @bi: Information about the binding to track.
+ * @shader_slot: The shader slot of the binding.
+ * @slot: The slot of the binding.
  *
  * Starts tracking the binding in the context binding
  * state structure @cbs.
@@ -367,6 +369,7 @@ void vmw_binding_add_uav_index(struct vmw_ctx_binding_state *cbs, uint32 slot,
  * vmw_binding_transfer: Transfer a context binding tracking entry.
  *
  * @cbs: Pointer to the persistent context binding state tracker.
+ * @from: Staged binding info built during execbuf
  * @bi: Information about the binding to track.
  *
  */
@@ -484,9 +487,8 @@ void vmw_binding_res_list_scrub(struct list_head *head)
 /**
  * vmw_binding_state_commit - Commit staged binding info
  *
- * @ctx: Pointer to context to commit the staged binding info to.
+ * @to:   Staged binding info area to copy into to.
  * @from: Staged binding info built during execbuf.
- * @scrubbed: Transfer only scrubbed bindings.
  *
  * Transfers binding info from a temporary structure
  * (typically used by execbuf) to the persistent
@@ -511,7 +513,7 @@ void vmw_binding_state_commit(struct vmw_ctx_binding_state *to,
 /**
  * vmw_binding_rebind_all - Rebind all scrubbed bindings of a context
  *
- * @ctx: The context resource
+ * @cbs: Pointer to the context binding state tracker.
  *
  * Walks through the context binding list and rebinds all scrubbed
  * resources.
@@ -789,6 +791,7 @@ static void vmw_collect_dirty_view_ids(struct vmw_ctx_binding_state *cbs,
  * vmw_binding_emit_set_sr - Issue delayed DX shader resource binding commands
  *
  * @cbs: Pointer to the context's struct vmw_ctx_binding_state
+ * @shader_slot: The shader slot of the binding.
  */
 static int vmw_emit_set_sr(struct vmw_ctx_binding_state *cbs,
 			   int shader_slot)
-- 
2.25.1

