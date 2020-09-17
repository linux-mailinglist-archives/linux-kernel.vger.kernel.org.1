Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9A826D62E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgIQIOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:14:17 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:14550 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbgIQIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:00:49 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7SkYo008576;
        Thu, 17 Sep 2020 00:30:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=whMxdWPNJDrsQjLmvtUs/Dm5ezChZM9AbWpFqKbvU8E=;
 b=N2m41Mc+pLjSWIxWoJn9MJ8KUdByLBTccwslzYERho+OM6UuYnNRwZVuc2cqqL64IQkz
 ATdCNqUS8gfgH/5D3Cu/Dr0klIxewjf0mWNW+FHW0MaEzX9HV7r9+WzbzapNSUgc7EOA
 hNGDhT9j61c0U9wd3TX1CYgsLxeDtuag6e++E3AkbrgmA647lJ65xIO9iovWHMZA8tXq
 ZMNmAna/Z/43OXPdeIx8Hj8cVYpCg5/EHeJVEwXlBIV6T91GJwJRjJG6cgt2YnVfUgHO
 HmKTx+5PX+lp4+qCa0c3XVbQwsLjWtJdd0qAT0M8n9dMoFHfkIdvnTgpww2NoqoINJKw 2g== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2059.outbound.protection.outlook.com [104.47.38.59])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njxkq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8ISYInencNwJKYLu383efHlvuNQLaP7pv4ZpQPKSv1ClU1d/FTUASCx4zg4V5MAiSOmZnnvfT705mrNsIvj/jBCWWFvWXq4XMFHqnK9Vqrf7ByPEUdwNLnt27M5iuOcdje5/Vc6rjFfsTzZ8EEq/fx41wBNwIPhV+Z3RKdE/auHpX6XZ2PULDflTlX8qnvMMQFOrVpWwpiezbLfAoids3HKrBIKRCKcGfs+SHJI1E9bt1Y6YsKsTL8uvup1vLQRF6Alqsj9tNcce6uAYyzLohWYssnPkIYlFjduNeod12IrF7RAZcKzR0xZzBpOuHIzbvlxjLSFL36mdAn1awslrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whMxdWPNJDrsQjLmvtUs/Dm5ezChZM9AbWpFqKbvU8E=;
 b=liJzOnLLsG23BiFQcMsJjK+iq1cgVngm20sHCnb3owcL9IgY54BqpyGk8H3D5ABiWpVxpUZw8OmH67ZrP8xxeOll3V1YWzciTonAgO+mvovqBWiaFM+pzGmgQgzFp0UTBy3Tec7aBE4w5z1316m80GwS60Gpd4Zgo9cxbyYICkWCc2GIMYnCOUe1bZI/mVYJOSnpus4jLXcFXjV9WMWGrC3+UlGo0O01yw6/qtq2sHMBrjeNCXAlLBSPyCRiPYHMXlsDrv/Z5+WsdMYFuZZhEwNRjGz+nAb0/wsTqi8WXqWygAGRZ2NbU7xoYt+IPYk11lcSZpb+dwiEUFPq4l3FOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whMxdWPNJDrsQjLmvtUs/Dm5ezChZM9AbWpFqKbvU8E=;
 b=AqzHaNH0htCVFST0xT67gkhpqpsvhbfACY3QQM+N47g7TmCfx0vbV7+rnJH4aVj9Zew+fqAiGyvYRiRWhX+Yn/Upkfb3IeTTtUDCHa8y2cY/3yFTU2PSzKqfK7mYhk9USviwmCiQ0aoPMpSGI1CqH+zOk06DESFP9Xi6Uennq+Q=
