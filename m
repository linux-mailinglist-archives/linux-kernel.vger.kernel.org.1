Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34332AF83D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgKKShF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgKKSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:10 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A3C0613D6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:10 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so3256175wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jXZJEO8V1+GfDNFYh0xMC5OCmgkAkp7ogIzPc700bj4=;
        b=P1O53+g6xCjn0HVbg+2LcTzi/TxNj9Kba5GMdJ54vcSns9ORtCgzS6wEcq8rV+SHzZ
         OQ1b7VoYUb67TSeIhw45K8NzFZYOxVXUj/3/XAwpmpXZzZgun6sh53tHnV0m3MwhEVi7
         a8XsVZN+PctNbvLAE3nukCVgBfi8sC7HP+uDeqJM7QJ3DRUQjaLK1IZ3wj+wtoOryBfm
         zscGpu1poXcuw9zuyJATHdJTAr6LIveeSn7QUjgghiHeKeHImZqEkMvSpim4SIsglgT1
         IY1JEaNFiwaMbrDH/ed1/K+ood3SkdVDbDrUnDY//QjQCZfqIshJSbIBdDUxXdDV8xCu
         zr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jXZJEO8V1+GfDNFYh0xMC5OCmgkAkp7ogIzPc700bj4=;
        b=j9ipW2Zs/Z3AWEayeIugHf2YVtKFgBrQYUnbqZBiQmtrQbHrbikALzkNquiZvLK/lR
         52eYXqfTkHk9wbn3JF1PFCMX/LTc1aJlTZhUN3vr+beo/U1lO4BU+1YHNprRrZEmxP2n
         E52FKpNRnzufgmyI3EnPJ3SHqCtaaHD1+Rf6c3eW/4Gqf8snUqkFfG5z31AcRuj/NJe8
         g0FrFQYPcSVu31MoXE0MNE7HblU1C5nDzu9/I59VW0U2y5F6WNtNczh6P7gxK/gBP5h7
         xNZ9t7YewMA3TKZZau0Z9odNV7ZmTjW5KdRqxX5Q8mwIwOVtijUm2tVFV9NQxi4Syf8v
         UDbg==
X-Gm-Message-State: AOAM533QB+6Vkvf5bvCSGVpXDiWEzg++/FY12nbCx848BsIi0NHv8ppz
        TZeXxdkMRu5iZgMAmsW8MLv3dUz/zRzZFlp9
X-Google-Smtp-Source: ABdhPJzfsayKXlu3vNEjxdNAa52H0jflpazf6xD3rLA1ezErQxUB0fVmYwEirbaixq6+caFEAJ67Xw==
X-Received: by 2002:a1c:ac03:: with SMTP id v3mr4489776wme.9.1605119768967;
        Wed, 11 Nov 2020 10:36:08 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:36:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 14/19] drm/radeon/evergreen: Move 'cik_*()'s prototypes to shared header
Date:   Wed, 11 Nov 2020 18:35:40 +0000
Message-Id: <20201111183545.1756994-15-lee.jones@linaro.org>
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
index d8ee80ad4ea44..f95b588354274 100644
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

