Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14B82AF82A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgKKSgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgKKSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:04 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B195C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:02 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so3511267wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/TaDkB9aPGP5jIvVTMt5uJ/KkWKg3o08L440ECaIrc=;
        b=r6woMpmmXo0Dj5775fZ4Cgbnwo1FcLxbbKcVGettNgkwJ6Cx4wfgTiVzUOZ6yjHa91
         PDuEfCvVpOvcRcswiUXZE4gg4YiSkaO4G+MOIhIJDFTP4KBjBvqLiq0DNNqICzoiFW7K
         vnX1v4/opW7uZuRGmvaWYOCdLTTwraEi8lxRBR8Po9duljYvHQJF46gFiGEtDBUWJwGv
         DrHkoqTr2dLCZEXQhmRMLTOTSwId9FnX25/MW4mzBrabNNErqk3pzrqo+Xd6pXZyl6sE
         2ULcoFWvBt9kwgAkdUKPix1fyjnL3O+cZaEVUSV5Zl0EWldvROjwGOxITtQgijDW3MkZ
         s3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/TaDkB9aPGP5jIvVTMt5uJ/KkWKg3o08L440ECaIrc=;
        b=PTxMTuCkpCPvw6S+nIf+Ci2DuRV76XQvf1qavt2VPcCFD7EMlhGRVc/p/FWPgOgj75
         vVM7DzgTEVSXVFkD/LZwfiW2OoaA4vF1fH9/JyMecIfAlgo0IyMC3oA6cfjjU/YbwYUw
         eNMxiuIQVrk3Z4OF/fGXGvmqiyjeR0cwz3DSkn/6g1OhDzlQwG5Bq1YvqpFrXugU+/Jh
         kc/87//+Y5oVx0AHuDwohfRYM9clbsavqBTygmJuaVc2dnAv1lxugfGGVQOKyJ73fMUY
         D6/t+YlY9lPHuuQ8JJ4xgMlsbc0bVzc9i+awjH0GETXqXHzTiTb75YlNgBH8p9zHz6c7
         opLQ==
X-Gm-Message-State: AOAM530hJ2Z/d60wAerLjkRJyfdZyPSpLbWm/2FXhy/nt1ZPUPQW8KZB
        d3DAnZ3rukBlrQw6/md2ZzkPyA==
X-Google-Smtp-Source: ABdhPJyY8o8gKVGXYOjDyRor39+RIHFMv2JbLl6uaiGyTOZu1dzApGW0b1xKClawnwujHmvLLUWJAw==
X-Received: by 2002:adf:e44f:: with SMTP id t15mr28375034wrm.380.1605119761005;
        Wed, 11 Nov 2020 10:36:01 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:36:00 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 08/19] drm/radeon/si_dma: Move 'si_gpu_check_soft_reset()'s prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:34 +0000
Message-Id: <20201111183545.1756994-9-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/si.c:3768:5: warning: no previous prototype for ‘si_gpu_check_soft_reset’ [-Wmissing-prototypes]
 3768 | u32 si_gpu_check_soft_reset(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/si.h     | 1 +
 drivers/gpu/drm/radeon/si_dma.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/si.h b/drivers/gpu/drm/radeon/si.h
index 0a5018ef166e2..a1751ae560f02 100644
--- a/drivers/gpu/drm/radeon/si.h
+++ b/drivers/gpu/drm/radeon/si.h
@@ -27,5 +27,6 @@
 struct radeon_device;
 
 int si_mc_load_microcode(struct radeon_device *rdev);
+u32 si_gpu_check_soft_reset(struct radeon_device *rdev);
 
 #endif                         /* __SI_H__ */
diff --git a/drivers/gpu/drm/radeon/si_dma.c b/drivers/gpu/drm/radeon/si_dma.c
index d2fa302a5be9f..645897d1bfc31 100644
--- a/drivers/gpu/drm/radeon/si_dma.c
+++ b/drivers/gpu/drm/radeon/si_dma.c
@@ -25,10 +25,9 @@
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_trace.h"
+#include "si.h"
 #include "sid.h"
 
-u32 si_gpu_check_soft_reset(struct radeon_device *rdev);
-
 /**
  * si_dma_is_lockup - Check if the DMA engine is locked up
  *
-- 
2.25.1

