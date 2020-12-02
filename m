Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF2742CBE35
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgLBN1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:27:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:7634 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727890AbgLBN1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:27:24 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2DOZUF002252;
        Wed, 2 Dec 2020 05:26:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=dkv036v8cz0p/oj3294SZHU9btCR1RFCaXVAbSTc/OY=;
 b=TSQ55QiE/MNH00CSmepzk+FTHf3wInQ5JPpLQqHyVFR+T7n0Io78GBO6l7EAxqZLYQ9J
 YJP5ch82ugJa2pEJuI4oOANw+tqunSuZDGCXqQJiP7avWBOP+hl5KmuqPLenXICezPIy
 9kdiobqzHaGU+D5D7tDGxdPmOpq74oHMMIK61pAEU2I9uRtrcFgRD+22xM+QfklFEx2F
 9sKBXSzhvl/Sp40fc8vpjz99DL6Xr9G15MjV6BEdJ19tdrsv0MlddokR9NVfgLzf6px2
 bA31WzLK4lpuf+Woe3NTkZjh9W/+4WMblrHJajPiZsJDFaQUGPC4FTOFYtfCdkh52ZeW 4A== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 355vn6apgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:26:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WQ5RlveLRJ7V779eC37E3cgnEWbIjm5bBg8rdbaXZEeEQEv7zLENDqjD8cczIyZVaefrtBGVQLRkY5eueX6msikEqutoV3XINZtC1jCjubz9lJpCMlMeiBKijCNDEYXkKeATZyaIqwtpBnOI9CUUTRiMpohR2ZvSg90nkVdWeJJGvwKqk44EbXJ1MWIboi5WZI6g2OlFzYIC6w4jDeYwxoFGHafSPXtoyYJpUm65jGXLbnZsxzYcAUBKBD7PMZ+sjlqdx8QRRYozKtfO+P18yZ6fJIJDoeVzkbCz33aamShCKoDdxoz9i/Cka8SlC1nKkPtAM7hv3AZZds6DrFD99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkv036v8cz0p/oj3294SZHU9btCR1RFCaXVAbSTc/OY=;
 b=Xi1TP5IyltB+DWaEoUe7ruaOKzs6mQjPxOAKMjV4BT+Op8eRgdtOJC3sS1G5h726eAEUWWxoCC2OzxvF1pYIruMaiEawNU7nD755Bn/icU6k5pRJkKtKHBRuklSqDou7/uUeY0CIwys0ov7IXOEE0H4SY87B6GQkZmQ3OvMGpez/FOpD2itula4zsWLEC4C2a4vkICrpas110vp25EogRgbEsZQF9jy+dIf3ecWslXbGxK+WDmL78rVzCRXVboiEnDmKYWStFTbvep0SQxVjeXGZRQvWJB3opyekwsa+w57wwgO+hBnrfHK2txtzcWBmoPa06SZzKzrzExKgo7oWhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkv036v8cz0p/oj3294SZHU9btCR1RFCaXVAbSTc/OY=;
 b=M0UTSNWjkMHacyUlHOM7O0xIdWw7b6yLWKMXainR1h2cFZnbLXJtcU9dREV498NrnU+fImmnsdY27ozzbEvWjA6t6fcBBv6m6hBo6UKnzIPS9+kdz3srZmlNG24eMQJ9bM4O7hM2JkGU3HLMEAiqGPpEp3D9XevLg8ReyHRi67M=
Received: from DM5PR16CA0037.namprd16.prod.outlook.com (2603:10b6:4:15::23) by
 CO2PR07MB2709.namprd07.prod.outlook.com (2603:10b6:102:13::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.20; Wed, 2 Dec 2020 13:26:11 +0000
Received: from DM6NAM12FT005.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::3b) by DM5PR16CA0037.outlook.office365.com
 (2603:10b6:4:15::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Wed, 2 Dec 2020 13:26:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT005.mail.protection.outlook.com (10.13.178.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.12 via Frontend Transport; Wed, 2 Dec 2020 13:26:11 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ6o9007337
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 2 Dec 2020 05:26:10 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 2 Dec 2020 14:26:06 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Dec 2020 14:26:06 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ6Ec010798;
        Wed, 2 Dec 2020 14:26:06 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B2DQ6Oj010797;
        Wed, 2 Dec 2020 14:26:06 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 03/10] usb: cdns3: Moves reusable code to separate module
Date:   Wed, 2 Dec 2020 14:25:41 +0100
Message-ID: <20201202132548.10736-4-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201202132548.10736-1-pawell@cadence.com>
References: <20201202132548.10736-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d42d7b7f-9dd2-4176-f04c-08d896c5d5e2
X-MS-TrafficTypeDiagnostic: CO2PR07MB2709:
X-Microsoft-Antispam-PRVS: <CO2PR07MB27095A72235D1806772925E0DDF30@CO2PR07MB2709.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:127;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7p0LZCTHUqnfSQAfEaciilp38gTYwcrwoZYbFI7RwMEM48DtDQGretI2JvSko5VWQpBngJpDu2VbO/oxL44NRZjSwdOKiFuFqDTw9W5Paqmm4z3AuouotkVa39TNK0p8pK/m1igMfP69+S4LqlCsRPS4f3XoEA7gTztZqtzyGG0Cb3e5pD75jlkmzYU7qI/dO8CDceUi/xXDY+7bvPU1l+bhW/SHuR3/sScr4TGcUXubiSUunvVK/a58SD1Xz2mu+vPqNG6RIzuOdJ+/iAQcdIBuWIHGMO6QVG11rVtRXUO0kHfYDoJCcuwf9NBE6ilkuQIoXgPN0xIZYnlwYjvS5wM/J1Vc0VQuCe5jFIszP17s9srDQVfdkB9+1lCSAvkrD8X8lOChtnS5O55odB3+sa8edxDhFoV3b/x8q/XUr7Y=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(36092001)(46966005)(186003)(6916009)(2906002)(5660300002)(2616005)(82310400003)(107886003)(356005)(7636003)(70206006)(86362001)(70586007)(336012)(8676002)(36756003)(1076003)(82740400003)(26005)(6666004)(8936002)(83380400001)(478600001)(4326008)(426003)(36906005)(316002)(47076004)(54906003)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 13:26:11.3099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d42d7b7f-9dd2-4176-f04c-08d896c5d5e2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT005.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR07MB2709
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=999
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=1 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020081
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
index bfb57ded9664..5371da7abb27 100644
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

