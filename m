Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2663427E1ED
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 08:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgI3G6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 02:58:47 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:34636 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgI3G6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 02:58:47 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08U6ePvV008865;
        Tue, 29 Sep 2020 23:58:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=GcHUWKnkocUYYLM9Ab6mSJtqJ5faAkc/4ctx2NK6Mto=;
 b=DhxfTmn8lePePDUJOBYCCdLhIxIRMFLDRYnxLnnl8F1NHvP1HgGGGKcJ2cxh51kM48d3
 zfAFBGrOK8/KroMW1F2pIE2z0OONe+2BkImACFcIw8aAFsuoWKriunsAr1t1VvnmGzJB
 Tc1E2N9Ec622hwt9AG/+CHMx9qH/1x+/aUyQtoeT81KXUUuvLWdUrYadj8/RVAL/dZh9
 99fBuczO+fjd8mhWsRgLMAczXHMqJhG41HDyo624sO1dW9FQh/hVL37nwmZhSOjzLTjZ
 s7eXvfgYW+7k2F+NrXUoBBmuxv6RwtBJFnA/TWxFRukSwALsvNxyFX0qm9HxVqJW1m5a /g== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33t17x5tfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 23:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPbi6W437paFFTTszIhUj5rB15rWX5VZjmNvxYVbmoR9kEKZGso2YjCEBNQVb2U4T98QnVOtvq8qt/joYqJT/zkE1ouyqWhJ0neEY5TbcR+Qp35oYV5ZTZd15OqhU2aYC5dtnNLSs50YGcLABwjyLvFGkc2j1EK+KMDbYvzQOipgfGnZOp3dgmeMp0JM8kmBAIZMYVgxV8KzGIDN7ndDQVbhyASlUrUtFOmNvCTTWxYvwIBylBHiD6EVurJRFnKmLXjZpWKVYyooBnXQh5wmQloSm5mQsH20Yg/FmbEcCzxZR2rG0vdc/hRc/v+dvWnaNPYppsvcVudNhTt+ZwIkOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcHUWKnkocUYYLM9Ab6mSJtqJ5faAkc/4ctx2NK6Mto=;
 b=gLTXOxKhjxcZnnZdrYmp2qP4661ojE6J6hFm0s+NPusoz++7n8CuafrmcB8bZeBh0ZpRWxTYjZfrHf7zb/pwigxB6evdHY1uqXzGbj4WBx+yBXT6r0I34nicOsB+qe+563IF7T2bVsxYfD1hEF+aAakT10WZrOviabjKIp1kaq2ZSrMFpFuuAT3jtg1N1RSjZ96ch1h/9zh9yvFBHOzI3GbhtUnUHDNwJfm4d1JesuPcm0OyMbfNgPobmpPrsaIyRBpkjuQ9vZ4YA32vuglXM4kyBLfnJFToaOZypyQnNQEhBNIDuTRp9MLQUXeXWgBmeeCgzpLg/nGpfAEnjxzyPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GcHUWKnkocUYYLM9Ab6mSJtqJ5faAkc/4ctx2NK6Mto=;
 b=fgJWp5W0qBfLSi4y5iu3aCbZG5D0Ic0H3Rld3mWFGhjsP9m51zvJcsumKO4H+tce1/gRfsDeO3EsCmLDEf+GieBvcPD1G2iQGN7YPcquGSZQ+u6bmFU0SFbvsjaDbMi9MxZBlGmP4vjAtBVnsvF//Qlc2qDrEzCVlwjPHydQUvM=
