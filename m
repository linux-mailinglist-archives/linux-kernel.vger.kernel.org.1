Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C1B29D83D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbgJ1Waq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:30:46 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6985 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgJ1Wao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:30:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CLhSV3Vzrzhbkn;
        Wed, 28 Oct 2020 16:24:26 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 16:24:12 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm/amd/display: remove useless if/else
Date:   Wed, 28 Oct 2020 16:36:11 +0800
Message-ID: <1603874171-106841-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccinelle report:

./drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c:1367:3-5:
WARNING: possible condition with no effect (if == else)

Both branches are the same, so remove the if/else altogether.

Fixes: 81875979f0b2 ("drm/amd/display: Remove extra pairs of parentheses in dce_calcs.c")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
index 2c6db37..e4f29cd 100644
--- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
@@ -1364,13 +1364,10 @@ static void calculate_bandwidth(
 	/*if stutter and dram clock state change are gated before cursor then the cursor latency hiding does not limit stutter or dram clock state change*/
 	for (i = 0; i <= maximum_number_of_surfaces - 1; i++) {
 		if (data->enable[i]) {
-			if (dceip->graphics_lb_nodownscaling_multi_line_prefetching == 1) {
-				data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
-			}
-			else {
-				/*maximum_latency_hiding(i) = minimum_latency_hiding(i) + 1 / vsr(i) * h_total(i) / pixel_rate(i) + 0.5 * total_dmifmc_urgent_latency*/
-				data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
-			}
+			/*maximum_latency_hiding(i) = minimum_latency_hiding(i) + 1 / vsr(i) **/
+			/*      h_total(i) / pixel_rate(i) + 0.5 * total_dmifmc_urgent_latency*/
+			data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i],
+				bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
 			data->maximum_latency_hiding_with_cursor[i] = bw_min2(data->maximum_latency_hiding[i], data->cursor_latency_hiding[i]);
 		}
 	}
-- 
2.6.2

