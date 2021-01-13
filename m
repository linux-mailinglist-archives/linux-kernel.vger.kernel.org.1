Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8302F45ED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbhAMIJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbhAMIJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:33 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D5C061381
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id k10so688754wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VziGpla9CXHb4VzE3DuAR1EazcEsD8QPraycH5WIRSc=;
        b=lbwRgZbP9xaz0MoRQPGeYDTj8v589eA7dm1Uy37pKQvTgix70bV95WKhysILiuhLnr
         X/IoChmCmepg3Tbx6LBfkVnmlA/RIM3EDMVJg6T6ruPjY9yrvrXGCQoIcVZ79tfE/PWs
         4mkUE3DUsymzBsrpRsCDU8Ktu/0DRUcZB9cV6wI8WNYkv3jWMtC+G82lGGz0vfMkCTXA
         SEPQWMlKrKAjiJE99bhtRYwTyXkG5ysCP9oab4bXxelwOBTv1Lkp+MZwXAQXp0OXGudT
         SubAZ8iP8LxkxI3TwbnIGfiW2Ph5h0UUDSWVr/Qdms1Ey8M2CHepKkGIWyaUTelpM+H3
         GUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VziGpla9CXHb4VzE3DuAR1EazcEsD8QPraycH5WIRSc=;
        b=E4zHuao5KrsHCe1qn/tHUj4lEKZzmDcdRQFHUjqj81/mnR6eeKtg9fsncrH7D7faPL
         Y+vcpeEfn4pcFxcllOEowyoJjeXOvl3c2Hz61j2qX9NZAQouJNf4NXd3MU4Kld3EvKJp
         nUxVzXz/T6JjD2i8E161doW7gZxRkjWAknGKBeLl+24CUS1rQ34Q4vV+tu0ix83dq3BN
         uvB2zrVynj8p+FeRMSM7CCIcOwUn9jS/2fI2nfvOkmBVuWt4k4eTBCeDQBbzoKVePAWZ
         Q7GFJqSHP1zaK4fU//ThDK6JAPA8SyVcp/axvT79UUS9RZ5wJJEfm+yXQqW0BO75pvuG
         4YqA==
X-Gm-Message-State: AOAM5326ntgm+YGWAkJgQuIBupEHSf4Bq60dmFd003oTQDZOgI8b/ATU
        tLYNmdoI3o4xrN6DXbcqTpz59qvDTY8iMyJO
X-Google-Smtp-Source: ABdhPJzXttIjQDYYJgjEyRjkSlEuWzctzAsWLV+A732JhQle3eVPLxXqcOXVMCJ4UDL/+yUpwhorCg==
X-Received: by 2002:a1c:6402:: with SMTP id y2mr923252wmb.43.1610525300839;
        Wed, 13 Jan 2021 00:08:20 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/30] drm/amd/display/dc/core/dc: Fix a bunch of documentation misdemeanours
