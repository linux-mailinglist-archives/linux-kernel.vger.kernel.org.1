Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E6E26D522
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgIQHuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:50:10 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:9054 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbgIQHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:50:05 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7MdFc003933;
        Thu, 17 Sep 2020 00:30:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=0CHvDggT9waDSIL2+S5YVQQPD0zas5X7OmGVYi87+Hs=;
 b=kkF/5vL/57tQ7YxGfo5vmHMmExZbpNs9SrKbvgNodkAFpTJaCc3NXZV1ikSOl6/SLtsi
 v4QlQ2M8AxSF5C1Zye2qkz2bTspSVpqitzeZJWdQ+1s84GXPet3RG4jdKsW7z/dXAubt
 M/xrO3+1KwFCVD/lNRCMjv21fyye2DALSuOms+NTsX02h2s3yDV8UVOjez8hjbUgRq9V
 3dQuDNZ9GmaJvqnFQ3Q7d5NmdEKAhTLmcvyxSrOzNSVPgEhtNcqChP46CUQXcOp0/PcG
 00UmpQ3NYikGq1f2wMaQrQARSz4x3dzBU2UnDZde9zY7qDIuTBeguEUgKXL5o9MrPDWT EA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmpfjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XrfNhIRz4Af3UsIFFtBwrbXbFNx0huttFgV2InrVaHX+9Wgp52AvFX8Srgiopot9GFhwGtbodqamKjlv/y05bJ61ssI2ubV4e63iHR0I3AacVM12j1MUBamanZaTRXKNN2QhFIFwuZcmQ6TGl5eLoQk6zMQCltzqVHNy/mHC/LKXib/2d/thhpHbO/sSW4Pi8H99YN9vo4AmMPeJJ5p8Gr9CE6lj2AiwhLZtiHbtaA8jftxrCSvibs0+znnQffWdrihLl/kELCjhrJEsfMVCrsP/NXLucfS5hZ7GoejnML81R9FLJKkFgWSM5Z5XWrsmAUA2Ta94AVsiQpvslJipRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CHvDggT9waDSIL2+S5YVQQPD0zas5X7OmGVYi87+Hs=;
 b=m/vaCT0cX/0qtxPxZwe0Qmv9YM2SZ7/0PdB+N60bIeWELSyeR3Xp5kUp32TECm8CqFDtRO+dlKe6VzXeBSsGizN5AieH6dRDvfZ9rmR/IXfSmVPhA9rWRNOWrCf+8vOZIVzaGYECaqIeCHjtNxj9M+v+JEYKnU9NiMHe+GMXGxEvi0zaKbxkV+dLLthSkZfc0PqMVv+yY0hJsQ0ujJsWHBlwlEabWFI4xrILo1SiaU/wYrdB9A/dQFg7JvCaoJ3zEQjGQ6DEZmYJ4FEQzb8qOXMMLuMeJTPLOfonBVMnICoMVRCBd3nZku6OssyjlP8cwJdF8FWk93WmySKzZnvT3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0CHvDggT9waDSIL2+S5YVQQPD0zas5X7OmGVYi87+Hs=;
 b=iEPgXj4S+WGcRjM0aTCJ8Cke9Q2Ispnh6PLP0LCntmaF/n1pbRT0De6dGSlfDdyspzSMFhCp4LEaIW6SqzzIBdgmaUDPMGUFcOeiRmXLdMT3+jkSkX0JP9Yqd9bNxRjAWfoH4tIc9KL3JXBQUPGMN9dwh7Pp0LLdHq1VYo27dJc=
