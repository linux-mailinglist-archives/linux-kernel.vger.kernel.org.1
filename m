Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360F62A959F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgKFLp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:45:28 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59850 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbgKFLoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:44:55 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6BhNaG009751;
        Fri, 6 Nov 2020 03:44:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=F3AUeCITgADesildIQmpAMJTHFP+pMDDpR4AGLyFPZg=;
 b=YI0f3GTFCQO86OEN040NyviBKvIQAGlht9hnQbAhcAzMHY4i5GX78z8X71FGSVMZBTwR
 hLqxIs41aLZ0BK5x8Ra+QTc2cqDuvEoGmZTNJ60gkszAWgWss51jRemzpHwre2es+g4I
 qslECkuotudQ0H+LCxlrHEykUbXskZlVDeGkJWpLDup/GJ0RHbu3tyzVSW+2WSGVvPba
 5AaMv86fViko2wDrmEHQrZ4g81qyJFCHm347n9OVGKoNyCRxH+JZ4SvfNb0Ud9kjDR9b
 rEqx1qw81hSP3WeNszLNoP4zRghyhGFayp7d3etd0uTx4J2pDrHizbil+bnG4kES479X rw== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2053.outbound.protection.outlook.com [104.47.38.53])
        by mx0a-0014ca01.pphosted.com with ESMTP id 34h4fvsr8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 03:44:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Edg5bRX9vsq2fk5UQPwXxsnh+CNuZE6XZvp3iLSTV0eWYZ+o/u5T29vyL4C3FZKtOr+FG05Zk9WHM+iVoFADLM+yCd8S73zVlZy0EnlgFDvI6IT4cP3BC39y9VG4YGwWM2zHV9cPSGHk6jek38y0xLufC4bvd/mj0P0L6SlCcSnYigYP9hv0PRuxQ/9N7H099U6MF7o4jSVeNTcSl0O3JnOisQE9tQVt8WCxS0xGBuyioQkyS34ZGIrVp7RVntWwfgOlCfNmUEw3isD0kZGphvmTfMgYvmp2ArALKDbE+Q/vJp4BT2cN0jZ8hAe4ptbXc7keuS+09Rml0yZsZ4rPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3AUeCITgADesildIQmpAMJTHFP+pMDDpR4AGLyFPZg=;
 b=OfdbVkk/xeuvbOmHEu9EXNIrIOdV5CA1oNVNJ/d6oRR4yN+jYPkNx9zgCKk5ua4BmTSw/AGE1+S4YpeF+8XZlSIy2YrooE26PfptGlypFXCdKM0752ciBkgviO2aP6WXyPdMy3UyrVYFqc9K3p7vBUX0gKvEtqeF/MxB9D2XNTiZuBKH4XqLPcGhRGgIAZbYN2xF7tGSRdt6TpulifEeBhE39slUeon1a8jbACUR857aUkwKWijTf2XpVaUar4XmqzT+YqsGay33EbCHBuecn2Akk4R10dlD3kVIQtbXmgsqsf3ZhroRzD2BzvL25OX0KWa/M+L2DMPUameC72CaDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F3AUeCITgADesildIQmpAMJTHFP+pMDDpR4AGLyFPZg=;
 b=paMitC8f1ICYsT5eF9S2heJidxWxcl19WihZ4UszfoqEqOvfYt+BU721tZ7Fw9t4B3ykK8Vdh7kZ6st5lp+vJOu76f2TOBAunKmwMjmZSjeutUAlxLOQp+U0RFbAJNmEcNTFPZ2e3x8pN2OoFzUJ8wlqimzwoVliGZiynf/BT78=
