Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C465B2A315C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbgKBRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgKBRU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:20:57 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8616C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:20:56 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i7so9423744pgh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3u/ID6i0HKFSwkiMXtA0kEMBqE7TZchp7Cb2zZ9L4Js=;
        b=Ex9JrzyI9/1pBRfYqQ0GV/ak1IV7glXSEC1w4K2yeOK7QLavI2p+/+iu/Nj0zjIkNa
         zsqjbcVxpC8fvRq7Hev1/xFhl3A6X8KZB4j/L1B8Cq0DKGt0z0j2gSUrMCGdUCs/WlJz
         3qGPHdt+z5Kwo4URH0FCMXup5B4PrTZHwr7Eh/mrky+tZWjHj6mWtDCLaGoT0MLxsgbF
         tjmzjNgmHaiIOOeHHmJOR6hbG4xUyWdQAUWbFHa4Mq62yWQ0uC5UPDFQEF4mHOw1+FH2
         lpv8uwYJP9vhX3EcPJfPnDUTDv5IqchKsx77AZl13Hx8LuJL1R5zUSoVPw/5TCcqxUih
         SgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3u/ID6i0HKFSwkiMXtA0kEMBqE7TZchp7Cb2zZ9L4Js=;
        b=KmaFME45ayGVSyQzzJueo/9n5G4cvd6dZjG8+JQCXKgg5QOh6n/eLi10IBJk71+htY
         0UMJbuJYVjcsT4M5RYK6ZUoqcejyh6R+nXPI0e8U9juFTpA+i0pK4YuFhacIE8YfIHSj
         /zZhIw3sB6bzI9FsZRhwA8ShmluS4CN3/nWWo0ubx7SlwB2Ht75J5p1hrq/hh3DRFMCh
         UNSJcvJ3bRsb85sD5uwnsxp+oZ03t2v8TrgQQiwshQ1IN1k1xYVQp/RXjtEi2YFIW1/N
         2eyjPkzLaN5UuTBmxnaweRr+04cpi2DKg1rB8OLXNb6NCDcAzkKb2/qKlNho8yYIKxS8
         QXdg==
X-Gm-Message-State: AOAM533NKwbHWkrnqGpiO+uYpw5iYpImsc/zNEL5lz0rTJcsaB1RFDt9
        80K+b3Koz6z3iUsxAZoT3lQJ4L84Gs0=
X-Google-Smtp-Source: ABdhPJyKYp6U+OqdrkLuP7E/svFLVvTpoq98ZaSaWH85TZrIwXEYuTqAelPMvKTceQarZxlHaUlsHA==
X-Received: by 2002:a63:443:: with SMTP id 64mr2458197pge.127.1604337656368;
        Mon, 02 Nov 2020 09:20:56 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id r6sm14650705pfg.85.2020.11.02.09.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:20:56 -0800 (PST)
Date:   Mon, 2 Nov 2020 22:50:50 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, gregkh@linuxfoundation.org,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH 6/6] drm/amdgpu: improve code indentation and alignment
Message-ID: <1b15f176289a7829c644dc9b7770f654eaee0efb.1604336791.git.mh12gx2825@gmail.com>
References: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d644879c4cac32a7cbdbbeebc97c98efd421e17f.1604336791.git.mh12gx2825@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

General code indentation and alignment changes such as replace spaces
by tabs or align function arguments as per the coding style
guidelines. The patch covers various .c files for this driver.
Issue reported by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/atom.c       | 4 ++--
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/df_v1_7.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c  | 8 ++++----
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/si.c         | 2 +-
 drivers/gpu/drm/amd/amdgpu/si_ih.c      | 2 +-
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 2 +-
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 4cfc786699c7..696e97ab77eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -71,8 +71,8 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t * params);
 
 static uint32_t atom_arg_mask[8] =
-    { 0xFFFFFFFF, 0xFFFF, 0xFFFF00, 0xFFFF0000, 0xFF, 0xFF00, 0xFF0000,
-0xFF000000 };
+	{ 0xFFFFFFFF, 0xFFFF, 0xFFFF00, 0xFFFF0000, 0xFF, 0xFF00, 0xFF0000,
+	  0xFF000000 };
 static int atom_arg_shift[8] = { 0, 0, 8, 16, 0, 8, 16, 24 };
 
 static int atom_dst_to_src[8][4] = {
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 20f108818b2b..52f05d2f5ed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -195,7 +195,7 @@ static void cik_sdma_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[ring->me],
-		       	(lower_32_bits(ring->wptr) << 2) & 0x3fffc);
+	       (lower_32_bits(ring->wptr) << 2) & 0x3fffc);
 }
 
 static void cik_sdma_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
