Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4AD27250E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgIUNKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:10:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727113AbgIUNKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:10 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 36BBFD2A5751974C9D3E;
        Mon, 21 Sep 2020 21:10:08 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:00 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Eric Anholt <eric@anholt.net>, David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] drm/vc4: simplify the return expression of vc4_v3d_bin_bo_get()
Date:   Mon, 21 Sep 2020 21:10:25 +0800
Message-ID: <20200921131025.91739-1-miaoqinglang@huawei.com>
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
 drivers/gpu/drm/vc4/vc4_bo.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_bo.c b/drivers/gpu/drm/vc4/vc4_bo.c
index 74ceebd62..dfd214386 100644
--- a/drivers/gpu/drm/vc4/vc4_bo.c
+++ b/drivers/gpu/drm/vc4/vc4_bo.c
@@ -795,19 +795,13 @@ vc4_prime_import_sg_table(struct drm_device *dev,
 
 static int vc4_grab_bin_bo(struct vc4_dev *vc4, struct vc4_file *vc4file)
 {
-	int ret;
-
 	if (!vc4->v3d)
 		return -ENODEV;
 
 	if (vc4file->bin_bo_used)
 		return 0;
 
-	ret = vc4_v3d_bin_bo_get(vc4, &vc4file->bin_bo_used);
-	if (ret)
-		return ret;
-
-	return 0;
+	return vc4_v3d_bin_bo_get(vc4, &vc4file->bin_bo_used);
 }
 
 int vc4_create_bo_ioctl(struct drm_device *dev, void *data,
-- 
2.23.0

