Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB6B2F47F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbhAMJpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:45:36 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:48289 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727219AbhAMJpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:45:36 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0ULbS2qg_1610531056;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULbS2qg_1610531056)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Jan 2021 17:44:23 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Simplify bool comparison
Date:   Wed, 13 Jan 2021 17:44:15 +0800
Message-Id: <1610531055-56146-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c:3141:30-39:
WARNING: Comparison to bool

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
index 45f0289..f33e3de 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
@@ -3138,7 +3138,7 @@ static void CalculateFlipSchedule(
 				4.0 * (TimeForFetchingMetaPTEImmediateFlip / LineTime + 0.125),
 				1) / 4.0;
 
-		if ((GPUVMEnable == true || DCCEnable == true)) {
+		if ((GPUVMEnable || DCCEnable)) {
 			mode_lib->vba.ImmediateFlipBW[0] = BandwidthAvailableForImmediateFlip
 					* ImmediateFlipBytes / TotImmediateFlipBytes;
 			TimeForFetchingRowInVBlankImmediateFlip = dml_max(
-- 
1.8.3.1

