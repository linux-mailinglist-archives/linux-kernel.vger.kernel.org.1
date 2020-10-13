Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B7D28C7B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 06:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgJMEAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 00:00:40 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:30456 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgJMEAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 00:00:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09D3wBNm028870;
        Mon, 12 Oct 2020 21:00:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=PYIfTKF+gZLu1BQqqTJjzcUoI1zOKFCyiKQb2Ls8VAE=;
 b=BBVqE4aSUnUMKlMRkPuT9FCNym18uuq2zwKtjEnieedDQPvXbGcbJSSE+TZFV0TS1PMH
 TZPCOZe5p7X3aPkiY1Ch1UZDW8vOAfI9ILkrIAvTpegguv0B4Xx9oNav38lFvAw1RPhA
 c2ytlqDnxffSopADcJ20HEx3DKc7Y2Zeq2hQIvuQS96X+fd/nFzY7F6E/fL1UQz9coyJ
 Rp//SYmLTyK2UMnLunmqj9FA10kpx7Vuwz4WFfbNALxO8DbEgj0Ax3Uto80b11c582L5
 48w5X+SekBjnzy5bF/4d52jzO93Wn1LfgkM3xBl/5xCwmR6a0ixBYh+2p8VZYEAXwa9F 3g== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3439gw0vmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Oct 2020 21:00:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuKYLq0WIeOFnkvxkDW0GBnBP/UKPZDKLzfwRHwMh8ST/nnAk0UuIO/4wG9L3e2RzYt0Si1RFvB5MXs7OGUzOgQJcz+Q8Q2bg327+prX0K3nc3ncZ9AAWquBYS6ubCte6AHthBjniTvjUisshbwMeHqp/JDyLnFah/uKN1jqGevA0BnK0n/eTWrd+PKG1ql0avawM8IKmyPVwBU0Gh23j0sxY9LCPyJgflzcFjOkXqkbU7LPIXA3BEXc+d47v5NZ2dC1OncfIBPg57Ci4gN5HNqB3g7MhvoY9vcSpMf6EVVR6woo8liMornMuk/q+Xj6A+gU7j8t9oJZXThMFFzvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYIfTKF+gZLu1BQqqTJjzcUoI1zOKFCyiKQb2Ls8VAE=;
 b=PjcHRkRbtPHK15FMQHc26Hk68zGfy29H2FQaPE/tjQfrAplS5daRflicAZVYUy8xOlSj1tHyiBXWM3fovIi4aR/HEjuYpSOn465MV82JUNJ1VbADV+QhM+bb+qFWl2U1QCkXIK7iWni0uH3njnvpTVIZBwKgPlRV7PPTQkTgM6GK/iJd9dcpquNiAoZnXsebw9RUg1jsLKw8A0839gVspHz2XLzskZDbnl6xI7G1uMi3/bljZBuiwlywB65XEBZ/r6bknnJpg8o3S3JBPRjZe2gP31grbnMu0I6P33VnD+Cs1gQ32LpCqc7Ttc0atn/CpkYIBy7HOLyW+X5lxpnQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYIfTKF+gZLu1BQqqTJjzcUoI1zOKFCyiKQb2Ls8VAE=;
 b=wVrEIGR1r7vs8stOfyWYd9Qth7rX43I97ldBB8V9KavDMRS8ONZmZOWttTnPGwZR4ZCuqRXo5aWP6WQDQISQ/D0EZbj//0VasEvIXwrTCKu7egac0pBxPMVGeiPTI8nDZBj/FaYd+zC7bAUmy1pzj6NmzNsAYJF2j1PlSZgFN7o=
