Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9722AF82B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKKSgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:36:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgKKSgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:05 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5B7C0617A7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:04 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so3503071wrl.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQLiBxHM+lzm9ozhMmLXV+2+mYaIBz41oWImWz9w9hM=;
        b=NJd73JO8AhCRjn0Dimt7Zx7LwVzjPfPvz0Q7de5mm4lbH4VN3T9g5lqmYSLnuOF9tu
         b28psdPSe3h3rvZaBt6PTzgVQlcTjC6+q9zysQzBn/Izo1sivArJskR3h6+W5zQqrLa0
         LFAPYjhnNOTSf2/p6AQo5OVfp0ojT9L2+od3s3nAMfOSZsGqOfw9gmWL7zEnvuWwWI4a
         zqh5I2d5C5qjcMsxvkOLggAj3Rh1DmaXOu7qWzqL3YnsRGfm6+foHZpFoeOd0lXZkJKu
         dC2Ymmsle3SOm4Qp4Gqmx549kx5S+59K92JhnUPnMXR3Udq1Qy1LtxUVQOk6+1d4O5FK
         w+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQLiBxHM+lzm9ozhMmLXV+2+mYaIBz41oWImWz9w9hM=;
        b=Qe5S78KaOEKGfXxhNX8sEXc2CranUQvSKbYm5kKLlkt45VaUytwJBQ+nL3oQ1o+Kwj
         AG2nJTrtsOmwrjLZqidux/SussGIE9AfZIHGPKfodwAkRza+SV4Fs6bLNrHwcN8LuKyD
         yGYw9HDrpQSabRK8f+G0+cGN8gqni+MIkhyKOWNTUDofnmSH80HCCMtDpvOZEzFZTqYy
         Dca1uCpu9aJECG8FOusBLYyxmZ0r0uT3zN4IagmdPi8dBh8XEk8tp9M+je6PUtVwW27C
         1brKWcwfuH6k/WCdvoUA/Y7LEHWpWZN6HUMNj8nh4+My44SxZgNCgdvJ9+eZXH2/sFFi
         SmTA==
X-Gm-Message-State: AOAM532gBdSXz5mQx3SopVI0Q1vcC43XyiKXttCv+w80EviP/Xc0nwRs
        ED1cJiedXq079OZLYfcTgS+KlA==
X-Google-Smtp-Source: ABdhPJwY6/aV6pBsNp4c+ohQJAqJxH/R+uzFqEOGSkHFqmIKkn6EQjgjq9FqJEpKfV6tLzSXVde6CA==
X-Received: by 2002:a5d:654a:: with SMTP id z10mr9037894wrv.285.1605119763560;
        Wed, 11 Nov 2020 10:36:03 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:36:02 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 10/19] drm/radeon/btc_dpm: Move 'evergreen_get_pi's prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:36 +0000
Message-Id: <20201111183545.1756994-11-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/rv770_dpm.c:62:30: warning: no previous prototype for ‘evergreen_get_pi’ [-Wmissing-prototypes]
 62 | struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/btc_dpm.c     | 3 +--
 drivers/gpu/drm/radeon/cypress_dpm.c | 3 +--
 drivers/gpu/drm/radeon/evergreen.h   | 2 ++
 drivers/gpu/drm/radeon/ni_dpm.c      | 3 +--
 drivers/gpu/drm/radeon/rv770_dpm.c   | 1 +
 drivers/gpu/drm/radeon/si_dpm.c      | 3 +--
 6 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/btc_dpm.c b/drivers/gpu/drm/radeon/btc_dpm.c
index 018949668536e..4e64ed38c439f 100644
--- a/drivers/gpu/drm/radeon/btc_dpm.c
+++ b/drivers/gpu/drm/radeon/btc_dpm.c
@@ -29,6 +29,7 @@
 #include "btc_dpm.h"
 #include "btcd.h"
 #include "cypress_dpm.h"
+#include "evergreen.h"
 #include "r600_dpm.h"
 #include "rv770.h"
 #include "radeon.h"
