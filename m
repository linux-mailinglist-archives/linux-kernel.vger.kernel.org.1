Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8118626C800
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgIPSi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:38:28 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:53422 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727993AbgIPS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:56 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GIOo6Q012348;
        Wed, 16 Sep 2020 11:28:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=lfE2bjkGElZnGFIJLpRAR32VLokKjBAt6fcznLw+RYs=;
 b=AAHadyVPk8FbV9W8WxxTgvU8ILnXe21c7KbxazeHrnWpgoT5ZGnyktVyrL0YrrmcVzU1
 n5E7HHybV1agL3JEQcFekwQtUNEdd39/uf7tPtiho9azT5bUlKEhupUmsiadWoDeZhQ9
 qCb4Umymddo0tosExhV9zlbqKA0zjcECE2+PaRFoPRpHEJd4L191C2TOx8aXRr2KIpje
 ivBb62c9AKKP6gQhtsF7mBYGSZGdqd55CfRAxsFCpjZmS7OYaLBKhMHhiHgwLqSn03O1
 V0NPM7gd6aJvVv+mbbEVv7MT8BFGHBq5ahzSx5E/y2hsxYS9HUCfJ9gO8qFSeTpzNzlu MQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njvbha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 11:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hH9lfBmGCi9FQwV4bPByn+0T2l9nQP0rjLxBjFvtF27unXtIWy2sWVmu0Hahf3doKM2JfUJjm7vbqVFp2UDyojTyuLop7ArpwVEyg2jP5fD1sO/G71jy0fOOYvMRr3YMAhYFEHoWgZJ29vrKFO+zbkbaSYepksLodEamcKe0V9d7ZliBQIaeqm553OojEEgdDT15WpPLt078u8FQBIneKPzXpDKZ6g+JpOFei14UYpgRKBQ29z8EBVnNqL0xmPelVIyDEfbkkmNyPnwVs4C0+fSFHV098zP+DTTiJRlHnzPN17R1nUMyfosY6GztS21syrfsfS0YxGg/tNJnrLUSCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfE2bjkGElZnGFIJLpRAR32VLokKjBAt6fcznLw+RYs=;
 b=W6g+Ml/SiRVIp32km64pu3NPq9R9EGm7JhGdgTztiO2QbsApsfgfS2PWr6QcXCb+3Z6h+OJ+jlAyCYnlcyRjIyZfWaB1XgGAItRBI89VGh1snULHtHzXgISk26m9ArvoURO97kaQMg/qA9silMFJRfg3iBJgneaf3Jlqg1dLcdoH4WaUofozuyz9BG97oV9s88BZfeeZjOFOKIjLsd9NVqz3ZA8kfL8hXVDJl5NKKpGJqNXUcAz907sXfpdqs4fTfdcj7nKt6p9aVPTBWdFuuPJOL83qJBAeBYySz7z1KvJFMfKrmH12YafuwsqkDWZ4FEIP0qsqeuOEKPE+pS8CRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfE2bjkGElZnGFIJLpRAR32VLokKjBAt6fcznLw+RYs=;
 b=ligL0b3TN+YBFqWIdKTLGyH24Yqd3S9A5HTO9McqWI0pBGlZjLEHY8I9HNbvMLcopF/FB3HlYqhYPu/vqrLnb6ozTLFIiJHFaB2dG3nrx3ZH73Hkesm999wCCVuuXnYbtmwhgOqw0Ot87cIgrgBfrH1BXj4TsnsDG8AyeNeFSNw=
Received: from DM3PR08CA0017.namprd08.prod.outlook.com (2603:10b6:0:52::27) by
 SN6PR07MB5727.namprd07.prod.outlook.com (2603:10b6:805:e1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.18; Wed, 16 Sep 2020 18:28:37 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:52:cafe::32) by DM3PR08CA0017.outlook.office365.com
 (2603:10b6:0:52::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend
 Transport; Wed, 16 Sep 2020 18:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 18:28:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISXhR016248
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 16 Sep 2020 11:28:36 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISWk9009274;
        Wed, 16 Sep 2020 20:28:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08GISWAW009273;
        Wed, 16 Sep 2020 20:28:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 5/7] phy: cadence-torrent: Check total lane count for all subnodes is within limit
