Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE9027ADE4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgI1MeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:34:07 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:45974 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726613AbgI1Md6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:33:58 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SCUDl2012178;
        Mon, 28 Sep 2020 05:33:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=gNwHVriDXoUqW3zUv3U2/729I/2cBDbp/EnUHgsN5ik=;
 b=BtVrckA2h5WEWrYK7XH0t0VnMyCFu8UL13Bb1kSjuLmsw/sDchtmQhfaUxxVIW/C+qrm
 ds1ZFA2rhgPshVVOsfkxqxorGEZzHsm0reTtGAOkY53x1VWM+V/v863meOSQuzUuF3C3
 TIUQARG4xyc27SRcgMpODTfkv+/k/2HyntLrmIOI+6LwRToeRvTgYYj6K+x88Sk3wJwZ
 U39vhQbbO0XDKcqRt0sk4Is5XrqjxM75dhHyjUyYN60V66UQ0q3n0frYFvvH5BqaUmB8
 CfvABeIIWtmVhbet93SuPbrIGOkGiJaH5JEtoV+O/HLGS48/KTn6+0BuaXo/268a8zve 2Q== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17wwcuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5vkUyA33uw0CpB4UOZhaWwwhfaXbCmWCeHdvhGQD6mQv+ID5b9FdZSSC3u4Pm803oXntzJACRAyaFVyRCfS3U5WhRjNLdRlOZ0slYcxLSgQccztvW7YT6yYTgt3oqApOoGHuIxzZO0rjGP+V3kasv4cFt1VC/GUIHmG9TlBX6tQzOSGK1WwR8R6SEUKVTx+93BSb0AUiu/Odcd02HXFnyTZj7WIwcDbYexaiz2mBJr31uVrXzQc+qmgOl8J8ZUVZWAI14IKn6Ae5RpdhFWSLnpzBLun/fkUuI6LyRf5GkgnZj0cnvex1V9CIEep1Se7ViyeTYDnj8JVrid4K+9CCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNwHVriDXoUqW3zUv3U2/729I/2cBDbp/EnUHgsN5ik=;
 b=h0cHnadqngXNsNjHybPjS2OG1cOwSQ9T8XuHtUkmtF6uUxS3mlOsTyYx3/GxMhsQgA9hWCxzah4sAHlKRvd0525LnJC5tptrVMWGETGBZurn08KxqwSMRESDQQR7MxJaKftBRsrn+QZtesiEI+3XfcKxKAQTtHXyxo6cPMjvMut9jGhdfXkG5FM1tonGdcLPyYxQJq2Gs6m5FSfP4KOJ1BMaloIpJSqBeF0OisYA1VUPvDmxYFtKprKYYjnMvAo284Bry2GQNtStEYUWLOxPkDsAVyjbP6DgE9YzqLViDQ7A39KxIgFPWLOb24HDnx8EQ77jmG0nyelQFfkgg7IK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=temperror action=none header.from=cadence.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNwHVriDXoUqW3zUv3U2/729I/2cBDbp/EnUHgsN5ik=;
 b=fy0z2MYrE3u/MdCdq828p3JRafUSGLT5Fnipg+TS0X0xFU2H6pn1/A09AhhP4rpIJBZ9y8ukFHFThOQA+fIfgyM7gyjALcU3dICHCUvolqmO1EsELAKYs2yCUBK7xWb4uMcMPhRnVyY1ttDIpQHVaaAm2AeTlx1+YqnX8xpnXQA=
