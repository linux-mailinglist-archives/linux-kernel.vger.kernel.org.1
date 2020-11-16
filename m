Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CF72B4D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387550AbgKPRiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387527AbgKPRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:38:01 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12991C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:38:01 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id d12so19599839wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RO6gVjdG8KAsdeDZko1zQc/smdj+DRpN8GOLXtDNvO8=;
        b=WirrMl8fUxp4CO5aIQmGr0dbC4i6LjQ5TaIvP1F18yQ9bcjLr9Ahv5ncmc+D+rDiB6
         jnXwyVZOgt697WzPOCzN35MCspjL1F3oMNO4pyQlFbKV/AqhvkypMuRxRQYT7fGT5qm7
         qoIltC6EqdtoQgVkm/2T9Ne73ONBGIgLLk6eKipqsjzPYB6rLceNhPW8BkX68K8qJ+0u
         gOl5LCqRWDmgdQzuSIwQXhlqFz6Wwc565XdPtH5Eap/jQVVI88UzJJ2k1AWvaVfFKnLP
         xQRuYkkDCZemobG+VP2trTK/7X/r5owlR/Xg6sjuoQ6grn7zRLl0HAvyrc3Z2BHBeROE
         M6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RO6gVjdG8KAsdeDZko1zQc/smdj+DRpN8GOLXtDNvO8=;
        b=oVZpbHQJ46FgfXQUBY0VwpoC4GnA8dOcjIMHqob/fve+xHmKFpraKai+f7J7qwWTqg
         RKQrDqKrMVI/YziQ4A5q+va5iIREz/C7nkaQG+XshwXzcxK5rEM4Gb4PVo3BbklldbY8
         VkMU6/si3REKeD69NOFP/9AoNREa8QjDi37C5zberjVFXY4ZfckBiRu/+ucyjKPzCieU
         cgv5P7Gssi9QtlDl2xAQPp4GtRE4/d1GlSC5Rnq+AQtAP+DwYg2jBf1oKDICLi5EebBi
         GGj2cT1mvakRGkLwPUrsTF2xsSD10DDSFE6K9BNLtQywpZHWR1WdHsVSUEdRqYim81uL
         3DNw==
X-Gm-Message-State: AOAM5333M2ev94YqpzXScaqXPtMErBtDNEIJ+EB6IzJX9+lDwiV3iVkY
        EZZH+ZVF2TGzlulOjJSNSNE71g==
X-Google-Smtp-Source: ABdhPJyDb6MSSsrxeaZ0Ak/n2fUOzh8hKJoprG7a4vmxqPmZhO/GHAqyfWZv5CNERO41midRYzTR3g==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr19958992wrw.97.1605548279761;
        Mon, 16 Nov 2020 09:37:59 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:59 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 41/43] drm/radeon/evergreen_cs: Move 'r600_dma_cs_next_reloc()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:58 +0000
Message-Id: <20201116173700.1830487-42-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/r600_cs.c:2343:5: warning: no previous prototype for ‘r600_dma_cs_next_reloc’ [-Wmissing-prototypes]
 2343 | int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
 | ^~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/evergreen_cs.c | 3 +--
 drivers/gpu/drm/radeon/r600.h         | 4 ++++
 drivers/gpu/drm/radeon/r600_cs.c      | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/evergreen_cs.c b/drivers/gpu/drm/radeon/evergreen_cs.c
index 53b75cf201958..0de79f3a7e3ff 100644
--- a/drivers/gpu/drm/radeon/evergreen_cs.c
+++ b/drivers/gpu/drm/radeon/evergreen_cs.c
@@ -28,6 +28,7 @@
 
 #include "radeon.h"
 #include "radeon_asic.h"
+#include "r600.h"
 #include "evergreend.h"
 #include "evergreen_reg_safe.h"
 #include "cayman_reg_safe.h"
@@ -37,8 +38,6 @@
 
 #define REG_SAFE_BM_SIZE ARRAY_SIZE(evergreen_reg_safe_bm)
 
-int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
-			   struct radeon_bo_list **cs_reloc);
 struct evergreen_cs_track {
 	u32			group_size;
 	u32			nbanks;
diff --git a/drivers/gpu/drm/radeon/r600.h b/drivers/gpu/drm/radeon/r600.h
index e66ef58706cd8..dbdff4568516b 100644
--- a/drivers/gpu/drm/radeon/r600.h
+++ b/drivers/gpu/drm/radeon/r600.h
@@ -28,10 +28,14 @@
 #ifndef __R600_H__
 #define __R600_H__
 
+struct radeon_bo_list;
+struct radeon_cs_parser;
 struct radeon_device;
 
 u32 r600_gpu_check_soft_reset(struct radeon_device *rdev);
 int r600_ih_ring_alloc(struct radeon_device *rdev);
 void r600_ih_ring_fini(struct radeon_device *rdev);
 
+int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
+			   struct radeon_bo_list **cs_reloc);
 #endif				/* __R600_H__ */
diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index f20b619466816..dc68e538d5a97 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -29,6 +29,7 @@
 
 #include "radeon.h"
 #include "radeon_asic.h"
+#include "r600.h"
 #include "r600d.h"
 #include "r600_reg_safe.h"
 
-- 
2.25.1

