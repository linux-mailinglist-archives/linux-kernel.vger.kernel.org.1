Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD43C2ADFB6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732900AbgKJTeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731613AbgKJTb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:31:27 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189BC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:26 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so4341720wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EMKJYN4cADZ/51nOTydJW9dcnK9yEI29SFRHcdhKjx0=;
        b=tmfnWr1PFAZjvFUoR70C/EeiHh5YP6TtNv8y7lYw9Nw/feqC/lAHTDFMby7fV5FYcU
         Xba3hs1WRtRejNsmv02L/hFQLaAYQDGw6Och/0RDZf6Ho1Amyy0v8jPCl2v4pRL715vh
         4XrOLlYqOBrdIoiV//72GwFAqDwm38Ob165dWEIj1YbMTku/gm1pH8F4vhZe9F7BoK0C
         qG3uSnS1N2HGx9nyo23hGifKjDayTPAB7nk1cnK3ZhwdAyZvOd8xei3kfhXCOJUU21Yy
         pMyLIP58Uo9TymtizzG224a6YIiOduHQ64qsLYpu1vtbBoYwqJdERv9byTxsUSlKAXZE
         QACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EMKJYN4cADZ/51nOTydJW9dcnK9yEI29SFRHcdhKjx0=;
        b=XQxDUjCtx7nwZGxUGv7u+L7Qu+X/XiKa0Qkol1gCGkB+hIAXYBAAWhENaDe/4AECJC
         UzWWcVMw6yFjpSA6LQKLlswM+8+mBExMEfQGRRHN6RN7xE15r8i2P94xliWO5Dyyqj5e
         qLTJhSWlah/dbv4bXxRoZZA+EmQygxbWVCx2e2bEXwrTZ3ysMTqdp+U24HJRsxpLSHwh
         yGP03+IFhTD11zJX7jEA7H3X07wNc9ayTqwVgFSnM8FtlROoXSpluNU9PTyQXuoFC/iA
         9knb00LLSawwHMVyAxR8Gl4J4QnSEAO7Z2dzqtkwLmMISGnI3KXnyg9Ily6/Ir3E1mgJ
         S3zg==
X-Gm-Message-State: AOAM531dKVaFHhkeml4bgg+9++sW+8j9sj9IW88LfbObiben2pJgSjBP
        IH6+SJiwP3MCWZRI/2P3MKcp+Q==
X-Google-Smtp-Source: ABdhPJxrbn865pa+UCi0erSAXQ2pS/9WWnTcZgMUBaoEYzX0Vkb0Z8f1dsA8oecg7rHXf54RhODuXg==
X-Received: by 2002:a1c:3846:: with SMTP id f67mr750176wma.33.1605036685081;
        Tue, 10 Nov 2020 11:31:25 -0800 (PST)
Received: from dell.default ([91.110.221.139])
        by smtp.gmail.com with ESMTPSA id 30sm17635335wrs.84.2020.11.10.11.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:31:24 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 07/30] drm/radeon/kv_dpm: Strip out unused functions and their tables
Date:   Tue, 10 Nov 2020 19:30:49 +0000
Message-Id: <20201110193112.988999-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201110193112.988999-1-lee.jones@linaro.org>
References: <20201110193112.988999-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These haven't been used since the driver was upstreamed in 2013.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/radeon/kv_dpm.c:161:40: warning: ‘cpl_cac_config_reg’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:156:40: warning: ‘mc3_cac_config_reg’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:151:40: warning: ‘mc2_cac_config_reg’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:146:40: warning: ‘mc1_cac_config_reg’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:141:40: warning: ‘mc0_cac_config_reg’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:136:40: warning: ‘sx0_cac_config_reg’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:104:43: warning: ‘cpl_local_cac_cfg_kv’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:98:43: warning: ‘mc3_local_cac_cfg_kv’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:92:43: warning: ‘mc2_local_cac_cfg_kv’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:86:43: warning: ‘mc1_local_cac_cfg_kv’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:80:43: warning: ‘mc0_local_cac_cfg_kv’ defined but not used [-Wunused-const-variable=]
 drivers/gpu/drm/radeon/kv_dpm.c:67:43: warning: ‘sx_local_cac_cfg_kv’ defined but not used [-Wunused-const-variable=]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/radeon/kv_dpm.c | 205 +-------------------------------
 1 file changed, 1 insertion(+), 204 deletions(-)

diff --git a/drivers/gpu/drm/radeon/kv_dpm.c b/drivers/gpu/drm/radeon/kv_dpm.c
index 5e6086eb18073..f7735da07feb9 100644
--- a/drivers/gpu/drm/radeon/kv_dpm.c
+++ b/drivers/gpu/drm/radeon/kv_dpm.c
@@ -64,105 +64,6 @@ extern void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
 extern void cik_update_cg(struct radeon_device *rdev,
 			  u32 block, bool enable);
 
