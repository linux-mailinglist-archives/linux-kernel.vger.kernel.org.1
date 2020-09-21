Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624EC2724A7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgIUNKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:10:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13752 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727112AbgIUNJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:09:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9E403A6ADBBBD87B25B4;
        Mon, 21 Sep 2020 21:09:54 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:09:47 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] drm/amdgpu/mes: simplify the return expression of mes_v10_1_ring_init
Date:   Mon, 21 Sep 2020 21:10:11 +0800
Message-ID: <20200921131011.91281-1-miaoqinglang@huawei.com>
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
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 4b746584a..1c22d8393 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -832,7 +832,6 @@ static int mes_v10_1_queue_init(struct amdgpu_device *adev)
 static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	int r;
 
 	ring = &adev->mes.ring;
 
@@ -849,11 +848,7 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 	ring->no_scheduler = true;
 	sprintf(ring->name, "mes_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
-	r = amdgpu_ring_init(adev, ring, 1024, NULL, 0, AMDGPU_RING_PRIO_DEFAULT);
-	if (r)
-		return r;
-
-	return 0;
+	return amdgpu_ring_init(adev, ring, 1024, NULL, 0, AMDGPU_RING_PRIO_DEFAULT);
 }
 
 static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev)
-- 
2.23.0

