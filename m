Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F4A2B4D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733298AbgKPRhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733233AbgKPRhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:31 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F05C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:30 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o15so19634918wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uPrx+xhJSBB8cqNRTfRxpV861JL0F49FY7TxVtUc7KQ=;
        b=u31O7pj1zGDcrio/FSlsCBviO7IM8g6lQEnTygECI/nuOgTKY4r0NhHol9iTNLGAn+
         zdLph8fd3Yuh5ALkDKEgxnNG18QYa0bsD7qhmJeuL69Mb72Gr7aBgJip239aK5NAxjs8
         bwmKEWSGIl80oReFzD5dPK4o61T22DBvKtr/Ld97VBLSmDf/T7Qe49a2nsurDTjVNSSP
         d45/vKLH6geRF9spJ2Zzz9ibSFfV7qMS1hWPotwBvP0TCMhLJL+wYrqQCZ9jAz3ZAxka
         tQniI5JB4SFW/5S3t/97fz3dr+LiWmC/rvEilaMRA/NEEYJvS1K5XYJQ4LeiDkKq7xyr
         uBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uPrx+xhJSBB8cqNRTfRxpV861JL0F49FY7TxVtUc7KQ=;
        b=GBWNW1aj7QHSeHglaUD6Zu4w1IZjJu/vu7kjsexzAOZgeANBwENAFh209LE5hG6GTr
         RXWs05maOPxgg/vIzg0QZbCLrAJvrDQt0sPSj2Odsn9xzsewFfOnGLrGtN5b5FdjmQUr
         mYs4erBeoKEZHA+thFWcoL1TW/lC9kwJU3QimJW9n+EyWp5qjfhngye8ZcIwe8GvR/7F
         KQJiLVk4pFKoPwH2UboHs2eVNbcfy89yUNPsAN+nMbnk25NMHe5IS/99Xu8rM8HAywuZ
         tbnySABusL3IDccZutYGRZqIhJLoCmh7tl+Tjl3NZ8Yimcda72dv3A7Ju+KdqvZ4H+0q
         +2RQ==
X-Gm-Message-State: AOAM530JZEJtzxlZq0E6COrW+qFxweJFUzT87uEyO+bNGwKVPMhHKjuv
        cYiUK/cBqBwnzGmSt6xUrxFohQ==
X-Google-Smtp-Source: ABdhPJzCHDkei2JEkX1GB2GW8T/eLFBIz2InwIuHUVRCrc6XXSR/icg3z1DWHJMy3glbmKvXNjAaew==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr20117035wrq.236.1605548249538;
        Mon, 16 Nov 2020 09:37:29 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/43] drm/radeon/ni_dpm: Move 'ni_get_{pi,ps}()'s into shared header
Date:   Mon, 16 Nov 2020 17:36:36 +0000
Message-Id: <20201116173700.1830487-20-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/ni_dpm.c:727:23: warning: no previous prototype for ‘ni_get_pi’ [-Wmissing-prototypes]
 727 | struct ni_power_info *ni_get_pi(struct radeon_device *rdev)
 | ^~~~~~~~~
 drivers/gpu/drm/radeon/ni_dpm.c:734:15: warning: no previous prototype for ‘ni_get_ps’ [-Wmissing-prototypes]
 734 | struct ni_ps *ni_get_ps(struct radeon_ps *rps)
 | ^~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/ni_dpm.h | 3 +++
 drivers/gpu/drm/radeon/si_dpm.c | 3 +--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni_dpm.h b/drivers/gpu/drm/radeon/ni_dpm.h
index 6bbee9180909e..74e3019369063 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.h
+++ b/drivers/gpu/drm/radeon/ni_dpm.h
@@ -247,4 +247,7 @@ void ni_set_uvd_clock_after_set_eng_clock(struct radeon_device *rdev,
 
 bool ni_dpm_vblank_too_short(struct radeon_device *rdev);
 
+struct ni_power_info *ni_get_pi(struct radeon_device *rdev);
+struct ni_ps *ni_get_ps(struct radeon_ps *rps);
+
 #endif
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index a80a21447a76d..c68ab2fb1ac23 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -30,6 +30,7 @@
 #include "rv770.h"
 #include "radeon.h"
 #include "radeon_asic.h"
+#include "ni_dpm.h"
 #include "si_dpm.h"
 #include "sid.h"
 
@@ -1719,8 +1720,6 @@ static const struct si_powertune_data powertune_data_hainan =
 };
 
 struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
-struct ni_power_info *ni_get_pi(struct radeon_device *rdev);
-struct ni_ps *ni_get_ps(struct radeon_ps *rps);
 
 extern int si_mc_load_microcode(struct radeon_device *rdev);
 extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable);
-- 
2.25.1

