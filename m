Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C6426D664
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIQIYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:24:34 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:32074 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgIQIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:24:20 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7MdFe003933;
        Thu, 17 Sep 2020 00:30:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Bof05TT3EiLL3OoK24xV4OmRnc8mUqPZLsiMWbZt99Y=;
 b=AP7mWlZ01XivDXuRfcQvfc1ZI5mHPAqaejyZ0Q7HtZAoVhx3ajaZe9AM6Q8RQNteYHJw
 JZuOQCqg7tksQ+ZEskzT5V7QdFrBNNoqgY/AlPkM7Ii5i5vg6QKtnUn39Ig/JcCuos/3
 qAba2CKPhyV8isZVQj6HiAZXTzUnK6TJD2f8C5yCGNltD8NmW6rjixREYFcCIMtqIshe
 Oqcl6OPvOImyeGiI/xTPPOh+vhFKOVSo4hXG2I7cvNc4RO/Op/9TWM61MvmlweKWIz+e
 9mLKVrLm/h3hiLhuKcmWPwSlB5umYQSyWuoGFmR6Y3z/lgv1ucLFfrijBs5n43l0LZJL 2g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmpfjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lot/BhPSk7RVX/FrRf34zoGC2jiq7ohz0slnBvPFNJWFdsaHe9eyL3gw/dXSbHxzn4WQPMKUZ6A0CfP58s91r3yT9vWpL97gptKdc/44rOWf+TYjPU3zB8csRcKZLEhPS1tbybXv1pR2/Zro4T/ls/7NezDnbDT264VbKY7UNK8i+tZCSaVCOBnk58yHVO0IwA68/nTkHqQyUxeyS5PejtgWT+hwL6vm1vvXOpLY3hcJUxZbYsxVA/BTfNGBueUVBdp/2tkVG8lV+Bj0IzikFU1Lyl/SDop6RQaFVMFWg05198RNlu+1sREohrLuqc0tluCN9oKMniwuQKuVJz1lNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bof05TT3EiLL3OoK24xV4OmRnc8mUqPZLsiMWbZt99Y=;
 b=V451m2lG9oOxqLFyKGHXQNCtm0fC8FOcrdrQZzcxQy8Z98gs05X7jTFrslzOPC7iMO+4GwDG4/21LYmQJShHoTUUJph9z5mi9odXqnq8byQpdfXt5AgnzSswsLUOWQwX+XBvlFBHYLYwijdQ7nauStTl59LdC/1G6oMC1JFq1jkQvsWMMuv3iSuJBDIDVCgDMaSXWtYNcpRm+xCUskBnZsoEtMB9Hk7u3yfhXS0rN1taqHZ/yuq2rSyjpTZDlqGGRuFHn/cnLKqfACeQK806xh/KiwUKiR0yEg3VICqILhj15JOl50OplCM/rpFY/+hUcuDJ4XhHe1Zmq2zYnIKQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bof05TT3EiLL3OoK24xV4OmRnc8mUqPZLsiMWbZt99Y=;
 b=gxDLqlUoc7ey5YX7ow8/N4flhMO9X1yy+DmhsAaPb6JfgpaaRpiwSG8e0n8OqNPWdKMzhhYjgsc8ruR2fP2tzK+/1GBTStCkvUw3L15tpzKlVFOfpbLkng9c3bzZh4QpwqOjf0vRJbqR2vF7W0UokaxVRXruYgiZ//QK6cL1gDI=
