Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934CB2A959B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgKFLpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:45:05 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53504 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727055AbgKFLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:44:54 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6BhMYX009729;
        Fri, 6 Nov 2020 03:44:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=i2DBOv9uOnqvcgP4ekF+epl+MNoWhiekHgBKPGU1ZxQ=;
 b=cfhdMkyi5f2tA193Oo+HAY0HfHqGjrLGAxRcUxQXHqsyReymueZxLA5O1EU1tjhvX81G
 6bKLYgi7Kks7T3FKeSCwKh6G744Dhrcf+P/plnb4vyLAKHkT3ii/emQdhyIgjkml7XsR
 0m7aQJVk3uIqQqWIuIaCI8KS49hy41ANJkScerBjHBnG86NpOAClnu574NfuDH56/qfE
 LAndhb4890Xnk3MJVGC8UGYSOMu4VIyN9dCa465TkWP3nA6vgYDo3B6kuXuqOzbGT40C
 zh/m5jnBprcYxJh64Xm4yAQPtuXV8GQoloJd4BnwJ5ULv/VllAwsa7jPxz6aFem464cv oA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34h4fvsr8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 03:44:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrUhNKw2aq3zMXv85s2HQnDFPpBF749cSi1ygV4Bd68i+XfnmSGVkJy8oi2J53Zdvg+fwUfG+fqIU6C1U+d6t1YWpsnG2qaAOE3JKALGPKxoV6TL70w0l1Pv9a8PE6RBb0XQXp+BYJni+oYTg3daC/NqjjFbCBvmjcGTAdWEyyki/+9CCXCpGeU4QECB2FdavICzSXtbU/wTouCnvZz97PQjmkZyJ6bVrF5EQVbX0n1Cv7IgZ/Zjo3p1aN4reCFpnr+RZCXd487HPkYB5JUIsuXwNHPJXcrhiJOw1sUAF3Llwas97Fc324rnEWhn16059JSpZCvPeGtrX+N0KrAAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2DBOv9uOnqvcgP4ekF+epl+MNoWhiekHgBKPGU1ZxQ=;
 b=TWKmC6Y8GIC8Hr0Kqj8NoUJOIU6grftYPjy1oOM375AHdNEkrbR9gHNVwxE3IbrioiTo5kRk+gKXuG3fwLIYCFoQwC+nzbOND0N321I84n+NBkTcSDz4vB/VxKToghWkAmXLDA2XGsSWaqzdsq5rtYSl8nLjJQFBqwgCcxrNUKAoE4SNPe2DXog/w0E+/lmih34UfnCky2vrYSBLzQyLLAODikRgQE7mEhzlbe/QwJnkjdm9GtXfwk8V/cN9mS0AoF31v0G40Ju80ovoFFk+3DnKW3DLpYLcBNTVf4k/RuoojRQJPfwLXIk1Od6ejEh73nHLjQCsplcmDNyemrtMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2DBOv9uOnqvcgP4ekF+epl+MNoWhiekHgBKPGU1ZxQ=;
 b=Moo/1ogtX0Z1H446YirGgeF88utraEGPBU5u6qWModtgP5MUlynOaELcHF3cGLq7fFnZPuW1nv07KGbZIgpRPFeobtKkrk2NbNUamhLAGT8uEQQIowSh4WhgFLh8RK09tWpV7LqoXdSUFghDj4khFjeYQoe4jP597kR4SWb02Ok=
