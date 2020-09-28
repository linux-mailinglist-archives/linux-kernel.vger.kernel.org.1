Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97A127ADE5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgI1MeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:34:10 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:8152 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726614AbgI1MeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:34:02 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08SCUE1j012279;
        Mon, 28 Sep 2020 05:33:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=++O4BXJm6N0w57a15w6T2pjcNf61jMnIua77J++0oZo=;
 b=Im6MB/fyBwxEo2IW7GS4muXUvFBOcsEgQIaAPUx/mpR5TZ4nDD50lViLMRiy3+mUJxYk
 bDqhIHnX4RWYeNPHHwKK9OEE4X0CqaRTpULuKlAu6IXhUrTt92SADzHwrCA/iJWbAP/a
 TqdoH4Zq0VJRTDjOM9kLYOAWES1KkXFmNGFf/KMSE2QTBpwe+vteDcfkPV2qwt8+qd7N
 W0GCpazw+EtgR7BY2L678sYrsQJjrirRqyiqdv5Cx9VPof4ouQkDVVRHUt4pGJI44NsH
 rAO62vTmPdAj0G/IWm/7tYHJG2bbVMq7PY12xgmxJM9s7hVq1knZueB2Fzdk9gu1sboP rg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17wwcuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Sep 2020 05:33:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3rajS+TJHSFrzbp3iU6ujomBh9b4UsLno7NQSZovBK1snA7yg00wQyCQ/EDNI9EFL9rLdhVcTzMUIocY8afJN9DkK+pVQtBA306FNeom8xwfPdziNLpli9Uys0eTYO/GWcaIqcWcCyQN9AawMfDy1HD5sC47wcbsy/HqqHxPUjcRF1UJRN1XRJB2QcJvWYGR/CiUOODkh9TCUoXbfhHdoyng8leCFl/P8H113EW7an0LAwlPuE2thsYfWBCtUWD3bvUb4+uwH8yFi9B1j50f38sVd7JvpaxVzJoIINVzXR2ShjS97qUSVVhd7D7i7lZT+J7wBWUWpgIe4c7Vk+Xpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++O4BXJm6N0w57a15w6T2pjcNf61jMnIua77J++0oZo=;
 b=dG7wRY/bFL8+MHEhrtS2/iwT75GIhote7bsDdT1O25tvzYQbircbaXFzrCtNiYs1TOLh19FkQJ1NPyzejzI5xLAqhWpS6YMtygVqkHuUjBG+jMLzRpvagCEY6+KLu1bH+ueD4jTmyWi/inQj9jTvtFivwsyhOD+M9W5QsATBnpTz/WNU+AAQvsG5TaL+tQee4iPEUg3xET7XIdhhX4NdGFNA1Fj5zkRoslhZhuXP0jzDi9WTSRL5DTsMZLwOLppL5m3fIr2Qg0PwZJiXC0ck5VFKm0pBXK1qSgoNihWyXugUi0+v+dfRWorzGuk3RRJuly/XkXv81QXKd5IYVOhK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++O4BXJm6N0w57a15w6T2pjcNf61jMnIua77J++0oZo=;
 b=3B1vs1INXtWWompqTbt4lyQyVPTwtHPQL+2aKgW5HWOubt8/FPq4xGHR52zJoHJg74pMoYYIYmFosgd7UmLJTnes9ak6DqhFAB1f19TijZj+iZQUKsWRA/nvHwn1ccGZmdas8hgyd7B6ODql8xIgHDXuXlgB6aV3Ff2FqvaEg1I=
