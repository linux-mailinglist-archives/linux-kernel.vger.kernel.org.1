Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE29726C78E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgIPSaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:30:19 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:44508 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728058AbgIPS2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:55 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GIQhgp014191;
        Wed, 16 Sep 2020 11:28:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=eQEDde8l6HfVjrSAyMZUtq/TAQmeDBpPN5xN0gs+rcc=;
 b=i2YoQlWBwScKmq44VAD8+7HSKNER70uYFi3uoidQBBde/u21tFZq44pXUx7IanbR0Oom
 qGLwB7k/4NBrme/mJc6ZVm9ObO6lGWSW7Rv2j5VtYL4dVn9yZWjXjyPAzsxR8hwnrQ+r
 XTwjfJQDyHxDooP2RtONHLpUGDXzVKDX3LyD2o3UIhNFYmVXOyAW44EWToFqZpnk1cMZ
 VU+p5Ew2qM8M/jKlrvnkOzMpRmweoUvG9L67oz9cpI532DT/Ez5bqEEFo+IPvHgNHbI/
 MoUWkuH4686biJMTzdyauRJPLbpAWb9SW8RbkMf6COvrKeP1YFvvQ5mBhKME57DuPtmG lQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmm7ka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 11:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3pEHWl8kTLJJT9r21TbSZMsT8OqxQ7guQIuQyfvuzgYPRKt+eFI1Gzcl2mzp2i4B6QESytBiGMCldv+3F+P7ezgFVfPQN05VIZfkU0xmCmBS2rVQwFSZJfboLLyA6evGlyILxniJHogKeQqcAFd89PkviE7jzeXwuKEi7zIYgCINI4ODWkCIpPCiPGap5A9V6GQeoT4TiRkxYGMg0edOT24Va/8+8iPSyC1Fwu9vd6xHfPtJ7NBYxpbEiJFjTn3JoIoLbVDXMmLHf1qhhZM5O7nOdRsjlHCajkP37BKIiZmJrFXqMNchjNLVxW5/N2awRTbUJrhC8xORthdHTjdig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQEDde8l6HfVjrSAyMZUtq/TAQmeDBpPN5xN0gs+rcc=;
 b=IY3BkVUEEfbIu+lBXFnnCZzvEU6E4JOjwgIlhek+wXaMyq3Kk+7gC56J2nsQfL0iCRwARHe7Dq3jZZ3BlpTLakhhXD+qYXxPSS2kauCOGy0ATF+IjNtK6Aliob75WFWqCFKsoCBaqzXcw0YmfnE4DV5bwMOdHDTV7oIPhBKh+CnZFuV3gRvJa3yWbmMCx0UFpSQtXAzM3lSBtOGM4YRGqRejgzngI046grlDde9zQk8IDt4Ob+P93mRT8WWWN/IOSvRNbJDcfj9brO1if/FO2eqndYBfkDEO6D/R0/gT42P9scv4eezthVvgYXoHsF41ZaspvIuxUkVEhoPbL30rMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQEDde8l6HfVjrSAyMZUtq/TAQmeDBpPN5xN0gs+rcc=;
 b=MIRDeTZPf+AlPZbFBmyQWqTEBfH5zsu3QIW084lWyZpF9qSnOeStaUFg4TvuKNV0h8ONOFUhwk/TWrGdmPb/cjP3zcPwllf6V5qnG3yDNs+xwc8OSVKmoW6llrLY3v9YbLgEYynSlTtKI8ZBTWmGxdLIH4t6mGqunvRB4A5/IuQ=
