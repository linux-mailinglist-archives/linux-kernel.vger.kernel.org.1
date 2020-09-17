Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE01726D526
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIQHul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:50:41 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:2372 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726236AbgIQHuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:50:06 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7ShpW008558;
        Thu, 17 Sep 2020 00:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=GLcNRh5GEMYTGltjLYZU5wei2ID6oWmvcQtjbSDCBik=;
 b=WPkDIVfgsGKZVOgGUR3mDi+2CUJAH9jaqd4Bpmrx+QSqMZmCV5GuT5En94MfU7txW/Kf
 OJtM2I90umm01/2CoJybgLeNBvKfdZOCbLztA75wXiDmnbnI8R6DXyk2vfAv9iBH4Hs2
 wnnzOUWBcEiyjO4uGrHrzCzub3WQauOsx7IBMdGLEb6419qwXfn5+pR2oNL79VFNBrZw
 tJv6QJxkIqcTOfDHigjK972+7IBO/JaPFzIWQDBTIcAlRD05DrgzxO/dBW8pkNTXeH4X
 scIAf44QaWWkPLOGhYh3slxW3iPVvJLnvXj2BmgH1v5ry25e0oCI/D83FVkLcEN9Vyd0 SA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njxkpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+A/iRnPsjjNlpYknX15AonDQIgDM5grEQKKTtUVmfTCoxzB9uUI+QH6lWWr7mC4yFNHf6S6ptKUob6qq7lvMsNpnflRuTGf9kHIAiHHdhR7xJjS4oTOWrr0uQjD050aki0SroyEYXu7k2eJ4sIJnLDS5cH/aO04brYoox8IQLqyjA6Rq/K4qjZpI1ukpVjCWVTBpTDma2CbPlj4Qm+9A+gGg6W9dkwMncPDUhXtlCRFyspehIUgFC7QOezqVnffe92luLVnEvIGAGHbi7RPIy3ZtlODOFHbrCfwsOpDRwvvH+j5LOJZKlXVkxZRXVvNlgK3iJ/LcqFdZyuULTAiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLcNRh5GEMYTGltjLYZU5wei2ID6oWmvcQtjbSDCBik=;
 b=VNGpj8N4oxv+lfYlj0i/JasX8davL71yk0u/tJ5/R+1MTJe+JIAcfteMvhistTfECOgdjUbo4pbrXn9WmHpv7e1Mls5c6cpOAT7Uooedbtl+pXR5TietBqZXBm+TQ1e/XIjRyD9ClFphdMVrD645H+PDgJH3rX3meDrGB5fGQffXwPnC0GvuukP9HWD6vbBHJUN/N9lsBEBOtf+tEDOdRg42Z/M3EBgkH7bsnsY5bnwt6J0LyKBuGq710A0qn4SEZHXck3f2BDtP9T0TnzJcL/Dm/ll6Qoz97V9AzPbv4zxdsttkMwwFYCkXod1QAVExgGXEs0yat2Anoyt3/QX+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLcNRh5GEMYTGltjLYZU5wei2ID6oWmvcQtjbSDCBik=;
 b=phQ5RKvn+q0pJS2DCPN6e8jgKBVyagLciMF1bHk8JtRV+sMzbi+AS/zR88f/A3Y/5ZTTSsS0brLDOsgOcXKnFZnTHrNgBPwjau5TE+VHEJTC3N1U8KvGClefwc0Ll6oeNldAPxmAc3TAPYCfGuXh9o23HZZEEqV2OONsP6h+w60=
