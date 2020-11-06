Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00F32A9F6D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 22:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgKFVuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 16:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728790AbgKFVuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 16:50:15 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F5EC0613D4
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 13:50:14 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so2779398wrc.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 13:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5L5j9WeVf4OsGrOI+zWyqNE90Jqm8OHoY/X5eer+uIE=;
        b=IOrFk0Bum8NpeO7vrbdT+XF4GBjyGBJirBDhxAK8aUBIKAcElcG4GD3NpjReOmFrTO
         LNLQT1Bp/et1mAqsqqvJwrYOwSCeu4qCr+4EFsp6WHjxr7qmDknJ+/AjCk13hiavhUqk
         UpiKHCRBbIv0f1XbNH35v08ckSZ5oFOCE93dTd66rbwUvPbqlyosD3vsT6AYCa/U9M+T
         87TTsY///sjDCxef1KSDqVk0xLrjDQmwAJ4i3URwNA8yg7RZL0mhIRV3C+lYwA8zQ0E2
         G3uwwRMXnGQ64wRyv1KqN+Y3EHHytDdE5YbYb0blE7CeA+XR9uD2xGk8ovxdFFN/d4/m
         RTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5L5j9WeVf4OsGrOI+zWyqNE90Jqm8OHoY/X5eer+uIE=;
        b=FY+XUluXiTc2xPdM+a7ITfX/wo1MBfGSkkhStOdiv/TxTLLXUqDyo5SNMoalpQG9Tg
         PUcKfL/d/OnIaKFILTk2ztOhG82rjpIpipVxDXUzQBDorCTeRE3HnYfavQq5tEHgJYad
         ScEBRjIRwNq6W2XXlpYYQsvIlrcPZiKv3STsVG0AwXTpTbBiSHAqD20keLyUE5dA9i6W
         ZqnEoPAMB7NShktFj/2m0Gw3hRdilsQ9zViQHMc1NPn0x+EQBf0Ub26YmJrREvu1i0U9
         veFtRg3UGm2ZNz50tMRW/VJal+uw8YxaBOAGl7JL1KZ8qtNY+LtovdejnRtDIqEXNUE0
         77bA==
X-Gm-Message-State: AOAM531glJTQCuo/am8GeGVPGdumBM/spbx003tC7OBkCVia0XpzIylf
        Qc5TLSTZgl8xWPSZ/A+gX+um1Q==
X-Google-Smtp-Source: ABdhPJxjy3CwhAzixHBwYh/xNEBVJ6Ej4P7uEr5YDA2+aR0KybxhQjhHm8g5KDuddWQScZEwMDoJug==
X-Received: by 2002:a5d:660e:: with SMTP id n14mr4522258wru.94.1604699413709;
        Fri, 06 Nov 2020 13:50:13 -0800 (PST)
