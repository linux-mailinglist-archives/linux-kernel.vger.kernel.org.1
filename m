Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1509F2EF8F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 21:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbhAHUTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 15:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbhAHUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 15:16:42 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D32C061244
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 12:15:43 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id i9so10169441wrc.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 12:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pblAeFWzmcS2QjfKQcW4YzpdGFQhCgUQwjxDwmXWZWw=;
        b=Xy31cYvBZTa7wJ1AwNUqIzABwROlfQfrASnc5CTUU081n4VYSnlDIaJAc21aaE+eWx
         8Ux4vVwgMYkbOuZ1bXU/h+qbLVBFN5564/w1AT1hrGktaGQJcMFovbEaR51iRcy6atHQ
         w0tIx2ZCcnJzTPYP3lZ/jEvrd+457uEkr1i1voZClrunnwQyMLA0wv1XJ2Ho5BiMnSb4
         9WmbTG/OO7FoDPt0+ULwXPcOYlOd5xuGi4gGEfGEFMrCQX1erOpB3+qtS6QEMT/T46ZT
         U4gIigaDRgZ6AzJKcAF2A5Ktgq8NRtyYj686vz5UgfdAe5z9n1JMZ/ThH7y7PYkCTIOO
         moTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pblAeFWzmcS2QjfKQcW4YzpdGFQhCgUQwjxDwmXWZWw=;
        b=acmq4V+5PpQW0AzhUDjGACclUOr8R9jeda9FcYHjJlMNG7MbyUEV29YbgxfjT4KMKv
         Nn8PtnsYmKLWPOtDeq3ZXPZV1P28J4ko1nzncJ6Fd4rmSDaoqhaq/VjOFk+FBq8TS/i9
         fzxrUTf9UH0tUzedT5KstsehF1MxJ+VY/VybaiTaFCPyyGdXoEr/elZsItUxoRLD9kPV
         OFGI48OSDL+geJ/meFN7RstUIbi8hSohyrlOFIt4MdOZHV0+96BcApPFHPpA+P4n0lW3
         RsC2IyDOb/9nkG+XEkiq1bsi6grwZOKwTPn76JEvcGyD7xNoR0RBn0ee3xqK6TRThROB
         6ufw==
X-Gm-Message-State: AOAM533kZhcAir/t1jEsqnrKjHMMVfYyd1nnxhlripTm5zysCAGGnkZK
        d2kEZEy5wExfmb/7mBqOHVyX4A==
X-Google-Smtp-Source: ABdhPJwKfZJVO0VBgsruhlxZw4wp8+ys6OwzyXyumA3cPPvLorD8pVohryyd3OLfJKdTKKLiY/j4GA==
X-Received: by 2002:a05:6000:1188:: with SMTP id g8mr5413367wrx.111.1610136942484;
        Fri, 08 Jan 2021 12:15:42 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id l8sm15598671wrb.73.2021.01.08.12.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 12:15:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 26/40] drm/amd/display/dc/dce/dce_clock_source: Fix formatting/spelling of worthy function headers
