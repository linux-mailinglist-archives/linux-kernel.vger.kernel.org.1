Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D6D26BCC9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgIPGVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:21:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726183AbgIPGUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:20:55 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 055E765D4C38A2940654;
        Wed, 16 Sep 2020 14:20:48 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Wed, 16 Sep 2020 14:20:41 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Qinglang Miao" <miaoqinglang@huawei.com>
Subject: [PATCH -next] drivers/macintosh/smu.c: use for_each_child_of_node() macro
Date:   Wed, 16 Sep 2020 14:21:22 +0800
Message-ID: <20200916062122.190586-1-miaoqinglang@huawei.com>
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
 drivers/macintosh/smu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/smu.c b/drivers/macintosh/smu.c
index 96684581a..45875e8c6 100644
--- a/drivers/macintosh/smu.c
+++ b/drivers/macintosh/smu.c
@@ -638,7 +638,7 @@ static void smu_expose_childs(struct work_struct *unused)
 {
 	struct device_node *np;
 
-	for (np = NULL; (np = of_get_next_child(smu->of_node, np)) != NULL;)
+	for_each_child_of_node(smu->of_node, np)
 		if (of_device_is_compatible(np, "smu-sensors"))
 			of_platform_device_create(np, "smu-sensors",
 						  &smu->of_dev->dev);
-- 
2.23.0

