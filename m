Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA1326D527
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIQHuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:50:55 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:32468 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726202AbgIQHuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:50:06 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7MfaY004018;
        Thu, 17 Sep 2020 00:30:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=gXyxxrMs5fzYUeocc5UrRZ5NgTHVWIabQdvIT0zi9iE=;
 b=mR/VBM4PGRP2MHxqulNJiPsOdcm81ikjfHp4nqq9LwaqNRcIGY56umVszZZB/oJaIaKp
 ee7s5gCy7rc1ous/6aWLe0MoXjNasAmf35tCXpRiklLKyONIMWJrm01CvFlueBjTBZZ0
 PQqlAZTRbquFvgoTm4v4R7DgA0hhIyqML0/RHA441wvqfT51EpNxkHtC6IxV8NLxXJUk
 wdRDcJpoCyAXTbkaFYx9Yjgyt6nSQ3PhdBtP5sUnggbpNIL/d5AzC4UsRo4T4QJo6TSo
 ws9ZwObZBCXdnVoZZHlY5KuYXDv6cuSEdo39T+3KbT2LTB4/wMw1QSwuNs8IP6R+go30 gg== 
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2055.outbound.protection.outlook.com [104.47.46.55])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmpfjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXC2hFJDnt1jQtfuJd1af6dfhp3VHw+dV4UMT6T4p+4qJuUdZN5YgQWhMZNPm26cvzW+0RHF6MK3BwZCxlHogtH9ifnZMWuaiZttkcGFg+nwv1MebRRt9lP6z4sLyCmbygGOgpW2AM+4tJCuWZaBT2zLEb0lkfWelwnF7MzloboClluxBVSyT9t8nADJGx7TBmOFaYdpal/eHWtbPs7O0hKOdFQRdW9X7N8t5cJa9+vOCn34iaN+K0uHTX2tVh42hcMjvOa03DcRjnltJZy3XgnrVthqXaZPRHlIQEfLxjF00F7L1MOPTyxDt54eBOru4oTCIAldiOelwIauamsbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXyxxrMs5fzYUeocc5UrRZ5NgTHVWIabQdvIT0zi9iE=;
 b=JvX1r6V0Ckn4o47G8dIWWEcy6bM436I+dxeF5EjZDf79ovB8FzmS4T1/cTteIhvxTgLTcad+xoMKMVv+FSFH3RjctnAlOzzUjOwHBiGKC7i/uUj/rxREWkcOOtn+LZvMtuzmO8lnN25BdpAxTH6IBJJT40a5XNt82pauVGK94T2Ldx/7JVHBd4zVKpwnt8LYpu1gNNpxCX/MI9nj6wNBhuAnJWKm42wBVRpX3pGfYQ8Kdy59dS2fwpkPlLQJ6FSHxmlIDMifYsE8ROO0phphNadyAoO5wKP0FXS+v7AsVhEbroTxysy1DtbHNcW5VnYd/XmX+gBiqX9Vdt3JHLeuLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXyxxrMs5fzYUeocc5UrRZ5NgTHVWIabQdvIT0zi9iE=;
 b=oNfZDXfllwPtRSVDc5iAlKDQPCOyCiIztTzTlYYuoeQ3WfIMtx12uD2fgTCVyxON/abjp6d1Q3A8HHFLY6B/ir2KnYkTQQDbxH9/MmzUJvfnefKYccn1LV6bms3xIxYMvk8ohb0JDVIW1KaS/6zaadVeVvLMP2auI5XU9FqeHbQ=
Received: from DM5PR21CA0025.namprd21.prod.outlook.com (2603:10b6:3:ed::11) by
 CY4PR07MB3047.namprd07.prod.outlook.com (2603:10b6:903:d4::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Thu, 17 Sep 2020 07:30:54 +0000
Received: from DM6NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::85) by DM5PR21CA0025.outlook.office365.com
 (2603:10b6:3:ed::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.1 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT055.mail.protection.outlook.com (10.13.179.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 07:30:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHd011305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 03:30:53 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:30:49 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:30:49 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UnG7009824;
        Thu, 17 Sep 2020 09:30:49 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7UnUp009823;
        Thu, 17 Sep 2020 09:30:49 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 12/13] phy: cadence-torrent: Add PCIe + USB multilink configuration
Date:   Thu, 17 Sep 2020 09:30:45 +0200
Message-ID: <1600327846-9733-13-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eab2af16-ca1c-4e9a-4486-08d85adb9c8a
X-MS-TrafficTypeDiagnostic: CY4PR07MB3047:
X-Microsoft-Antispam-PRVS: <CY4PR07MB30473E8D21BAA59790AF6E19C53E0@CY4PR07MB3047.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N3HiTNZiK88t8PD/C7Ejzu7ynn5qr2N4uT719leMPLxylRQ0PuZ6xb0qn/H2Zib8BeCIebO99J09BETi5cXq5nA1Bd289IiL9thj2GIVcVNfu96yggvoLvY+FqSBdmvqX7BUNnWSX2wnLNU1B31YraTbQXaGuFvew4ZmsLEoivyIen7Z14mG2/e00D6rQb0+uuYuXPY3h9SnF5r115si1EA6ZMXrfjKsTANdfWVX6geNbWVS13yM6qNGO4nGpEh6FpDhWi4AMU3KNRF/lECJob6Lyoq1bjcX/hYiuPABARxLXdBShKey1xotLlPY9rF3miFcDrZdgSaQe+n8Bo5aDuPNzdAloScB+dWMeW2xB4KoHW3T5QlqqrvuXMZtFbgybmN3k62PM6/Ouprt3M7nY9LB0w9hHB7QnIDSjGq5nbw=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36092001)(46966005)(54906003)(6666004)(47076004)(82740400003)(8936002)(81166007)(316002)(83380400001)(86362001)(8676002)(356005)(186003)(42186006)(30864003)(36756003)(5660300002)(2906002)(70206006)(26005)(110136005)(336012)(4326008)(82310400003)(36906005)(70586007)(426003)(478600001)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:54.2410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eab2af16-ca1c-4e9a-4486-08d85adb9c8a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT055.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3047
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=779 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe + USB Unique SSC multilink configuration sequences.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 216 ++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 3758c4b183af..e82ab72bd3d8 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1938,6 +1938,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
+	struct cdns_torrent_vals *pcs_cmn_vals;
 	int i, j, node, mlane, num_lanes, ret;
 	struct cdns_reg_pairs *reg_pairs;
 	enum cdns_torrent_ssc_mode ssc;
