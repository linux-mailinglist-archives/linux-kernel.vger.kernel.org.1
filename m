Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45CC2D0E49
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgLGKmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:42:39 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:64828 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726188AbgLGKmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:42:12 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7AZP8Q029458;
        Mon, 7 Dec 2020 02:41:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=jsGYts2pQXstP692u8xBOeU5oI9vnz/vY618osftNOE=;
 b=UxUA51AMBTyflDKcakHUJn7ss+XmxdJYvgqPcunT/e/yk87cy+7Vs4ZT00NgqFNLi74A
 /fpzVFWRuwOEVDDkgG/1tByr2HJ+7QGscf0C0jKMRx1ROp6hePAWPetbwKE9GjpMqomA
 kAjJD/tIhWv5Bm6Xp/vldcT42SqK2bumJqFaRD+u7nBwO1F+3oFYffkX8kAwv5RF64EP
 HMLl/B588A1/lF48cjxF8xqoKm51hRYx73pYWtzxX9wGIxbLwz9sASSMe1uIa/+wvtvE
 NjJfvq8+Bkgo6Q9Y+QXKHik7KJJ7Gh4b86KNrQbpySo5E9LuN/Uz4yALFBTk5PQ2e+nF hg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3586p3vc2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 02:41:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoNzuDKl5DfAujNV3QTCacqeP9RiCopp4M5ymZ8MOWpd0cNnRJkSUNWWZO7ZMkpRsPuf1C/aF07pJKrdeXySRQWrzcB9ruPi6Arqc2nWbyBrSDzMY/M03qSUxfY75hQU/E2TOtnoZGY4Us+9cfz+Hsdp4jOIodNfcvLtRSFTVYyvl+idg/kG/iHJDw2KjYoycpumQd2UPIYhkeRNBSWm0uXWeqbTEal28ZKXF8f+1DgJT9oNUQpgTTkSlFORqFJafLefOWHod+bRDsrlU/P8lzv4haWK+SG+NeMkXSYHkZRRQuVGtibGfQKxlHhALRavlZ5IV1qkxRwRX84vYtpTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsGYts2pQXstP692u8xBOeU5oI9vnz/vY618osftNOE=;
 b=SSrPGHgUWV8AlXjmabD1CBei43P8Ib/JHKBBk6VY6WQbIZcRb8GTX9qZcKeohMc8CWSQcFdwUApwAW2xoEaZrj8ewu1QCVb8oKx866/RS66g0LCZtm0tksmtld4NqHA7394OmfXOX55GicVaHfr2V30Y6iYqTv2MFktu6Oh25x5FHjvsjYt+ZgK/u6iOBYxnlI0I1T5PkwMb5HxdOFbScATboskVxk3vfkLxZg+sdNe6Gn0IMi1Fe9wcPMNGBUUJiqlzNPVAccgdDymgcluCPZYMmJaioTi0BeU7WKxDKbgLAxAXsebj5ySsucwrQ2UfimQjDcMxTY4qAZeai83bGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsGYts2pQXstP692u8xBOeU5oI9vnz/vY618osftNOE=;
 b=d/Lj+DjIC9pwi0LqO/sDVEYwkmDo3PFUUTF0K3+SBiaVRgWxtxDY+SmYwvEIVTCHpfXbNBVd4Mf9GdMT8jxvV8uhCy8YfMuwiVdETVy4dbWVoJ/rpVXNCo86zTXVy9YtIgQWIecmWWX4u0ErWy6uEv2AwRAhhOveB3rM03/p4T0=
Received: from DM3PR14CA0143.namprd14.prod.outlook.com (2603:10b6:0:53::27) by
 BN8PR07MB6161.namprd07.prod.outlook.com (2603:10b6:408:b2::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Mon, 7 Dec 2020 10:41:00 +0000
Received: from DM6NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:53:cafe::d4) by DM3PR14CA0143.outlook.office365.com
 (2603:10b6:0:53::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 10:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT040.mail.protection.outlook.com (10.13.179.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10 via Frontend Transport; Mon, 7 Dec 2020 10:41:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7AeuT3007278
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Dec 2020 02:40:59 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 7 Dec 2020 11:40:56 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Dec 2020 11:40:56 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7Aeull006432;
        Mon, 7 Dec 2020 11:40:56 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B7Aeuxm006431;
        Mon, 7 Dec 2020 11:40:56 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, <a-govindraju@ti.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v5 03/10] usb: cdns3: Moves reusable code to separate module
Date:   Mon, 7 Dec 2020 11:32:20 +0100
Message-ID: <20201207103227.606-4-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201207103227.606-1-pawell@cadence.com>
References: <20201207103227.606-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4764c153-86cb-43b6-746a-08d89a9c9680
X-MS-TrafficTypeDiagnostic: BN8PR07MB6161:
X-Microsoft-Antispam-PRVS: <BN8PR07MB6161DC1E1D729D2D01826665DDCE0@BN8PR07MB6161.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mWdZ4w07iTmushzOKT8o/biq5/wPkC246UZ4FL/BUzFXZvZ4Q6ImMPh9p2ZkDeKdMSnoKfGHJqLz9QBYAd5bfVs/+1JSuXfVlRSaTM0pWa+I+bPqj0dFkTp5h+2PEQJxl7HzgEo2C5SonDF/qmKzTGz9y37aKu672okOmmBBJqGDAPphnSSaRcfTAPcR5W/QjD1GWhSyk76+ISRe7LK02AlCW4CLyOdsZbU1qGyc2zq4xpbV6sNIpUdOZ9eZpIbgOi38c1qDOjaPQw6TGHh3ZrCseuaf15GqeJbf/A1REdtnSLiMJpQ947O//Vw1Na65Kfgcnm6A0bzCQYLFNjRVmF9rVj5422FPnzgOxi1oKy8LzONpZ9Iw82FYbwDq+1Hu8sy937CWi5m/R0b60UBAaODVXpHnw44e0zBfi4R1YSBSYWtmjhFzo33t4AI2GWsUF359G3hSnhQzxZLmWWrzhg==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(36092001)(46966005)(70206006)(42186006)(356005)(47076004)(86362001)(70586007)(4326008)(5660300002)(83380400001)(316002)(1076003)(82740400003)(7636003)(82310400003)(107886003)(8676002)(186003)(26005)(54906003)(336012)(34020700004)(8936002)(2616005)(36756003)(426003)(478600001)(6666004)(2906002)(6916009)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 10:41:00.2542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4764c153-86cb-43b6-746a-08d89a9c9680
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6161
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-07_09:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=1
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012070067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch moves common reusable code used by cdns3 and cdnsp driver
to cdns-usb-common library. This library include core.c, drd.c
and host.c files.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Tested-by: Aswath Govindraju <a-govindraju@ti.com>
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
index 5dcb83af6c86..d7b07f1729d5 100644
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
index 7b67a7c74586..81ea035c0e11 100644
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
@@ -477,6 +479,7 @@ int cdns3_init(struct cdns3 *cdns)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(cdns3_init);
 
 /**
  * cdns3_remove - unbind drd driver and clean up
@@ -491,6 +494,7 @@ int cdns3_remove(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_remove);
 
 #ifdef CONFIG_PM_SLEEP
 int cdns3_suspend(struct cdns3 *cdns)
@@ -509,6 +513,7 @@ int cdns3_suspend(struct cdns3 *cdns)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(cdns3_suspend);
 
 int cdns3_resume(struct cdns3 *cdns, u8 set_active)
 {
@@ -525,4 +530,11 @@ int cdns3_resume(struct cdns3 *cdns, u8 set_active)
 
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

