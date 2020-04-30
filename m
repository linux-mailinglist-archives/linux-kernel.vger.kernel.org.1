Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178121BEEBB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 05:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgD3DuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 23:50:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51262 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbgD3DuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:50:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D8BB2F8D3830183161C6;
        Thu, 30 Apr 2020 11:50:20 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 30 Apr 2020 11:49:49 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
        <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] drm/amd/display: Fix unsigned comparison to zero
Date:   Thu, 30 Apr 2020 11:56:02 +0800
Message-ID: <1588218962-75747-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c:1398:60-61:
WARNING: Unsigned expression compared with zero: j >= 0

Fixes: 238387774232 ("drm/amd/display: fix rn soc bb update")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index ceaf70a..419cdde 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -1384,7 +1384,8 @@ static void update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
 	struct clk_limit_table *clk_table = &bw_params->clk_table;
 	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
-	unsigned int i, j, closest_clk_lvl;
+	unsigned int i, closest_clk_lvl;
+	int j;
 
 	// Default clock levels are used for diags, which may lead to overclocking.
 	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-- 
2.6.2

