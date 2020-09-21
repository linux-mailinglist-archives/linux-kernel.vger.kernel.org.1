Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E3C2724A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgIUNKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:10:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13753 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727117AbgIUNJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:09:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A250F2907FB90E859727;
        Mon, 21 Sep 2020 21:09:57 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:09:49 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] drm/amdgpu: simplify the return expression
Date:   Mon, 21 Sep 2020 21:10:13 +0800
Message-ID: <20200921131013.91326-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_ih.c   |  7 +------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 10 ++--------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index 401c99f0b..db953e95f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -316,14 +316,9 @@ static int cik_ih_sw_fini(void *handle)
 
 static int cik_ih_hw_init(void *handle)
 {
-	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	r = cik_ih_irq_init(adev);
-	if (r)
-		return r;
-
-	return 0;
+	return cik_ih_irq_init(adev);
 }
 
 static int cik_ih_hw_fini(void *handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 20d8a03ca..56ed108b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2198,7 +2198,6 @@ static int gfx_v9_0_gpu_early_init(struct amdgpu_device *adev)
 static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 				      int mec, int pipe, int queue)
 {
-	int r;
 	unsigned irq_type;
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
 	unsigned int hw_prio;
@@ -2223,13 +2222,8 @@ static int gfx_v9_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring->queue) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
-	r = amdgpu_ring_init(adev, ring, 1024,
-			     &adev->gfx.eop_irq, irq_type, hw_prio);
-	if (r)
-		return r;
-
-
-	return 0;
+	return amdgpu_ring_init(adev, ring, 1024,
+				&adev->gfx.eop_irq, irq_type, hw_prio);
 }
 
 static int gfx_v9_0_sw_init(void *handle)
-- 
2.23.0