Received: from DM5PR07CA0091.namprd07.prod.outlook.com (2603:10b6:4:ae::20) by
 CY4PR07MB3845.namprd07.prod.outlook.com (2603:10b6:903:d6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Thu, 17 Sep 2020 07:30:52 +0000
Received: from DM6NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::1c) by DM5PR07CA0091.outlook.office365.com
 (2603:10b6:4:ae::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT032.mail.protection.outlook.com (10.13.178.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 07:30:52 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHY011305
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7Umxl009805;
        Thu, 17 Sep 2020 09:30:48 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7Umo0009804;
        Thu, 17 Sep 2020 09:30:48 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 08/13] phy: cadence-torrent: Add PHY link configuration sequences for single link
Date:   Thu, 17 Sep 2020 09:30:41 +0200
Message-ID: <1600327846-9733-9-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66f017dd-ba9c-406d-1a34-08d85adb9b80
X-MS-TrafficTypeDiagnostic: CY4PR07MB3845:
X-Microsoft-Antispam-PRVS: <CY4PR07MB38458EA7ECBCF987266D8251C53E0@CY4PR07MB3845.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1247;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uiiYpW7Kke3U0ieHnnClFHzJTtLt1MhTLJwImfq1zubl7XPWiHIFlM+ZYTpNnyjqkcPXsryeqkFZXv+ihquapD2nbHzNN/eMnQnHOmRoFqzvgvPP+io6dRe92hRmWgbsp/p+vu1kxcJxQEG4pxKvvMOC8TyL2UqH6EkVh1J/0kU8Pg66KOc38B8DxcRA5U+ZJn5ub9DB7E07r33QauakRR9ekLHdBY0CErrIy5vnn2W45krHDI7vBq42rFp2NtOuQ/rqk3bYoDTsmHZP8OEGQC0BcZjH625EAnVeE7d25kd3QoqLmA8boGc/m2WWbLkCe3klE4ADVZcGw72/pr9pC2pQrkAh6lIF6fBspx0aUsouE19AuY/w97IO9evsYOzw5E97Q3Lq/mGFFsCiNK2Hi1Rxzgj8kh8IGGh4vxWIn+8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36092001)(46966005)(2906002)(26005)(110136005)(82740400003)(8676002)(186003)(54906003)(5660300002)(82310400003)(47076004)(70586007)(478600001)(86362001)(4326008)(2616005)(8936002)(70206006)(42186006)(36756003)(36906005)(316002)(426003)(6666004)(356005)(81166007)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:52.5417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f017dd-ba9c-406d-1a34-08d85adb9b80
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT032.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3845
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=817 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to configure link_cmn_vals and xcvr_diag_vals in case of single
link PHY configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 6641f2f3a367..0367c0fe15e2 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1809,6 +1809,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
 	enum cdns_torrent_ssc_mode ssc = inst->ssc_mode;
@@ -1823,6 +1824,29 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	if (phy_type == TYPE_DP)
 		return cdns_torrent_dp_init(phy);
 
+	/* PHY configuration specific registers for single link */
+	link_cmn_vals = init_data->link_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (link_cmn_vals) {
+		reg_pairs = link_cmn_vals->reg_pairs;
+		num_regs = link_cmn_vals->num_regs;
+		regmap = cdns_phy->regmap_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off,
+				     reg_pairs[i].val);
+	}
+
+	xcvr_diag_vals = init_data->xcvr_diag_vals[phy_type][TYPE_NONE][ssc];
+	if (xcvr_diag_vals) {
+		reg_pairs = xcvr_diag_vals->reg_pairs;
+		num_regs = xcvr_diag_vals->num_regs;
+		for (i = 0; i < inst->num_lanes; i++) {
+			regmap = cdns_phy->regmap_tx_lane_cdb[i + inst->mlane];
+			for (j = 0; j < num_regs; j++)
+				regmap_write(regmap, reg_pairs[j].off,
+					     reg_pairs[j].val);
+		}
+	}
+
 	/* PMA common registers configurations */
 	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
@@ -2643,6 +2667,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	.reg_offset_shift = 0x2,
 	.link_cmn_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2671,6 +2700,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
@@ -2803,6 +2837,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	.reg_offset_shift = 0x1,
 	.link_cmn_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_link_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_link_cmn_vals,
@@ -2831,6 +2870,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 	},
 	.xcvr_diag_vals = {
 		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[NO_SSC] = NULL,
+				[EXTERNAL_SSC] = NULL,
+				[INTERNAL_SSC] = NULL,
+			},
 			[TYPE_SGMII] = {
 				[NO_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
 				[EXTERNAL_SSC] = &pcie_sgmii_xcvr_diag_ln_vals,
-- 
2.26.1

