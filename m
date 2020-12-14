Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7E532D984C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 13:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439316AbgLNMwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 07:52:07 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53180 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439180AbgLNMwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 07:52:05 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BECRtTr026335;
        Mon, 14 Dec 2020 04:50:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=7ndgh2zkvyWfO0yYTHxcoYkDJL/y526nAPh2W1L5V+M=;
 b=HL3K2GxsWSKPgJdLYdeK4URzseSkk2e2sztBjZekbszIVrFtJn5hnlX9yceCVnTl40UA
 HTNRTKDwo7cCLuTHvb1INmfbuPIAW/1snz7anfuvXXWTwgszx7M4Purpu+faZC2z6h67
 3/x7daWks69lkfGB/2XYLcxybxuoeyCpqeG/Zs8VCnZr4JwmX6w/15CFnVBN+VhU+Y7D
 2jkYQZhkAkaLyGFxRefKqXtUENAWDSmxqfXdvXFkMvnEYiXy2x0mBwdvAgLp2vAsvsCo
 ClJqBwCBsCRaZHUmFht5EdlrsZCPHEFbGF11MhfNIcH4HQmE5QwLNCK4F+aw+gLj0WOm Nw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35cua24ucm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Dec 2020 04:50:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y52jAbcMM/STzthRCmf8VvTUkNQ9i4Ju/ZT6eDF3AkcObQX0Onlhis+211VmlJP7TxlqvzCiM6vOM8b6F20llbFsGHFJ30nN/uZ/qOhtg9Ho4YKbhge5u9atSC6QQ7UpEoZHdOwIRW4S9phVcyYN5hf+LC3MkuZlTkvT5ldXdfzLpzMJpQ5l2RklVHHyd8+MAWYAkuwAi+n8/jsrFRIUKZ04hz98jHdZcvgS+1qAN+rd5KDQVq1+B0nF+89zlyMg2ZoMp0/0VbiDVkiO/f/l4NxREnW8qohG0JYe6ylB2WufwfTPzR2JJyO6B4xxXHSwphV9ojI5wdBCMGER3BVh6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ndgh2zkvyWfO0yYTHxcoYkDJL/y526nAPh2W1L5V+M=;
 b=BoWzSLhvntrr5cVLmbUvhxx2so/otZfLuHSi39jpXnQkCc3MTlxTnW2FX+sKMmsk93Gsx4oRhQeomYC/6QUM8wxhNMEWR4P7jL4rcL3ehSL+oFZWpHpFW+tnO4FR0N/YMBf9had6JSUuT+5R4jGT5IjCc1ClTYkQ0CPNyQ8MmV5sONzoKEBomF1o9yVR7FNAnSP2AjAH/StG5Xeyx+VVj22YYLOLVYfF4AzyKgwoQThS1O8j5FfOotTEdjkIKCsl/TJ8n745Vtcyr5ducomc3+KyT3GwzK7tX2HwVqER46S0SEH/cmX5ErvGngC6UO0YG0uKUUl46lFgIzSwh20CsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ndgh2zkvyWfO0yYTHxcoYkDJL/y526nAPh2W1L5V+M=;
 b=HC+bZphMeH0tJfn2nylCsIK7gzAbSbVvIpg6DYvX9Mw5QHIQQeW0LYFYBjhCuvXWqzJ1LtNEmmiQodW1f+s97VEUTKM07dQ7cgV0RUGEVpizLeD3CG4KBKwYfAPVA3l0X20Srk3PfA2QO09x3mqpi0uAkZZc+y26McLqZQZzSQs=
