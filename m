Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7535A2EF8DC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729492AbhAHURk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbhAHURH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:17:07 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBACC061243
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:42 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id q75so9454322wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUGfQYc+R1dSwJCy8EOZsDxk+j22XvGXIhAmHcCe5cw=;
        b=DWuALbOhM66Bs4VwVlyplT5ynHt8NzU3loaaZxKRM42BP/MjWrJmNNyXEDNQAWWUgJ
         AVVbyPb8jiDbNhUJkj4Gmsg7VzT3+WI261d/9SWtCnnkvlsZNNbXp0ehTrZASSv6Rrkv
         xiAVooMmLYM8rmb8ZwAnTu6rPmRD9O1kjkhFONkNcdyv22UeNWhpzZQJwZtq11T+Q/UR
         emEiXSKaK8tShQ2wut5xKFCiNJ+IKcYdMGxp3TkIsfzVueHbBGvpxrnmZ2nVdeC6X1vV
         dDC9x2dPQxojVJcxAbk2qGprHLHKrqdzLejDbibsn2hUTXEt+V5wuL2hydI5G1bhoXxX
         Oc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUGfQYc+R1dSwJCy8EOZsDxk+j22XvGXIhAmHcCe5cw=;
        b=rUuH3nn4v4VIddF9kw2zHqez46i1zGwBEFIb3xDTUuCxWbsrlsa/HAmVPNn8ULc53z
         A4xBjszG2rYhBy85FtXXF+IsTYVHbKeQymi8n1Yb2ErYPLneNCjHFA+sCnkFfOoiLc1v
         dsVUWLObMiKnae5H/rIv9LqEkPzhJrUBwl296r5EKxKSmm8WWBfQuYkJ6Otj6aFXZvEx
         f7qhxpKtCrPyN1f7jhhc5eT6eBsCz5gBDbGZagdcTNol0V7UTv4dG+aIM5NOLfEvtCQu
         1LYgIa/rOQ1PlWmRlGosY7SFyiO5mF19S2s6FfiYEWb1A6CGFtrIo7M8080IOHGpYv8n
         Kzew==
X-Gm-Message-State: AOAM531AVuo7pHR4Wt3xkkhfMkJbxAn+kjqrb6hEk4e2lQB9LFmV/NYb
        ARzCq7jx9ur24bTpPzyjd9yAwQ==
X-Google-Smtp-Source: ABdhPJwZWGT0SqzjU0ajhwspc3Sw3rWT8U3ETPx3G6MwoIvh2O6d6nInckJTXpUxvcYNu6v99GiJnA==
X-Received: by 2002:a1c:9a57:: with SMTP id c84mr4347583wme.183.1610136941141;
        Fri, 08 Jan 2021 12:15:41 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:40 -0800 (PST)
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
Subject: [PATCH 25/40] drm/amd/display/dc/dce/dce_link_encoder: Make functions invoked by reference static
Date:   Fri,  8 Jan 2021 20:14:42 +0000
Message-Id: <20210108201457.3078600-26-lee.jones@linaro.org>
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

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1200:6: warning: no previous prototype for ‘dce60_link_encoder_enable_dp_output’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1239:6: warning: no previous prototype for ‘dce60_link_encoder_enable_dp_mst_output’ [-Wmissing-prototypes]
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1429:6: warning: no previous prototype for ‘dce60_link_encoder_dp_set_phy_pattern’ [-Wmissing-prototypes]

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
 drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 210466b2d8631..0ef2f4d9d8bf3 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -1197,7 +1197,7 @@ void dce110_link_encoder_enable_dp_mst_output(
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
 /* enables DP PHY output */
-void dce60_link_encoder_enable_dp_output(
+static void dce60_link_encoder_enable_dp_output(
 	struct link_encoder *enc,
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source)
@@ -1236,7 +1236,7 @@ void dce60_link_encoder_enable_dp_output(
 }
 
 /* enables DP PHY output in MST mode */
-void dce60_link_encoder_enable_dp_mst_output(
+static void dce60_link_encoder_enable_dp_mst_output(
 	struct link_encoder *enc,
 	const struct dc_link_settings *link_settings,
 	enum clock_source_id clock_source)
@@ -1426,7 +1426,7 @@ void dce110_link_encoder_dp_set_phy_pattern(
 
 #if defined(CONFIG_DRM_AMD_DC_SI)
 /* set DP PHY test and training patterns */
-void dce60_link_encoder_dp_set_phy_pattern(
+static void dce60_link_encoder_dp_set_phy_pattern(
 	struct link_encoder *enc,
 	const struct encoder_set_dp_phy_pattern_param *param)
 {
-- 
2.25.1

