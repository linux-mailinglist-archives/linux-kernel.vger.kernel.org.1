Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B250C2BA3C1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgKTHol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:44:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8011 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgKTHoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:44:20 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcpTG1q7Bzhdfc;
        Fri, 20 Nov 2020 15:44:02 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 15:44:10 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH] s390: cmf: fix use-after-free in enable_cmf
Date:   Fri, 20 Nov 2020 15:48:50 +0800
Message-ID: <20201120074850.31609-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree(cdev) is called in put_device in the error branch. So that
device_unlock(&cdev->dev) would raise a use-after-free bug. In fact,
there's no need to call device_unlock after put_device.

Fix it by adding simply return after put_device.

Fixes: a6ef15652d26 ("s390/cio: fix use after free in cmb processing")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/s390/cio/cmf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 72dd2471e..e95ca476f 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -1149,9 +1149,12 @@ int enable_cmf(struct ccw_device *cdev)
 		sysfs_remove_group(&cdev->dev.kobj, cmbops->attr_group);
 		cmbops->free(cdev);
 	}
+
 out:
-	if (ret)
+	if (ret) {
 		put_device(&cdev->dev);
+		return ret;
+	}
 out_unlock:
 	device_unlock(&cdev->dev);
 	return ret;
-- 
2.23.0

