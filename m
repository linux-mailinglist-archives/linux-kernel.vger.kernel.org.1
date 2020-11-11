Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9871E2AF848
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbgKKShp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgKKSfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:35:54 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5B9C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:53 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id p8so3510901wrx.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TTguyaQuVrd+USo/F+rMhw06NLnXmuljJDk3k933AM=;
        b=uzYnXdFFpGFm/O/yOG8ZnLUAwCXGekg2acMZNKqILkDN5/NpAh6cm4f6K2dqKdkJSn
         C7NRB6cZlnNl8hSwWeBmI36L4kdkOL3H4CmV87xjGW/FpXfExfTEu8a45Q4Y/V243SnO
         qGFS0il8RaTQOfwdfzUBnRXSabA3COE4c7YFG+yDuJ9WBCF9rBWj8yrEzOrUgjnQapnL
         D/WJ/RQQOsJ6t8yAtJBi2DNUPyxK5rCNaUWcRyoqXBo21obVwGHtq5ZrCENObNqe0lN1
         3qjzGG56Gfes7ebdpjzYG1smr2Tp3b5vwvffnIt63DYfsfYCIuVGakNbesczuHou+RCn
         /xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TTguyaQuVrd+USo/F+rMhw06NLnXmuljJDk3k933AM=;
        b=D/c7gifMEIT3vRPk5G60l/Zyw0TzhAXeMEPkCUpFmIPofSjhjaksyxl/vTOQJAtjyg
         nWvw7It65QTev63EIVUU37QD08U3EOGM51xsK4ebnaM+5s69bW50iJKgtlNmMMSxTlSM
         ZgAFu4JXkZSpHt2u51nuQYdegpHBAQL0mBLq91IDIxEYbv/ycdQ0sX/6LVI8R2MldW9F
         wBTWk0xYMIAs8/BgEG8zpNPKW24hQdf2ISc9/N5fHwJ0ZTwR6tts2YwM8Qikmq93wXbF
         3/5yt2TxxFLVtn0+lEmY/wH8tyjyA/JXUj0DJwEOpzzLLGp5QG9t+qd99mlCAiSra+qV
         VH/w==
X-Gm-Message-State: AOAM531mH/hDaiBVnL6Ptigoy/FDC8wLUCP1a6mQhawFrDVbktKE0pBz
        dGnL5sOK20bqhmGfikS5GlA8Hw==
X-Google-Smtp-Source: ABdhPJz1U7jH0AHxumlfztYxCgXSd62vSFI+BQvD1c3fi+W9yP8psRSOQGLIgiF1Ay2M34GtNjD27Q==
X-Received: by 2002:a5d:6cc5:: with SMTP id c5mr31747759wrc.301.1605119752670;
        Wed, 11 Nov 2020 10:35:52 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:35:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 03/19] drm/radeon/ni_dma: Move 'cayman_gpu_check_soft_reset()'s prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:29 +0000
Message-Id: <20201111183545.1756994-4-lee.jones@linaro.org>
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

