Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A142FCB25
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 07:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbhATGnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 01:43:45 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41726 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727654AbhATGmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 01:42:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UMJ.riZ_1611124873;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMJ.riZ_1611124873)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jan 2021 14:41:18 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     rydberg@bitmath.org
Cc:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] hwmon: (applesmc) Assign boolean values to a bool variable
Date:   Wed, 20 Jan 2021 14:41:10 +0800
Message-Id: <1611124870-125658-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/hwmon/applesmc.c:568:6-23: WARNING: Assignment of
0/1 to bool variable.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/hwmon/applesmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index 89207af..28b137e 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -565,7 +565,7 @@ static int applesmc_init_index(struct applesmc_registers *s)
 static int applesmc_init_smcreg_try(void)
 {
 	struct applesmc_registers *s = &smcreg;
-	bool left_light_sensor = 0, right_light_sensor = 0;
+	bool left_light_sensor = false, right_light_sensor = false;
 	unsigned int count;
 	u8 tmp[1];
 	int ret;
-- 
1.8.3.1

