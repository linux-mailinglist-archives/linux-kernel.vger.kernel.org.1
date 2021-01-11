Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765712F1F1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391036AbhAKTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403932AbhAKTVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:21:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91F2C061345
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id q75so297958wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AejyAKESpWoI52tNZY+VpYKWtH7XjXdVdCW7Df3aTz4=;
        b=fL0A3FYKyTXR1evYTyVZcRhsAUYxUi2VIDBy/CKs5c5KAjiVP8mb4fcwcGvU+pmIOa
         85gscWuzM0iyOkj+belxv0VLkBefcLZSUTNYoFOM1NCwEsEl1eLgtA+lbMUvEl1j9FYG
         8l3Xlqq8GYvvazaKupRqFvEGlrR+MJ9Ftr5ATPw0C17fiBAw3a0RpQpmmkUcNuMEFi05
         dUwPFX3VYlBCMvwfuNQekEYCveNycqsFJQ2WMVIV+uWlsweflYJU6CVnKsWVtah8M4lb
         t703vrdVc9G9sY63wzC6c6+HrX6+hFdXpQVZgtU5RwsJnNjEcMCVOyLFl+tqzZJlR/E/
         hdeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AejyAKESpWoI52tNZY+VpYKWtH7XjXdVdCW7Df3aTz4=;
        b=pa36N726FnJeon8uVvIe0f4015u2l85ZIa3lC57vlHr074OqCccfhDn+gDhtT/vHdM
         Mt1VS7oLDispJSQ96qY351NSRnMZIgw/l5EKkHhNFljBqsr2tz3WXH+mztNTVMHYnm7M
         imybnhcMSRDu5o/e1uhNi6HiNoF5QOlsgUjqMTIj1p/S34l8gNAmC5BkEAbv+1R8X0B2
         3aFYj/AcTr4cpmo1s836nOAWVQ/sYg1sI33+2jaf7aQ9TLTmQcAZPPGKngI+Bv6dfyx2
         MyKj8WjTCXtx+2LF2Lh82MfMu+vjwDT1lqfXB0EQy+5pMvwWAvyYsBkHrWbpTFZvJZg/
         zMaQ==
X-Gm-Message-State: AOAM532sY/yo0wS5aXv2IY9Ok8+kCfrF/Yn+leM4nW3i6dkhjFY0tX8d
        ff5/b1Abq0Yc3ElzYo3c08kCyw==
X-Google-Smtp-Source: ABdhPJwqLNKhpsvusFowjVq55d1AVbljG6jJxOvD/XIynEhDqhCVft9FdfgFL3xLk24pL+s98upOxg==
X-Received: by 2002:a1c:4489:: with SMTP id r131mr311092wma.24.1610392822455;
        Mon, 11 Jan 2021 11:20:22 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:20:21 -0800 (PST)
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
Subject: [PATCH 40/40] drm/amd/display/dc/core/dc_stream: Demote non-conformant kernel-doc headers
Date:   Mon, 11 Jan 2021 19:19:26 +0000
Message-Id: <20210111191926.3688443-41-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210111191926.3688443-1-lee.jones@linaro.org>
References: <20210111191926.3688443-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:253: warning: Function parameter or member 'pStream' not described in 'dc_optimize_timing_for_fsft'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:253: warning: Function parameter or member 'max_input_rate_in_khz' not described in 'dc_optimize_timing_for_fsft'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:270: warning: Function parameter or member 'stream' not described in 'dc_stream_set_cursor_attributes'
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_stream.c:270: warning: Function parameter or member 'attributes' not described in 'dc_stream_set_cursor_attributes'

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
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index c103f858375d0..25fa712a78474 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -244,7 +244,7 @@ struct dc_stream_status *dc_stream_get_status(
 }
 
 #ifndef TRIM_FSFT
-/**
+/*
  * dc_optimize_timing_for_fsft() - dc to optimize timing
  */
 bool dc_optimize_timing_for_fsft(
@@ -260,8 +260,7 @@ bool dc_optimize_timing_for_fsft(
 }
 #endif
 
-
-/**
+/*
  * dc_stream_set_cursor_attributes() - Update cursor attributes and set cursor surface address
  */
 bool dc_stream_set_cursor_attributes(
-- 
2.25.1