Received: from dell.default ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id t199sm3981084wmt.46.2020.11.06.13.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 13:50:13 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 16/19] drm/amd/amdgpu/amdgpu_kms: Remove 'struct drm_amdgpu_info_device dev_info' from the stack
Date:   Fri,  6 Nov 2020 21:49:46 +0000
Message-Id: <20201106214949.2042120-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106214949.2042120-1-lee.jones@linaro.org>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Place it on the heap instead.

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c: In function ‘amdgpu_info_ioctl’:
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:979:1: warning: the frame size of 1128 bytes is larger than 1024 bytes [-Wframe-larger-than=]

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 104 +++++++++++++-----------
 1 file changed, 55 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 918d4e9c6461a..ef6fa5007d135 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -721,38 +721,42 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		return n ? -EFAULT : 0;
 	}
 	case AMDGPU_INFO_DEV_INFO: {
-		struct drm_amdgpu_info_device dev_info;
+		struct drm_amdgpu_info_device *dev_info;
 		uint64_t vm_size;
+		int ret;
+
+		dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
+		if (!dev_info)
+			return -ENOMEM;
 
-		memset(&dev_info, 0, sizeof(dev_info));
-		dev_info.device_id = dev->pdev->device;
-		dev_info.chip_rev = adev->rev_id;
-		dev_info.external_rev = adev->external_rev_id;
-		dev_info.pci_rev = dev->pdev->revision;
-		dev_info.family = adev->family;
-		dev_info.num_shader_engines = adev->gfx.config.max_shader_engines;
-		dev_info.num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
+		dev_info->device_id = dev->pdev->device;
+		dev_info->chip_rev = adev->rev_id;
+		dev_info->external_rev = adev->external_rev_id;
+		dev_info->pci_rev = dev->pdev->revision;
+		dev_info->family = adev->family;
+		dev_info->num_shader_engines = adev->gfx.config.max_shader_engines;
+		dev_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
 		/* return all clocks in KHz */
-		dev_info.gpu_counter_freq = amdgpu_asic_get_xclk(adev) * 10;
+		dev_info->gpu_counter_freq = amdgpu_asic_get_xclk(adev) * 10;
 		if (adev->pm.dpm_enabled) {
-			dev_info.max_engine_clock = amdgpu_dpm_get_sclk(adev, false) * 10;
-			dev_info.max_memory_clock = amdgpu_dpm_get_mclk(adev, false) * 10;
+			dev_info->max_engine_clock = amdgpu_dpm_get_sclk(adev, false) * 10;
+			dev_info->max_memory_clock = amdgpu_dpm_get_mclk(adev, false) * 10;
 		} else {
-			dev_info.max_engine_clock = adev->clock.default_sclk * 10;
-			dev_info.max_memory_clock = adev->clock.default_mclk * 10;
+			dev_info->max_engine_clock = adev->clock.default_sclk * 10;
+			dev_info->max_memory_clock = adev->clock.default_mclk * 10;
 		}
-		dev_info.enabled_rb_pipes_mask = adev->gfx.config.backend_enable_mask;
-		dev_info.num_rb_pipes = adev->gfx.config.max_backends_per_se *
+		dev_info->enabled_rb_pipes_mask = adev->gfx.config.backend_enable_mask;
+		dev_info->num_rb_pipes = adev->gfx.config.max_backends_per_se *
 			adev->gfx.config.max_shader_engines;
-		dev_info.num_hw_gfx_contexts = adev->gfx.config.max_hw_contexts;
-		dev_info._pad = 0;
-		dev_info.ids_flags = 0;
+		dev_info->num_hw_gfx_contexts = adev->gfx.config.max_hw_contexts;
+		dev_info->_pad = 0;
+		dev_info->ids_flags = 0;
 		if (adev->flags & AMD_IS_APU)
-			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
+			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_FUSION;
 		if (amdgpu_mcbp || amdgpu_sriov_vf(adev))
-			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
+			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_PREEMPTION;
 		if (amdgpu_is_tmz(adev))
-			dev_info.ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
+			dev_info->ids_flags |= AMDGPU_IDS_FLAGS_TMZ;
 
 		vm_size = adev->vm_manager.max_pfn * AMDGPU_GPU_PAGE_SIZE;
 		vm_size -= AMDGPU_VA_RESERVED_SIZE;
@@ -762,45 +766,47 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 		    adev->vce.fw_version < AMDGPU_VCE_FW_53_45)
 			vm_size = min(vm_size, 1ULL << 40);
 
-		dev_info.virtual_address_offset = AMDGPU_VA_RESERVED_SIZE;
-		dev_info.virtual_address_max =
+		dev_info->virtual_address_offset = AMDGPU_VA_RESERVED_SIZE;
+		dev_info->virtual_address_max =
 			min(vm_size, AMDGPU_GMC_HOLE_START);
 
 		if (vm_size > AMDGPU_GMC_HOLE_START) {
-			dev_info.high_va_offset = AMDGPU_GMC_HOLE_END;
-			dev_info.high_va_max = AMDGPU_GMC_HOLE_END | vm_size;
+			dev_info->high_va_offset = AMDGPU_GMC_HOLE_END;
+			dev_info->high_va_max = AMDGPU_GMC_HOLE_END | vm_size;
 		}
