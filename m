Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661602EF8D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbhAHURC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729347AbhAHUQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:59 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B79C061257
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:16:02 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id v14so8751470wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eWoKxxHh/jIScLnS2QAr46PBCZJOD2Raq8YJ5NQrCs=;
        b=UgwKrpQj8bI7j36cfQXc3ja3wLCuYNWWeh1QOGINun8I9cI3ipS1TdZ1r+JxJvIkln
         J2FC1Gro3x2D8HUtUNcnF4ArUwEMcdM2dvZB7fwyTB2yd7K0tFjnIds/fGs0SuxeWAZZ
         lJrHUGhb2gCxYxqQHczSAhBhInAOO+j2mTmgqS+vdgPW88BQfWPhdYzNECNNbVKZB1mA
         d+VP6aaHpIKPrjDOw85/gLmOppJ4RZvz4W3n0/LI6KG0DDqsbIwXqLvWPqJ5OIKkEjyZ
         pvDrl3Brwx05UpHLrWqNsH7vHXaKFgP1YqToxsuwyscSQyxWc/TQYELWFyTgxQBehiYk
         QXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eWoKxxHh/jIScLnS2QAr46PBCZJOD2Raq8YJ5NQrCs=;
        b=Pu08tJq5kdy4YQSb1QIwTxhZpkhDGRGSvLco3PmE1idKt6hqMajH1VJrNcIrxhR79c
         en0zMu2JUbEVM1EqYzFJR7U2HInx/gyrqKnJ0h1+J9kmdLobfraeNbBrOp7ad8QfWmmj
         ilptdGNjklgndVdZ4wQyrnUX6dQF6JkXGRjCgbitTxjt+adxln8Ynr3Uh5PgQtpZpObB
         DQzEzZ6hJxX0nkjBSwCmKnTesetx0L6t8E7M707g/PTyGL5LehH0ZH7Ru0w1aF+ltR5C
         NmpFMyCYiUY1LARCyOjpO5u5wk0kl4BiXApDLPWiHDe7hJvTKVE9xNld/6ighX0I9XD0
         4IWQ==
X-Gm-Message-State: AOAM533T5iWx4rgbIjzs5bjY/DXaUpfySqDtYxaNK5ua7Cq7xyZSVH62
        u1Beqml6vItPZRGrhJsXjwFtoA==
X-Google-Smtp-Source: ABdhPJwucocRq4CMupbHCIphosfmpzfS2f6nhBCMV74/+zP/C/b4oX0A7rk70lGZQXp+Y9UtTjxwpg==
X-Received: by 2002:a7b:c45a:: with SMTP id l26mr4503703wmi.91.1610136961199;
        Fri, 08 Jan 2021 12:16:01 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:16:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wyatt Wood <wyatt.wood@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 39/40] drm/amd/display/dc/dce/dmub_psr: Demote non-conformant kernel-doc headers
Date:   Fri,  8 Jan 2021 20:14:56 +0000
Message-Id: <20210108201457.3078600-40-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:38: warning: Function parameter or member 'raw_state' not described in 'convert_psr_state'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:81: warning: Function parameter or member 'dmub' not described in 'dmub_psr_get_state'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:81: warning: Function parameter or member 'state' not described in 'dmub_psr_get_state'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:97: warning: Function parameter or member 'dmub' not described in 'dmub_psr_set_version'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:97: warning: Function parameter or member 'stream' not described in 'dmub_psr_set_version'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:128: warning: Function parameter or member 'dmub' not described in 'dmub_psr_enable'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:128: warning: Function parameter or member 'enable' not described in 'dmub_psr_enable'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:128: warning: Function parameter or member 'wait' not described in 'dmub_psr_enable'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:177: warning: Function parameter or member 'dmub' not described in 'dmub_psr_set_level'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:177: warning: Function parameter or member 'psr_level' not described in 'dmub_psr_set_level'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:203: warning: Function parameter or member 'dmub' not described in 'dmub_psr_copy_settings'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:203: warning: Function parameter or member 'link' not described in 'dmub_psr_copy_settings'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:203: warning: Function parameter or member 'psr_context' not described in 'dmub_psr_copy_settings'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:284: warning: Function parameter or member 'dmub' not described in 'dmub_psr_force_static'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:301: warning: Function parameter or member 'dmub' not described in 'dmub_psr_get_residency'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:301: warning: Function parameter or member 'residency' not described in 'dmub_psr_get_residency'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:323: warning: Function parameter or member 'psr' not described in 'dmub_psr_construct'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:323: warning: Function parameter or member 'ctx' not described in 'dmub_psr_construct'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:332: warning: Function parameter or member 'ctx' not described in 'dmub_psr_create'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dmub_psr.c:349: warning: Function parameter or member 'dmub' not described in 'dmub_psr_destroy'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Wyatt Wood <wyatt.wood@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index 17e84f34ceba1..4228caa741193 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -31,7 +31,7 @@
 
 #define MAX_PIPES 6
 
