Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F39F2EF8D9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbhAHUR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbhAHURL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:17:11 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66157C0612FD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y23so9443295wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zW3ufI7pY7JKZ5jgf9PFOiorHzk8Ikn536vctwi0D0o=;
        b=o3+1v//IuiO8OWf1LsRbjZv/Xs6WgdkPiA0liTKkThpPTBjfWe46BeDVSY32inCCQr
         ipNhPObHC4cpO9eg3wFEcYD4IkaSKkd0DwOj2e1mllIpDfTF4f7hUlU29AANQ9RJDYe/
         hxT5H7cx6tbtdM72Oq51SIdiuL8P4vQ6OEU300+iwQEHxGWipdoNLvPXoVAK4XGdJDnS
         pUikoZhdHW1KTDHclPBwb2FLIinrwM07ZMcGAQtC5eDawXjDNoNrXLXOhRntsxiIwhe+
         jMbiszhFMrXF/EBDYGL9bFTO1UnUxx+55azoVqpmoyaoxaemhPWP9X4DG/JkoQoDwO43
         BZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zW3ufI7pY7JKZ5jgf9PFOiorHzk8Ikn536vctwi0D0o=;
        b=rR3Ll78Zs3VOtK7LE2OXlTRzOD72bjE/Aqh580YDV6WzVxgaXsJHoOlCA14P3cyzWQ
         t4Qd8rI2FH7AcrMLZq0072ZjRYLUBbCg7n6CICobibfOdA1oW1RAFRdAZPBJq0lGW4Ov
         Up9cVUoxeCZw4M22YmCLQ3sGDDFpdk8V1L4/VBzdwqRMKMDZF/3mt+ja2saedz2nN/vs
         5R6n44n36R4tn5ayh8uxsQHKSu5m5HXCLjo24/IaBGF5aiqVz6pAHLZkqZrNuvNLmyCL
         ooEjgg8jNgrvb1WwrPkokMXLhcMuZnhAwOQm9u80lUCXhp32coVYa7C4HJCUwKR95Cyw
         2PLw==
X-Gm-Message-State: AOAM533IZ+oGUVN41NIITc20VgnmaLvLelwoCbzXecyzS9vlC8VlWPyc
        p7cKXtGkcXkrvbv8kvzSgH807A==
X-Google-Smtp-Source: ABdhPJyhre7nNzYMjQTmOKcnjVaXR3GH/Z4Xtw8jRqqFDeJ+IzSHh3cydfpLMioIBHahxZ66ZAOewQ==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr4580747wmc.39.1610136949189;
        Fri, 08 Jan 2021 12:15:49 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:48 -0800 (PST)
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
Subject: [PATCH 31/40] drm/amd/display/dc/dce/dce_opp: Make local functions and ones invoked by reference static
Date:   Fri,  8 Jan 2021 20:14:48 +0000
Message-Id: <20210108201457.3078600-32-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:427:6: warning: no previous prototype for ‘dce60_opp_set_clamping’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:548:6: warning: no previous prototype for ‘dce60_opp_program_bit_depth_reduction’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:571:6: warning: no previous prototype for ‘dce60_opp_program_clamping_and_pixel_encoding’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:681:6: warning: no previous prototype for ‘dce60_opp_program_fmt’ [-Wmissing-prototypes]

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Mauro Rossi <issor.oruam@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index e459ae65aaf76..2bf8f5a2e0c22 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -424,7 +424,7 @@ void dce110_opp_set_clamping(
  *		7 for programable
  *	2) Enable clamp if Limited range requested
  */
-void dce60_opp_set_clamping(
+static void dce60_opp_set_clamping(
 	struct dce110_opp *opp110,
 	const struct clamping_and_pixel_encoding_params *params)
 {
@@ -545,7 +545,7 @@ void dce110_opp_program_bit_depth_reduction(
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
-void dce60_opp_program_bit_depth_reduction(
+static void dce60_opp_program_bit_depth_reduction(
 	struct output_pixel_processor *opp,
 	const struct bit_depth_reduction_params *params)
 {
@@ -568,7 +568,7 @@ void dce110_opp_program_clamping_and_pixel_encoding(
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
-void dce60_opp_program_clamping_and_pixel_encoding(
+static void dce60_opp_program_clamping_and_pixel_encoding(
 	struct output_pixel_processor *opp,
 	const struct clamping_and_pixel_encoding_params *params)
 {
@@ -678,7 +678,7 @@ void dce110_opp_program_fmt(
 }
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
-void dce60_opp_program_fmt(
+static void dce60_opp_program_fmt(
 	struct output_pixel_processor *opp,
 	struct bit_depth_reduction_params *fmt_bit_depth,
 	struct clamping_and_pixel_encoding_params *clamping)
-- 
2.25.1

