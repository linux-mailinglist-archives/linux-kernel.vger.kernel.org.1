Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79A626BCD7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIPGXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:23:11 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12722 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbgIPGUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:20:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 941A61B18CA26962224C;
        Wed, 16 Sep 2020 14:20:53 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:44 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] macintosh: smu_sensors: use for_each_child_of_node() macro
Date:   Wed, 16 Sep 2020 14:21:25 +0800
Message-ID: <20200916062125.190729-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use for_each_child_of_node() macro instead of open coding it.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/macintosh/windfarm_smu_sensors.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 3e6059eaa..c8706cfb8 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -421,8 +421,7 @@ static int __init smu_sensors_init(void)
 		return -ENODEV;
 
 	/* Look for sensors subdir */
-	for (sensors = NULL;
-	     (sensors = of_get_next_child(smu, sensors)) != NULL;)
+	for_each_child_of_node(smu, sensors)
 		if (of_node_name_eq(sensors, "sensors"))
 			break;
 
-- 
2.23.0