-/**
+/*
  * Convert dmcub psr state to dmcu psr state.
  */
 static enum dc_psr_state convert_psr_state(uint32_t raw_state)
@@ -74,7 +74,7 @@ static enum dc_psr_state convert_psr_state(uint32_t raw_state)
 	return state;
 }
 
-/**
+/*
  * Get PSR state from firmware.
  */
 static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
@@ -90,7 +90,7 @@ static void dmub_psr_get_state(struct dmub_psr *dmub, enum dc_psr_state *state)
 	*state = convert_psr_state(raw_state);
 }
 
-/**
+/*
  * Set PSR version.
  */
 static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *stream)
@@ -121,7 +121,7 @@ static bool dmub_psr_set_version(struct dmub_psr *dmub, struct dc_stream_state *
 	return true;
 }
 
-/**
+/*
  * Enable/Disable PSR.
  */
 static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
@@ -170,7 +170,7 @@ static void dmub_psr_enable(struct dmub_psr *dmub, bool enable, bool wait)
 	}
 }
 
-/**
+/*
  * Set PSR level.
  */
 static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level)
@@ -194,7 +194,7 @@ static void dmub_psr_set_level(struct dmub_psr *dmub, uint16_t psr_level)
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 }
 
-/**
+/*
  * Setup PSR by programming phy registers and sending psr hw context values to firmware.
  */
 static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
@@ -277,7 +277,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	return true;
 }
 
-/**
+/*
  * Send command to PSR to force static ENTER and ignore all state changes until exit
  */
 static void dmub_psr_force_static(struct dmub_psr *dmub)
@@ -294,7 +294,7 @@ static void dmub_psr_force_static(struct dmub_psr *dmub)
 	dc_dmub_srv_wait_idle(dc->dmub_srv);
 }
 
-/**
+/*
  * Get PSR residency from firmware.
  */
 static void dmub_psr_get_residency(struct dmub_psr *dmub, uint32_t *residency)
@@ -316,7 +316,7 @@ static const struct dmub_psr_funcs psr_funcs = {
 	.psr_get_residency		= dmub_psr_get_residency,
 };
 
-/**
+/*
  * Construct PSR object.
  */
 static void dmub_psr_construct(struct dmub_psr *psr, struct dc_context *ctx)
@@ -325,7 +325,7 @@ static void dmub_psr_construct(struct dmub_psr *psr, struct dc_context *ctx)
 	psr->funcs = &psr_funcs;
 }
 
-/**
+/*
  * Allocate and initialize PSR object.
  */
 struct dmub_psr *dmub_psr_create(struct dc_context *ctx)
@@ -342,7 +342,7 @@ struct dmub_psr *dmub_psr_create(struct dc_context *ctx)
 	return psr;
 }
 
-/**
+/*
  * Deallocate PSR object.
  */
 void dmub_psr_destroy(struct dmub_psr **dmub)
-- 
2.25.1

