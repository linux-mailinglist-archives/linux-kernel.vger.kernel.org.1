Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251872B4D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733170AbgKPRhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgKPRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:06 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572E9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:06 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k2so19676702wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xb5oU/OD2Y3rEdVts+1SNNg+EwKMwAAR+VS8s4ifyQw=;
        b=Rp3u8JwosxZh0tOeegPBxxchLmVOYDwvYReTo37Z7mS8aEPbmb6WEaUD6M5dTaExSd
         xzcQJ4Sq1/oi3Lxxv8GqyecBWbauJ2CVW/X7CT+hhZiz9m4wmSUKFokcNvpH6fJEkPzB
         QOz8TiyiEQpjN7gUlhkDZH8soePq9CURV8V1prdX9MPZFc777IyoWRW42CCdNhNBO5Y3
         npVM63rsAmWkWqXDUYLzA/Vrq40jzzHFZ9tshka692aiawIxhXa8tYxkiqEvRKizwNkR
         uX6ikzRdIoBV7hQ+3w+iZ+3uF5yMJ2D8HpTAjwF4jqxFOuvg550DFPYirq6Vp15qcLdY
         +Nxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xb5oU/OD2Y3rEdVts+1SNNg+EwKMwAAR+VS8s4ifyQw=;
        b=EpQVZlpPgo9EBXrInm8G/+29cNrXi7q3F1ZLtrjDeV7WVwZIL/ljqqRdGaCDlznmi5
         hVAkjxjIn2i2GMw9mLxQPG/wbrLJPqV5SnvKsrMiO78iWLUojqJvWnC4CUeCR5uZbEKS
         VoEjDQ8LdbKE+SwmCxnUDaMPAq95bvrGT9NNfyGaSQTg+LCTpOh93M8qvfdvA2+CA2NK
         6Hu8xZDoLL7XTGdPGlfB/yYy6Xb62Z15NxeQDOkLISvqbSLaWVZBjCfXkKT64OW7eK6O
         mgCxitKkgep1Sed6SLX2BffuKmzz/UrDGUK8stGAXi8fd68wcfaFMPW1DRHfBJ0dNhkJ
         8P6g==
X-Gm-Message-State: AOAM532TbJmsGjPSzXuOSzKug2jxIqIYmDrZ8bsMKD8OC6jAfcBoc+Gp
        KGTjRA7ws8nXTdSAJV0J/V5sYQ==
X-Google-Smtp-Source: ABdhPJzTxMswOuqD1i5BcnjwTcSwtXU8jI63VS4MryPWVcjhcFg8WGldPf7OlqGXYfb2bWITm00heQ==
X-Received: by 2002:a5d:654b:: with SMTP id z11mr19684774wrv.291.1605548225053;
        Mon, 16 Nov 2020 09:37:05 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:04 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 01/43] drm/radeon/atombios_encoders: Move 'radeon_atom_get_tv_timings()'s prototype into shared location
Date:   Mon, 16 Nov 2020 17:36:18 +0000
Message-Id: <20201116173700.1830487-2-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/radeon_atombios.c:1791:6: warning: no previous prototype for ‘radeon_atom_get_tv_timings’ [-Wmissing-prototypes]
 1791 | bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/atombios_encoders.c |  5 +--
 drivers/gpu/drm/radeon/radeon_atombios.c   |  1 +
 drivers/gpu/drm/radeon/radeon_atombios.h   | 37 ++++++++++++++++++++++
 3 files changed, 39 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/radeon_atombios.h

diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index cc5ee1b3af84f..683de198e18d9 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -33,6 +33,7 @@
 #include <drm/radeon_drm.h>
 
 #include "atom.h"
+#include "radeon_atombios.h"
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_audio.h"
@@ -296,10 +297,6 @@ static void radeon_atom_backlight_exit(struct radeon_encoder *encoder)
 
 #endif
 
-/* evil but including atombios.h is much worse */
-bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
-				struct drm_display_mode *mode);
-
 static bool radeon_atom_mode_fixup(struct drm_encoder *encoder,
 				   const struct drm_display_mode *mode,
 				   struct drm_display_mode *adjusted_mode)
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index 5d25917251892..71bf2ed172697 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -34,6 +34,7 @@
 #include "atom.h"
 #include "atom-bits.h"
 #include "radeon_asic.h"
+#include "radeon_atombios.h"
 
 extern void
 radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_enum,
diff --git a/drivers/gpu/drm/radeon/radeon_atombios.h b/drivers/gpu/drm/radeon/radeon_atombios.h
new file mode 100644
index 0000000000000..b7c76920feb7d
--- /dev/null
+++ b/drivers/gpu/drm/radeon/radeon_atombios.h
@@ -0,0 +1,37 @@
+/* radeon_atombios.h -- Private header for radeon driver -*- linux-c -*-
+ *
+ * Copyright 2007-8 Advanced Micro Devices, Inc.
+ * Copyright 2008 Red Hat Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: Dave Airlie
+ *          Alex Deucher
+ */
+
+#ifndef __RADEON_ATOMBIOS_H__
+#define __RADEON_ATOMBIOS_H__
+
+struct drm_display_mode;
+struct radeon_device;
+
+bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
+				struct drm_display_mode *mode);
+
+#endif                         /* __RADEON_ATOMBIOS_H__ */
-- 
2.25.1