Received: from DM5PR15CA0040.namprd15.prod.outlook.com (2603:10b6:4:4b::26) by
 BLAPR07MB7747.namprd07.prod.outlook.com (2603:10b6:208:299::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 07:30:53 +0000
Received: from DM6NAM12FT061.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::d8) by DM5PR15CA0040.outlook.office365.com
 (2603:10b6:4:4b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT061.mail.protection.outlook.com (10.13.179.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 07:30:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHZ011305
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmJK009801;
        Thu, 17 Sep 2020 09:30:48 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7UmUG009800;
        Thu, 17 Sep 2020 09:30:48 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 07/13] phy: cadence-torrent: Add clk changes for multilink configuration
Date:   Thu, 17 Sep 2020 09:30:40 +0200
Message-ID: <1600327846-9733-8-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 617e9ccc-1d61-465f-f9ea-08d85adb9bb2
X-MS-TrafficTypeDiagnostic: BLAPR07MB7747:
X-Microsoft-Antispam-PRVS: <BLAPR07MB774755DFE8F7B4D34D93CE9FC53E0@BLAPR07MB7747.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:475;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gbgB9c5mF0Vcq3OGk4KZlVLtuLbNVnaR/7qwS3OdKpUOoLUTADVxsa+eKIvYCnnaMqYUnNM7Hujcd9DohAUX+grprqW085+btAZ5CifqumhLNLEzkcgtzzKmbwNpamXPI+KrSIMIdPpwBBXax3O2ZA5STlPMdlwSwjaXbVR8/xx1h7Rwnzu6wZ3npb0SDY3dxQ1KA4oxpigHQdyG4G8C1xIzeQM4zUc92no7Go9FudCCHNMfSSN5dwgRVLrhfLr6I+VF9qUi0qA3c60vqxNer5TUyd2SHBLVkFIH9gu3b93Mf3XVAxZwTubIDE01gt5wu+5A5F+MNpIjQEYl3XLegzQ7OmJNMSOcEsLsFEagLumEoEvbQ3aniDz04hxHI82x+JhUPSO+Z0DfwBKPR1Yv0i0qikKkZ4FpOj+yv0xABL7Ec6sFc+4lxxggZeakQsnavkp8F7Ro2WODT+o8EvFW/bit3Xh+05skr2dA6/4iUTg=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(36092001)(46966005)(316002)(2616005)(8936002)(82310400003)(70586007)(5660300002)(4326008)(26005)(83380400001)(42186006)(47076004)(8676002)(336012)(70206006)(6666004)(186003)(2906002)(478600001)(82740400003)(36906005)(81166007)(356005)(36756003)(86362001)(426003)(54906003)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:52.8691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617e9ccc-1d61-465f-f9ea-08d85adb9bb2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT061.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7747
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=978 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare and enable clock in probe instead of phy_init.
Also, remove phy_exit callback.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 41 ++++++++++-------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index bdd96c76751e..6641f2f3a367 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -273,7 +273,6 @@ enum phy_powerstate {
 };
 
 static int cdns_torrent_phy_init(struct phy *phy);
-static int cdns_torrent_phy_exit(struct phy *phy);
 static int cdns_torrent_dp_init(struct phy *phy);
 static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
 			       u32 num_lanes);
@@ -305,7 +304,6 @@ static int cdns_torrent_phy_off(struct phy *phy);
 
 static const struct phy_ops cdns_torrent_phy_ops = {
 	.init		= cdns_torrent_phy_init,
-	.exit		= cdns_torrent_phy_exit,
 	.configure	= cdns_torrent_dp_configure,
 	.power_on	= cdns_torrent_phy_on,
 	.power_off	= cdns_torrent_phy_off,
@@ -977,14 +975,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
-static int cdns_torrent_phy_exit(struct phy *phy)
-{
-	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
-
-	clk_disable_unprepare(cdns_phy->clk);
-	return 0;
-}
-
 static
 int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
@@ -1825,20 +1815,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
 	u32 num_regs;
-	int ret, i, j;
-
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
+	int i, j;
 
 	if (cdns_phy->nsubnodes > 1)
 		return 0;
@@ -2071,6 +2048,19 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
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
 	/* Enable APB */
 	reset_control_deassert(cdns_phy->apb_rst);
 
@@ -2243,6 +2233,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	of_node_put(child);
 	reset_control_assert(cdns_phy->apb_rst);
+	clk_disable_unprepare(cdns_phy->clk);
 	return ret;
 }
 
@@ -2258,6 +2249,8 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	}
 
+	clk_disable_unprepare(cdns_phy->clk);
+
 	return 0;
 }
 
-- 
2.26.1

