Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9ECE2F47BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhAMJkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:40:05 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:43837 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726995AbhAMJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:40:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0ULc.clB_1610530708;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULc.clB_1610530708)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Jan 2021 17:38:36 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Simplify bool comparison
Date:   Wed, 13 Jan 2021 17:38:27 +0800
Message-Id: <1610530707-50441-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c:5121:14-38:
WARNING: Comparison to bool

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 .../amd/display/dc/dml/dcn21/display_mode_vba_21.c | 44 +++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 86ff24d..0bcec11 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -5121,48 +5121,48 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 		for (j = 0; j < 2; j++) {
 			enum dm_validation_status status = DML_VALIDATION_OK;
 
-			if (mode_lib->vba.ScaleRatioAndTapsSupport != true) {
+			if (!mode_lib->vba.ScaleRatioAndTapsSupport) {
 				status = DML_FAIL_SCALE_RATIO_TAP;
-			} else if (mode_lib->vba.SourceFormatPixelAndScanSupport != true) {
+			} else if (!mode_lib->vba.SourceFormatPixelAndScanSupport) {
 				status = DML_FAIL_SOURCE_PIXEL_FORMAT;
-			} else if (locals->ViewportSizeSupport[i][0] != true) {
+			} else if (!locals->ViewportSizeSupport[i][0]) {
 				status = DML_FAIL_VIEWPORT_SIZE;
-			} else if (locals->DIOSupport[i] != true) {
+			} else if (!locals->DIOSupport[i]) {
 				status = DML_FAIL_DIO_SUPPORT;
-			} else if (locals->NotEnoughDSCUnits[i] != false) {
+			} else if (locals->NotEnoughDSCUnits[i]) {
 				status = DML_FAIL_NOT_ENOUGH_DSC;
-			} else if (locals->DSCCLKRequiredMoreThanSupported[i] != false) {
+			} else if (locals->DSCCLKRequiredMoreThanSupported[i]) {
 				status = DML_FAIL_DSC_CLK_REQUIRED;
-			} else if (locals->ROBSupport[i][0] != true) {
+			} else if (!locals->ROBSupport[i][0]) {
 				status = DML_FAIL_REORDERING_BUFFER;
-			} else if (locals->DISPCLK_DPPCLK_Support[i][j] != true) {
+			} else if (!locals->DISPCLK_DPPCLK_Support[i][j]) {
 				status = DML_FAIL_DISPCLK_DPPCLK;
-			} else if (locals->TotalAvailablePipesSupport[i][j] != true) {
+			} else if (!locals->TotalAvailablePipesSupport[i][j]) {
 				status = DML_FAIL_TOTAL_AVAILABLE_PIPES;
-			} else if (mode_lib->vba.NumberOfOTGSupport != true) {
+			} else if (!mode_lib->vba.NumberOfOTGSupport) {
 				status = DML_FAIL_NUM_OTG;
-			} else if (mode_lib->vba.WritebackModeSupport != true) {
+			} else if (!mode_lib->vba.WritebackModeSupport) {
 				status = DML_FAIL_WRITEBACK_MODE;
-			} else if (mode_lib->vba.WritebackLatencySupport != true) {
+			} else if (!mode_lib->vba.WritebackLatencySupport) {
 				status = DML_FAIL_WRITEBACK_LATENCY;
-			} else if (mode_lib->vba.WritebackScaleRatioAndTapsSupport != true) {
+			} else if (!mode_lib->vba.WritebackScaleRatioAndTapsSupport) {
 				status = DML_FAIL_WRITEBACK_SCALE_RATIO_TAP;
-			} else if (mode_lib->vba.CursorSupport != true) {
+			} else if (!mode_lib->vba.CursorSupport) {
 				status = DML_FAIL_CURSOR_SUPPORT;
-			} else if (mode_lib->vba.PitchSupport != true) {
+			} else if (!mode_lib->vba.PitchSupport) {
 				status = DML_FAIL_PITCH_SUPPORT;
-			} else if (locals->TotalVerticalActiveBandwidthSupport[i][0] != true) {
+			} else if (!locals->TotalVerticalActiveBandwidthSupport[i][0]) {
 				status = DML_FAIL_TOTAL_V_ACTIVE_BW;
-			} else if (locals->PTEBufferSizeNotExceeded[i][j] != true) {
+			} else if (!locals->PTEBufferSizeNotExceeded[i][j]) {
 				status = DML_FAIL_PTE_BUFFER_SIZE;
-			} else if (mode_lib->vba.NonsupportedDSCInputBPC != false) {
+			} else if (mode_lib->vba.NonsupportedDSCInputBPC) {
 				status = DML_FAIL_DSC_INPUT_BPC;
-			} else if ((mode_lib->vba.HostVMEnable != false
-					&& locals->ImmediateFlipSupportedForState[i][j] != true)) {
+			} else if ((mode_lib->vba.HostVMEnable
+					&& !locals->ImmediateFlipSupportedForState[i][j])) {
 				status = DML_FAIL_HOST_VM_IMMEDIATE_FLIP;
-			} else if (locals->PrefetchSupported[i][j] != true) {
+			} else if (!locals->PrefetchSupported[i][j]) {
 				status = DML_FAIL_PREFETCH_SUPPORT;
-			} else if (locals->VRatioInPrefetchSupported[i][j] != true) {
+			} else if (!locals->VRatioInPrefetchSupported[i][j]) {
 				status = DML_FAIL_V_RATIO_PREFETCH;
 			}
 
-- 
1.8.3.1