Received: from BN4PR12CA0005.namprd12.prod.outlook.com (2603:10b6:403:2::15)
 by CH2PR07MB6695.namprd07.prod.outlook.com (2603:10b6:610:2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 11:44:20 +0000
Received: from BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
 (2603:10b6:403:2:cafe::47) by BN4PR12CA0005.outlook.office365.com
 (2603:10b6:403:2::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22 via Frontend
 Transport; Fri, 6 Nov 2020 11:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT036.mail.protection.outlook.com (10.13.182.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 11:44:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0A6BiFAn094912
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 03:44:18 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 6 Nov 2020 12:44:14 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 6 Nov 2020 12:44:14 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0A6BiEK3001573;
        Fri, 6 Nov 2020 12:44:14 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0A6BiEm0001572;
        Fri, 6 Nov 2020 12:44:14 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 03/10] usb: cdns3: Moves reusable code to separate module
Date:   Fri, 6 Nov 2020 12:42:53 +0100
Message-ID: <20201106114300.1245-4-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201106114300.1245-1-pawell@cadence.com>
References: <20201106114300.1245-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7609e7e-6f83-421d-b4b1-08d882494c28
X-MS-TrafficTypeDiagnostic: CH2PR07MB6695:
X-Microsoft-Antispam-PRVS: <CH2PR07MB6695B1DC6B95535101829392DDED0@CH2PR07MB6695.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3YFGuRc0OdilGUt5Wx0u2yNMQtxG/geQrEyFr3gtzm2YPfxfaBDOGjis7h6AwUmUpkkrGsCYDXkgMy5NbNqDEyqR0654aEIbrT9S5wrcPOPut1nqpRdZcPYBrpI81NP1JJtfiG+Znq83372Qd1i6bYEek6stkRweC8gNJPIpaiwXkEAaCtnpajESoT1QzrfxqGcx3HITJblMc7osNL38RGncnpJR/nbP9lgaiBYUGcl/+kOpnckQk6cjuWRJ8rvFbNp9+fhgeHBj9/fytm5GIHLKksjD0SERLq/Tc1A6XUUt6EcoOI0bFxltA36WR6M5yD4FlSmXiSGY70kwCpfeP8zuZ47rf4mUc47KFJ+tDzEasFZpcYqnzjK96uFkjJD8oW7gmOIqlHYTV59CAEHYQXtizQGmsCYy6yBxitzZKTc=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(36092001)(46966005)(81166007)(107886003)(36756003)(8676002)(8936002)(70586007)(86362001)(478600001)(26005)(186003)(356005)(426003)(47076004)(336012)(2616005)(70206006)(4326008)(82740400003)(42186006)(316002)(36906005)(1076003)(82310400003)(6916009)(2906002)(54906003)(83380400001)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 11:44:19.3405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7609e7e-6f83-421d-b4b1-08d882494c28
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6695
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_03:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=863 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060086
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
 drivers/usb/cdns3/core.h       | 11 +++++++----
 drivers/usb/cdns3/drd.c        |  3 ++-
 drivers/usb/cdns3/drd.h        |  4 ++--
 7 files changed, 41 insertions(+), 13 deletions(-)

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
index b74882af3a9f..562163c81911 100644
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
index 7e5d9a344a53..96bdab7e8357 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -75,6 +75,7 @@ struct cdns3_platform_data {
  * @wakeup_pending: wakeup interrupt pending
  * @pdata: platform data from glue layer
  * @lock: spinlock structure
+ * @gadget_init: pointer to gadget initialization function
  */
 struct cdns3 {
 	struct device			*dev;
@@ -111,14 +112,16 @@ struct cdns3 {
 	bool				wakeup_pending;
 	struct cdns3_platform_data	*pdata;
 	spinlock_t			lock;
+
+	int (*gadget_init)(struct cdns3 *cdns);
 };
 
 int cdns3_hw_role_switch(struct cdns3 *cdns);
-int cdns3_init(struct cdns3 *cdns);
-int cdns3_remove(struct cdns3 *cdns);
+extern int cdns3_init(struct cdns3 *cdns);
+extern int cdns3_remove(struct cdns3 *cdns);
 
 #ifdef CONFIG_PM_SLEEP
-int cdns3_resume(struct cdns3 *cdns, u8 set_active);
-int cdns3_suspend(struct cdns3 *cdns);
+extern int cdns3_resume(struct cdns3 *cdns, u8 set_active);
+extern int cdns3_suspend(struct cdns3 *cdns);
 #endif /* CONFIG_PM_SLEEP */
 #endif /* __LINUX_CDNS3_CORE_H */
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
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index d752d8806a38..972aba8a40b6 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -209,8 +209,8 @@ int cdns3_get_vbus(struct cdns3 *cdns);
 int cdns3_drd_init(struct cdns3 *cdns);
 int cdns3_drd_exit(struct cdns3 *cdns);
 int cdns3_drd_update_mode(struct cdns3 *cdns);
-int cdns3_drd_gadget_on(struct cdns3 *cdns);
-void cdns3_drd_gadget_off(struct cdns3 *cdns);
+extern int cdns3_drd_gadget_on(struct cdns3 *cdns);
+extern void cdns3_drd_gadget_off(struct cdns3 *cdns);
 int cdns3_drd_host_on(struct cdns3 *cdns);
 void cdns3_drd_host_off(struct cdns3 *cdns);
 
-- 
2.17.1

