Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D022D5C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbgLJNwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:52:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9589 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgLJNwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:52:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsFg50F1mzM34n;
        Thu, 10 Dec 2020 21:50:41 +0800 (CST)
Received: from ubuntu.network (10.175.138.68) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 10 Dec 2020 21:51:14 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <johan@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] drivers: gnss: simplify the gnss code return expression
Date:   Thu, 10 Dec 2020 21:51:42 +0800
Message-ID: <20201210135142.1138-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.138.68]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the return expression at diffrent .c file, fix this all.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 drivers/gnss/core.c |  7 +------
 drivers/gnss/mtk.c  | 14 ++------------
 drivers/gnss/ubx.c  | 14 ++------------
 3 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
index e6f94501cb28..e6b9ac9da92c 100644
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
diff --git a/drivers/gnss/mtk.c b/drivers/gnss/mtk.c
index d1fc55560daf..451cb6e66ec3 100644
--- a/drivers/gnss/mtk.c
+++ b/drivers/gnss/mtk.c
@@ -24,25 +24,15 @@ struct mtk_data {
 static int mtk_set_active(struct gnss_serial *gserial)
 {
 	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
-	int ret;
 
-	ret = regulator_enable(data->vcc);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regulator_enable(data->vcc);
 }
 
 static int mtk_set_standby(struct gnss_serial *gserial)
 {
 	struct mtk_data *data = gnss_serial_get_drvdata(gserial);
-	int ret;
 
-	ret = regulator_disable(data->vcc);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regulator_disable(data->vcc);
 }
 
 static int mtk_set_power(struct gnss_serial *gserial,
diff --git a/drivers/gnss/ubx.c b/drivers/gnss/ubx.c
index 7b05bc40532e..7a22fc901fab 100644
--- a/drivers/gnss/ubx.c
+++ b/drivers/gnss/ubx.c
@@ -24,25 +24,15 @@ struct ubx_data {
 static int ubx_set_active(struct gnss_serial *gserial)
 {
 	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
-	int ret;
 
-	ret = regulator_enable(data->vcc);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regulator_enable(data->vcc);
 }
 
 static int ubx_set_standby(struct gnss_serial *gserial)
 {
 	struct ubx_data *data = gnss_serial_get_drvdata(gserial);
-	int ret;
 
-	ret = regulator_disable(data->vcc);
-	if (ret)
-		return ret;
-
-	return 0;
+	return regulator_disable(data->vcc);
 }
 
 static int ubx_set_power(struct gnss_serial *gserial,
-- 
2.22.0