Date:   Wed, 16 Sep 2020 20:28:29 +0200
Message-ID: <1600280911-9214-6-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
References: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa767e96-b934-4765-64c5-08d85a6e539c
X-MS-TrafficTypeDiagnostic: SN6PR07MB5727:
X-Microsoft-Antispam-PRVS: <SN6PR07MB5727325D297FBB8DAA0FEF82C5210@SN6PR07MB5727.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:115;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mibPOit18de69oOKovRYly3QlGQBhPa6fSfGVWINjrrLswKyv9RJjyExGd4g2fHvt3qPu9o56BAKbRXyZhULHh9mnCUEN0Y5wK8bNllnLFtDjqGshKspJILljkA4XKJHZzh5c/v3MrS+jYnt+uG+7oE54AxcQc2LZEFB8PBpPJ0X2iCK2JprdNcuD/e6BeR0uocwsZf7rW7buEfg93NQXkF8x9ZpQZwgYCar6A64NcWzVGtTio4GUVANfbBfhVe3pfe3c6ckVZsUKChKcdtDG9kRLMrdPpmISFphJz67W0QLrCrMh8v8FqdcIs1XJHffRGT0zn8ne+qOSJVXYruSd4xGbMDPGxIxxvDnGQX2+298cAyyE3u2+H+7tzTuHhqXKfDFwOSC8CuEzS92DA34h4ibFwoBTOgFMP+kxIGCaNQ=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39850400004)(396003)(376002)(346002)(136003)(36092001)(46966005)(83380400001)(8676002)(316002)(70206006)(426003)(86362001)(2906002)(336012)(26005)(186003)(356005)(47076004)(478600001)(82740400003)(70586007)(42186006)(7636003)(82310400003)(54906003)(6666004)(36906005)(2616005)(4326008)(110136005)(8936002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:28:36.7546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa767e96-b934-4765-64c5-08d85a6e539c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5727
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add checking if total number of lanes for all subnodes is not greater than
number of lanes supported by PHY.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 9dba7ba33fcd..6c199400fa5b 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -25,7 +25,6 @@
 #define REF_CLK_19_2MHz		19200000
 #define REF_CLK_25MHz		25000000
 
-#define DEFAULT_NUM_LANES	4
 #define MAX_NUM_LANES		4
 #define DEFAULT_MAX_BIT_RATE	8100 /* in Mbps */
 
@@ -1734,6 +1733,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	const struct cdns_torrent_data *data;
 	struct device_node *child;
 	int ret, subnodes, node = 0, i;
+	u32 total_num_lanes = 0;
 	u8 init_dp_regmap = 0;
 
 	/* Get init data for this PHY */
@@ -1808,9 +1808,15 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			goto put_child;
 		}
 
-		cdns_phy->phys[node].num_lanes = DEFAULT_NUM_LANES;
-		of_property_read_u32(child, "cdns,num-lanes",
-				     &cdns_phy->phys[node].num_lanes);
+		if (of_property_read_u32(child, "cdns,num-lanes",
+					 &cdns_phy->phys[node].num_lanes)) {
+			dev_err(dev, "%s: No \"cdns,num-lanes\"-property.\n",
+				child->full_name);
+			ret = -EINVAL;
+			goto put_child;
+		}
+
+		total_num_lanes += cdns_phy->phys[node].num_lanes;
 
 		if (cdns_phy->phys[node].phy_type == PHY_TYPE_DP) {
 			switch (cdns_phy->phys[node].num_lanes) {
@@ -1890,6 +1896,11 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	}
 	cdns_phy->nsubnodes = node;
 
+	if (total_num_lanes > MAX_NUM_LANES) {
+		dev_err(dev, "Invalid lane configuration\n");
+		goto put_lnk_rst;
+	}
+
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(phy_provider)) {
 		ret = PTR_ERR(phy_provider);
-- 
2.26.1