index d6aca1c08068..2d01ac0d4c11 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v1_7.c
@@ -41,7 +41,7 @@ static void df_v1_7_sw_fini(struct amdgpu_device *adev)
 }
 
 static void df_v1_7_enable_broadcast_mode(struct amdgpu_device *adev,
-                                          bool enable)
+					  bool enable)
 {
 	u32 tmp;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index dbc8b76b9b78..6b04729d8fec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -145,7 +145,7 @@ static const struct amdgpu_irq_src_funcs gmc_v10_0_ecc_funcs = {
 	.process = amdgpu_umc_process_ecc_irq,
 };
 
- static void gmc_v10_0_set_irq_funcs(struct amdgpu_device *adev)
+static void gmc_v10_0_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gmc.vm_fault.num_types = 1;
 	adev->gmc.vm_fault.funcs = &gmc_v10_0_irq_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 94caf5204c8b..7b1a18cbafc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -32,19 +32,19 @@
 #include "vcn/vcn_2_0_0_sh_mask.h"
 #include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
 
-#define mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET 			0x1bfff
+#define mmUVD_JRBC_EXTERNAL_REG_INTERNAL_OFFSET				0x1bfff
 #define mmUVD_JPEG_GPCOM_CMD_INTERNAL_OFFSET				0x4029
 #define mmUVD_JPEG_GPCOM_DATA0_INTERNAL_OFFSET				0x402a
 #define mmUVD_JPEG_GPCOM_DATA1_INTERNAL_OFFSET				0x402b
 #define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ea
-#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET 	0x40eb
+#define mmUVD_LMI_JRBC_RB_MEM_WR_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40eb
 #define mmUVD_LMI_JRBC_IB_VMID_INTERNAL_OFFSET				0x40cf
 #define mmUVD_LMI_JPEG_VMID_INTERNAL_OFFSET				0x40d1
-#define mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET 		0x40e8
+#define mmUVD_LMI_JRBC_IB_64BIT_BAR_LOW_INTERNAL_OFFSET			0x40e8
 #define mmUVD_LMI_JRBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40e9
 #define mmUVD_JRBC_IB_SIZE_INTERNAL_OFFSET				0x4082
 #define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_LOW_INTERNAL_OFFSET		0x40ec
-#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET 	0x40ed
+#define mmUVD_LMI_JRBC_RB_MEM_RD_64BIT_BAR_HIGH_INTERNAL_OFFSET		0x40ed
 #define mmUVD_JRBC_RB_COND_RD_TIMER_INTERNAL_OFFSET			0x4085
 #define mmUVD_JRBC_RB_REF_DATA_INTERNAL_OFFSET				0x4084
 #define mmUVD_JRBC_STATUS_INTERNAL_OFFSET				0x4089
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index f84701c562bf..0309d84c887d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -409,7 +409,7 @@ static void mmhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev, bool
 				CRASH_ON_NO_RETRY_FAULT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 				CRASH_ON_RETRY_FAULT, 1);
-    }
+	}
 
 	WREG32_SOC15(MMHUB, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
@@ -712,7 +712,7 @@ static int mmhub_v1_0_get_ras_error_count(struct amdgpu_device *adev,
 	uint32_t sec_cnt, ded_cnt;
 
 	for (i = 0; i < ARRAY_SIZE(mmhub_v1_0_ras_fields); i++) {
-		if(mmhub_v1_0_ras_fields[i].reg_offset != reg->reg_offset)
+		if (mmhub_v1_0_ras_fields[i].reg_offset != reg->reg_offset)
 			continue;
 
 		sec_cnt = (value &
diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e5e336fd9e94..3cf0589bfea5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -1350,7 +1350,7 @@ static void si_vga_set_state(struct amdgpu_device *adev, bool state)
 
 static u32 si_get_xclk(struct amdgpu_device *adev)
 {
-        u32 reference_clock = adev->clock.spll.reference_freq;
+	u32 reference_clock = adev->clock.spll.reference_freq;
 	u32 tmp;
 
 	tmp = RREG32(CG_CLKPIN_CNTL_2);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 621727d7fd18..51880f6ef634 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -43,7 +43,7 @@ static void si_ih_enable_interrupts(struct amdgpu_device *adev)
 	WREG32(IH_RB_CNTL, ih_rb_cntl);
 	adev->irq.ih.enabled = true;
 }
-  
+
 static void si_ih_disable_interrupts(struct amdgpu_device *adev)
 {
 	u32 ih_rb_cntl = RREG32(IH_RB_CNTL);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index afcccc6c0fc6..b4e6ff78ddd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -822,7 +822,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
 			amdgpu_device_ip_block_add(adev, &dce_virtual_ip_block);
 #if defined(CONFIG_DRM_AMD_DC)
                 else if (amdgpu_device_has_dc_support(adev))
-                        amdgpu_device_ip_block_add(adev, &dm_ip_block);
+			amdgpu_device_ip_block_add(adev, &dm_ip_block);
 #endif
 		amdgpu_device_ip_block_add(adev, &vcn_v2_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v2_0_ip_block);
-- 
2.25.1