@@ -2011,6 +2012,17 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			}
 		}
 
+		/* PHY PCS common registers configurations */
+		pcs_cmn_vals = init_data->pcs_cmn_vals[phy_t1][phy_t2][ssc];
+		if (pcs_cmn_vals) {
+			reg_pairs = pcs_cmn_vals->reg_pairs;
+			num_regs = pcs_cmn_vals->num_regs;
+			regmap = cdns_phy->regmap_phy_pcs_common_cdb;
+			for (i = 0; i < num_regs; i++)
+				regmap_write(regmap, reg_pairs[i].off,
+					     reg_pairs[i].val);
+		}
+
 		/* PMA common registers configurations */
 		cmn_vals = init_data->cmn_vals[phy_t1][phy_t2][ssc];
 		if (cmn_vals) {
@@ -2331,6 +2343,100 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIe and USB Unique SSC link configuration */
+static struct cdns_reg_pairs pcie_usb_link_cmn_regs[] = {
+	{0x0003, PHY_PLL_CFG},
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1},
+	{0x8600, CMN_PDIAG_PLL1_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs pcie_usb_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0012, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs usb_pcie_xcvr_diag_ln_regs[] = {
+	{0x0011, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x00C9, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals pcie_usb_link_cmn_vals = {
+	.reg_pairs = pcie_usb_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_usb_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals pcie_usb_xcvr_diag_ln_vals = {
+	.reg_pairs = pcie_usb_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(pcie_usb_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals usb_pcie_xcvr_diag_ln_vals = {
+	.reg_pairs = usb_pcie_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_pcie_xcvr_diag_ln_regs),
+};
+
+/* USB 100 MHz Ref clk, internal SSC */
+static struct cdns_reg_pairs usb_100_int_ssc_cmn_regs[] = {
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
+	{0x0064, CMN_PLL1_INTDIV_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M0},
+	{0x0002, CMN_PLL0_FRACDIVH_M1},
+	{0x0002, CMN_PLL1_FRACDIVH_M0},
+	{0x0044, CMN_PLL0_HIGH_THR_M0},
+	{0x0036, CMN_PLL0_HIGH_THR_M1},
+	{0x0044, CMN_PLL1_HIGH_THR_M0},
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
+	{0x006E, CMN_PLL1_SS_CTRL3_M0},
+	{0x000E, CMN_PLL0_SS_CTRL4_M0},
+	{0x0012, CMN_PLL0_SS_CTRL4_M1},
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
+static struct cdns_torrent_vals usb_100_int_ssc_cmn_vals = {
+	.reg_pairs = usb_100_int_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_100_int_ssc_cmn_regs),
+};
+
 /* Single USB link configuration */
 static struct cdns_reg_pairs sl_usb_link_cmn_regs[] = {
 	{0x0000, PHY_PLL_CFG},
@@ -2895,6 +3001,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -2922,6 +3033,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -2941,6 +3057,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -2968,6 +3089,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -2977,6 +3103,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -2996,6 +3127,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3023,6 +3159,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
@@ -3042,6 +3183,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = NULL,
 				[INTERNAL_SSC] = NULL,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3069,6 +3215,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
@@ -3088,6 +3239,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3115,6 +3271,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
@@ -3139,6 +3300,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3166,6 +3332,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sl_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_link_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &pcie_usb_link_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -3185,6 +3356,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &pcie_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3212,6 +3388,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sl_usb_xcvr_diag_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -3221,6 +3402,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -3240,6 +3426,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3267,6 +3458,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
@@ -3286,6 +3482,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = NULL,
 				[INTERNAL_SSC] = NULL,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3313,6 +3514,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
@@ -3332,6 +3538,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_SGMII] = {
 			[TYPE_NONE] = {
@@ -3359,6 +3570,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_PCIE] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
-- 
2.26.1

