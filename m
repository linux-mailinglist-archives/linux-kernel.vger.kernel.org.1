Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724542A3435
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKBTfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKBTe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:34:56 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B8C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 11:34:56 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id b12so7349968plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 11:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=W2TZBx79MZY2MxND9q++iA+/ACw6KEnI7V5Qbdkg/uM=;
        b=doVb0hJkNrB+/a8ihwLG+uAZ2h+jk9iV3Gii8+ElShEy63Mso1mM7ZkUYWc9XFc/cG
         WVncfo7XJiFGPK71/61MNkWKY3wb7vNhCkUmftc4UewUYcHRhkfCQ+ax8gnWRfFQnTbp
         h3qHcVkCZBbPGhAhXgOmsQT/+nVm8V4zgmGcnpP1rK9wStIDd3vJj64NCtpUeiEgUj8B
         MzOtoPXrNeIeRRd5gR9sSHuVvwhTNEOCSDDSvDCKlD7Mn1yBrHOsRpqsVLo06wjwbSQU
         6fcGVi4HILS7EFs2aIKhSn3qBCj+KbAwln+gB8oLRFcQQ2qlCjuAUcXwaAbrGHVxL+sH
         3K2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=W2TZBx79MZY2MxND9q++iA+/ACw6KEnI7V5Qbdkg/uM=;
        b=mlMYiNcbt1cU6VA789gkXvMMcAqJkWDuF0vnuJcal+5/5mL4wPAW6axkbhu6EFOnNs
         sFejbVrTAdMUzCO3GJUUA2Ti5SMGgjp9UKmsvIX0j7DkeYxu6+iGwooAoA/ig42fvlyn
         0h+oWxDK1b8GBZdY/V1ggAcBE1Mf7epBtnB0f8b1pCBWUHekLnpoyrqeMPvQJ2AAw0NV
         FewDJand+hSdQ92aKmKaH2WZT99mI7tcNiXu2uAe3sno5kVg9pqrNQD2zZP+zoTmmF40
         f6XtXx6aI6GY+0zjm5WfOwM4T0+O1MEK1/gTdwFVgM8zsYCUllASg2zuQ47/lUiHvVZS
         t6XQ==
X-Gm-Message-State: AOAM531AsiEANJvWu/eGpGvvlqWKix9/9zxcxsbPIK9iNBKZ1DeFscd8
        GwTdzVhBL06DCrUAdVCxReE=
X-Google-Smtp-Source: ABdhPJzYmHpFiayucqtEFpK2gHFprs7BMo+PHnOhUcbhfS1waqq3rwzS2FRCnIeEF7o9VucN35Uz9g==
X-Received: by 2002:a17:902:b696:b029:d5:cb0b:976f with SMTP id c22-20020a170902b696b02900d5cb0b976fmr23250643pls.26.1604345696344;
        Mon, 02 Nov 2020 11:34:56 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id e5sm293375pjd.0.2020.11.02.11.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:34:55 -0800 (PST)
Date:   Tue, 3 Nov 2020 01:04:50 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, gregkh@linuxfoundation.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH 1/6] drm/amdgpu/vcn: use "*" adjacent to data name
Message-ID: <6ad41a97d7805124d2e31c70d96c846cf0d21524.1604345594.git.mh12gx2825@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When declaring pointer data, the "*" symbol should be used adjacent to
the data name as per the coding style standards. This resolves following
issues reported by checkpatch script:
	ERROR: "foo *   bar" should be "foo *bar"
	ERROR: "foo * bar" should be "foo *bar"
	ERROR: "foo*            bar" should be "foo *bar"
	ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 136270e4af7b..e285f9c9d460 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -800,7 +800,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	WREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS, tmp);
 
 	if (indirect)
-		adev->vcn.inst->dpg_sram_curr_addr = (uint32_t*)adev->vcn.inst->dpg_sram_cpu_addr;
+		adev->vcn.inst->dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst->dpg_sram_cpu_addr;
 
 	/* enable clock gating */
 	vcn_v2_0_clock_gating_dpg_mode(adev, 0, indirect);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 4094718ae27a..b6e0f4ba6272 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -777,7 +777,7 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15(VCN, inst_idx, mmUVD_POWER_STATUS, tmp);
 
 	if (indirect)
-		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t*)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
+		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
 	vcn_v2_5_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 13e511d77bb1..749bf9503470 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -915,7 +915,7 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	WREG32_SOC15(VCN, inst_idx, mmUVD_POWER_STATUS, tmp);
 
 	if (indirect)
-		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t*)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
+		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t *)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
 
 	/* enable clock gating */
 	vcn_v3_0_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
-- 
2.25.1