Received: from BN8PR15CA0037.namprd15.prod.outlook.com (2603:10b6:408:80::14)
 by SA0PR07MB7786.namprd07.prod.outlook.com (2603:10b6:806:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 12:33:32 +0000
Received: from BN8NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::3) by BN8PR15CA0037.outlook.office365.com
 (2603:10b6:408:80::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Mon, 28 Sep 2020 12:33:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT032.mail.protection.outlook.com (10.13.183.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Mon, 28 Sep 2020 12:33:31 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXQCZ030864
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 28 Sep 2020 08:33:31 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 28 Sep 2020 14:33:26 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08SCXQHa019078;
        Mon, 28 Sep 2020 14:33:26 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08SCXQY0019077;
        Mon, 28 Sep 2020 14:33:26 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>
CC:     <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <jpawar@cadence.com>, <kurahul@cadence.com>, <sparmar@cadence.com>,
        <pawell@cadence.com>, <nsekhar@ti.com>,
        <heikki.krogerus@linux.intel.com>, <chunfeng.yun@mediatek.com>,
        <yanaijie@huawei.com>
Subject: [PATCH 4/8] usb: cdns3: Refactoring names in reusable code
Date:   Mon, 28 Sep 2020 14:27:37 +0200
Message-ID: <20200928122741.17884-5-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200928122741.17884-1-pawell@cadence.com>
References: <20200928122741.17884-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cd3dd30-13b2-4514-d146-08d863aab5be
X-MS-TrafficTypeDiagnostic: SA0PR07MB7786:
X-Microsoft-Antispam-PRVS: <SA0PR07MB7786174C11F16D304A20C962DD350@SA0PR07MB7786.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lvq2+iRI76ePtPW6r/uoaWwWt0a8A7pztsT85U064s9tAavOKPmGJgegK73z/zEbzoDTwIV/FClEWYrLPHQtXdNlk/ZBHEPsX2PYS/J5n+osifsqsEaHYyMorAI96Qr8SKl62+qWzqMe9eZ6nRFO/F3fqk9S+cT0VW9m9U5vNRIxns7lNeZeDQrcwQtHEE/JMzK12ryL1DPT2Y0sg8dE4kYjlhHktM8ZCcCeVYvK2qq2YSC5XRs6nwiaKiCt3zxxlCCft0vw/rUIZTPYeHuRnjVuc024Y/7zQ0qjzIfnT8zguZ0V6Lr2OrzDlPpnSwXR5EHhXJyKV2IWJKPu1ozuFc1eueS/lN4J8rDd9UWkw8hStm9SaHD0XbGcO8TfqHew+j+SeIbMKYtxyNczHlNPbw5kXDN/rILj+T0UfKUdHA1QEeFv4VQpWmACl2uWbNTo4A0jU5+YLyRVCPTpl6ZsxNhzyLI4y1xuIFTU2/Fj8c8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36092001)(46966005)(7416002)(186003)(42186006)(30864003)(8676002)(86362001)(82740400003)(36756003)(4326008)(110136005)(47076004)(36906005)(316002)(1076003)(8936002)(54906003)(83380400001)(6666004)(81166007)(356005)(5660300002)(2616005)(478600001)(70206006)(70586007)(26005)(336012)(2906002)(426003)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 12:33:31.7396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd3dd30-13b2-4514-d146-08d863aab5be
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT032.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7786
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_11:2020-09-28,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=797 clxscore=1015
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009280102
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
 drivers/usb/cdns3/cdns3-plat.c    |  16 ++--
 drivers/usb/cdns3/core.c          | 128 +++++++++++++++---------------
 drivers/usb/cdns3/core.h          |  44 +++++-----
 drivers/usb/cdns3/drd.c           | 104 ++++++++++++------------
 drivers/usb/cdns3/drd.h           |  26 +++---
 drivers/usb/cdns3/gadget-export.h |   8 +-
 drivers/usb/cdns3/gadget.c        |  22 ++---
 drivers/usb/cdns3/host-export.h   |   6 +-
 drivers/usb/cdns3/host.c          |  20 ++---
 9 files changed, 187 insertions(+), 187 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index f35e9dca30fe..a5f8cf6d8961 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -29,7 +29,7 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct resource	*res;
-	struct cdns3 *cdns;
+	struct cdns *cdns;
 	void __iomem *regs;
 	int ret;
 
@@ -110,7 +110,7 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_phy3_power_on;
 
-	ret = cdns3_init(cdns);
+	ret = cdns_init(cdns);
 	if (ret)
 		goto err_cdns_init;
 
@@ -148,13 +148,13 @@ static int cdns3_plat_probe(struct platform_device *pdev)
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
 	phy_power_off(cdns->usb2_phy);
 	phy_power_off(cdns->usb3_phy);
 	phy_exit(cdns->usb2_phy);
@@ -166,16 +166,16 @@ static int cdns3_plat_remove(struct platform_device *pdev)
 
 static int cdns3_plat_suspend(struct device *dev)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct cdns *cdns = dev_get_drvdata(dev);
 
-	return cdns3_suspend(cdns);
+	return cdns_suspend(cdns);
 }
 
 static int cdns3_plat_resume(struct device *dev)
 {
-	struct cdns3 *cdns = dev_get_drvdata(dev);
+	struct cdns *cdns = dev_get_drvdata(dev);
 
-	return cdns3_resume(cdns);
+	return cdns_resume(cdns);
 }
 #endif
 
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index 2c79fd5dbacb..2af99294beaa 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -25,9 +25,9 @@
 #include "gadget-export.h"
 #include "drd.h"
 
