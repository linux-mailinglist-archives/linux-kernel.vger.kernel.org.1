Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C460626D68C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIQI22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:28:28 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31880 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726489AbgIQI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:28:08 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7SkfJ008571;
        Thu, 17 Sep 2020 00:30:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=C8lZJ1Cha7Cb0wiYNOREsm6vquHw6qwRCnPKgby+j8E=;
 b=LuLqLtKv+aWxchmYq+qHDY9u3J3+KekAEiGvUWukKo4h3FFyjBTPAWNU3PQQWN3z8HAA
 4J52+UlvkJx7qt8lXxr9JsyeUntLQd6fErvLIGT2qlgIPYs8qTlTAS6ivbFxhVPFFoia
 5RhobKaqxGT36a+1oYIlkidITcMoTOmMgvtHjfNHbM63WGNfvp7QMd3bAtfgpfNAdNKS
 Zg6VzFf7N+byzJd3SkUov3k4/qJ9k2Z9TEFt3ba0TPUafLzAACT6Bph+cDdeaTgjFPmo
 /ig/gmzszYNPCjCUQmF2aI2uOPLZGlPUIAutwl2MOeKwjeL6sLRn+4YeUyijZ6QWBuZw fQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njxkpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKMVwgLk64PDKxFulnnSHFXFN//6FgItDMhELXaN0Qdybi8PEsgmcw54ukKQi1mqdMSy8eCQGAQbdoBdYJiRsqXx2mG5aEcpxpUHUj3y4GuZ9ZWoYEnXq1xCHwAXB0mLZpFr84H07EqlcJbVlqYbWi82smsh1SQAxfkWQIriWCUx43cg3E1albZg0qCdNvB+c+u8ciYnZWoYvFelaaIuCfUOFer/KyXmx2AZrVKhwVvAK0FosItwT171hdYxOyjU0JcgoyJlAaDnZph7wSfSgGL8McAF0uPv9sOLHGeHbXE4S8CRwf4pTuECEb4tCsRfDJGHiJZtJ2/mE7jtqUYGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8lZJ1Cha7Cb0wiYNOREsm6vquHw6qwRCnPKgby+j8E=;
 b=DC7bBEaq1wi9fy+3D4dTyrzEeuXI1RxvCQsY3WObLyKJHqLKo/i7SgNB6a8YyRVXH5uL+ozBbXHKv1ZrIc2rIBYc1mEA1BmEv9LZcJ1+oNkK0Ze+UWEaF2wB3Lg6OULNICeaiMpyWILCp87nBYzxJ9sXDrdW0L9oQCPgraU5+YZytXYfcCq9+kE+d9Z1/DDK/CeROd8/N038LIpBWsr7ywPeoalzUtehvM2miVpX251poZ8fNtE/lTnxvmylu87Od9Uxe789LsUjxknxQ/d3HrG0E+EAwW19Bq04vCE3Kg1EB01tNWs89njcaDHcoSolCqMl7jzXkzDJD+bdhXpMQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8lZJ1Cha7Cb0wiYNOREsm6vquHw6qwRCnPKgby+j8E=;
 b=UMIxiJ1k5HHhzDXmKM4ZLSldjso8pdUmddgjlpLc4Rs4f5ORNvyC8Y7pcMrewjK9iaQ8trEihB6a9JxALJQu7pDrVAHN2HawtIpDCDi7m1+tR2e2GgFMb/CxbV8Ry8zrL8tyiFcsR7ggbjK4Y68i/wNpihJe35JaymMPs5+l1CE=
