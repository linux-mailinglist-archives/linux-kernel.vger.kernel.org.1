Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34F32A343F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKBTgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgKBTgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:36:18 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C15C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:36:18 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id z3so5644926pfz.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s/DA9Kue9Ve8AC+uOhIa4hc4aaK5zLqpc50nqJdELt0=;
        b=aZL3CEeYk7iVAX0nfTGvMN0yre2qpny9PFNowwuO3SUgxkSiMTlFEb9wI/TaQDhwIP
         yK1l6mGwUoJI12pkoIJEzLUgOutjpgu8N7YR0bG9DGkkBm+JE1tEBdsqT2CXMyImLwUz
         nHH4Oq+Nbg2+ONavgNNYaJcIbFTlRxVehiMXerS39NPsVAznTdA0AvVNDK8E0u0O3kVn
         iSRFQzF3w5JoqoMEOTaZcfb8aWR+tbn/iRVF20L8agcCY7cxSUpwWr+1XYrmJwOIgkHT
         v7aV/za6H4URGmN0ExXJ+Sp6hQf6kFtB9g+pfvFIq64ad2Lv0z/L2qdSQ6b+cEnlTeyH
         FzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s/DA9Kue9Ve8AC+uOhIa4hc4aaK5zLqpc50nqJdELt0=;
        b=nketr1KBYAGwnIJfHAebEbLLo76dOUbglrKNT7KRAlcWEqRqQMloBBMyJ0Mq8GpwP0
         7IuqT8dbOODwuygLp4YjlCGMOlIgkosZqb0w4o51E5xKeofpsuSYUEAZvuLbse1zmCSr
         xwqChVkjvL4uz63E+kZqaFh72eOJkLak/nYEuHIonyNjPELtImq3Exh90ncip3U7An0P
         bXXD8vZxr6zpGIUZ5FOOa34dpM6sDAB01EPUb8wYYNXyRqavLFOgeA0ONUV5Di8Fl4Y+
         hRBieFPlDZ/3RK09Cq4xDUuue+4F3RNuGAy/5HEgP8woBYSP3fdKbPfdvnD32ZisaSmD
         VKMQ==
X-Gm-Message-State: AOAM530zYnsndtvEs9eV9RXhkENsa8FabReE2P6ank3YqtN32ekDOjuK
        RKwd+tkTBU8ofDjEBXa0WZcyWjQq/d4=
X-Google-Smtp-Source: ABdhPJxGtFsHxqpHVik0XMgKD5oDUq7RYiD8rabDGWVXAqIBZBXqVhXo4Th8ZmALaNcYTdhpQGbbhw==
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id s7-20020aa782870000b0290142250139ecmr22201598pfm.59.1604345777761;
        Mon, 02 Nov 2020 11:36:17 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id gb13sm241681pjb.55.2020.11.02.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:36:17 -0800 (PST)
Date:   Tue, 3 Nov 2020 01:06:11 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, gregkh@linuxfoundation.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH 3/6] drm/amdgpu/jpeg: use "*" adjacent to data name
Message-ID: <cc3d07cfc8480f9f812d801f66ee9dee5674c662.1604345594.git.mh12gx2825@gmail.com>
References: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When declaring pointer data, the "*" symbol should be used adjacent to
the data name as per the coding standards. This resolves following
issues reported by checkpatch script:
	ERROR: "foo *   bar" should be "foo *bar"
	ERROR: "foo * bar" should be "foo *bar"
	ERROR: "foo*            bar" should be "foo *bar"
	ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 6 +++---
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 7b1a18cbafc4..6b80dcea80ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -247,7 +247,7 @@ static int jpeg_v2_0_disable_power_gating(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int jpeg_v2_0_enable_power_gating(struct amdgpu_device* adev)
+static int jpeg_v2_0_enable_power_gating(struct amdgpu_device *adev)
 {
 	if (adev->pg_flags & AMD_PG_SUPPORT_JPEG) {
 		uint32_t data;
@@ -274,7 +274,7 @@ static int jpeg_v2_0_enable_power_gating(struct amdgpu_device* adev)
 	return 0;
 }
 
-static void jpeg_v2_0_disable_clock_gating(struct amdgpu_device* adev)
+static void jpeg_v2_0_disable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
@@ -297,7 +297,7 @@ static void jpeg_v2_0_disable_clock_gating(struct amdgpu_device* adev)
 	WREG32_SOC15(JPEG, 0, mmJPEG_CGC_GATE, data);
 }
 
-static void jpeg_v2_0_enable_clock_gating(struct amdgpu_device* adev)
+static void jpeg_v2_0_enable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 845306f63cdb..c6724a0e0c43 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -247,7 +247,7 @@ static int jpeg_v2_5_resume(void *handle)
 	return r;
 }
 
-static void jpeg_v2_5_disable_clock_gating(struct amdgpu_device* adev, int inst)
+static void jpeg_v2_5_disable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data;
 
@@ -276,7 +276,7 @@ static void jpeg_v2_5_disable_clock_gating(struct amdgpu_device* adev, int inst)
 	WREG32_SOC15(JPEG, inst, mmJPEG_CGC_CTRL, data);
 }
 
-static void jpeg_v2_5_enable_clock_gating(struct amdgpu_device* adev, int inst)
+static void jpeg_v2_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
 {
 	uint32_t data;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 3a0dff53654d..e8fbb2a0de34 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -213,7 +213,7 @@ static int jpeg_v3_0_resume(void *handle)
 	return r;
 }
 
-static void jpeg_v3_0_disable_clock_gating(struct amdgpu_device* adev)
+static void jpeg_v3_0_disable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
 
@@ -243,7 +243,7 @@ static void jpeg_v3_0_disable_clock_gating(struct amdgpu_device* adev)
 	WREG32_SOC15(JPEG, 0, mmJPEG_CGC_CTRL, data);
 }
 
-static void jpeg_v3_0_enable_clock_gating(struct amdgpu_device* adev)
+static void jpeg_v3_0_enable_clock_gating(struct amdgpu_device *adev)
 {
 	uint32_t data = 0;
 
@@ -286,7 +286,7 @@ static int jpeg_v3_0_disable_static_power_gating(struct amdgpu_device *adev)
 	return 0;
 }
 
-static int jpeg_v3_0_enable_static_power_gating(struct amdgpu_device* adev)
+static int jpeg_v3_0_enable_static_power_gating(struct amdgpu_device *adev)
 {
 	/* enable anti hang mechanism */
 	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_POWER_STATUS),
-- 
2.25.1

