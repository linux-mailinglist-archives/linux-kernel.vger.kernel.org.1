Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAD52DAADD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbgLOK2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:28:34 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:46382 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727156AbgLOK2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:28:33 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BFAIBAv009334;
        Tue, 15 Dec 2020 02:27:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=8KS+knvQnTfrgSTBCCK3t8gfX/n8zSMAe1SIAY3d+NE=;
 b=RS+sxRpmYUh3synwU5/vSRT2k0xOBrlZox9BJlH7gNSnl0EFePr5x4TSHi02QtY32ell
 M7NxhzR3V4bEoOc9iWnLn/h+WAhGOgMvTUIcJPmR+7ZkZZYe5lhemf9jL4sn/NFGH2MI
 AlcxgYy+aIR9zn4i23/05VDDnLfGKh3sYqRXfZdlmAGucq0Tx5/HmZDkEfggjQEPsSge
 QJ07No0IMJDu3/V9/lfmMchP66w6ZPy/ZpkVJb3zVt78UpA+1SESTVLCsj6AQVYXGVxT
 QGQJjkOHyFeJ3jech4i2aI/xYi3oZ/Wu439B5vx6ACGzRWwxYrdX7+6P9kFwQ2jBa2ZP 8Q== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35cua28bk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 02:27:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DXtdXCyc8gEJi8+f/vHVxWPeLNUZhwYUawpkCNad53X4/rP+SCdH6Waeke/6fmgLowxMqhZkEoWsWG67LvxvuGmnaWKLLD8HHWyGl49f/6t8Shi2FGIZzQOQk6y8d6HW4hU1oL8eW6InQc1kwlJb2Sqexq/sc3OYUzKkg9jipaAm2oG3FyQ5SyVS9CAu0JaL7ltqJ42c3bCtitMXFJIJZRt7Yz1OfBL+70TxzcWFeh0AluysNvRuIapys4QA/GwcqlkRmBum0p0ENw3XuGXHIYs2yzvqxfwo+U61rIZOBglRs05V5w0oA4qvd8HKwpIDt+mWjuOyTSVj3k4qGaFHfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KS+knvQnTfrgSTBCCK3t8gfX/n8zSMAe1SIAY3d+NE=;
 b=kyvZxKoYo+K59VTXHU2EV/+V8L/nFHLr0yH58i69Mxqi4UV1TlNJsuc4wrJ8tjdQP/+TZOmc7AgDbO98m9c1BBySQEihPZWmZ4y4OQN+Ue5ZDweeXUvt8JZgD+CW0+kUswkc7zT7PISRBQdLvKDk0GqnJUANWvJCDcGV0p2FDw9DmX08ou+/indPwHcV+KLCNEhD97PbCiZsn72PpPNCM03snBg3oIr1eGj7oai1Ah1bkD4B3p8IpCbOd8bvpWFsKSxEaOICF6EP/m6ap6XeFdZfExrbka31rDngGSpQilYgjEPE4IJB5/5cpZTV3MOxsLetKqIpvFRi3GBf45gxpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KS+knvQnTfrgSTBCCK3t8gfX/n8zSMAe1SIAY3d+NE=;
 b=Yzyhkudl7JiKtY7sQcHvn+1HvDb6nz/EfaB7rVZVU8STA/yxFWDYLzRK1JXO21PZ0iN+pHR1HWKPrLRrLKZn/6jvW6lZU0xJF0yzdJ8/D9c8/jIBZNzHw7pXio3hawRKt0tESqC+n+aLH81LoLrckLqBwQgfhP4G4QFQuMyW4TM=
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 SJ0PR07MB7581.namprd07.prod.outlook.com (2603:10b6:a03:285::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Tue, 15 Dec
 2020 10:27:21 +0000
Received: from DM6NAM12FT045.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::7e) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Tue, 15 Dec 2020 10:27:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT045.mail.protection.outlook.com (10.13.178.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.10 via Frontend Transport; Tue, 15 Dec 2020 10:27:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0BFARHpw026851
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 02:27:19 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 15 Dec 2020 11:27:17 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 15 Dec 2020 11:27:17 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0BFARGbr003454;
        Tue, 15 Dec 2020 11:27:16 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0BFARGSd003453;
        Tue, 15 Dec 2020 11:27:16 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <rogerq@ti.com>, <a-govindraju@ti.com>, <nsekhar@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2] usb: cdns3: Adds missing __iomem markers
Date:   Tue, 15 Dec 2020 11:27:09 +0100
Message-ID: <20201215102709.3411-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 462d5775-af67-4aa3-1f4a-08d8a0e40120
X-MS-TrafficTypeDiagnostic: SJ0PR07MB7581:
X-Microsoft-Antispam-PRVS: <SJ0PR07MB7581B95ACAB898E4970B9DB2DDC60@SJ0PR07MB7581.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NHJ7xEloUrcS6cMcIRBS234kYl+6OUUVh9Ke0rUqNWQKh77yh/tci/NBFFqvGgU94BBmpi764jS9DJWcInDOUrctTj5xEp2U3sXsKxLchr5JjevnWl6xfxkKEl40qDWFhTSXMfYPmwUTQuiA3PL6S8Ochjzxs4H/azXeW8ueDsF4J9Q845h+Gh1zosFl+mpZ4JcvHBenYbTsc7OCsE8ivE23Qa3pg8acw3iRVqGeibZoqE4smoccLFvYM2PnRYpaaTigZIK7378HrmmbFX9azqfTs47S3+TWL+N1gF64P4BVv0JaJSM7y0X6IGnwHB+1DEhfyGfGr8yJ7oYgCMQF8EH0gXtGSasANni2q2I7GTp7I4VaNg12R9fSbIxQoRfK2M/M1iIMCQmLnsxijNNz2MBnalGwbIN8VKd1EMwgPfQ=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(36092001)(46966005)(356005)(8936002)(107886003)(36906005)(186003)(336012)(5660300002)(7636003)(26005)(426003)(54906003)(6666004)(2616005)(1076003)(2906002)(70586007)(86362001)(508600001)(42186006)(82310400003)(70206006)(83380400001)(4326008)(36756003)(47076004)(8676002)(6916009);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 10:27:20.3705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 462d5775-af67-4aa3-1f4a-08d8a0e40120
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT045.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7581
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-15_08:2020-12-14,2020-12-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 mlxscore=0
 mlxlogscore=656 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds missing __iomem markers in core.h file
and makes some changes in drd.c file related with
these markers.

The lack of __iomem has reported by sparse checker
on parsic architecture.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v2
 - fixed typo in cdns_otg_irq_regs name
 - fixed incorrect argument in readl

 drivers/usb/cdns3/core.h | 12 ++++++------
 drivers/usb/cdns3/drd.c  | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index f8e350cef699..ab0cb68acd23 100644
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
+	struct cdns_otg_irq_regs __iomem	*otg_irq_regs;
 #define CDNS3_CONTROLLER_V0	0
 #define CDNS3_CONTROLLER_V1	1
 #define CDNSP_CONTROLLER_V2	2
diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 605a413db727..fa5318ade3e1 100644
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
+		if (readl(&cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
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

