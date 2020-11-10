Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A212ADF5D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgKJTb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731574AbgKJTbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:24 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CCBC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:22 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so4311406wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=StAAQEcBU7NR52Iv4O4K3Wzt60gqSmLeuRfVm5ltXDE=;
        b=mZZml1jytN4/9i59YihQPrNuAaWkUZdpVAXKmHE+4/4U0iTDxxXftQINnq5G5KzB7G
         YesRLVtr9cgChuzabdGh9KH2EuSxiXVqGIXVcVPQt0PXeGOfgTM5dOjXbabrkCeznPMS
         M/oG817gEvJDwb4E3oJv+VQi0vnLJ71+SwUju8DAErlpIANOm0L3QGER585yKxQzU2Sf
         ebwUEsuVFPKaXemnBJXXnWktrStj7pS8IV4rj3r73hdlRkZN+oQgb3LOacCljFAfP4Mj
         WTSoGT13avpp4RioJ2BY4M491H5h2fw29JW0vttsqLYfbm7NEnYd57MfEAr1ELF2pGoA
         MX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=StAAQEcBU7NR52Iv4O4K3Wzt60gqSmLeuRfVm5ltXDE=;
        b=i8k98KUqAP8cxxrdhFAT2EU9Z+BuyZtY7v5ZBs7K2Tn5taLq+I0Tm2hdwo1aOncyvH
         ycJcXL1baIGTxeN4EO7i1sZ6IYb4lvK3oV5oGrPQflmWGiFL25yAbGLCHoaCjYNCutwr
         2T3hV3SE93t1WgAn7rfM28dMIR/qwZ76qlUQx9OKs2RnW/2bpU2z+17EBJnc3w5gYyiJ
         5nCbXO4lKoFGQlNJ8QilwUlQl6CmhC005fsXTAA3esMr3okGGPRwSkFofL7gDF/NgiOD
         r2L4EMOawqlg1CkRm5iruI2Vg2aK9MSmgdCWvTTmu2MB6bXNoHnaAaX11OpomQmVBVwX
         McIQ==
X-Gm-Message-State: AOAM530g0ayZ7BTvulqNVlWRqxnwsf34pMY6XioGIn0pUvem1ZCelgwE
        5VOOvYeM1ypj/MZm/OSqWpru6g==
X-Google-Smtp-Source: ABdhPJygMM2wHpSm/z5nOffXXW1qdVFhGsZ9Tt9PjrxCds2cWRaFqtX2RLwd7EtuOhsFgrpLiAq/TQ==
X-Received: by 2002:a1c:7c02:: with SMTP id x2mr717105wmc.64.1605036681441;
        Tue, 10 Nov 2020 11:31:21 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:20 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/30] drm/radeon/si: Remove set but unused variable 'mc_shared_chmap'
Date:   Tue, 10 Nov 2020 19:30:46 +0000
Message-Id: <20201110193112.988999-5-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/si.c: In function ‘si_gpu_init’:
 drivers/gpu/drm/radeon/si.c:3090:6: warning: variable ‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/si.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index c27af89785f34..45076c27d7ded 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -3088,7 +3088,7 @@ static void si_setup_rb(struct radeon_device *rdev,
 static void si_gpu_init(struct radeon_device *rdev)
 {
 	u32 gb_addr_config = 0;
-	u32 mc_shared_chmap, mc_arb_ramcfg;
+	u32 mc_arb_ramcfg;
 	u32 sx_debug_1;
 	u32 hdp_host_path_cntl;
 	u32 tmp;
@@ -3200,7 +3200,7 @@ static void si_gpu_init(struct radeon_device *rdev)
 
 	WREG32(BIF_FB_EN, FB_READ_EN | FB_WRITE_EN);
 
-	mc_shared_chmap = RREG32(MC_SHARED_CHMAP);
+	RREG32(MC_SHARED_CHMAP);
 	mc_arb_ramcfg = RREG32(MC_ARB_RAMCFG);
 
 	rdev->config.si.num_tile_pipes = rdev->config.si.max_tile_pipes;
-- 
2.25.1

