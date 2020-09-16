Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92FA26C80A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgIPSjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:39:40 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:1812 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728015AbgIPS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:56 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GIOmAc012341;
        Wed, 16 Sep 2020 11:28:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=k5CyeKK1LO175XLeQn/Az7M0PHRsao6MTfxoI7W6IS0=;
 b=b8DFNDjKbRsHbhW0R2abD9M/X1stoczMRN20Ss0HC73jH2ciqZrrW0HSISpjvnye7dHu
 fYxTfnPR0CmE0r2r935/fJBtAJbJiGKmgC4CxmvWlQvmiPzqPqUYHPwJPooTaH5/6n6e
 jqpPwlc6KXXsP5fWIyU/Rpq5WuLXwGcMKm26i1nyD2AX1Y9yfjTcUHi+wlkmq0am25MQ
 zr2BhJSuJqAphw0jR25Un6gby1oqq+LACLN6QZ9gFqwglno25kQMQfQnR2tth6MXOpBa
 CuNckhrkM/A3rR9W97JCXj2ZiwZ+IB2YHqal2oRkrjwq/9bCGZ3UCqixoD6+QJpe09wq Jg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njvbhd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 11:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWVQbYgTSEWErIvWgRQQWLHGWGjRZoVNXtmTzD5QTWhLxFmg8qsnGrmEmc5teHVozGx76pgJ5hd2XlFTk7WiAxUiksrR1QjX4OflHGW3/D4AY+pEC2ZOwW1Bys4GnBDogJLYfy/s25lI00ei61nk/F8la9QBzGe86Seepz9ltYIS/FY/DdBiM6/wWQHNfeDvVkTwU76BIhycEBV1ln7bHbagPmR2rvM8r+prc0ILPNye3bzvBboXxWw4cEGv2Hnwe+Lqbs1CqLbCexmjdz+zyZ2YeT3Za4smgQRNiu+4Ncb/Msf7z396MCDPxN60Um1slS6jDFOKmVDB/YdE4aHJ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5CyeKK1LO175XLeQn/Az7M0PHRsao6MTfxoI7W6IS0=;
 b=UYf9UAke8+SCGZreBlvqSJBVF50VI1J9saHEV/wtKu74I+nMjMdappjhIQdtNeoHviG5TuQHIUZEZatUHtNNc5/HGvwAkMay2VMHwNroZeJYYasj1+dxLgeymfxPQRvfONl5taMFt38RgIqettylUnz1oVZgNv/EfB4ZiyFohwOT2uBTXTKlaDgKSDjQG+sLIfGX9x4UiKemm/j7aaLGFIN8hW2T/3uxdz/Sh7bjUI22xhoO1s74lOWYGW/bVivicYZz5rWt1+HwKLFEoJ4GoI/YLHs8jBow45/xWJmF1h3JyQ82wviuThk9NFTSKn+l+Qo/Cwg4b+V41NmWJyPNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5CyeKK1LO175XLeQn/Az7M0PHRsao6MTfxoI7W6IS0=;
 b=RpubeqMRpxg4+ruUISJ1qcN5Q/z22TBa1wzOFkGj6yvWB6dgxz/GbraM70GGFEE5SH8348TsNzYtO6JdahS6oj5oXFUMzd6u0YhycG3MHRj48I1ft45Fs0TcIE8zZ5RWLk33Y3f0rf4r6SdSVIlsz1A25714x0qwrh5Gq7Cg+zI=
Received: from BN6PR21CA0018.namprd21.prod.outlook.com (2603:10b6:404:8e::28)
 by CY4PR07MB3078.namprd07.prod.outlook.com (2603:10b6:903:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 18:28:36 +0000
Received: from BN8NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:8e:cafe::a1) by BN6PR21CA0018.outlook.office365.com
 (2603:10b6:404:8e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.1 via Frontend
 Transport; Wed, 16 Sep 2020 18:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT058.mail.protection.outlook.com (10.13.182.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 18:28:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISXhN016248
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 16 Sep 2020 11:28:34 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISWr2009261;
        Wed, 16 Sep 2020 20:28:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08GISWgm009260;
        Wed, 16 Sep 2020 20:28:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 2/7] phy: cadence-torrent: Use devm_platform_ioremap_resource() to get reg addresses
Date:   Wed, 16 Sep 2020 20:28:26 +0200
Message-ID: <1600280911-9214-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
References: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ffb03e3-41ca-4840-822b-08d85a6e52c0
X-MS-TrafficTypeDiagnostic: CY4PR07MB3078:
X-Microsoft-Antispam-PRVS: <CY4PR07MB307870FA0883632086F10CE5C5210@CY4PR07MB3078.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S4U3Yai9ZPEycl2WDchnn69z74oOIy0lhrEyozCjV8ppUD/6XbOht97/Z2smHNSEjPClO8HK9N6rPqHhJRYHSG0xjORYMQZf089O56Ww0zNUAunAPvUwdQIHfoe2uRxg1uLJo90nku2sIsHUZ2NGnUBOC2oTk0LuzUImnrnoEsG4fIg2UhWS04VvMJB0v44GP4IR8B920AoCaXzy4wV1S7y3nQxPFeNKiJmNKYAVeagFNVKdApTJ6VqPgbEagL0yoiq42bda+KkzC26eUTIyK2gozTBuPsBlQvhXyVBXchqY8z4yM7lffqs/DBy9pnlfLmg8THBnHwe/w4W98FqqeAcmU9H7i8MVl+yQmttNC2vzVRDxV3m60/syxEH1Pnvu52c80AfqD8Ta6wJNJX04mbowaurmA2nL9o7Nw9yIRqQ=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39850400004)(346002)(36092001)(46966005)(70586007)(70206006)(186003)(316002)(4326008)(2616005)(7636003)(82740400003)(6666004)(5660300002)(47076004)(356005)(110136005)(42186006)(336012)(36906005)(83380400001)(2906002)(86362001)(26005)(8676002)(82310400003)(426003)(478600001)(8936002)(36756003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:28:35.2816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffb03e3-41ca-4840-822b-08d85a6e52c0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT058.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3078
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=830 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_platform_ioremap_resource() to get register addresses instead of
boilerplate code.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 0211083a4d09..bd8656dfc919 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1705,7 +1705,6 @@ static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
 
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
-	struct resource *regs;
 	struct cdns_torrent_phy *cdns_phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
@@ -1739,8 +1738,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_phy->clk);
 	}
 
-	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	cdns_phy->sd_base = devm_ioremap_resource(&pdev->dev, regs);
+	cdns_phy->sd_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(cdns_phy->sd_base))
 		return PTR_ERR(cdns_phy->sd_base);
 
@@ -1830,9 +1828,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			}
 
 			/* DPTX registers */
-			regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-			cdns_phy->base = devm_ioremap_resource(&pdev->dev,
-							       regs);
+			cdns_phy->base = devm_platform_ioremap_resource(pdev, 1);
 			if (IS_ERR(cdns_phy->base)) {
 				ret = PTR_ERR(cdns_phy->base);
 				goto put_child;
-- 
2.26.1

