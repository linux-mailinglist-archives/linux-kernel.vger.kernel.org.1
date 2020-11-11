Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533982AF83A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgKKSgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgKKSgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:36:17 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7FDC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so3492424wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1BMpKgrGRaaFsrowXlZeUlkXnTCJQ5S+7+zF8aRI5RM=;
        b=gv9rARHr4D0R1XbUNjjQpIHG+8Ukz+VROemjmN9deTxOLLwa57CGwe7Yw2nPVD5LkI
         x7sBA5S4Izl8Y+DLOybIvelf93pnTPj30GwSDjNqThbgY52WPq9pGugtalPjo4Me6wOi
         v3Wf9SH9nuttFyN/EE8mWWiXT3JxVUq06ieJknk5W231WtKu0+8a6uSy7vdh1HVUK8ea
         2AC/M3H/iD7QdDK/feCxSxKB0ScDF6vwy8oQrAZTdgXy/8X1ALdG+Vxo9y/csOsWa8Qz
         txo6oqrG/NN9rdWgI6GsC3//RR1aBRg7CpXQRIiN8lqFXulSkUJ5ArqmT2m75r2FCIsu
         /yXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1BMpKgrGRaaFsrowXlZeUlkXnTCJQ5S+7+zF8aRI5RM=;
        b=o9t/8EhcT1M+7zNAW06TeTKNq0LA991drKwotEh52wohXJd4bw8bh4yXmJTQhvivpq
         K8hiTKGpuBJT87Bo59ZOuAWZxWOCMV7zibeIaV0mW4K56HoRHe8L1xsbvOk8C7Ri8Xxr
         aVoTQwpMLwqLafsXuDF6ThsiBLr9JDH6CHHR9FaTLxYmYkQWST+iXzyfhx7wwXAutZpX
         1Bx5dOJwmfeOe95dQpmXbwha70QZcVfjcT2dIqrdRfbQete3DZHSku8NYmzre8p5FBB5
         DUwtBVw7391G0Ow8Ne0N2XxN7Q0Xs15YtKmOFFqOu+CdqjPp4t6NLMso5T78vhGaGJ2f
         pTdA==
X-Gm-Message-State: AOAM530IoPl39mShX2z9z8CxE87rv+UhlH8T0Pw3HUifjj4yyPBaX10p
        EY9WQAt8ivnpgmqq/Z1kczgjcUFF6sZdjN71
X-Google-Smtp-Source: ABdhPJyUfP02CiM21bckjb6v/8zvCckUDUA51nDOma7tQN+Oa6OdUY9rQNKYPeBoyCSxr/LkFz5tnQ==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr33192388wrs.178.1605119775741;
        Wed, 11 Nov 2020 10:36:15 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:36:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 19/19] drm/radeon/evergreen_cs: Move 'r600_dma_cs_next_reloc()'s prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:45 +0000
Message-Id: <20201111183545.1756994-20-lee.jones@linaro.org>
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
index a259976a95913..21fe44198a966 100644
--- a/drivers/gpu/drm/radeon/r600.h
+++ b/drivers/gpu/drm/radeon/r600.h
@@ -29,7 +29,9 @@
 #define __R600_H__
 
 struct r600_audio_pin;
+struct radeon_bo_list;
 struct radeon_crtc;
+struct radeon_cs_parser;
 struct radeon_device;
 struct radeon_hdmi_acr;
 
@@ -50,4 +52,6 @@ void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
 void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
 void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
 
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

