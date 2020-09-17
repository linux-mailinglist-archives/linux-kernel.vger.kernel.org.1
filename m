Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96FF426D581
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgIQIBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:01:47 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31004 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbgIQIAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:00:07 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7Sh28008564;
        Thu, 17 Sep 2020 00:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=0HC/0MJmwL/PmZpo5rZAxj3F/bSG991OemfSUHqUHkA=;
 b=htdRSQHUmyetkdowAh+FUSpreuMqueIqn/rGwR83tCbXYEf9PMMMtvvP5GIRYyMaj4/t
 wJFkyJaRWOG9FtxF5/sVtsFmtgh/ZQSKDqHUdRlS9nxxUBSdCiOlKeD7v3Ln7EwBknfM
 wA4tEN2qvPVHaAp95YMyzpcRltI8AoBx24BlfciXGIVadzpj4JDE8q4XL/dlRg2gZFU+
 YeSbbgRCE7RwfgaQS6GcZy43MzAj+GosHQ4bZ70UQFki7De7MsEV9vbr+RG/slTb8HvX
 vP8p17a1/v7hZ/rIzYNmYQSg6eyH0ToW4uttnHk/phhYN572tJRnbU2R7g+MWv+XnO8G Cg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njxkpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bodxLYLKTlX9iAX3+aMrsl+OAIfvLloqIqzfRSQXQg710qH54STQFm1n//jCc0CAdoHGMU7AVNgnJJpbvAnMS1ygBxFQDlkKMxUUIQbchrm0t9UKuFdhOJ3opVdnbQLW4BB7gtY2tQGBktmWbb0VBWKR1b1nLrzY2tnwDXQCdXrTVYjdUqXR9rDls2VTsRaebaGN2++2JK7teg+3L/OTxQLrPx5sNU1z2Wgm1TucuXcDpIocpswMnkr8Xdb8fUq51XpCLpXwVixUe3Ptvns3WLPv99XXlV6G6eic7LR9is+AYHHcmOQMAvPQOO+maBOgo11cXU2h7c4duqm8Co5nTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HC/0MJmwL/PmZpo5rZAxj3F/bSG991OemfSUHqUHkA=;
 b=AwFk8m0rAnRZ2k4DX3qSkcZZrDiTJPA8W2Q4B5xBxVNnZgQ9kSLf4lB8QJJEnC3kxp6VpXr7YHNzAEcvxWwraiST188oa/HFT2+pcsghcNrSLlWGNn8OfzSjA+xuO1CHllSp5qzZQrVwIKrgSJovXmRFDEAXOatRxYt44cU4qQWOjy7gj0cQuokkyR4Ob3XMVVVRZCCHZ1Ek992HUhq9/V5Ajoh9I45bBNvtrcONEVicdPKlRQwU8BatiDjqaKKHlyi8fWV+24M7rULKCxY2N12bfgSoE9XyLOkBi5vw2mkBHNFQYSR6Q0OmZeykmF1/atKZrECKlEjUb6cP0zMUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HC/0MJmwL/PmZpo5rZAxj3F/bSG991OemfSUHqUHkA=;
 b=te2EJgKe7yMq749PQfFSu3TGsUT9G8sDNDgOpZ+W1a8T9pUenkd8wuoF3qxjdKCnw07ekrhGGvTNc3AAGkvHAq9KjtiIBGeHO3tC47GPSBuvQaz+yjoLRAn7hcyU8ihu1dzmC/VrMIobF8UEeSALfwnuQqA0+N+DQOHrpCKr+SA=