-static const struct kv_lcac_config_values sx_local_cac_cfg_kv[] =
-{
-	{  0,       4,        1    },
-	{  1,       4,        1    },
-	{  2,       5,        1    },
-	{  3,       4,        2    },
-	{  4,       1,        1    },
-	{  5,       5,        2    },
-	{  6,       6,        1    },
-	{  7,       9,        2    },
-	{ 0xffffffff }
-};
-
-static const struct kv_lcac_config_values mc0_local_cac_cfg_kv[] =
-{
-	{  0,       4,        1    },
-	{ 0xffffffff }
-};
-
-static const struct kv_lcac_config_values mc1_local_cac_cfg_kv[] =
-{
-	{  0,       4,        1    },
-	{ 0xffffffff }
-};
-
-static const struct kv_lcac_config_values mc2_local_cac_cfg_kv[] =
-{
-	{  0,       4,        1    },
-	{ 0xffffffff }
-};
-
-static const struct kv_lcac_config_values mc3_local_cac_cfg_kv[] =
-{
-	{  0,       4,        1    },
-	{ 0xffffffff }
-};
-
-static const struct kv_lcac_config_values cpl_local_cac_cfg_kv[] =
-{
-	{  0,       4,        1    },
-	{  1,       4,        1    },
-	{  2,       5,        1    },
-	{  3,       4,        1    },
-	{  4,       1,        1    },
-	{  5,       5,        1    },
-	{  6,       6,        1    },
-	{  7,       9,        1    },
-	{  8,       4,        1    },
-	{  9,       2,        1    },
-	{  10,      3,        1    },
-	{  11,      6,        1    },
-	{  12,      8,        2    },
-	{  13,      1,        1    },
-	{  14,      2,        1    },
-	{  15,      3,        1    },
-	{  16,      1,        1    },
-	{  17,      4,        1    },
-	{  18,      3,        1    },
-	{  19,      1,        1    },
-	{  20,      8,        1    },
-	{  21,      5,        1    },
-	{  22,      1,        1    },
-	{  23,      1,        1    },
-	{  24,      4,        1    },
-	{  27,      6,        1    },
-	{  28,      1,        1    },
-	{ 0xffffffff }
-};
-
-static const struct kv_lcac_config_reg sx0_cac_config_reg[] =
-{
-	{ 0xc0400d00, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
-};
-
-static const struct kv_lcac_config_reg mc0_cac_config_reg[] =
-{
-	{ 0xc0400d30, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
-};
-
-static const struct kv_lcac_config_reg mc1_cac_config_reg[] =
-{
-	{ 0xc0400d3c, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
-};
-
-static const struct kv_lcac_config_reg mc2_cac_config_reg[] =
-{
-	{ 0xc0400d48, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
-};
-
-static const struct kv_lcac_config_reg mc3_cac_config_reg[] =
-{
-	{ 0xc0400d54, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
-};
-
-static const struct kv_lcac_config_reg cpl_cac_config_reg[] =
-{
-	{ 0xc0400d80, 0x003e0000, 17, 0x3fc00000, 22, 0x0001fffe, 1, 0x00000001, 0 }
-};
-
 static const struct kv_pt_config_reg didt_config_kv[] =
 {
 	{ 0x10, 0x000000ff, 0, 0x0, KV_CONFIGREG_DIDT_IND },
@@ -254,32 +155,6 @@ static struct kv_power_info *kv_get_pi(struct radeon_device *rdev)
 	return pi;
 }
 
-#if 0
-static void kv_program_local_cac_table(struct radeon_device *rdev,
-				       const struct kv_lcac_config_values *local_cac_table,
-				       const struct kv_lcac_config_reg *local_cac_reg)
-{
-	u32 i, count, data;
-	const struct kv_lcac_config_values *values = local_cac_table;
-
-	while (values->block_id != 0xffffffff) {
-		count = values->signal_id;
-		for (i = 0; i < count; i++) {
-			data = ((values->block_id << local_cac_reg->block_shift) &
-				local_cac_reg->block_mask);
-			data |= ((i << local_cac_reg->signal_shift) &
-				 local_cac_reg->signal_mask);
-			data |= ((values->t << local_cac_reg->t_shift) &
-				 local_cac_reg->t_mask);
-			data |= ((1 << local_cac_reg->enable_shift) &
-				 local_cac_reg->enable_mask);
-			WREG32_SMC(local_cac_reg->cntl, data);
-		}
-		values++;
-	}
-}
-#endif
-
 static int kv_program_pt_config_registers(struct radeon_device *rdev,
 					  const struct kv_pt_config_reg *cac_config_regs)
 {
@@ -398,39 +273,6 @@ static int kv_enable_didt(struct radeon_device *rdev, bool enable)
 	return 0;
 }
 
-#if 0
-static void kv_initialize_hardware_cac_manager(struct radeon_device *rdev)
-{
-	struct kv_power_info *pi = kv_get_pi(rdev);
-
-	if (pi->caps_cac) {
-		WREG32_SMC(LCAC_SX0_OVR_SEL, 0);
-		WREG32_SMC(LCAC_SX0_OVR_VAL, 0);
-		kv_program_local_cac_table(rdev, sx_local_cac_cfg_kv, sx0_cac_config_reg);
-
-		WREG32_SMC(LCAC_MC0_OVR_SEL, 0);
-		WREG32_SMC(LCAC_MC0_OVR_VAL, 0);
-		kv_program_local_cac_table(rdev, mc0_local_cac_cfg_kv, mc0_cac_config_reg);
-
-		WREG32_SMC(LCAC_MC1_OVR_SEL, 0);
-		WREG32_SMC(LCAC_MC1_OVR_VAL, 0);
-		kv_program_local_cac_table(rdev, mc1_local_cac_cfg_kv, mc1_cac_config_reg);
-
-		WREG32_SMC(LCAC_MC2_OVR_SEL, 0);
-		WREG32_SMC(LCAC_MC2_OVR_VAL, 0);
-		kv_program_local_cac_table(rdev, mc2_local_cac_cfg_kv, mc2_cac_config_reg);
-
-		WREG32_SMC(LCAC_MC3_OVR_SEL, 0);
-		WREG32_SMC(LCAC_MC3_OVR_VAL, 0);
-		kv_program_local_cac_table(rdev, mc3_local_cac_cfg_kv, mc3_cac_config_reg);
-
-		WREG32_SMC(LCAC_CPL_OVR_SEL, 0);
-		WREG32_SMC(LCAC_CPL_OVR_VAL, 0);
-		kv_program_local_cac_table(rdev, cpl_local_cac_cfg_kv, cpl_cac_config_reg);
-	}
-}
-#endif
-
 static int kv_enable_smc_cac(struct radeon_device *rdev, bool enable)
 {
 	struct kv_power_info *pi = kv_get_pi(rdev);
@@ -1227,9 +1069,7 @@ int kv_dpm_enable(struct radeon_device *rdev)
 		return ret;
 	}
 	kv_program_vc(rdev);
-#if 0
-	kv_initialize_hardware_cac_manager(rdev);
-#endif
+
 	kv_start_am(rdev);
 	if (pi->enable_auto_thermal_throttling) {
 		ret = kv_enable_auto_thermal_throttling(rdev);
@@ -1330,26 +1170,6 @@ void kv_dpm_disable(struct radeon_device *rdev)
 	kv_update_current_ps(rdev, rdev->pm.dpm.boot_ps);
 }
 
-#if 0
-static int kv_write_smc_soft_register(struct radeon_device *rdev,
-				      u16 reg_offset, u32 value)
-{
-	struct kv_power_info *pi = kv_get_pi(rdev);
-
-	return kv_copy_bytes_to_smc(rdev, pi->soft_regs_start + reg_offset,
-				    (u8 *)&value, sizeof(u16), pi->sram_end);
-}
-
-static int kv_read_smc_soft_register(struct radeon_device *rdev,
-				     u16 reg_offset, u32 *value)
-{
-	struct kv_power_info *pi = kv_get_pi(rdev);
-
-	return kv_read_smc_sram_dword(rdev, pi->soft_regs_start + reg_offset,
-				      value, pi->sram_end);
-}
-#endif
-
 static void kv_init_sclk_t(struct radeon_device *rdev)
 {
 	struct kv_power_info *pi = kv_get_pi(rdev);
@@ -1939,29 +1759,6 @@ void kv_dpm_setup_asic(struct radeon_device *rdev)
 	kv_init_sclk_t(rdev);
 }
 
-#if 0
-void kv_dpm_reset_asic(struct radeon_device *rdev)
-{
-	struct kv_power_info *pi = kv_get_pi(rdev);
-
-	if (rdev->family == CHIP_KABINI || rdev->family == CHIP_MULLINS) {
-		kv_force_lowest_valid(rdev);
-		kv_init_graphics_levels(rdev);
-		kv_program_bootup_state(rdev);
-		kv_upload_dpm_settings(rdev);
-		kv_force_lowest_valid(rdev);
-		kv_unforce_levels(rdev);
-	} else {
-		kv_init_graphics_levels(rdev);
-		kv_program_bootup_state(rdev);
-		kv_freeze_sclk_dpm(rdev, true);
-		kv_upload_dpm_settings(rdev);
-		kv_freeze_sclk_dpm(rdev, false);
-		kv_set_enabled_level(rdev, pi->graphics_boot_level);
-	}
-}
-#endif
-
 //XXX use sumo_dpm_display_configuration_changed
 
 static void kv_construct_max_power_limits_table(struct radeon_device *rdev,
-- 
2.25.1

