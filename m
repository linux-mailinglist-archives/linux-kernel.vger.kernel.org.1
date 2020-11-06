Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9B2A95A5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgKFLpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:45:51 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:45614 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726832AbgKFLpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:45:14 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6BfTHO006045;
        Fri, 6 Nov 2020 03:44:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=kWG6z7ogMBqie/wkFxoIx/y3TjcdxEjYEqfYEupsgcQ=;
 b=bIgHrpe2dUDHF/JiJGCqw3c+JAc7fvUI4YxnPKxy0eARvA/57UQXbz7YWXwnT3bgEcbB
 GVAq3Yg+KUS/Pp3yL9JiwkbGgLE2JeB9yf8aeW565h0hzT3W5O26uKaiLbbBPWptjawZ
 aRdLG25kJCsIWPvXmi/agzPDUNgia2Q9pwwE9iI/ubvvhMP5/biKoLNq+iXUGCmFAL+x
 E4b8PZXefJfGjUWq31Hgd0vUABdoNast81/ZSGmEQUBPsHfXCzJMcaaX19vEXotZs3oO
 Kwu5fosbLQ42M+cnF8vTpd8xww6J1YoY/Lg8L+QTqDvAaeXS7aO6dyY4NkFuhOuW6RuF lQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34h3gxac8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 03:44:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KORCuY7k80OYjKL+uBGCSdNEu2W9/g+VoppLAoeQQ+CFlFAPjs9WD5JjwzwmLyZqf/Mc0XfM5UXt5f5Ybf73IMsJqITz2uqgjJSQfU4tnm0jlhjuSYrVoxQsaYyjcDKknm8X6U92KasbbqbUDPhnTLypDYyIIVEYcpiIHyaAg79F+DzRoAWzJBBjK2ADbZzKkWfxticnLNYTkvpvWI+6jmwdg0Fv44h8EVoYO+43Ijk4o5ic6NDh7o2mA91j6vPbHf0Q3w0cTI/yziH/ihtOcJTfIbrdgXyB/8FqdCmEA8W8C0ppOtCKIES0zGHdt4d1EPzqNhgZjGOrIkxDAuRWfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWG6z7ogMBqie/wkFxoIx/y3TjcdxEjYEqfYEupsgcQ=;
 b=WnB2XIXEgVH77xUXC4AphN9ujfBEMRAJjg1D2IXy9RlyHTTlcn5XW+eTdqiw0CtRZspVLq0Q3gf9O6kK8xlNr/FJRrad/1/6QQrHBdOYtUQOsvX8bX9QTV5q7xzsbURgmZApXOeCjSSAu/iXTiljiI9kRvU3MU1+1FRukuB3HntmYuRyidULsc6s8ssNoThVCLs6cdUciqVG6Iuvv5O5k49eVYSMWjyFXB6rM9mdy2nTLB858xyyfWM6Y+h1IfLVWR6UqvB9I499qQESjRGkhruoE+B62uXacSUS0sqpjaNCm5DteoPzHzAUragkXvBKKfLsphS6bzSCjfus93oxCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kWG6z7ogMBqie/wkFxoIx/y3TjcdxEjYEqfYEupsgcQ=;
 b=a3A9LfYnPSQeJ1ZR32Ia/qV9lmxkf+HQkLak7D5HBC8fD5jBpRvCaJ5U+jXnzzhDVhka2vCqauauA7w/3HUX5KGG9tvczi/J5OuJTtzhNRWBbtn43eMTIEDAI0zOjxzopIqoyLH5BVTPViFljlO3M3c5ZaDehiLLxYvK/baMFns=
