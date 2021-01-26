Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00543044DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390007AbhAZRQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:16:12 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28067 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387444AbhAZGWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:22:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UMxNTrM_1611642101;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMxNTrM_1611642101)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 14:21:46 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] hwmon: (pmbus) Simplify the calculation of variables
Date:   Tue, 26 Jan 2021 14:21:40 +0800
Message-Id: <1611642100-29937-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/hwmon/pmbus/pmbus_core.c:1265:24-26: WARNING !A || A && B is
equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 192442b..a78ae70 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1262,7 +1262,7 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 		 * which global bit is set) for this page is accessible.
 		 */
 		if (!ret && attr->gbit &&
-		    (!upper || (upper && data->has_status_word)) &&
+		    (!upper || data->has_status_word) &&
 		    pmbus_check_status_register(client, page)) {
 			ret = pmbus_add_boolean(data, name, "alarm", index,
 						NULL, NULL,
-- 
1.8.3.1

