Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEA828EC77
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 06:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgJOEza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 00:55:30 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:25844 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725208AbgJOEza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 00:55:30 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09F4sQZU027791;
        Wed, 14 Oct 2020 21:55:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=xT82cz/DrRg1LaRbUL0mHzsXSL/tgwkB2ZKN74Sf89g=;
 b=bSlCqvNyyyVId2LeKucjth6Xpuezie1hfElG2uLIPtPcSM9PvP1NKqZcj/Zm4Q8+noIk
 +anGRfQ+kohmEnHQdFc2uB9TsroGRRgqwgIrkXBqjQJ3/i185CCwE2iri8U3Yi1lXT4R
 Tpf+h5KIeMbuXYxe8LA9z6250rbWno1V7uTYNBi1lIyVB0elHAand+OWfEoa/B/Nar/i
 Dqz6AfqHT5dvOwrmpJiUSXThIzprYc0MLzeA2PmEyqK6caBfzf++swDZgy653sZ9Cgqk
 LJxfo4FuB6jpTJ/6yRfx7ICn2SMG32zqI67DCMVymClY78Jz6wYPyGW6GfebE9kfWc8D Gg== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3438hxawcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Oct 2020 21:55:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNy7SKcAypaWlu4kDYJG24qZhurBxm8btoQ2AjxkgFMlUzQ+60BgJWctFBm0Cy5d+IvwUBuS5Byw068rHASukNu4t5XKtPsXvFvq00hAwlsTX/O9UsUM93ajj2+RuQ728KfHKYksiWqeQrxbym1pu5aNxhOkfpjKEHjDIqEiKuzNVW4jT+0QL+dvt+VNtYCk1OG62zUEOaqXfh9r1zIrwfXIXyEhY5AGR14ayaUJgkUUEcGs1+u2PWsmBKSfmV4FR995I1GO8Qtl04CzB0b1ZuRXGQJHAQCVRKgVlUNNyAoVrN31k/zuKqp/78txcYTQXAnReFuLofBcAd8w5RFdtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT82cz/DrRg1LaRbUL0mHzsXSL/tgwkB2ZKN74Sf89g=;
 b=YXGtIshjnYlT0JwY0LQ9nqzXjenJy1xRxPkcV1tCGMNiU0eqlyweLUE8+rCmfPDnlGhNHLM9wGkRIZ1Xr+qzGPqAWwCnLPNv7PbVlJr2Qhbf4vWYuZdL39QVHyiOo1Gm47R8kgj4SsGlHhyaw7C0KIjGnEJqXLz440mU3yN7zsddJ7L1ZW7xemRoekaJNttYU/NXL8s7M7dvQpa52FySAse06rVwmzcGZemUCUklyQUxMRSVYEZ09wynHfNq37dB+jropel05DLh0103B8ptdb0KuIvtyfJxGyKVGY9SgawmKqCwqbsfFXHY7GFCiKa9oy/DFUUL53m6pskaCGXjUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xT82cz/DrRg1LaRbUL0mHzsXSL/tgwkB2ZKN74Sf89g=;
 b=YWCRzjTYBHcwt7g1yV500/bbK6A4cJymvL671DTVnfN3MFI31+zkWFKHx5AlAXaOca+K86wzTf8hCvrfp7Q6PII2Ebh1xQRdFG8Yo9MWSo2b93mDC0ONgmBtW14eAgm5UsHp0JT6MB+EaS/BGsKeMdxf/+uDcZBGGfs8HdrteSU=
Received: from BN3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:400::27) by
 BN6PR07MB2756.namprd07.prod.outlook.com (2603:10b6:404:41::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.23; Thu, 15 Oct 2020 04:55:19 +0000
Received: from BN8NAM12FT009.eop-nam12.prod.protection.outlook.com
 (2603:10b6:400:0:cafe::6f) by BN3PR05CA0017.outlook.office365.com
 (2603:10b6:400::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.13 via Frontend
 Transport; Thu, 15 Oct 2020 04:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT009.mail.protection.outlook.com (10.13.182.242) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.7 via Frontend Transport; Thu, 15 Oct 2020 04:55:19 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 09F4tHG0015937
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 15 Oct 2020 00:55:18 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 15 Oct 2020 06:55:16 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 15 Oct 2020 06:55:16 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 09F4tGfj002015;
        Thu, 15 Oct 2020 06:55:16 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 09F4tGON002014;
        Thu, 15 Oct 2020 06:55:16 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <balbi@kernel.org>, <rogerq@ti.com>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kurahul@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4] usb: cdns3: Rids of duplicate error message
Date:   Thu, 15 Oct 2020 06:54:47 +0200
Message-ID: <20201015045447.1440-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bdbf763-266b-4c1a-5a79-08d870c683ed
X-MS-TrafficTypeDiagnostic: BN6PR07MB2756:
X-Microsoft-Antispam-PRVS: <BN6PR07MB2756696CA757730560AB52EEDD020@BN6PR07MB2756.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1aGsmUoFXYtCzJFDVpK7ZGCDZ51E1z5lVh/Hugk9WVHqEQMcOUFZhlsgPnv/KDDmXeuQFKlCr/eVBAspiey8EKzd8uJipePyrdakvZ8Vw7/tOvp9GI7MTZhwCci0c+EFrxP1V7PAoa4xsn8lSy7DX+89W6OS73vDkcYHBl4jYiHVYhYDMLLwEA6Ixu/MGzFj+2dV0P3A4kSpg23sKnPbxFVG1srJB1HR3YlD1AL+WF7jBE6AIocmK0WNqZZ5fqmRxwrwV+D9GBjNCNgd5GnxEesT9BmytKPdURPCBQVCSBV8uxtBW0ytL1cWKkaSRJY5GA+uWy3eRlYIM8XfF92hn1ktc/aEdmkYj++mL5a4nNdokMbsyZu6Nn59i/s4p7im7HM5bzkoQYNeKTMIlKUjrYMa3oCNSlWJ+WmHlcW1Qsq0bjRbztFu5GXE7fjQ2B0LfQSVhljlBK3EbtA8L2w8JQ==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36092001)(46966005)(15650500001)(26005)(6916009)(36756003)(2906002)(6666004)(478600001)(4326008)(70586007)(70206006)(82310400003)(47076004)(356005)(82740400003)(34020700004)(83380400001)(81166007)(107886003)(86362001)(8936002)(8676002)(42186006)(1076003)(316002)(36906005)(54906003)(426003)(2616005)(5660300002)(186003)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2020 04:55:19.1881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdbf763-266b-4c1a-5a79-08d870c683ed
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT009.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2756
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-15_01:2020-10-14,2020-10-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=1 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0
 mlxlogscore=949 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010150035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On failure, the platform_get_irq_byname prints an error message,
so patch removes error message related to this function from
core.c file.

A change was suggested during reviewing CDNSP driver by Chunfeng Yun.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Peter Chen <peter.chen@nxp.com>
---
Changelog:
v4
- fixed typo.
- "Acked-by" tag has been added.
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

