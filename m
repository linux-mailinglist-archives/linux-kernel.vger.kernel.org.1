Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEAB26D638
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbgIQIQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:16:06 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:11374 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgIQIQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:16:02 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7MdFd003933;
        Thu, 17 Sep 2020 00:30:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=HNORRcSdXo9UXhW0DmoXmhJfVibrbFfHCE78rErzGY8=;
 b=SztKCavq4r19FQU/NL0cMRTXFhoF5nIxz+SN14yfUb4F6dqj8QTzEi024s4aBktIn17I
 iy8p5/WofeqU3t71OU3ybaCNJ9bhxg44135RQAQ++MDQbKkQpIHWb7mJkdfim/rVDxSB
 IiUlNHlR+q6333cec7x0qrMChKYHDU73cie7Rr/BrISumk9Gbzv8HkhJluZhUC8GvqKH
 iJZm7Gn5BZ34yMpfswCjhMvcFo/V/6MKXxgdzF+o+oEw/TUqPiPteOhMAt4TJ4AKy2C6
 1AO5ZHOcTM0spz7V+CVl+pg3Z+G1MPIJTkQmlN7x7JZZyLtF+54Noghgkx30jbYR/SmQ wA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmpfjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=novWewxeGDaxr56RhLEk4nJd0xxO6Uv/84CMjQVmN2e1kiFkEdk17kuXWmvl1o8EyhT+9kULpfw2GT7Jepmqkj+Uveti+/F443t0OH2937NN8GCkDcBBB4+8uIsNMtiL5Z7enirpima293JQRtC/x9t45kIWBpk887IXMkfO1Eh1lYDeMDxHZdbZgnW05MX55udZwS29E5Y3WOW3QqA2AiGaRuKRDnILJoFCNM+NtJLmQh8yuLAh6PV+RKHBe+7TSr14y3eVDWl1hzhxaaoLI6SknKwWUmUd//Sog6OotKBRk7PQKVgN5AC0/CD79i98IUCJKq2kTX/sap2HMU1mNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNORRcSdXo9UXhW0DmoXmhJfVibrbFfHCE78rErzGY8=;
 b=AOil8j1l7zD8Cek8V7mm1wsw/xnwO4RqXHjfcYUvRJwgYExtkVkpPioaSlubeBWz2M3E21dyOAnmEFU/7/J81EglbU8BFykWQytPhgKyDcQucMV5tA6zIjyFpm3+iWA9g6DNDvvDUh3VK0idI3aQQ8+OQ7Dqc6iHInwOrMz4galkm5+67CUHoaFgrlgypYKk1P/jfWOZqHOPnIf0wg6BZBTfZwL8lixpxzjYyVPimPZPC5fT8Shd27zbXk3ES1YlsvJB+KERTr69IXS49Rmv3gPON0BjOSCKMRDviGv0zSi8U5+Mzv2jEjnE+sSTbBgqNYfuz9yj3HUrxYvNMTdQpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNORRcSdXo9UXhW0DmoXmhJfVibrbFfHCE78rErzGY8=;
 b=KJIukEEjun67xifJKQZ6iVjI7dnCnlYvTcXlGMLInhxTaUyErAImBfRjF96JBGbiERZg9Vl+4AxINAWQqRgurdosHAPbguctfUMWByMeaB7C5h1CE7HQ7KgozpduibykBJrzoCXVj0yuuKj6TKLayatU75X1LeJQycku+dWQ1q4=
