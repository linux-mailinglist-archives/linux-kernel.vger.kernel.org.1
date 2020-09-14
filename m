Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B3E2689A5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgINKzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:55:38 -0400
Received: from mail-eopbgr140050.outbound.protection.outlook.com ([40.107.14.50]:56899
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726428AbgINKzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:55:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlwbEv4EZyR+UYAslKBM1jP/TTtDyVPd8CkSu9ZbarvWLh0su3q00TIx1DgCMxhFytPhUcMHOKnYmwuMajm16IM59NmwCWKB9KgS8txTxULpo3/jD9xXVTTLbaVX/A4nsYBgWJYvvWOAmUa8ktml+WwzA1F2eq8lwMHTukfc4muOxtL+SdAmHMgP1gnOFmQnjI1nlitz5/874CVLLyJA+O/Ah7wBsPpvdPSqGMIX1yPlU0ZgiSvxzNFTdfWQ/BJxL1e8B1uxMThFqh+cclfp0qiTj8CzkNSIyz6DldeSl42nk9icEI80MScaB/tA8tWlQUJj30cVWUUHHsaiytKJ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9S7CUBlKFgLevPePCiNqHaY0Yb/SYTZtzOqhURdUaM=;
 b=gmCSp/KKBJLuY8HKf1Lnt/YzS9JhuFu+a2go7JiW/9/0WB1+/PuUOZn+o10XcZY7btdJ+bsBET2EJUhHlB1UuigkxzOHGU3TMspyozeruKPq1J6fEl9GRfxZiq3QhgSGSlbQI91m6gUjdRR4Yn8tN/iTSWkuKEISbixQI/7rMsEJUqd1cRjS8TyGY7y1Zn0usNDPRvyCGgJBC+YtR0sCJMhcPM76jipVcszdlqXf5Rvvzgue4usLgXXjUq6/89E02DKgfnw5Cx077PaBlYjYDmr4JoLWuA9B9mTI1SMHV6kd1e4EIST7IvH7ehJnEL2PJ9ibBg2gHAyaTnM1DDeoog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9S7CUBlKFgLevPePCiNqHaY0Yb/SYTZtzOqhURdUaM=;
 b=DfwM1EN+yc0BjSFdMRYtscZ0LFM8P/EAfIQHD53FfasVp7+k6PKjMuBEh604igtMJt6k9KryHmUtagvvfFpk5N/8Sr9BJ2Z4Ox+/nftu1crdwCXpFMIh1t7sOf0ZT7crlJvJUP7sClj8SwwqlutCV7kLOAncmBYsqamkNnDlPQA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB3134.eurprd04.prod.outlook.com (2603:10a6:802:d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 10:55:10 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 10:55:10 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com,
        anda-alexandra.dorneanu@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 1/2] bus: fsl-mc: don't assume an iommu is always present
Date:   Mon, 14 Sep 2020 13:54:58 +0300
Message-Id: <20200914105459.27448-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0PR10CA0049.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::29) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM0PR10CA0049.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 10:55:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0d41e8b4-00df-4366-bc80-08d8589ca615
X-MS-TrafficTypeDiagnostic: VI1PR04MB3134:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB31344DF07B27E8B1718EBABFEC230@VI1PR04MB3134.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: viTEfY+p25rnXFPPTMX/+NLrJ9a3FXg7eOuMm76D7iz2GKZpTPu9WjCA/esB5rQr8PF/xCI0Py5qJ4ZXVqPHem4AEjh2VM9KVJ1Mbkev7G6kpO36roYtEro/WmlWbPDa2WeWgtNKIOCkA/kCfic21OcN+CKSH2F3lyw2dsI31Qz6HXa9w22fiRto2a0oBZvCr7mlxpThcSkBHExRYFXUXTQshVv2IxaCqXdebfnHHHCjpBfwmezSxuaTp+iubAGbIZKbbSiNc21VDqgOxBgtmFetlU0MI4bq2gbwyOVW5dqaUpjpXWOfSMUjjxjidOgwUM91Yta28ER0y/HVlhPrmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(6512007)(36756003)(2906002)(1076003)(83380400001)(186003)(8936002)(4744005)(316002)(4326008)(8676002)(16526019)(6666004)(86362001)(478600001)(2616005)(6506007)(44832011)(26005)(5660300002)(52116002)(66556008)(6486002)(956004)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PWksIsosP4uq9e9mPWNByqDEKEWQ8pw7IaL2OXqtd8U1cU3ko9maxFfFxZTi7fTTMZ00LgX8iMDSFfaagIfN8CWqGCLUHbC6sEhogcjdDIqL6SrptO4IIrKnXJhz+7QkWtZv9mZqwGQ4AJmslvD6RvJqNGqhKaYUgbBFhoQtPywJUtZI2YIf42eX4ORCqDF12WYYqBXMXL4r5z0h9BCYGMs8E3pSLFT5xPrwBvlWflQQaV7Cv1rH3OX8BnELiUlaIuvz5XikAm61Jl1JuBHjqlxFE3OqrD/Syne0VJK0X4yTMchjglKEOGLQGNDI8nQzm5F8IVs747AQvk5chqnDT0MXrF2tQUXwo7gNBulNp/TDAH7a5TIzEimkEK6kPLttHHEbq61BI8zlVU6YElmnP5vM14y8jUhUGRdURL+ZeNNZHBQxoKRbERsjDk5WLe8yAdjYq01eup/EerjHYcTo2KD4Tvtb5Yph5bmUv0vpgFg5vFtpO4FhOlqax0DZLsa7kwHMCOE7TiNdBDvEuXpHhk5SNRVIgqWKnbx/vFYnY55kvC7MZRvuVsR1DgI3HPVR1HP/hwWvQaI5qXqty2CRFcYLIwLkfbjdHX0znpSkaDaTipUwHhE4LcU48ZVsq0bSpm8Bwr2oDak85Hc1pOgeuw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d41e8b4-00df-4366-bc80-08d8589ca615
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 10:55:10.0118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x28gr0nGiwLQX8pSq9HsbuNdQQM7jBhcfOTHjuQnRDWk7rlWxH/B7bTzrp9WV/yDRyjFd2Chum9KZKhEhu6EEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are certain scenarios where an iommu is not present, e.g.
booting in a VM. Let's support these scenarios by dropping the
check.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index b69794e7364d..b0449df117e8 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -908,9 +908,6 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	u32 mc_portal_size, mc_stream_id;
 	struct resource *plat_res;
 
-	if (!iommu_present(&fsl_mc_bus_type))
-		return -EPROBE_DEFER;
-
 	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
 	if (!mc)
 		return -ENOMEM;
-- 
2.17.1

