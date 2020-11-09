Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F422AB337
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgKIJKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:10:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7064 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbgKIJKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:10:13 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CV4vb10HxzhhSm;
        Mon,  9 Nov 2020 17:10:03 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 9 Nov 2020 17:10:01 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] firmware: arm_scmi: fix missing destroy_workqueue() on error in scmi_notification_init
Date:   Mon, 9 Nov 2020 17:15:17 +0800
Message-ID: <20201109091517.55895-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing destroy_workqueue() before return from
scmi_notification_init in the error handling case when
fails to do devm_kcalloc().

Fixes: bd31b249692e ("firmware: arm_scmi: Add notification dispatch and delivery")
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/firmware/arm_scmi/notify.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 2754f9d01636..3048e57d9731 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1476,8 +1476,10 @@ int scmi_notification_init(struct scmi_handle *handle)
 
 	ni->registered_protocols = devm_kcalloc(handle->dev, SCMI_MAX_PROTO,
 						sizeof(char *), GFP_KERNEL);
-	if (!ni->registered_protocols)
+	if (!ni->registered_protocols) {
+		destroy_workqueue(ni->notify_wq);
 		goto err;
+	}
 
 	mutex_init(&ni->pending_mtx);
 	hash_init(ni->pending_events_handlers);
-- 
2.23.0

