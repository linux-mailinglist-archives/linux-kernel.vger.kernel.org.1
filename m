Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13252B4D95
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733128AbgKPRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387451AbgKPRhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:37:46 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F11C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:45 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id s8so19610883wrw.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F+vpUFKiF0HcP1zSRTFbAOX8pFoOA6PVK8Wzkj+zQXI=;
        b=sfgrxMG6CmVvxPp4PJ5OjjRHPczlJjKdH29Zymx3hfYfE28kkaxjfDWAx0nuOk+ddu
         ewVWB5vaa58WzoSuaKOe1y49Hirs7sGkZqF336HJXZqwi3+TilGnTvhmW7jNA+MmJVqG
         JQK6/e26iVfnIxjfwdOu4dgSMMxubz6qKpAu+soYAhohpvOFjnUIwxArHRVpuLZSFunx
         Sgee/pS7pRG9DTBsJujcROkhpOINwa00CJ6ZoBCiwcxI3O+iWhzxws4OjIo8XDqeSMSR
         uROJx71BUPkebIoSl/3XMWCrOKn+QNPS3p0MHC7DJqKD9yLppbd8PXwlGPpEP31XSpWa
         9b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F+vpUFKiF0HcP1zSRTFbAOX8pFoOA6PVK8Wzkj+zQXI=;
        b=IQtoEheVKv8cN7tBBID5By85SxA58b3W2/KpVvzbGEoedA0+R49qJFnp5RwSTQD7KE
         I9IJGfsQKLXdJ+mibTggEBSb8NJYJujFfeSE4MUAdLrz7McBUSnTE2k2ujQLKKnEMHmk
         /s7FWyBAfqVnZqmoV3WikOhLvJUr9gZg8eEjDBm7G/GyY6+GQpBL2FPP0TC1dSeQfj2d
         iR/hbvCrkOcsV6yvrgS7rdrxp0H4dscDl/Am/Z0Qcv4sAIHeAmmEymwFDtW+811ARN/F
         tLBuP5tY+TVXlb6pkSbquC9BPUxFGqQKBw62RmBi7QQz+apBhNrhVvOxbxXloDk0KNNK
         /WCA==
X-Gm-Message-State: AOAM531MmG24W2F76PuAd4xqewRCnJVRyHvKQep4iWYh7M/tx9W0ylAm
        i/lNf3DxM1S73wm68s/frH72Cw==
X-Google-Smtp-Source: ABdhPJxabV2dqaOH00x783/4blA0QVK+CVrO53x1r1AXui8K5KdtLxjQf5SCZ94kqTgAUzFpUxxw4A==
X-Received: by 2002:a5d:488b:: with SMTP id g11mr21841442wrq.210.1605548264298;
        Mon, 16 Nov 2020 09:37:44 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id 30sm16942828wrd.88.2020.11.16.09.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:37:43 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 29/43] drm/radeon/si_dpm: Move 'si_mc_load_microcode()'s prototype to shared header
Date:   Mon, 16 Nov 2020 17:36:46 +0000
Message-Id: <20201116173700.1830487-30-lee.jones@linaro.org>
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

 drivers/gpu/drm/radeon/si.c:1570:5: warning: no previous prototype for ‘si_mc_load_microcode’ [-Wmissing-prototypes]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/si.c     |  1 +
 drivers/gpu/drm/radeon/si.h     | 31 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/radeon/si_dpm.c |  2 +-
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/radeon/si.h

diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index d0407145c07b5..88731b79c8f57 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -39,6 +39,7 @@
 #include "radeon_audio.h"
 #include "radeon_ucode.h"
 #include "si_blit_shaders.h"
+#include "si.h"
 #include "sid.h"
 
 
diff --git a/drivers/gpu/drm/radeon/si.h b/drivers/gpu/drm/radeon/si.h
new file mode 100644
index 0000000000000..0a5018ef166e2
--- /dev/null
+++ b/drivers/gpu/drm/radeon/si.h
@@ -0,0 +1,31 @@
+/* si.h -- Private header for radeon driver -*- linux-c -*-
+ *
+ * Copyright 2011 Advanced Micro Devices, Inc.
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
+ */
+
+#ifndef __SI_H__
+#define __SI_H__
+
+struct radeon_device;
+
+int si_mc_load_microcode(struct radeon_device *rdev);
+
+#endif                         /* __SI_H__ */
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index c68ab2fb1ac23..32b697965c064 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -32,6 +32,7 @@
 #include "radeon_asic.h"
 #include "ni_dpm.h"
 #include "si_dpm.h"
+#include "si.h"
 #include "sid.h"
 
 #define MC_CG_ARB_FREQ_F0           0x0a
@@ -1721,7 +1722,6 @@ static const struct si_powertune_data powertune_data_hainan =
 
 struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev);
 
-extern int si_mc_load_microcode(struct radeon_device *rdev);
 extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable);
 
 static int si_populate_voltage_value(struct radeon_device *rdev,
-- 
2.25.1

