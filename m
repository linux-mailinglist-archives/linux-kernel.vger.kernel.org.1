Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29562C407A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 13:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgKYMrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 07:47:07 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:7987 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgKYMrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:47:07 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Ch0yC15Z8zhhMs;
        Wed, 25 Nov 2020 20:46:43 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 25 Nov 2020
 20:46:51 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <danil.kipnis@cloud.ionos.com>
CC:     <jinpu.wang@cloud.ionos.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>,
        <bobo.shaobowang@huawei.com>
Subject: [PATCH] block/rnbd: server: Fix error return code in rnbd_srv_create_dev_sysfs()
Date:   Wed, 25 Nov 2020 20:46:47 +0800
Message-ID: <20201125124647.30327-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return -ENOMEM error code from the error handling case where
kobject_create_and_add() failed instead of 0 in rnbd_srv_create_dev_sysfs(),
as done elsewhere in this function.

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/block/rnbd/rnbd-srv-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv-sysfs.c b/drivers/block/rnbd/rnbd-srv-sysfs.c
index 106775c074d1..5ba1a31ad626 100644
--- a/drivers/block/rnbd/rnbd-srv-sysfs.c
+++ b/drivers/block/rnbd/rnbd-srv-sysfs.c
@@ -52,8 +52,10 @@ int rnbd_srv_create_dev_sysfs(struct rnbd_srv_dev *dev,
 
 	dev->dev_sessions_kobj = kobject_create_and_add("sessions",
 							&dev->dev_kobj);
-	if (!dev->dev_sessions_kobj)
+	if (!dev->dev_sessions_kobj) {
+		ret = -ENOMEM;
 		goto put_dev_kobj;
+	}
 
 	bdev_kobj = &disk_to_dev(bdev->bd_disk)->kobj;
 	ret = sysfs_create_link(&dev->dev_kobj, bdev_kobj, "block_dev");
-- 
2.17.1

