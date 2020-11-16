Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D512B4D84
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbgKPRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbgKPRhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:51 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B2EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so19605523wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQLiBxHM+lzm9ozhMmLXV+2+mYaIBz41oWImWz9w9hM=;
        b=rDoz2LODwdktvJ9Y9EB13KeCm6PWI+1JaZSHYfxn0zExBSUAYcFF3Lk6Ktpw5Vwga8
         aL0QXnr6CBahNfjRD5G4eKtK79HrTR4hmKiITJdzXnS0ED9XlTb2mt0hJeqqOcBwxmeR
         05rnsgHtTUluKUDpP5sJhTd0r20O3S6oLrlgydUWSzxOQfL7knsKgSvaji3bHKLYTqHJ
         FvK5gDN2dVmttG7hb8l5OFk80iq7QiJ3jDsFhiGAEhryWjHOc+L4L2KVW/kUCftYR/yE
         MVyBHd1SJt/+YU3LZD24rx8hHt80lCb5WQ4tsk9PtPfzNzGI51M7c/IeZIR5U+Y2eTem
         nWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQLiBxHM+lzm9ozhMmLXV+2+mYaIBz41oWImWz9w9hM=;
        b=QtqdVI29eLkExlnsxRa9ey6ztRpFO+PnjKXN65vJINlU5utDQIPqb5XFGrcrnsC1DF
         85DC+nMyuMYoJqErQ+BxRB+ThCF+vXJZhukb1hPJR9EL0ZGxTFwAjSHYnUPUc9J4SXg4
         ZgSyl7MeEZLiqtBhLDc6FzUmL3Rnqc49wRhVKf9snQm/dr9UUK2W2hNtWPqTr75m1mrp
         t+CfNE8kRgDM/Gv45jNewf25XE/FCak7g5S5rv3H0s04RmPZXP2OojAKkwEmYxvOWray
         JxpLKaH2MGInVhRK/8rgyMiTrD2aI4nJK9u543r7qi8fry1beCDasq7BWzSijnusQpVb
         3j2A==
X-Gm-Message-State: AOAM530HFIPWmggf70fD/A1UPSgOIgVAvcRLmpsDHX7Slw6bF/H8LiwP
        pWkOui9ExiMHwO2JwJ2fZhtfzg==
X-Google-Smtp-Source: ABdhPJxCpzwe4imCzFW0TzeoW/NB4Uovt0DLHrE/wNPjb+bT45c82Lf7bTQCIN3A11qDyKVlyg1sQw==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr20141378wrv.243.1605548268198;
        Mon, 16 Nov 2020 09:37:48 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 32/43] drm/radeon/btc_dpm: Move 'evergreen_get_pi's prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:49 +0000
Message-Id: <20201116173700.1830487-33-lee.jones@linaro.org>
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

