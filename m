Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85802B4D79
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387526AbgKPRiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387484AbgKPRh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:56 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738AC0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:55 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o15so19637334wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcR9SHA/hLxAo0DjnBJYKl1ZjLgHXt+Q6E2OPcU6TRk=;
        b=PD4ZgQMZc0zjxIrjINFoGLWFLiD9nsqe4m09WvxLwc4lK/OJwqcl5NM9CfB8miTxhp
         Ma93beNUf5CGer5yi6sN7aNsLZu1pCUWwPYqHrTOqtltVJK83S07N/Fvy8cKqs6Gcfx5
         c6bIztFZ+QB2VhosEON3sfBHv3qhI9uuGnATdpU6Kl/EM2ygpRSqP4897TFPba5AKPcj
         V3jxwH4MpFQ8oIxWWM1toY80XO3Pe3eg05EXLZwswlr16Q1UFVnIX62o7aru7zSO+mD2
         sCXBU6nZp6xSyAagvnTd8yKWIPJZzi0EW//O9VhlehDylZjokCG2Hsas/zDUJN1nh8SB
         ekDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcR9SHA/hLxAo0DjnBJYKl1ZjLgHXt+Q6E2OPcU6TRk=;
        b=EImmxv8VjPUi79/Db2K13mzVQXaUEKQNK8yx9lrCuNZOsbAsi7oEcRe7E9DvB5Xgqg
         gk8QJEF+kOHBOq0HM8s7V5kEF03YddsX3Po1vOks+cylO+MHAilyoS8MguDSnjwWgOfc
         oLIUm3UaItBFrvGwudWoEUs+ze/n0UFkHp+dqhxlQ/RK8K0bj/gDNqlasGOnIT+UMq1V
         sz5PDlQD8fREjXlFfdfJGlal0IHn/D0bdMr7wd+6rBhBnoKipMdmdc1kZpi0h2N6KNiv
         zdyhhmIjAFL/VfO2bE9aCOBRkuHMYwfvwVZNk4hBHv0HB4rWdSu1hr9zHdFt5A0lEjuD
         VoGw==
X-Gm-Message-State: AOAM530wJfcWf5gRXVO7WV3djiZRplAOnXu396DjN0pyLBodG5ToVG21
        I3Prbadj5n0n3IkUJtuWgYR2vw==
X-Google-Smtp-Source: ABdhPJxvfA9lwqfWGkqjGiyJLV87fl0kCzlW8nO3dkzHqjHgQ3TGj2I2Y/FSm1mKoTJJN3k/a/XjDg==
X-Received: by 2002:adf:b74d:: with SMTP id n13mr3638294wre.101.1605548274459;
        Mon, 16 Nov 2020 09:37:54 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 37/43] drm/radeon/ci_dpm: Move 'si_*()'s prototypes to shared header
Date:   Mon, 16 Nov 2020 17:36:54 +0000
Message-Id: <20201116173700.1830487-38-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/si_dpm.c:3802:4: warning: no previous prototype for ‘si_get_ddr3_mclk_frequency_ratio’ [-Wmissing-prototypes]
 3802 | u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/si_dpm.c:3815:4: warning: no previous prototype for ‘si_get_mclk_frequency_ratio’ [-Wmissing-prototypes]
 3815 | u8 si_get_mclk_frequency_ratio(u32 memory_clock, bool strobe_mode)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/si_dpm.c:3897:6: warning: no previous prototype for ‘si_trim_voltage_table_to_fit_state_table’ [-Wmissing-prototypes]
 3897 | void si_trim_voltage_table_to_fit_state_table(struct radeon_device *rdev,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/ci_dpm.c | 6 +-----
 drivers/gpu/drm/radeon/si_dpm.h | 5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index a9fc0a552736c..0dfb0ed9af89d 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -33,6 +33,7 @@
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_ucode.h"
+#include "si_dpm.h"
 
 #define MC_CG_ARB_FREQ_F0           0x0a
 #define MC_CG_ARB_FREQ_F1           0x0b
@@ -153,11 +154,6 @@ static const struct ci_pt_config_reg didt_config_ci[] =
 extern u8 rv770_get_memory_module_index(struct radeon_device *rdev);
 extern int ni_copy_and_switch_arb_sets(struct radeon_device *rdev,
 				       u32 arb_freq_src, u32 arb_freq_dest);
-extern u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock);
-extern u8 si_get_mclk_frequency_ratio(u32 memory_clock, bool strobe_mode);
-extern void si_trim_voltage_table_to_fit_state_table(struct radeon_device *rdev,
-						     u32 max_voltage_steps,
-						     struct atom_voltage_table *voltage_table);
 static int ci_get_std_voltage_value_sidd(struct radeon_device *rdev,
 					 struct atom_voltage_table_entry *voltage_table,
 					 u16 *std_voltage_hi_sidd, u16 *std_voltage_lo_sidd);
diff --git a/drivers/gpu/drm/radeon/si_dpm.h b/drivers/gpu/drm/radeon/si_dpm.h
index 1032a68be792b..aa857906ef93d 100644
--- a/drivers/gpu/drm/radeon/si_dpm.h
+++ b/drivers/gpu/drm/radeon/si_dpm.h
@@ -234,5 +234,10 @@ struct si_power_info {
 #define SISLANDS_CGULVPARAMETER_DFLT                    0x00040035
 #define SISLANDS_CGULVCONTROL_DFLT                      0x1f007550
 
+u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock);
+u8 si_get_mclk_frequency_ratio(u32 memory_clock, bool strobe_mode);
+void si_trim_voltage_table_to_fit_state_table(struct radeon_device *rdev,
+					      u32 max_voltage_steps,
+					      struct atom_voltage_table *voltage_table);
 
 #endif
-- 
2.25.1

