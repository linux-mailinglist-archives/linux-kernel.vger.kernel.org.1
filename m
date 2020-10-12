Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030E228B5DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388282AbgJLNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:17:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387906AbgJLNRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:17:39 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3E6A525B094AB20EDF90;
        Mon, 12 Oct 2020 21:17:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 12 Oct 2020 21:17:29 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <TheSven73@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] staging: fieldbus: anybuss: jump to correct label in an error path
Date:   Mon, 12 Oct 2020 21:24:04 +0800
Message-ID: <20201012132404.113031-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In current code, controller_probe() misses to call ida_simple_remove()
in an error path. Jump to correct label to fix it.

Fixes: 17614978ed34 ("staging: fieldbus: anybus-s: support the Arcx anybus controller")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/staging/fieldbus/anybuss/arcx-anybus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/fieldbus/anybuss/arcx-anybus.c b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
index 5b8d0bae9ff3..b5fded15e8a6 100644
--- a/drivers/staging/fieldbus/anybuss/arcx-anybus.c
+++ b/drivers/staging/fieldbus/anybuss/arcx-anybus.c
@@ -293,7 +293,7 @@ static int controller_probe(struct platform_device *pdev)
 	regulator = devm_regulator_register(dev, &can_power_desc, &config);
 	if (IS_ERR(regulator)) {
 		err = PTR_ERR(regulator);
-		goto out_reset;
+		goto out_ida;
 	}
 	/* make controller info visible to userspace */
 	cd->class_dev = kzalloc(sizeof(*cd->class_dev), GFP_KERNEL);
-- 
2.17.1

