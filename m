Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A97E2F45EE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 09:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbhAMIJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 03:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbhAMIJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 03:09:34 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D01C061383
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y187so712796wmd.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 00:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FpwY4GtbDJpEMrD8DXq2EUXYJZUv4cPwkIqKzqODNJA=;
        b=Bdvrn9SakRrtH0IarS95O03IgYmKiSBzTWBhd72Xl2oiD/WRlfu8A5bqe5l3YriNXF
         XPdsV1cYlQIaO3Wx2GAb3a9TuycM7uNa/YcQa+ftyADQMOesp+QtFSWrQi7A3FnUo+yk
         2BbUt3WNtBG4rKew2hsF3bC+CS1z+ySpMsLAEi/g9cjsqVvKUGZmfsA5nzaC2ujZZvD9
         hqs3+IdBQTTVH103vC8BgMirOrYD+IM0pQWapb+JF9X03WLYIEmyCphzJjJ5lBt6nn2X
         iQFmQee0qcQxQg/lLCZGHZjKQBBqb42J3W/TdT3LDF24z69aIWpFX2rBdwTZMAdYLAbn
         wyig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpwY4GtbDJpEMrD8DXq2EUXYJZUv4cPwkIqKzqODNJA=;
        b=qXV4f5ow9gR3hA6aKZpVwhaplw0BZLhC48jtetKt5BYzkg08z2Pi+eO1fwMLKb+xV5
         2T45Btk/c9zoM/siD0cgC34AqZd7Ue7Pt576KvE3KYKBzNTbvp/cFzDPAEkzIUKjumGV
         D63JWR4zsv/odAe4NbCnKrXCVpJH2m2PdbhE04SdgKvHo1EJUKG2hj2Cks6TndvHKC6l
         1MqrmlhXt9HZOtWWQhWLpxUalkUEX7yF4/c5qH1GTawirJnGAkkKjHIrvWCQubvaZeut
         XE8Ros9KgbHldbdXA0+VB8D98VUGrUF0KRgk4cB7QkX+BUgu1G1D5D1QyCkVjA67pF/m
         CIGw==
X-Gm-Message-State: AOAM5308vACLIloCW8PLhFktefSK44+x9wHsnNat+xgKpW7kA7rYczCj
        pDd7FSYRXzBvWS6bjwX60klliA==
X-Google-Smtp-Source: ABdhPJyMSIIWiu2bN6N7ZNvS2zrhWvtrGATyhCuNtgDZVfGZXO735pYuZMZ8fdxPfs5n1O+GCbhlrQ==
X-Received: by 2002:a1c:234d:: with SMTP id j74mr954180wmj.18.1610525303222;
        Wed, 13 Jan 2021 00:08:23 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id r20sm1642486wmh.15.2021.01.13.00.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 00:08:22 -0800 (PST)
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
Subject: [PATCH 22/30] drm/amd/display/dc/core/dc_link: Fix a couple of function documentation issues
Date:   Wed, 13 Jan 2021 08:07:44 +0000
Message-Id: <20210113080752.1003793-23-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:214: warning: Function parameter or member 'link' not described in 'dc_link_detect_sink'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:350: warning: Function parameter or member 'link' not described in 'dc_link_is_dp_sink_present'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:841: warning: Function parameter or member 'link' not described in 'dc_link_detect_helper'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:841: warning: Function parameter or member 'reason' not described in 'dc_link_detect_helper'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3403: warning: Cannot understand  *****************************************************************************

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
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 3366a49f11dc7..271c4f66edb56 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -206,6 +206,7 @@ static bool program_hpd_filter(const struct dc_link *link)
 /**
  * dc_link_detect_sink() - Determine if there is a sink connected
  *
+ * @link: pointer to the dc link
  * @type: Returned connection type
  * Does not detect downstream devices, such as MST sinks
  * or display connected through active dongles
@@ -342,7 +343,7 @@ static enum signal_type get_basic_signal_type(struct graphics_object_id encoder,
 	return SIGNAL_TYPE_NONE;
 }
 
-/**
+/*
  * dc_link_is_dp_sink_present() - Check if there is a native DP
  * or passive DP-HDMI dongle connected
  */
@@ -828,7 +829,7 @@ static bool wait_for_entering_dp_alt_mode(struct dc_link *link)
 	return false;
 }
 
-/**
+/*
  * dc_link_detect() - Detect if a sink is attached to a given link
  *
  * link->local_sink is created or destroyed as needed.
@@ -3400,10 +3401,7 @@ void core_link_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
 }
 
 /**
- *****************************************************************************
- *  Function: dc_link_enable_hpd_filter
- *
- *  @brief
+ *  dc_link_enable_hpd_filter:
  *     If enable is true, programs HPD filter on associated HPD line using
  *     delay_on_disconnect/delay_on_connect values dependent on
  *     link->connector_signal
@@ -3411,9 +3409,8 @@ void core_link_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
  *     If enable is false, programs HPD filter on associated HPD line with no
  *     delays on connect or disconnect
  *
- *  @param [in] link: pointer to the dc link
- *  @param [in] enable: boolean specifying whether to enable hbd
- *****************************************************************************
+ *  @link:   pointer to the dc link
+ *  @enable: boolean specifying whether to enable hbd
  */
 void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
 {
-- 
2.25.1

