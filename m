Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8B2A9083
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgKFHjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:39:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7600 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgKFHjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:39:03 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSC1q2h5VzLtnJ;
        Fri,  6 Nov 2020 15:38:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 15:38:54 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <lee.jones@linaro.org>, <darkstar6262@gmail.com>,
        <sameo@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <jingxiangfeng@huawei.com>
Subject: [PATCH v2] mfd: htc-i2cpld: Add the missed i2c_put_adapter() in htcpld_register_chip_i2c()
Date:   Fri, 6 Nov 2020 15:43:46 +0800
Message-ID: <20201106074346.194621-1-jingxiangfeng@huawei.com>
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

Fixes: 6048a3dd2371 ("mfd: Add HTCPLD driver")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
v2:
- add the tag Fixes

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

