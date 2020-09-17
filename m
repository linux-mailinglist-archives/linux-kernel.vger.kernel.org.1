Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F3326D587
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIQIDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:03:22 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:62344 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726315AbgIQIAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:00:08 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7SkYm008576;
        Thu, 17 Sep 2020 00:30:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TD1km+/fPcpGt7WYEcbx0JtclRLvpYtr3uQP8oniigU=;
 b=uFsbk9EgnMffMQnZZcth7olUeei5YRNG5rJ77vjy2RSUsv6yGkvJ1ios/FxBBJ2WfN27
 6e6qmqNsdBD03TDHysqKGsf71X4g2BsfWs5jRMBk0Jn09pE5NtIOtVLTIHKKGXdd2wZT
 H1Y1+Xk0DGwkAGVtVdfOMQfhEMIeITehqwbC23pUUrW0HOt4wkL9JZ/dOfZOqePoMD4/
 OnWd4apmPS4Q7477ivURl3NzipW7SAcfSI6/ez758tiHq8/o7FSCqJXZGxHH42lHb0zF
 AtaMRwtzoQ1C3AUEU94gbNvngSVCMUQ+5ZBeZDyXHccwf5MIQ/ML+3J1MIC0fo8gr9ND /w== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njxkpp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGnhl62L4eSqceStzQTGFctl+GA3dRJ+xkXyILv3S0RqXCiX406bvChJz44Aqjz+vGt6pquG+jcEkhQyPvWSHA9gJQbVdnMTTR3l3Vbb6DT/5x8iDUIegsLwSFc2N3Mv3Qwdl4sv771RiM9alNxLGPfB2e8GIEbYnZtxEPV815/rJecSIhv0GU3jCHQbBKHQgIsGoHJjNBE5AkLllew4NPr4bfIYRd2n2apVN8hNgICSFCJSzEVg7I/edN1pl5wARmlCnTb2qiO+hZkdwK4q6RtcHq/6sWgG4ACejJgv+UzZzb+Ky+A9FJXijnKPTH8rv6hI1o8fbVdwY/wzhymBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD1km+/fPcpGt7WYEcbx0JtclRLvpYtr3uQP8oniigU=;
 b=FkerqQAW8Ti+snc1D/0yEQtAXLg2m1N+f0OgNBFlLGAfVe55BIU6YQZJJgrLldf82vWRXlE4rSD5VE2kvDgKptanZMi/EfP9hfqbzrCKF5a6uhYRb6iBInps1sJNSh4Lh5092x+6yIetf6g+K2inWVPl8s5RHLcAopJYx6X2QMpE1NAhp+8CuVeSRA7aOndCczXVIpvYyPy4vfPEu3X7Q6o9yLYq0PWmkouPlwuGUylX/Te57t8N8Abr+LC5t9wFJo/s8VswVvhZigG4CCOSZh7zhtYK3O+Vrxisj9Qy9bIQTdYIapHR+H1nX2ZzC4WEFUOqOp61EVi47MCAKrNdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD1km+/fPcpGt7WYEcbx0JtclRLvpYtr3uQP8oniigU=;
 b=Ocq7DhB3w/LbrucE5PBRGQxIyqnS9t/wcP/T2Fpem33cdcNslqdwAovyw0PRPWcpD8SCOBUSKOOaLUs7LOL/9NLoajZKOpoXcEmRDXG0B9J7lEF0HTWYLuXf+L1AwO5obAYtZVyQjssbfV+vam+wUXT48EkqgAt9G1pbBxNgGpE=
