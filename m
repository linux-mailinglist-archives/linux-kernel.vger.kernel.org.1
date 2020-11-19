Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC192B944D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgKSOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:15:06 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:21730 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727074AbgKSOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:15:05 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJE92Pj001995;
        Thu, 19 Nov 2020 06:14:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=aSuCLNPgo+KHFDHTJ8YCkAJtazuxUT5ibB808A22RgI=;
 b=WPQtThNVNU0GlR+q18p3DrvSjoj3dfv4o0zv4rcKfCNeGo5yhjaH9e2+UScB8T9ltgoI
 3CbY8HQ30EHwFKmvZQA530Uwqj+6qHSWbtuiKXYJrKf21xmrsCFaqahcHKhbQ1BAZqz2
 AWcqyWzKzG1NP3McHaLkJwSnuFczreF89gVVY2px0bsY9VOtQ/UH4isrAjin+SLTQeuR
 IplbYSd4RmBqfF9z2ldGFmxg9Kkp/mk0vUg2CU27J9Cc2B8x48ifFJ4QfHOtOE7695V1
 dPBBuzHwiPS1WSpX6RyGM2NUwrU09eOsb8pq4nxbfhPRlj9H/ISVBda9dq+05PzABqdd UA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34tbq34yt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 06:14:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWjKKYyN8anbofuEdQbZC06Ovqmrf8utF4kZTxnALdbhKmwHMsrrKFE/joPgaroW7gaLOI/NXPF15uNFVIOFWrw5JQDEzm3eItnk93nJZcsbY+bojCZTO5oMOhHyF1PiterTG4SG5uqWZIpc5tjlNtr+90Nt5wcpkjj192dwpLfSdKkzG8nUwV9LfuGCHIS6tb7ALJwj87HYvucmN8zGgi5cyQYuq8i7+CRWjxwBm2ouUxckDHy4bkH3IVTyimhCT/NUfqgo72epWUNfdGsiuXqveZrd03PjQigmXggiHFjkAoF+hFUc7C/PNbmxNzlhkJ/2jxtyOTQgOzQnl9EmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSuCLNPgo+KHFDHTJ8YCkAJtazuxUT5ibB808A22RgI=;
 b=L56201D6CRum5liyG/JRLWAV+cQxqH1vliLb1gw/TsDsNM5wP/DDvVw67TEQQ700GjTePgQf9fEKlXQiWwlIL5alBUNyleAGRH6QG48Ot7ID/r5KSu9HoiWYfIaNfSK97Rgg1GqA/+nyb1GgbWTIhieUnDrxpu2rbCr4njk24l3G4gh+decG++ZFt5/z5tv9M2ZPxsKt8PfrLwY0Qmj7OCrcf8UN4g7/7pY/LCtc1TM6z41t64AFxKuFpHu36XHmKVhflzatVaADYAqoL8d6hXWCafj5Ar6Il/iLjeFmT4whwTl4OYk1+vstYzlU8TrKrgnQMrAflLHEqdm2NnZi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aSuCLNPgo+KHFDHTJ8YCkAJtazuxUT5ibB808A22RgI=;
 b=lZM4xb5MTHmhHS3aqJPI6q0hlu/kJxGZgZBU1PMEVvdOfZUKlES6MhqKe3ROgwF2OSIczFkKAecKJoKrKQUt/W8eeC5RrNa8tgNA/9kKVgtJdHWx+mq5kClU4wj+/74Wj871d3jdYHGmH8LR0X60FdlGy8TNfjD9IP3ATN8xbz4=