Received: from BN6PR14CA0040.namprd14.prod.outlook.com (2603:10b6:404:13f::26)
 by MN2PR07MB5949.namprd07.prod.outlook.com (2603:10b6:208:af::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 11:44:19 +0000
Received: from BN8NAM12FT031.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::22) by BN6PR14CA0040.outlook.office365.com
 (2603:10b6:404:13f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.22 via Frontend
 Transport; Fri, 6 Nov 2020 11:44:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT031.mail.protection.outlook.com (10.13.183.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 11:44:18 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0A6BiFAl094912
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 03:44:16 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 6 Nov 2020 12:44:14 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 6 Nov 2020 12:44:14 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0A6BiErw001563;
        Fri, 6 Nov 2020 12:44:14 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0A6BiE5d001562;
        Fri, 6 Nov 2020 12:44:14 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 01/10] usb: cdns3: Add support for DRD CDNSP
Date:   Fri, 6 Nov 2020 12:42:51 +0100
Message-ID: <20201106114300.1245-2-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201106114300.1245-1-pawell@cadence.com>
References: <20201106114300.1245-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d73965ac-328d-4c51-4fd3-08d882494b83
X-MS-TrafficTypeDiagnostic: MN2PR07MB5949:
X-Microsoft-Antispam-PRVS: <MN2PR07MB5949E1A835668680C7DEF6A8DDED0@MN2PR07MB5949.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T6drwzizm8xYoI8xuCi51iviMC6soIuPjr1CKMMDdAQ4ceH7y5pUkXtisw9Ph/Y2KYrPz/lw9hyWyeU9jrEmNX+LenHyrE400A0Xqxu7u2xZJvog26xSaV9w3O3Hab8DHJ0WSyhOGej+xfG5ihztwvCU+jMOQIqf8LiWZPTLNNSa5mhbGziLw5z6gtK9e1vpKZ1wS5EXDvfj/y5UOlccWU4eqiC2VfEgpjXR77Obc12j0rXszhj5goL4y2Bzd4hcgqFOUkkCoPKmV0jmG9cfvJRIpKOrxpi0gLWeD6frZq45WhVMYVenYVvDkdKmGgnROn1G7MOq76GWnH4aNwCsdRw8dlGqTc7LClv2lZ4UVX95sBobTGuLlbxJLtqQ/Tk7svs6m3HVam3UmxUpI0AXmo0h4gVngA+42nfoZ1y7V2g=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36092001)(46966005)(8936002)(8676002)(86362001)(2906002)(82310400003)(5660300002)(47076004)(82740400003)(6916009)(83380400001)(478600001)(81166007)(42186006)(54906003)(30864003)(70586007)(316002)(70206006)(6666004)(356005)(36906005)(186003)(336012)(36756003)(4326008)(2616005)(1076003)(426003)(107886003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 11:44:18.2556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d73965ac-328d-4c51-4fd3-08d882494b83
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT031.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5949
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_04:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=1 mlxlogscore=977 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060086
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
 drivers/usb/cdns3/core.c |  24 +++++++---
 drivers/usb/cdns3/core.h |   5 ++
 drivers/usb/cdns3/drd.c  | 101 +++++++++++++++++++++++++++------------
 drivers/usb/cdns3/drd.h  |  67 +++++++++++++++++++++-----
 4 files changed, 148 insertions(+), 49 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index f2dedce3a40e..58a3cb0e2a5d 100644
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
index 8a40d53d5ede..3af8eb7ca844 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -53,7 +53,9 @@ struct cdns3_platform_data {
  * @otg_res: the resource for otg
  * @otg_v0_regs: pointer to base of v0 otg registers
  * @otg_v1_regs: pointer to base of v1 otg registers
+ * @otg_cdnsp_regs: pointer to base of CDNSP otg registers
  * @otg_regs: pointer to base of otg registers
+ * @otg_irq_regs: pointer to interrupt registers
  * @otg_irq: irq number for otg controller
  * @dev_irq: irq number for device controller
  * @wakeup_irq: irq number for wakeup event, it is optional
@@ -83,9 +85,12 @@ struct cdns3 {
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
 	bool				phyrst_a_enable;
 
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 38ccd29e4cde..95863d44e3e0 100644
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
@@ -28,8 +27,9 @@
  *
  * Returns 0 on success otherwise negative errno
  */
-int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
+static int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
 {
+	u32 __iomem *override_reg;
 	u32 reg;
 
 	switch (mode) {
@@ -39,11 +39,24 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
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
+		else
+			reg |= OVERRIDE_IDPULLUP_V0;
 
+		writel(reg, override_reg);
+
+		if (cdns->version == CDNS3_CONTROLLER_V1) {
 			/*
 			 * Enable work around feature built into the
 			 * controller to address issue with RX Sensitivity
@@ -55,10 +68,6 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
 				reg |= PHYRST_CFG_PHYRST_A_ENABLE;
 				writel(reg, &cdns->otg_v1_regs->phyrst_cfg);
 			}
-		} else {
-			reg = readl(&cdns->otg_v0_regs->ctrl1);
-			reg |= OVERRIDE_IDPULLUP_V0;
-			writel(reg, &cdns->otg_v0_regs->ctrl1);
 		}
 
 		/*
@@ -123,7 +132,7 @@ bool cdns3_is_device(struct cdns3 *cdns)
  */
 static void cdns3_otg_disable_irq(struct cdns3 *cdns)
 {
-	writel(0, &cdns->otg_regs->ien);
+	writel(0, &cdns->otg_irq_regs->ien);
 }
 
 /**
@@ -133,7 +142,7 @@ static void cdns3_otg_disable_irq(struct cdns3 *cdns)
 static void cdns3_otg_enable_irq(struct cdns3 *cdns)
 {
 	writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
-	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_regs->ien);
+	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_irq_regs->ien);
 }
 
 /**
@@ -144,16 +153,21 @@ static void cdns3_otg_enable_irq(struct cdns3 *cdns)
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
@@ -189,17 +203,22 @@ void cdns3_drd_host_off(struct cdns3 *cdns)
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
@@ -244,7 +263,7 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
 
 	cdns3_otg_disable_irq(cdns);
 	/* clear all interrupts */
-	writel(~0, &cdns->otg_regs->ivect);
+	writel(~0, &cdns->otg_irq_regs->ivect);
 
 	ret = cdns3_set_mode(cdns, USB_DR_MODE_OTG);
 	if (ret)
@@ -313,7 +332,7 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 	if (cdns->in_lpm)
 		return ret;
 
-	reg = readl(&cdns->otg_regs->ivect);
+	reg = readl(&cdns->otg_irq_regs->ivect);
 
 	if (!reg)
 		return IRQ_NONE;
@@ -332,7 +351,7 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 		ret = IRQ_WAKE_THREAD;
 	}
 
-	writel(~0, &cdns->otg_regs->ivect);
+	writel(~0, &cdns->otg_irq_regs->ivect);
 	return ret;
 }
 
@@ -347,28 +366,43 @@ int cdns3_drd_init(struct cdns3 *cdns)
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
@@ -378,10 +412,17 @@ int cdns3_drd_init(struct cdns3 *cdns)
 
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
index f1ccae285a16..ac60fa5633c5 100644
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
 
 /* PHYRST_CFG - bitmasks */
 #define PHYRST_CFG_PHYRST_A_ENABLE     BIT(0)
@@ -170,6 +214,5 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns);
 void cdns3_drd_gadget_off(struct cdns3 *cdns);
 int cdns3_drd_host_on(struct cdns3 *cdns);
 void cdns3_drd_host_off(struct cdns3 *cdns);
-int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode);
 
 #endif /* __LINUX_CDNS3_DRD */
-- 
2.17.1

