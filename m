Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084AB2F83E8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388578AbhAOSRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388562AbhAOSRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7140C0617AA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y17so10197495wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KHlPUbSx+S7HaZ3WBED5ORmcl4UG0ks+269HCulT/zo=;
        b=bZYtpfaz0DYpixFzW6Nzd+4F9hPJRMtojlCsMlY2KnHYpvFtgakrDpSvM5GYx5XYZL
         asdSBMrkKKcnALNec1t0ZNf8pxjFeMP9dWq9N4KH0VSopwM8kPWS0muwwIdLg3Z+nju8
         9slBiFnMdBmq5jZuQDSC9HAa5lU9d3tnywip2BURw0o8huKwWcetZNKpDVe3S1YfrL7u
         BKWnyQpECfsuEeTK6L6KgDmpTsDk8ubHBXnnaPHpeEYGZ8m6FBZQxUowWVFCz6+Bcs8C
         chRz5cw3Lg1/XaDVsudrPmPiW1ZIo7n09RV7QDTU7fm+mgOcaCqSTlno8rErPuIICv7C
         hFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KHlPUbSx+S7HaZ3WBED5ORmcl4UG0ks+269HCulT/zo=;
        b=G080TEPqlQ+jzkcvUr2NUXhTKctkSeRB8VhGM0FmkFzx2TUT61/hJ0K1NnBwHjnAhE
         ICIRbniWgVYb7wxTmpSBkeMNiiqjTdkxIa3e7QQVW7PEOHef8Jw8rKMwm7LAloNHfpIQ
         dQp6AkCcdPGjmHZoKPVMKdmcjBng0zwa3+3Rykee3KXs60OJdqsJDQBeTnxJ5eUCLz63
         IV8CQ4H+pLEwRlFQ7luxfGt81N6Uws9UN0gAe0YKj/Kqwj/viy/JSnTw+24VCWRw3a2v
         BcliYvC7YbLdrAWXu80xNhnYLPNz3GvxbzeMxxftZx/BoKKWzXwemLJvF0wffmKzYPyU
         L8xw==
X-Gm-Message-State: AOAM5326A8bYfmT9nfVLZ864DXihtD/47sp5bEdcAesG92OMHBqmxmgs
        jbefyAvHJ47ni85dSsbo9oYGmg==
X-Google-Smtp-Source: ABdhPJyhWz+GaUNosLHdwGA3LiH/FmN+J7ZpAI3lFu2pFreiu9/b2FNhjvUQAAukANQoSXVXodQXew==
X-Received: by 2002:adf:8285:: with SMTP id 5mr14064349wrc.289.1610734593666;
        Fri, 15 Jan 2021 10:16:33 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:32 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 20/29] drm/gma500/oaktrail_crtc: Demote unworthy kernel-doc headers
Date:   Fri, 15 Jan 2021 18:15:52 +0000
Message-Id: <20210115181601.3432599-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/oaktrail_crtc.c:184: warning: Function parameter or member 'limit' not described in 'mrst_lvds_find_best_pll'
 drivers/gpu/drm/gma500/oaktrail_crtc.c:184: warning: Function parameter or member 'crtc' not described in 'mrst_lvds_find_best_pll'
 drivers/gpu/drm/gma500/oaktrail_crtc.c:184: warning: Function parameter or member 'target' not described in 'mrst_lvds_find_best_pll'
 drivers/gpu/drm/gma500/oaktrail_crtc.c:184: warning: Function parameter or member 'refclk' not described in 'mrst_lvds_find_best_pll'
 drivers/gpu/drm/gma500/oaktrail_crtc.c:184: warning: Function parameter or member 'best_clock' not described in 'mrst_lvds_find_best_pll'
 drivers/gpu/drm/gma500/oaktrail_crtc.c:215: warning: Function parameter or member 'crtc' not described in 'oaktrail_crtc_dpms'
 drivers/gpu/drm/gma500/oaktrail_crtc.c:215: warning: Function parameter or member 'mode' not described in 'oaktrail_crtc_dpms'
 drivers/gpu/drm/gma500/oaktrail_crtc.c:345: warning: Function parameter or member 'dev' not described in 'oaktrail_panel_fitter_pipe'

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/oaktrail_crtc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_crtc.c b/drivers/gpu/drm/gma500/oaktrail_crtc.c
index 900e5499249d5..129f879710022 100644
--- a/drivers/gpu/drm/gma500/oaktrail_crtc.c
+++ b/drivers/gpu/drm/gma500/oaktrail_crtc.c
@@ -174,7 +174,7 @@ static bool mrst_sdvo_find_best_pll(const struct gma_limit_t *limit,
 	return min_error == 0;
 }
 
-/**
+/*
  * Returns a set of divisors for the desired target clock with the given refclk,
  * or FALSE.  Divisor values are the actual divisors for
  */
@@ -205,7 +205,7 @@ static bool mrst_lvds_find_best_pll(const struct gma_limit_t *limit,
 	return err != target;
 }
 
-/**
+/*
  * Sets the power management mode of the pipe and plane.
  *
  * This code should probably grow support for turning the cursor off and back
@@ -337,7 +337,7 @@ static void oaktrail_crtc_dpms(struct drm_crtc *crtc, int mode)
 	gma_power_end(dev);
 }
 
-/**
+/*
  * Return the pipe currently connected to the panel fitter,
  * or -1 if the panel fitter is not present or not in use
  */
-- 
2.25.1