Received: from DM5PR06CA0091.namprd06.prod.outlook.com (2603:10b6:3:4::29) by
 CY4PR0701MB3780.namprd07.prod.outlook.com (2603:10b6:910:8f::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.28; Wed, 30 Sep
 2020 06:58:39 +0000
Received: from DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::e1) by DM5PR06CA0091.outlook.office365.com
 (2603:10b6:3:4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend
 Transport; Wed, 30 Sep 2020 06:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT006.mail.protection.outlook.com (10.13.178.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.14 via Frontend Transport; Wed, 30 Sep 2020 06:58:39 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08U6wbhS021304
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 30 Sep 2020 02:58:37 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 30 Sep 2020 08:58:36 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 30 Sep 2020 08:58:36 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08U6waTv024457;
        Wed, 30 Sep 2020 08:58:36 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08U6wads024456;
        Wed, 30 Sep 2020 08:58:36 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>
CC:     <peter.chen@nxp.org>, <pawell@cadence.com>, <rogerq@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>
Subject: [PATCH] usb: cdns3: platform_get_irq_byname_optional instead platform_get_irq_byname
Date:   Wed, 30 Sep 2020 08:57:58 +0200
Message-ID: <20200930065758.23740-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc1c162d-35f2-4af9-f42c-08d8650e42a8
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3780:
X-Microsoft-Antispam-PRVS: <CY4PR0701MB37808BA947244EC7D5957B34DD330@CY4PR0701MB3780.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:235;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZKQP0WdxUPSOGn/0NNV3O5InprYXFCBjFjGWo6SlpjKv9cxWQxGO99/9j2J4fNsWSLXsk2Oi3t7FCQfsjMrGXCL8zOu4o6Kqj8oNpur/Al/fUm/ebM1PAjyw41SwYcCKaVuR2/+YdyVDuJNAuJMssmem3gecRRVepIb0vdS98GxOQIk/QlodDzoDTnNWSoFg7nhwWH0JQKfRUQ/3weQfAqIl+WJtlq4BpAROXe/lml6hvBvoYfuWWu02c35ai0sCZTQAsPTZpCxUdQNyUqMaUQEvDLp0ElNJeiYQYwqxnyd/j+qCaemSe/CNv9DDh6GQnpOqvSv5FW796TweSXlqnr0n0qt4IvpmPPaJA5WAu/foy4NFjtWc14zJNzU0kq2YV5SPdlB+awuVN50g5wir/NXwec1BLlOM73cYb7HNRidQthrR4URBdcVxgbrmTsAK/phjOWTcPn+pUrjtMIowBOtdeXfigJDIEypduHIrjKo=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39850400004)(396003)(36092001)(46966005)(5660300002)(47076004)(70586007)(70206006)(86362001)(356005)(83380400001)(82740400003)(82310400003)(1076003)(81166007)(4326008)(42186006)(186003)(6916009)(36756003)(478600001)(6666004)(316002)(54906003)(36906005)(336012)(2906002)(426003)(2616005)(107886003)(8936002)(26005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2020 06:58:39.4352
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1c162d-35f2-4af9-f42c-08d8650e42a8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3780
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_03:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 adultscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=408 clxscore=1011
 suspectscore=1 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009300053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid duplicate error information patch replaces platform_get_irq_byname
into platform_get_irq_byname_optional.

A change was suggested during reviewing CDNSP driver by Chunfeng Yun.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index a0f73d4711ae..a3f6dc44cf3a 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -465,7 +465,7 @@ static int cdns3_probe(struct platform_device *pdev)
 
 	cdns->xhci_res[1] = *res;
 
-	cdns->dev_irq = platform_get_irq_byname(pdev, "peripheral");
+	cdns->dev_irq = platform_get_irq_byname_optional(pdev, "peripheral");
 	if (cdns->dev_irq == -EPROBE_DEFER)
 		return cdns->dev_irq;
 
@@ -477,7 +477,7 @@ static int cdns3_probe(struct platform_device *pdev)
 		return PTR_ERR(regs);
 	cdns->dev_regs	= regs;
 
-	cdns->otg_irq = platform_get_irq_byname(pdev, "otg");
+	cdns->otg_irq = platform_get_irq_byname_optional(pdev, "otg");
 	if (cdns->otg_irq == -EPROBE_DEFER)
 		return cdns->otg_irq;
 
-- 
2.17.1

