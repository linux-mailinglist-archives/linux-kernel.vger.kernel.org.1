Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4252A26CCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgIPUtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgIPRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:00:52 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on0627.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1f::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE31C0A8899
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltZ0hooO1x528LGeTvheO8QorkYiIa0Q6S9mD2tRWO8ZQ3DMUftMIGzv5UkGpfy0U9n7qUpPhUOAg45PMGlSGVi0ug5fwr2B4/pREeJ+N3lZru98a5Zcm/gnmv4ib7fBY0YcEJfp0UIhR4TKf/boOpMIPwDjddNol1VruhC0/6Hxoq9hy9j6BnGF7fFXhtW1pTNfRnjuXwUCb05sWW4Rd9iKfHGfQXtMkX3v/HiIv915wG8/CmCYBsKfwdi+prQuT9i08rC9VEitve9CbzTgwdZwAxk/2qPDYx8zBSUDE6PKKAuMRe4mxevaeCoS/Zv7HRxOAlXPyoc2IglJN6fbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W041f+QsPp29vVfvLz1/9BGwJXMlHfl6AQULHfTmNjs=;
 b=nnugJyol32qCXC/u75OCdBpAx8IQqtTVHU3LdCJpqz5BJujw8PGSmkuB2zWyqU/a3v2Dg0yeaKiEc+LQ9AWv7ustNruvM7C6yzwHZWHBg8cyaWRH93WfEX0OdH4E6vvgx70RocGu6iX4+G6H0ONZyyxylvouHes/BsfsoLLmCWgXGwOvi/HrMCDK+rFEM3LlpTRZD90m9MkpwrkSTTdsdWBqkUomrhVW0387eiQqLtKGXcuMg1mM6Bt0xsZ+cDrmrLQ5kkOpL9iIOCfaLmTN5ED3eQj1neLhXzkowazlSzp/yyK3Q/0wWYF/zbFsVIDxn9GDfQjombGw7xDIfyhK/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W041f+QsPp29vVfvLz1/9BGwJXMlHfl6AQULHfTmNjs=;
 b=ZGK6ywcPHn7kXNyNqKimEOcOqqvidyYtjfF+SwHJicLm9McpyhIoKM4tGjNZwGK++YGcuxyNjSYqXr62H3X1tnHy7sc3l1GDBpIoKMlI1VsHf3NghiC6R5MhaXNvfi4XplwXeiOEQu+zB3gcdKPkcYIZCLukSf1fxF9tGEQaljs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR0401MB2318.eurprd04.prod.outlook.com (2603:10a6:800:27::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 16 Sep
 2020 10:52:25 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f960:c16d:16a5:6e7b%7]) with mapi id 15.20.3370.019; Wed, 16 Sep 2020
 10:52:25 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     diana.craciun@nxp.com, ioana.ciornei@nxp.com,
        anda-alexandra.dorneanu@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2 2/2] bus: fsl-mc: MC control registers are not always available
Date:   Wed, 16 Sep 2020 13:52:13 +0300
Message-Id: <20200916105213.18625-2-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916105213.18625-1-laurentiu.tudor@nxp.com>
References: <20200916105213.18625-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM0P190CA0009.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 10:52:24 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9877f98b-d638-4759-89be-08d85a2e9900
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB23181BC71E9424A7E54E0EFDEC210@VI1PR0401MB2318.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:289;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lGTxKf6tGZYC1DOhfM9xRtLhO3tQ8Z8hLJJGlyUXon2xkaKtckSngLlvY6QVzoeV0M/k7x3khykXIk0R5MRDxHreXXP9O6zNZd6y0W7iYA/CJAPbgZRQLJypfovduOmQ7+ZNH/gHM7vHOwfPzq3UneO4vfESGikaDu8ppusozwm+kl/14+BDsnH2Zz47nKbupMeqcsUbbHdWSxy3FyciOhPmc5cuWOQYtwi9tlL5s3F+wQ83VGs01x8m6fMwyJ59N+38qjzfC0kfxImlr9MH5DZ4xVqgJzBAie1huOZos0T+TDBbRx6dSB2/oMEerrBHr7JM7Htuk09Q5dHInXyAlAB3PtFcE8JsY9VRAgE6gagRYqsjDOpKdj9QtLpmoF3k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39850400004)(346002)(136003)(66476007)(66946007)(8676002)(44832011)(2906002)(66556008)(52116002)(6666004)(83380400001)(6512007)(86362001)(8936002)(16526019)(6506007)(186003)(6486002)(26005)(36756003)(4326008)(1076003)(5660300002)(478600001)(956004)(316002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: D/rklZ6lunMcdu/DLSg3gzZmCZB45yUf7bzmDpAgPP/TLS4/J2djcW43wcm/6/yST/d31ivcaZ6txDpQqviQ93fhzxJnCDm8x7TRpJMywn1BdhIl74osY06NpFJddtv86jSCAAdxff9oNaNwONWjLl7hLajGpdftmiYwMY2IvqvlXfMpOKCqod7mmUeGbQe3GzksXuN2AaMAFJ34HrBP5ROKiDwVL1ZBB5922+aAH7ylj+lXlrEVn1GR63ppl36o8swuZbqR9OqA+Z3LjivPXoILYZ8Nolc/SfcgS2vnfPJ7rgErDjXV6cNL6J+VbIE/Jm+tJWGoQrS9NQdyxe9Djqe6+e8vS8+Ui+AAjwkxug5LBK9KzlzFc1iPVpxKOwY1s3rQjNpctiNgFtfOwRN0U1c4Fm/siz8eNiMmWD8B2FPliw1yeRjtEKa31OHmoIdY0Wwd1YBjzUwbeWZRq3NzNd9lT2pZvr+Rp2volzd24Zx1wkPVIbxh0CUuc9PLYdy/vnvdj7z15MhsGOjuGLoKRkHorBq1ESwTxgSWNU/QrX/WTrpgFILmEiIkG7tM5BXAqvtjnUD/NFkQbP+LsHiZi6fTm0k6nRGYQushjJ5Mzbp6EuhzKgxBDRKtBDJ03l5ScBwr2eEmdI3mbGrCRyyvAg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9877f98b-d638-4759-89be-08d85a2e9900
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 10:52:25.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fMxUoO9Aq30JmE1CAczLbIlwlMfe172lqIPJx5nT/mVGNc0VCGqP+Mqqmqc39yZOD8s/uPJ1t50bgaeTxNzzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2318
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the device tree binding, in certain scenarios such as
virtualization scenarios, the MC control registers are not
available so don't error out if they are not present.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes in v2:
 - dropped useless NULL check
 - restore IS_ERR() usage

 drivers/bus/fsl-mc/fsl-mc-bus.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index b0449df117e8..b4177eccbf50 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -916,10 +916,9 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 
 	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
-	if (IS_ERR(mc->fsl_mc_regs))
-		return PTR_ERR(mc->fsl_mc_regs);
 
-	if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
+	if (!IS_ERR(mc->fsl_mc_regs) && IS_ENABLED(CONFIG_ACPI) &&
+	    !dev_of_node(&pdev->dev)) {
 		mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
 		/*
 		 * HW ORs the PL and BMT bit, places the result in bit 15 of
-- 
2.17.1

