Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546D42F47AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 10:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbhAMJdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 04:33:47 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:55302 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726948AbhAMJdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 04:33:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0ULbomAn_1610530367;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULbomAn_1610530367)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Jan 2021 17:33:01 +0800
From:   Yang Li <abaci-bugfix@linux.alibaba.com>
To:     airlied@linux.ie
Cc:     daniel@ffwll.ch, harry.wentland@amd.com, sunpeng.li@amd.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Yang Li <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Simplify bool comparison
Date:   Wed, 13 Jan 2021 17:32:45 +0800
Message-Id: <1610530365-46152-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c:580:23-31:
WARNING: Comparison to bool

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <abaci-bugfix@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
index 4d3f7d5..904c2d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_cm.c
@@ -577,7 +577,7 @@ void dpp1_power_on_degamma_lut(
 	struct dcn10_dpp *dpp = TO_DCN10_DPP(dpp_base);
 
 	REG_SET(CM_MEM_PWR_CTRL, 0,
-			SHARED_MEM_PWR_DIS, power_on == true ? 0:1);
+			SHARED_MEM_PWR_DIS, power_on ? 0:1);
 
 }
 
-- 
1.8.3.1

