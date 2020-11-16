Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5BE2B4D98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733144AbgKPRjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbgKPRhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:41 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF0C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:40 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id a65so32311wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TTguyaQuVrd+USo/F+rMhw06NLnXmuljJDk3k933AM=;
        b=WRLJ1q4UqmT47CdbxnEAngUmUOahyGqrN/s44SVmCRGE6+Btb4XOge97Tzm/ASOQvQ
         kHutEnIMP6rdOJgwGTAuB09lr/dhhN/C9SIIs5MrfN7Hw1/lT9c19lWAECUjdPa/KzFp
         9WRrW4r8nRawZqPNQclJS4KzH2uIjbHP4ys9TnqtcZPjX+SZRjt1oNPvWGWb6WeY5OHz
         3GnCQNaU27a0kw0JU1LPD5VPe/xWhnp19+XdWN77fMIVozxsf5337JKUQThHXJ5HuR7d
         8pR0Uwf6UbEh1hBKF0a3CAPdBv/gWuvcX04dnPdYdSsvHxCMg2WVTP6jTa433VpmMBi9
         8DVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TTguyaQuVrd+USo/F+rMhw06NLnXmuljJDk3k933AM=;
        b=iCZNn0Zakq16KDdYleA/hCeonKqEogKvG6oBUK6yyzTNbUeVI8V2HiNI7lN4l+PxHn
         NXmKd6h+CI0Ebh682c/F7U1CL9U/Es60vYAqMequjEdos+zWQ+1qcXIQvdnd0otAAfiM
         Hxy///BDI3iWbiXOqr8f2mo0M5KdRVuuqqi5tz8hYnZigLmxQv0HP7KuM+DbNirD6/Ia
         9Teu+3JHwpJ+5h3pZa5/F/6jpoFVWpd+loJdyMA4UWHrvzrkMzwmhgcsno55P0OQ5bBM
         wz2PdoIN8YDMVS4BwM6Et5uvfMvyNQQPoFYr67i5qYm1HxDwA26LwQmfAW2pgYCpdQwa
         tNIA==
X-Gm-Message-State: AOAM530cJ51XMaoUXFUKLmayLlpkJns5XObk2coxJ2s750q4KZvhaYdI
        WLann0uQAHLoP+y55T+IUiBEGA==
X-Google-Smtp-Source: ABdhPJw0MoOwO876rhqimSbMBMXrkpTGHAmxxSzdJkaUcBzp1n6ZUGdVjsQTISfCOxCG5I7moeivOA==
X-Received: by 2002:a1c:c203:: with SMTP id s3mr16952678wmf.77.1605548259534;
        Mon, 16 Nov 2020 09:37:39 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:38 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 25/43] drm/radeon/ni_dma: Move 'cayman_gpu_check_soft_reset()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:42 +0000
Message-Id: <20201116173700.1830487-26-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/ni.c:1733:5: warning: no previous prototype for ‘cayman_gpu_check_soft_reset’ [-Wmissing-prototypes]
 1733 | u32 cayman_gpu_check_soft_reset(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/ni.h     | 1 +
 drivers/gpu/drm/radeon/ni_dma.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni.h b/drivers/gpu/drm/radeon/ni.h
index d63be1c88c0f1..9a5f31a05e68f 100644
--- a/drivers/gpu/drm/radeon/ni.h
+++ b/drivers/gpu/drm/radeon/ni.h
@@ -34,5 +34,6 @@ void cayman_cp_int_cntl_setup(struct radeon_device *rdev,
 			      int ring, u32 cp_int_cntl);
 void cayman_vm_decode_fault(struct radeon_device *rdev,
 			    u32 status, u32 addr);
+u32 cayman_gpu_check_soft_reset(struct radeon_device *rdev);
 
 #endif				/* __NI_H__ */
diff --git a/drivers/gpu/drm/radeon/ni_dma.c b/drivers/gpu/drm/radeon/ni_dma.c
index c56136848360e..bd515ad4fe4cc 100644
--- a/drivers/gpu/drm/radeon/ni_dma.c
+++ b/drivers/gpu/drm/radeon/ni_dma.c
@@ -25,10 +25,9 @@
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_trace.h"
+#include "ni.h"
 #include "nid.h"
 
-u32 cayman_gpu_check_soft_reset(struct radeon_device *rdev);
-
 /*
  * DMA
  * Starting with R600, the GPU has an asynchronous
-- 
2.25.1

