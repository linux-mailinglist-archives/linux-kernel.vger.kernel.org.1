Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF47B2ADFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgKJTeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731570AbgKJTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:24 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79F1C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:23 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id b6so2665820wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wRyVj7QwW9m8+QJhWlLMpTOCKbqNO9FAw2XMc+XmqfM=;
        b=VXWEbmSQdarwlsBZu0sGfm2zUAEFee1etW65JRLgltUoi+G+TEfeOZuvcOFOtETnCl
         BR5u0aCXUDMEWbkQM8dypexH5UgRgI4h6cG10ovPBfrlnJlxBhDfQdojqGQiEzWjkbv2
         IP4UAKUedp43K+i37H+yZhL1bcqhNEp8De6a/VguzFgKA4iokYZ+bFOl3qn9hbp8enbe
         wxHwYjyBP15UyrKgnwQGKu5uSOZB5y9CI009lwCVp0s83UX9oHeQM4fjPomRExZibnxt
         pPN7DIs/GidNsVTpHOIdaS1azDjBDcohEpKiQ8LdZDfycd5MpkEQCRUpk8za67UsVFxp
         D19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wRyVj7QwW9m8+QJhWlLMpTOCKbqNO9FAw2XMc+XmqfM=;
        b=qOe4RvfULnF2P5l+SmtncfLfLi7svp76ZFqN/C1QSeOKXSdXfJW+ymqVeXeCxezQEW
         JzWX6j50J3N98aNmyau+mtLGzkWqHSnPSB02lXIRRK/c97967W19snxa/bYyTNj0CreJ
         +VMHAehdePVRY9sC+k5cBTQK1aKmlwyITaOf0ntvP653pFKdlH1tf8Bow+X16zLHZcHR
         hPLYLllgI2H6vs0kwuvVT7UlRCz90ndLqUP2H64lPqSpach4lvvgBlP8/82Ujoq4pIQy
         oLEsDNLsRQKMjfxWeaFcBj+Dn0hCzNsvvYxjnELohdfBiVduIAIx5CV5IxuIHcGeUenv
         luYw==
X-Gm-Message-State: AOAM530TK0pe03pphbiWLyhdh6euPEmhKoCm78PeqPGbJgtXrq0ntKvI
        dqxbYPyLd8gH97YL0+0/4RqnXQ==
X-Google-Smtp-Source: ABdhPJwWshC2o53BvNhQdk0R+5cyozx2c9WuwgLipcJsRxBlRZ8RuYlhCvVs65g9PrFdKEC6fxWuCg==
X-Received: by 2002:a5d:634c:: with SMTP id b12mr10100178wrw.130.1605036682691;
        Tue, 10 Nov 2020 11:31:22 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:22 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 05/30] drm/radeon/cik: Remove set but unused variable 'mc_shared_chmap'
Date:   Tue, 10 Nov 2020 19:30:47 +0000
Message-Id: <20201110193112.988999-6-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/cik.c: In function ‘cik_gpu_init’:
 drivers/gpu/drm/radeon/cik.c:3180:6: warning: variable ‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/cik.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 4494f9122fd91..b94e2e678f255 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3177,7 +3177,7 @@ static void cik_setup_rb(struct radeon_device *rdev,
 static void cik_gpu_init(struct radeon_device *rdev)
 {
 	u32 gb_addr_config = RREG32(GB_ADDR_CONFIG);
-	u32 mc_shared_chmap, mc_arb_ramcfg;
+	u32 mc_arb_ramcfg;
 	u32 hdp_host_path_cntl;
 	u32 tmp;
 	int i, j;
@@ -3270,7 +3270,7 @@ static void cik_gpu_init(struct radeon_device *rdev)
 
 	WREG32(BIF_FB_EN, FB_READ_EN | FB_WRITE_EN);
 
-	mc_shared_chmap = RREG32(MC_SHARED_CHMAP);
+	RREG32(MC_SHARED_CHMAP);
 	mc_arb_ramcfg = RREG32(MC_ARB_RAMCFG);
 
 	rdev->config.cik.num_tile_pipes = rdev->config.cik.max_tile_pipes;
-- 
2.25.1

