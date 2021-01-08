Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B942EFAD0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbhAHWAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:00:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43718 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbhAHWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610143138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rY5ZPZc+UpoVk06JLNrDEFfoZnlAUfsw6zwHWZ87dfE=;
        b=TFFdqAlXilUUMJpUosjGVMjVRPa/zh+Atgiv7Ncc7SkAqeBZPIc6USzwCwZakh2E2u0sIh
        tVXnOnu3P3SgM3nM9sQXbKYzKwnCWhWEwTsF0oKKQWavtXTINZX4K/qZ7rDJvM28VMCMkt
        m8UNz5OxltWgNzBVXrnwlrmLsXr+2tw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-dZiinM59P2iLT3cnpBJAWQ-1; Fri, 08 Jan 2021 16:58:56 -0500
X-MC-Unique: dZiinM59P2iLT3cnpBJAWQ-1
Received: by mail-il1-f197.google.com with SMTP id f19so11628756ilk.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:58:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rY5ZPZc+UpoVk06JLNrDEFfoZnlAUfsw6zwHWZ87dfE=;
        b=rzmpklJ/+OvH2HfoqPRr0ERt4wkvRU2hVTVrlGA5ou//9KvXGob9QbD1LQcziTRAks
         xN9HHJnePJ2kpGpyR3+nx1d/2w+7GHgvPa4LsHgaznpopx0Daxp0tYuifbXbhub+eLPW
         LDewD+JW8+3dQnR1hm/IPg5hH379qA2+sSqN2L9NX5Dga9RXiS4dkgboM3LlgF6xH6Lf
         oPci/7E0aiD9WKRkqQ5HEfVpWlGfjlQpl4proYDgnaAiMgrij2ouJwIVaAGMlSL/a2/p
         wPRscWuCfJ2oIjquE8u/OVIgGg5XthWro9RT9fLlWtrvvNBDPlJ1QRBhTj99zffTzgOq
         v6tQ==
X-Gm-Message-State: AOAM5318fp9YkdBg0A6k55lE/JwgpTvnktVFo6VeOgWPZ/WFa/vsCmSp
        v1bCP8+hEMWlrc7O9ZSTyG4gAhAJ0OnOz906pffkCQiKOSzfv4J36zqtLACCTkxPIIANH+k82De
        SI6BIvGAjsGpK4f/az1b/LugV
X-Received: by 2002:a6b:1454:: with SMTP id 81mr7014763iou.96.1610143135590;
        Fri, 08 Jan 2021 13:58:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcL32QS4piiA/+xZFlxxD2vJ8+gVoEA1QeikN8eAe85m5gz3Phc/CaInN+y9uuwjkvaGhbYw==
X-Received: by 2002:a6b:1454:: with SMTP id 81mr7014752iou.96.1610143135364;
        Fri, 08 Jan 2021 13:58:55 -0800 (PST)
Received: from dev.jcline.org ([2605:a601:a63a:4d01:c440:5c61:43ba:350c])
        by smtp.gmail.com with ESMTPSA id h18sm5961873ioh.30.2021.01.08.13.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 13:58:54 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: [PATCH] amdgpu: Avoid sleeping during FPU critical sections
Date:   Fri,  8 Jan 2021 16:58:38 -0500
Message-Id: <20210108215838.470637-1-jcline@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dcn20_resource_construct() includes a number of kzalloc(GFP_KERNEL)
calls which can sleep, but kernel_fpu_begin() disables preemption and
sleeping in this context is invalid.

The only places the FPU appears to be required is in the
init_soc_bounding_box() function and when calculating the
{min,max}_fill_clk_mhz. Narrow the scope to just these two parts to
avoid sleeping while using the FPU.

Fixes: 7a8a3430be15 ("amdgpu: Wrap FPU dependent functions in dc20")
Cc: Timothy Pearson <tpearson@raptorengineering.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index e04ecf0fc0db..a4fa5bf016c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3622,6 +3622,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 	if (bb && ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev)) {
 		int i;
 
+		DC_FP_START();
 		dcn2_0_nv12_soc.sr_exit_time_us =
 				fixed16_to_double_to_cpu(bb->sr_exit_time_us);
 		dcn2_0_nv12_soc.sr_enter_plus_exit_time_us =
@@ -3721,6 +3722,7 @@ static bool init_soc_bounding_box(struct dc *dc,
 			dcn2_0_nv12_soc.clock_limits[i].dram_speed_mts =
 					fixed16_to_double_to_cpu(bb->clock_limits[i].dram_speed_mts);
 		}
+		DC_FP_END();
 	}
 
 	if (pool->base.pp_smu) {
@@ -3777,8 +3779,6 @@ static bool dcn20_resource_construct(
 	enum dml_project dml_project_version =
 			get_dml_project_version(ctx->asic_id.hw_internal_rev);
 
-	DC_FP_START();
-
 	ctx->dc_bios->regs = &bios_regs;
 	pool->base.funcs = &dcn20_res_pool_funcs;
 
@@ -3959,8 +3959,10 @@ static bool dcn20_resource_construct(
 				ranges.reader_wm_sets[i].wm_inst = i;
 				ranges.reader_wm_sets[i].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
 				ranges.reader_wm_sets[i].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
+				DC_FP_START();
 				ranges.reader_wm_sets[i].min_fill_clk_mhz = (i > 0) ? (loaded_bb->clock_limits[i - 1].dram_speed_mts / 16) + 1 : 0;
 				ranges.reader_wm_sets[i].max_fill_clk_mhz = loaded_bb->clock_limits[i].dram_speed_mts / 16;
+				DC_FP_END();
 
 				ranges.num_reader_wm_sets = i + 1;
 			}
@@ -4125,12 +4127,10 @@ static bool dcn20_resource_construct(
 		pool->base.oem_device = NULL;
 	}
 
-	DC_FP_END();
 	return true;
 
 create_fail:
 
-	DC_FP_END();
 	dcn20_resource_destruct(pool);
 
 	return false;
-- 
2.28.0