Received: from BN0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:408:e6::31)
 by DM6PR07MB5148.namprd07.prod.outlook.com (2603:10b6:5:42::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.26; Thu, 19 Nov
 2020 14:14:33 +0000
Received: from BN8NAM12FT014.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::f4) by BN0PR03CA0026.outlook.office365.com
 (2603:10b6:408:e6::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Thu, 19 Nov 2020 14:14:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT014.mail.protection.outlook.com (10.13.183.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.12 via Frontend Transport; Thu, 19 Nov 2020 14:14:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEERJ6022418
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 19 Nov 2020 06:14:31 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Nov 2020 15:14:26 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 19 Nov 2020 15:14:26 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEEQvU011731;
        Thu, 19 Nov 2020 15:14:26 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AJEEQXR011730;
        Thu, 19 Nov 2020 15:14:26 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3 03/10] usb: cdns3: Moves reusable code to separate module
Date:   Thu, 19 Nov 2020 15:13:00 +0100
Message-ID: <20201119141307.8342-4-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201119141307.8342-1-pawell@cadence.com>
References: <20201119141307.8342-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 701dc2ea-b1fb-490b-3b8b-08d88c956fde
X-MS-TrafficTypeDiagnostic: DM6PR07MB5148:
X-Microsoft-Antispam-PRVS: <DM6PR07MB5148E03DD32D37BC5D19C145DDE00@DM6PR07MB5148.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d8DmfH1pu/q0WE4y8GZJFR6qjCch3Plh2iXYSmkpalGCyS6cUuPEUIxgj8EmJBoldjtK9YVARRe9Xy6VVOj8SPTteY7RTYqn5TcOfVtAFfZ31U2nJwFGFdGCN/6aoBPplUUtP3OjfuK0M82Ii4NyyFJoGMYWwP9hSkza2/KSLNCh93SUMLG4olWJh6ZPG4ihQrBgHpS0BWlxXtCctF5pl5teFQnhVIcoUdXdljh0zG/A0LWGpld/j/mPfEgk9b7MQYlDtPIgBOLD4DQ51TEeNRLXhTttEw/lBnhpQapIvY0w0C718/WMbUjfE/DrG3no+l1MHaWq8CmI53EAExDYntKQazlsh5GKyi2RizAqzM0L5dVNTenDQtKh/2+GnfVDNk/Ro9uwSM0z+TQ2ktD+OU/+pjwiSg6cA+Sc55mHcZU=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36092001)(46966005)(1076003)(54906003)(4326008)(70586007)(2906002)(6666004)(82310400003)(7636003)(5660300002)(186003)(107886003)(6916009)(86362001)(356005)(2616005)(336012)(47076004)(478600001)(82740400003)(8676002)(426003)(83380400001)(26005)(70206006)(316002)(36756003)(42186006)(36906005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 14:14:32.6326
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 701dc2ea-b1fb-490b-3b8b-08d88c956fde
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT014.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5148
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves common reusable code used by cdns3 and cdnsp driver
to cdns-usb-common library. This library include core.c, drd.c
and host.c files.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/Kconfig      |  8 ++++++++
 drivers/usb/cdns3/Makefile     |  8 +++++---
 drivers/usb/cdns3/cdns3-plat.c |  2 ++
 drivers/usb/cdns3/core.c       | 18 +++++++++++++++---
 drivers/usb/cdns3/core.h       |  3 +++
 drivers/usb/cdns3/drd.c        |  3 ++-
 6 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/cdns3/Kconfig b/drivers/usb/cdns3/Kconfig
index 84716d216ae5..58154c0a73ac 100644
--- a/drivers/usb/cdns3/Kconfig
+++ b/drivers/usb/cdns3/Kconfig
@@ -1,8 +1,15 @@
+config CDNS_USB_COMMON
+	tristate
+
+config CDNS_USB_HOST
+	bool
+
 config USB_CDNS3
 	tristate "Cadence USB3 Dual-Role Controller"
 	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
 	select USB_XHCI_PLATFORM if USB_XHCI_HCD
 	select USB_ROLE_SWITCH
+	select CDNS_USB_COMMON
 	help
 	  Say Y here if your system has a Cadence USB3 dual-role controller.
 	  It supports: dual-role switch, Host-only, and Peripheral-only.
@@ -25,6 +32,7 @@ config USB_CDNS3_GADGET
 config USB_CDNS3_HOST
 	bool "Cadence USB3 host controller"
 	depends on USB=y || USB=USB_CDNS3
+	select CDNS_USB_HOST
 	help
 	  Say Y here to enable host controller functionality of the
 	  Cadence driver.
diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index a1fe9612053a..16df87abf3cf 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -2,17 +2,19 @@
 # define_trace.h needs to know how to find our header
 CFLAGS_trace.o				:= -I$(src)
 
-cdns3-y					:= cdns3-plat.o core.o drd.o
+cdns-usb-common-y			:= core.o drd.o
+cdns3-y					:= cdns3-plat.o
 
 obj-$(CONFIG_USB_CDNS3)			+= cdns3.o
+obj-$(CONFIG_CDNS_USB_COMMON)		+= cdns-usb-common.o
+
+cdns-usb-common-$(CONFIG_CDNS_USB_HOST) += host.o
 cdns3-$(CONFIG_USB_CDNS3_GADGET)	+= gadget.o ep0.o
 
 ifneq ($(CONFIG_USB_CDNS3_GADGET),)
 cdns3-$(CONFIG_TRACING)			+= trace.o
 endif
 
-cdns3-$(CONFIG_USB_CDNS3_HOST)		+= host.o
-
 obj-$(CONFIG_USB_CDNS3_PCI_WRAP)	+= cdns3-pci-wrap.o
 obj-$(CONFIG_USB_CDNS3_TI)		+= cdns3-ti.o
 obj-$(CONFIG_USB_CDNS3_IMX)		+= cdns3-imx.o
diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index d538b3b2657f..ddebb1511c56 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 
 #include "core.h"
+#include "gadget-export.h"
 
 static int set_phy_power_on(struct cdns3 *cdns)
 {
@@ -134,6 +135,7 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_phy_power_on;
 
+	cdns->gadget_init = cdns3_gadget_init;
 	ret = cdns3_init(cdns);
 	if (ret)
 		goto err_cdns_init;
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 758fd5d67196..4fedf32855af 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -19,10 +19,8 @@
 #include <linux/io.h>
 #include <linux/pm_runtime.h>
 
-#include "gadget.h"
 #include "core.h"
 #include "host-export.h"
-#include "gadget-export.h"
 #include "drd.h"
 
 static int cdns3_idle_init(struct cdns3 *cdns);
@@ -147,7 +145,11 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	}
 
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_PERIPHERAL) {
-		ret = cdns3_gadget_init(cdns);
+		if (cdns->gadget_init)
+			ret = cdns->gadget_init(cdns);
+		else
+			ret = -ENXIO;
+
 		if (ret) {
 			dev_err(dev, "Device initialization failed with %d\n",
 				ret);
@@ -473,6 +475,7 @@ int cdns3_init(struct cdns3 *cdns)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns3_init);
 
 /**
  * cdns3_remove - unbind drd driver and clean up
@@ -487,6 +490,7 @@ int cdns3_remove(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_remove);
 
 #ifdef CONFIG_PM_SLEEP
 int cdns3_suspend(struct cdns3 *cdns)
@@ -505,6 +509,7 @@ int cdns3_suspend(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_suspend);
 
 int cdns3_resume(struct cdns3 *cdns, u8 set_active)
 {
@@ -521,4 +526,11 @@ int cdns3_resume(struct cdns3 *cdns, u8 set_active)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_resume);
 #endif /* CONFIG_PM_SLEEP */
+
+MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
+MODULE_DESCRIPTION("Cadence USBSS and USBSSP DRD Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index c97c2bb1582f..2fe482dee4d7 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -78,6 +78,7 @@ struct cdns3_platform_data {
  * @pdata: platform data from glue layer
  * @lock: spinlock structure
  * @xhci_plat_data: xhci private data structure pointer
+ * @gadget_init: pointer to gadget initialization function
  */
 struct cdns3 {
 	struct device			*dev;
@@ -115,6 +116,8 @@ struct cdns3 {
 	struct cdns3_platform_data	*pdata;
 	spinlock_t			lock;
 	struct xhci_plat_priv		*xhci_plat_data;
+
+	int (*gadget_init)(struct cdns3 *cdns);
 };
 
 int cdns3_hw_role_switch(struct cdns3 *cdns);
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index ed8cde91a02c..1874dc6018f0 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -15,7 +15,6 @@
 #include <linux/iopoll.h>
 #include <linux/usb/otg.h>
 
-#include "gadget.h"
 #include "drd.h"
 #include "core.h"
 
@@ -226,6 +225,7 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns)
 	phy_set_mode(cdns->usb3_phy, PHY_MODE_USB_DEVICE);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_drd_gadget_on);
 
 /**
  * cdns3_drd_gadget_off - stop gadget.
@@ -249,6 +249,7 @@ void cdns3_drd_gadget_off(struct cdns3 *cdns)
 				  1, 2000000);
 	phy_set_mode(cdns->usb3_phy, PHY_MODE_INVALID);
 }
+EXPORT_SYMBOL_GPL(cdns3_drd_gadget_off);
 
 /**
  * cdns3_init_otg_mode - initialize drd controller
-- 
2.17.1

