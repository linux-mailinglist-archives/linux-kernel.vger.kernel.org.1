Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA242BA3AF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 08:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKTHoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 02:44:17 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8560 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgKTHoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 02:44:17 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CcpT573QczLrm8;
        Fri, 20 Nov 2020 15:43:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 15:44:04 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     David Kershner <david.kershner@unisys.com>,
        <sparmaintainer@unisys.com>
CC:     <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] drivers: visorbus: fix use-after free bugs
Date:   Fri, 20 Nov 2020 15:48:44 +0800
Message-ID: <20201120074844.31277-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kfree(dev) is called in put_device(&dev->device) so that following
use would cause use-after-free bug.

There are two inappropriate use of put_device:

1. In create_visor_device, put dev_err before put_device to fix this.

2. In remove_visor_device, the former put_device is redundant because
   device_unregister contains put_device already.

Fixes: 93d3ad90c2d4 ("drivers: visorbus: move driver out of staging")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/visorbus/visorbus_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/visorbus/visorbus_main.c b/drivers/visorbus/visorbus_main.c
index 152fd29f0..031349baf 100644
--- a/drivers/visorbus/visorbus_main.c
+++ b/drivers/visorbus/visorbus_main.c
@@ -695,15 +695,14 @@ int create_visor_device(struct visor_device *dev)
 	return 0;
 
 err_put:
-	put_device(&dev->device);
 	dev_err(&dev->device, "Creating visor device failed. %d\n", err);
+	put_device(&dev->device);
 	return err;
 }
 
 void remove_visor_device(struct visor_device *dev)
 {
 	list_del(&dev->list_all);
-	put_device(&dev->device);
 	if (dev->pending_msg_hdr)
 		visorbus_response(dev, 0, CONTROLVM_DEVICE_DESTROY);
 	device_unregister(&dev->device);
-- 
2.23.0

