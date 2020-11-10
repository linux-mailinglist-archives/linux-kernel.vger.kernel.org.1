Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0B2AD08A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 08:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgKJHhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 02:37:22 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7876 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJHhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 02:37:21 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CVfnz0g67z71Lr;
        Tue, 10 Nov 2020 15:37:11 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Tue, 10 Nov 2020 15:37:09 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH v2] firmware: arm_scmi: fix missing destroy_workqueue()
Date:   Tue, 10 Nov 2020 15:42:21 +0800
Message-ID: <20201110074221.41235-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

destroy_workqueue seems necessary before return from
scmi_notification_init in the error handling case when
fails to do devm_kcalloc(). Fix this by simply moving
devm_kcalloc to the front.

Fixes: bd31b249692e ("firmware: arm_scmi: Add notification dispatch and delivery")
Suggested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 v2: fix this problem by simply moving codes.

 drivers/firmware/arm_scmi/notify.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 2754f9d01636..fdb2cc95dfde 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1468,17 +1468,17 @@ int scmi_notification_init(struct scmi_handle *handle)
 	ni->gid = gid;
 	ni->handle = handle;
 
+	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
+						sizeof(char *), GFP_KERNEL);
+	if (!ni->registered_protocols)
+		goto err;
+
 	ni->notify_wq = alloc_workqueue("scmi_notify",
 					WQ_UNBOUND | WQ_FREEZABLE | WQ_SYSFS,
 					0);
 	if (!ni->notify_wq)
 		goto err;
 
-	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
-						sizeof(char *), GFP_KERNEL);
-	if (!ni->registered_protocols)
-		goto err;
-
 	mutex_init(&ni->pending_mtx);
 	hash_init(ni->pending_events_handlers);
 
-- 
2.23.0

