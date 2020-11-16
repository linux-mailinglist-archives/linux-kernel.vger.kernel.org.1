Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E72C2B4D92
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732973AbgKPRis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387462AbgKPRhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8356C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:46 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so19605246wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c/TaDkB9aPGP5jIvVTMt5uJ/KkWKg3o08L440ECaIrc=;
        b=H9fzVUYr61GkdepEkcKo4chSq6TsD6cuRJmXdrsP+VjRRNEvOQQX/IfJ52sG/AWhsh
         EFRdfq3Dlg+axrP3DhsmqLb4m57yB9TVKIKxsJ0uDgUZORWETCnUubh/cXsWl8zsxOQ1
         o/9J+jM+JTAJ1opy/ZR2C8WKVu8T394xmWN6haS6//h2fksNKepH0hCF4L0RS7i8WIS8
         ThriN6lQhbMpGbEIWYKuT4VANbahux5F81Q/wy69QsmKqF4kktqGd/gfP9OhrIEd5Iz/
         RzpxPw7HF4e7VfvvQLuSrr+A8vSFJPkA+FYLvcXnilM0rbX07wqAzzg43KI8MMoxUt1E
         BEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c/TaDkB9aPGP5jIvVTMt5uJ/KkWKg3o08L440ECaIrc=;
        b=j9yvlodN4OFJyOFuMhAJ7M5jSrRypcpzepSXhqzMu2CibUjiPmhh07gW2LZiDYEMRW
         887yTfbcxQo4XFwTp5R+mjd4qiXIMekjx1LP+xGhUqIZQ+kWejY1aHZ0mV6+qLANaxJU
         x5GF+QsT5t4gMHM+XgpQt22G5i1kzisNR7wW0B/8mc+vdu/LXAHNbvtP+T9kc/Yt/rUC
         P+5qc2h37yFOS+c3dsKT8VE4ustdqBvCcfGeGW6/EtQAetH0nNlBFqKZ78R6mbb4nfBv
         jxiDbriLYZcroKfslmOJiBhkZgK2P7Zj/CZSX2dhHzOzIQaxUDk4Mfnrr0XyotZZFDwv
         O2BA==
X-Gm-Message-State: AOAM531asEqNow2rkpS+wqPDeCR61Mql+J+scJ2dNA/Hq0RwYwisWmFX
        WMo/3HPSQG0n8XVPI4vLd3BJuw==
X-Google-Smtp-Source: ABdhPJz+sGVtIvHucgBcxMBTLe3HE9tgMEhDeD1NpTRCThOpVex2/FpBQ/EEQO9VAAJPzEWqq3i2CA==
X-Received: by 2002:a5d:4612:: with SMTP id t18mr20438262wrq.401.1605548265478;
        Mon, 16 Nov 2020 09:37:45 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 30/43] drm/radeon/si_dma: Move 'si_gpu_check_soft_reset()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:47 +0000
Message-Id: <20201116173700.1830487-31-lee.jones@linaro.org>
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

