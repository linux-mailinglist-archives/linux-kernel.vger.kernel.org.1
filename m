Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0072A313A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgKBRRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727484AbgKBRRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:17:06 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476BC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:17:05 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id g11so632860pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a0jYTmrFpdw95OyIRLlDuQeZ5xit+fHnq5W5rVj7juA=;
        b=VpLkXv3FGasnw6RWFjbzBHclWI38P4gsSsNqXgS6d11F7eDNPz8jieDqz1GfhXrowq
         VG9eE9esFFmJ1hqZ6b/YDr3U1xF9lwwlNX03ZM0LRJyTPg09csiv/4n07l5bHGiecQr/
         lDPamuHlPhk8Kxjz7rrWg5y2doc0SFZzJM0XaXt1kAtJs5TXYVUn0zShcNE9GaQIyIm9
         Nrkcae3MkVppfjUk35bRCgiL1+Cx+a9rjiYxtwhNnTadoRHNxWt3+KwJTWhjBWU2r0oV
         7zOhUX01tvJDluzsQi9AE7UOyk4GpLRYG9LXpmcXrMLm91yuPPozaXppA0q944QRTFdE
         zGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a0jYTmrFpdw95OyIRLlDuQeZ5xit+fHnq5W5rVj7juA=;
        b=t445DTzLGMSDYdaJFIBJYrdYfGP1imeQzCXlKidpaWzNKCb1aw6yWS66ILTa3UPdjj
         hCpdzFWEZNmhyea2OMqow/AmstXFW7nXUZ2LfxPK1d59JtK0vG13JbyPpIfa6fQURiV0
         ViVXfz0BcRtCp7bpg+OsUZEq5gb3ldDV0XUXjRMmrKBtrX8hCMreH8nafZaO8Ghm5oH3
         SLz0Vl3qY20x10k4bVQw0fbx/IMO96FAYmStx/2TL+AEyfiwSAK53plBqaz4bXotNCkc
         uIzZt6r5UuZvibXUcM9Qwxxh5EKcepdnXFH0QuGufPNr1IJm1rEFnIkJyqf8rHcyzxpL
         ijkQ==
X-Gm-Message-State: AOAM5300NjtUhUYbZ8Vztazr8uN7/p2TI2MrF6jOIpR6W6GwRzkChoM/
        5EEAF5T8c99yiZhGgyss01w=
X-Google-Smtp-Source: ABdhPJzBvEf8/a8mYK9gWC2o0GG6EkLwG/D1jjlRP3lTFRhwncusiDCdB/RROZx1ly3sBcCr6BQDqQ==
X-Received: by 2002:a17:902:a589:b029:d6:856a:2978 with SMTP id az9-20020a170902a589b02900d6856a2978mr21413557plb.67.1604337424893;
        Mon, 02 Nov 2020 09:17:04 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id j11sm13951700pfc.64.2020.11.02.09.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:17:04 -0800 (PST)
Date:   Mon, 2 Nov 2020 22:46:58 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, gregkh@linuxfoundation.org,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH 2/6] drm/amdgpu/gfx: improve code indentation and alignment
Message-ID: <8a81ed33f995301350742aff6cce0463e37c8bb0.1604336791.git.mh12gx2825@gmail.com>
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
guidelines. Issue reported by checkpatch script.

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 56fdbe626d30..987f9b6dbc3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -3192,7 +3192,7 @@ static void gfx_v10_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v10_0_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v10_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
-                                 struct amdgpu_cu_info *cu_info);
+				 struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v10_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v10_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
 				   u32 sh_num, u32 instance);
@@ -4200,10 +4200,10 @@ static void gfx_v10_0_read_wave_vgprs(struct amdgpu_device *adev, uint32_t simd,
 }
 
 static void gfx_v10_0_select_me_pipe_q(struct amdgpu_device *adev,
-									  u32 me, u32 pipe, u32 q, u32 vm)
- {
-       nv_grbm_select(adev, me, pipe, q, vm);
- }
+				       u32 me, u32 pipe, u32 q, u32 vm)
+{
+	nv_grbm_select(adev, me, pipe, q, vm);
+}
 
 
 static const struct amdgpu_gfx_funcs gfx_v10_0_gfx_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 94b7e0531d09..3e9a230f84df 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -5058,7 +5058,7 @@ static int gfx_v8_0_pre_soft_reset(void *handle)
 		gfx_v8_0_cp_compute_enable(adev, false);
 	}
 
-       return 0;
+	return 0;
 }
 
 static int gfx_v8_0_soft_reset(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 6959aebae6d4..48f98c750956 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -787,7 +787,7 @@ static void gfx_v9_0_set_irq_funcs(struct amdgpu_device *adev);
 static void gfx_v9_0_set_gds_init(struct amdgpu_device *adev);
 static void gfx_v9_0_set_rlc_funcs(struct amdgpu_device *adev);
 static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
-                                 struct amdgpu_cu_info *cu_info);
+				struct amdgpu_cu_info *cu_info);
 static uint64_t gfx_v9_0_get_gpu_clock_counter(struct amdgpu_device *adev);
 static void gfx_v9_0_ring_emit_de_meta(struct amdgpu_ring *ring);
 static u64 gfx_v9_0_ring_get_rptr_compute(struct amdgpu_ring *ring);
-- 
2.25.1

