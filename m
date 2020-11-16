Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E81C2B4D85
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbgKPRi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387498AbgKPRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:55 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47380C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:53 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id c17so19605859wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noNY+SglbM8aEsCCdAF8dY+Y+lbfpcrhUN1CWHwGoPw=;
        b=DFTBbu+5/taBz5pfwjhg2wGKAOcz772ZE8KKWtmmMpONrvSSKnHUEF6FR+5UjXPlQK
         XmlgrM5ohKz9h/HLFZcXQxou2oIiaih5t2afZ7Otfj4eqUJz+ClVii6GJ31QOupottY2
         06K+IiP5G5Tql72mSEUj5Elt4Zonc+FW5cVsOEaMS375Pw0lb25NVw8jn19KABojYTnO
         sIvvQE5jz3fGbJosQodyjtGV4pDXBk4l7CjgB7lbA9PWHD/hGoTrLX7YaUy58OBTdG8n
         uyZSjbl/MOssb5we3fYsnndgw9ANHUUAgPawXlc59hSgBoC/XP5DMqLG24yHn7aduPpK
         h7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noNY+SglbM8aEsCCdAF8dY+Y+lbfpcrhUN1CWHwGoPw=;
        b=FcJbRW9oNpPTJVwQwNx0WlybhIMsP2/bw2BxB9Lm+kud20oWFddYBvbjYHRnwvwhvK
         Qf+14Tds/WesTc+a/4U0EbmQ0CPaBUDH9GcjxIPMIIFmqSBaxySng+WfvOKsZbNXXC+O
         UiJVIumoRBTs/MYtY0bMSDl1/ErmYjw0dJfJGL7dHG3NR+J8jawZ1ZDF9nt4pBubqFER
         cLhDRuoO4KB38tk+1vCJZP1BhS90J5i4dqBRxHEDjeZkn73JrK2TwjjRzmKH+6aE85O5
         HDcnT7ANM0jkUERZbnQfy5ZNXC0Q30EYKQuFbBcXQ6ukbIYen6OqQ1aj5gPaNlQcMoUZ
         YwrQ==
X-Gm-Message-State: AOAM530xUn+oyNqinqAaq8HL3ReiNpHMd0kO3/MZ3KIBwxDn4RdWTIFL
        05QxtOuRfNk+NNAYpy9ltg5nrQ==
X-Google-Smtp-Source: ABdhPJyZfd0rNWrnYq7A3M2ndx2Eq6U97hpTle2EgGXwsNwTmEA6pUg4LVpVHh3yyTfW4Sn4/lXW8A==
X-Received: by 2002:adf:e48d:: with SMTP id i13mr19977610wrm.387.1605548271964;
        Mon, 16 Nov 2020 09:37:51 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 35/43] drm/radeon/cik_sdma: Move 'amdgpu_cik_gpu_check_soft_reset()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:52 +0000
Message-Id: <20201116173700.1830487-36-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/cik.c:4845:5: warning: no previous prototype for ‘cik_gpu_check_soft_reset’ [-Wmissing-prototypes]
 4845 | u32 cik_gpu_check_soft_reset(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/cik.h      | 1 +
 drivers/gpu/drm/radeon/cik_sdma.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.h b/drivers/gpu/drm/radeon/cik.h
index 297b3c1ff804f..6630b9da9e7aa 100644
--- a/drivers/gpu/drm/radeon/cik.h
+++ b/drivers/gpu/drm/radeon/cik.h
@@ -29,5 +29,6 @@ void cik_enter_rlc_safe_mode(struct radeon_device *rdev);
 void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
 int ci_mc_load_microcode(struct radeon_device *rdev);
 void cik_update_cg(struct radeon_device *rdev, u32 block, bool enable);
+u32 cik_gpu_check_soft_reset(struct radeon_device *rdev);
 
 #endif                         /* __CIK_H__ */
diff --git a/drivers/gpu/drm/radeon/cik_sdma.c b/drivers/gpu/drm/radeon/cik_sdma.c
index 3c709ebe8d1ab..919b14845c3c7 100644
--- a/drivers/gpu/drm/radeon/cik_sdma.c
+++ b/drivers/gpu/drm/radeon/cik_sdma.c
@@ -27,14 +27,13 @@
 #include "radeon_ucode.h"
 #include "radeon_asic.h"
 #include "radeon_trace.h"
+#include "cik.h"
 #include "cikd.h"
 
 /* sdma */
 #define CIK_SDMA_UCODE_SIZE 1050
 #define CIK_SDMA_UCODE_VERSION 64
 
-u32 cik_gpu_check_soft_reset(struct radeon_device *rdev);
-
 /*
  * sDMA - System DMA
  * Starting with CIK, the GPU has new asynchronous
-- 
2.25.1