Received: from BN3PR03CA0088.namprd03.prod.outlook.com
 (2a01:111:e400:7a4d::48) by BL0PR07MB4114.namprd07.prod.outlook.com
 (2603:10b6:207:4c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 13 Oct
 2020 04:00:26 +0000
Received: from BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:7a4d:cafe::36) by BN3PR03CA0088.outlook.office365.com
 (2a01:111:e400:7a4d::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Tue, 13 Oct 2020 04:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT068.mail.protection.outlook.com (10.13.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.11 via Frontend Transport; Tue, 13 Oct 2020 04:00:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 09D40MZR211608
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Mon, 12 Oct 2020 21:00:23 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 13 Oct 2020 06:00:21 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 13 Oct 2020 06:00:21 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 09D40LUk025751;
        Tue, 13 Oct 2020 06:00:21 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 09D40K56025750;
        Tue, 13 Oct 2020 06:00:20 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <rogerq@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3] usb: cdns3: Rids of duplicate error message
Date:   Tue, 13 Oct 2020 06:00:05 +0200
Message-ID: <20201013040005.25706-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12e8b966-7cb7-4cb1-5c22-08d86f2c83d2
X-MS-TrafficTypeDiagnostic: BL0PR07MB4114:
X-Microsoft-Antispam-PRVS: <BL0PR07MB4114FD15BE8875328CF21C20DD040@BL0PR07MB4114.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f56+R60X+sM0abp70KonjgY8JahIKA670Zw4jNsbmJb06+Va2KcIs8yI6Du1e5DcVVvqfrMvTX4w6l+Yz1HViDXssTvDCCiYlnEAd83DP2Mik2nXaT6zToC8wyovMWAwwU5WLJEfJOEdMYvgnimWcohWXHEOPUJTYBHyWWrEvLUjJjj1dkr8aPwpenDl/yqCvWw4gu8u68Xa8HnemIYd5dlUFlohxsPPJbymDCiFJ2EZw/3trPHRMC2e3D3D0uqndiAsiOyFEarwSxvdFsNY2SZDLbJ6v3w6EyJloV1FWRskBYxbgmfh12BJ1HdlrvkVPG1LkdV8eF7ERoeblLy/22KWisV7nw1R3uNaKUK+J062j/+6/n5YdwND7dGqgw0sWIcOxxqKBeI9lpeJfrbwqd8y1Gwg80uxsEhT1nC1CX/FyoQRHkAAiFKR0n6UwDoQJBGEXiaJiN7VxlVu+dBTiA==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36092001)(46966005)(2616005)(6916009)(15650500001)(26005)(6666004)(36756003)(336012)(356005)(2906002)(186003)(426003)(86362001)(5660300002)(70206006)(36906005)(316002)(81166007)(54906003)(70586007)(42186006)(478600001)(107886003)(4326008)(1076003)(47076004)(82740400003)(34020700004)(8936002)(82310400003)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2020 04:00:25.2291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e8b966-7cb7-4cb1-5c22-08d86f2c83d2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4114
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-13_01:2020-10-12,2020-10-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=1
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=779 clxscore=1015 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010130033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On failure, the platform_get_irq_byname prints an error message
so, patch removes error message related to this function from
core.c file.

A change was suggested during reviewing CDNSP driver by Chunfeng Yun.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v3
- changed error condition checking for dev_irq.
v2
- simplified code as sugested by Roger Quadros.

 drivers/usb/cdns3/core.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index a0f73d4711ae..f2dedce3a40e 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -466,11 +466,8 @@ static int cdns3_probe(struct platform_device *pdev)
 	cdns->xhci_res[1] = *res;
 
 	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
-	if (cdns->dev_irq == -EPROBE_DEFER)
-		return cdns->dev_irq;
-
 	if (cdns->dev_irq < 0)
-		dev_err(dev, "couldn't get peripheral irq\n");
+		return cdns->dev_irq;
 
 	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
 	if (IS_ERR(regs))
@@ -478,14 +475,9 @@ static int cdns3_probe(struct platform_device *pdev)
 	cdns->dev_regs	= regs;
 
 	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
-	if (cdns->otg_irq == -EPROBE_DEFER)
+	if (cdns->otg_irq < 0)
 		return cdns->otg_irq;
 
-	if (cdns->otg_irq < 0) {
-		dev_err(dev, "couldn't get otg irq\n");
-		return cdns->otg_irq;
-	}
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
 	if (!res) {
 		dev_err(dev, "couldn't get otg resource\n");
-- 
2.17.1

