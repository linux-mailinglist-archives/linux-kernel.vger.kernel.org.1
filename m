Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D345272511
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 15:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbgIUNNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 09:13:50 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13802 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727227AbgIUNKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:12 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F6E49D0A94E9EA8856C;
        Mon, 21 Sep 2020 21:10:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:04 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Johan Hovold <johan@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] gnss: simplify the return expression of gnss_uevent
Date:   Mon, 21 Sep 2020 21:10:28 +0800
Message-ID: <20200921131028.91837-1-miaoqinglang@huawei.com>
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
 drivers/gnss/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index e6f94501c..e6b9ac9da 100644
--- a/drivers/gnss/core.c
+++ b/drivers/gnss/core.c
@@ -368,13 +368,8 @@ ATTRIBUTE_GROUPS(gnss);
 static int gnss_uevent(struct device *dev, struct kobj_uevent_env *env)
 {
 	struct gnss_device *gdev = to_gnss_device(dev);
-	int ret;
 
-	ret = add_uevent_var(env, "GNSS_TYPE=%s", gnss_type_name(gdev));
-	if (ret)
-		return ret;
-
-	return 0;
+	return add_uevent_var(env, "GNSS_TYPE=%s", gnss_type_name(gdev));
 }
 
 static int __init gnss_module_init(void)
-- 
2.23.0

