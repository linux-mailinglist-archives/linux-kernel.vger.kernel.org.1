Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03E32A3325
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKBSlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBSlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:41:55 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FE5C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 10:41:55 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id h6so11550817pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 10:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uX2j6BTsDsDmpfeekKFS6duLUjm424lsGMqXT4y60ag=;
        b=rMqgtwuy5gD+utEZVzx4U+OKxKZfzgAso2fI0Yr74Ryq8G65Frfn8pbfHJGvou9bpj
         Tyr9mGQeXJvFwGgx0kkoNsNbrWfqOYrxKlCEdnDPfXxb/o2IAkkMudeNW40oeLl0zqVQ
         PS/DMw1hMbXNNYNxolpYZMGp68QDxM6LCuRWgf7XMoKr/RYUByZLoVPyc3OplZV43zTo
         0YwgOq5ZGArljQ9pobSQz1RJCVPceQ4Jng/w4ycgeNRCYEaO34wS7pBA+du948kHUxnS
         7od99l/cs9GhooDEaI58YHPUfMQBsxs/KfkstQg2B+p22G4jFDbFedq9r/uy4Fipo4Qf
         Xaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uX2j6BTsDsDmpfeekKFS6duLUjm424lsGMqXT4y60ag=;
        b=IQ3LPq1fFjngOplJP5JoTN6RnKP0PMJNQH9M/74sTs53hgwE25SjbxfwDM6xpROUpJ
         tJeequz7CfsooMGse+ZjWWwvSFSjXdv1wCxQQjQLCCfDj545VlCZfRrMxC0tmXq1Tt2e
         ry/ZYPQzzn7x/dGYsiHncaMmvUHRkWRFhtlx06hCL1t3WAHm80jYldoKEzzMdmhfBfiU
         7a1X/nDeUtW5+4sEqoJNBNtAmQ1L6U5L/8f2QMbmrBfscn6NfeXJc1vDnimGwDlEpbfv
         kXULnVeZyrgPIrz+QT8ffRnO3gR8PmuDxz7i4HsnayNIkpbM4nUBFgSf9CaZpqoD+/6o
         RBLg==
X-Gm-Message-State: AOAM53165LmJ2dX/v6ozRXJRq8+Z3mmYWVSTZVlXm+96z7yl2INgZfOf
        2y5XVlcYEhXpLeviWa/tqZQ=
X-Google-Smtp-Source: ABdhPJxVTiek04noTjU9GhU1+83S9V6Fm2v8nawdUGGy18yNrKkctDFNKL3bNrq+vflGQ1SHFhJt7g==
X-Received: by 2002:a17:90b:ec9:: with SMTP id gz9mr2068967pjb.105.1604342514622;
        Mon, 02 Nov 2020 10:41:54 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id v24sm13205004pgi.91.2020.11.02.10.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 10:41:54 -0800 (PST)
Date:   Tue, 3 Nov 2020 00:11:47 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     mh12gx2825@gmail.com, gregkh@linuxfoundation.org,
        melissa.srw@gmail.com, daniel.vetter@ffwll.ch
Subject: [PATCH] drm/amdgpu: do not initialise global variables to 0 or NULL
Message-ID: <20201102184147.GA42288@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing global variable to 0 or NULL is not necessary and should
be avoided. Issue reported by checkpatch script as:
ERROR: do not initialise globals to 0 (or NULL).

Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 46 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/atom.c       |  4 +--
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 8ab6126ff70c..6de94c46bc91 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -94,16 +94,16 @@
 #define KMS_DRIVER_MINOR	40
 #define KMS_DRIVER_PATCHLEVEL	0
 
-int amdgpu_vram_limit = 0;
-int amdgpu_vis_vram_limit = 0;
+int amdgpu_vram_limit;
+int amdgpu_vis_vram_limit;
 int amdgpu_gart_size = -1; /* auto */
 int amdgpu_gtt_size = -1; /* auto */
 int amdgpu_moverate = -1; /* auto */
