Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855492EEF5C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbhAHJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:21:07 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10043 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbhAHJVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:21:06 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DByGl2PVszj5R8;
        Fri,  8 Jan 2021 17:19:27 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Fri, 8 Jan 2021 17:20:16 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <lee.jones@linaro.org>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH v2 -next] mfd: convert comma to semicolon
Date:   Fri, 8 Jan 2021 17:20:58 +0800
Message-ID: <20210108092058.18576-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a comma between expression statements by a semicolon.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/mfd/88pm860x-core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/88pm860x-core.c b/drivers/mfd/88pm860x-core.c
index c9bae71f643a..a9e0855b4c66 100644
--- a/drivers/mfd/88pm860x-core.c
+++ b/drivers/mfd/88pm860x-core.c
@@ -916,7 +916,7 @@ static void device_power_init(struct pm860x_chip *chip,
 	power_devs[0].platform_data = pdata->power;
 	power_devs[0].pdata_size = sizeof(struct pm860x_power_pdata);
 	power_devs[0].num_resources = ARRAY_SIZE(battery_resources);
-	power_devs[0].resources = &battery_resources[0],
+	power_devs[0].resources = &battery_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &power_devs[0], 1,
 			      &battery_resources[0], chip->irq_base, NULL);
 	if (ret < 0)
@@ -925,7 +925,7 @@ static void device_power_init(struct pm860x_chip *chip,
 	power_devs[1].platform_data = pdata->power;
 	power_devs[1].pdata_size = sizeof(struct pm860x_power_pdata);
 	power_devs[1].num_resources = ARRAY_SIZE(charger_resources);
-	power_devs[1].resources = &charger_resources[0],
+	power_devs[1].resources = &charger_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &power_devs[1], 1,
 			      &charger_resources[0], chip->irq_base, NULL);
 	if (ret < 0)
@@ -942,7 +942,7 @@ static void device_power_init(struct pm860x_chip *chip,
 		pdata->chg_desc->charger_regulators =
 			&chg_desc_regulator_data[0];
 		pdata->chg_desc->num_charger_regulators	=
-			ARRAY_SIZE(chg_desc_regulator_data),
+			ARRAY_SIZE(chg_desc_regulator_data);
 		power_devs[3].platform_data = pdata->chg_desc;
 		power_devs[3].pdata_size = sizeof(*pdata->chg_desc);
 		ret = mfd_add_devices(chip->dev, 0, &power_devs[3], 1,
@@ -958,7 +958,7 @@ static void device_onkey_init(struct pm860x_chip *chip,
 	int ret;
 
 	onkey_devs[0].num_resources = ARRAY_SIZE(onkey_resources);
-	onkey_devs[0].resources = &onkey_resources[0],
+	onkey_devs[0].resources = &onkey_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &onkey_devs[0],
 			      ARRAY_SIZE(onkey_devs), &onkey_resources[0],
 			      chip->irq_base, NULL);
@@ -972,7 +972,7 @@ static void device_codec_init(struct pm860x_chip *chip,
 	int ret;
 
 	codec_devs[0].num_resources = ARRAY_SIZE(codec_resources);
-	codec_devs[0].resources = &codec_resources[0],
+	codec_devs[0].resources = &codec_resources[0];
 	ret = mfd_add_devices(chip->dev, 0, &codec_devs[0],
 			      ARRAY_SIZE(codec_devs), &codec_resources[0], 0,
 			      NULL);
-- 
2.22.0

