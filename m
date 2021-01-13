Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861642F4741
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbhAMJLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:11:06 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45196 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727408AbhAMJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:11:05 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0ULbca43_1610528935;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULbca43_1610528935)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Jan 2021 17:10:18 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Simplify bool comparison
Date:   Wed, 13 Jan 2021 17:08:53 +0800
Message-Id: <1610528933-26973-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c:1228:9-20:
WARNING: Comparison to bool

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
index 319dec5..3827501 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_mode_vba_30.c
@@ -1219,13 +1219,13 @@ static bool CalculatePrefetchSchedule(
 			dml_print("DML: prefetch_bw_equ: %f\n", prefetch_bw_equ);
 
 			if (prefetch_bw_equ > 0) {
-				if (GPUVMEnable == true) {
+				if (GPUVMEnable) {
 					Tvm_equ = dml_max3(*Tno_bw + PDEAndMetaPTEBytesFrame * HostVMInefficiencyFactor / prefetch_bw_equ, Tvm_trips, LineTime / 4);
 				} else {
 					Tvm_equ = LineTime / 4;
 				}
 
-				if ((GPUVMEnable == true || myPipe->DCCEnable == true)) {
+				if ((GPUVMEnable || myPipe->DCCEnable)) {
 					Tr0_equ = dml_max4(
 							(MetaRowByte + PixelPTEBytesPerRow * HostVMInefficiencyFactor) / prefetch_bw_equ,
 							Tr0_trips,
-- 
1.8.3.1

