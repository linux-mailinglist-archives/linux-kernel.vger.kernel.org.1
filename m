Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065BA2B4D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733163AbgKPRjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732922AbgKPRh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:29 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748DCC0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:29 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id s8so19609432wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3sAihSVFlANjp/LfbWd5zL/9ZHGZH2FRewnW7XCNYU=;
        b=wuVN6YR5ue+Y/uISgXnfR8H9qMOLcDPvVWT7AtX/xKoK5SGxjV+5+Orty+TS2hwVgi
         iG2PbBbT9IP0Rr66YNtfCQre3N4WeP2jH1qGRvoeI3ZXQg9Rp7bAq2FYmlfoS83XvD8U
         8ICEDp6UyqffMQLURawrpOBGpJGejJeONJ1n4BuyGfsre/i7n5QHejXLI1vVvG1IHivT
         y1X8r35U+k3eMDV/t2mhsruyX2gXKmqydP6yrj/uY+q7K5GlD+EjXdFaaSNZJOabuS4M
         IcYW2GFYZ+WMSAYdANBhceWthtfY/WA74coJmUkAzmgdf8FoGeZlQM0wlVDJ7g5lbEvm
         k1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3sAihSVFlANjp/LfbWd5zL/9ZHGZH2FRewnW7XCNYU=;
        b=ji52mfR3rwoGIBVaIATZStTFPiykX6aiBOCF+oMIcOUeiD7Ar7xCFUNmZMfYC+N/Jg
         0izV/zSfqEHykl8cx7XNK/Qem0Vw1niopXyckB5C8H0A5430j4P+7NrM9a0JtngSH3AH
         ku86s1xNEXXJm7IkqnNcmJBDTI8EcDZ+NySyQAvXOwxXZJV3qIl+sGUtCfipLiltnqIG
         bdXr3a+eyqq6S7e8HbveeP4ZhnBV4toTOeai0t+d4Vrvk4RCRoAZ89YyZYMYFjMdgQTD
         Ur58zmbJ+uKSmRympz9Qv0KirpZfo0PMCPpj+XUKmYq24LMnvauZtFTuISeRUTvn9na/
         iokQ==
X-Gm-Message-State: AOAM532aob7G8QvVsQHSHyC2dK2+y3GR2ed8wIdEL94g0U/f8t+ktrTH
        emypIRnBpgh4iGv1mUPhWpWWWw==
X-Google-Smtp-Source: ABdhPJyD73Tg6sPSXW5qxG4OND+YQH7KpeMwDsGUY7+LTErHjdV211BeVdW7YJ7CUI0mZBrtK7a2rA==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr21840157wrq.210.1605548248215;
        Mon, 16 Nov 2020 09:37:28 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:27 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/43] drm/radeon/rv770: Move 'rv770_get_*()'s prototypes to shared header
Date:   Mon, 16 Nov 2020 17:36:35 +0000
Message-Id: <20201116173700.1830487-19-lee.jones@linaro.org>
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
 drivers/gpu/drm/radeon/rv770.h       | 4 ++++
 drivers/gpu/drm/radeon/rv770_dpm.c   | 1 +
 drivers/gpu/drm/radeon/si_dpm.c      | 2 +-
 8 files changed, 11 insertions(+), 11 deletions(-)

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
index a3f2bb44979fe..0e15916d0a948 100644
--- a/drivers/gpu/drm/radeon/rv770.h
+++ b/drivers/gpu/drm/radeon/rv770.h
@@ -29,7 +29,11 @@
 #define __RADEON_RV770_H__
 
 struct radeon_device;
+struct radeon_ps;
 
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

