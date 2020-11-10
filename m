Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906872ADFBB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgKJTbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKJTbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:21 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47566C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:20 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so4310452wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQX81Ctm9sTtgsQoGgQawTW9+eghPr6miXi9Ld6UbB8=;
        b=CmiXRc4v8Kl5jmW2EN11kUgPzLzq6Ark8ALqQCkz7GSbVukMERLz7d42Srtb/5WZf0
         9GGVvNS/FOFrNkCI2tC+GVapoUfn3vxiA/2KGrNqIlUJuTVatDxWbLsoqyjpWdrsxfKw
         2koS0NDXH7HziyogXgW4QacBGKC2Zo4tkuZYo8up3YFUB6bl1jTDN3iWO15YazabMPTo
         GxLWm0N9zlhFo0tAcj5TGPHZF8oyEK5bM96EaQpH7iqLceE5jm8NEMIYaJoLFqSRa8Oy
         iIfkHJ0VjJp+5NAo2Mftgh+iev5UvoFwfRFjqqciW/UHlHutNrL1V9oUVAyVk8sM9Z4F
         zmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQX81Ctm9sTtgsQoGgQawTW9+eghPr6miXi9Ld6UbB8=;
        b=CfsZujVgSg6c+tUu8UUhEtp89bkufdxBrPZMxl4RhVwA6LHe+BpBERm2gYI5T+8KvY
         wIXy8qG4dZPHChS2CLafQlTCrdDjQPf5VcZ9W1LTu/O+sPs5L9+5X9DejAMQDkHJf+xA
         z/6na7vkAFiNO7l1Kw/5H4p5cTh11afXF7YIsmfa3c2IphCruZ2zPb+fFWzs0DlDLTV7
         22nH7WZzUKwmpvSamluSlj5yuIXuE8+VUhn4t+/sQk1UMIsllK03OSjOnef1VgEjIHbs
         p40Kc/fa9zSCWn6MJDIERTnemKL1oWen6twfIovsR7ssUNOvXa9ZLz+P21QqwUmhh0Sg
         Djhw==
X-Gm-Message-State: AOAM532mtoIjKH2iC6T25nTgB6Ej66lLt4kwmcdLzTuHFeOHOcGcQXV2
        TAac5iz58QSUrcSgSnJGbfpjmw==
X-Google-Smtp-Source: ABdhPJyo1saJykBWBcugWCd9fSt0sIUSOPTzL4VrP0JyyLveR/RMfi+hE/k2HljcYsPVsoensWKyoA==
X-Received: by 2002:a1c:b041:: with SMTP id z62mr712398wme.183.1605036679051;
        Tue, 10 Nov 2020 11:31:19 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:18 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/30] drm/radeon/evergreen: Remove set but unused variable 'mc_shared_chmap'
Date:   Tue, 10 Nov 2020 19:30:44 +0000
Message-Id: <20201110193112.988999-3-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/evergreen.c: In function ‘evergreen_gpu_init’:
 drivers/gpu/drm/radeon/evergreen.c:3135:6: warning: variable ‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index c9a9a87959f9e..efb19c445e48f 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -3135,7 +3135,7 @@ static int evergreen_cp_resume(struct radeon_device *rdev)
 static void evergreen_gpu_init(struct radeon_device *rdev)
 {
 	u32 gb_addr_config;
-	u32 mc_shared_chmap, mc_arb_ramcfg;
+	u32 mc_arb_ramcfg;
 	u32 sx_debug_1;
 	u32 smx_dc_ctl0;
 	u32 sq_config;
@@ -3399,7 +3399,7 @@ static void evergreen_gpu_init(struct radeon_device *rdev)
 
 	evergreen_fix_pci_max_read_req_size(rdev);
 
-	mc_shared_chmap = RREG32(MC_SHARED_CHMAP);
+	RREG32(MC_SHARED_CHMAP);
 	if ((rdev->family == CHIP_PALM) ||
 	    (rdev->family == CHIP_SUMO) ||
 	    (rdev->family == CHIP_SUMO2))
-- 
2.25.1