-static int cdns3_idle_init(struct cdns3 *cdns);
+static int cdns_idle_init(struct cdns *cdns);
 
-static int cdns3_role_start(struct cdns3 *cdns, enum usb_role role)
+static int cdns_role_start(struct cdns *cdns, enum usb_role role)
 {
 	int ret;
 
@@ -41,47 +41,47 @@ static int cdns3_role_start(struct cdns3 *cdns, enum usb_role role)
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
@@ -122,7 +122,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	 */
 	best_dr_mode = cdns->dr_mode;
 
-	ret = cdns3_idle_init(cdns);
+	ret = cdns_idle_init(cdns);
 	if (ret)
 		return ret;
 
@@ -138,7 +138,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 	dr_mode = best_dr_mode;
 
 	if (dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_HOST) {
-		ret = cdns3_host_init(cdns);
+		ret = cdns_host_init(cdns);
 		if (ret) {
 			dev_err(dev, "Host initialization failed with %d\n",
 				ret);
@@ -157,28 +157,28 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
 
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
@@ -194,27 +194,27 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
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
@@ -250,28 +250,28 @@ static enum usb_role cdns3_hw_role_state_machine(struct cdns3 *cdns)
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
@@ -282,10 +282,10 @@ static int cdns3_idle_init(struct cdns3 *cdns)
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
@@ -293,22 +293,22 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
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
@@ -325,15 +325,15 @@ int cdns3_hw_role_switch(struct cdns3 *cdns)
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
@@ -341,9 +341,9 @@ static enum usb_role cdns3_role_get(struct usb_role_switch *sw)
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
@@ -371,8 +371,8 @@ static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
 		}
 	}
 
-	cdns3_role_stop(cdns);
-	ret = cdns3_role_start(cdns, role);
+	cdns_role_stop(cdns);
+	ret = cdns_role_start(cdns, role);
 	if (ret)
 		dev_err(cdns->dev, "set role %d has failed\n", role);
 
@@ -382,12 +382,12 @@ static int cdns3_role_set(struct usb_role_switch *sw, enum usb_role role)
 }
 
 /**
- * cdns3_probe - probe for cdns3 core device
- * @cdns: Pointer to cdnsp structure.
+ * cdns_probe - probe for cdns core device
+ * @cdns: Pointer to cdns structure.
  *
  * Returns 0 on success otherwise negative errno
  */
-int cdns3_init(struct cdns3 *cdns)
+int cdns_init(struct cdns *cdns)
 {
 	struct usb_role_switch_desc sw_desc = { };
 	struct device *dev = cdns->dev;
@@ -401,8 +401,8 @@ int cdns3_init(struct cdns3 *cdns)
 
 	mutex_init(&cdns->mutex);
 
-	sw_desc.set = cdns3_role_set;
-	sw_desc.get = cdns3_role_get;
+	sw_desc.set = cdns_role_set;
+	sw_desc.get = cdns_role_get;
 	sw_desc.allow_userspace_control = true;
 	sw_desc.driver_data = cdns;
 	if (device_property_read_bool(dev, "usb-role-switch"))
@@ -414,11 +414,11 @@ int cdns3_init(struct cdns3 *cdns)
 		return PTR_ERR(cdns->role_sw);
 	}
 
-	ret = cdns3_drd_init(cdns);
+	ret = cdns_drd_init(cdns);
 	if (ret)
 		goto init_failed;
 
-	ret = cdns3_core_init_role(cdns);
+	ret = cdns_core_init_role(cdns);
 	if (ret)
 		goto init_failed;
 