Date:   Wed, 13 Jan 2021 08:07:42 +0000
Message-Id: <20210113080752.1003793-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113080752.1003793-1-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:287: warning: Cannot understand  *****************************************************************************
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:366: warning: Function parameter or member 'crc_window' not described in 'dc_stream_configure_crc'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:430: warning: Function parameter or member 'r_cr' not described in 'dc_stream_get_crc'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:430: warning: Function parameter or member 'g_y' not described in 'dc_stream_get_crc'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:430: warning: Function parameter or member 'b_cb' not described in 'dc_stream_get_crc'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Function parameter or member 'dc' not described in 'dc_check_update_surfaces_for_stream'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Function parameter or member 'updates' not described in 'dc_check_update_surfaces_for_stream'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Function parameter or member 'surface_count' not described in 'dc_check_update_surfaces_for_stream'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Function parameter or member 'stream_update' not described in 'dc_check_update_surfaces_for_stream'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Function parameter or member 'stream_status' not described in 'dc_check_update_surfaces_for_stream'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2822: warning: Function parameter or member 'dc' not described in 'dc_interrupt_set'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2822: warning: Function parameter or member 'src' not described in 'dc_interrupt_set'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2822: warning: Function parameter or member 'enable' not described in 'dc_interrupt_set'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2962: warning: Function parameter or member 'link' not described in 'dc_link_add_remote_sink'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2962: warning: Function parameter or member 'edid' not described in 'dc_link_add_remote_sink'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2962: warning: Function parameter or member 'len' not described in 'dc_link_add_remote_sink'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2962: warning: Function parameter or member 'init_data' not described in 'dc_link_add_remote_sink'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3022: warning: Function parameter or member 'link' not described in 'dc_link_remove_remote_sink'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3022: warning: Function parameter or member 'sink' not described in 'dc_link_remove_remote_sink'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 33 ++++++++++++------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0a07e608485ff..3ee3978fae977 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -284,20 +284,16 @@ static void dc_perf_trace_destroy(struct dc_perf_trace **perf_trace)
 }
 
 /**
- *****************************************************************************
- *  Function: dc_stream_adjust_vmin_vmax
+ *  dc_stream_adjust_vmin_vmax:
  *
- *  @brief
- *     Looks up the pipe context of dc_stream_state and updates the
- *     vertical_total_min and vertical_total_max of the DRR, Dynamic Refresh
- *     Rate, which is a power-saving feature that targets reducing panel
- *     refresh rate while the screen is static
+ *  Looks up the pipe context of dc_stream_state and updates the
+ *  vertical_total_min and vertical_total_max of the DRR, Dynamic Refresh
+ *  Rate, which is a power-saving feature that targets reducing panel
+ *  refresh rate while the screen is static
  *
- *  @param [in] dc: dc reference
- *  @param [in] stream: Initial dc stream state
- *  @param [in] adjust: Updated parameters for vertical_total_min and
- *  vertical_total_max
- *****************************************************************************
+ *  @dc:     dc reference
+ *  @stream: Initial dc stream state
+ *  @adjust: Updated parameters for vertical_total_min and vertical_total_max
  */
 bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 		struct dc_stream_state *stream,
@@ -355,6 +351,7 @@ bool dc_stream_get_crtc_position(struct dc *dc,
  * @dc: DC Object
  * @stream: The stream to configure CRC on.
  * @enable: Enable CRC if true, disable otherwise.
+ * @crc_window: CRC window (x/y start/end) information
  * @continuous: Capture CRC on every frame if true. Otherwise, only capture
  *              once.
  *
@@ -420,7 +417,9 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc_stream_state *stream,
  * dc_stream_get_crc() - Get CRC values for the given stream.
  * @dc: DC object
  * @stream: The DC stream state of the stream to get CRCs from.
- * @r_cr, g_y, b_cb: CRC values for the three channels are stored here.
+ * @r_cr: CRC value for the first of the 3 channels stored here.
+ * @g_y:  CRC value for the second of the 3 channels stored here.
+ * @b_cb: CRC value for the third of the 3 channels stored here.
  *
  * dc_stream_configure_crc needs to be called beforehand to enable CRCs.
  * Return false if stream is not found, or if CRCs are not enabled.
@@ -2012,7 +2011,7 @@ static enum surface_update_type check_update_surfaces_for_stream(
 	return overall_type;
 }
 
-/**
+/*
  * dc_check_update_surfaces_for_stream() - Determine update type (fast, med, or full)
  *
  * See :c:type:`enum surface_update_type <surface_update_type>` for explanation of update types
@@ -2815,7 +2814,7 @@ enum dc_irq_source dc_interrupt_to_irq_source(
 	return dal_irq_service_to_irq_source(dc->res_pool->irqs, src_id, ext_id);
 }
 
-/**
+/*
  * dc_interrupt_set() - Enable/disable an AMD hw interrupt source
  */
 bool dc_interrupt_set(struct dc *dc, enum dc_irq_source src, bool enable)
@@ -2949,7 +2948,7 @@ static bool link_add_remote_sink_helper(struct dc_link *dc_link, struct dc_sink
 	return true;
 }
 
-/**
+/*
  * dc_link_add_remote_sink() - Create a sink and attach it to an existing link
  *
  * EDID length is in bytes
@@ -3012,7 +3011,7 @@ struct dc_sink *dc_link_add_remote_sink(
 	return NULL;
 }
 
-/**
+/*
  * dc_link_remove_remote_sink() - Remove a remote sink from a dc_link
  *
  * Note that this just removes the struct dc_sink - it doesn't
-- 
2.25.1

