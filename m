Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 708D92B4D78
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387517AbgKPRh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgKPRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:52 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D42EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:52 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so372209wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+jve5cvTFEXukD009ehQU3PqTcAXFynBtan2SGSyic=;
        b=CdtQ5VOj6GNmI+pVSbK8iXPk9zYqd+dkBXz0oNCMhVjailBPgrsFVQpacvXB/WYg19
         gzhUcmBF8H+J7KjFL7KvzmoLPoenb9qFD6KVc7PvQU8cBB/snaOKMeK/N/dn7gNjFcfx
         TdsEHf61jmaky/RM1r3Mo2K/0M8AegoDlQ77EXQogA+MkGp7qtoAN2le5QjgqDt6c1lE
         aWyz76mSfCM45dm0sDsun/E22uYtgtiohNphQuWYFfz5xS2MNbbCv1K8xD6jWsQ0SjwN
         AY2o5IrCP1vFjmpfS6VoAVK8OSAw86fyD0GzPWP9cErsWQ9j69lI9JmI7HNDRF9wEfWp
         ZFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+jve5cvTFEXukD009ehQU3PqTcAXFynBtan2SGSyic=;
        b=LYfECIMdgarYBEtafhuusCSO8CbHwUnEs/zrJ5kIggVxWm1InYov1o9svkxYrL02T0
         24P063f251iRWtEBK6b9QLeJK9BJati8I4IUsRMXM4oIhkZehlurKXzlsTf3GPDPmdKd
         HRz2aLfOVAdN+ul0D0ISm8nAAO1wyCivBT8/1keP4QqZtm1hYGcdCs+OXDHArekksNoQ
         EeUtlhFoEB0SxEJIQPy15ZVIdJcc4hENHWVDUdXFoPlh3EjTFTJNpf/W3XmpOdFB4L58
         tLnL+6LQTxJU4OPxppDFOdIBCqXvXk/GchirGQVHD2TbaIsj3wDK2FGFk8p0x8FY0XnP
         QiyQ==
X-Gm-Message-State: AOAM533QquOGjM2ehTL3YKOPzXQI6qB0amWdZxe4pBN66magJtqm4elZ
        75edBBNPtK4PojYKdSU878m8jg==
X-Google-Smtp-Source: ABdhPJy12MNli9kFNIMlRsBrqjU08eIQi0MCmukLruPYo8rtkzJjAmyfaSvOe0YSaJMrspAVUifIkg==
X-Received: by 2002:a1c:96cb:: with SMTP id y194mr21701wmd.62.1605548270778;
        Mon, 16 Nov 2020 09:37:50 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 34/43] drm/radeon/evergreen: Move 'si_get_csb_*()'s prototypes to shared header
Date:   Mon, 16 Nov 2020 17:36:51 +0000
Message-Id: <20201116173700.1830487-35-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173700.1830487-1-lee.jones@linaro.org>
References: <20201116173700.1830487-1-lee.jones@linaro.org>
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
index 8fb0b8c3db5b5..4575e448e59df 100644
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