-int amdgpu_benchmarking = 0;
-int amdgpu_testing = 0;
+int amdgpu_benchmarking;
+int amdgpu_testing;
 int amdgpu_audio = -1;
-int amdgpu_disp_priority = 0;
-int amdgpu_hw_i2c = 0;
+int amdgpu_disp_priority;
+int amdgpu_hw_i2c;
 int amdgpu_pcie_gen2 = -1;
 int amdgpu_msi = -1;
 char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
@@ -113,43 +113,43 @@ int amdgpu_aspm = -1;
 int amdgpu_runtime_pm = -1;
 uint amdgpu_ip_block_mask = 0xffffffff;
 int amdgpu_bapm = -1;
-int amdgpu_deep_color = 0;
+int amdgpu_deep_color;
 int amdgpu_vm_size = -1;
 int amdgpu_vm_fragment_size = -1;
 int amdgpu_vm_block_size = -1;
-int amdgpu_vm_fault_stop = 0;
-int amdgpu_vm_debug = 0;
+int amdgpu_vm_fault_stop;
+int amdgpu_vm_debug;
 int amdgpu_vm_update_mode = -1;
-int amdgpu_exp_hw_support = 0;
+int amdgpu_exp_hw_support;
 int amdgpu_dc = -1;
 int amdgpu_sched_jobs = 32;
 int amdgpu_sched_hw_submission = 2;
-uint amdgpu_pcie_gen_cap = 0;
-uint amdgpu_pcie_lane_cap = 0;
+uint amdgpu_pcie_gen_cap;
+uint amdgpu_pcie_lane_cap;
 uint amdgpu_cg_mask = 0xffffffff;
 uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
-char *amdgpu_disable_cu = NULL;
-char *amdgpu_virtual_display = NULL;
+char *amdgpu_disable_cu;
+char *amdgpu_virtual_display;
 /* OverDrive(bit 14) disabled by default*/
 uint amdgpu_pp_feature_mask = 0xffffbfff;
-uint amdgpu_force_long_training = 0;
-int amdgpu_job_hang_limit = 0;
+uint amdgpu_force_long_training;
+int amdgpu_job_hang_limit;
 int amdgpu_lbpw = -1;
 int amdgpu_compute_multipipe = -1;
 int amdgpu_gpu_recovery = -1; /* auto */
-int amdgpu_emu_mode = 0;
-uint amdgpu_smu_memory_pool_size = 0;
+int amdgpu_emu_mode;
+uint amdgpu_smu_memory_pool_size;
 /* FBC (bit 0) disabled by default*/
-uint amdgpu_dc_feature_mask = 0;
-uint amdgpu_dc_debug_mask = 0;
+uint amdgpu_dc_feature_mask;
+uint amdgpu_dc_debug_mask;
 int amdgpu_async_gfx_ring = 1;
-int amdgpu_mcbp = 0;
+int amdgpu_mcbp;
 int amdgpu_discovery = -1;
-int amdgpu_mes = 0;
+int amdgpu_mes;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
-int amdgpu_tmz = 0;
+int amdgpu_tmz;
 int amdgpu_reset_method = -1; /* auto */
 int amdgpu_num_kcq = -1;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 696e97ab77eb..46c00ee580b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -66,7 +66,7 @@ typedef struct {
 	bool abort;
 } atom_exec_context;
 
-int amdgpu_atom_debug = 0;
+int amdgpu_atom_debug;
 static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index, uint32_t * params);
 int amdgpu_atom_execute_table(struct atom_context *ctx, int index, uint32_t * params);
 
@@ -88,7 +88,7 @@ static int atom_dst_to_src[8][4] = {
 };
 static int atom_def_dst[8] = { 0, 0, 1, 2, 0, 1, 2, 3 };
 
-static int debug_depth = 0;
+static int debug_depth;
 #ifdef ATOM_DEBUG
 static void debug_print_spaces(int n)
 {
-- 
2.25.1

