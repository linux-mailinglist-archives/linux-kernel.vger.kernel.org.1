Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A81929EBD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 13:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgJ2MZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 08:25:55 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37362 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgJ2MZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 08:25:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCOojK082355;
        Thu, 29 Oct 2020 12:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=muC+62ccY3AJOJRwsluIQP+9e8kedGedtYzp9yud9+Y=;
 b=nbvroTbmCKbWjCxuWYjnzpJRG5mmu5g/VWnvGa2Hmg5ifn2mLfbTCc+UyWkqwww0+LKd
 BBfek//51yIrJq1pmoxn1iPSbKvZoNOu9EKJsEBiua1HfCy6B10pGY/u8rgitvwLoGxd
 cK8RIy+7uNPablAuIzi835U/QXantWZNWymvDY9Vr83JLjMU0PD2mquZIYnwFgi+ZmjD
 oyoIe/RwC0cMxXpxdQ/PMoKhPCGPLHedZ2wE4rSU77TtP/rwyiTYSGfHlhgaYe73oN7J
 gny67V/kvNaEziE7r/2Aq6rlqQtr9NynqCjzsgSDiEb5fr/0tYCvQ2M+eTUMWntP+PlG LQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34dgm4a41e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Oct 2020 12:25:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09TCAPio059339;
        Thu, 29 Oct 2020 12:25:53 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 34cx1t5ere-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Oct 2020 12:25:53 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09TCPod0000862;
        Thu, 29 Oct 2020 12:25:52 GMT
Received: from mihai.localdomain (/10.153.73.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Oct 2020 05:25:50 -0700
From:   Mihai Carabas <mihai.carabas@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     Peng Hao <peng.hao2@zte.com.cn>,
        Mihai Carabas <mihai.carabas@oracle.com>
Subject: [PATCH 3/4] misc/pvpanic: Avoid initializing multiple pvpanic devices
Date:   Thu, 29 Oct 2020 13:43:06 +0200
Message-Id: <1603971787-16784-4-git-send-email-mihai.carabas@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com>
References: <1603971787-16784-1-git-send-email-mihai.carabas@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=2 malwarescore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9788 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=2 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010290092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Hao <peng.hao2@zte.com.cn>

Avoid initializing multiple pvpanic devices when configure multiple
pvpanic device driver type. Make sure that only one pvpanic device
is working.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
---
 drivers/misc/pvpanic/pvpanic.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 4c831f5..8c7b534 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -17,10 +17,13 @@
 #include <uapi/misc/pvpanic.h>
 
 static struct {
+	struct mutex lock;
 	struct platform_device *pdev;
 	void __iomem *base;
 	bool is_ioport;
-} pvpanic_data;
+} pvpanic_data = {
+	.lock = __MUTEX_INITIALIZER(pvpanic_data.lock),
+};
 
 MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic device driver");
@@ -56,9 +59,17 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
 	struct platform_device *pdev;
 	int ret;
 
+	mutex_lock(&pvpanic_data.lock);
+	if (pvpanic_data.pdev) {
+		mutex_unlock(&pvpanic_data.lock);
+		return -EEXIST;
+	}
+
 	pdev = platform_device_alloc("pvpanic", -1);
-	if (!pdev)
+	if (!pdev) {
+		mutex_unlock(&pvpanic_data.lock);
 		return -ENOMEM;
+	}
 
 	pdev->dev.parent = dev;
 
@@ -70,9 +81,11 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
 	if (ret)
 		goto err;
 	pvpanic_data.pdev = pdev;
+	mutex_unlock(&pvpanic_data.lock);
 
 	return 0;
 err:
+	mutex_unlock(&pvpanic_data.lock);
 	platform_device_put(pdev);
 	return ret;
 }
@@ -80,8 +93,10 @@ int pvpanic_add_device(struct device *dev, struct resource *res)
 
 void pvpanic_remove_device(void)
 {
+	mutex_lock(&pvpanic_data.lock);
 	platform_device_unregister(pvpanic_data.pdev);
 	pvpanic_data.pdev = NULL;
+	mutex_unlock(&pvpanic_data.lock);
 }
 EXPORT_SYMBOL_GPL(pvpanic_remove_device);
 
-- 
1.8.3.1

