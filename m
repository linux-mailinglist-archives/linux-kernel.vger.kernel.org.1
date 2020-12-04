Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710262CE920
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgLDIAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:00:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8684 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgLDIAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:00:00 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnQ7f3wmzzkl46;
        Fri,  4 Dec 2020 15:58:38 +0800 (CST)
Received: from compute.localdomain (10.175.112.70) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 4 Dec 2020 15:59:07 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Alexander Graf <agraf@suse.de>,
        "J. German Rivera" <German.Rivera@freescale.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Zhang Changzhong <zhangchangzhong@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] bus: fsl-mc: fix error return code in fsl_mc_object_allocate()
Date:   Fri, 4 Dec 2020 16:02:47 +0800
Message-ID: <1607068967-31991-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 197f4d6a4a00 ("staging: fsl-mc: fsl-mc object allocator driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
---
 drivers/bus/fsl-mc/fsl-mc-allocator.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
index e71a6f5..2d7c764 100644
--- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
+++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
@@ -292,8 +292,10 @@ int __must_check fsl_mc_object_allocate(struct fsl_mc_device *mc_dev,
 		goto error;
 
 	mc_adev = resource->data;
-	if (!mc_adev)
+	if (!mc_adev) {
+		error = -EINVAL;
 		goto error;
+	}
 
 	mc_adev->consumer_link = device_link_add(&mc_dev->dev,
 						 &mc_adev->dev,
-- 
2.9.5