@@ -426,31 +426,31 @@ int cdns3_init(struct cdns3 *cdns)
 
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
 
@@ -465,9 +465,9 @@ int cdns3_suspend(struct cdns3 *cdns)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cdns3_suspend);
+EXPORT_SYMBOL_GPL(cdns_suspend);
 
-int cdns3_resume(struct cdns3 *cdns)
+int cdns_resume(struct cdns *cdns)
 {
 	struct device *dev = cdns->dev;
 
@@ -483,7 +483,7 @@ int cdns3_resume(struct cdns3 *cdns)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(cdns3_resume);
+EXPORT_SYMBOL_GPL(cdns_resume);
 #endif
 
 MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index f868c415d4e7..0c6e14683b36 100644
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
@@ -26,20 +26,20 @@ struct cdns3;
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
 /**
- * struct cdns3 - Representation of Cadence USB3 DRD controller.
+ * struct cdns - Representation of Cadence USB3 DRD controller.
  * @dev: pointer to Cadence device struct
  * @xhci_regs: pointer to base of xhci registers
  * @xhci_res: the resource for xhci
@@ -54,7 +54,7 @@ struct cdns3_role_driver {
  * @dev_irq: irq number for device controller
  * @roles: array of supported roles for this controller
  * @role: current role
- * @host_dev: the child host device pointer for cdns3 core
+ * @host_dev: the child host device pointer for cdns core
  * @gadget_dev: the child gadget device pointer for cdns3 core
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
@@ -65,18 +65,18 @@ struct cdns3_role_driver {
  *           and hardware configuration.
  * @role_sw: pointer to role switch object.
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
@@ -84,7 +84,7 @@ struct cdns3 {
 
 	int				otg_irq;
 	int				dev_irq;
-	struct cdns3_role_driver	*roles[USB_ROLE_DEVICE + 1];
+	struct cdns_role_driver	*roles[USB_ROLE_DEVICE + 1];
 	enum usb_role			role;
 	struct platform_device		*host_dev;
 	struct cdns3_device		*gadget_dev;
@@ -96,12 +96,12 @@ struct cdns3 {
 	struct usb_role_switch		*role_sw;
 };
 
-int cdns3_hw_role_switch(struct cdns3 *cdns);
-extern int cdns3_init(struct cdns3 *cdns);
-extern int cdns3_remove(struct cdns3 *cdns);
+int cdns_hw_role_switch(struct cdns *cdns);
+extern int cdns_init(struct cdns *cdns);
+extern int cdns_remove(struct cdns *cdns);
 
 #ifdef CONFIG_PM_SLEEP
-extern int cdns3_resume(struct cdns3 *cdns);
-extern int cdns3_suspend(struct cdns3 *cdns);
+extern int cdns_resume(struct cdns *cdns);
+extern int cdns_suspend(struct cdns *cdns);
 #endif /* CONFIG_PM_SLEEP */
 #endif /* __LINUX_CDNS3_CORE_H */
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index ee6c6ddb6a6f..7feb622972da 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -20,13 +20,13 @@
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
@@ -70,7 +70,7 @@ static int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
 	return 0;
 }
 
-int cdns3_get_id(struct cdns3 *cdns)
+int cdns_get_id(struct cdns *cdns)
 {
 	int id;
 
@@ -80,7 +80,7 @@ int cdns3_get_id(struct cdns3 *cdns)
 	return id;
 }
 
-int cdns3_get_vbus(struct cdns3 *cdns)
+int cdns_get_vbus(struct cdns *cdns)
 {
 	int vbus;
 
@@ -90,53 +90,53 @@ int cdns3_get_vbus(struct cdns3 *cdns)
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
@@ -159,13 +159,13 @@ int cdns3_drd_host_on(struct cdns3 *cdns)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(cdns3_drd_host_on);
+EXPORT_SYMBOL_GPL(cdns_drd_host_on);
 
 /**
- * cdns3_drd_host_off - stop host.
+ * cdns_drd_host_off - stop host.
  * @cdns: Pointer to controller context structure.
  */
-void cdns3_drd_host_off(struct cdns3 *cdns)
+void cdns_drd_host_off(struct cdns *cdns)
 {
 	u32 val;
 
@@ -178,15 +178,15 @@ void cdns3_drd_host_off(struct cdns3 *cdns)
 				  !(val & OTGSTATE_HOST_STATE_MASK),
 				  1, 2000000);
 }