Received: from BN6PR17CA0007.namprd17.prod.outlook.com (2603:10b6:404:65::17)
 by CY1PR07MB2587.namprd07.prod.outlook.com (2a01:111:e400:c60e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 07:30:54 +0000
Received: from BN8NAM12FT053.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:65:cafe::51) by BN6PR17CA0007.outlook.office365.com
 (2603:10b6:404:65::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT053.mail.protection.outlook.com (10.13.182.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Thu, 17 Sep 2020 07:30:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHc011305
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UnHf009828;
        Thu, 17 Sep 2020 09:30:49 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7Un3E009827;
        Thu, 17 Sep 2020 09:30:49 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 13/13] phy: cadence-torrent: Add USB + SGMII/QSGMII multilink configuration
Date:   Thu, 17 Sep 2020 09:30:46 +0200
Message-ID: <1600327846-9733-14-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0914a5b-4e0f-4876-4462-08d85adb9c1b
X-MS-TrafficTypeDiagnostic: CY1PR07MB2587:
X-Microsoft-Antispam-PRVS: <CY1PR07MB2587616DCA53DF0011C634E2C53E0@CY1PR07MB2587.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGbWHXIjdWDqm1dv4yqREsKTtjFVvSHOR2M9/Gy4BPRcDf6QB8YS/Gg1pYLDkaYkp8CYa31ufyWv6+qsdei8Hld5s4aP7RTmRWSslb0Q2xe/FAqUjkb26D0IJKmiALZzfAQZHpE8ASM/fRfz7UGkIOMIvQJ59dGVJFCYerNdCkN6fpfdUxBnS5gGqZYenxXboKuF3+kf4fENGyBCY3TbjurbiM7I1xIPjz6AszN5160+2/a3MPfvWTar4eAoZMRaWJ2+kvhaJ0mLPGNDtfS096PWYDrFQeRqLLuHO4QsYMhD5Yo0gQgfnxLEG38Dn92ohcdKVDAfRfZk/9BdRKeDdoBth8rb0xx7j2m7RkNYqIjvKwcNrnV1E+5qzGSY3CjNfBrsyEDsRb0GS3i0jckNS16pXjy6BFddlYiEueAtm3c=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36092001)(46966005)(42186006)(8676002)(70206006)(82740400003)(316002)(36906005)(36756003)(6666004)(47076004)(4326008)(2906002)(8936002)(5660300002)(336012)(70586007)(356005)(186003)(86362001)(82310400003)(2616005)(478600001)(26005)(81166007)(426003)(110136005)(30864003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:53.6015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0914a5b-4e0f-4876-4462-08d85adb9c1b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT053.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2587
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=737 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add USB + SGMII/QSGMII multilink configuration sequences.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 254 ++++++++++++++++++++++
 1 file changed, 254 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index e82ab72bd3d8..f310e15d94cb 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2343,6 +2343,40 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* USB and SGMII/QSGMII link configuration */
+static struct cdns_reg_pairs usb_sgmii_link_cmn_regs[] = {
+	{0x0002, PHY_PLL_CFG},
+	{0x8600, CMN_PDIAG_PLL0_CLK_SEL_M0},
+	{0x0601, CMN_PDIAG_PLL1_CLK_SEL_M0}
+};
+
+static struct cdns_reg_pairs usb_sgmii_xcvr_diag_ln_regs[] = {
+	{0x0000, XCVR_DIAG_HSCLK_SEL},
+	{0x0001, XCVR_DIAG_HSCLK_DIV},
+	{0x0041, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_reg_pairs sgmii_usb_xcvr_diag_ln_regs[] = {
+	{0x0011, XCVR_DIAG_HSCLK_SEL},
+	{0x0003, XCVR_DIAG_HSCLK_DIV},
+	{0x009B, XCVR_DIAG_PLLDRC_CTRL}
+};
+
+static struct cdns_torrent_vals usb_sgmii_link_cmn_vals = {
+	.reg_pairs = usb_sgmii_link_cmn_regs,
+	.num_regs = ARRAY_SIZE(usb_sgmii_link_cmn_regs),
+};
+
+static struct cdns_torrent_vals usb_sgmii_xcvr_diag_ln_vals = {
+	.reg_pairs = usb_sgmii_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(usb_sgmii_xcvr_diag_ln_regs),
+};
+
+static struct cdns_torrent_vals sgmii_usb_xcvr_diag_ln_vals = {
+	.reg_pairs = sgmii_usb_xcvr_diag_ln_regs,
+	.num_regs = ARRAY_SIZE(sgmii_usb_xcvr_diag_ln_regs),
+};
+
 /* PCIe and USB Unique SSC link configuration */
 static struct cdns_reg_pairs pcie_usb_link_cmn_regs[] = {
 	{0x0003, PHY_PLL_CFG},
@@ -3016,6 +3050,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3026,6 +3065,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3038,6 +3082,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -3072,6 +3126,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3082,6 +3141,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3094,6 +3158,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -3108,6 +3182,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -3142,6 +3226,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3152,6 +3241,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3164,6 +3258,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
@@ -3198,6 +3302,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3208,6 +3317,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3220,6 +3334,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
@@ -3254,6 +3378,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3264,6 +3393,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3276,6 +3410,16 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
@@ -3315,6 +3459,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3325,6 +3474,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3337,6 +3491,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 				[INTERNAL_SSC] = &pcie_usb_link_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_sgmii_link_cmn_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+				[INTERNAL_SSC] = &usb_sgmii_link_cmn_vals,
+			},
 		},
 	},
 	.xcvr_diag_vals = {
@@ -3371,6 +3535,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3381,6 +3550,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &sgmii_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &sgmii_usb_xcvr_diag_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3393,6 +3567,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
 				[INTERNAL_SSC] = &usb_pcie_xcvr_diag_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[EXTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+				[INTERNAL_SSC] = &usb_sgmii_xcvr_diag_ln_vals,
+			},
 		},
 	},
 	.pcs_cmn_vals = {
@@ -3407,6 +3591,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &usb_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.cmn_vals = {
@@ -3441,6 +3635,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3451,6 +3650,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3463,6 +3667,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+			},
 		},
 	},
 	.tx_ln_vals = {
@@ -3497,6 +3711,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3507,6 +3726,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3519,6 +3743,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+			},
 		},
 	},
 	.rx_ln_vals = {
@@ -3553,6 +3787,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_QSGMII] = {
 			[TYPE_NONE] = {
@@ -3563,6 +3802,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_USB] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
@@ -3575,6 +3819,16 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
 			},
+			[TYPE_SGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+			},
 		},
 	},
 };
-- 
2.26.1

