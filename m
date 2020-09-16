Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCBDD26C80E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgIPSjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:39:54 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:13660 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728024AbgIPS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:55 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GIOjZX012142;
        Wed, 16 Sep 2020 11:28:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=B3Y33UgGF1jdEQPjcTpfDXCr3bQzLJB38Lys5td0FZU=;
 b=kXZqLkC6Xf+thA1FWzWDHbDRtpzytwgwx1IgyGDq4qHaQJKf/NLQCyH2EyIl2FNR2qvd
 JVqfiq8rqkHFC1WTC1beyiWb8Pi45mzv+IV7rI7dvQloIPqAsANUIP9XWpc0eQS2a5n7
 M4kgHRvR5/Ic5zbGnh/SxF3nt8a5CdPOk1eg9qv5Tc7A0R1uxR6zkNfto9eOjg3ZBsaY
 xH/tv7dMiS4LEXGRvAe28n21nmOIiNJ0+Eukcfrg3kyykZXLvIoEnPsEi6FVTe55Cu6Q
 dtBCfWhr7uXavnPO++kfSWlRTA+t4+x8jR+QA8HvqK5rQv1JYfX/Incb3d/v9qS4+lih Xg== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njvbhg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 11:28:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLLtEs0qEdXXmWgR7F2w3GbykaH8ma0dlUfjv1+ebnb+Qgr/jDESQtDU8xHKfy6Z/aRWxOQXDt+mse3w8qzpyufpYqATrs9MSoe7MKsLMjpwt665v28O17HejephYNCGFuaKDJO89/2YWHT2V1BMFTbwTekOKm8hJqbh6Sihy3YtShAKJl/+Q3yg99Hw+ym9MTJG145bibkA1JTHPrheIGyrfqm8k1Eq4BgK/B5Djtv1ZeOCtq6eQBRBQD8YZPd1Di6eUKeYjqUc3Jb8bCvJ+N66Y61uwGcLoVw0Yxf80QbTPRNq1X8inQ/APSsAm8AfQ3MlsNGtHER3K2XOjwgEaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3Y33UgGF1jdEQPjcTpfDXCr3bQzLJB38Lys5td0FZU=;
 b=YaHj9g0rxPXdTJubVRoqYVGaesYclz/u5TAlmGVOS/whhmjJndj4/fMANVzLC2ORv14AEo/roKlzu8M8HQGWi3Da5oKIyK+pGrdKTUrkqSCWR6B6nMmSpQxtGPU1mDVoOish1meJGV39xQam8UG3Hz0FQp/Tn7/yjNcObgNsJTYs50k2qp/slBjD9DOXKpWtu5NmGOUkqzlxSnGRcZxwKcC4WaedWgyJy+AG6Gmqb23qiHMuvy9mQcR+JhmjMATgdgaRuNgOt1YbQOxg2GIuGXJ1HKJ923C1YeQUEN52QBMDMF/LbwMEKXDKmoSACoacIEarfYIkKH1y7pasdAcCqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3Y33UgGF1jdEQPjcTpfDXCr3bQzLJB38Lys5td0FZU=;
 b=ZUayrBCJ6N+WReXdZJOOOWrz48FVuNaNu/Evu3lprHOpkOzQ5nIYBkg03Dem5fnuwscjaCI5iVZzR3haVLUQMjN8XBPI88vhNKtkMyGKaHdJHgXyGR/ZmaXrgv3E+bGQVK5V85hvbLWRJHcB9YPsCxCNq2CrAKxqf1JsG2oe6bY=