Received: from BN6PR08CA0096.namprd08.prod.outlook.com (2603:10b6:404:b6::34)
 by BLAPR07MB7748.namprd07.prod.outlook.com (2603:10b6:208:290::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 07:30:50 +0000
Received: from BN8NAM12FT027.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:b6:cafe::f7) by BN6PR08CA0096.outlook.office365.com
 (2603:10b6:404:b6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT027.mail.protection.outlook.com (10.13.182.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 07:30:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHT011305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 03:30:50 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:30:48 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:30:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UlbR009781;
        Thu, 17 Sep 2020 09:30:47 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7UluS009780;
        Thu, 17 Sep 2020 09:30:47 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 02/13] phy: cadence-torrent: Check cmn_ready assertion during PHY power on
Date:   Thu, 17 Sep 2020 09:30:35 +0200
Message-ID: <1600327846-9733-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 90eb18c4-500c-4499-e390-08d85adb9a46
X-MS-TrafficTypeDiagnostic: BLAPR07MB7748:
X-Microsoft-Antispam-PRVS: <BLAPR07MB774814E73AC2F35FDD4DEB41C53E0@BLAPR07MB7748.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7+WDA4KmmMS+bKk4tVjVzp5MuYaW0BwoYoo3M5sFhtFPBEKSqQOpVV+4Jit7H1zv7yeu04JvHkEm9ilK4ATfhGuNhvIL8pe+2PrSnXx8NjkOTH2qPcPwn3lso2yvpFtirJeXN6jwB6jAaf1pAMHLhhjT5B1a6d/ocrswCbTMczET493Av+VSJCIkrBbZp3POjZq+IqZ94UBcD4Z3UYCww7omhf3L2BdgPZWy+OWoh3hp+QUY3JgwHzgqBi2o9sUU9WVpCxWs+dKsC/dcsC3zXsMlcWPvQnbGpx14pbb4Yne+iFT4YHUBhVDD+BeKojmZSn+5VAezB3T/KAun0ukVDjjKF3c6SZxNgcEbzcUv+r8OTIfqgb9+h0lqLLkrdYniLRgWmkdM4gRsTEDlWCmOFRKDD16e2HG6qO/5VAOK5u4=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(36092001)(46966005)(316002)(36906005)(426003)(2616005)(86362001)(36756003)(5660300002)(70586007)(110136005)(54906003)(70206006)(8676002)(6666004)(4326008)(478600001)(336012)(42186006)(8936002)(26005)(2906002)(82310400003)(81166007)(186003)(47076004)(82740400003)(83380400001)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:50.5330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90eb18c4-500c-4499-e390-08d85adb9a46
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT027.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7748
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=907 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if cmn_ready is set after both PLL0 and PLL1 are locked.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 31 ++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 052cff34208d..9e900f389b08 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -32,6 +32,7 @@
 #define NUM_PHY_TYPE		2
 
 #define POLL_TIMEOUT_US		5000
+#define PLL_LOCK_TIMEOUT	100000
 
 #define TORRENT_COMMON_CDB_OFFSET	0x0
 
@@ -183,12 +184,16 @@
 #define PHY_PLL_CFG			0x000EU
 
 /* PHY PMA common registers */
+#define PHY_PMA_CMN_CTRL1		0x0000U
 #define PHY_PMA_CMN_CTRL2		0x0001U
 #define PHY_PMA_PLL_RAW_CTRL		0x0003U
 
 static const struct reg_field phy_pll_cfg =
 				REG_FIELD(PHY_PLL_CFG, 0, 1);
 
+static const struct reg_field phy_pma_cmn_ctrl_1 =
+				REG_FIELD(PHY_PMA_CMN_CTRL1, 0, 0);
+
 static const struct reg_field phy_pma_cmn_ctrl_2 =
 				REG_FIELD(PHY_PMA_CMN_CTRL2, 0, 7);
 
@@ -237,6 +242,7 @@ struct cdns_torrent_phy {
 	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_dptx_phy_reg;
 	struct regmap_field *phy_pll_cfg;
+	struct regmap_field *phy_pma_cmn_ctrl_1;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
 	struct regmap_field *phy_reset_ctrl;
@@ -1570,6 +1576,7 @@ static int cdns_torrent_phy_on(struct phy *phy)
 {
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	u32 read_val;
 	int ret;
 
 	/* Take the PHY out of reset */
@@ -1578,7 +1585,21 @@ static int cdns_torrent_phy_on(struct phy *phy)
 		return ret;
 
 	/* Take the PHY lane group out of reset */
-	return reset_control_deassert(inst->lnk_rst);
+	reset_control_deassert(inst->lnk_rst);
+
+	/*
+	 * Wait for cmn_ready assertion
+	 * PHY_PMA_CMN_CTRL1[0] == 1
+	 */
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_1,
+					     read_val, read_val, 1000,
+					     PLL_LOCK_TIMEOUT);
+	if (ret) {
+		dev_err(cdns_phy->dev, "Timeout waiting for CMN ready\n");
+		return ret;
+	}
+
+	return 0;
 }
 
 static int cdns_torrent_phy_off(struct phy *phy)
@@ -1643,6 +1664,14 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pll_cfg = field;
 
+	regmap = cdns_phy->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, phy_pma_cmn_ctrl_1);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_CMN_CTRL1 reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	cdns_phy->phy_pma_cmn_ctrl_1 = field;
+
 	regmap = cdns_phy->regmap_phy_pma_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pma_cmn_ctrl_2);
 	if (IS_ERR(field)) {
-- 
2.26.1

