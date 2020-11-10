Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F962ADF77
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbgKJTbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731962AbgKJTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:47 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790E6C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:47 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so4342647wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O9D4sdvgAf5ZpmG7WRKhdhcXCgCIe69NPhgbZH8YPLo=;
        b=KiUNDt1pIPZZdeRHH1IiNfbpdTZZJAixesDx6gTVlmC1kGISYte/3HPinHflWMH2aO
         rsw3FijzmVrzqK/ILIpm4YSAHvaeH0pKDB2gN92IM3Dsg8Qvdzf98TvkbvsHwCC6ym3e
         wJP5RtOIZw61M7EuzVDDUNViEk5jCpEZH1A6OY/R+NNhWE1pYiIpNyXs2xfPWw/0ryii
         z8iFLtGtnhL8rsZXzUMAM3JERcT2SdMImNQOXfW0y6jU7GgYSIY8kTA2/hzAO4xz9k2j
         QB7UsJp8g9Rn8ujubUuBo+UfsphKn1UcA8KgZQjdh8XjizsnIlCP6jGGFwyV/jcC4VQo
         9GFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O9D4sdvgAf5ZpmG7WRKhdhcXCgCIe69NPhgbZH8YPLo=;
        b=F/sRxcE5wWQrHkv1mdGC9sdHtrkqpSBGUoxl260iO//EIQWiIUn3nKFHnL09WLSOX+
         W4tgZTwc8k6jlc3cq2PkKAJZJiRa/S/+7y0pRvdkHl+F4COtzk5x0GiS6UQBgCk4zX2u
         PWyNxPIEoufTxpAdF316o68HlJzYnIbYsavbzoEjKsEAmfaxVMUygInCN4ppDzpFDjqS
         XCmhmkN1TncCfg319teGxEoebcszk+dtD2rHLkNRNxFM7Y40Hh4ZRItv71uNo4SpISQU
         THdGy5A4Mh2YR4Yb8puAqkFq4OfdBCqpC9a9r39yOPXUTObSB3EFUl/alharLVsq8EkZ
         rGjQ==
X-Gm-Message-State: AOAM530yZ3nhH9KQE3PQApkUJxJtSP7yaNorqzbz+O9rbPvKUIgSG7lL
        xN6JIiry/2TVzqjl6YbV92q2hQ==
X-Google-Smtp-Source: ABdhPJzF41hR67Ro9bIuTul3C4tQ6M2lToJxdhe+VnMm4DqKNLxUkvF73+aC+ssnbVkfOuIidK0vjA==
X-Received: by 2002:a1c:190:: with SMTP id 138mr667479wmb.113.1605036706165;
        Tue, 10 Nov 2020 11:31:46 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:45 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 24/30] drm/radeon/rv770: Move 'rv770_get_*()'s prototypes to shared header
Date:   Tue, 10 Nov 2020 19:31:06 +0000
Message-Id: <20201110193112.988999-25-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/rv770_dpm.c:47:18: warning: no previous prototype for ‘rv770_get_ps’ [-Wmissing-prototypes]
 47 | struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps)
 | ^~~~~~~~~~~~
 drivers/gpu/drm/radeon/rv770_dpm.c:54:26: warning: no previous prototype for ‘rv770_get_pi’ [-Wmissing-prototypes]
 54 | struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev)
 | ^~~~~~~~~~~~

Cc: Evan Quan <evan.quan@amd.com>
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
 drivers/gpu/drm/radeon/ni_dpm.c      | 2 +-
 drivers/gpu/drm/radeon/rv730_dpm.c   | 4 +---
 drivers/gpu/drm/radeon/rv740_dpm.c   | 3 +--
 drivers/gpu/drm/radeon/rv770.h       | 5 +++++
 drivers/gpu/drm/radeon/rv770_dpm.c   | 1 +
 drivers/gpu/drm/radeon/si_dpm.c      | 2 +-
 8 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/radeon/btc_dpm.c b/drivers/gpu/drm/radeon/btc_dpm.c
index d1d8aaf8323c2..018949668536e 100644
--- a/drivers/gpu/drm/radeon/btc_dpm.c
+++ b/drivers/gpu/drm/radeon/btc_dpm.c
@@ -30,6 +30,7 @@
 #include "btcd.h"
 #include "cypress_dpm.h"
 #include "r600_dpm.h"
+#include "rv770.h"
 #include "radeon.h"
 #include "radeon_asic.h"
 
@@ -48,8 +49,6 @@
 #ifndef BTC_MGCG_SEQUENCE
 #define BTC_MGCG_SEQUENCE  300
 
-struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps);
-struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
 struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
 
 extern int ni_mc_load_microcode(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/cypress_dpm.c b/drivers/gpu/drm/radeon/cypress_dpm.c
index 35b177d777913..6d3690bcca2d2 100644
--- a/drivers/gpu/drm/radeon/cypress_dpm.c
+++ b/drivers/gpu/drm/radeon/cypress_dpm.c
@@ -28,6 +28,7 @@
 #include "cypress_dpm.h"
 #include "evergreend.h"
 #include "r600_dpm.h"
+#include "rv770.h"
 #include "radeon.h"
 #include "radeon_asic.h"
 
@@ -43,8 +44,6 @@
 #define MC_CG_SEQ_YCLK_SUSPEND      0x04
 #define MC_CG_SEQ_YCLK_RESUME       0x0a
 
-struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps);
-struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
 struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
 
 static void cypress_enable_bif_dynamic_pcie_gen2(struct radeon_device *rdev,
diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_dpm.c
index 59cdadcece159..d39bbd9793cc2 100644
--- a/drivers/gpu/drm/radeon/ni_dpm.c
+++ b/drivers/gpu/drm/radeon/ni_dpm.c
@@ -29,6 +29,7 @@
 #include "ni_dpm.h"
 #include "nid.h"
 #include "r600_dpm.h"
+#include "rv770.h"
 #include "radeon.h"
 #include "radeon_asic.h"
 
@@ -719,7 +720,6 @@ static const u32 cayman_sysls_enable[] =
 };
 #define CAYMAN_SYSLS_ENABLE_LENGTH sizeof(cayman_sysls_enable) / (3 * sizeof(u32))
 
-struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
 struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
 
 extern int ni_mc_load_microcode(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/rv730_dpm.c b/drivers/gpu/drm/radeon/rv730_dpm.c
index 84a3d6d724866..a9de5c953396a 100644
--- a/drivers/gpu/drm/radeon/rv730_dpm.c
+++ b/drivers/gpu/drm/radeon/rv730_dpm.c
@@ -25,6 +25,7 @@
 #include "radeon.h"
 #include "rv730d.h"
 #include "r600_dpm.h"
+#include "rv770.h"
 #include "rv770_dpm.h"
 #include "atom.h"
 
@@ -33,9 +34,6 @@
 #define MC_CG_ARB_FREQ_F2           0x0c
 #define MC_CG_ARB_FREQ_F3           0x0d
 
-struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps);
-struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
-
 int rv730_populate_sclk_value(struct radeon_device *rdev,
 			      u32 engine_clock,
 			      RV770_SMC_SCLK_VALUE *sclk)
diff --git a/drivers/gpu/drm/radeon/rv740_dpm.c b/drivers/gpu/drm/radeon/rv740_dpm.c
index 327d65a76e1f4..d57a3e1df8d63 100644
--- a/drivers/gpu/drm/radeon/rv740_dpm.c
+++ b/drivers/gpu/drm/radeon/rv740_dpm.c
@@ -25,11 +25,10 @@
 #include "radeon.h"
 #include "rv740d.h"
 #include "r600_dpm.h"
+#include "rv770.h"
 #include "rv770_dpm.h"
 #include "atom.h"
 
-struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
-
 u32 rv740_get_decoded_reference_divider(u32 encoded_ref)
 {
 	u32 ref = 0;
diff --git a/drivers/gpu/drm/radeon/rv770.h b/drivers/gpu/drm/radeon/rv770.h
index de831684c9926..cf234d59f0475 100644
--- a/drivers/gpu/drm/radeon/rv770.h
+++ b/drivers/gpu/drm/radeon/rv770.h
@@ -28,6 +28,11 @@
 #ifndef __RADEON_RV770_H__
 #define __RADEON_RV770_H__
 
+struct radeon_ps;
+
 void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
 
+struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps);
+struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
+
 #endif				/* __RADEON_RV770_H__ */
diff --git a/drivers/gpu/drm/radeon/rv770_dpm.c b/drivers/gpu/drm/radeon/rv770_dpm.c
index 4a0cf597c11c6..badd8ac6e038f 100644
--- a/drivers/gpu/drm/radeon/rv770_dpm.c
+++ b/drivers/gpu/drm/radeon/rv770_dpm.c
@@ -24,6 +24,7 @@
 
 #include "radeon.h"
 #include "radeon_asic.h"
+#include "rv770.h"
 #include "rv770d.h"
 #include "r600_dpm.h"
 #include "rv770_dpm.h"
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index d1c73e9db889a..a80a21447a76d 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -27,6 +27,7 @@
 
 #include "atom.h"
 #include "r600_dpm.h"
+#include "rv770.h"
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "si_dpm.h"
@@ -1717,7 +1718,6 @@ static const struct si_powertune_data powertune_data_hainan =
 	true
 };
 
-struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
 struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
 struct ni_power_info *ni_get_pi(struct radeon_device *rdev);
 struct ni_ps *ni_get_ps(struct radeon_ps *rps);
-- 
2.25.1