Received: from DM6PR11CA0029.namprd11.prod.outlook.com (2603:10b6:5:190::42)
 by BL0PR07MB3892.namprd07.prod.outlook.com (2603:10b6:207:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 07:30:51 +0000
Received: from DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::23) by DM6PR11CA0029.outlook.office365.com
 (2603:10b6:5:190::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT067.mail.protection.outlook.com (10.13.179.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 07:30:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHS011305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 03:30:49 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:30:48 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:30:48 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7Ulpd009785;
        Thu, 17 Sep 2020 09:30:47 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7UlV7009784;
        Thu, 17 Sep 2020 09:30:47 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 03/13] phy: cadence-torrent: Add PHY APB reset support
Date:   Thu, 17 Sep 2020 09:30:36 +0200
Message-ID: <1600327846-9733-4-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b58439cb-5f16-47c5-9df6-08d85adb9a44
X-MS-TrafficTypeDiagnostic: BL0PR07MB3892:
X-Microsoft-Antispam-PRVS: <BL0PR07MB38926A8CD87FC682CD8C5516C53E0@BL0PR07MB3892.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLFxL/g892HoRaTYe9m8WFmTJ0ZWbZs7oaNa1dE17wjzpLWsPecHfEb3f1pZMJbXTFh6szcwlVKYyWKbHrQc2VwFNcwicob3NjL+nol6VepvusPxRE2EihvCjJsVaxG9fr7W3M09U12UqfHMcWNUxU0JPlXZ/zzBF/W60bf4c6C6eyf9og1usnRyhBSrDlmIHh0eADKGBKfvBPuET54agXVA4eDr7d3rHqm3ynHIKz7sGec1bSSAzD8+I5v90q6FDAdSPsTP8R3c1JwHiyIQypKy5rpIdAwizdNx8NrtENbyPuZcbEmI8W/34h/ixdw7BL9qTMO1Wn0P16SP5Ykqbl+jBdIzr3BGrl/CondDb2eYjIM5Dco4A2ZK9POv1/SPpS3zaJ571TPK5De6GZFRFV0k0haMBCfDQOK23bbtv/cTnJ1ux9P3+DrHeat1OuCnrvH7pYMBino8vSg6xs3F1m3HAo5kC5Nj1z4MZvbZKnI=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36092001)(46966005)(70586007)(82740400003)(36756003)(186003)(26005)(316002)(70206006)(42186006)(36906005)(6666004)(336012)(54906003)(4326008)(110136005)(2616005)(426003)(478600001)(8936002)(356005)(83380400001)(47076004)(81166007)(82310400003)(8676002)(2906002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:50.4741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b58439cb-5f16-47c5-9df6-08d85adb9a44
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT067.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB3892
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=890 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PHY APB reset and make it optional.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 9e900f389b08..1d0c9bb7cfa0 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -228,6 +228,7 @@ struct cdns_torrent_phy {
 	void __iomem *sd_base; /* SD0801 registers base */
 	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
 	struct reset_control *phy_rst;
+	struct reset_control *apb_rst;
 	struct device *dev;
 	struct clk *clk;
 	unsigned long ref_clk_rate;
@@ -1883,6 +1884,13 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_phy->phy_rst);
 	}
 
+	cdns_phy->apb_rst = devm_reset_control_get_optional(dev, "torrent_apb");
+	if (IS_ERR(cdns_phy->apb_rst)) {
+		dev_err(dev, "%s: failed to get apb reset\n",
+			dev->of_node->full_name);
+		return PTR_ERR(cdns_phy->apb_rst);
+	}
+
 	cdns_phy->clk = devm_clk_get(dev, "refclk");
 	if (IS_ERR(cdns_phy->clk)) {
 		dev_err(dev, "phy ref clock not found\n");
@@ -1907,6 +1915,9 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Enable APB */
+	reset_control_deassert(cdns_phy->apb_rst);
+
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct phy *gphy;
 
@@ -2059,6 +2070,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	for (i = 0; i < node; i++)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	of_node_put(child);
+	reset_control_assert(cdns_phy->apb_rst);
 	return ret;
 }
 
@@ -2068,6 +2080,7 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	int i;
 
 	reset_control_assert(cdns_phy->phy_rst);
+	reset_control_assert(cdns_phy->apb_rst);
 	for (i = 0; i < cdns_phy->nsubnodes; i++) {
 		reset_control_assert(cdns_phy->phys[i].lnk_rst);
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
-- 
2.26.1

