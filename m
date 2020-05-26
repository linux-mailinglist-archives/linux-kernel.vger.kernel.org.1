Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484C01CBE0C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 08:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgEIGay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 02:30:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4364 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbgEIGay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 02:30:54 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ACC85C1323C26D88B3D6;
        Sat,  9 May 2020 14:30:49 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Sat, 9 May 2020
 14:30:39 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] drm/amd/amdgpu: remove defined but not used 'crtc_offsets'
Date:   Sat, 9 May 2020 14:29:59 +0800
Message-ID: <20200509062959.42481-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:65:18: warning: ‘crtc_offsets’
defined but not used [-Wunused-const-variable=]
 static const u32 crtc_offsets[6] =
                  ^~~~~~~~~~~~

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index c1a530dbe162..a75e472b4a81 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -61,17 +61,6 @@ MODULE_FIRMWARE("amdgpu/si58_mc.bin");
 #define MC_SEQ_MISC0__MT__HBM    0x60000000
 #define MC_SEQ_MISC0__MT__DDR3   0xB0000000
 
-
-static const u32 crtc_offsets[6] =
-{
-	SI_CRTC0_REGISTER_OFFSET,
-	SI_CRTC1_REGISTER_OFFSET,
-	SI_CRTC2_REGISTER_OFFSET,
-	SI_CRTC3_REGISTER_OFFSET,
-	SI_CRTC4_REGISTER_OFFSET,
-	SI_CRTC5_REGISTER_OFFSET
-};
-
 static void gmc_v6_0_mc_stop(struct amdgpu_device *adev)
 {
 	u32 blackout;
-- 
2.21.1