-		dev_info.virtual_address_alignment = max((int)PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE);
-		dev_info.pte_fragment_size = (1 << adev->vm_manager.fragment_size) * AMDGPU_GPU_PAGE_SIZE;
-		dev_info.gart_page_size = AMDGPU_GPU_PAGE_SIZE;
-		dev_info.cu_active_number = adev->gfx.cu_info.number;
-		dev_info.cu_ao_mask = adev->gfx.cu_info.ao_cu_mask;
-		dev_info.ce_ram_size = adev->gfx.ce_ram_size;
-		memcpy(&dev_info.cu_ao_bitmap[0], &adev->gfx.cu_info.ao_cu_bitmap[0],
+		dev_info->virtual_address_alignment = max((int)PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE);
+		dev_info->pte_fragment_size = (1 << adev->vm_manager.fragment_size) * AMDGPU_GPU_PAGE_SIZE;
+		dev_info->gart_page_size = AMDGPU_GPU_PAGE_SIZE;
+		dev_info->cu_active_number = adev->gfx.cu_info.number;
+		dev_info->cu_ao_mask = adev->gfx.cu_info.ao_cu_mask;
+		dev_info->ce_ram_size = adev->gfx.ce_ram_size;
+		memcpy(&dev_info->cu_ao_bitmap[0], &adev->gfx.cu_info.ao_cu_bitmap[0],
 		       sizeof(adev->gfx.cu_info.ao_cu_bitmap));
-		memcpy(&dev_info.cu_bitmap[0], &adev->gfx.cu_info.bitmap[0],
+		memcpy(&dev_info->cu_bitmap[0], &adev->gfx.cu_info.bitmap[0],
 		       sizeof(adev->gfx.cu_info.bitmap));
-		dev_info.vram_type = adev->gmc.vram_type;
-		dev_info.vram_bit_width = adev->gmc.vram_width;
-		dev_info.vce_harvest_config = adev->vce.harvest_config;
-		dev_info.gc_double_offchip_lds_buf =
+		dev_info->vram_type = adev->gmc.vram_type;
+		dev_info->vram_bit_width = adev->gmc.vram_width;
+		dev_info->vce_harvest_config = adev->vce.harvest_config;
+		dev_info->gc_double_offchip_lds_buf =
 			adev->gfx.config.double_offchip_lds_buf;
-		dev_info.wave_front_size = adev->gfx.cu_info.wave_front_size;
-		dev_info.num_shader_visible_vgprs = adev->gfx.config.max_gprs;
-		dev_info.num_cu_per_sh = adev->gfx.config.max_cu_per_sh;
-		dev_info.num_tcc_blocks = adev->gfx.config.max_texture_channel_caches;
-		dev_info.gs_vgt_table_depth = adev->gfx.config.gs_vgt_table_depth;
-		dev_info.gs_prim_buffer_depth = adev->gfx.config.gs_prim_buffer_depth;
-		dev_info.max_gs_waves_per_vgt = adev->gfx.config.max_gs_threads;
+		dev_info->wave_front_size = adev->gfx.cu_info.wave_front_size;
+		dev_info->num_shader_visible_vgprs = adev->gfx.config.max_gprs;
+		dev_info->num_cu_per_sh = adev->gfx.config.max_cu_per_sh;
+		dev_info->num_tcc_blocks = adev->gfx.config.max_texture_channel_caches;
+		dev_info->gs_vgt_table_depth = adev->gfx.config.gs_vgt_table_depth;
+		dev_info->gs_prim_buffer_depth = adev->gfx.config.gs_prim_buffer_depth;
+		dev_info->max_gs_waves_per_vgt = adev->gfx.config.max_gs_threads;
 
 		if (adev->family >= AMDGPU_FAMILY_NV)
-			dev_info.pa_sc_tile_steering_override =
+			dev_info->pa_sc_tile_steering_override =
 				adev->gfx.config.pa_sc_tile_steering_override;
 
-		dev_info.tcc_disabled_mask = adev->gfx.config.tcc_disabled_mask;
+		dev_info->tcc_disabled_mask = adev->gfx.config.tcc_disabled_mask;
 
-		return copy_to_user(out, &dev_info,
-				    min((size_t)size, sizeof(dev_info))) ? -EFAULT : 0;
+		ret = copy_to_user(out, dev_info,
+				   min((size_t)size, sizeof(*dev_info))) ? -EFAULT : 0;
+		kfree(dev_info);
+		return ret;
 	}
 	case AMDGPU_INFO_VCE_CLOCK_TABLE: {
 		unsigned i;
-- 
2.25.1

