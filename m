Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8914E2F1EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390885AbhAKTUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390794AbhAKTUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:20:17 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDADC0617A3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y17so901681wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hm4IxlJoGh/sD4Llo9T9poKwv9M0GUPYWILmlGUVZkw=;
        b=pmAPbuu8KzQpA0OGEnyRVYgrkYouxj97xcJnCh+rbNYGLKPXSOHX8XeOQwVagK25PA
         tesulpSrEkQdFCKW4QWNOPohXEzbb4A1NOFx6GHLdCkkrkq9g+kzgLx7r66lffwD8ARo
         7/DsUXnDbc1yg8TK6oVO3JkepMTUm76D2a6qD1XrNqdx2f241rV0hknI+7rN1gGfEBhV
         CnfL5CLLsi8l1h/rVcRuAvW2Fgu/fW2lqqzNyAQM0aMtb8rOGGCfHHPxzdA8OEnwY6XP
         Y2npGlI+u4GkUU8Djw249JxTnErT3aXp3eGpoFPuywhvGVKY8qTEicq8WrLimdl1QzVn
         yUyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hm4IxlJoGh/sD4Llo9T9poKwv9M0GUPYWILmlGUVZkw=;
        b=uVew0EbKupZB/4OjLJQNEu4MxW6UOSRSsgeyG0HJ2Gq7nHDcCHdU8kxyJCMkhYxbC1
         qEx2rxC+8fCnJQ/JDp0KOykZsXvi9eSSIY/4+Qbh1LrL5ABwtZxYpNXWzV6FHhT/xenV
         9Y1SIeRhIhiXCpB5OpEdK0OufHP2iB3V+B9iesKUwq2PkTg7sOfSNtlL3mzXhNdcaczd
         u5EvaBsR1QSQhK3eTYcTAMT57tVYtck9gdN1hbMKvq1FlPVfWmr4xOSWD48kiCl0UIgJ
         cyJjTjeJC/+4m8DRZt0QKgjEmer2eJXAmML638h5JESZnA1uB6ldVsN8tdWsF76mnl1v
         LGXQ==
X-Gm-Message-State: AOAM530Ajpln8WObngWl7sENY8eJMmitfGkVPSebSkEA8ZTqL5ain94g
        FEhAw54AtZs9elpWhRgeTFVO0Q==
X-Google-Smtp-Source: ABdhPJxfc99MylJMQF9yOhc+UdiV+S+o2HbR0ikBaAXL7njSA3ZGSjbo9pFBdHGpdST8TjEdRm4c9A==
X-Received: by 2002:a5d:610d:: with SMTP id v13mr564808wrt.425.1610392775810;
        Mon, 11 Jan 2021 11:19:35 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id n3sm778090wrw.61.2021.01.11.11.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 11:19:35 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mauro Rossi <issor.oruam@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 04/40] drm/amd/display/dc/dce/dce_opp: Demote non-compliant kernel-doc headers
Date:   Mon, 11 Jan 2021 19:18:50 +0000
Message-Id: <20210111191926.3688443-5-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:109: warning: Function parameter or member 'opp110' not described in 'set_truncation'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:109: warning: Function parameter or member 'params' not described in 'set_truncation'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:154: warning: Function parameter or member 'opp110' not described in 'dce60_set_truncation'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:154: warning: Function parameter or member 'params' not described in 'dce60_set_truncation'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:204: warning: Function parameter or member 'opp110' not described in 'set_spatial_dither'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:204: warning: Function parameter or member 'params' not described in 'set_spatial_dither'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:308: warning: Function parameter or member 'opp110' not described in 'set_temporal_dither'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:308: warning: Function parameter or member 'params' not described in 'set_temporal_dither'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:370: warning: Function parameter or member 'opp110' not described in 'dce110_opp_set_clamping'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:370: warning: Function parameter or member 'params' not described in 'dce110_opp_set_clamping'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:430: warning: Function parameter or member 'opp110' not described in 'dce60_opp_set_clamping'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:430: warning: Function parameter or member 'params' not described in 'dce60_opp_set_clamping'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:478: warning: Function parameter or member 'opp110' not described in 'set_pixel_encoding'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:478: warning: Function parameter or member 'params' not described in 'set_pixel_encoding'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:514: warning: Function parameter or member 'opp110' not described in 'dce60_set_pixel_encoding'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:514: warning: Function parameter or member 'params' not described in 'dce60_set_pixel_encoding'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index 2bf8f5a2e0c22..4600231da6cbb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -97,7 +97,7 @@ enum {
 
 
 
-/**
+/*
  *	set_truncation
  *	1) set truncation depth: 0 for 18 bpp or 1 for 24 bpp
  *	2) enable truncation
@@ -142,7 +142,7 @@ static void set_truncation(
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
-/**
+/*
  *	dce60_set_truncation
  *	1) set truncation depth: 0 for 18 bpp or 1 for 24 bpp
  *	2) enable truncation
@@ -183,7 +183,7 @@ static void dce60_set_truncation(
 }
 #endif
 
-/**
+/*
  *	set_spatial_dither
  *	1) set spatial dithering mode: pattern of seed
  *	2) set spatial dithering depth: 0 for 18bpp or 1 for 24bpp
@@ -291,7 +291,7 @@ static void set_spatial_dither(
 		FMT_SPATIAL_DITHER_EN, 1);
 }
 
-/**
+/*
  *	SetTemporalDither (Frame Modulation)
  *	1) set temporal dither depth
  *	2) select pattern: from hard-coded pattern or programmable pattern
@@ -355,7 +355,7 @@ static void set_temporal_dither(
 		FMT_TEMPORAL_DITHER_EN, 1);
 }
 
-/**
+/*
  *	Set Clamping
  *	1) Set clamping format based on bpc - 0 for 6bpc (No clamping)
  *		1 for 8 bpc
@@ -415,7 +415,7 @@ void dce110_opp_set_clamping(
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
-/**
+/*
  *	Set Clamping for DCE6 parts
  *	1) Set clamping format based on bpc - 0 for 6bpc (No clamping)
  *		1 for 8 bpc
@@ -465,7 +465,7 @@ static void dce60_opp_set_clamping(
 }
 #endif
 
-/**
+/*
  *	set_pixel_encoding
  *
  *	Set Pixel Encoding
@@ -501,7 +501,7 @@ static void set_pixel_encoding(
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
-/**
+/*
  *	dce60_set_pixel_encoding
  *	DCE6 has no FMT_SUBSAMPLING_{MODE,ORDER} bits in FMT_CONTROL reg
  *	Set Pixel Encoding
-- 
2.25.1

