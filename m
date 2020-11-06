Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5902A9F6B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgKFVuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbgKFVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:10 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C09C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:09 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 23so2777559wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sSLs3el2OyWbVsEn+pD70NcssOBrvqEsumretpeL3Ds=;
        b=Fg03f1ie4ITmoYfqfIpjifTAA8wKVblmO4KjzkpCm6gE2NytBaRSUY0L+Sq4e5GQBG
         bFs4s7QvgryHFMdcA8em7y6YUQG39npIUgTlI0EQowc5rrw9+Odku+gMoW8GldBSQC9E
         E6QQiE93cA7d+XE4vK/HHNAFJMLZnMfWTRTCQ/4GcPWro5oThTV0vDGY+GjugtfprdZA
         UObpFO64SEriemyPjtFfNmQHZSF6jBoXuv1PRiSquaJUayoglzNLxW6RN8ip1FxtwfRz
         +wnrud83OxAq4nw4ooTpKeGh/5O/MyU2psfVdwHs59GyAWuR3cVY1FMKf4vD64Fdrc0i
         HZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sSLs3el2OyWbVsEn+pD70NcssOBrvqEsumretpeL3Ds=;
        b=f8X3TUf6gthsWZUjoIXOtlXdDSpWgFTF4/JnQD5zePnf9/O+9PE6Ri1cPCgZDHYaro
         hIyEzcRuZP3AcLonm8ffWeNVLcoCMJUHMLUB0WzDBYbn1m19tTGQmwPnWSKBeWEYQb06
         eFo4O0IzN7qwiJSEzz/l3im+tOZYXOB6+FatqEz+dZ06NjxezPJrCRy4FF3BmpZswczA
         UghtS8bEwVGekojbE7ErsNESTK6bYWnr51/sW1oyhjM6yVC7s3wfayGTvhkXYz6dh1of
         Dh4lkWOulAfpvcDVNtNBMpXM3S105exQOhIYuiy6/bVrVSRz9FP8xoY+S4uAObEX1b7t
         rw6Q==
X-Gm-Message-State: AOAM532j0lFA2V/ymu85OIay87hPOnOD/qHk2kXA61eXA3+RrZ1sjA8S
        DuZhoVjlrYUp8RI/Hery2vWrXA==
X-Google-Smtp-Source: ABdhPJzf2xI6CL5550HyBIRa+NGoE6q+KpGaJ+iPNinF9nAS2FLtnIDT4CYD4RyhkJ/F4l+Sgz8yFg==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr4577899wrw.378.1604699408431;
        Fri, 06 Nov 2020 13:50:08 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:07 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/19] drm/amd/display/dc/basics/fixpt31_32: Move variables to where they're used
Date:   Fri,  6 Nov 2020 21:49:42 +0000
Message-Id: <20201106214949.2042120-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also rid some unused ones.

This patch solves 2000 warnings!

Fixes the following W=1 kernel build warning(s):

 In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
 from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
 from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
 from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:35:
 At top level:
 drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: ‘dc_fixpt_ln2_div_2’ defined but not used [-Wunused-const-variable=]
 76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
 | ^~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: ‘dc_fixpt_ln2’ defined but not used [-Wunused-const-variable=]
 75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
 | ^~~~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: ‘dc_fixpt_e’ defined but not used [-Wunused-const-variable=]
 74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
 | ^~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: ‘dc_fixpt_two_pi’ defined but not used [-Wunused-const-variable=]
 73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
 | ^~~~~~~~~~~~~~~
 drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: ‘dc_fixpt_pi’ defined but not used [-Wunused-const-variable=]
 72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
 | ^~~~~~~~~~~

Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c | 5 +++++
 drivers/gpu/drm/amd/display/include/fixed31_32.h   | 6 ------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
index 1e9a2d3520684..59f37563704ad 100644
--- a/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
+++ b/drivers/gpu/drm/amd/display/dc/basics/fixpt31_32.c
@@ -26,6 +26,11 @@
 #include "dm_services.h"
 #include "include/fixed31_32.h"
 
+static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
+static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
+static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
+static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
+
 static inline unsigned long long abs_i64(
 	long long arg)
 {
diff --git a/drivers/gpu/drm/amd/display/include/fixed31_32.h b/drivers/gpu/drm/amd/display/include/fixed31_32.h
index 16df2a485dd0d..22053d7ea6ced 100644
--- a/drivers/gpu/drm/amd/display/include/fixed31_32.h
+++ b/drivers/gpu/drm/amd/display/include/fixed31_32.h
@@ -69,12 +69,6 @@ static const struct fixed31_32 dc_fixpt_epsilon = { 1LL };
 static const struct fixed31_32 dc_fixpt_half = { 0x80000000LL };
 static const struct fixed31_32 dc_fixpt_one = { 0x100000000LL };
 
-static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
-static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
-static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
-static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
-static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
-
 /*
  * @brief
  * Initialization routines
-- 
2.25.1

