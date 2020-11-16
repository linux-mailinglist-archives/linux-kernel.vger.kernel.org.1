Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F322B4D97
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387429AbgKPRhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733311AbgKPRhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:38 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683A7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:38 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id p1so19599970wrf.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eWjxCy1b/Di1KDbBj5VEEMSjXTSXChj8189ArvQtHE=;
        b=R2Zvmw9KS2p/uW92MEVvMAZHk/cC36qiZDKxllEIdVedCqMaJxEhSpmCl8uEzkgxvs
         ziSwIPTt2zvHY39MLFUPlML1cC0Y4JOoKx3lqQ8apPiW9uNx0p0hyqKCg3mdkC1uGZpo
         9QZLpveawM4J2EiSh9h4Ky7yUMPlTMDW6etAsDjbjhYc6A4T792sIprRsqKM6TO+Cuia
         qRZodDurakwR/Sa0L1NztR38xENLghD8JYA7jLO9eYyDMWoNeqNc8F8voGZxgUOBAoiG
         PVYJw/2UeoXSIhRt0aiFE/6FKhjqwCslGMIL6Nvym5qzUA0y6W2dVcXzM/1fuh4TKJik
         2ecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eWjxCy1b/Di1KDbBj5VEEMSjXTSXChj8189ArvQtHE=;
        b=QgkZ3Ej4Ius8QuP7i90ZbQlftRDfYrmZvSrpjrzpVuMwjEK4ykXbXOt2/k1IqmGLcW
         GdnJaK1JNtmV0rC4TTikNOyZN3l5RELNQFNH9CvLXoxjEDhZkL6L4ZyIyoFfsslD2/DV
         GFTxKh1QOgFKsGJAzQR2J1iYfnmf7OLxnUkTRPkAxJP9FTeGN57AH5Liik5llnIu8zmQ
         398sWTPV/Gc1FiY+Q8r57790+5Wf44Tffpq9ZLL9azJUYegw19E/8+JiTG02QrY2dmy8
         2hZycNPxgaPQbovH8aXtzp80XcTJTkbDvXe5v0VUvzgD5xKa/ooS7WDMxp0W1Ly47Lls
         AVZw==
X-Gm-Message-State: AOAM531nSD/EDGv5LgXtgz/tS9xfcFmxjYYd99FByhyHUXh3jnL8nhNM
        QmMsEMqgVfjI0A3TfaYjCIvNGA==
X-Google-Smtp-Source: ABdhPJxROO5b9lILZ+JniBmhfb3OcM1XvkCvRfpWKPHTjgz7WGw0zIZm4kKfPGYNo/liMWytt2yiCQ==
X-Received: by 2002:a5d:448b:: with SMTP id j11mr20117581wrq.236.1605548257084;
        Mon, 16 Nov 2020 09:37:37 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:36 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 23/43] drm/radeon/evergreen_dma: Move 'evergreen_gpu_check_soft_reset()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:40 +0000
Message-Id: <20201116173700.1830487-24-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/evergreen.c:3825:5: warning: no previous prototype for ‘evergreen_gpu_check_soft_reset’ [-Wmissing-prototypes]
 3825 | u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen.h     | 1 +
 drivers/gpu/drm/radeon/evergreen_dma.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen.h b/drivers/gpu/drm/radeon/evergreen.h
index 30c9ca99ced90..eb46ac7776951 100644
--- a/drivers/gpu/drm/radeon/evergreen.h
+++ b/drivers/gpu/drm/radeon/evergreen.h
@@ -47,5 +47,6 @@ int sumo_rlc_init(struct radeon_device *rdev);
 void evergreen_gpu_pci_config_reset(struct radeon_device *rdev);
 u32 evergreen_get_number_of_dram_channels(struct radeon_device *rdev);
 void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
+u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev);
 
 #endif				/* __RADEON_EVERGREEN_H__ */
diff --git a/drivers/gpu/drm/radeon/evergreen_dma.c b/drivers/gpu/drm/radeon/evergreen_dma.c
index 767857d4a8c5c..52c79da1ecf57 100644
--- a/drivers/gpu/drm/radeon/evergreen_dma.c
+++ b/drivers/gpu/drm/radeon/evergreen_dma.c
@@ -24,10 +24,9 @@
 
 #include "radeon.h"
 #include "radeon_asic.h"
+#include "evergreen.h"
 #include "evergreend.h"
 
-u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev);
-
 /**
  * evergreen_dma_fence_ring_emit - emit a fence on the DMA ring
  *
-- 
2.25.1

