Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577DD262EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 15:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgIINKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 09:10:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57456 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730205AbgIINAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:00:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 47A891E728AC6FC2521F;
        Wed,  9 Sep 2020 21:00:33 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 9 Sep 2020
 21:00:25 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 1/8] drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
Date:   Wed, 9 Sep 2020 21:07:13 +0800
Message-ID: <20200909130720.105234-2-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20200909130720.105234-1-zhengbin13@huawei.com>
References: <20200909130720.105234-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes coccicheck warning:

drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:2805:5-11: WARNING: Comparison to bool

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index fed2690d1380..20d8a03ca866 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2802,7 +2802,7 @@ static void pwr_10_0_gfxip_control_over_cgpg(struct amdgpu_device *adev,
 	uint32_t default_data = 0;

 	default_data = data = RREG32(SOC15_REG_OFFSET(PWR, 0, mmPWR_MISC_CNTL_STATUS));
-	if (enable == true) {
+	if (enable) {
 		/* enable GFXIP control over CGPG */
 		data |= PWR_MISC_CNTL_STATUS__PWR_GFX_RLC_CGPG_EN_MASK;
 		if(default_data != data)
--
2.26.0.106.g9fadedd