Received: from BN6PR20CA0055.namprd20.prod.outlook.com (2603:10b6:404:151::17)
 by MN2PR07MB6493.namprd07.prod.outlook.com (2603:10b6:208:161::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 11:44:22 +0000
Received: from BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::e5) by BN6PR20CA0055.outlook.office365.com
 (2603:10b6:404:151::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 11:44:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT065.mail.protection.outlook.com (10.13.182.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 11:44:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0A6BiFAp094912
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 03:44:19 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 6 Nov 2020 12:44:15 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 6 Nov 2020 12:44:15 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0A6BiErj001577;
        Fri, 6 Nov 2020 12:44:14 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0A6BiENw001576;
        Fri, 6 Nov 2020 12:44:14 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 04/10] usb: cdns3: Refactoring names in reusable code
Date:   Fri, 6 Nov 2020 12:42:54 +0100
Message-ID: <20201106114300.1245-5-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201106114300.1245-1-pawell@cadence.com>
References: <20201106114300.1245-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82f5f3f6-2db1-4da6-e8d8-08d882494ce6
X-MS-TrafficTypeDiagnostic: MN2PR07MB6493:
X-Microsoft-Antispam-PRVS: <MN2PR07MB64939E6978B140109F92870FDDED0@MN2PR07MB6493.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mTPreSIJLtXMN50uMNjbHy5iRFTjQNnwXcq9NlgE2CpJE8Iz4m1d9HXRSqN+LjYzbbO4PfHUsnODKpSM7AiYdt15b3ZzdWMzs+GxnkxSAvuX3BWW/7EGiC+RaHXwdKBs6A6Yn5a1Yezrg95M6OewZ0dLZPWciZLi9dhbuQzfTLg/pDoXnKGZKI2CbV7PJ8dprbg74qdWD9UEwd0/MHxDhtdrS7Vh64VU3W8NBUWQROYoy4uafDWvAQogFff/Gii7KHxSxy9mpgxwfjxWwVjLLU96eowHKOZ8Zhp31Ge0CIpfACcJBX66GZw6H4etxan7w9ALcXuxPek0v+HzNW8sbr7kc+LkaXb5DzfdNe2kCjbbdkiza8ndBmaFz6lDds9r57pR1pj2iYmqYhROdubAFLd7iBELgIvbSeI44vZGh/c=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(36092001)(46966005)(30864003)(82740400003)(356005)(426003)(81166007)(6916009)(5660300002)(186003)(82310400003)(336012)(83380400001)(47076004)(70586007)(70206006)(2906002)(26005)(6666004)(478600001)(86362001)(107886003)(1076003)(54906003)(36906005)(8676002)(316002)(42186006)(4326008)(36756003)(2616005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 11:44:20.5860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82f5f3f6-2db1-4da6-e8d8-08d882494ce6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6493
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_03:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=534 mlxscore=0 clxscore=1015 impostorscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 suspectscore=1
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch change the functions and objects names in reusable code.
The reusable code includes core.c, core.h, drd.c and drd.h files.
It also changes the names of all references to these functions and
objects in other cdns3 files. There are a lot of changes, but all
changes are very trivial.
The reason of this patch is to avoid of mixing prefix cdns3 and cdnsp in
in cdnsp driver what could introduce some confusion in understanding
of cdnsp driver.
This patch assumes to use three different prefixes in Cadence
USB drivers:
  cdns: for common reusable code
  cdnsp: for names related only with cdnsp driver
  cdns3: for names related only with cdns3 driver

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/cdns3-imx.c     |   2 +-
 drivers/usb/cdns3/cdns3-plat.c    |  25 +++---
 drivers/usb/cdns3/core.c          | 142 +++++++++++++++---------------
 drivers/usb/cdns3/core.h          |  46 +++++-----
 drivers/usb/cdns3/drd.c           | 100 ++++++++++-----------
 drivers/usb/cdns3/drd.h           |  26 +++---
 drivers/usb/cdns3/gadget-export.h |   4 +-
 drivers/usb/cdns3/gadget.c        |  24 ++---
 drivers/usb/cdns3/host-export.h   |   6 +-
 drivers/usb/cdns3/host.c          |  22 ++---
 10 files changed, 199 insertions(+), 198 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-imx.c b/drivers/usb/cdns3/cdns3-imx.c
index 54a2d70a9c73..366e88f068ef 100644
--- a/drivers/usb/cdns3/cdns3-imx.c
+++ b/drivers/usb/cdns3/cdns3-imx.c
@@ -250,7 +250,7 @@ static void cdns3_set_wakeup(struct cdns_imx *data, bool enable)
 static int cdns_imx_platform_suspend(struct device *dev,
 		bool suspend, bool wakeup)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct cdns *cdns = dev_get_drvdata(dev);
 	struct device *parent = dev->parent;
 	struct cdns_imx *data = dev_get_drvdata(parent);
 	void __iomem *otg_regs = (void __iomem *)(cdns->otg_regs);
diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 562163c81911..99b5dae4a80c 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -20,7 +20,7 @@
 #include "core.h"
 #include "gadget-export.h"
 
-static int set_phy_power_on(struct cdns3 *cdns)
+static int set_phy_power_on(struct cdns *cdns)
 {
 	int ret;
 
@@ -35,7 +35,7 @@ static int set_phy_power_on(struct cdns3 *cdns)
 	return ret;
 }
 
-static void set_phy_power_off(struct cdns3 *cdns)
+static void set_phy_power_off(struct cdns *cdns)
 {
 	phy_power_off(cdns->usb3_phy);
 	phy_power_off(cdns->usb2_phy);
@@ -51,7 +51,7 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource	*res;
-	struct cdns3 *cdns;
+	struct cdns *cdns;
 	void __iomem *regs;
 	int ret;
 
@@ -136,7 +136,8 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 		goto err_phy_power_on;
 
 	cdns->gadget_init = cdns3_gadget_init;
-	ret = cdns3_init(cdns);
+
+	ret = cdns_init(cdns);
 	if (ret)
 		goto err_cdns_init;
 
@@ -174,13 +175,13 @@ static int cdns3_plat_probe(struct platform_device *pdev)
  */
 static int cdns3_plat_remove(struct platform_device *pdev)
 {
-	struct cdns3 *cdns = platform_get_drvdata(pdev);
+	struct cdns *cdns = platform_get_drvdata(pdev);
 	struct device *dev = cdns->dev;
 
 	pm_runtime_get_sync(dev);
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
-	cdns3_remove(cdns);
+	cdns_remove(cdns);
 	set_phy_power_off(cdns);
 	phy_exit(cdns->usb2_phy);
 	phy_exit(cdns->usb3_phy);
@@ -192,7 +193,7 @@ static int cdns3_plat_remove(struct platform_device *pdev)
 static int cdns3_set_platform_suspend(struct device *dev,
 				      bool suspend, bool wakeup)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct cdns *cdns = dev_get_drvdata(dev);
 	int ret = 0;
 
 	if (cdns->pdata && cdns->pdata->platform_suspend)
@@ -203,7 +204,7 @@ static int cdns3_set_platform_suspend(struct device *dev,
 
 static int cdns3_controller_suspend(struct device *dev, pm_message_t msg)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct cdns *cdns = dev_get_drvdata(dev);
 	bool wakeup;
 	unsigned long flags;
 
@@ -227,7 +228,7 @@ static int cdns3_controller_suspend(struct device *dev, pm_message_t msg)
 
 static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct cdns *cdns = dev_get_drvdata(dev);
 	int ret;
 	unsigned long flags;
 
@@ -241,7 +242,7 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
 	cdns3_set_platform_suspend(cdns->dev, false, false);
 
 	spin_lock_irqsave(&cdns->lock, flags);
-	cdns3_resume(cdns, !PMSG_IS_AUTO(msg));
+	cdns_resume(cdns, !PMSG_IS_AUTO(msg));
 	cdns->in_lpm = false;
 	spin_unlock_irqrestore(&cdns->lock, flags);
 	if (cdns->wakeup_pending) {
@@ -267,9 +268,9 @@ static int cdns3_plat_runtime_resume(struct device *dev)
 
 static int cdns3_plat_suspend(struct device *dev)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct cdns *cdns = dev_get_drvdata(dev);
 
-	cdns3_suspend(cdns);
+	cdns_suspend(cdns);
 
 	return cdns3_controller_suspend(dev, PMSG_AUTO_SUSPEND);
 }
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 4fedf32855af..e282f727a241 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -23,9 +23,9 @@
 #include "host-export.h"
 #include "drd.h"
 
-static int cdns3_idle_init(struct cdns3 *cdns);
+static int cdns_idle_init(struct cdns *cdns);
 
-static int cdns3_role_start(struct cdns3 *cdns, enum usb_role role)
+static int cdns_role_start(struct cdns *cdns, enum usb_role role)
 {
 	int ret;
 
@@ -39,47 +39,47 @@ static int cdns3_role_start(struct cdns3 *cdns, enum usb_role role)
 	if (!cdns->roles[role])
 		return -ENXIO;
 
-	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_ACTIVE)
+	if (cdns->roles[role]->state == CDNS_ROLE_STATE_ACTIVE)
 		return 0;
 
 	mutex_lock(&cdns->mutex);
 	ret = cdns->roles[role]->start(cdns);
 	if (!ret)
-		cdns->roles[role]->state = CDNS3_ROLE_STATE_ACTIVE;
+		cdns->roles[role]->state = CDNS_ROLE_STATE_ACTIVE;
 	mutex_unlock(&cdns->mutex);
 
 	return ret;
 }
 
-static void cdns3_role_stop(struct cdns3 *cdns)
+static void cdns_role_stop(struct cdns *cdns)
 {
 	enum usb_role role = cdns->role;
 
 	if (WARN_ON(role > USB_ROLE_DEVICE))
 		return;
 
-	if (cdns->roles[role]->state == CDNS3_ROLE_STATE_INACTIVE)
+	if (cdns->roles[role]->state == CDNS_ROLE_STATE_INACTIVE)
 		return;
 
 	mutex_lock(&cdns->mutex);
 	cdns->roles[role]->stop(cdns);
-	cdns->roles[role]->state = CDNS3_ROLE_STATE_INACTIVE;
+	cdns->roles[role]->state = CDNS_ROLE_STATE_INACTIVE;
 	mutex_unlock(&cdns->mutex);
 }
 
-static void cdns3_exit_roles(struct cdns3 *cdns)
+static void cdns_exit_roles(struct cdns *cdns)
 {
-	cdns3_role_stop(cdns);
-	cdns3_drd_exit(cdns);
+	cdns_role_stop(cdns);
+	cdns_drd_exit(cdns);
 }
 
 /**
- * cdns3_core_init_role - initialize role of operation
- * @cdns: Pointer to cdns3 structure
+ * cdns_core_init_role - initialize role of operation
+ * @cdns: Pointer to cdns structure
  *
  * Returns 0 on success otherwise negative errno
  */
-static int cdns3_core_init_role(struct cdns3 *cdns)
+static int cdns_core_init_role(struct cdns *cdns)
 {
 	struct device *dev = cdns->dev;
 	enum usb_dr_mode best_dr_mode;
@@ -120,7 +120,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	 */
 	best_dr_mode = cdns->dr_mode;
 
-	ret = cdns3_idle_init(cdns);
+	ret = cdns_idle_init(cdns);
 	if (ret)
 		return ret;
 
@@ -136,7 +136,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	dr_mode = best_dr_mode;
 
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
-		ret = cdns3_host_init(cdns);
+		ret = cdns_host_init(cdns);
 		if (ret) {
 			dev_err(dev, "Host initialization failed with %d\n",
 				ret);
@@ -159,28 +159,28 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 
 	cdns->dr_mode = dr_mode;
 
-	ret = cdns3_drd_update_mode(cdns);
+	ret = cdns_drd_update_mode(cdns);
 	if (ret)
 		goto err;
 
 	/* Initialize idle role to start with */
-	ret = cdns3_role_start(cdns, USB_ROLE_NONE);
+	ret = cdns_role_start(cdns, USB_ROLE_NONE);
 	if (ret)
 		goto err;
 
 	switch (cdns->dr_mode) {
 	case USB_DR_MODE_OTG:
-		ret = cdns3_hw_role_switch(cdns);
+		ret = cdns_hw_role_switch(cdns);
 		if (ret)
 			goto err;
 		break;
 	case USB_DR_MODE_PERIPHERAL:
-		ret = cdns3_role_start(cdns, USB_ROLE_DEVICE);
+		ret = cdns_role_start(cdns, USB_ROLE_DEVICE);
 		if (ret)
 			goto err;
 		break;
 	case USB_DR_MODE_HOST:
-		ret = cdns3_role_start(cdns, USB_ROLE_HOST);
+		ret = cdns_role_start(cdns, USB_ROLE_HOST);
 		if (ret)
 			goto err;
 		break;
@@ -191,32 +191,32 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 
 	return 0;
 err:
-	cdns3_exit_roles(cdns);
+	cdns_exit_roles(cdns);
 	return ret;
 }
 
 /**
- * cdns3_hw_role_state_machine  - role switch state machine based on hw events.
+ * cdns_hw_role_state_machine  - role switch state machine based on hw events.
  * @cdns: Pointer to controller structure.
  *
  * Returns next role to be entered based on hw events.
  */
-static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
+static enum usb_role cdns_hw_role_state_machine(struct cdns *cdns)
 {
 	enum usb_role role = USB_ROLE_NONE;
 	int id, vbus;
 
 	if (cdns->dr_mode != USB_DR_MODE_OTG) {
-		if (cdns3_is_host(cdns))
+		if (cdns_is_host(cdns))
 			role = USB_ROLE_HOST;
-		if (cdns3_is_device(cdns))
+		if (cdns_is_device(cdns))
 			role = USB_ROLE_DEVICE;
 
 		return role;
 	}
 
-	id = cdns3_get_id(cdns);
-	vbus = cdns3_get_vbus(cdns);
+	id = cdns_get_id(cdns);
+	vbus = cdns_get_vbus(cdns);
 
 	/*
 	 * Role change state machine
@@ -252,28 +252,28 @@ static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
 	return role;
 }
 
-static int cdns3_idle_role_start(struct cdns3 *cdns)
+static int cdns_idle_role_start(struct cdns *cdns)
 {
 	return 0;
 }
 
-static void cdns3_idle_role_stop(struct cdns3 *cdns)
+static void cdns_idle_role_stop(struct cdns *cdns)
 {
 	/* Program Lane swap and bring PHY out of RESET */
 	phy_reset(cdns->usb3_phy);
 }
 
-static int cdns3_idle_init(struct cdns3 *cdns)
+static int cdns_idle_init(struct cdns *cdns)
 {
-	struct cdns3_role_driver *rdrv;
+	struct cdns_role_driver *rdrv;
 
 	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
 	if (!rdrv)
 		return -ENOMEM;
 
-	rdrv->start = cdns3_idle_role_start;
-	rdrv->stop = cdns3_idle_role_stop;
-	rdrv->state = CDNS3_ROLE_STATE_INACTIVE;
+	rdrv->start = cdns_idle_role_start;
+	rdrv->stop = cdns_idle_role_stop;
+	rdrv->state = CDNS_ROLE_STATE_INACTIVE;
 	rdrv->suspend = NULL;
 	rdrv->resume = NULL;
 	rdrv->name = "idle";
@@ -284,10 +284,10 @@ static int cdns3_idle_init(struct cdns3 *cdns)
 }
 
 /**
- * cdns3_hw_role_switch - switch roles based on HW state
+ * cdns_hw_role_switch - switch roles based on HW state
  * @cdns: controller
  */
-int cdns3_hw_role_switch(struct cdns3 *cdns)
+int cdns_hw_role_switch(struct cdns *cdns)
 {
 	enum usb_role real_role, current_role;
 	int ret = 0;
@@ -299,22 +299,22 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
 	pm_runtime_get_sync(cdns->dev);
 
 	current_role = cdns->role;
-	real_role = cdns3_hw_role_state_machine(cdns);
+	real_role = cdns_hw_role_state_machine(cdns);
 
 	/* Do nothing if nothing changed */
 	if (current_role == real_role)
 		goto exit;
 
-	cdns3_role_stop(cdns);
+	cdns_role_stop(cdns);
 
 	dev_dbg(cdns->dev, "Switching role %d -> %d", current_role, real_role);
 
-	ret = cdns3_role_start(cdns, real_role);
+	ret = cdns_role_start(cdns, real_role);
 	if (ret) {
 		/* Back to current role */
 		dev_err(cdns->dev, "set %d has failed, back to %d\n",
 			real_role, current_role);
-		ret = cdns3_role_start(cdns, current_role);
+		ret = cdns_role_start(cdns, current_role);
 		if (ret)
 			dev_err(cdns->dev, "back to %d failed too\n",
 				current_role);
@@ -331,15 +331,15 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
  *
  * Returns role
  */
-static enum usb_role cdns3_role_get(struct usb_role_switch *sw)
+static enum usb_role cdns_role_get(struct usb_role_switch *sw)
 {
-	struct cdns3 *cdns = usb_role_switch_get_drvdata(sw);
+	struct cdns *cdns = usb_role_switch_get_drvdata(sw);
 
 	return cdns->role;
 }
 
 /**
- * cdns3_role_set - set current role of controller.
+ * cdns_role_set - set current role of controller.
  *
  * @sw: pointer to USB role switch structure
  * @role: the previous role
@@ -347,9 +347,9 @@ static enum usb_role cdns3_role_get(struct usb_role_switch *sw)
  * - Role switch for dual-role devices
  * - USB_ROLE_GADGET <--> USB_ROLE_NONE for peripheral-only devices
  */
-static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
+static int cdns_role_set(struct usb_role_switch *sw, enum usb_role role)
 {
-	struct cdns3 *cdns = usb_role_switch_get_drvdata(sw);
+	struct cdns *cdns = usb_role_switch_get_drvdata(sw);
 	int ret = 0;
 
 	pm_runtime_get_sync(cdns->dev);
@@ -377,8 +377,8 @@ static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
 		}
 	}
 
-	cdns3_role_stop(cdns);
-	ret = cdns3_role_start(cdns, role);
+	cdns_role_stop(cdns);
+	ret = cdns_role_start(cdns, role);
 	if (ret)
 		dev_err(cdns->dev, "set role %d has failed\n", role);
 
@@ -389,15 +389,15 @@ static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
 
 
 /**
- * cdns3_wakeup_irq - interrupt handler for wakeup events
- * @irq: irq number for cdns3 core device
- * @data: structure of cdns3
+ * cdns_wakeup_irq - interrupt handler for wakeup events
+ * @irq: irq number for cdns3/cdnsp core device
+ * @data: structure of cdns
  *
  * Returns IRQ_HANDLED or IRQ_NONE
  */
-static irqreturn_t cdns3_wakeup_irq(int irq, void *data)
+static irqreturn_t cdns_wakeup_irq(int irq, void *data)
 {
-	struct cdns3 *cdns = data;
+	struct cdns *cdns = data;
 
 	if (cdns->in_lpm) {
 		disable_irq_nosync(irq);
@@ -412,12 +412,12 @@ static irqreturn_t cdns3_wakeup_irq(int irq, void *data)
 }
 
 /**
- * cdns3_probe - probe for cdns3 core device
- * @cdns: Pointer to cdnsp structure.
+ * cdns_probe - probe for cdns3/cdnsp core device
+ * @cdns: Pointer to cdns structure.
  *
  * Returns 0 on success otherwise negative errno
  */
-int cdns3_init(struct cdns3 *cdns)
+int cdns_init(struct cdns *cdns)
 {
 	struct usb_role_switch_desc sw_desc = { };
 	struct device *dev = cdns->dev;
@@ -431,8 +431,8 @@ int cdns3_init(struct cdns3 *cdns)
 
 	mutex_init(&cdns->mutex);
 
-	sw_desc.set = cdns3_role_set;
-	sw_desc.get = cdns3_role_get;
+	sw_desc.set = cdns_role_set;
+	sw_desc.get = cdns_role_get;
 	sw_desc.allow_userspace_control = true;
 	sw_desc.driver_data = cdns;
 	if (device_property_read_bool(dev, "usb-role-switch"))
@@ -446,7 +446,7 @@ int cdns3_init(struct cdns3 *cdns)
 
 	if (cdns->wakeup_irq) {
 		ret = devm_request_irq(cdns->dev, cdns->wakeup_irq,
-						cdns3_wakeup_irq,
+						cdns_wakeup_irq,
 						IRQF_SHARED,
 						dev_name(cdns->dev), cdns);
 
@@ -456,11 +456,11 @@ int cdns3_init(struct cdns3 *cdns)
 		}
 	}
 
-	ret = cdns3_drd_init(cdns);
+	ret = cdns_drd_init(cdns);
 	if (ret)
 		goto init_failed;
 
-	ret = cdns3_core_init_role(cdns);
+	ret = cdns_core_init_role(cdns);
 	if (ret)
 		goto init_failed;
 
@@ -470,30 +470,30 @@ int cdns3_init(struct cdns3 *cdns)
 
 	return 0;
 init_failed:
-	cdns3_drd_exit(cdns);
+	cdns_drd_exit(cdns);
 	usb_role_switch_unregister(cdns->role_sw);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cdns3_init);
+EXPORT_SYMBOL_GPL(cdns_init);
 
 /**
- * cdns3_remove - unbind drd driver and clean up
- * @cdns: Pointer to cdnsp structure.
+ * cdns_remove - unbind drd driver and clean up
+ * @cdns: Pointer to cdns structure.
  *
  * Returns 0 on success otherwise negative errno
  */
-int cdns3_remove(struct cdns3 *cdns)
+int cdns_remove(struct cdns *cdns)
 {
-	cdns3_exit_roles(cdns);
+	cdns_exit_roles(cdns);
 	usb_role_switch_unregister(cdns->role_sw);
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cdns3_remove);
+EXPORT_SYMBOL_GPL(cdns_remove);
 
 #ifdef CONFIG_PM_SLEEP
-int cdns3_suspend(struct cdns3 *cdns)
+int cdns_suspend(struct cdns *cdns)
 {
 	struct device *dev = cdns->dev;
 	unsigned long flags;
@@ -509,9 +509,9 @@ int cdns3_suspend(struct cdns3 *cdns)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cdns3_suspend);
+EXPORT_SYMBOL_GPL(cdns_suspend);
 
-int cdns3_resume(struct cdns3 *cdns, u8 set_active)
+int cdns_resume(struct cdns *cdns, u8 set_active)
 {
 	struct device *dev = cdns->dev;
 
@@ -526,7 +526,7 @@ int cdns3_resume(struct cdns3 *cdns, u8 set_active)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cdns3_resume);
+EXPORT_SYMBOL_GPL(cdns_resume);
 #endif /* CONFIG_PM_SLEEP */
 
 MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 96bdab7e8357..2dc4bb1c6b6d 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -14,10 +14,10 @@
 #ifndef __LINUX_CDNS3_CORE_H
 #define __LINUX_CDNS3_CORE_H
 
-struct cdns3;
+struct cdns;
 
 /**
- * struct cdns3_role_driver - host/gadget role driver
+ * struct cdns_role_driver - host/gadget role driver
  * @start: start this role
  * @stop: stop this role
  * @suspend: suspend callback for this role
@@ -26,18 +26,18 @@ struct cdns3;
  * @name: role name string (host/gadget)
  * @state: current state
  */
-struct cdns3_role_driver {
-	int (*start)(struct cdns3 *cdns);
-	void (*stop)(struct cdns3 *cdns);
-	int (*suspend)(struct cdns3 *cdns, bool do_wakeup);
-	int (*resume)(struct cdns3 *cdns, bool hibernated);
+struct cdns_role_driver {
+	int (*start)(struct cdns *cdns);
+	void (*stop)(struct cdns *cdns);
+	int (*suspend)(struct cdns *cdns, bool do_wakeup);
+	int (*resume)(struct cdns *cdns, bool hibernated);
 	const char *name;
-#define CDNS3_ROLE_STATE_INACTIVE	0
-#define CDNS3_ROLE_STATE_ACTIVE		1
+#define CDNS_ROLE_STATE_INACTIVE	0
+#define CDNS_ROLE_STATE_ACTIVE		1
 	int state;
 };
 
-#define CDNS3_XHCI_RESOURCES_NUM	2
+#define CDNS_XHCI_RESOURCES_NUM	2
 
 struct cdns3_platform_data {
 	int (*platform_suspend)(struct device *dev,
@@ -45,7 +45,7 @@ struct cdns3_platform_data {
 };
 
 /**
- * struct cdns3 - Representation of Cadence USB3 DRD controller.
+ * struct cdns - Representation of Cadence USB3 DRD controller.
  * @dev: pointer to Cadence device struct
  * @xhci_regs: pointer to base of xhci registers
  * @xhci_res: the resource for xhci
@@ -61,7 +61,7 @@ struct cdns3_platform_data {
  * @wakeup_irq: irq number for wakeup event, it is optional
  * @roles: array of supported roles for this controller
  * @role: current role
- * @host_dev: the child host device pointer for cdns3 core
+ * @host_dev: the child host device pointer for cdns core
  * @gadget_dev: the child gadget device pointer for cdns3 core
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
@@ -77,18 +77,18 @@ struct cdns3_platform_data {
  * @lock: spinlock structure
  * @gadget_init: pointer to gadget initialization function
  */
-struct cdns3 {
+struct cdns {
 	struct device			*dev;
 	void __iomem			*xhci_regs;
-	struct resource			xhci_res[CDNS3_XHCI_RESOURCES_NUM];
+	struct resource			xhci_res[CDNS_XHCI_RESOURCES_NUM];
 	struct cdns3_usb_regs __iomem	*dev_regs;
 
 	struct resource			otg_res;
 	struct cdns3_otg_legacy_regs	*otg_v0_regs;
 	struct cdns3_otg_regs		*otg_v1_regs;
 	struct cdnsp_otg_regs		*otg_cdnsp_regs;
-	struct cdns3_otg_common_regs	*otg_regs;
-	struct cdns3_otg_irq_regs	*otg_irq_regs;
+	struct cdns_otg_common_regs	*otg_regs;
+	struct cdns_otg_irq_regs	*otg_irq_regs;
 #define CDNS3_CONTROLLER_V0	0
 #define CDNS3_CONTROLLER_V1	1
 #define CDNSP_CONTROLLER_V2	2
@@ -98,7 +98,7 @@ struct cdns3 {
 	int				otg_irq;
 	int				dev_irq;
 	int				wakeup_irq;
-	struct cdns3_role_driver	*roles[USB_ROLE_DEVICE + 1];
+	struct cdns_role_driver	*roles[USB_ROLE_DEVICE + 1];
 	enum usb_role			role;
 	struct platform_device		*host_dev;
 	struct cdns3_device		*gadget_dev;
@@ -113,15 +113,15 @@ struct cdns3 {
 	struct cdns3_platform_data	*pdata;
 	spinlock_t			lock;
 
-	int (*gadget_init)(struct cdns3 *cdns);
+	int (*gadget_init)(struct cdns *cdns);
 };
 
-int cdns3_hw_role_switch(struct cdns3 *cdns);
-extern int cdns3_init(struct cdns3 *cdns);
-extern int cdns3_remove(struct cdns3 *cdns);
+int cdns_hw_role_switch(struct cdns *cdns);
+extern int cdns_init(struct cdns *cdns);
+extern int cdns_remove(struct cdns *cdns);
 
 #ifdef CONFIG_PM_SLEEP
-extern int cdns3_resume(struct cdns3 *cdns, u8 set_active);
-extern int cdns3_suspend(struct cdns3 *cdns);
+extern int cdns_resume(struct cdns *cdns, u8 set_active);
+extern int cdns_suspend(struct cdns *cdns);
 #endif /* CONFIG_PM_SLEEP */
 #endif /* __LINUX_CDNS3_CORE_H */
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 1874dc6018f0..0fd465094101 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -19,13 +19,13 @@
 #include "core.h"
 
 /**
- * cdns3_set_mode - change mode of OTG Core
+ * cdns_set_mode - change mode of OTG Core
  * @cdns: pointer to context structure
  * @mode: selected mode from cdns_role
  *
  * Returns 0 on success otherwise negative errno
  */
-static int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
+static int cdns_set_mode(struct cdns *cdns, enum usb_dr_mode mode)
 {
 	u32 __iomem *override_reg;
 	u32 reg;
@@ -83,7 +83,7 @@ static int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
 	return 0;
 }
 
-int cdns3_get_id(struct cdns3 *cdns)
+int cdns_get_id(struct cdns *cdns)
 {
 	int id;
 
@@ -93,7 +93,7 @@ int cdns3_get_id(struct cdns3 *cdns)
 	return id;
 }
 
-int cdns3_get_vbus(struct cdns3 *cdns)
+int cdns_get_vbus(struct cdns *cdns)
 {
 	int vbus;
 
@@ -103,53 +103,53 @@ int cdns3_get_vbus(struct cdns3 *cdns)
 	return vbus;
 }
 
-bool cdns3_is_host(struct cdns3 *cdns)
+bool cdns_is_host(struct cdns *cdns)
 {
 	if (cdns->dr_mode == USB_DR_MODE_HOST)
 		return true;
-	else if (cdns3_get_id(cdns) == CDNS3_ID_HOST)
+	else if (cdns_get_id(cdns) == CDNS3_ID_HOST)
 		return true;
 
 	return false;
 }
 
-bool cdns3_is_device(struct cdns3 *cdns)
+bool cdns_is_device(struct cdns *cdns)
 {
 	if (cdns->dr_mode == USB_DR_MODE_PERIPHERAL)
 		return true;
 	else if (cdns->dr_mode == USB_DR_MODE_OTG)
-		if (cdns3_get_id(cdns) == CDNS3_ID_PERIPHERAL)
+		if (cdns_get_id(cdns) == CDNS3_ID_PERIPHERAL)
 			return true;
 
 	return false;
 }
 
 /**
- * cdns3_otg_disable_irq - Disable all OTG interrupts
+ * cdns_otg_disable_irq - Disable all OTG interrupts
  * @cdns: Pointer to controller context structure
  */
-static void cdns3_otg_disable_irq(struct cdns3 *cdns)
+static void cdns_otg_disable_irq(struct cdns *cdns)
 {
 	writel(0, &cdns->otg_irq_regs->ien);
 }
 
 /**
- * cdns3_otg_enable_irq - enable id and sess_valid interrupts
+ * cdns_otg_enable_irq - enable id and sess_valid interrupts
  * @cdns: Pointer to controller context structure
  */
-static void cdns3_otg_enable_irq(struct cdns3 *cdns)
+static void cdns_otg_enable_irq(struct cdns *cdns)
 {
 	writel(OTGIEN_ID_CHANGE_INT | OTGIEN_VBUSVALID_RISE_INT |
 	       OTGIEN_VBUSVALID_FALL_INT, &cdns->otg_irq_regs->ien);
 }
 
 /**
- * cdns3_drd_host_on - start host.
+ * cdns_drd_host_on - start host.
  * @cdns: Pointer to controller context structure.
  *
  * Returns 0 on success otherwise negative errno.
  */
-int cdns3_drd_host_on(struct cdns3 *cdns)
+int cdns_drd_host_on(struct cdns *cdns)
 {
 	u32 val, ready_bit;
 	int ret;
@@ -175,10 +175,10 @@ int cdns3_drd_host_on(struct cdns3 *cdns)
 }
 
 /**
- * cdns3_drd_host_off - stop host.
+ * cdns_drd_host_off - stop host.
  * @cdns: Pointer to controller context structure.
  */
-void cdns3_drd_host_off(struct cdns3 *cdns)
+void cdns_drd_host_off(struct cdns *cdns)
 {
 	u32 val;
 
@@ -194,12 +194,12 @@ void cdns3_drd_host_off(struct cdns3 *cdns)
 }
 
 /**
- * cdns3_drd_gadget_on - start gadget.
+ * cdns_drd_gadget_on - start gadget.
  * @cdns: Pointer to controller context structure.
  *
  * Returns 0 on success otherwise negative errno
  */
-int cdns3_drd_gadget_on(struct cdns3 *cdns)
+int cdns_drd_gadget_on(struct cdns *cdns)
 {
 	u32 reg = OTGCMD_OTG_DIS;
 	u32 ready_bit;
@@ -225,13 +225,13 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns)
 	phy_set_mode(cdns->usb3_phy, PHY_MODE_USB_DEVICE);
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cdns3_drd_gadget_on);
+EXPORT_SYMBOL_GPL(cdns_drd_gadget_on);
 
 /**
- * cdns3_drd_gadget_off - stop gadget.
+ * cdns_drd_gadget_off - stop gadget.
  * @cdns: Pointer to controller context structure.
  */
-void cdns3_drd_gadget_off(struct cdns3 *cdns)
+void cdns_drd_gadget_off(struct cdns *cdns)
 {
 	u32 val;
 
@@ -249,50 +249,50 @@ void cdns3_drd_gadget_off(struct cdns3 *cdns)
 				  1, 2000000);
 	phy_set_mode(cdns->usb3_phy, PHY_MODE_INVALID);
 }
-EXPORT_SYMBOL_GPL(cdns3_drd_gadget_off);
+EXPORT_SYMBOL_GPL(cdns_drd_gadget_off);
 
 /**
- * cdns3_init_otg_mode - initialize drd controller
+ * cdns_init_otg_mode - initialize drd controller
  * @cdns: Pointer to controller context structure
  *
  * Returns 0 on success otherwise negative errno
  */
-static int cdns3_init_otg_mode(struct cdns3 *cdns)
+static int cdns_init_otg_mode(struct cdns *cdns)
 {
 	int ret;
 
-	cdns3_otg_disable_irq(cdns);
+	cdns_otg_disable_irq(cdns);
 	/* clear all interrupts */
 	writel(~0, &cdns->otg_irq_regs->ivect);
 
-	ret = cdns3_set_mode(cdns, USB_DR_MODE_OTG);
+	ret = cdns_set_mode(cdns, USB_DR_MODE_OTG);
 	if (ret)
 		return ret;
 
-	cdns3_otg_enable_irq(cdns);
+	cdns_otg_enable_irq(cdns);
 
 	return 0;
 }
 
 /**
- * cdns3_drd_update_mode - initialize mode of operation
+ * cdns_drd_update_mode - initialize mode of operation
  * @cdns: Pointer to controller context structure
  *
  * Returns 0 on success otherwise negative errno
  */
-int cdns3_drd_update_mode(struct cdns3 *cdns)
+int cdns_drd_update_mode(struct cdns *cdns)
 {
 	int ret;
 
 	switch (cdns->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-		ret = cdns3_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
+		ret = cdns_set_mode(cdns, USB_DR_MODE_PERIPHERAL);
 		break;
 	case USB_DR_MODE_HOST:
-		ret = cdns3_set_mode(cdns, USB_DR_MODE_HOST);
+		ret = cdns_set_mode(cdns, USB_DR_MODE_HOST);
 		break;
 	case USB_DR_MODE_OTG:
-		ret = cdns3_init_otg_mode(cdns);
+		ret = cdns_init_otg_mode(cdns);
 		break;
 	default:
 		dev_err(cdns->dev, "Unsupported mode of operation %d\n",
@@ -303,27 +303,27 @@ int cdns3_drd_update_mode(struct cdns3 *cdns)
 	return ret;
 }
 
-static irqreturn_t cdns3_drd_thread_irq(int irq, void *data)
+static irqreturn_t cdns_drd_thread_irq(int irq, void *data)
 {
-	struct cdns3 *cdns = data;
+	struct cdns *cdns = data;
 
-	cdns3_hw_role_switch(cdns);
+	cdns_hw_role_switch(cdns);
 
 	return IRQ_HANDLED;
 }
 
 /**
- * cdns3_drd_irq - interrupt handler for OTG events
+ * cdns_drd_irq - interrupt handler for OTG events
  *
- * @irq: irq number for cdns3 core device
- * @data: structure of cdns3
+ * @irq: irq number for cdns core device
+ * @data: structure of cdns
  *
  * Returns IRQ_HANDLED or IRQ_NONE
  */
-static irqreturn_t cdns3_drd_irq(int irq, void *data)
+static irqreturn_t cdns_drd_irq(int irq, void *data)
 {
 	irqreturn_t ret = IRQ_NONE;
-	struct cdns3 *cdns = data;
+	struct cdns *cdns = data;
 	u32 reg;
 
 	if (cdns->dr_mode != USB_DR_MODE_OTG)
@@ -339,14 +339,14 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 
 	if (reg & OTGIEN_ID_CHANGE_INT) {
 		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
-			cdns3_get_id(cdns));
+			cdns_get_id(cdns));
 
 		ret = IRQ_WAKE_THREAD;
 	}
 
 	if (reg & (OTGIEN_VBUSVALID_RISE_INT | OTGIEN_VBUSVALID_FALL_INT)) {
 		dev_dbg(cdns->dev, "OTG IRQ: new VBUS: %d\n",
-			cdns3_get_vbus(cdns));
+			cdns_get_vbus(cdns));
 
 		ret = IRQ_WAKE_THREAD;
 	}
@@ -355,7 +355,7 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 	return ret;
 }
 
-int cdns3_drd_init(struct cdns3 *cdns)
+int cdns_drd_init(struct cdns *cdns)
 {
 	void __iomem *regs;
 	u32 state;
@@ -380,7 +380,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
 		cdns->otg_v1_regs = NULL;
 		cdns->otg_cdnsp_regs = NULL;
 		cdns->otg_regs = regs;
-		cdns->otg_irq_regs = (struct cdns3_otg_irq_regs *)
+		cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
 				     &cdns->otg_v0_regs->ien;
 		writel(1, &cdns->otg_v0_regs->simulate);
 		dev_dbg(cdns->dev, "DRD version v0 (%08x)\n",
@@ -393,11 +393,11 @@ int cdns3_drd_init(struct cdns3 *cdns)
 		cdns->otg_regs = (void *)&cdns->otg_v1_regs->cmd;
 
 		if (cdns->otg_cdnsp_regs->did == OTG_CDNSP_DID) {
-			cdns->otg_irq_regs = (struct cdns3_otg_irq_regs *)
+			cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
 					      &cdns->otg_cdnsp_regs->ien;
 			cdns->version  = CDNSP_CONTROLLER_V2;
 		} else {
-			cdns->otg_irq_regs = (struct cdns3_otg_irq_regs *)
+			cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
 			cdns->version  = CDNS3_CONTROLLER_V1;
@@ -428,8 +428,8 @@ int cdns3_drd_init(struct cdns3 *cdns)
 	}
 
 	ret = devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
-					cdns3_drd_irq,
-					cdns3_drd_thread_irq,
+					cdns_drd_irq,
+					cdns_drd_thread_irq,
 					IRQF_SHARED,
 					dev_name(cdns->dev), cdns);
 	if (ret) {
@@ -446,8 +446,8 @@ int cdns3_drd_init(struct cdns3 *cdns)
 	return 0;
 }
 
-int cdns3_drd_exit(struct cdns3 *cdns)
+int cdns_drd_exit(struct cdns *cdns)
 {
-	cdns3_otg_disable_irq(cdns);
+	cdns_otg_disable_irq(cdns);
 	return 0;
 }
diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
index 972aba8a40b6..5cac07a14b15 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -84,7 +84,7 @@ struct cdnsp_otg_regs {
 /*
  * Common registers interface for both CDNS3 and CDNSP version of DRD.
  */
-struct cdns3_otg_common_regs {
+struct cdns_otg_common_regs {
 	__le32 cmd;
 	__le32 sts;
 	__le32 state;
@@ -94,7 +94,7 @@ struct cdns3_otg_common_regs {
  * Interrupt related registers. This registers are mapped in different
  * location for CDNSP controller.
  */
-struct cdns3_otg_irq_regs {
+struct cdns_otg_irq_regs {
 	__le32 ien;
 	__le32 ivect;
 };
@@ -202,16 +202,16 @@ struct cdns3_otg_irq_regs {
 #define CDNS3_ID_PERIPHERAL		1
 #define CDNS3_ID_HOST			0
 
-bool cdns3_is_host(struct cdns3 *cdns);
-bool cdns3_is_device(struct cdns3 *cdns);
-int cdns3_get_id(struct cdns3 *cdns);
-int cdns3_get_vbus(struct cdns3 *cdns);
-int cdns3_drd_init(struct cdns3 *cdns);
-int cdns3_drd_exit(struct cdns3 *cdns);
-int cdns3_drd_update_mode(struct cdns3 *cdns);
-extern int cdns3_drd_gadget_on(struct cdns3 *cdns);
-extern void cdns3_drd_gadget_off(struct cdns3 *cdns);
-int cdns3_drd_host_on(struct cdns3 *cdns);
-void cdns3_drd_host_off(struct cdns3 *cdns);
+bool cdns_is_host(struct cdns *cdns);
+bool cdns_is_device(struct cdns *cdns);
+int cdns_get_id(struct cdns *cdns);
+int cdns_get_vbus(struct cdns *cdns);
+int cdns_drd_init(struct cdns *cdns);
+int cdns_drd_exit(struct cdns *cdns);
+int cdns_drd_update_mode(struct cdns *cdns);
+extern int cdns_drd_gadget_on(struct cdns *cdns);
+extern void cdns_drd_gadget_off(struct cdns *cdns);
+int cdns_drd_host_on(struct cdns *cdns);
+void cdns_drd_host_off(struct cdns *cdns);
 
 #endif /* __LINUX_CDNS3_DRD */
diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-export.h
index 702c5a267a92..0f7cb2a92c9a 100644
--- a/drivers/usb/cdns3/gadget-export.h
+++ b/drivers/usb/cdns3/gadget-export.h
@@ -12,10 +12,10 @@
 
 #ifdef CONFIG_USB_CDNS3_GADGET
 
-int cdns3_gadget_init(struct cdns3 *cdns);
+int cdns3_gadget_init(struct cdns *cdns);
 #else
 
-static inline int cdns3_gadget_init(struct cdns3 *cdns)
+static inline int cdns3_gadget_init(struct cdns *cdns)
 {
 	return -ENXIO;
 }
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 26232917197a..9e0a82063873 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -1841,7 +1841,7 @@ __must_hold(&priv_dev->lock)
 static irqreturn_t cdns3_device_irq_handler(int irq, void *data)
 {
 	struct cdns3_device *priv_dev = data;
-	struct cdns3 *cdns = dev_get_drvdata(priv_dev->dev);
+	struct cdns *cdns = dev_get_drvdata(priv_dev->dev);
 	irqreturn_t ret = IRQ_NONE;
 	u32 reg;
 
@@ -3081,7 +3081,7 @@ static void cdns3_gadget_release(struct device *dev)
 	kfree(priv_dev);
 }
 
-static void cdns3_gadget_exit(struct cdns3 *cdns)
+static void cdns3_gadget_exit(struct cdns *cdns)
 {
 	struct cdns3_device *priv_dev;
 
@@ -3114,10 +3114,10 @@ static void cdns3_gadget_exit(struct cdns3 *cdns)
 	kfree(priv_dev->zlp_buf);
 	usb_put_gadget(&priv_dev->gadget);
 	cdns->gadget_dev = NULL;
-	cdns3_drd_gadget_off(cdns);
+	cdns_drd_gadget_off(cdns);
 }
 
-static int cdns3_gadget_start(struct cdns3 *cdns)
+static int cdns3_gadget_start(struct cdns *cdns)
 {
 	struct cdns3_device *priv_dev;
 	u32 max_speed;
@@ -3237,7 +3237,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
 	return ret;
 }
 
-static int __cdns3_gadget_init(struct cdns3 *cdns)
+static int __cdns3_gadget_init(struct cdns *cdns)
 {
 	int ret = 0;
 
@@ -3248,7 +3248,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 		return ret;
 	}
 
-	cdns3_drd_gadget_on(cdns);
+	cdns_drd_gadget_on(cdns);
 	pm_runtime_get_sync(cdns->dev);
 
 	ret = cdns3_gadget_start(cdns);
@@ -3274,7 +3274,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 	return ret;
 }
 
-static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
+static int cdns3_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 __must_hold(&cdns->lock)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
@@ -3293,7 +3293,7 @@ __must_hold(&cdns->lock)
 	return 0;
 }
 
-static int cdns3_gadget_resume(struct cdns3 *cdns, bool hibernated)
+static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
 
@@ -3308,13 +3308,13 @@ static int cdns3_gadget_resume(struct cdns3 *cdns, bool hibernated)
 /**
  * cdns3_gadget_init - initialize device structure
  *
- * @cdns: cdns3 instance
+ * @cdns: cdns instance
  *
  * This function initializes the gadget.
  */
-int cdns3_gadget_init(struct cdns3 *cdns)
+int cdns3_gadget_init(struct cdns *cdns)
 {
-	struct cdns3_role_driver *rdrv;
+	struct cdns_role_driver *rdrv;
 
 	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
 	if (!rdrv)
@@ -3324,7 +3324,7 @@ int cdns3_gadget_init(struct cdns3 *cdns)
 	rdrv->stop	= cdns3_gadget_exit;
 	rdrv->suspend	= cdns3_gadget_suspend;
 	rdrv->resume	= cdns3_gadget_resume;
-	rdrv->state	= CDNS3_ROLE_STATE_INACTIVE;
+	rdrv->state	= CDNS_ROLE_STATE_INACTIVE;
 	rdrv->name	= "gadget";
 	cdns->roles[USB_ROLE_DEVICE] = rdrv;
 
diff --git a/drivers/usb/cdns3/host-export.h b/drivers/usb/cdns3/host-export.h
index ae11810f8826..d82b83d070ad 100644
--- a/drivers/usb/cdns3/host-export.h
+++ b/drivers/usb/cdns3/host-export.h
@@ -11,16 +11,16 @@
 
 #ifdef CONFIG_USB_CDNS3_HOST
 
-int cdns3_host_init(struct cdns3 *cdns);
+int cdns_host_init(struct cdns *cdns);
 
 #else
 
-static inline int cdns3_host_init(struct cdns3 *cdns)
+static inline int cdns_host_init(struct cdns *cdns)
 {
 	return -ENXIO;
 }
 
-static inline void cdns3_host_exit(struct cdns3 *cdns) { }
+static inline void cdns_host_exit(struct cdns *cdns) { }
 
 #endif /* CONFIG_USB_CDNS3_HOST */
 
diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index b3e2cb69762c..42276e99ab5d 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Cadence USBSS DRD Driver - host side
+ * Cadence USBSS and USBSSP DRD Driver - host side
  *
  * Copyright (C) 2018-2019 Cadence Design Systems.
  * Copyright (C) 2017-2018 NXP
@@ -15,13 +15,13 @@
 #include "host-export.h"
 #include <linux/usb/hcd.h>
 
-static int __cdns3_host_init(struct cdns3 *cdns)
+static int __cdns_host_init(struct cdns *cdns)
 {
 	struct platform_device *xhci;
 	int ret;
 	struct usb_hcd *hcd;
 
-	cdns3_drd_host_on(cdns);
+	cdns_drd_host_on(cdns);
 
 	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
 	if (!xhci) {
@@ -33,7 +33,7 @@ static int __cdns3_host_init(struct cdns3 *cdns)
 	cdns->host_dev = xhci;
 
 	ret = platform_device_add_resources(xhci, cdns->xhci_res,
-					    CDNS3_XHCI_RESOURCES_NUM);
+					    CDNS_XHCI_RESOURCES_NUM);
 	if (ret) {
 		dev_err(cdns->dev, "couldn't add resources to xHCI device\n");
 		goto err1;
@@ -56,24 +56,24 @@ static int __cdns3_host_init(struct cdns3 *cdns)
 	return ret;
 }
 
-static void cdns3_host_exit(struct cdns3 *cdns)
+static void cdns_host_exit(struct cdns *cdns)
 {
 	platform_device_unregister(cdns->host_dev);
 	cdns->host_dev = NULL;
-	cdns3_drd_host_off(cdns);
+	cdns_drd_host_off(cdns);
 }
 
-int cdns3_host_init(struct cdns3 *cdns)
+int cdns_host_init(struct cdns *cdns)
 {
-	struct cdns3_role_driver *rdrv;
+	struct cdns_role_driver *rdrv;
 
 	rdrv = devm_kzalloc(cdns->dev, sizeof(*rdrv), GFP_KERNEL);
 	if (!rdrv)
 		return -ENOMEM;
 
-	rdrv->start	= __cdns3_host_init;
-	rdrv->stop	= cdns3_host_exit;
-	rdrv->state	= CDNS3_ROLE_STATE_INACTIVE;
+	rdrv->start	= __cdns_host_init;
+	rdrv->stop	= cdns_host_exit;
+	rdrv->state	= CDNS_ROLE_STATE_INACTIVE;
 	rdrv->name	= "host";
 
 	cdns->roles[USB_ROLE_HOST] = rdrv;
-- 
2.17.1

