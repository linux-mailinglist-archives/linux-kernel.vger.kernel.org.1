Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170E12B4D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbgKPRht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387433AbgKPRhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:41 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BE5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so16812wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pyNxvxME2tG4MioZh0DLPpucvuaAdYEDiX4yy0UM7tE=;
        b=U3XpEpiWRsz0j+hMtLDZ8ijrHq2pxzt4Q63ge8BICYDILPrM0Uk4Znt6t3gnNNK6TA
         NlOKoWX3AV2dY6ZopWymRVjS6pKydRf3Qy9yyqC+dsxNtmX1UWDNjK6g1ijj8+MSV1PS
         diXcNe5FtP7YT1fRvskacyGs+kp2Rj2sSYX2lkHzUuwA+ZHhRI4Cll4N/5sRzHkFYVaq
         MkX1VQC13yUvBzlVxq3Hmv3pczoGHnxuBNInJfWzFE11iZ7h0ZMcoMLObo7M9IgVC4/R
         k6amszu3ErtAEjGk8HeP0Ws64DknQnHPnko2q4YWihbQ/WiOE45rttjDJudtgCmsouyQ
         M+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pyNxvxME2tG4MioZh0DLPpucvuaAdYEDiX4yy0UM7tE=;
        b=gVjuI0uMniYlFAuYyMexNcmrQwpncSxkz70AJGIEeabKOc1DbyyfRpEO60DO1LhtRk
         oZpIgMww2370sR4u+haAf1Aze2sMNidCbBDHJ2HX9QxL5FjMs33H0zCyk9wYeAG4pXV5
         AjrmK03j+IZZv2ZlE+Iyw0sADD7i2LBYdyPaXyOm6EgFPMvHYk68Sg6k2CaxEFzXXtAq
         xdTTEMHodPrmbi15HSkbfxQgjzFkIW+8oNYGCIf5HGJeWl9cb/MFObylPiqfA/UMOwjC
         niTf2CuHVS2UY5hOARS+sksLhr2YfROrl3q3x8SG2EvtMa47eSJD3fMsB4jHwrwzHOL/
         Xu/w==
X-Gm-Message-State: AOAM532Vo/0PO9hq6b0PZZeIef2mfVQ706N0aHZUGBwe1Z5bs9lX2afS
        u8Q7sL3jpHCwwZW9tokdtrQ1rA==
X-Google-Smtp-Source: ABdhPJxjNzoVEL+7L/X1+qeuAPEwh/Hw3rRmVVjqZSe7TGSI246nAKkLp8ED984/eStmZR1+Gdt8Lg==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr16321450wme.113.1605548258220;
        Mon, 16 Nov 2020 09:37:38 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:37 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 24/43] drm/radeon/r600: Move 'evergreen_rlc_resume()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:41 +0000
Message-Id: <20201116173700.1830487-25-lee.jones@linaro.org>
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