-EXPORT_SYMBOL_GPL(cdns3_drd_host_off);
+EXPORT_SYMBOL_GPL(cdns_drd_host_off);
 
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
@@ -211,13 +211,13 @@ int cdns3_drd_gadget_on(struct cdns3 *cdns)
 
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
 
@@ -234,50 +234,50 @@ void cdns3_drd_gadget_off(struct cdns3 *cdns)
 				  !(val & OTGSTATE_DEV_STATE_MASK),
 				  1, 2000000);
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
@@ -288,27 +288,27 @@ int cdns3_drd_update_mode(struct cdns3 *cdns)
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
@@ -321,14 +321,14 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 
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
@@ -337,7 +337,7 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
 	return ret;
 }
 
-int cdns3_drd_init(struct cdns3 *cdns)
+int cdns_drd_init(struct cdns *cdns)
 {
 	void __iomem *regs;
 	u32 state;
@@ -362,7 +362,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
 		cdns->otg_v1_regs = NULL;
 		cdns->otg_cdnsp_regs = NULL;
 		cdns->otg_regs = regs;
-		cdns->otg_irq_regs = (struct cdns3_otg_irq_regs *)
+		cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
 				     &cdns->otg_v0_regs->ien;
 		writel(1, &cdns->otg_v0_regs->simulate);
 		dev_dbg(cdns->dev, "DRD version v0 (%08x)\n",
@@ -375,11 +375,11 @@ int cdns3_drd_init(struct cdns3 *cdns)
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
@@ -410,8 +410,8 @@ int cdns3_drd_init(struct cdns3 *cdns)
 	}
 
 	ret = devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
-					cdns3_drd_irq,
-					cdns3_drd_thread_irq,
+					cdns_drd_irq,
+					cdns_drd_thread_irq,
 					IRQF_SHARED,
 					dev_name(cdns->dev), cdns);
 	if (ret) {
@@ -428,8 +428,8 @@ int cdns3_drd_init(struct cdns3 *cdns)
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
index b4e4c5330f06..b92e2834dc3f 100644
--- a/drivers/usb/cdns3/drd.h
+++ b/drivers/usb/cdns3/drd.h
@@ -85,7 +85,7 @@ struct cdnsp_otg_regs {
 /*
  * Common registers interface for both CDNS3 and CDNSP version of DRD.
  */
-struct cdns3_otg_common_regs {
+struct cdns_otg_common_regs {
 	__le32 cmd;
 	__le32 sts;
 	__le32 state;
@@ -95,7 +95,7 @@ struct cdns3_otg_common_regs {
  * Interrupt related registers. This registers are mapped in different
  * location for CDNSP controller.
  */
-struct cdns3_otg_irq_regs {
+struct cdns_otg_irq_regs {
 	__le32 ien;
 	__le32 ivect;
 };
@@ -200,16 +200,16 @@ struct cdns3_otg_irq_regs {
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
-extern int cdns3_drd_host_on(struct cdns3 *cdns);
-extern void cdns3_drd_host_off(struct cdns3 *cdns);
+bool cdns_is_host(struct cdns *cdns);
+bool cdns_is_device(struct cdns *cdns);
+int cdns_get_id(struct cdns *cdns);
+int cdns_get_vbus(struct cdns *cdns);
+int cdns_drd_init(struct cdns *cdns);
+int cdns_drd_exit(struct cdns *cdns);
+int cdns_drd_update_mode(struct cdns *cdns);
+extern int cdns_drd_gadget_on(struct cdns *cdns);
+extern void cdns_drd_gadget_off(struct cdns *cdns);
+extern int cdns_drd_host_on(struct cdns *cdns);
+extern void cdns_drd_host_off(struct cdns *cdns);
 
 #endif /* __LINUX_CDNS3_DRD */
diff --git a/drivers/usb/cdns3/gadget-export.h b/drivers/usb/cdns3/gadget-export.h
index 03a78593a04a..e784584fe053 100644
--- a/drivers/usb/cdns3/gadget-export.h
+++ b/drivers/usb/cdns3/gadget-export.h
@@ -12,16 +12,16 @@
 
 #ifdef CONFIG_USB_CDNS3_GADGET
 
-extern int cdns3_gadget_init(struct cdns3 *cdns);
-void cdns3_gadget_exit(struct cdns3 *cdns);
+extern int cdns3_gadget_init(struct cdns *cdns);
+void cdns3_gadget_exit(struct cdns *cdns);
 #else
 
-static inline int cdns3_gadget_init(struct cdns3 *cdns)
+static inline int cdns3_gadget_init(struct cdns *cdns)
 {
 	return -ENXIO;
 }
 
-static inline void cdns3_gadget_exit(struct cdns3 *cdns) { }
+static inline void cdns3_gadget_exit(struct cdns *cdns) { }
 
 #endif
 
diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
index 132c7ed945d2..26f68182e65e 100644
--- a/drivers/usb/cdns3/gadget.c
+++ b/drivers/usb/cdns3/gadget.c
@@ -2984,7 +2984,7 @@ static int cdns3_init_eps(struct cdns3_device *priv_dev)
 	return -ENOMEM;
 }
 
-void cdns3_gadget_exit(struct cdns3 *cdns)
+void cdns3_gadget_exit(struct cdns *cdns)
 {
 	struct cdns3_device *priv_dev;
 
@@ -3017,10 +3017,10 @@ void cdns3_gadget_exit(struct cdns3 *cdns)
 	kfree(priv_dev->zlp_buf);
 	kfree(priv_dev);
 	cdns->gadget_dev = NULL;
-	cdns3_drd_gadget_off(cdns);
+	cdns_drd_gadget_off(cdns);
 }
 
-static int cdns3_gadget_start(struct cdns3 *cdns)
+static int cdns3_gadget_start(struct cdns *cdns)
 {
 	struct cdns3_device *priv_dev;
 	u32 max_speed;
@@ -3137,7 +3137,7 @@ static int cdns3_gadget_start(struct cdns3 *cdns)
 	return ret;
 }
 
-static int __cdns3_gadget_init(struct cdns3 *cdns)
+static int __cdns3_gadget_init(struct cdns *cdns)
 {
 	int ret = 0;
 
@@ -3148,7 +3148,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 		return ret;
 	}
 
-	cdns3_drd_gadget_on(cdns);
+	cdns_drd_gadget_on(cdns);
 	pm_runtime_get_sync(cdns->dev);
 
 	ret = cdns3_gadget_start(cdns);
@@ -3174,7 +3174,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
 	return ret;
 }
 
-static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
+static int cdns3_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
 
@@ -3190,7 +3190,7 @@ static int cdns3_gadget_suspend(struct cdns3 *cdns, bool do_wakeup)
 	return 0;
 }
 
-static int cdns3_gadget_resume(struct cdns3 *cdns, bool hibernated)
+static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
 
@@ -3205,13 +3205,13 @@ static int cdns3_gadget_resume(struct cdns3 *cdns, bool hibernated)
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
@@ -3221,7 +3221,7 @@ int cdns3_gadget_init(struct cdns3 *cdns)
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
index d4b911e7fa49..6b194389178b 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -14,12 +14,12 @@
 #include "drd.h"
 #include "host-export.h"
 
-static int __cdns3_host_init(struct cdns3 *cdns)
+static int __cdns_host_init(struct cdns *cdns)
 {
 	struct platform_device *xhci;
 	int ret;
 
-	cdns3_drd_host_on(cdns);
+	cdns_drd_host_on(cdns);
 
 	xhci = platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
 	if (!xhci) {
@@ -31,7 +31,7 @@ static int __cdns3_host_init(struct cdns3 *cdns)
 	cdns->host_dev = xhci;
 
 	ret = platform_device_add_resources(xhci, cdns->xhci_res,
-					    CDNS3_XHCI_RESOURCES_NUM);
+					    CDNS_XHCI_RESOURCES_NUM);
 	if (ret) {
 		dev_err(cdns->dev, "couldn't add resources to xHCI device\n");
 		goto err1;
@@ -49,24 +49,24 @@ static int __cdns3_host_init(struct cdns3 *cdns)
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

