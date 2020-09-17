Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458BF26D50A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgIQHsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:48:03 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:61966 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726301AbgIQHsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:48:01 -0400
X-Greylist: delayed 1015 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 03:47:59 EDT
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7MfaX004018;
        Thu, 17 Sep 2020 00:30:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TwoZXuvImRyd1c3rWiIhM2vwyG3dtDI/UQjEvat2PKM=;
 b=tKNulLiDXxXfK4/Xw+wMES6niKuQ4PlpLBja04n047I+Rh9YEejJO1ocF/jYhsGDexY8
 AyCz831zCVVHHJvHZpFuhEPkNCxQYp707R+zcTWezq/Cep1kOp7/+EXjFh7FP/iKlNIU
 YhEtr3KFo0ll95aUb26rTrIT3ZFAfNx80DpoVgeYdFf+jPP9tgU3+xvawilThvPusxv7
 4Mu3Ard7K+tWoZ4A2N+qSfsPnWqoPkK1bdsBkXb6OcWQ0iXL8Hoytj9SO0nsEdHnunmy
 dBF5Fnzxuafc0OxjCgCkw7EnEd+tAnx3vNf7umozTGJ0G/qmQKU1muc54L7/cGs8tjxu 8g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmpfju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5fMACGBAPuFJ9eVzFzd7hGk0fxSmSPcpwjoeGBBXsKzIghdp/vbP/FdwJSFGUB2PL1xYdImInS2t+7KefwwlUpoTMhUOzEkpTsvaxDxjAvxezSOaNZBzaiTTK3GH4JIcNVHIMufJNQYOJFBVLdYytMGMce7/3v9kLSbK9PxjTBFIBoiyC2QzGLTnlQNvuPBlgsbVVDHM0s4uyT7VBzvFEG4/xJTSb2WFW9WNRQ2vPOJId+Ntjg/yz7BMx0z8YN05jqPfceXBwklGCosqnuCkTQr6NG8AO6I/7ku4Oi3AIi0fy9AFwCpJXyOzFYlNBRT9Hqt339Dc96dEVA95afBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwoZXuvImRyd1c3rWiIhM2vwyG3dtDI/UQjEvat2PKM=;
 b=HyFESGmfIlJG1JRO1INzfEdNsz5bX9p5zhqzOR5aQAdJ4xCZrPqgKhoDtN2TRvM+U/t532lU9dxFKSCGB4fbL1+Cp8pU2KgpRBm3+L9LVuc/g41zQemgxA/9CL2Njorn8FJkrXgDxHDZbUT8cjmtUYyah1eLE8pOuOh76j/02iS9+JCfao4MfYQ+m3MgDAQFspv5nTR3oYbS9JmdiG7DpmF15UyiRV4Gp9rqfTBHCogOpdpnujiUYl+2eisqCgnfAoArKmqOhHK/bN+3HmeOoWTe4MFx2hdnOL6txt2QUq2ZSeixNvsho9D5f68dHrwokwJe/fQavWdXdROrnigH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwoZXuvImRyd1c3rWiIhM2vwyG3dtDI/UQjEvat2PKM=;
 b=izyj9mkX9poQN8Ztwn0Sz+UxPnIyHLFITReWwUJH55XE/eXRxY03w16O2lAf/6UWvqppptPazRj7vr4zL7xcDD8Ys6aptQ6kpd7LIFm8dxOTUalUOfMfKYARqUSpzEMOhod5qNmHQUE7mYQNZ7chwIoO+dbjVZP5Qe9o0DODDAc=