Received: from DM6PR13CA0023.namprd13.prod.outlook.com (2603:10b6:5:bc::36) by
 BN8PR07MB6164.namprd07.prod.outlook.com (2603:10b6:408:b1::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.20; Mon, 14 Dec 2020 12:50:54 +0000
Received: from DM6NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::5d) by DM6PR13CA0023.outlook.office365.com
 (2603:10b6:5:bc::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.12 via Frontend
 Transport; Mon, 14 Dec 2020 12:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT021.mail.protection.outlook.com (10.13.179.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.10 via Frontend Transport; Mon, 14 Dec 2020 12:50:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0BECopwC028869
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Dec 2020 04:50:52 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 14 Dec 2020 13:50:50 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 14 Dec 2020 13:50:50 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BECooZJ029789;
        Mon, 14 Dec 2020 13:50:50 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BECooxU029788;
        Mon, 14 Dec 2020 13:50:50 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <rogerq@ti.com>, <a-govindraju@ti.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdns3: Adds missing __iomem markers
Date:   Mon, 14 Dec 2020 13:50:43 +0100
Message-ID: <20201214125043.29710-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6acfdff8-d1c0-4463-40dc-08d8a02ee4cf
X-MS-TrafficTypeDiagnostic: BN8PR07MB6164:
X-Microsoft-Antispam-PRVS: <BN8PR07MB6164628CDFD09DB506B716D4DDC70@BN8PR07MB6164.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AR7bNEW+ZO4m9CC9MUHnwX6SyALGPZuhuAq5DSv0GJb4I4K+7QwIvBMtNJTGE2plWSydVhHmF3g5Ct/e7zdFEvs1pf9YIvuWB7ACduTJnZoYUNZTNu4cos3JqjF/cIAHeYuGXZ9htTJGBSHAFG8VVblTTagb+PztpzR0+zATFe5YlIono6EDKwmuZgDWDfeZbp8kLwtVBoGsVS54OsLwqKs6mWcGqc4T2KyJnzU+EH0T659+kQCJ/nZix7kVmQFfdlM8m1y96bXxCQN0d+cT3SwJBM9E/zapF8+c/qFTO/MbrwJmvMojfJAsf1JZegph1xIC38EeNn/vmdtOrXc58JoSiTxUvm6JlDj0i0gZ99xeIkWSYqheaKyr34RhS0G2lT4F565ViHS1aVArwHFHEpCPhKbBhbl1xUE52bFZSpo=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(36092001)(46966005)(70586007)(1076003)(70206006)(54906003)(82310400003)(356005)(42186006)(6666004)(7636003)(86362001)(36906005)(508600001)(336012)(107886003)(26005)(5660300002)(83380400001)(36756003)(426003)(2906002)(186003)(2616005)(47076004)(4326008)(8676002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2020 12:50:53.9633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acfdff8-d1c0-4463-40dc-08d8a02ee4cf
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT021.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6164
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-14_05:2020-12-11,2020-12-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 mlxlogscore=511 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds missing __iomem markers in core.h file
and makes some changes in drd.c file related with
these markers.

The lack of __iomem has reported by sparse checker
on parsic architecture.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/usb/cdns3/core.h | 12 ++++++------
 drivers/usb/cdns3/drd.c  | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index f8e350cef699..bfa39795208e 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -86,12 +86,12 @@ struct cdns {
 	struct resource			xhci_res[CDNS_XHCI_RESOURCES_NUM];
 	struct cdns3_usb_regs __iomem	*dev_regs;
 
-	struct resource			otg_res;
-	struct cdns3_otg_legacy_regs	*otg_v0_regs;
-	struct cdns3_otg_regs		*otg_v1_regs;
-	struct cdnsp_otg_regs		*otg_cdnsp_regs;
-	struct cdns_otg_common_regs	*otg_regs;
-	struct cdns_otg_irq_regs	*otg_irq_regs;
+	struct resource				otg_res;
+	struct cdns3_otg_legacy_regs __iomem	*otg_v0_regs;
+	struct cdns3_otg_regs __iomem		*otg_v1_regs;
+	struct cdnsp_otg_regs __iomem		*otg_cdnsp_regs;
+	struct cdns_otg_common_regs __iomem	*otg_regs;
+	struct cdns_otg_irq_reg __iomem		*otg_irq_regs;
 #define CDNS3_CONTROLLER_V0	0
 #define CDNS3_CONTROLLER_V1	1
 #define CDNSP_CONTROLLER_V2	2
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 605a413db727..0701853b501c 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -27,7 +27,7 @@
  */
 static int cdns_set_mode(struct cdns *cdns, enum usb_dr_mode mode)
 {
-	u32 __iomem *override_reg;
+	void __iomem  *override_reg;
 	u32 reg;
 
 	switch (mode) {
@@ -406,7 +406,7 @@ int cdns_drd_init(struct cdns *cdns)
 		cdns->otg_v1_regs = NULL;
 		cdns->otg_cdnsp_regs = NULL;
 		cdns->otg_regs = regs;
-		cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
+		cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem  *)
 				     &cdns->otg_v0_regs->ien;
 		writel(1, &cdns->otg_v0_regs->simulate);
 		dev_dbg(cdns->dev, "DRD version v0 (%08x)\n",
@@ -416,14 +416,14 @@ int cdns_drd_init(struct cdns *cdns)
 		cdns->otg_v1_regs = regs;
 		cdns->otg_cdnsp_regs = regs;
 
-		cdns->otg_regs = (void *)&cdns->otg_v1_regs->cmd;
+		cdns->otg_regs = (void __iomem *)&cdns->otg_v1_regs->cmd;
 
-		if (cdns->otg_cdnsp_regs->did == OTG_CDNSP_DID) {
-			cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
+		if (readl(cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
+			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_cdnsp_regs->ien;
 			cdns->version  = CDNSP_CONTROLLER_V2;
 		} else {
-			cdns->otg_irq_regs = (struct cdns_otg_irq_regs *)
+			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
 					      &cdns->otg_v1_regs->ien;
 			writel(1, &cdns->otg_v1_regs->simulate);
 			cdns->version  = CDNS3_CONTROLLER_V1;
-- 
2.17.1