@@ -49,8 +50,6 @@
 #ifndef BTC_MGCG_SEQUENCE
 #define BTC_MGCG_SEQUENCE  300
 
-struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
-
 extern int ni_mc_load_microcode(struct radeon_device *rdev);
 
 //********* BARTS **************//
diff --git a/drivers/gpu/drm/radeon/cypress_dpm.c b/drivers/gpu/drm/radeon/cypress_dpm.c
index 6d3690bcca2d2..fdddbbaecbb74 100644
--- a/drivers/gpu/drm/radeon/cypress_dpm.c
+++ b/drivers/gpu/drm/radeon/cypress_dpm.c
@@ -26,6 +26,7 @@
 
 #include "atom.h"
 #include "cypress_dpm.h"
+#include "evergreen.h"
 #include "evergreend.h"
 #include "r600_dpm.h"
 #include "rv770.h"
@@ -44,8 +45,6 @@
 #define MC_CG_SEQ_YCLK_SUSPEND      0x04
 #define MC_CG_SEQ_YCLK_RESUME       0x0a
 
-struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
-
 static void cypress_enable_bif_dynamic_pcie_gen2(struct radeon_device *rdev,
 						 bool enable)
 {
diff --git a/drivers/gpu/drm/radeon/evergreen.h b/drivers/gpu/drm/radeon/evergreen.h
index f8d772e612a48..a829deb8b078a 100644
--- a/drivers/gpu/drm/radeon/evergreen.h
+++ b/drivers/gpu/drm/radeon/evergreen.h
@@ -29,6 +29,7 @@
 #define __RADEON_EVERGREEN_H__
 
 struct evergreen_mc_save;
+struct evergreen_power_info;
 struct radeon_device;
 
 bool evergreen_is_display_hung(struct radeon_device *rdev);
@@ -49,5 +50,6 @@ u32 evergreen_get_number_of_dram_channels(struct radeon_device *rdev);
 void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
 u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev);
 int evergreen_rlc_resume(struct radeon_device *rdev);
+struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
 
 #endif				/* __RADEON_EVERGREEN_H__ */
diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index d39bbd9793cc2..dd5ef64937230 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -26,6 +26,7 @@
 #include <linux/seq_file.h>
 
 #include "atom.h"
+#include "evergreen.h"
 #include "ni_dpm.h"
 #include "nid.h"
 #include "r600_dpm.h"
@@ -720,8 +721,6 @@ static const u32 cayman_sysls_enable[] =
 };
 #define CAYMAN_SYSLS_ENABLE_LENGTH sizeof(cayman_sysls_enable) / (3 * sizeof(u32))
 
-struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
-
 extern int ni_mc_load_microcode(struct radeon_device *rdev);
 
 struct ni_power_info *ni_get_pi(struct radeon_device *rdev)
diff --git a/drivers/gpu/drm/radeon/rv770_dpm.c b/drivers/gpu/drm/radeon/rv770_dpm.c
index badd8ac6e038f..ef2f1a048cfed 100644
--- a/drivers/gpu/drm/radeon/rv770_dpm.c
+++ b/drivers/gpu/drm/radeon/rv770_dpm.c
@@ -30,6 +30,7 @@
 #include "rv770_dpm.h"
 #include "cypress_dpm.h"
 #include "atom.h"
+#include "evergreen.h"
 #include <linux/seq_file.h>
 
 #define MC_CG_ARB_FREQ_F0           0x0a
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index 32b697965c064..b4581392fbce9 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -26,6 +26,7 @@
 #include <linux/seq_file.h>
 
 #include "atom.h"
+#include "evergreen.h"
 #include "r600_dpm.h"
 #include "rv770.h"
 #include "radeon.h"
@@ -1720,8 +1721,6 @@ static const struct si_powertune_data powertune_data_hainan =
 	true
 };
 
-struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
-
 extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable);
 
 static int si_populate_voltage_value(struct radeon_device *rdev,
-- 
2.25.1

