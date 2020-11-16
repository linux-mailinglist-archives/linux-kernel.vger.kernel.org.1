Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6642B4D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbgKPRih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387494AbgKPRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:54 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84366C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:54 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so27941wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFkz09HHg8XjVV8DdlQiV5ZmST/9B9izgfFwLsHrImI=;
        b=kH1BKC//wSZb3AKFDqYNzlpJHp967MUaPmKrCtKH4g9gvuaOhCFOB+bqmmVsBfJp6Y
         IRFKDFJr0NyQzl1AeiqaSKli+a3YmpMGqWEGze33mB487RpiarUWtucYnXzoWoqpwd7A
         qx5TQJV2CDRomdZE8xN48p2tGpBgTnkL7Myt/S49GRT4zyEP2KYH/BnX8zmnLGjZnHeK
         n9uQD8axbidJE2t3gHCmX1lIn++JBHCYOpFyy2kau/q16LLE7DV2v4Ahl/3kMiCJKU76
         i60I5VMbQWJkSXUxtjztOUlRblW0zJ9D5hN7FE9Ht1Xh7QJwe0MrDRErQqC/6CA+M+BP
         u8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFkz09HHg8XjVV8DdlQiV5ZmST/9B9izgfFwLsHrImI=;
        b=sep8Dy6mWXAl3uxVaWctDIKQ7DQvBBrbNZw1xOljb9CJFBAWtQMuFq+FuodgzJ4s/C
         XrvBgRMvR4o6tyFeWzs3MpK6xaHmtiJlqDIHmidVKLORAvmlAN+jkfbsFL3bAvamReyi
         5eErEIV/GHi2CkOT3u8VAINJH22rtSGCDCnUPm6h1iAqPZb+VEJ93wS/foyheB6ZHCw+
         jT807O4dwDMQqK0BZJB8BB1SnOsSWkrS4TTVRpa/OuGo+5TFxmD2HkZi/Q6wlnvjxgc8
         tk270KHUBENsQ1lAW9oZ/PdskGUYRGBvgiwqInjQkm+xzRHGV4hwAKpmvYCfmtdefM7F
         zIoA==
X-Gm-Message-State: AOAM533wjYHOmt4odt/8DofwA6mGcUE0zv6A912vCiSfaVLYiA9brff/
        Ru+apIVE57NgdEoK19XZBI04bw==
X-Google-Smtp-Source: ABdhPJwC9/+3SUbWpobqPivqrvsp22GrpEgM9PhprEf6eKffR7Y/olS1qwqch2we9TXXEGQQPqTdiQ==
X-Received: by 2002:a1c:c203:: with SMTP id s3mr16953543wmf.77.1605548273156;
        Mon, 16 Nov 2020 09:37:53 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 36/43] drm/radeon/evergreen: Move 'cik_*()'s prototypes to shared header
Date:   Mon, 16 Nov 2020 17:36:53 +0000
Message-Id: <20201116173700.1830487-37-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/cik.c:6413:6: warning: no previous prototype for ‘cik_init_cp_pg_table’ [-Wmissing-prototypes]
 6413 | void cik_init_cp_pg_table(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/cik.c:6670:5: warning: no previous prototype for ‘cik_get_csb_size’ [-Wmissing-prototypes]
 6670 | u32 cik_get_csb_size(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/cik.c:6702:6: warning: no previous prototype for ‘cik_get_csb_buffer’ [-Wmissing-prototypes]
 6702 | void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer)
 | ^~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/cik.h       | 3 +++
 drivers/gpu/drm/radeon/evergreen.c | 5 +----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.h b/drivers/gpu/drm/radeon/cik.h
index 6630b9da9e7aa..420207d19de52 100644
--- a/drivers/gpu/drm/radeon/cik.h
+++ b/drivers/gpu/drm/radeon/cik.h
@@ -30,5 +30,8 @@ void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
 int ci_mc_load_microcode(struct radeon_device *rdev);
 void cik_update_cg(struct radeon_device *rdev, u32 block, bool enable);
 u32 cik_gpu_check_soft_reset(struct radeon_device *rdev);
+void cik_init_cp_pg_table(struct radeon_device *rdev);
+u32 cik_get_csb_size(struct radeon_device *rdev);
+void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer);
 
 #endif                         /* __CIK_H__ */
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 4575e448e59df..8e9e88bf1f43d 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -31,6 +31,7 @@
 
 #include "atom.h"
 #include "avivod.h"
+#include "cik.h"
 #include "ni.h"
 #include "rv770.h"
 #include "evergreen.h"
@@ -217,10 +218,6 @@ static void evergreen_gpu_init(struct radeon_device *rdev);
 void evergreen_fini(struct radeon_device *rdev);
 void evergreen_pcie_gen2_enable(struct radeon_device *rdev);
 void evergreen_program_aspm(struct radeon_device *rdev);
-void cik_init_cp_pg_table(struct radeon_device *rdev);
-
-extern u32 cik_get_csb_size(struct radeon_device *rdev);
-extern void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 *buffer);
 
 static const u32 evergreen_golden_registers[] =
 {
-- 
2.25.1

