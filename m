Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C63B2AF83C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgKKShA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgKKSgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:12 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F15C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:11 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so3269163wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wcR9SHA/hLxAo0DjnBJYKl1ZjLgHXt+Q6E2OPcU6TRk=;
        b=ZppS/pPTRTgdttLh54xP750Kj6wz+Skcp0gIoIgehdUbqo2zKnEjGa/yiqC1zsRVT1
         RojNDkdIIOVwEH/cxzrfw4IzVBy+MNQX717cjqzVcQD/DhZ7iqciX6SM6vWljUD9C7vy
         INmw17RivPboOAMS7Evvldk4WAubEVgS4S/nkTyULsmgnbzDLjGxfJfy+SxvxwbIOBkd
         Z8BJJPyj9Xo5ParXgCKw1BIgyM1MPmCqIDQXge0PR3SNWPVIVb1bugXxBYfp9WDf+xld
         Hhidwk+ywKJksPFcW9w+HUDn2U5kjpbYCXXweJoLxXkIhKaCfiQqoIVuzgh6iYP2RRo0
         amRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wcR9SHA/hLxAo0DjnBJYKl1ZjLgHXt+Q6E2OPcU6TRk=;
        b=V1tV9c2F3p56x9Fu9QCTKymyS3UVbR9wY/9BG4G4BGEZLm80hEuH/UFxt7v4EN1i3S
         OhR9IJeeIDGsr/tlMH0NEl8txmq8cW1tmXALGSGnnueZgDjdYyL3xxS2dkNifeFCx6Nc
         FHMnYiC6Z+VYhsWI9ecomyWhfnAwp+0e7Z2Ew4eV71mywYtZNoxn7KbindmchBixeN3B
         64vWbMF6afs+BgfBdN0QAhufojdNXU4hk7PuV5n8BIGRZcMTNVXPxZ9fxx+OLdv5tTN7
         vCZdczld9ViXDeq040QhAFvIUB94rek9WAMFMJOwU/9yOAvfJCyEwbuI7ZFvp7buSpNQ
         yvyQ==
X-Gm-Message-State: AOAM533NFDGAOxPQ4EpoaERLH4zmB/EZUMAWFXn6fMziJBN10K6RNd4O
        YVge5KmvqcV6fgR7ht3KbAqgUw==
X-Google-Smtp-Source: ABdhPJwRT4ieJ2l8ug/xaqNwACgL0ytg+jIjEVoXnmY/kQp/b2J6n2NQ7oxNVQnCZou2JirHx9ehsw==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr2725638wme.113.1605119770340;
        Wed, 11 Nov 2020 10:36:10 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:36:09 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 15/19] drm/radeon/ci_dpm: Move 'si_*()'s prototypes to shared header
Date:   Wed, 11 Nov 2020 18:35:41 +0000
Message-Id: <20201111183545.1756994-16-lee.jones@linaro.org>
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