Received: from BN6PR03CA0081.namprd03.prod.outlook.com (2603:10b6:405:6f::19)
 by DM6PR07MB4476.namprd07.prod.outlook.com (2603:10b6:5:c6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 07:30:50 +0000
Received: from BN8NAM12FT035.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::2c) by BN6PR03CA0081.outlook.office365.com
 (2603:10b6:405:6f::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT035.mail.protection.outlook.com (10.13.182.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Thu, 17 Sep 2020 07:30:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHR011305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 03:30:49 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:30:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:30:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UlPx009777;
        Thu, 17 Sep 2020 09:30:47 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7UlW3009776;
        Thu, 17 Sep 2020 09:30:47 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 01/13] phy: cadence-torrent: Add single link PCIe support
Date:   Thu, 17 Sep 2020 09:30:34 +0200
Message-ID: <1600327846-9733-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cc46056-0fc4-40ff-1784-08d85adb99e0
X-MS-TrafficTypeDiagnostic: DM6PR07MB4476:
X-Microsoft-Antispam-PRVS: <DM6PR07MB44769914089781040F5CB536C53E0@DM6PR07MB4476.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:74;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5L22eRdXXneShaqMAO35DiRSyr1n56/3oaWeMHmv5fbNaBNZfqDaYl/J84/2mRrG1WcEvqphzhG6enhhEjyEm3AGTwCT1bmJRwipsMz22TKIhwoRf3fDzHYf2PZRC0/mZzwFXCOrDzqmyhj4XB522XgROlWb/mg7uEsT9qpz8CNjnc9utQkmqmNWNLsTGFDnQlFEuWHl0TG4hb8jw20RTxV1in6Xf4cFVV1euiM4+HmFQkllJsgcNYjMXZHjQmr7ta98bvqC2PafNcv6bA6nH3IMMjETFNZe5H+Lt4NAP8b9bMdb5pzDnGn85UkuEaxh4y7I+oEcGKRw2ObpCzJ7Y/7LZ2M3B7H53zozCkGRuoSK58QFAY2Ud2vcrd2QPuZ0Bg1Cx0y1ltL7oAncP08NJyiXPDCsEvj80xBFRdOU0g=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36092001)(46966005)(336012)(426003)(8936002)(478600001)(81166007)(47076004)(82310400003)(82740400003)(356005)(26005)(2906002)(83380400001)(186003)(42186006)(36756003)(36906005)(2616005)(316002)(5660300002)(86362001)(8676002)(4326008)(70586007)(110136005)(70206006)(6666004)(30864003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:49.8473
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cc46056-0fc4-40ff-1784-08d85adb99e0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT035.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4476
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=881 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single link PCIe register sequences in Torrent PHY driver.
Also, add support for getting SSC type from DT.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 296 +++++++++++++++++++---
 1 file changed, 266 insertions(+), 30 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 6c199400fa5b..052cff34208d 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -28,6 +28,9 @@
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
+#define NUM_SSC_MODE		3
+#define NUM_PHY_TYPE		2
+
 #define POLL_TIMEOUT_US		5000
 
 #define TORRENT_COMMON_CDB_OFFSET	0x0
@@ -98,6 +101,14 @@
 #define CMN_PLL0_LOCK_REFCNT_START      0x009CU
 #define CMN_PLL0_LOCK_PLLCNT_START	0x009EU
 #define CMN_PLL0_LOCK_PLLCNT_THR        0x009FU
+#define CMN_PLL0_INTDIV_M1		0x00A0U
+#define CMN_PLL0_FRACDIVH_M1		0x00A2U
+#define CMN_PLL0_HIGH_THR_M1		0x00A3U
+#define CMN_PLL0_DSM_DIAG_M1		0x00A4U
+#define CMN_PLL0_SS_CTRL1_M1		0x00A8U
+#define CMN_PLL0_SS_CTRL2_M1		0x00A9U
+#define CMN_PLL0_SS_CTRL3_M1		0x00AAU
+#define CMN_PLL0_SS_CTRL4_M1		0x00ABU
 #define CMN_PLL1_VCOCAL_TCTRL		0x00C2U
 #define CMN_PLL1_VCOCAL_INIT_TMR	0x00C4U
 #define CMN_PLL1_VCOCAL_ITER_TMR	0x00C5U
@@ -130,8 +141,10 @@
 #define CMN_PDIAG_PLL0_CP_PADJ_M0	0x01A4U
 #define CMN_PDIAG_PLL0_CP_IADJ_M0	0x01A5U
 #define CMN_PDIAG_PLL0_FILT_PADJ_M0	0x01A6U
+#define CMN_PDIAG_PLL0_CTRL_M1		0x01B0U
 #define CMN_PDIAG_PLL0_CP_PADJ_M1	0x01B4U
 #define CMN_PDIAG_PLL0_CP_IADJ_M1	0x01B5U
+#define CMN_PDIAG_PLL0_FILT_PADJ_M1	0x01B6U
 #define CMN_PDIAG_PLL1_CTRL_M0		0x01C0U
 #define CMN_PDIAG_PLL1_CLK_SEL_M0	0x01C1U
 #define CMN_PDIAG_PLL1_CP_PADJ_M0	0x01C4U
@@ -162,6 +175,9 @@
 #define RX_REE_GCSM1_CTRL		0x0108U
 #define RX_REE_GCSM2_CTRL		0x0110U
 #define RX_REE_PERGCSM_CTRL		0x0118U
+#define RX_REE_TAP1_CLIP		0x0171U
+#define RX_REE_TAP2TON_CLIP		0x0172U
+#define RX_DIAG_ACYA			0x01FFU
 
 /* PHY PCS common registers */
 #define PHY_PLL_CFG			0x000EU
@@ -182,12 +198,24 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
+enum cdns_torrent_phy_type {
+	TYPE_DP,
+	TYPE_PCIE
+};
+
+enum cdns_torrent_ssc_mode {
+	NO_SSC,
+	EXTERNAL_SSC,
+	INTERNAL_SSC
+};
+
 struct cdns_torrent_inst {
 	struct phy *phy;
 	u32 mlane;
-	u32 phy_type;
+	enum cdns_torrent_phy_type phy_type;
 	u32 num_lanes;
 	struct reset_control *lnk_rst;
+	enum cdns_torrent_ssc_mode ssc_mode;
 };
 
 struct cdns_torrent_phy {
@@ -221,8 +249,9 @@ enum phy_powerstate {
 	POWERSTATE_A3 = 3,
 };
 
+static int cdns_torrent_phy_init(struct phy *phy);
+static int cdns_torrent_phy_exit(struct phy *phy);
 static int cdns_torrent_dp_init(struct phy *phy);
-static int cdns_torrent_dp_exit(struct phy *phy);
 static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
 			       u32 num_lanes);
 static
@@ -252,17 +281,30 @@ static int cdns_torrent_phy_on(struct phy *phy);
 static int cdns_torrent_phy_off(struct phy *phy);
 
 static const struct phy_ops cdns_torrent_phy_ops = {
-	.init		= cdns_torrent_dp_init,
-	.exit		= cdns_torrent_dp_exit,
+	.init		= cdns_torrent_phy_init,
+	.exit		= cdns_torrent_phy_exit,
 	.configure	= cdns_torrent_dp_configure,
 	.power_on	= cdns_torrent_phy_on,
 	.power_off	= cdns_torrent_phy_off,
 	.owner		= THIS_MODULE,
 };
 
+struct cdns_reg_pairs {
+	u32 val;
+	u32 off;
+};
+
+struct cdns_torrent_vals {
+	struct cdns_reg_pairs *reg_pairs;
+	u32 num_regs;
+};
+
 struct cdns_torrent_data {
-		u8 block_offset_shift;
-		u8 reg_offset_shift;
+	u8 block_offset_shift;
+	u8 reg_offset_shift;
+	struct cdns_torrent_vals *cmn_vals[NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals *tx_ln_vals[NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals *rx_ln_vals[NUM_PHY_TYPE][NUM_SSC_MODE];
 };
 
 struct cdns_regmap_cdb_context {
@@ -846,19 +888,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
-	ret = clk_prepare_enable(cdns_phy->clk);
-	if (ret) {
-		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
-		return ret;
-	}
-
-	cdns_phy->ref_clk_rate = clk_get_rate(cdns_phy->clk);
-	if (!(cdns_phy->ref_clk_rate)) {
-		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
-		clk_disable_unprepare(cdns_phy->clk);
-		return -EINVAL;
-	}
-
 	switch (cdns_phy->ref_clk_rate) {
 	case REF_CLK_19_2MHz:
 	case REF_CLK_25MHz:
@@ -918,7 +947,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
-static int cdns_torrent_dp_exit(struct phy *phy)
+static int cdns_torrent_phy_exit(struct phy *phy)
 {
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 
@@ -1725,6 +1754,74 @@ static int cdns_torrent_regmap_init(struct cdns_torrent_phy *cdns_phy)
 	return 0;
 }
 
+static int cdns_torrent_phy_init(struct phy *phy)
+{
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	enum cdns_torrent_phy_type phy_type = inst->phy_type;
+	enum cdns_torrent_ssc_mode ssc = inst->ssc_mode;
+	struct cdns_reg_pairs *reg_pairs;
+	struct regmap *regmap;
+	u32 num_regs;
+	int ret, i, j;
+
+	ret = clk_prepare_enable(cdns_phy->clk);
+	if (ret) {
+		dev_err(cdns_phy->dev, "Failed to prepare ref clock\n");
+		return ret;
+	}
+
+	cdns_phy->ref_clk_rate = clk_get_rate(cdns_phy->clk);
+	if (!(cdns_phy->ref_clk_rate)) {
+		dev_err(cdns_phy->dev, "Failed to get ref clock rate\n");
+		clk_disable_unprepare(cdns_phy->clk);
+		return -EINVAL;
+	}
+
+	if (phy_type == TYPE_DP)
+		return cdns_torrent_dp_init(phy);
+
+	/* PMA common registers configurations */
+	cmn_vals = cdns_phy->init_data->cmn_vals[phy_type][ssc];
+	if (cmn_vals) {
+		reg_pairs = cmn_vals->reg_pairs;
+		num_regs = cmn_vals->num_regs;
+		regmap = cdns_phy->regmap_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off,
+				     reg_pairs[i].val);
+	}
+
+	/* PMA TX lane registers configurations */
+	tx_ln_vals = cdns_phy->init_data->tx_ln_vals[phy_type][ssc];
+	if (tx_ln_vals) {
+		reg_pairs = tx_ln_vals->reg_pairs;
+		num_regs = tx_ln_vals->num_regs;
+		for (i = 0; i < inst->num_lanes; i++) {
+			regmap = cdns_phy->regmap_tx_lane_cdb[i + inst->mlane];
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off,
+					     reg_pairs[j].val);
+		}
+	}
+
+	/* PMA RX lane registers configurations */
+	rx_ln_vals = cdns_phy->init_data->rx_ln_vals[phy_type][ssc];
+	if (rx_ln_vals) {
+		reg_pairs = rx_ln_vals->reg_pairs;
+		num_regs = rx_ln_vals->num_regs;
+		for (i = 0; i < inst->num_lanes; i++) {
+			regmap = cdns_phy->regmap_rx_lane_cdb[i + inst->mlane];
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off,
+					     reg_pairs[j].val);
+		}
+	}
+
+	return 0;
+}
+
 static int cdns_torrent_phy_probe(struct platform_device *pdev)
 {
 	struct cdns_torrent_phy *cdns_phy;
@@ -1735,6 +1832,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	int ret, subnodes, node = 0, i;
 	u32 total_num_lanes = 0;
 	u8 init_dp_regmap = 0;
+	u32 phy_type;
 
 	/* Get init data for this PHY */
 	data = of_device_get_match_data(dev);
@@ -1800,14 +1898,26 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			goto put_child;
 		}
 
-		if (of_property_read_u32(child, "cdns,phy-type",
-					 &cdns_phy->phys[node].phy_type)) {
+		if (of_property_read_u32(child, "cdns,phy-type", &phy_type)) {
 			dev_err(dev, "%s: No \"cdns,phy-type\"-property.\n",
 				child->full_name);
 			ret = -EINVAL;
 			goto put_child;
 		}
 
+		switch (phy_type) {
+		case PHY_TYPE_PCIE:
+			cdns_phy->phys[node].phy_type = TYPE_PCIE;
+			break;
+		case PHY_TYPE_DP:
+			cdns_phy->phys[node].phy_type = TYPE_DP;
+			break;
+		default:
+			dev_err(dev, "Unsupported protocol\n");
+			ret = -EINVAL;
+			goto put_child;
+		}
+
 		if (of_property_read_u32(child, "cdns,num-lanes",
 					 &cdns_phy->phys[node].num_lanes)) {
 			dev_err(dev, "%s: No \"cdns,num-lanes\"-property.\n",
@@ -1818,7 +1928,18 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 
 		total_num_lanes += cdns_phy->phys[node].num_lanes;
 
-		if (cdns_phy->phys[node].phy_type == PHY_TYPE_DP) {
+		/* Get SSC mode */
+		cdns_phy->phys[node].ssc_mode = NO_SSC;
+		of_property_read_u32(child, "cdns,ssc-mode",
+				     &cdns_phy->phys[node].ssc_mode);
+
+		gphy = devm_phy_create(dev, child, &cdns_torrent_phy_ops);
+		if (IS_ERR(gphy)) {
+			ret = PTR_ERR(gphy);
+			goto put_child;
+		}
+
+		if (cdns_phy->phys[node].phy_type == TYPE_DP) {
 			switch (cdns_phy->phys[node].num_lanes) {
 			case 1:
 			case 2:
@@ -1861,13 +1982,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 				goto put_child;
 			}
 
-			gphy = devm_phy_create(dev, child,
-					       &cdns_torrent_phy_ops);
-			if (IS_ERR(gphy)) {
-				ret = PTR_ERR(gphy);
-				goto put_child;
-			}
-
 			if (!init_dp_regmap) {
 				ret = cdns_torrent_dp_regmap_init(cdns_phy);
 				if (ret)
@@ -1889,6 +2003,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
 			gphy->attrs.mode = PHY_MODE_DP;
 		}
+
 		cdns_phy->phys[node].phy = gphy;
 		phy_set_drvdata(gphy, &cdns_phy->phys[node]);
 
@@ -1932,14 +2047,135 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* Single link PCIe, 100 MHz Ref clk, internal SSC */
+static struct cdns_reg_pairs sl_pcie_100_int_ssc_cmn_regs[] = {
+	{0x0004, CMN_PLL0_DSM_DIAG_M0},
+	{0x0004, CMN_PLL0_DSM_DIAG_M1},
+	{0x0004, CMN_PLL1_DSM_DIAG_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M1},
+	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M1},
+	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M1},
+	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
+	{0x0064, CMN_PLL0_INTDIV_M0},
+	{0x0050, CMN_PLL0_INTDIV_M1},
+	{0x0050, CMN_PLL1_INTDIV_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M1},
+	{0x0002, CMN_PLL1_FRACDIVH_M0},
+	{0x0044, CMN_PLL0_HIGH_THR_M0},
+	{0x0036, CMN_PLL0_HIGH_THR_M1},
+	{0x0036, CMN_PLL1_HIGH_THR_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M1},
+	{0x0002, CMN_PDIAG_PLL1_CTRL_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M1},
+	{0x0001, CMN_PLL1_SS_CTRL1_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M1},
+	{0x011B, CMN_PLL1_SS_CTRL2_M0},
+	{0x006E, CMN_PLL0_SS_CTRL3_M0},
+	{0x0058, CMN_PLL0_SS_CTRL3_M1},
+	{0x0058, CMN_PLL1_SS_CTRL3_M0},
+	{0x000E, CMN_PLL0_SS_CTRL4_M0},
+	{0x0012, CMN_PLL0_SS_CTRL4_M1},
+	{0x0012, CMN_PLL1_SS_CTRL4_M0},
+	{0x0C5E, CMN_PLL0_VCOCAL_REFTIM_START},
+	{0x0C5E, CMN_PLL1_VCOCAL_REFTIM_START},
+	{0x0C56, CMN_PLL0_VCOCAL_PLLCNT_START},
+	{0x0C56, CMN_PLL1_VCOCAL_PLLCNT_START},
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x00C7, CMN_PLL0_LOCK_REFCNT_START},
+	{0x00C7, CMN_PLL1_LOCK_REFCNT_START},
+	{0x00C7, CMN_PLL0_LOCK_PLLCNT_START},
+	{0x00C7, CMN_PLL1_LOCK_PLLCNT_START},
+	{0x0005, CMN_PLL0_LOCK_PLLCNT_THR},
+	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR}
+};
+
+static struct cdns_torrent_vals sl_pcie_100_int_ssc_cmn_vals = {
+	.reg_pairs = sl_pcie_100_int_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_pcie_100_int_ssc_cmn_regs),
+};
+
+/* PCIe, 100 MHz Ref clk, no SSC & external SSC */
+static struct cdns_reg_pairs pcie_100_ext_no_ssc_cmn_regs[] = {
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
+};
+
+static struct cdns_reg_pairs pcie_100_ext_no_ssc_rx_ln_regs[] = {
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x0001, RX_DIAG_ACYA}
+};
+
+static struct cdns_torrent_vals pcie_100_no_ssc_cmn_vals = {
+	.reg_pairs = pcie_100_ext_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_ext_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = pcie_100_ext_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_ext_no_ssc_rx_ln_regs),
+};
+
 static const struct cdns_torrent_data cdns_map_torrent = {
 	.block_offset_shift = 0x2,
 	.reg_offset_shift = 0x2,
+	.cmn_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+			[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+			[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+		},
+	},
+	.tx_ln_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = NULL,
+			[EXTERNAL_SSC] = NULL,
+			[INTERNAL_SSC] = NULL,
+		},
+	},
+	.rx_ln_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+		},
+	},
 };
 
 static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	.block_offset_shift = 0x0,
 	.reg_offset_shift = 0x1,
+	.cmn_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+			[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+			[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+		},
+	},
+	.tx_ln_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = NULL,
+			[EXTERNAL_SSC] = NULL,
+			[INTERNAL_SSC] = NULL,
+		},
+	},
+	.rx_ln_vals = {
+		[TYPE_PCIE] = {
+			[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+		},
+	},
 };
 
 static const struct of_device_id cdns_torrent_phy_of_match[] = {
-- 
2.26.1

