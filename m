Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 588F22AF83F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgKKSf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgKKSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:35:54 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF2C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:52 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so3491831wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyNxvxME2tG4MioZh0DLPpucvuaAdYEDiX4yy0UM7tE=;
        b=pZ+Qh5Ir0/lUkjSQsdZgT0qNsnE0Kwon6ayRY4sx+bJ7U2t95+wam8fCVcVYBQy3hX
         AuDoAsSXTh3xeuT4E4r2i+u0RRFD1EiCY9T3C0Xgkq8wSfVcPtW9PVHnim5Cnp+zsmT9
         zz112QT7ngXkmeKYTV3biTKexdGTYGHonT4el6Xo2iPzUX/ZkfMN3Du0t7dd80eMKzZP
         f93rAUQgaRHJzbR7P9KIZYs5AM0iFg4IUBa1MtgtG3Q/Owj5iXYPEx9PjJBnC5zbS6C8
         xR3zEPCXFZNsjaNtqFCbfMXBHlp+C98S3ZNNEW8ePYQAYo/iIenIqSTFaMe9Vs6uQnEw
         sEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyNxvxME2tG4MioZh0DLPpucvuaAdYEDiX4yy0UM7tE=;
        b=W7CS7O4EQJXl5sVS7CS9HQhWi0bQ8hL73zurzD+JNqCjGcZ5eBINuulvnqKEPoanl7
         Cpi1YfwFlurmQoT+q3H0NUYjeZ+a4efTH4hxO+ZB2Xcfmbuua2xFL6OgEZyj1CeVC+ps
         4C9R+QalyEj314wbOudGV2aqPWRi0FQMH9WnwRGanzVpmkqyFtFQ3sdD5IhkdvZVyWg1
         vpFhNGltYK3lpgE79fYyHcICwwi4Won68t5xWVwCTkMlYZ5FjzpWiD1Ezokq6+YoXFQ/
         Nzf/cZBovveCnAr8Weecvd1AabbaM1+fWjk3pIZq7S7qGkAhujtc3GsMoyjuwpkrNJY2
         C7Ow==
X-Gm-Message-State: AOAM533esxOwo9//OzUHmYkQkkdRfsGT9GaEoO9VPV5cHsqzhPznxB1G
        GdDTLlWV43QM7JLyS79s65Q+jA==
X-Google-Smtp-Source: ABdhPJzXU4WDrLLMPa79WjcoHOQsKAyxzRDNTbkyMczIslidwC4TN6humNF53xIsEkReAjLaT3O4uw==
X-Received: by 2002:adf:de91:: with SMTP id w17mr30549664wrl.84.1605119751376;
        Wed, 11 Nov 2020 10:35:51 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:35:50 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 02/19] drm/radeon/r600: Move 'evergreen_rlc_resume()'s prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:28 +0000
Message-Id: <20201111183545.1756994-3-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/evergreen.c:4380:5: warning: no previous prototype for ‘evergreen_rlc_resume’ [-Wmissing-prototypes]
 4380 | int evergreen_rlc_resume(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen.h | 1 +
 drivers/gpu/drm/radeon/r600.c      | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.h b/drivers/gpu/drm/radeon/evergreen.h
index eb46ac7776951..f8d772e612a48 100644
--- a/drivers/gpu/drm/radeon/evergreen.h
+++ b/drivers/gpu/drm/radeon/evergreen.h
@@ -48,5 +48,6 @@ void evergreen_gpu_pci_config_reset(struct radeon_device *rdev);
 u32 evergreen_get_number_of_dram_channels(struct radeon_device *rdev);
 void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
 u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev);
+int evergreen_rlc_resume(struct radeon_device *rdev);
 
 #endif				/* __RADEON_EVERGREEN_H__ */
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 94e8815e5067d..b44e0c607b1b1 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -39,6 +39,7 @@
 
 #include "atom.h"
 #include "avivod.h"
+#include "evergreen.h"
 #include "r600.h"
 #include "r600d.h"
 #include "rv770.h"
@@ -113,7 +114,6 @@ static void r600_gpu_init(struct radeon_device *rdev);
 void r600_fini(struct radeon_device *rdev);
 void r600_irq_disable(struct radeon_device *rdev);
 static void r600_pcie_gen2_enable(struct radeon_device *rdev);
-extern int evergreen_rlc_resume(struct radeon_device *rdev);
 
 /*
  * Indirect registers accessor
-- 
2.25.1

