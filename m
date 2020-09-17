Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00026D646
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgIQIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:20:29 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:59928 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbgIQIUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:20:22 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7SkYn008576;
        Thu, 17 Sep 2020 00:30:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Cu4Hj69hylhcYQpKYXyaQcqDnwnLCoaQsCWtja7gWAg=;
 b=B7PY5dlOa1vasLnxB9FJEzbePIj4DK3yDoPiya0SMxJqKcrpNMqI80h9XxyEP4oKKYas
 KddjEdLHLtIpou+d4/SJm37U8WyvVUSWMv3WWq8asEL6v7HCBNU0XEmZTl5wmTezQivt
 lNOk/WWOWllNHH23ZeFM1sKKeuHkP5GJVUu2hojIYuQZGr7BtFEUGIi93wucCOQIokW1
 T/iEax898ACsHAZAw+W6xhNdgTuExowCgcHXtQHLg4WI+NuA0zfSrhHTTGLbqpdujoIt
 JnBkFdD+vCnOIjjGpN9A5U+BlqrjCQZMSTpg7VboujokUk8v+UzM2Yyi/m8IVIsiEUG2 qQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njxkpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCZZhUHfTT9URCUDIVuVd0zB2NHsiOalSavz4/NBXZpZKfSnN9/GpPVfOMCrrAhFU+Kgogre9FDRzn9QFk09IEq4KeRjZlDBou01PH07haYyA2q/pzxyI4CXJONbINtUcI6O53HsyL0YkAH3KOWVKCf0/aQkY4n2Oc4na8OcmUG36x7IuBI08X43W5k/VmkF8KtaNUuODt8qHUIOYXOp6TNiM55tUDvbbRMSAZBMbMiSEKF2So1oF4n/x1KCsLYA61L2tZkrfP21cba4V+HoepJra7Vxi21BGVLDC8uuPYMz0xHB8VsyCTxHzd2kpIe5PrTR2+W6zeQekeGRAAct7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu4Hj69hylhcYQpKYXyaQcqDnwnLCoaQsCWtja7gWAg=;
 b=GK8CXgxEhP7V1dhdrhjdkXHcSkI8NBPm4TcW7w9nALnPjKehtpBez7pFU8ccYbPQieJnXPLKXGkrdnfzj4efvDsjQME/1l5sLo7fKPCAJbdt8Lx1DbUbtiaHqIGzikXcmAC4xNCX6TbhFRRpF3hlRcRVP71Nh3FRVt5ve8lOxVkczBiVRYOlZHfQfehXIVz1dpHEoE5n49ju+Ge1joyhmv6C2kYG4Koy9AjRY+F+bGVs8Ej3wSYjlm7+NbAZt9LNUohLkDYRWHPDo0wGJo1LLCLfjhL/OQQZzNL28AgtZDGlQTUMF1fNmgK0pxvdVrDLm7/7VTT8tf3GVi9g0IjTyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cu4Hj69hylhcYQpKYXyaQcqDnwnLCoaQsCWtja7gWAg=;
 b=ALyahNPIfswLHB2WTxacmESpXc7EjSp0dnuERs+J3nDLFkOIDK4SxNq9S8X2B+0IiqecRIyISKIMOFFl/VO2/qCy9+dr/h1GAupTeNwBQ03gttu7Pd1O2BYlhCvkr+8rKFCYbGVjxvB5l7CZHjkMeY2BkMRRy03MtVMsmhtAr1U=
