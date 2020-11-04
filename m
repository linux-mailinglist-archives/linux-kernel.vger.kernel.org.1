Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649492A5E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 07:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgKDG0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 01:26:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6742 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgKDG0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 01:26:43 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CQxWJ1kcyzkYPD;
        Wed,  4 Nov 2020 14:26:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Wed, 4 Nov 2020 14:26:34 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH] mfd: htc-i2cpld: Add the missed i2c_put_adapter() in htcpld_register_chip_i2c()
Date:   Wed, 4 Nov 2020 14:31:58 +0800
Message-ID: <20201104063158.102048-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

htcpld_register_chip_i2c() misses to call i2c_put_adapter() in an error
path. Add the missed function call to fix it.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 drivers/mfd/htc-i2cpld.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/htc-i2cpld.c b/drivers/mfd/htc-i2cpld.c
index 247f9849e54a..417b0355d904 100644
--- a/drivers/mfd/htc-i2cpld.c
+++ b/drivers/mfd/htc-i2cpld.c
@@ -346,6 +346,7 @@ static int htcpld_register_chip_i2c(
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA)) {
 		dev_warn(dev, "i2c adapter %d non-functional\n",
 			 pdata->i2c_adapter_id);
+		i2c_put_adapter(adapter);
 		return -EINVAL;
 	}
 
@@ -360,6 +361,7 @@ static int htcpld_register_chip_i2c(
 		/* I2C device registration failed, contineu with the next */
 		dev_warn(dev, "Unable to add I2C device for 0x%x\n",
 			 plat_chip_data->addr);
+		i2c_put_adapter(adapter);
 		return PTR_ERR(client);
 	}
 
-- 
2.17.1

