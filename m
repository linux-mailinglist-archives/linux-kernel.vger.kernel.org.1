Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BF22A823B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 16:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgKEPba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 10:31:30 -0500
Received: from mail-eopbgr40057.outbound.protection.outlook.com ([40.107.4.57]:59387
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731272AbgKEPb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 10:31:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HinGuRlb6yHRqLiO4FdA6RFlDya5naNS11xa1E3Ghoh3xggnu/iFl3BQdsxkp1SMMZu9IyNmVlRiwW2yDJcYj4O8xOUjw8ODzhPSAzi8uej5vqKHKBu7TnVpyR9g425PMIoto00NYUlF3h6NHWwgNj0fq998+MUUZjNsGlOTtWnYK2CvHsgckaAP2hrQOy9wvQ8QixGZjbUpDnHgq0wL0mnhAJSgYyhwUdolPzHcI1jFB8jpHz4+AVuMCniR6rMdGcri/gOrueQNxAVoY+dtoth3Xw5EeAsku4lxlHE+0icw3le4WCyPp79fTGAPYH4emf8MxIUIm97fxniOlmKtgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+wI46yJ5G1UPgxB/dV/8b+y48yzFNxOyR/whS0J5k0=;
 b=mB/AmWqScsZCn4P6IhChxU/MNMOaXX1FuovI4p7TdAsGGw5fE2fJDe/uCIkiEcXwREYuNQoX3Q7De3vPS2FmsEOviWUnSVhjHSoFrq1hp8jqXMUiMQCosr9WOI8/qWkkALoFqfgKI87iU8lXmStOTsJUj457ryx4aeIb5MbAvUPc2cU6MIUQDPnB2H4KK2UQ9Gh5p3sqcVgZQF3rNG+qqQAQ11BvV9l9XVmlpahLY2b8R/qWVYS4PYsaQYCYBeMMZSCtaZNXzHPHkQPXY96SrGK4t5lN/0dnY8L/2p2V9BAfpoANH+TRx6D8iL+BnIIJDJzrUb5BuwgnHphW8OLHDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+wI46yJ5G1UPgxB/dV/8b+y48yzFNxOyR/whS0J5k0=;
 b=lX0KHUpsdf9p9UTPvEHOIKYwzfZKFcaQDIJqfdEtuzUIF4eXr19Q2XZzMbMkhizr/4jGIS3x4PXZ2pYsSwVn5JSv56evi2N4IP5m4iWLOhB1tvTv4m6WKdvkJxf4q6VGMXpnVtOlRIT9GPjgjV0n7aToK162Y8Nngsgkh1yYZ9U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VI1PR04MB4895.eurprd04.prod.outlook.com (2603:10a6:803:56::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 15:31:26 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f557:4dcb:4d4d:57f3]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::f557:4dcb:4d4d:57f3%2]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 15:31:26 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org
Cc:     diana.craciun@oss.nxp.com, ioana.ciornei@nxp.com,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH 1/2] bus: fsl-mc: add back accidentally dropped error check
Date:   Thu,  5 Nov 2020 17:30:49 +0200
Message-Id: <20201105153050.19662-1-laurentiu.tudor@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: AM3PR05CA0156.eurprd05.prod.outlook.com
 (2603:10a6:207:3::34) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-101.ea.freescale.net (83.217.231.2) by AM3PR05CA0156.eurprd05.prod.outlook.com (2603:10a6:207:3::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 15:31:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f23371bf-5e05-4897-ec2a-08d8819fd7c6
X-MS-TrafficTypeDiagnostic: VI1PR04MB4895:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB4895293BBCC366E824EA80AFECEE0@VI1PR04MB4895.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wkyksh+hxe50C7RSx+BJKDjDcSKpW1OpqXYrMjPSM9fCXfcS85qnuNgtECjA1hTwnQIAL0DetcHxcOLruviw7MZyUEeZfCfsNYn9yAytpm1pkMlWcMd2v6lbakrCG0W0sUmlpbGPyPoAVNvFRLg2BI8tUEcYsCMXmA1unDDIOQuDYotY44C3hOI74J+GoHnR+r8H0fy9Vmq0TVpjCWGqkOZF9eMQbt644L69/Kuss51qbmEpdobNYPRjb2xeBc11CHy4S4r4nS9xBq89a8fQWD4DhSm+Dpmfqx0C0VZcWwPIhiEQrBJ5SIVSugMbzAm1WlVlXerbXvkKHsCT/B9Ayg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(8936002)(956004)(52116002)(66946007)(36756003)(66556008)(66476007)(2616005)(26005)(316002)(5660300002)(6506007)(1076003)(6666004)(4744005)(4326008)(86362001)(8676002)(2906002)(186003)(44832011)(16526019)(83380400001)(6486002)(478600001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /2mSHQDe4LRueascyAZjoZbJHiGhaUESPfVy7YWTwbksuXRUlxWUPkk+hJzxXLHh5XaUYR/gA/LUqR1p/RE0CgAcK35c4TnJNeliWiNKWMr2pHoBHq7Cuc1aqOE61DX55w3WstzK/YY+Sh0qD8EHL45+WYRkFPtZOkmS4CZ+5wq/FvUtdTQUAmbfYM95Q8BUfcRnN6djg4qT3VJQ4WEjdtnpFCSeY5rhFLjp15d4YoLB8u8p9nK1WG4HjO2mtHRDe4D4gPS9lcQnKPOJ6audI65Ota4M5DmJbr6SVCjHtlpa4RF1hj6UpCgQeRfvmEuVAYcGOW/vRHGi+raPK2SOtZ5JAWSfnvfgFB7uB5vZvdVNYEaP7JSM7dbY/wmXK8a4DORXciFM+5EFBuoO+H5xrpGow9Lf1mQ1KQ44s68/mNC6j1z8iq91nuKdN6L8UldHWtqTbc89khcsMzU/P6t4w2q3986XDbZQJc8Xy5Roil5ChsJ98fsnt5pgnJ+pMBjEa1ih2lUqhTcOulQtdis//d5E6ru0wDZDMkNyiwBG0Gi03QBrKYQCadWXQSDO7TFqXqgMJCISfCHR5dZTfoKM8GHsJPSJ9/H98m+anPPFGrFG4W9IcXigCiUMArrztFu+CARImYu0ls9d2iAV452KXw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23371bf-5e05-4897-ec2a-08d8819fd7c6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 15:31:25.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X3GaaxzJVf0inKGEbj4qxxXmexUD+kcpNCEFppNo90PtfOO4WW4y5Q/k1KWPQirjG/sa5mI/qeqihzSrpxBTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4895
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch accidentally dropped an error check, so add it back.

Fixes: aef85b56c3c1 ("bus: fsl-mc: MC control registers are not always available")
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 76a6ee505d33..806766b1b45f 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -967,8 +967,11 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mc);
 
 	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (plat_res)
+	if (plat_res) {
 		mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
+		if (IS_ERR(mc->fsl_mc_regs))
+			return PTR_ERR(mc->fsl_mc_regs);
+	}
 
 	if (mc->fsl_mc_regs && IS_ENABLED(CONFIG_ACPI) &&
 	    !dev_of_node(&pdev->dev)) {
-- 
2.17.1

