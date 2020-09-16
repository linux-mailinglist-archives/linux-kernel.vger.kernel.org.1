Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D756426CCA0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbgIPUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgIPRBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:01:23 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0610.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F16C0A889A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCtxKKv4y2wTmH2Hm8UtAl1FN4ecYy3ygzevyYcIi9AoDNqdB4yCPor0ATsYXj69xjVzD5SDavUM1LV7utVb/WKSM3qgua5nCgoXvVIUesxDNbPDR+GPbEcvyBV/Kau8tt/FUgusVEEWAPYEYocJuLJsoNA59geqtKOUndlRmoQyroHJeeK7w5dR9plWybu2M7X03aoTaPuojeacM1ExMsphfA0MHl8GuTD7BhKCI3tQduU9mITaOn6T3zom+/n4g1qTxWBR3BVkETighD9ySWLmhiVtZg1pJyVpxeIMJTgNJ6+tuXMaDxgDGZ+rVd2AsuwW2/219NMwQKcEPEigJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MGyhgQCXqPJK9EQMHY2KWG+tNQqqrlzPJnIBMUMl5M=;
 b=jHZiuovP2g4sTRh1ttB7CIKukzJOlqK5bOwI+nent01gDydCBHYsx8whbFSxzw17XQLxjp53M10yiVVGtbK9o/u+LH+GkvgRZDQY1LgSPa55++1u6eHMyxvzOF55BkwFrTmWFQZkvolUn8D7VgMD9lSE8CyBMA1D7pBshlYct2D32C5NcEYb0Ascz0L3hbKfo1Crh+Gd2id/sWcjF7lJxTj2gooZ4vpoVRNXddbobC+9IjLGVBLhKg8CzTfh1ocKi1h5c1eNZG6uS2vay0p504dx1ZSjebBqOP39ILQaWk7E1LzVa6fHNoSUKGpFIW42JCllHD9tNiTIImEJMqzkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MGyhgQCXqPJK9EQMHY2KWG+tNQqqrlzPJnIBMUMl5M=;
 b=DxYJ7VBI0kw1ov92M3N91v3iiKuQ1PYTc/bkuwT6BbdWq6E3QaW8d9971JflOU4lJoPoXS5Uw7EBlmWhSNTH1KG+dBKprnLMxjC8Avs/l8jyC/mazyXbxJSf2XdCkleWe/fHCzZaogLue2numOF/mjpIMuN4PiTrDpArosenhUw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0402MB2878.eurprd04.prod.outlook.com (2603:10a6:800:b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 10:52:24 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b%7]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 10:52:24 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com,
        anda-alexandra.dorneanu@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 1/2] bus: fsl-mc: don't assume an iommu is always present
Date:   Wed, 16 Sep 2020 13:52:12 +0300
Message-Id: <20200916105213.18625-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM0P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 10:52:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 97a1c40f-4dad-401d-9442-08d85a2e9867
X-MS-TrafficTypeDiagnostic: VI1PR0402MB2878:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0402MB2878598FD5F5FA91841E231FEC210@VI1PR0402MB2878.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SFHGOoD4uJtjuNW/DrXx8XM5BFPiFUYEk67tdYyyqU6auAswcuM0DoSaFWak5dwhYCMJkTf1MHLXmRMzxbAC00OfZfLctInQ9VY8s5A7IxMXyv0przlVLM60O1Z4tbCdTdEmiI9mjsi1P5xg19BUgYR3uy0BNvMUmfWtYYA+b11L7Ig7KKlTzwqdtVNguJ0Ral5YOMpwe36dFup3ZCfjCjzzIEnr3Qp3JBpJ6P694BoK88YBINmCzzNlXa4Q5uRsk4zDdy9z4WePWfprFmwNKMQVz+F88Yw4eK0HpOVZo6CL14GA5R30e808Hbdk+5/LpUXZnj5+IjXMgau6mB/S0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39850400004)(396003)(136003)(2906002)(83380400001)(36756003)(6512007)(478600001)(86362001)(1076003)(6486002)(2616005)(956004)(8676002)(316002)(4744005)(44832011)(186003)(5660300002)(16526019)(66476007)(6666004)(66556008)(4326008)(66946007)(6506007)(26005)(52116002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xkEshM/UVKlw+d9JVYRuT6G2LjWEOGNza2SGQvtr7HbHeuKsJkQAGdxyE7Zxqj9jShQRTU6Ty/eT4B8pJOunque3l305oWU7bYzqniVbe+iUXqrPxF7zucd2zGvM9Lq3AruMniFE+OdQq9V8R+mn3HAuK0epv3R7f6TXY3Jt5d6peJGB1X1Gt5FIUt8htZpGLd7gbh+kj6+wFaMP/cIw6aOHYKUZLkm1ObsD6XN5FxJpPAPplgiaRjzOkWKf3AAsbMq1PSp4cyauzgwNn2XCvbPvBO9jdJaHU5t/+RUpVol7ndcxrWsJkyR0q1JQnhnXxRRq/N+oQefPX6tYjR38evfEStrlz+J4pqIR4tIlacNtUwHJ35rwcZ2U2blzrTCW+jkNcrV0dNy7yVaRG0VH7Oe+gPeijbHa5AZIwJ1jUtLx9J081unPOcdOghyiSL02UBcvcvjsXHzt0tmN101JJdTGSfUW+mrqAYkiALvoiamKI+iXczdfrDkOCekD3cQ92z2riCN6ZIyuqz+KyNFQ3rrPVAJAeBHbK+x8aPI3u0wcCp2gJnitEid1zcqeGjNi1EoFR8RDcSHnyJVm5rbzFOqkWUQ4GHdPjHdl3k+pcv/ktnhRjvSjQwRn0pJp4UF7q2aFM7DDgFhT2oEjOTf1EA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a1c40f-4dad-401d-9442-08d85a2e9867
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 10:52:24.6934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FagoViA3BH6IZOx5RJUsn6aJB8cb+ghYjCJdlbbODAvi+NEgVdIEJUxD9/SdSHHymce4OjYutMo282cbnr8jHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are certain scenarios where an iommu is not present, e.g.
booting in a VM. Let's support these scenarios by dropping the
check.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes in v2:
 - none

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