Date:   Fri,  8 Jan 2021 20:14:43 +0000
Message-Id: <20210108201457.3078600-27-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210108201457.3078600-1-lee.jones@linaro.org>
References: <20210108201457.3078600-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Demote the one that provides no param descriptions.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: warning: Function parameter or member 'calc_pll_cs' not described in 'calculate_fb_and_fractional_fb_divider'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: warning: Function parameter or member 'target_pix_clk_100hz' not described in 'calculate_fb_and_fractional_fb_divider'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: warning: Function parameter or member 'ref_divider' not described in 'calculate_fb_and_fractional_fb_divider'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: warning: Function parameter or member 'post_divider' not described in 'calculate_fb_and_fractional_fb_divider'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: warning: Function parameter or member 'feedback_divider_param' not described in 'calculate_fb_and_fractional_fb_divider'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: warning: Function parameter or member 'fract_feedback_divider_param' not described in 'calculate_fb_and_fractional_fb_divider'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: warning: Function parameter or member 'calc_pll_cs' not described in 'calc_fb_divider_checking_tolerance'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: warning: Function parameter or member 'pll_settings' not described in 'calc_fb_divider_checking_tolerance'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: warning: Function parameter or member 'ref_divider' not described in 'calc_fb_divider_checking_tolerance'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: warning: Function parameter or member 'post_divider' not described in 'calc_fb_divider_checking_tolerance'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: warning: Function parameter or member 'tolerance' not described in 'calc_fb_divider_checking_tolerance'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:478: warning: Function parameter or member 'clk_src' not described in 'dce110_get_pix_clk_dividers_helper'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:478: warning: Function parameter or member 'pll_settings' not described in 'dce110_get_pix_clk_dividers_helper'
 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:478: warning: Function parameter or member 'pix_clk_params' not described in 'dce110_get_pix_clk_dividers_helper'

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../drm/amd/display/dc/dce/dce_clock_source.c | 57 +++++++++----------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
index fb733f573715e..10938a8c9500a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
@@ -113,20 +113,19 @@ static const struct spread_spectrum_data *get_ss_data_entry(
 }
 
 /**
- * Function: calculate_fb_and_fractional_fb_divider
+ * calculate_fb_and_fractional_fb_divider - Calculates feedback and fractional
+ *                                          feedback dividers values
  *
- * * DESCRIPTION: Calculates feedback and fractional feedback dividers values
+ * @calc_pll_cs:	    Pointer to clock source information
+ * @target_pix_clk_100hz:   Desired frequency in 100 Hz
+ * @ref_divider:            Reference divider (already known)
+ * @post_divider:           Post Divider (already known)
+ * @feedback_divider_param: Pointer where to store
+ *			    calculated feedback divider value
+ * @fract_feedback_divider_param: Pointer where to store
+ *			    calculated fract feedback divider value
  *
- *PARAMETERS:
- * targetPixelClock             Desired frequency in 100 Hz
- * ref_divider                  Reference divider (already known)
- * postDivider                  Post Divider (already known)
- * feedback_divider_param       Pointer where to store
- *					calculated feedback divider value
- * fract_feedback_divider_param Pointer where to store
- *					calculated fract feedback divider value
- *
- *RETURNS:
+ * return:
  * It fills the locations pointed by feedback_divider_param
  *					and fract_feedback_divider_param
  * It returns	- true if feedback divider not 0
@@ -175,22 +174,22 @@ static bool calculate_fb_and_fractional_fb_divider(
 }
 
 /**
-*calc_fb_divider_checking_tolerance
-*
-*DESCRIPTION: Calculates Feedback and Fractional Feedback divider values
-*		for passed Reference and Post divider, checking for tolerance.
-*PARAMETERS:
-* pll_settings		Pointer to structure
-* ref_divider		Reference divider (already known)
-* postDivider		Post Divider (already known)
-* tolerance		Tolerance for Calculated Pixel Clock to be within
-*
-*RETURNS:
-* It fills the PLLSettings structure with PLL Dividers values
-* if calculated values are within required tolerance
-* It returns	- true if error is within tolerance
-*		- false if error is not within tolerance
-*/
+ * calc_fb_divider_checking_tolerance - Calculates Feedback and
+ *                                      Fractional Feedback divider values
+ *		                        for passed Reference and Post divider,
+ *                                      checking for tolerance.
+ * @calc_pll_cs:	Pointer to clock source information
+ * @pll_settings:	Pointer to PLL settings
+ * @ref_divider:	Reference divider (already known)
+ * @post_divider:	Post Divider (already known)
+ * @tolerance:		Tolerance for Calculated Pixel Clock to be within
+ *
+ * return:
+ *  It fills the PLLSettings structure with PLL Dividers values
+ *  if calculated values are within required tolerance
+ *  It returns	- true if error is within tolerance
+ *		- false if error is not within tolerance
+ */
 static bool calc_fb_divider_checking_tolerance(
 		struct calc_pll_clock_source *calc_pll_cs,
 		struct pll_settings *pll_settings,
@@ -460,7 +459,7 @@ static bool pll_adjust_pix_clk(
 	return false;
 }
 
-/**
+/*
  * Calculate PLL Dividers for given Clock Value.
  * First will call VBIOS Adjust Exec table to check if requested Pixel clock
  * will be Adjusted based on usage.
-- 
2.25.1

