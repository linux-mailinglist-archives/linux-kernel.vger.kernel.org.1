Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF52E2AF827
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 19:36:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgKKSgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 13:36:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbgKKSfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 13:35:55 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39388C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:55 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so3478779wrf.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 10:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eP0WyWZg5ruAlRDHyNqDbB7ackT3+aNOib1WfADr30A=;
        b=uWL7G87ad8BBVCkHBLVEpHZDR8zZqKdyrnOOfcEpLPyUY3xT+ts4pkohRGIbD+xnu8
         /Iz+STdZtJMMEoeMJaIhC356yaZnl6WUZGi47iCmWDzKV0Mu+VkcfBm4HTxKQ+RO0KA/
         HdkdQwGyTAqbmjccN90fWErcuo6zeYrO+h6Da6EK+C9xPXHLyLa6YAqONl16i3IQEvcU
         +3siVCh0rpVbt1upZqzW+MliM3OXB0129YlDV3PAHMl9JKSAwWTt9rrH9aI+w81zgyCA
         ulk7nZN40BMCJdrrUgJPMrIoFuerGLtgVecgPs39c3C4GsMjHzKzET9sK6WY6ikVhKpN
         dn6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eP0WyWZg5ruAlRDHyNqDbB7ackT3+aNOib1WfADr30A=;
        b=ARROExi301qqKU5G1sWUjrijGrpid7QbyFkgWUTYyz/IKf/effB8umSY8t+nKy33V2
         P5G+NIv+FBHVG6OvxBM3Gzvx4UygPdAu/zcCztVphvz3b6ucnXGp2xmTnmD2V/A1Q1wh
         cciH8Z/SJOL6gPFz1SxOl9EvZcvJIBIYYJYLn7FTpNpG2ivzaWVKpgnprovngozbP1h5
         gDhrKnOfMxYFGLBZjftu/bDJcU0ChpMUBFdnzRQIRCidaSNhfckFmZ/56cl/FmomU1NQ
         WIpNSc1i4TxavNCTR6Qq34lwzibXEhMlvpTdPJuov/w5ElNGInzYOjSGE700ULBtXzsN
         k0fA==
X-Gm-Message-State: AOAM532Y0BmOsQRNFEIqgUTsO22SSLIorW1mCviUcztVmg4bnvXtnNgY
        Eqx9hPqLdrizNP7OdA8kAvToHaD8wk7OxllS
X-Google-Smtp-Source: ABdhPJySQOMuzRn2OADac5SQlejJdpHY1681Ddh/ovuTq00XPGI73rfjk/KhDTqbXGIORvDN1CVW2Q==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr16771878wro.197.1605119753978;
        Wed, 11 Nov 2020 10:35:53 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id k84sm3558311wmf.42.2020.11.11.10.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 10:35:53 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 04/19] drm/radeon/radeon_atombios: Move 'radeon_add_atom_encoder()'s prototype to shared header
Date:   Wed, 11 Nov 2020 18:35:30 +0000
Message-Id: <20201111183545.1756994-5-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/atombios_encoders.c:2721:1: warning: no previous prototype for ‘radeon_add_atom_encoder’ [-Wmissing-prototypes]
 2721 | radeon_add_atom_encoder(struct drm_device *dev,
 | ^~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 4 ----
 drivers/gpu/drm/radeon/radeon_atombios.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index cc80651b25773..be96d9b64e43b 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -37,10 +37,6 @@
 #include "radeon_atombios.h"
 #include "radeon_legacy_encoders.h"
 
-extern void
-radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_enum,
-			uint32_t supported_device, u16 caps);
-
 union atom_supported_devices {
 	struct _ATOM_SUPPORTED_DEVICES_INFO info;
 	struct _ATOM_SUPPORTED_DEVICES_INFO_2 info_2;
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.h b/drivers/gpu/drm/radeon/radeon_atombios.h
index b7c76920feb7d..a895a7002c3d3 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.h
+++ b/drivers/gpu/drm/radeon/radeon_atombios.h
@@ -28,10 +28,14 @@
 #ifndef __RADEON_ATOMBIOS_H__
 #define __RADEON_ATOMBIOS_H__
 
+struct drm_device;
 struct drm_display_mode;
 struct radeon_device;
 
 bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
 				struct drm_display_mode *mode);
+void radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_enum,
+			     uint32_t supported_device, u16 caps);
+
 
 #endif                         /* __RADEON_ATOMBIOS_H__ */
-- 
2.25.1