Received: from BN6PR03CA0071.namprd03.prod.outlook.com (2603:10b6:404:4c::33)
 by BN7PR07MB5281.namprd07.prod.outlook.com (2603:10b6:408:32::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Wed, 16 Sep
 2020 18:28:36 +0000
Received: from BN8NAM12FT006.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:4c:cafe::97) by BN6PR03CA0071.outlook.office365.com
 (2603:10b6:404:4c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend
 Transport; Wed, 16 Sep 2020 18:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT006.mail.protection.outlook.com (10.13.183.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 18:28:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISXhP016248
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 16 Sep 2020 11:28:35 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISW0a009257;
        Wed, 16 Sep 2020 20:28:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08GISWXK009256;
        Wed, 16 Sep 2020 20:28:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 1/7] phy: cadence-torrent: Use of_device_get_match_data() to get driver data
Date:   Wed, 16 Sep 2020 20:28:25 +0200
Message-ID: <1600280911-9214-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
References: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3cde3bc5-896a-4f0b-84d4-08d85a6e5311
X-MS-TrafficTypeDiagnostic: BN7PR07MB5281:
X-Microsoft-Antispam-PRVS: <BN7PR07MB52815576ED5163D768DB9425C5210@BN7PR07MB5281.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:130;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38SPgE8bU1xvEsbHtCRYmpKyS61VgdmwuXQSzlydVtmxaHl8W9a8z6uEUq37ao/Gkmel0R15+fdyhQ5yJWEa87z0K1sn0OtVNFJGCMUyCl5xZ2G/78BNSfon+PbQuSBmTwWiESzDkP6boIcw8llXs600jatC7YQAhT8hiEyFlnwRIkgcXaSQSax8F8oVMnFTTr/iwfa6Hm8lL+w3b1MnfOV/qGGu9nDwGZ265wSNiNpyspNCC1LjnM9aOloYvnGi4Iz7ySjiHfRm8rp2RcG5WLox7XVGHJkCb+f+zZ0STRkidYMBLq5ms7MxQAjX3SLBvJ0Zv/w0qKT/auKmii5qjxvseJEfR6Lvr2n1G9Kvc2s4DRoFJVT4TZCgMgBYbLmvAB4bQ/RsV9bNU2ojiIjlqoLDefmwwIMNWST3LCAWlXk=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(396003)(346002)(36092001)(46966005)(47076004)(356005)(82310400003)(83380400001)(7636003)(86362001)(8676002)(2906002)(5660300002)(36906005)(36756003)(42186006)(26005)(316002)(6666004)(70206006)(82740400003)(70586007)(336012)(4326008)(54906003)(2616005)(426003)(8936002)(110136005)(186003)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:28:35.8125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cde3bc5-896a-4f0b-84d4-08d85a6e5311
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT006.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB5281
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to get driver data instead of boilerplate
code.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a065fc17de65..0211083a4d09 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -183,8 +183,6 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
-static const struct of_device_id cdns_torrent_phy_of_match[];
-
 struct cdns_torrent_inst {
 	struct phy *phy;
 	u32 mlane;
@@ -203,6 +201,7 @@ struct cdns_torrent_phy {
 	unsigned long ref_clk_rate;
 	struct cdns_torrent_inst phys[MAX_NUM_LANES];
 	int nsubnodes;
+	const struct cdns_torrent_data *init_data;
 	struct regmap *regmap;
 	struct regmap *regmap_common_cdb;
 	struct regmap *regmap_phy_pcs_common_cdb;
@@ -1710,24 +1709,22 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	struct cdns_torrent_phy *cdns_phy;
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
-	const struct of_device_id *match;
-	struct cdns_torrent_data *data;
+	const struct cdns_torrent_data *data;
 	struct device_node *child;
 	int ret, subnodes, node = 0, i;
 
 	/* Get init data for this PHY */
-	match = of_match_device(cdns_torrent_phy_of_match, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct cdns_torrent_data *)match->data;
-
 	cdns_phy = devm_kzalloc(dev, sizeof(*cdns_phy), GFP_KERNEL);
 	if (!cdns_phy)
 		return -ENOMEM;
 
 	dev_set_drvdata(dev, cdns_phy);
 	cdns_phy->dev = dev;
+	cdns_phy->init_data = data;
 
 	cdns_phy->phy_rst = devm_reset_control_get_exclusive_by_index(dev, 0);
 	if (IS_ERR(cdns_phy->phy_rst)) {
-- 
2.26.1