Received: from DM5PR06CA0055.namprd06.prod.outlook.com (2603:10b6:3:37::17) by
 BL0PR07MB7891.namprd07.prod.outlook.com (2603:10b6:207:34::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.11; Thu, 17 Sep 2020 07:30:52 +0000
Received: from DM6NAM12FT026.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::90) by DM5PR06CA0055.outlook.office365.com
 (2603:10b6:3:37::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT026.mail.protection.outlook.com (10.13.179.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 07:30:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHW011305
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7Um37009797;
        Thu, 17 Sep 2020 09:30:48 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7UmBJ009796;
        Thu, 17 Sep 2020 09:30:48 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 06/13] phy: cadence-torrent: Update PHY reset for multilink configuration
Date:   Thu, 17 Sep 2020 09:30:39 +0200
Message-ID: <1600327846-9733-7-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30d3dec9-f415-40f1-a336-08d85adb9b19
X-MS-TrafficTypeDiagnostic: BL0PR07MB7891:
X-Microsoft-Antispam-PRVS: <BL0PR07MB7891816C8A47AC9DB4017EEDC53E0@BL0PR07MB7891.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qhHMyhu+Z7AysJzg5kEN9pA88NSNYHoVo0uSYjIUrOG39yBOLl8wmKGHoGjtB+9muhbHJnl7sEjExGldvXwq/zV4JrIv2cFky2nqu87GsPB7+2PZnoCfcTnfWkS2va2QzDlHFpOeGsvWJMW6ob2uDxFBKAJEVgunM7+fS6UAZPD64BK7J8nIx/r1bPYwjkErPxsQbi08rdpVr6GNWwVc3M8/8kRLcSTbsbOOzeGLTvdDKii0DYa4xdsuFd4zJKqG9AgkXvjufYV+RTDyajaTzx40axoARSpQEGlupC1Imye0gCNqf8KHhryLCWAaBITeOZxmm6ai5YRMVkRBEscg3T9LT9s7yYFn3r8AD5VBAuyx9H32fPnO+BhsQ+5o+mfK0Hg2eBnBMJFd5lCf6/SEPW0xn2GO3r3nDeb9K6BTF9RD4bruLHWh6T+gr/mh+rixa2WIjLN6maY9497CNcTtioCrkyPFL8kdZdRfarK7Oiw=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36092001)(46966005)(54906003)(47076004)(81166007)(82740400003)(6666004)(316002)(83380400001)(8936002)(86362001)(356005)(8676002)(186003)(42186006)(36756003)(2906002)(5660300002)(70586007)(70206006)(110136005)(26005)(4326008)(36906005)(336012)(2616005)(478600001)(426003)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:51.8621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d3dec9-f415-40f1-a336-08d85adb9b19
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT026.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB7891
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For multilink configuration, deassert PHY and link reset after PHY
registers are configured in probe and only check link status in
power_on callback.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 28 +++++++++++++++++------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index cd02aa47dbc9..bdd96c76751e 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1603,13 +1603,15 @@ static int cdns_torrent_phy_on(struct phy *phy)
 	u32 read_val;
 	int ret;
 
-	/* Take the PHY out of reset */
-	ret = reset_control_deassert(cdns_phy->phy_rst);
-	if (ret)
-		return ret;
+	if (cdns_phy->nsubnodes == 1) {
+		/* Take the PHY lane group out of reset */
+		reset_control_deassert(inst->lnk_rst);
 
-	/* Take the PHY lane group out of reset */
-	reset_control_deassert(inst->lnk_rst);
+		/* Take the PHY out of reset */
+		ret = reset_control_deassert(cdns_phy->phy_rst);
+		if (ret)
+			return ret;
+	}
 
 	/*
 	 * Wait for cmn_ready assertion
@@ -1623,6 +1625,8 @@ static int cdns_torrent_phy_on(struct phy *phy)
 		return ret;
 	}
 
+	mdelay(10);
+
 	return 0;
 }
 
@@ -1632,6 +1636,9 @@ static int cdns_torrent_phy_off(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	int ret;
 
+	if (cdns_phy->nsubnodes != 1)
+		return 0;
+
 	ret = reset_control_assert(cdns_phy->phy_rst);
 	if (ret)
 		return ret;
@@ -1886,7 +1893,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
-	int i, j, node, mlane, num_lanes;
+	int i, j, node, mlane, num_lanes, ret;
 	struct cdns_reg_pairs *reg_pairs;
 	enum cdns_torrent_ssc_mode ssc;
 	struct regmap *regmap;
@@ -1989,8 +1996,15 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 						     reg_pairs[j].val);
 			}
 		}
+
+		reset_control_deassert(cdns_phy->phys[node].lnk_rst);
 	}
 
+	/* Take the PHY out of reset */
+	ret = reset_control_deassert(cdns_phy->phy_rst);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.26.1

