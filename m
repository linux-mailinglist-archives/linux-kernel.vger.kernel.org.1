Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415BB2AF826
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgKKSf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727292AbgKKSfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:35:51 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF02C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:51 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so3510804wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eWjxCy1b/Di1KDbBj5VEEMSjXTSXChj8189ArvQtHE=;
        b=HbkLuQQi5rW0/qhwunU2WW0FWuIMpOuK3Lb1lXqJZZqhFtQ0WVod0F1XFBZAthXUFw
         xXjyvXMBZIRfRPFWIjgVG0uFcAr87Ios/o1uGlsFlq8jACLRAWaIVyFNN69wwgk9Zl2J
         S7bhRfZayQLJdGensl6yesXvZoW6r6n4AIB18Rf4uu14sXEjeZLls+85JlR0x3kbjoBw
         DVJiPNOPJBi/2wGU7f6bBKz3LrP064hHZLM4zwvUoWbIdxKFNJndlornfq4m5DDsge7i
         LYzgUUvQislNFuJvaZVzSwUp9v/HcLrP64p4YEne6oClTQ+ohO9SvBG4vrLMVB6r1P2J
         veRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6eWjxCy1b/Di1KDbBj5VEEMSjXTSXChj8189ArvQtHE=;
        b=BgbyPCWDbNEnB4EC7fidu5TsHsbUgL06yeciG4+hFJbDWHB0IrHitDB7qvxP/Csol2
         aYmovAAkkbu8wIpRCpDKuxBKJ2LDzN5I4CpLNmaet80Rvcmmoj7MECwRi1lXcvWbPEuE
         Bd+Zl9hgaS2nEOU2cBTDYTZz94hky2yF6M4hSPb2Wf9e0j5TBCwO/H+7jnEKEYfTW/io
         V6jkdcTIkUcL/WwYZGxJJYcu//nmvoxGG0tbf3Ch8sv9m5BV78Df1u8VfvQH/eeGTEu6
         RJ56bINuxcezmW8dyuMY4Uefd1rViySD3ZDqn2DsG6nJQnftWGb5BW6F31dyL70FOHoj
         APmA==
X-Gm-Message-State: AOAM532gIGD+NfxFaitMMSftqA7zTmDaDkeM/Nr06xYacFBHR40jnsHX
        uCD5t1+j/+64PDXuBN0dKf+fRA==
X-Google-Smtp-Source: ABdhPJwTG1YxOAySI8bAWJE0QPTrYQEjoXSzKA5s7TWbneAQ6O54b4nGoEtH73y89h/U+IhYeKkUXg==
X-Received: by 2002:adf:9124:: with SMTP id j33mr30438227wrj.376.1605119750054;
        Wed, 11 Nov 2020 10:35:50 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:35:49 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/19] drm/radeon/evergreen_dma: Move 'evergreen_gpu_check_soft_reset()'s prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:27 +0000
Message-Id: <20201111183545.1756994-2-lee.jones@linaro.org>
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