Received: from DM5PR21CA0066.namprd21.prod.outlook.com (2603:10b6:3:129::28)
 by BYAPR07MB5701.namprd07.prod.outlook.com (2603:10b6:a03:9f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Mon, 28 Sep
 2020 12:33:31 +0000
Received: from DM6NAM12FT049.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::b4) by DM5PR21CA0066.outlook.office365.com
 (2603:10b6:3:129::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.6 via Frontend
 Transport; Mon, 28 Sep 2020 12:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=temperror action=none
 header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT049.mail.protection.outlook.com (10.13.178.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Mon, 28 Sep 2020 12:33:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXQCU030864
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 28 Sep 2020 08:33:27 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXPHa019062;
        Mon, 28 Sep 2020 14:33:25 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08SCXPxG019061;
        Mon, 28 Sep 2020 14:33:25 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>
CC:     <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <sparmar@cadence.com>,
        <pawell@cadence.com>, <nsekhar@ti.com>,
        <heikki.krogerus@linux.intel.com>, <chunfeng.yun@mediatek.com>,
        <yanaijie@huawei.com>
Subject: [PATCH 1/8] usb: cdns3: Add support for DRD CDNSP
Date:   Mon, 28 Sep 2020 14:27:34 +0200
Message-ID: <20200928122741.17884-2-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200928122741.17884-1-pawell@cadence.com>
References: <20200928122741.17884-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69b87b8d-2b7e-466b-13a9-08d863aab4c4
X-MS-TrafficTypeDiagnostic: BYAPR07MB5701:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5701734ADE83902B30ED8464DD350@BYAPR07MB5701.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3maMpvY+MqYh+cjYNrEESINjuLfhkgkmpV2MLdHJt3pnKR0rZPyDDVlFcia+kgghWrOY8TeIBia1dG1VkESv/FjEUwfeTvWuuCYLAbH4y6zGTl0Wjli5H0J8rdBboh0OTsceeXYd/AjsLMZE5puiwRaXXR5GGIVJ9YzYTUIMJ9CndJ5GgkItTSYRPDH3/XXqio1I7aGBAd6bLULagu39pAR859jze77emA7IJfCPJpKF3biMYWWZ5z8f9iuhvDDnz9IYAYQJXBuZyxbwEVKkQnL5OMFLEz8tOqsl0rurHUhoi6rDrwzgFK8j3PcoQRKUZcqO3DcQFOk47p3kwm2hexixChTTMXCrUq4sesvMukutwbxvz6umUdVHLNKnSfd+yuSF6h+gVSfVNLslsxHmD0N9mm7w2Q40sT9BVC5jpMBgmjpMarYxC7Vge4eZiIH0o1Nb+L6hHKDxxHhJVSjTIyzaKrqpj6PntL02p3ymOM=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36092001)(46966005)(26005)(1076003)(356005)(81166007)(336012)(478600001)(30864003)(426003)(186003)(5660300002)(82740400003)(63350400001)(63370400001)(36756003)(70586007)(82310400003)(2616005)(83380400001)(47076004)(70206006)(7416002)(2906002)(4326008)(316002)(42186006)(110136005)(54906003)(36906005)(86362001)(8936002)(8676002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 12:33:30.0214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b87b8d-2b7e-466b-13a9-08d863aab4c4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT049.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5701
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=834 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009280102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds support for Cadence DRD Super Speed Plus controller(CDNSP).
CDNSP DRD is a part of Cadence CDNSP controller.
The DRD CDNSP controller has a lot of difference on hardware level but on
software level is quite compatible with CDNS3 DRD. For this reason
CDNS3 DRD part of CDNS3 driver was reused for CDNSP driver.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c | 24 +++++++---
 drivers/usb/cdns3/core.h |  5 ++
 drivers/usb/cdns3/drd.c  | 99 ++++++++++++++++++++++++++++------------
 drivers/usb/cdns3/drd.h  | 67 ++++++++++++++++++++++-----
 4 files changed, 146 insertions(+), 49 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 5c1586ec7824..371128e9a4ae 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -97,13 +97,23 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	 * can be restricted later depending on strap pin configuration.
 	 */
 	if (dr_mode == USB_DR_MODE_UNKNOWN) {
-		if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
-		    IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
-			dr_mode = USB_DR_MODE_OTG;
-		else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
-			dr_mode = USB_DR_MODE_HOST;
-		else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
-			dr_mode = USB_DR_MODE_PERIPHERAL;
+		if (cdns->version == CDNSP_CONTROLLER_V2) {
+			if (IS_ENABLED(CONFIG_USB_CDNSP_HOST) &&
+			    IS_ENABLED(CONFIG_USB_CDNSP_GADGET))
+				dr_mode = USB_DR_MODE_OTG;
+			else if (IS_ENABLED(CONFIG_USB_CDNSP_HOST))
+				dr_mode = USB_DR_MODE_HOST;
+			else if (IS_ENABLED(CONFIG_USB_CDNSP_GADGET))
+				dr_mode = USB_DR_MODE_PERIPHERAL;
+		} else {
+			if (IS_ENABLED(CONFIG_USB_CDNS3_HOST) &&
+			    IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
+				dr_mode = USB_DR_MODE_OTG;
+			else if (IS_ENABLED(CONFIG_USB_CDNS3_HOST))
+				dr_mode = USB_DR_MODE_HOST;
+			else if (IS_ENABLED(CONFIG_USB_CDNS3_GADGET))
+				dr_mode = USB_DR_MODE_PERIPHERAL;
+		}
 	}
 
 	/*
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 1ad1f1fe61e9..c09fdde3ae8f 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -47,7 +47,9 @@ struct cdns3_role_driver {
  * @otg_res: the resource for otg
  * @otg_v0_regs: pointer to base of v0 otg registers
  * @otg_v1_regs: pointer to base of v1 otg registers
+ * @otg_cdnsp_regs: pointer to base of CDNSP otg registers
  * @otg_regs: pointer to base of otg registers
+ * @otg_irq_regs: pointer to interrupt registers
  * @otg_irq: irq number for otg controller
  * @dev_irq: irq number for device controller
  * @roles: array of supported roles for this controller
@@ -72,9 +74,12 @@ struct cdns3 {
 	struct resource			otg_res;
 	struct cdns3_otg_legacy_regs	*otg_v0_regs;
 	struct cdns3_otg_regs		*otg_v1_regs;
+	struct cdnsp_otg_regs		*otg_cdnsp_regs;
 	struct cdns3_otg_common_regs	*otg_regs;
+	struct cdns3_otg_irq_regs	*otg_irq_regs;
 #define CDNS3_CONTROLLER_V0	0
 #define CDNS3_CONTROLLER_V1	1
+#define CDNSP_CONTROLLER_V2	2
 	u32				version;
 
 	int				otg_irq;
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 6234bcd6158a..2d78ad7e3e78 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -2,13 +2,12 @@
 /*
  * Cadence USBSS DRD Driver.
  *
- * Copyright (C) 2018-2019 Cadence.
+ * Copyright (C) 2018-2020 Cadence.
  * Copyright (C) 2019 Texas Instruments
  *
  * Author: Pawel Laszczak <pawell@cadence.com>
  *         Roger Quadros <rogerq@ti.com>
  *
- *
  */
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
@@ -27,8 +26,9 @@
  *
  * Returns 0 on success otherwise negative errno
  */
-int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
+static int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
 {
+	u32 __iomem *override_reg;
 	u32 reg;
 
 	switch (mode) {
@@ -38,15 +38,22 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
 		break;
 	case USB_DR_MODE_OTG:
 		dev_dbg(cdns->dev, "Set controller to OTG mode\n");
-		if (cdns->version == CDNS3_CONTROLLER_V1) {
-			reg = readl(&cdns->otg_v1_regs->override);
+
+		if (cdns->version == CDNSP_CONTROLLER_V2)
+			override_reg = &cdns->otg_cdnsp_regs->override;
+		else if (cdns->version == CDNS3_CONTROLLER_V1)
+			override_reg = &cdns->otg_v1_regs->override;
+		else
+			override_reg = &cdns->otg_v0_regs->ctrl1;
+
+		reg = readl(override_reg);
+
+		if (cdns->version != CDNS3_CONTROLLER_V0)
 			reg |= OVERRIDE_IDPULLUP;
-			writel(reg, &cdns->otg_v1_regs->override);
-		} else {
-			reg = readl(&cdns->otg_v0_regs->ctrl1);
+		else
 			reg |= OVERRIDE_IDPULLUP_V0;
-			writel(reg, &cdns->otg_v0_regs->ctrl1);
-		}
+
+		writel(reg, override_reg);
 
 		/*
 		 * Hardware specification says: "ID_VALUE must be valid within
@@ -110,7 +117,7 @@ bool cdns3_is_device(struct cdns3 *cdns)
  */
 static void cdns3_otg_disable_irq(struct cdns3 *cdns)
 {
-	writel(0, &cdns->otg_regs->ien);
+	writel(0, &cdns->otg_irq_regs->ien);
 }
 
 /**
@@ -120,7 +127,7 @@ static void cdns3_otg_disable_irq(struct cdns3 *cdns)
 static void cdns3_otg_enable_irq(struct cdns3 *cdns)
 {
 	writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
-	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_regs->ien);
+	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_irq_regs->ien);
 }
 
 /**
@@ -131,16 +138,21 @@ static void cdns3_otg_enable_irq(struct cdns3 *cdns)
  */
 int cdns3_drd_host_on(struct cdns3 *cdns)
 {
-	u32 val;
+	u32 val, ready_bit;
 	int ret;
 
 	/* Enable host mode. */
 	writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
 	       &cdns->otg_regs->cmd);
 
+	if (cdns->version == CDNSP_CONTROLLER_V2)
+		ready_bit = OTGSTS_CDNSP_XHCI_READY;
+	else
+		ready_bit = OTGSTS_CDNS3_XHCI_READY;
+
 	dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
 	ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
-					val & OTGSTS_XHCI_READY, 1, 100000);
+					val & ready_bit, 1, 100000);
 
 	if (ret)
 		dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
@@ -174,17 +186,22 @@ void cdns3_drd_host_off(struct cdns3 *cdns)
  */
 int cdns3_drd_gadget_on(struct cdns3 *cdns)
 {
-	int ret, val;
 	u32 reg = OTGCMD_OTG_DIS;
+	u32 ready_bit;
+	int ret, val;
 
 	/* switch OTG core */
 	writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
 
 	dev_dbg(cdns->dev, "Waiting till Device mode is turned on\n");
 
+	if (cdns->version == CDNSP_CONTROLLER_V2)
+		ready_bit = OTGSTS_CDNSP_DEV_READY;
+	else
+		ready_bit = OTGSTS_CDNS3_DEV_READY;
+
 	ret = readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
-					val & OTGSTS_DEV_READY,
-					1, 100000);
+					val & ready_bit, 1, 100000);
 	if (ret) {
 		dev_err(cdns->dev, "timeout waiting for dev_ready\n");
 		return ret;
@@ -227,7 +244,7 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
 
 	cdns3_otg_disable_irq(cdns);
 	/* clear all interrupts */
-	writel(~0, &cdns->otg_regs->ivect);
+	writel(~0, &cdns->otg_irq_regs->ivect);
 
 	ret = cdns3_set_mode(cdns, USB_DR_MODE_OTG);
 	if (ret)
@@ -293,7 +310,7 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 	if (cdns->dr_mode != USB_DR_MODE_OTG)
 		return IRQ_NONE;
 
-	reg = readl(&cdns->otg_regs->ivect);
+	reg = readl(&cdns->otg_irq_regs->ivect);
 
 	if (!reg)
 		return IRQ_NONE;
@@ -312,7 +329,7 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 		ret = IRQ_WAKE_THREAD;
 	}
 
-	writel(~0, &cdns->otg_regs->ivect);
+	writel(~0, &cdns->otg_irq_regs->ivect);
 	return ret;
 }
 
@@ -327,28 +344,43 @@ int cdns3_drd_init(struct cdns3 *cdns)
 		return PTR_ERR(regs);
 
 	/* Detection of DRD version. Controller has been released
-	 * in two versions. Both are similar, but they have same changes
-	 * in register maps.
-	 * The first register in old version is command register and it's read
-	 * only, so driver should read 0 from it. On the other hand, in v1
-	 * the first register contains device ID number which is not set to 0.
-	 * Driver uses this fact to detect the proper version of
+	 * in three versions. All are very similar and are software compatible,
+	 * but they have same changes in register maps.
+	 * The first register in oldest version is command register and it's
+	 * read only. Driver should read 0 from it. On the other hand, in v1
+	 * and v2 the first register contains device ID number which is not
+	 * set to 0. Driver uses this fact to detect the proper version of
 	 * controller.
 	 */
 	cdns->otg_v0_regs = regs;
 	if (!readl(&cdns->otg_v0_regs->cmd)) {
 		cdns->version  = CDNS3_CONTROLLER_V0;
 		cdns->otg_v1_regs = NULL;
+		cdns->otg_cdnsp_regs = NULL;
 		cdns->otg_regs = regs;
+		cdns->otg_irq_regs = (struct cdns3_otg_irq_regs *)
+				     &cdns->otg_v0_regs->ien;
 		writel(1, &cdns->otg_v0_regs->simulate);
 		dev_dbg(cdns->dev, "DRD version v0 (%08x)\n",
 			 readl(&cdns->otg_v0_regs->version));
 	} else {
 		cdns->otg_v0_regs = NULL;
 		cdns->otg_v1_regs = regs;
+		cdns->otg_cdnsp_regs = regs;
+
 		cdns->otg_regs = (void *)&cdns->otg_v1_regs->cmd;
-		cdns->version  = CDNS3_CONTROLLER_V1;
-		writel(1, &cdns->otg_v1_regs->simulate);
+
+		if (cdns->otg_cdnsp_regs->did == OTG_CDNSP_DID) {
+			cdns->otg_irq_regs = (struct cdns3_otg_irq_regs *)
+					      &cdns->otg_cdnsp_regs->ien;
+			cdns->version  = CDNSP_CONTROLLER_V2;
+		} else {
+			cdns->otg_irq_regs = (struct cdns3_otg_irq_regs *)
+					      &cdns->otg_v1_regs->ien;
+			writel(1, &cdns->otg_v1_regs->simulate);
+			cdns->version  = CDNS3_CONTROLLER_V1;
+		}
+
 		dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
 			 readl(&cdns->otg_v1_regs->did),
 			 readl(&cdns->otg_v1_regs->rid));
@@ -358,10 +390,17 @@ int cdns3_drd_init(struct cdns3 *cdns)
 
 	/* Update dr_mode according to STRAP configuration. */
 	cdns->dr_mode = USB_DR_MODE_OTG;
-	if (state == OTGSTS_STRAP_HOST) {
+
+	if ((cdns->version == CDNSP_CONTROLLER_V2 &&
+	     state == OTGSTS_CDNSP_STRAP_HOST) ||
+	    (cdns->version != CDNSP_CONTROLLER_V2 &&
+	     state == OTGSTS_STRAP_HOST)) {
 		dev_dbg(cdns->dev, "Controller strapped to HOST\n");
 		cdns->dr_mode = USB_DR_MODE_HOST;
-	} else if (state == OTGSTS_STRAP_GADGET) {
+	} else if ((cdns->version == CDNSP_CONTROLLER_V2 &&
+		    state == OTGSTS_CDNSP_STRAP_GADGET) ||
+		   (cdns->version != CDNSP_CONTROLLER_V2 &&
+		    state == OTGSTS_STRAP_GADGET)) {
 		dev_dbg(cdns->dev, "Controller strapped to PERIPHERAL\n");
 		cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
 	}
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index 7e7cf7fa2dd3..b8379c36194b 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -1,8 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * Cadence USB3 DRD header file.
+ * Cadence USB3 and USBSSP DRD header file.
  *
- * Copyright (C) 2018-2019 Cadence.
+ * Copyright (C) 2018-2020 Cadence.
  *
  * Author: Pawel Laszczak <pawell@cadence.com>
  */
@@ -13,7 +13,7 @@
 #include <linux/phy/phy.h>
 #include "core.h"
 
-/*  DRD register interface for version v1. */
+/*  DRD register interface for version v1 of cdns3 driver. */
 struct cdns3_otg_regs {
 	__le32 did;
 	__le32 rid;
@@ -38,7 +38,7 @@ struct cdns3_otg_regs {
 	__le32 ctrl2;
 };
 
-/*  DRD register interface for version v0. */
+/*  DRD register interface for version v0 of cdns3 driver. */
 struct cdns3_otg_legacy_regs {
 	__le32 cmd;
 	__le32 sts;
@@ -57,14 +57,45 @@ struct cdns3_otg_legacy_regs {
 	__le32 ctrl1;
 };
 
+/* DRD register interface for cdnsp driver */
+struct cdnsp_otg_regs {
+	__le32 did;
+	__le32 rid;
+	__le32 cfgs1;
+	__le32 cfgs2;
+	__le32 cmd;
+	__le32 sts;
+	__le32 state;
+	__le32 ien;
+	__le32 ivect;
+	__le32 tmr;
+	__le32 simulate;
+	__le32 adpbc_sts;
+	__le32 adp_ramp_time;
+	__le32 adpbc_ctrl1;
+	__le32 adpbc_ctrl2;
+	__le32 override;
+	__le32 vbusvalid_dbnc_cfg;
+	__le32 sessvalid_dbnc_cfg;
+	__le32 susp_timing_ctrl;
+};
+
+#define OTG_CDNSP_DID	0x0004034E
+
 /*
- * Common registers interface for both version of DRD.
+ * Common registers interface for both CDNS3 and CDNSP version of DRD.
  */
 struct cdns3_otg_common_regs {
 	__le32 cmd;
 	__le32 sts;
 	__le32 state;
-	__le32 different1;
+};
+
+/*
+ * Interrupt related registers. This registers are mapped in different
+ * location for CDNSP controller.
+ */
+struct cdns3_otg_irq_regs {
 	__le32 ien;
 	__le32 ivect;
 };
@@ -92,9 +123,9 @@ struct cdns3_otg_common_regs {
 #define OTGCMD_DEV_BUS_DROP		BIT(8)
 /* Drop the bus for Host mode*/
 #define OTGCMD_HOST_BUS_DROP		BIT(9)
-/* Power Down USBSS-DEV. */
+/* Power Down USBSS-DEV - only for CDNS3.*/
 #define OTGCMD_DEV_POWER_OFF		BIT(11)
-/* Power Down CDNSXHCI. */
+/* Power Down CDNSXHCI - only for CDNS3. */
 #define OTGCMD_HOST_POWER_OFF		BIT(12)
 
 /* OTGIEN - bitmasks */
@@ -123,20 +154,31 @@ struct cdns3_otg_common_regs {
 #define OTGSTS_OTG_NRDY_MASK		BIT(11)
 #define OTGSTS_OTG_NRDY(p)		((p) & OTGSTS_OTG_NRDY_MASK)
 /*
- * Value of the strap pins.
+ * Value of the strap pins for:
+ * CDN3:
  * 000 - no default configuration
  * 010 - Controller initiall configured as Host
  * 100 - Controller initially configured as Device
+ * CDNSP:
+ * 000 - No default configuration.
+ * 010 - Controller initiall configured as Host.
+ * 100 - Controller initially configured as Device.
  */
 #define OTGSTS_STRAP(p)			(((p) & GENMASK(14, 12)) >> 12)
 #define OTGSTS_STRAP_NO_DEFAULT_CFG	0x00
 #define OTGSTS_STRAP_HOST_OTG		0x01
 #define OTGSTS_STRAP_HOST		0x02
 #define OTGSTS_STRAP_GADGET		0x04
+#define OTGSTS_CDNSP_STRAP_HOST		0x01
+#define OTGSTS_CDNSP_STRAP_GADGET	0x02
+
 /* Host mode is turned on. */
-#define OTGSTS_XHCI_READY		BIT(26)
+#define OTGSTS_CDNS3_XHCI_READY		BIT(26)
+#define OTGSTS_CDNSP_XHCI_READY		BIT(27)
+
 /* "Device mode is turned on .*/
-#define OTGSTS_DEV_READY		BIT(27)
+#define OTGSTS_CDNS3_DEV_READY		BIT(27)
+#define OTGSTS_CDNSP_DEV_READY		BIT(26)
 
 /* OTGSTATE- bitmasks */
 #define OTGSTATE_DEV_STATE_MASK		GENMASK(2, 0)
@@ -152,6 +194,8 @@ struct cdns3_otg_common_regs {
 #define OVERRIDE_IDPULLUP		BIT(0)
 /* Only for CDNS3_CONTROLLER_V0 version */
 #define OVERRIDE_IDPULLUP_V0		BIT(24)
+/* Vbusvalid/Sesvalid override select. */
+#define OVERRIDE_SESS_VLD_SEL		BIT(10)
 
 #define CDNS3_ID_PERIPHERAL		1
 #define CDNS3_ID_HOST			0
@@ -167,6 +211,5 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns);
 void cdns3_drd_gadget_off(struct cdns3 *cdns);
 int cdns3_drd_host_on(struct cdns3 *cdns);
 void cdns3_drd_host_off(struct cdns3 *cdns);
-int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode);
 
 #endif /* __LINUX_CDNS3_DRD */
-- 
2.17.1