Received: from DM5PR13CA0055.namprd13.prod.outlook.com (2603:10b6:3:117::17)
 by SN6PR07MB4318.namprd07.prod.outlook.com (2603:10b6:805:5d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Thu, 17 Sep
 2020 07:30:53 +0000
Received: from DM6NAM12FT012.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::6e) by DM5PR13CA0055.outlook.office365.com
 (2603:10b6:3:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT012.mail.protection.outlook.com (10.13.179.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Thu, 17 Sep 2020 07:30:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHa011305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 03:30:52 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:30:49 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:30:49 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7Umfj009820;
        Thu, 17 Sep 2020 09:30:48 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7Um8F009819;
        Thu, 17 Sep 2020 09:30:48 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 11/13] phy: cadence-torrent: Add single link USB register sequences
Date:   Thu, 17 Sep 2020 09:30:44 +0200
Message-ID: <1600327846-9733-12-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84c36e40-5483-46ab-0f6d-08d85adb9bf4
X-MS-TrafficTypeDiagnostic: SN6PR07MB4318:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4318349B888C067C8EDCE32AC53E0@SN6PR07MB4318.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oNQ0KNkHiU8qAgY4DwT8w7CqAIH4K4aCuo2nXwZzCW7syaKqcHEtoDolVV+wQgKXUIprMJmW4K2t9BeGVhiI8VVcoqg9KlZhfrO6AZvKC8rAAKuPG9LsI3eGfLfUlpCauf392LglG12LQraLfDg8lv1b+fJQqjo2T6rGeOnotqTDyHCpHte3QrwfHxVqhmMkEUGvQGwzL4SgWnuWJO6wE67IEsIB4tSpeS69q00YhlgQSXaWIrJ70OVrv+gL6x04o+hSB7TclnUMpg0r+wfD7iIYR2ZiVwR4fV3Vj8l9ZHlWX4+3hk94XlihTFUi+A+LMerbOaqSd5pmMeAL3dtLTl2ZAFWqNLzdTySkNAN6mM5odR6kN7S7Yls4eIamHSlV3lSjtpymBOPJPnmbKX1FIbm04qA9JaV2Crua3qhFkIE=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36092001)(46966005)(4326008)(42186006)(36906005)(54906003)(110136005)(8936002)(8676002)(426003)(478600001)(6666004)(5660300002)(36756003)(336012)(316002)(2616005)(30864003)(2906002)(47076004)(26005)(186003)(82310400003)(70586007)(81166007)(86362001)(83380400001)(82740400003)(356005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:53.2486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c36e40-5483-46ab-0f6d-08d85adb9bf4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT012.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4318
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=761 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for single link USB configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 260 +++++++++++++++++++++-
 1 file changed, 259 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 844ec0ee8c66..3758c4b183af 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -29,7 +29,7 @@
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
 #define NUM_SSC_MODE		3
-#define NUM_PHY_TYPE		5
+#define NUM_PHY_TYPE		6
 
 #define POLL_TIMEOUT_US		5000
 #define PLL_LOCK_TIMEOUT	100000
@@ -82,6 +82,8 @@
 #define CMN_PLLSM0_PLLLOCK_TMR		0x002CU
 #define CMN_PLLSM1_PLLPRE_TMR		0x0032U
 #define CMN_PLLSM1_PLLLOCK_TMR		0x0034U
+#define CMN_CDIAG_CDB_PWRI_OVRD		0x0041U
+#define CMN_CDIAG_XCVRC_PWRI_OVRD	0x0047U
 #define CMN_BGCAL_INIT_TMR		0x0064U
 #define CMN_BGCAL_ITER_TMR		0x0065U
 #define CMN_IBCAL_INIT_TMR		0x0074U
@@ -159,13 +161,16 @@
 /* PMA TX Lane registers */
 #define TX_TXCC_CTRL			0x0040U
 #define TX_TXCC_CPOST_MULT_00		0x004CU
+#define TX_TXCC_CPOST_MULT_01		0x004DU
 #define TX_TXCC_MGNFS_MULT_000		0x0050U
 #define DRV_DIAG_TX_DRV			0x00C6U
 #define XCVR_DIAG_PLLDRC_CTRL		0x00E5U
 #define XCVR_DIAG_HSCLK_SEL		0x00E6U
 #define XCVR_DIAG_HSCLK_DIV		0x00E7U
 #define XCVR_DIAG_BIDI_CTRL		0x00EAU
+#define XCVR_DIAG_PSC_OVRD		0x00EBU
 #define TX_PSC_A0			0x0100U
+#define TX_PSC_A1			0x0101U
 #define TX_PSC_A2			0x0102U
 #define TX_PSC_A3			0x0103U
 #define TX_RCVDET_ST_TMR		0x0123U
@@ -174,27 +179,37 @@
 
 /* PMA RX Lane registers */
 #define RX_PSC_A0			0x0000U
+#define RX_PSC_A1			0x0001U
 #define RX_PSC_A2			0x0002U
 #define RX_PSC_A3			0x0003U
 #define RX_PSC_CAL			0x0006U
 #define RX_CDRLF_CNFG			0x0080U
+#define RX_CDRLF_CNFG3			0x0082U
+#define RX_SIGDET_HL_FILT_TMR		0x0090U
 #define RX_REE_GCSM1_CTRL		0x0108U
 #define RX_REE_GCSM1_EQENM_PH1		0x0109U
 #define RX_REE_GCSM1_EQENM_PH2		0x010AU
 #define RX_REE_GCSM2_CTRL		0x0110U
 #define RX_REE_PERGCSM_CTRL		0x0118U
+#define RX_REE_ATTEN_THR		0x0149U
 #define RX_REE_TAP1_CLIP		0x0171U
 #define RX_REE_TAP2TON_CLIP		0x0172U
+#define RX_REE_SMGM_CTRL1		0x0177U
+#define RX_REE_SMGM_CTRL2		0x0178U
 #define RX_DIAG_DFE_CTRL		0x01E0U
 #define RX_DIAG_DFE_AMP_TUNE_2		0x01E2U
 #define RX_DIAG_DFE_AMP_TUNE_3		0x01E3U
 #define RX_DIAG_NQST_CTRL		0x01E5U
+#define RX_DIAG_SIGDET_TUNE		0x01E8U
 #define RX_DIAG_PI_RATE			0x01F4U
 #define RX_DIAG_PI_CAP			0x01F5U
 #define RX_DIAG_ACYA			0x01FFU
 
 /* PHY PCS common registers */
 #define PHY_PLL_CFG			0x000EU
+#define PHY_PIPE_USB3_GEN2_PRE_CFG0	0x0020U
+#define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
+#define PHY_PIPE_USB3_GEN2_POST_CFG1	0x0023U
 
 /* PHY PMA common registers */
 #define PHY_PMA_CMN_CTRL1		0x0000U
@@ -222,6 +237,7 @@ enum cdns_torrent_phy_type {
 	TYPE_PCIE,
 	TYPE_SGMII,
 	TYPE_QSGMII,
+	TYPE_USB,
 };
 
 enum cdns_torrent_ssc_mode {
@@ -327,6 +343,8 @@ struct cdns_torrent_data {
 					       [NUM_SSC_MODE];
 	struct cdns_torrent_vals *xcvr_diag_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 						[NUM_SSC_MODE];
+	struct cdns_torrent_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					      [NUM_SSC_MODE];
 	struct cdns_torrent_vals *cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					  [NUM_SSC_MODE];
 	struct cdns_torrent_vals *tx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
@@ -1813,6 +1831,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
 	enum cdns_torrent_ssc_mode ssc = inst->ssc_mode;
+	struct cdns_torrent_vals *pcs_cmn_vals;
 	struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
 	u32 num_regs;
@@ -1861,6 +1880,17 @@ static int cdns_torrent_phy_init(struct phy *phy)
 		}
 	}
 
+	/* PHY PCS common registers configurations */
+	pcs_cmn_vals = init_data->pcs_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (pcs_cmn_vals) {
+		reg_pairs = pcs_cmn_vals->reg_pairs;
+		num_regs = pcs_cmn_vals->num_regs;
+		regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off,
+				     reg_pairs[i].val);
+	}
+
 	/* PMA common registers configurations */
 	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