Received: from BN6PR14CA0014.namprd14.prod.outlook.com (2603:10b6:404:79::24)
 by BLAPR07MB7796.namprd07.prod.outlook.com (2603:10b6:208:29e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 07:30:52 +0000
Received: from BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::82) by BN6PR14CA0014.outlook.office365.com
 (2603:10b6:404:79::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT019.mail.protection.outlook.com (10.13.183.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Thu, 17 Sep 2020 07:30:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHX011305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 03:30:51 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:30:48 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:30:48 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7Umoc009812;
        Thu, 17 Sep 2020 09:30:48 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7UmM4009808;
        Thu, 17 Sep 2020 09:30:48 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 09/13] phy: cadence-torrent: Configure PHY_PLL_CFG as part of link_cmn_vals
Date:   Thu, 17 Sep 2020 09:30:42 +0200
Message-ID: <1600327846-9733-10-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ac19930-58a9-4275-11ae-08d85adb9b1e
X-MS-TrafficTypeDiagnostic: BLAPR07MB7796:
X-Microsoft-Antispam-PRVS: <BLAPR07MB7796CE2B8DE6A11DA00BF210C53E0@BLAPR07MB7796.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8LRYOTXN7QFBXeRg6fejKau1iO4dWkGj/ZUS2iTL2Yq6qRBifVkIllJ20ek/c57kILmZ0ZdSCEdO2cVp0UPDX4vNkIRjYAyf192Bp+Tpor6bk466GMvz5hXfxmCMBluQJyYa6+X4Stpx+PmVVzyZwrg/xpCSPEbitzDvWprt6CkNQwK+zX+VbLHl9TG9H4k8e3jW1be0YKf1EuRMIIjze33+ny4gpxDKKnzBNj0Qgye1psLaH/e8x/0JKebCBWz0Upunh63IXByUKqm9+bQk8kNjd238tAO2ttp9B83I5j2DMtGsjBkiM07HiXmgOM9SPAg2EouKRugeeF7y4EgDF963/8mUecWeU+cuAVV+/jJSn3EWkgKzEq50dnrmEb2n6UiJVfOnqFrHIOv4LLdNlzipmSjBj/pl5mfvmt/jGKEBO1im+eyBaCCvmkmZr1KOkfJorYpbX5PTORLj77xCeUmPNnLxaZ9YZ4eTUkY3+3w=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36092001)(46966005)(47076004)(82740400003)(356005)(82310400003)(81166007)(8676002)(83380400001)(5660300002)(2906002)(86362001)(186003)(26005)(70206006)(336012)(6666004)(36756003)(316002)(8936002)(36906005)(42186006)(478600001)(2616005)(4326008)(110136005)(54906003)(426003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:51.9422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ac19930-58a9-4275-11ae-08d85adb9b1e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7796
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=767 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include PHY_PLL_CFG as a first register value to configure in
link_cmn_vals array values.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 0367c0fe15e2..0c4abe959f19 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1830,7 +1830,14 @@ static int cdns_torrent_phy_init(struct phy *phy)
 		reg_pairs = link_cmn_vals->reg_pairs;
 		num_regs = link_cmn_vals->num_regs;
 		regmap = cdns_phy->regmap_common_cdb;
-		for (i = 0; i < num_regs; i++)
+
+		/**
+		 * First array value in link_cmn_vals must be of
+		 * PHY_PLL_CFG register
+		 */
+		regmap_field_write(cdns_phy->phy_pll_cfg, reg_pairs[0].val);
+
+		for (i = 1; i < num_regs; i++)
 			regmap_write(regmap, reg_pairs[i].off,
 				     reg_pairs[i].val);
 	}
@@ -1907,8 +1914,6 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	phy_t1 = cdns_phy->phys[0].phy_type;
 	phy_t2 = cdns_phy->phys[1].phy_type;
 
-	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0003);
-
 	/**
 	 * First configure the PHY for first link with phy_t1. Get the array
 	 * values as [phy_t1][phy_t2][ssc].
@@ -1944,7 +1949,15 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 			reg_pairs = link_cmn_vals->reg_pairs;
 			num_regs = link_cmn_vals->num_regs;
 			regmap = cdns_phy->regmap_common_cdb;
-			for (i = 0; i < num_regs; i++)
+
+			/**
+			 * First array value in link_cmn_vals must be of
+			 * PHY_PLL_CFG register
+			 */
+			regmap_field_write(cdns_phy->phy_pll_cfg,
+					   reg_pairs[0].val);
+
+			for (i = 1; i < num_regs; i++)
 				regmap_write(regmap, reg_pairs[i].off,
 					     reg_pairs[i].val);
 		}
@@ -2280,6 +2293,7 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 
 /* PCIe and SGMII/QSGMII Unique SSC link configuration */
 static struct cdns_reg_pairs pcie_sgmii_link_cmn_regs[] = {
+	{0x0003, PHY_PLL_CFG},
 	{0x0601, CMN_PDIAG_PLL0_CLK_SEL_M0},
 	{0x0400, CMN_PDIAG_PLL0_CLK_SEL_M1},
 	{0x0601, CMN_PDIAG_PLL1_CLK_SEL_M0}
-- 
2.26.1

