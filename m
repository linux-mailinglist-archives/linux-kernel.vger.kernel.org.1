Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56EBE2B4CF5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733011AbgKPRa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732997AbgKPRa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:30:26 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33101C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:26 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id 19so14948wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1uDD7eJYKIFmY2+cEE1XxDSSI80DfvhehKV0mcsFfw=;
        b=o0MK8NtsTRs/ZWz0Yv2EtePitO02CnYQar/CZQCn4okitC87ZYMzK2zZrmhKuM79DQ
         yWHkkAnv3yEhErOBgXePkRZbAuLotBk01S4/LzZMkX7rRpPxGYkZB0jT8G7AgYAXDI/H
         AUhgqt9aiVuBzr9lOK5CMDB1SMCEozqjoY5Wzls4cPHVNSTJlbmoT6cFL732JB/OVVV9
         r4mlyw5yot9EXfwmVbzFMDUsY5d20uf4+engxelKmyKd+fYik8jLOwWKK/FpMvzzP+iH
         84t3hOspghWPUWu2vQ0bM+QoXtPkyT7qn7qF7QrX1wZFutC/dukTugklJGpHrLgIm+cm
         CC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1uDD7eJYKIFmY2+cEE1XxDSSI80DfvhehKV0mcsFfw=;
        b=lHuFbu0l39oAsmSnhmJpUFyiXu9ahIndxwyG7WEhGAPyLCbkR5YhMFK01Y+/lWTTa2
         +yrSLpBkGLrt1dznzFKszRoQRceWBnvZxGKcQ32SBVXix91/71AyxAijJdawVJty09S9
         WnxnsHDy5d7HeVsbE3xpBjCcfSk6WurjM7tfaasfA6DhxIFIydhDmgB+UBIAHv54NA7x
         N4VW9ywgcvtlqFlnHcny1aniOPA81W/FE8QR0vc7JVn0cAB5bAPeEcXWIlJdMXFSxB0T
         +zRLtM7Nh2KTuOOO08uJl+aYwZ/KTzbKLSXc6D0LSz4BtddyN7CBozaEuF5QgiAomsdd
         4anw==
X-Gm-Message-State: AOAM5315dKts4eAzFuWe3TgQHu3p7A+C9j6hW7j9FHMLW/CZ5aGrRd+r
        w+doXVQBZa86ONOPhf3DaO1tNw==
X-Google-Smtp-Source: ABdhPJxP1jiX3vWBaRrnT6xfK9ix3sHp+39Z1IkIj4Uyx3d1kh6V0rrHwW1U1s2iVOm9iw/ZIbzIxg==
X-Received: by 2002:a1c:d0:: with SMTP id 199mr16366893wma.148.1605547824855;
        Mon, 16 Nov 2020 09:30:24 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id f23sm20054854wmb.43.2020.11.16.09.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:30:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 12/43] drm/radeon/evergreen: Move 'evergreen_*' and 'sumo_*' prototypes out to shared location
