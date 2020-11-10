Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197D62ADF87
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732274AbgKJTcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731760AbgKJTbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:50 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C769DC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:49 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so2666993wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uPrx+xhJSBB8cqNRTfRxpV861JL0F49FY7TxVtUc7KQ=;
        b=fvWFmwsbroPTBLuNSiqWL2C6ts7uBNUTAb85H5SQq/MGaMS1cangSJSSeVWp3XHAlm
         TSQnGisZL/NyszChhDltBHKvM3dyXcKX4vHlVYbByt+kOxb6EBSQp42dJY03Zam8JIPs
         QaOSrWVSI/8rL9nPM2sQ4O4ugLFkrQP9kKv78PsPcGbBsEn3GyQ/XWMy2LXergaa43Nx
         sBGNfZcE1U1Ip0vwO/MjqTFzwQEnKA0RhW3ZXRQigi9wnRgwVnzw11RhpsvhP0K+3ubm
         n/P+ilwrfzZiFMGnGZZzyqXTxW0Msd+N+e1W9SZsJJQJ8JHrgrCB8jRpRhMBvGuXZE9y
         j7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uPrx+xhJSBB8cqNRTfRxpV861JL0F49FY7TxVtUc7KQ=;
        b=Zeird+mhJaGsYmetNxo/mYJOv4hODgffg3Yjpu9RbqyLGrLly0fCBPkMTS3xFI57uc
         bDVSb3mB6uOU3V6/DKE5EBrYcLq0PQTtvby5p8x3DFH6bWOxqapAvewLBmn82mP1DgYw
         fO+OZB4zDRUofS5B+Dmmj+OfE8JEOrqakpLqATwDG0a4YXwAsley3vykxyhxNcUFkcAx
         /krdgz52FpC2bnqKt0DID3Y4mJ5i9fEyT7t0FbIl7VACJDGpXHshMSZPJDrQzIPIxcki
         9r/Pl0oLjFdOeXSrsKGphwFoViVx0UBK2Gwc4mMhTEL0g1wzLIkUqeNP+m+qoa0Jm71x
         ScHA==
X-Gm-Message-State: AOAM531GFfW8vPcxNqSZZeLavCJ5TKfnrc8SgQMBWCMYVu5hgDShCDbi
        GiGqpfJJ18FN+o1a6T9dmuX6sA==
X-Google-Smtp-Source: ABdhPJw9P+/6eiSGMjIagfmvzL2nZILnywLdK1sKrl9EFU2mVczfvrgcm5GN51EDLktxPdDmixc2Qw==
X-Received: by 2002:adf:f644:: with SMTP id x4mr26077443wrp.5.1605036708589;
        Tue, 10 Nov 2020 11:31:48 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:47 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 26/30] drm/radeon/ni_dpm: Move 'ni_get_{pi,ps}()'s into shared header
Date:   Tue, 10 Nov 2020 19:31:08 +0000
Message-Id: <20201110193112.988999-27-lee.jones@linaro.org>
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

