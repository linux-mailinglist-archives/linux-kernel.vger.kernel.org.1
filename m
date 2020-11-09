Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6212AC6FE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731676AbgKIVTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731577AbgKIVTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:19:43 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6749C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 13:19:42 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so10364770wrf.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 13:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyuOZ6WFceJf3q5HhUHXf3izEYZKAnZdbW02BpgTuA4=;
        b=ia6Ly/NDi9+1f1MROT2EMD4YRQgmF6pBC/ImFkzNoFNFyXq1oRlxFh2uqMhXnE6lbQ
         9XLcWdf7NjOGxRxtuv2UN22kTINyIyTfXWFGkK5Sm5i1RBc4bzAIHMXCd0J4sTI7vWJ+
         ASGDsFl+nL2+zeJ8sPajMBI5ZgSuPpkBRgxhTJLf6f3M+0GfIyYKGUlgBFv7H3Ys8lqi
         NuQO4QbSbYtEIowXUA/uPVYkSvdwGoFjjw3IrR2Z57nIhvQjI6y41eAqmfnFG+dXAK4u
         6zbri2xyInD457VBa3Kh8Izq/xDjxGZQw+Nb1wcYAJx7wPaRoICKqqQVzzRaI6qWz5q0
         /qJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyuOZ6WFceJf3q5HhUHXf3izEYZKAnZdbW02BpgTuA4=;
        b=G04sig5eV0Om7pZE02vllGoJycA/SGAqkd+D4JfAt2V8Oubl5EGz5whCZusWQPY2GI
         P6uzLZxg7qJVrGMV7+bIHgn6d/OBJ349P+0XjpYeE+ZqNb2Zbd45sHSu5zp2dRfcxHug
         xibmEJsDQBpX9nn9mtZBKpEtYJeiShKftxQ9K1AYt1IBkafru34QrPnFOlDNJxxDTQKh
         hsMrdA62aknqXDzYVJeqLkHBY0VP2+WShZml0IAUrTYJAvG8vKT4CBUdwz6RcRLnhpO+
         RCX3ihciKkB1o8bIMkm5IfhoGECj4rzq8w9Nn5+0kzDygmkGjztjOonQzsLqwOaAjDUD
         LJyw==
X-Gm-Message-State: AOAM530TeJSqu1EashtybwggbKoaPQqBtd4Sa6XR25vKXtZEzlOB5m6L
        JN33Tsd65+05TOORF0JDWbKAhw==
X-Google-Smtp-Source: ABdhPJwM8fgkq83zLEn8x192TrR2+IvKlZilWv/ozJBOiKhgMSaI6czM8/ut/dVksivEdrWLd8zUQA==
X-Received: by 2002:adf:b78b:: with SMTP id s11mr12746859wre.42.1604956781612;
        Mon, 09 Nov 2020 13:19:41 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 71sm15170630wrm.20.2020.11.09.13.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 13:19:41 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 17/20] drm/radeon/evergreend: Move 'evergreen_*' and 'sumo_*' prototypes out to shared location
Date:   Mon,  9 Nov 2020 21:18:52 +0000
Message-Id: <20201109211855.3340030-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201109211855.3340030-1-lee.jones@linaro.org>
References: <20201109211855.3340030-1-lee.jones@linaro.org>
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
 drivers/gpu/drm/radeon/ni.c     | 16 ----------------
 drivers/gpu/drm/radeon/radeon.h | 23 +++++++++++++++++++++++
 drivers/gpu/drm/radeon/si.c     |  6 ------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 02feb0801fd30..91bba473f2703 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -38,7 +38,6 @@
 #include "radeon_asic.h"
 #include "radeon_audio.h"
 #include "radeon_ucode.h"
-
 /*
  * Indirect registers accessor
  */
@@ -190,21 +189,6 @@ static const u32 tn_rlc_save_restore_register_list[] =
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
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 1cbbaff7cede2..3e53a9493ae92 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2951,6 +2951,29 @@ extern u32 r6xx_remap_render_backend(struct radeon_device *rdev,
 extern int ni_init_microcode(struct radeon_device *rdev);
 extern int ni_mc_load_microcode(struct radeon_device *rdev);
 
+/*
+ * evergreen functions used by ni.c and si.c
+ */
+
+struct evergreen_mc_save;
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
 /* radeon_acpi.c */
 #if defined(CONFIG_ACPI)
 extern int radeon_acpi_init(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 93dcab548a835..8b80884990aee 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -129,12 +129,6 @@ extern void sumo_rlc_fini(struct radeon_device *rdev);
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