@@ -2152,6 +2182,9 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		case PHY_TYPE_QSGMII:
 			cdns_phy->phys[node].phy_type = TYPE_QSGMII;
 			break;
+		case PHY_TYPE_USB3:
+			cdns_phy->phys[node].phy_type = TYPE_USB;
+			break;
 		default:
 			dev_err(dev, "Unsupported protocol\n");
 			ret = -EINVAL;
@@ -2298,6 +2331,143 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* Single USB link configuration */
+static struct cdns_reg_pairs sl_usb_link_cmn_regs[] = {
+	{0x0000, PHY_PLL_CFG},
+	{0x8600, CMN_PDIAG_PLL0_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs sl_usb_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0041, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals sl_usb_link_cmn_vals = {
+	.reg_pairs = sl_usb_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_usb_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_usb_xcvr_diag_ln_vals = {
+	.reg_pairs = sl_usb_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_usb_xcvr_diag_ln_regs),
+};
+
+/* USB PHY PCS common configuration */
+static struct cdns_reg_pairs usb_phy_pcs_cmn_regs[] = {
+	{0x0A0A, PHY_PIPE_USB3_GEN2_PRE_CFG0},
+	{0x1000, PHY_PIPE_USB3_GEN2_POST_CFG0},
+	{0x0010, PHY_PIPE_USB3_GEN2_POST_CFG1}
+};
+
+static struct cdns_torrent_vals usb_phy_pcs_cmn_vals = {
+	.reg_pairs = usb_phy_pcs_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_phy_pcs_cmn_regs),
+};
+
+/* USB 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs usb_100_no_ssc_cmn_regs[] = {
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
+	{0x8200, CMN_CDIAG_CDB_PWRI_OVRD},
+	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD}
+};
+
+static struct cdns_reg_pairs usb_100_no_ssc_tx_ln_regs[] = {
+	{0x02FF, TX_PSC_A0},
+	{0x06AF, TX_PSC_A1},
+	{0x06AE, TX_PSC_A2},
+	{0x06AE, TX_PSC_A3},
+	{0x2A82, TX_TXCC_CTRL},
+	{0x0014, TX_TXCC_CPOST_MULT_01},
+	{0x0003, XCVR_DIAG_PSC_OVRD}
+};
+
+static struct cdns_reg_pairs usb_100_no_ssc_rx_ln_regs[] = {
+	{0x0D1D, RX_PSC_A0},
+	{0x0D1D, RX_PSC_A1},
+	{0x0D00, RX_PSC_A2},
+	{0x0500, RX_PSC_A3},
+	{0x0013, RX_SIGDET_HL_FILT_TMR},
+	{0x0000, RX_REE_GCSM1_CTRL},
+	{0x0C02, RX_REE_ATTEN_THR},
+	{0x0330, RX_REE_SMGM_CTRL1},
+	{0x0300, RX_REE_SMGM_CTRL2},
+	{0x0019, RX_REE_TAP1_CLIP},
+	{0x0019, RX_REE_TAP2TON_CLIP},
+	{0x1004, RX_DIAG_SIGDET_TUNE},
+	{0x00F9, RX_DIAG_NQST_CTRL},
+	{0x0C01, RX_DIAG_DFE_AMP_TUNE_2},
+	{0x0002, RX_DIAG_DFE_AMP_TUNE_3},
+	{0x0000, RX_DIAG_PI_CAP},
+	{0x0031, RX_DIAG_PI_RATE},
+	{0x0001, RX_DIAG_ACYA},
+	{0x018C, RX_CDRLF_CNFG},
+	{0x0003, RX_CDRLF_CNFG3}
+};
+
+static struct cdns_torrent_vals usb_100_no_ssc_cmn_vals = {
+	.reg_pairs = usb_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals usb_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = usb_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals usb_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = usb_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_100_no_ssc_rx_ln_regs),
+};
+
+/* Single link USB, 100 MHz Ref clk, internal SSC */
+static struct cdns_reg_pairs sl_usb_100_int_ssc_cmn_regs[] = {
+	{0x0004, CMN_PLL0_DSM_DIAG_M0},
+	{0x0004, CMN_PLL1_DSM_DIAG_M0},
+	{0x0509, CMN_PDIAG_PLL0_CP_PADJ_M0},
+	{0x0509, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL0_CP_IADJ_M0},
+	{0x0F00, CMN_PDIAG_PLL1_CP_IADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL0_FILT_PADJ_M0},
+	{0x0F08, CMN_PDIAG_PLL1_FILT_PADJ_M0},
+	{0x0064, CMN_PLL0_INTDIV_M0},
+	{0x0064, CMN_PLL1_INTDIV_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M0},
+	{0x0002, CMN_PLL1_FRACDIVH_M0},
+	{0x0044, CMN_PLL0_HIGH_THR_M0},
+	{0x0044, CMN_PLL1_HIGH_THR_M0},
+	{0x0002, CMN_PDIAG_PLL0_CTRL_M0},
+	{0x0002, CMN_PDIAG_PLL1_CTRL_M0},
+	{0x0001, CMN_PLL0_SS_CTRL1_M0},
+	{0x0001, CMN_PLL1_SS_CTRL1_M0},
+	{0x011B, CMN_PLL0_SS_CTRL2_M0},
+	{0x011B, CMN_PLL1_SS_CTRL2_M0},
+	{0x006E, CMN_PLL0_SS_CTRL3_M0},
+	{0x006E, CMN_PLL1_SS_CTRL3_M0},
+	{0x000E, CMN_PLL0_SS_CTRL4_M0},
+	{0x000E, CMN_PLL1_SS_CTRL4_M0},
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
+	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR},
+	{0x8200, CMN_CDIAG_CDB_PWRI_OVRD},
+	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD}
+};
+
+static struct cdns_torrent_vals sl_usb_100_int_ssc_cmn_vals = {
+	.reg_pairs = sl_usb_100_int_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_usb_100_int_ssc_cmn_regs),
+};
+
 /* PCIe and SGMII/QSGMII Unique SSC link configuration */
 static struct cdns_reg_pairs pcie_sgmii_link_cmn_regs[] = {
 	{0x0003, PHY_PLL_CFG},
@@ -2746,6 +2916,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
+			},
+		},
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
@@ -2785,6 +2962,22 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
+			},
+		},
+	},
+	.pcs_cmn_vals = {
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
+		},
 	},
 	.cmn_vals = {
 		[TYPE_PCIE] = {
@@ -2824,6 +3017,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
+		},
 	},
 	.tx_ln_vals = {
 		[TYPE_PCIE] = {
@@ -2863,6 +3063,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
+		},
 	},
 	.rx_ln_vals = {
 		[TYPE_PCIE] = {
@@ -2902,6 +3109,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
+		},
 	},
 };
 
@@ -2946,6 +3160,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
+			},
+		},
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
@@ -2985,6 +3206,22 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
+			},
+		},
+	},
+	.pcs_cmn_vals = {
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
+		},
 	},
 	.cmn_vals = {
 		[TYPE_PCIE] = {
@@ -3024,6 +3261,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
+		},
 	},
 	.tx_ln_vals = {
 		[TYPE_PCIE] = {
@@ -3063,6 +3307,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
+		},
 	},
 	.rx_ln_vals = {
 		[TYPE_PCIE] = {
@@ -3102,6 +3353,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 			},
 		},
+		[TYPE_USB] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
+		},
 	},
 };
 
-- 
2.26.1

