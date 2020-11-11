Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434882AF841
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgKKShU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgKKSgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:07 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C40CC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:07 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so3478520wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k31TtB+plPHQj7iD5gVHpYef9lXJ4rGnOi0xYl4wuaA=;
        b=ASHzCi9BO6TBGcwRlccGp9W06y8j0wVJwMq49gkz7BHMXS3KXpXkm539aLEiIiT5eV
         3J60SRWROZJ0FT+DPZIgUGeuLIlBzbJ3JgOp3RVGEh3UCM0qSMagRKSiVQlwBRX4N89t
         vB0Ree3UHKnBben9i1q5CR6vQJvd5aYZC1Vbwd6mmNVPgH8nDExSxRuJVBh14GdCW7Yq
         0GuSXBlbu27+niVCWH4gNpovPCq/hwYLR9m9chbHVsUkz/4Wbwssr2FrsBf08bVFdWsM
         NDCSx0uK9ZHg22H6DCkX1XPyX5gUn8DwZt3ayQdLgTk51um7Nb4u1XDE8gltx6Udm44E
         0e2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k31TtB+plPHQj7iD5gVHpYef9lXJ4rGnOi0xYl4wuaA=;
        b=CEdpw+B87SFG+FzMXLRR9l2G/qxPSRVNQRUiv5FIbCPcxREmo0X6+PyNBrBz0mMkaX
         YZ0EjJYWECbNnyJEf9w75inoRfBMIe7+NwGIrhFwGfZAhw/cMibWPlKbQK/VcTsA3NMC
         0K5Upvg5oDU6+TNFfE+vHBMi80gS2pIPEDLhkkdUBMVRPlwzRtsFN7qItTTkYxeYnpaT
         7D251l9WQ+BMBZKB61XrJi0nBgAIiaW85jlInAGGpq6PQx3N73prZA6jSknMj5plcEAr
         hBXuIPiDxYcb8oi3sUP0ulhCMbTGQCoRHnlm3L7aCZHdJ1nIAE9xktrt46LW6lKwbqVN
         VRpg==
X-Gm-Message-State: AOAM530bGxgl7J4iBUDJN48a77GDz6ppqkySggai2+0E6F2KakwKE9aH
        Fbpz65A+3rcCiODOVV7Cgo6BcQ==
X-Google-Smtp-Source: ABdhPJx4N4V4sx7dAlzbxicFql018cJoVgNWMEO73mIRphND5KBdblN4KdUoquQN5qPSW4ezp+XgIg==
X-Received: by 2002:a5d:66c3:: with SMTP id k3mr26422272wrw.123.1605119766309;
        Wed, 11 Nov 2020 10:36:06 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:36:05 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/19] drm/radeon/evergreen: Move 'si_get_csb_*()'s prototypes to shared header
Date:   Wed, 11 Nov 2020 18:35:38 +0000
Message-Id: <20201111183545.1756994-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201111183545.1756994-1-lee.jones@linaro.org>
References: <20201111183545.1756994-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/si.c:5678:5: warning: no previous prototype for ‘si_get_csb_size’ [-Wmissing-prototypes]
 5678 | u32 si_get_csb_size(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/si.c:5710:6: warning: no previous prototype for ‘si_get_csb_buffer’ [-Wmissing-prototypes]
 5710 | void si_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer)
 | ^~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen.c | 3 +--
 drivers/gpu/drm/radeon/si.h        | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 28830f4ef95e3..d8ee80ad4ea44 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -41,6 +41,7 @@
 #include "radeon_asic.h"
 #include "radeon_audio.h"
 #include "radeon_ucode.h"
+#include "si.h"
 
 #define DC_HPDx_CONTROL(x)        (DC_HPD1_CONTROL     + (x * 0xc))
 #define DC_HPDx_INT_CONTROL(x)    (DC_HPD1_INT_CONTROL + (x * 0xc))
@@ -218,8 +219,6 @@ void evergreen_pcie_gen2_enable(struct radeon_device *rdev);
 void evergreen_program_aspm(struct radeon_device *rdev);
 void cik_init_cp_pg_table(struct radeon_device *rdev);
 
-extern u32 si_get_csb_size(struct radeon_device *rdev);
-extern void si_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer);
 extern u32 cik_get_csb_size(struct radeon_device *rdev);
 extern void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer);
 
diff --git a/drivers/gpu/drm/radeon/si.h b/drivers/gpu/drm/radeon/si.h
index f483a64d17050..310c58376f927 100644
--- a/drivers/gpu/drm/radeon/si.h
+++ b/drivers/gpu/drm/radeon/si.h
@@ -32,5 +32,7 @@ u32 si_gpu_check_soft_reset(struct radeon_device *rdev);
 void si_vram_gtt_location(struct radeon_device *rdev, struct radeon_mc *mc);
 void si_rlc_reset(struct radeon_device *rdev);
 void si_init_uvd_internal_cg(struct radeon_device *rdev);
+u32 si_get_csb_size(struct radeon_device *rdev);
+void si_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer);
 
 #endif                         /* __SI_H__ */
-- 
2.25.1