Received: from BN6PR11CA0008.namprd11.prod.outlook.com (2603:10b6:405:2::18)
 by DM5PR07MB2859.namprd07.prod.outlook.com (2603:10b6:3:9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Wed, 16 Sep 2020 18:28:38 +0000
Received: from BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::75) by BN6PR11CA0008.outlook.office365.com
 (2603:10b6:405:2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 18:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT010.mail.protection.outlook.com (10.13.182.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 18:28:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISXhS016248
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 16 Sep 2020 11:28:36 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISW3e009270;
        Wed, 16 Sep 2020 20:28:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08GISWmU009269;
        Wed, 16 Sep 2020 20:28:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 4/7] phy: cadence-torrent: Add separate regmap functions for torrent and DP
Date:   Wed, 16 Sep 2020 20:28:28 +0200
Message-ID: <1600280911-9214-5-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
References: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94473acf-afac-44c1-cce0-08d85a6e5444
X-MS-TrafficTypeDiagnostic: DM5PR07MB2859:
X-Microsoft-Antispam-PRVS: <DM5PR07MB28593160339067D7B0414142C5210@DM5PR07MB2859.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:121;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pgr0tZ7mypJw2Brbq7bWXMuh8AEKl0HGYvf3fmavbkpBJwwtoAntTIYm6JEswVqGdvwRdfYJclEDwQorZjCysk7DCxrshzhQWFzs+akhqvO8VpDg+l5Xilr49svSocSNP5acHZp1nKxotlTaoPzX03IVVJ5OsEfksecF1j/oW2OXQfxlAEJEWiDwfTBjrnLhSITa8P2aBeuK6UhzRc3J6NzcEywHhSoEcCqu2xxHXrBTtE0whl4/UAnMwQxTrjm2JWQcAr5T8Wc5SBn+92/+tVqq+i0W6Lhh518WBRX41/niGvhgYrQN5kNV4yzMaLwc+D+fM1iGsO/ogDVxEb2tNY9XTa0fyFUlbY5c3X7x6eZUJvGQS6Hn6HxUOHcPuncFkM48lIDoFhPcyk/eHTKJW/D4mRQI2C55H/vhwnUGs1E=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(376002)(36092001)(46966005)(7636003)(2616005)(6666004)(356005)(82310400003)(26005)(83380400001)(478600001)(82740400003)(336012)(110136005)(426003)(42186006)(8936002)(47076004)(316002)(36906005)(4326008)(54906003)(70586007)(186003)(86362001)(5660300002)(36756003)(70206006)(8676002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:28:37.8253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94473acf-afac-44c1-cce0-08d85a6e5444
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2859
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added separate functions for regmap initialization of torrent PHY
generic registers and DP specific registers.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 99 +++++++++++++++--------
 1 file changed, 66 insertions(+), 33 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 966aeec8ec06..9dba7ba33fcd 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1584,7 +1584,24 @@ static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 	return devm_regmap_init(dev, NULL, ctx, config);
 }
 
-static int cdns_regfield_init(struct cdns_torrent_phy *cdns_phy)
+static int cdns_torrent_dp_regfield_init(struct cdns_torrent_phy *cdns_phy)
+{
+	struct device *dev = cdns_phy->dev;
+	struct regmap_field *field;
+	struct regmap *regmap;
+
+	regmap = cdns_phy->regmap_dptx_phy_reg;
+	field = devm_regmap_field_alloc(dev, regmap, phy_reset_ctrl);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_RESET reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_reset_ctrl = field;
+
+	return 0;
+}
+
+static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 {
 	struct device *dev = cdns_phy->dev;
 	struct regmap_field *field;
@@ -1614,28 +1631,44 @@ static int cdns_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pma_pll_raw_ctrl = field;
 
-	regmap = cdns_phy->regmap_dptx_phy_reg;
-	field = devm_regmap_field_alloc(dev, regmap, phy_reset_ctrl);
-	if (IS_ERR(field)) {
-		dev_err(dev, "PHY_RESET reg field init failed\n");
-		return PTR_ERR(field);
+	return 0;
+}
+
+static int cdns_torrent_dp_regmap_init(struct cdns_torrent_phy *cdns_phy)
+{
+	void __iomem *base = cdns_phy->base;
+	struct device *dev = cdns_phy->dev;
+	struct regmap *regmap;
+	u8 reg_offset_shift;
+	u32 block_offset;
+
+	reg_offset_shift = cdns_phy->init_data->reg_offset_shift;
+
+	block_offset = TORRENT_DPTX_PHY_OFFSET;
+	regmap = cdns_regmap_init(dev, base, block_offset,
+				  reg_offset_shift,
+				  &cdns_torrent_dptx_phy_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init DPTX PHY regmap\n");
+		return PTR_ERR(regmap);
 	}
-	cdns_phy->phy_reset_ctrl = field;
+	cdns_phy->regmap_dptx_phy_reg = regmap;
 
 	return 0;
 }
 
-static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
-				       void __iomem *sd_base,
-				       void __iomem *base,
-				       u8 block_offset_shift,
-				       u8 reg_offset_shift)
+static int cdns_torrent_regmap_init(struct cdns_torrent_phy *cdns_phy)
 {
+	void __iomem *sd_base = cdns_phy->sd_base;
+	u8 block_offset_shift, reg_offset_shift;
 	struct device *dev = cdns_phy->dev;
 	struct regmap *regmap;
 	u32 block_offset;
 	int i;
 
+	block_offset_shift = cdns_phy->init_data->block_offset_shift;
+	reg_offset_shift = cdns_phy->init_data->reg_offset_shift;
+
 	for (i = 0; i < MAX_NUM_LANES; i++) {
 		block_offset = TORRENT_TX_LANE_CDB_OFFSET(i, block_offset_shift,
 							  reg_offset_shift);
@@ -1690,16 +1723,6 @@ static int cdns_regmap_init_torrent_dp(struct cdns_torrent_phy *cdns_phy,
 	}
 	cdns_phy->regmap_phy_pma_common_cdb = regmap;
 
-	block_offset = TORRENT_DPTX_PHY_OFFSET;
-	regmap = cdns_regmap_init(dev, base, block_offset,
-				  reg_offset_shift,
-				  &cdns_torrent_dptx_phy_config);
-	if (IS_ERR(regmap)) {
-		dev_err(dev, "Failed to init DPTX PHY regmap\n");
-		return PTR_ERR(regmap);
-	}
-	cdns_phy->regmap_dptx_phy_reg = regmap;
-
 	return 0;
 }
 
@@ -1711,6 +1734,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	const struct cdns_torrent_data *data;
 	struct device_node *child;
 	int ret, subnodes, node = 0, i;
+	u8 init_dp_regmap = 0;
 
 	/* Get init data for this PHY */
 	data = of_device_get_match_data(dev);
@@ -1748,6 +1772,14 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	ret = cdns_torrent_regmap_init(cdns_phy);
+	if (ret)
+		return ret;
+
+	ret = cdns_torrent_regfield_init(cdns_phy);
+	if (ret)
+		return ret;
+
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct phy *gphy;
 
@@ -1830,6 +1862,18 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 				goto put_child;
 			}
 
+			if (!init_dp_regmap) {
+				ret = cdns_torrent_dp_regmap_init(cdns_phy);
+				if (ret)
+					goto put_child;
+
+				ret = cdns_torrent_dp_regfield_init(cdns_phy);
+				if (ret)
+					goto put_child;
+
+				init_dp_regmap++;
+			}
+
 			dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
 				 cdns_phy->phys[node].num_lanes,
 				 cdns_phy->max_bit_rate / 1000,
@@ -1846,17 +1890,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	}
 	cdns_phy->nsubnodes = node;
 
-	ret = cdns_regmap_init_torrent_dp(cdns_phy, cdns_phy->sd_base,
-					  cdns_phy->base,
-					  data->block_offset_shift,
-					  data->reg_offset_shift);
-	if (ret)
-		goto put_lnk_rst;
-
-	ret = cdns_regfield_init(cdns_phy);
-	if (ret)
-		goto put_lnk_rst;
-
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(phy_provider)) {
 		ret = PTR_ERR(phy_provider);
-- 
2.26.1