Date:   Mon, 16 Nov 2020 17:29:34 +0000
Message-Id: <20201116173005.1825880-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201116173005.1825880-1-lee.jones@linaro.org>
References: <20201116173005.1825880-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/evergreen.c:1281:6: warning: no previous prototype for ‘evergreen_fix_pci_max_read_req_size’ [-Wmissing-prototypes]
 1281 | void evergreen_fix_pci_max_read_req_size(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:2664:6: warning: no previous prototype for ‘evergreen_mc_stop’ [-Wmissing-prototypes]
 2664 | void evergreen_mc_stop(struct radeon_device *rdev, struct evergreen_mc_save *save)
 | ^~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:2762:6: warning: no previous prototype for ‘evergreen_mc_resume’ [-Wmissing-prototypes]
 2762 | void evergreen_mc_resume(struct radeon_device *rdev, struct evergreen_mc_save *save)
 | ^~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:2850:6: warning: no previous prototype for ‘evergreen_mc_program’ [-Wmissing-prototypes]
 2850 | void evergreen_mc_program(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:3710:5: warning: no previous prototype for ‘evergreen_mc_init’ [-Wmissing-prototypes]
 3710 | int evergreen_mc_init(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:3769:6: warning: no previous prototype for ‘evergreen_print_gpu_status_regs’ [-Wmissing-prototypes]
 3769 | void evergreen_print_gpu_status_regs(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:3797:6: warning: no previous prototype for ‘evergreen_is_display_hung’ [-Wmissing-prototypes]
 3797 | bool evergreen_is_display_hung(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:4009:6: warning: no previous prototype for ‘evergreen_gpu_pci_config_reset’ [-Wmissing-prototypes]
 4009 | void evergreen_gpu_pci_config_reset(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:4110:6: warning: no previous prototype for ‘sumo_rlc_fini’ [-Wmissing-prototypes]
 4110 | void sumo_rlc_fini(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:4153:5: warning: no previous prototype for ‘sumo_rlc_init’ [-Wmissing-prototypes]
 4153 | int sumo_rlc_init(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:4381:5: warning: no previous prototype for ‘evergreen_rlc_resume’ [-Wmissing-prototypes]
 4381 | int evergreen_rlc_resume(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~
 drivers/gpu/drm/radeon/evergreen.c:4670:6: warning: no previous prototype for ‘evergreen_irq_suspend’ [-Wmissing-prototypes]
 4670 | void evergreen_irq_suspend(struct radeon_device *rdev)
 | ^~~~~~~~~~~~~~~~~~~~~

NB: Lots more of these - snipped for brevity

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/cik.c       |  6 +---
 drivers/gpu/drm/radeon/evergreen.c |  1 +
 drivers/gpu/drm/radeon/evergreen.h | 51 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/radeon/ni.c        | 16 +---------
 drivers/gpu/drm/radeon/si.c        |  7 +---
 5 files changed, 55 insertions(+), 26 deletions(-)
 create mode 100644 drivers/gpu/drm/radeon/evergreen.h

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index abf370e16bd9f..315c4f3df3656 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -30,6 +30,7 @@
 #include <drm/drm_vblank.h>
 
 #include "atom.h"
+#include "evergreen.h"
 #include "cik_blit_shaders.h"
 #include "cikd.h"
 #include "clearstate_ci.h"
@@ -126,11 +127,6 @@ MODULE_FIRMWARE("radeon/mullins_sdma.bin");
 
 extern int r600_ih_ring_alloc(struct radeon_device *rdev);
 extern void r600_ih_ring_fini(struct radeon_device *rdev);
-extern void evergreen_mc_stop(struct radeon_device *rdev, struct evergreen_mc_save *save);
-extern void evergreen_mc_resume(struct radeon_device *rdev, struct evergreen_mc_save *save);
-extern bool evergreen_is_display_hung(struct radeon_device *rdev);
-extern void sumo_rlc_fini(struct radeon_device *rdev);
-extern int sumo_rlc_init(struct radeon_device *rdev);
 extern void si_vram_gtt_location(struct radeon_device *rdev, struct radeon_mc *mc);
 extern void si_rlc_reset(struct radeon_device *rdev);
 extern void si_init_uvd_internal_cg(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 9a1e240b07234..f860f5ef2df88 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -32,6 +32,7 @@
 #include "atom.h"
 #include "avivod.h"
 #include "rv770.h"
+#include "evergreen.h"
 #include "evergreen_blit_shaders.h"
 #include "evergreen_reg.h"
 #include "evergreend.h"
diff --git a/drivers/gpu/drm/radeon/evergreen.h b/drivers/gpu/drm/radeon/evergreen.h
new file mode 100644
index 0000000000000..30c9ca99ced90
--- /dev/null
+++ b/drivers/gpu/drm/radeon/evergreen.h
@@ -0,0 +1,51 @@
+/* radeon_evergreen.h -- Private header for radeon driver -*- linux-c -*-
+ *
+ * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
+ * Copyright 2000 VA Linux Systems, Inc., Fremont, California.
+ * All rights reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the next
+ * paragraph) shall be included in all copies or substantial portions of the
+ * Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * PRECISION INSIGHT AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __RADEON_EVERGREEN_H__
+#define __RADEON_EVERGREEN_H__
+
+struct evergreen_mc_save;
+struct radeon_device;
+
+bool evergreen_is_display_hung(struct radeon_device *rdev);
+void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
+void evergreen_mc_stop(struct radeon_device *rdev, struct evergreen_mc_save *save);
+void evergreen_mc_resume(struct radeon_device *rdev, struct evergreen_mc_save *save);
+int evergreen_mc_wait_for_idle(struct radeon_device *rdev);
+void evergreen_mc_program(struct radeon_device *rdev);
+void evergreen_irq_suspend(struct radeon_device *rdev);
+int evergreen_mc_init(struct radeon_device *rdev);
+void evergreen_fix_pci_max_read_req_size(struct radeon_device *rdev);
+void evergreen_pcie_gen2_enable(struct radeon_device *rdev);
+void evergreen_program_aspm(struct radeon_device *rdev);
+void sumo_rlc_fini(struct radeon_device *rdev);
+int sumo_rlc_init(struct radeon_device *rdev);
+void evergreen_gpu_pci_config_reset(struct radeon_device *rdev);
+u32 evergreen_get_number_of_dram_channels(struct radeon_device *rdev);
+void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
+
+#endif				/* __RADEON_EVERGREEN_H__ */
diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 564a775b4b90c..1c9030a4631b8 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -32,6 +32,7 @@
 #include "atom.h"
 #include "cayman_blit_shaders.h"
 #include "clearstate_cayman.h"
+#include "evergreen.h"
 #include "ni_reg.h"
 #include "nid.h"
 #include "radeon.h"
@@ -190,21 +191,6 @@ static const u32 tn_rlc_save_restore_register_list[] =
 	0x802c,
 };
 
-extern bool evergreen_is_display_hung(struct radeon_device *rdev);
-extern void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
-extern void evergreen_mc_stop(struct radeon_device *rdev, struct evergreen_mc_save *save);
-extern void evergreen_mc_resume(struct radeon_device *rdev, struct evergreen_mc_save *save);
-extern int evergreen_mc_wait_for_idle(struct radeon_device *rdev);
-extern void evergreen_mc_program(struct radeon_device *rdev);
-extern void evergreen_irq_suspend(struct radeon_device *rdev);
-extern int evergreen_mc_init(struct radeon_device *rdev);
-extern void evergreen_fix_pci_max_read_req_size(struct radeon_device *rdev);
-extern void evergreen_pcie_gen2_enable(struct radeon_device *rdev);
-extern void evergreen_program_aspm(struct radeon_device *rdev);
-extern void sumo_rlc_fini(struct radeon_device *rdev);
-extern int sumo_rlc_init(struct radeon_device *rdev);
-extern void evergreen_gpu_pci_config_reset(struct radeon_device *rdev);
-
 /* Firmware Names */
 MODULE_FIRMWARE("radeon/BARTS_pfp.bin");
 MODULE_FIRMWARE("radeon/BARTS_me.bin");
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index de0792842af89..45076c27d7ded 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -32,6 +32,7 @@
 
 #include "atom.h"
 #include "clearstate_si.h"
+#include "evergreen.h"
 #include "radeon.h"
 #include "radeon_asic.h"
 #include "radeon_audio.h"
@@ -129,12 +130,6 @@ extern void sumo_rlc_fini(struct radeon_device *rdev);
 extern int sumo_rlc_init(struct radeon_device *rdev);
 extern int r600_ih_ring_alloc(struct radeon_device *rdev);
 extern void r600_ih_ring_fini(struct radeon_device *rdev);
-extern void evergreen_fix_pci_max_read_req_size(struct radeon_device *rdev);
-extern void evergreen_mc_stop(struct radeon_device *rdev, struct evergreen_mc_save *save);
-extern void evergreen_mc_resume(struct radeon_device *rdev, struct evergreen_mc_save *save);
-extern u32 evergreen_get_number_of_dram_channels(struct radeon_device *rdev);
-extern void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
-extern bool evergreen_is_display_hung(struct radeon_device *rdev);
 static void si_enable_gui_idle_interrupt(struct radeon_device *rdev,
 					 bool enable);
 static void si_init_pg(struct radeon_device *rdev);
-- 
2.25.1