Received: from DM5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:3:d4::17) by
 DM5PR07MB2795.namprd07.prod.outlook.com (2603:10b6:3:8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Thu, 17 Sep 2020 07:30:53 +0000
Received: from DM6NAM12FT024.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::fb) by DM5PR05CA0007.outlook.office365.com
 (2603:10b6:3:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT024.mail.protection.outlook.com (10.13.179.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 07:30:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHb011305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 03:30:52 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:30:48 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:30:48 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmD0009816;
        Thu, 17 Sep 2020 09:30:48 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7UmGb009815;
        Thu, 17 Sep 2020 09:30:48 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 10/13] phy: cadence-torrent: Add single link SGMII/QSGMII register sequences
Date:   Thu, 17 Sep 2020 09:30:43 +0200
Message-ID: <1600327846-9733-11-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 518a5609-8c09-4b09-824f-08d85adb9c23
X-MS-TrafficTypeDiagnostic: DM5PR07MB2795:
X-Microsoft-Antispam-PRVS: <DM5PR07MB2795744EA0EDF5A485FF9129C53E0@DM5PR07MB2795.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03wLs3iUXJ+eCTXOgmjEsyZATLI++AQWYClQGdGkXuburPCYMHqLyFtv9aiI/TP5vE9iDDSC3iP1atmVbtiYZV6kECZ5TpgoKYNsUt2zr/HICXAIbeESooqke6iRbocPwQmfTjfHEfNx8MjigsB/24UcVkzZ7hd6L7eousncHrKgwpZmwOm/HDNmjV8m+0iPEEGWweohj8PUJYIVM1HbRoanJ9ZAmyZkTCVvXE215HnFnRMnWl/gnmstAwO55eyCsAi9IHwDkSA6VR8ng+/RKKMMpVB7htJS56CwKYwdK96bRMx3QyggDVX9zbHD/F2wq2XJapF7+WSurL6oc4Ja7uW7Kce/WIIIIGRZgIpIPxnK9jLi1YB7IMatNm2Qd/21d5v/4Ro0Gvq3oY+D/pWBSSZTKifIsRRzQva4XxlLCGU=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36092001)(46966005)(47076004)(26005)(36906005)(336012)(4326008)(316002)(36756003)(70206006)(42186006)(6666004)(110136005)(54906003)(8936002)(478600001)(2616005)(426003)(186003)(82740400003)(70586007)(82310400003)(356005)(81166007)(5660300002)(2906002)(8676002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:53.6046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518a5609-8c09-4b09-824f-08d85adb9c23
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT024.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2795
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=784 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for single link SGMII/QSGMII configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 89 +++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 0c4abe959f19..844ec0ee8c66 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1824,6 +1824,13 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	if (phy_type == TYPE_DP)
 		return cdns_torrent_dp_init(phy);
 
+	/**
+	 * Spread spectrum generation is not required or supported
+	 * for SGMII/QSGMII
+	 */
+	if (phy_type == TYPE_SGMII || phy_type == TYPE_QSGMII)
+		ssc = NO_SSC;
+
 	/* PHY configuration specific registers for single link */
 	link_cmn_vals = init_data->link_cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (link_cmn_vals) {
@@ -2540,6 +2547,28 @@ static struct cdns_torrent_vals qsgmii_100_int_ssc_cmn_vals = {
 	.num_regs = ARRAY_SIZE(qsgmii_100_int_ssc_cmn_regs),
 };
 
+/* Single SGMII/QSGMII link configuration */
+static struct cdns_reg_pairs sl_sgmii_link_cmn_regs[] = {
+	{0x0000, PHY_PLL_CFG},
+	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs sl_sgmii_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0003, XCVR_DIAG_HSCLK_DIV},
+	{0x0013, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals sl_sgmii_link_cmn_vals = {
+	.reg_pairs = sl_sgmii_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_sgmii_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_sgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = sl_sgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_sgmii_xcvr_diag_ln_regs),
+};
+
 /* Multi link PCIe, 100 MHz Ref clk, internal SSC */
 static struct cdns_reg_pairs pcie_100_int_ssc_cmn_regs[] = {
 	{0x0004, CMN_PLL0_DSM_DIAG_M0},
@@ -2698,6 +2727,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_link_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2705,6 +2737,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_link_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2731,6 +2766,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
@@ -2738,6 +2776,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
@@ -2764,6 +2805,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
@@ -2771,6 +2815,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
@@ -2797,6 +2844,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
@@ -2804,6 +2854,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
@@ -2830,6 +2883,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
@@ -2837,6 +2893,9 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
@@ -2868,6 +2927,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_link_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2875,6 +2937,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_link_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2901,6 +2966,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
@@ -2908,6 +2976,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sl_sgmii_xcvr_diag_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
@@ -2934,6 +3005,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
@@ -2941,6 +3015,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
@@ -2967,6 +3044,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
@@ -2974,6 +3054,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
@@ -3000,6 +3083,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_SGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
@@ -3007,6 +3093,9 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[TYPE_QSGMII] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 			[TYPE_PCIE] = {
 				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-- 
2.26.1

