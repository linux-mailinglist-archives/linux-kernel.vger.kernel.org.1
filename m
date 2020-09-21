Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96C63272516
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgIUNOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:14:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13754 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727207AbgIUNKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:04 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E7E95384D5219CC99EB4;
        Mon, 21 Sep 2020 21:10:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:09:55 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Rob Herring <robh@kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] drm/panfrost: simplify the return expression of cz_ih_hw_init()
Date:   Mon, 21 Sep 2020 21:10:19 +0800
Message-ID: <20200921131019.91558-1-miaoqinglang@huawei.com>
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
 drivers/gpu/drm/panfrost/panfrost_device.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
index e68967338..ea8d31863 100644
--- a/drivers/gpu/drm/panfrost/panfrost_device.c
+++ b/drivers/gpu/drm/panfrost/panfrost_device.c
@@ -18,19 +18,13 @@
 
 static int panfrost_reset_init(struct panfrost_device *pfdev)
 {
-	int err;
-
 	pfdev->rstc = devm_reset_control_array_get(pfdev->dev, false, true);
 	if (IS_ERR(pfdev->rstc)) {
 		dev_err(pfdev->dev, "get reset failed %ld\n", PTR_ERR(pfdev->rstc));
 		return PTR_ERR(pfdev->rstc);
 	}
 
-	err = reset_control_deassert(pfdev->rstc);
-	if (err)
-		return err;
-
-	return 0;
+	return reset_control_deassert(pfdev->rstc);
 }
 
 static void panfrost_reset_fini(struct panfrost_device *pfdev)
-- 
2.23.0

