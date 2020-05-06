Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD1C1C674C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 07:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEFFMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 01:12:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3853 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725821AbgEFFMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 01:12:06 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 89ED0F0BB844B5F90096;
        Wed,  6 May 2020 13:12:02 +0800 (CST)
Received: from huawei.com (10.67.174.156) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 6 May 2020
 13:11:56 +0800
From:   ChenTao <chentao107@huawei.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <chentao107@huawei.com>
Subject: [PATCH -next] drm/amdgpu/navi10: fix unsigned comparison with 0
Date:   Wed, 6 May 2020 13:11:13 +0800
Message-ID: <20200506051113.223327-1-chentao107@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.156]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes warning because size is uint32_t and can never be negtative

drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:1296:12: warning:
comparison of unsigned expression < 0 is always false [-Wtype-limits]
   if (size < 0)

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: ChenTao <chentao107@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 2184d247a9f7..0c9be864d072 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1293,8 +1293,6 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size < 0)
-			return -EINVAL;
 
 		ret = smu_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
-- 
2.22.0

