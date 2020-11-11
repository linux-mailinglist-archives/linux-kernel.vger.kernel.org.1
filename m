Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5732AEF42
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgKKLMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:12:12 -0500
Received: from mail-eopbgr40070.outbound.protection.outlook.com ([40.107.4.70]:15499
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726221AbgKKLLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:11:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Noc0wMKDivwlALaD/huW6gRufEZ4tQ7lDbtWywjvqd9fgx+UAShyCW2nDZ+yBB+nKImxNmxRpc2GO7uGxTAMzaUgfy1yVs2HHXFlNGfktmMWt9JKOTq98IFoPyLNHbmztZOoh9GTzHlWB/KBSzlrI2iWI50hYrUWksBqPwxM18dxuo/BvvsGKtpgegqqLPz0pF4ETxJzEFPP1MBXxaFQNEBYeqN217mPS2f54PxlNFWHgXh2Xbt7w21xmiQ2v02Ew206Kgv1zIhR/GygRzqgoZHp7vaQ/V/9vB9MEgbOl7xyVHPMUvnXHkKMu8YnUzQdGfLp2zjNCwewaYVgDVwgPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLrOJsNnrXb+ewdPov0gxkVBIUXsJD+jA50llCrkDbs=;
 b=E7/GKY+qekP8GjoTMjvpu1QITTUrOxwLJ/JHdVYsqmwRuBNeqZ6PNz5H1OrhLjsZZDqbKx33m4uvEmPrwT3HUSa/BGetx8mOi/BEnkHzr2mygJ5u/qx6Yus1z2uDZDcbOam0yRMO57VEjzmyPEFK/9Sx4IUiEtvhpAwBOzF1iqAomlT58B3E2ivn8+zyjD7FfqpMcvND45MKTJpQ2Bov1Ou8ydZ8QjXlQIh59S0eYAinFU+BT/oiBaCcKV7KpVX82fXTai+l1hBYCCKNER5v5FORelXcpOw0T8Tsncs26fIF9EZtJwUhWwHpxCctQ6jV87o2O/4vIV+arcdtz8Jufg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLrOJsNnrXb+ewdPov0gxkVBIUXsJD+jA50llCrkDbs=;
 b=kCzkmEwo/I56m4HvTfJn9QoLho6r9R/eYhDbieYA9VUB7Syb2uX1WX9+HSjvUB8JglhriVyTHfZmY11/Y4HbpntqdGV2Qd4STtw/1ISsPzH60V67vpC7K9qySxVgDSzj1iq+BsnpbORyoLA1EN25ZEEo66e4T8tnXuuDb6UmH50=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VI1PR04MB5774.eurprd04.prod.outlook.com
 (2603:10a6:803:eb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 11:11:46 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a893:e288:b01d:599c]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::a893:e288:b01d:599c%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 11:11:46 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     shawnguo@kernel.org
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, paul.olaru@nxp.com,
        shengjiu.wang@nxp.com
Subject: [PATCH RESEND 1/3] firmware: imx: Introduce imx_dsp_setup_channels
Date:   Wed, 11 Nov 2020 13:11:16 +0200
Message-Id: <20201111111118.21824-2-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111111118.21824-1-daniel.baluta@nxp.com>
References: <20201111111118.21824-1-daniel.baluta@nxp.com>
Content-Type: text/plain
X-Originating-IP: [83.217.231.2]
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Wed, 11 Nov 2020 11:11:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 859d3e9e-6a8c-4815-a238-08d8863293f8
X-MS-TrafficTypeDiagnostic: VI1PR04MB5774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5774C0B58B75F7EE5FBD3978F9E80@VI1PR04MB5774.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YRr81utzkJK0D/chSUqsVZ0aHjQNKY5DqeuQ6oMBzKueWntRaSJCHgkrko5vSMOy7TdigEM9Y/iDf7Cb8XxfLIXY8GjSCKhNCJXch7QukqMVdK+j08qDMwfdIfqdjCMislre1Q3UBHBDLLdLHRgK1e8IEJvJgLCRzbVne21v/Dt9RLVO0ZKi+MMzo0Mzp9/mQWIrFDgFY009M5ZuL4VPWKBAGXGRrBWGmbVUyO8Z6jjcj2fFTm44YIRydITvk31Koasr4RPcbUY5JPzErqiE4pTFkXORZSLFBoNf1GC6ZE5K3/UEU/6rrAp3KbMNCqXcyLbqg0sDLdvCHRmoC2WEzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(8676002)(66946007)(52116002)(8936002)(86362001)(2616005)(956004)(7696005)(478600001)(4326008)(44832011)(66556008)(6486002)(5660300002)(66476007)(186003)(26005)(6666004)(1076003)(16526019)(6916009)(36756003)(83380400001)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yIvSuo7ANsxFWtNI3oEGlvJEg6q2qqbJoA1pdy63KMNdmuK22jtuQJlAbZbIxEFUqjzsX99s58sYAYQ9kk32prClM6sTpfS12fq27KUBOBFLC/P+EMHQskifylm71wEF9dScH+hEY6o9P7uVO+lQVxfQ4G/03CNSHFUC69zo8K49WZZlsSnAP8n6mwVE/7ZEyCllHf9hxZXUtQgNSEvCdOtoWB8QPYPwkLzR/y/ejC/j/TyMJFuE1TLeLvJQkOKJ1HJqvaEAyH9c6q1zRKOFTH0mlG+sevrVrTvRMDgjrSzYbFx4zDjxR8105gq9Tic808yMsGT0cgZPfBcXTV4olRZw/EwXSzZE1IyOB3M+zBrV50Wd04ziSAiQKYrstBeV78+rMgEYj+8+aAgLYvzTMZj0ud774ZJMa3C6K8yVAe+33uBQ/KKTZu8L1s3bZu3lOE1WPfi7Mwn7BQN/b3db6xPvlYdhqToaI0rDbNj5Xq7wkBeCMwQfDjg9Lhr6zjcbijIjDMlMSKr9A0hXreT6/nv/++mEubxfzMmM+Cr6webQnjBy6ilN6xg5H/x/e496gR/bWhntuwNFRB+cpgxdWj8r5ak3nCvDevqunZmc3uCUKrBytnSpgwqkVbioxHUY+jFwHbvt+UjxQFQpmwJrlidCFixVYFS+BfR1WS2v5+JNMrXrUIq9uGf3Vac7S/fyvtxySbsOBIpoN6zbbQE1wWyvl2mVizVk8ClKks1u9K3F+kygAoV1qv/4InMowqJCSGuYDiRrHY0/pzbf9+xLsujvfXs08cs3cuAGWorgGb7IpLgMK1BIlwRmgg8vtvBHM0sNukoa/6TYI9YdoIFXZtbU4PmVO4up5T2xMFvMtT+UNB94DnH1xXqCIEPNA8GkzjP3ERl8JtOgqeSG1job4g==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859d3e9e-6a8c-4815-a238-08d8863293f8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 11:11:46.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NoTeE0tRqnt4qx2fAeYwxwrb6xPzWcqhTm8xEYEHijseZBmvFKU7g7KaCW4mWurkhKS19EIBq6NtCIbUL0JtbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5774
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a separate function that sets up DSP mailbox channels
so that imx_dsp_probe function will be easier to read.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/imx-dsp.c | 41 +++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/firmware/imx/imx-dsp.c b/drivers/firmware/imx/imx-dsp.c
index 4265e9dbed84..a3a018c87b52 100644
--- a/drivers/firmware/imx/imx-dsp.c
+++ b/drivers/firmware/imx/imx-dsp.c
@@ -60,22 +60,15 @@ static void imx_dsp_handle_rx(struct mbox_client *c, void *msg)
 	}
 }
 
-static int imx_dsp_probe(struct platform_device *pdev)
+static int imx_dsp_setup_channels(struct imx_dsp_ipc *dsp_ipc)
 {
-	struct device *dev = &pdev->dev;
-	struct imx_dsp_ipc *dsp_ipc;
+	struct device *dev = dsp_ipc->dev;
 	struct imx_dsp_chan *dsp_chan;
 	struct mbox_client *cl;
 	char *chan_name;
 	int ret;
 	int i, j;
 
-	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
-
-	dsp_ipc = devm_kzalloc(dev, sizeof(*dsp_ipc), GFP_KERNEL);
-	if (!dsp_ipc)
-		return -ENOMEM;
-
 	for (i = 0; i < DSP_MU_CHAN_NUM; i++) {
 		if (i < 2)
 			chan_name = kasprintf(GFP_KERNEL, "txdb%d", i);
@@ -108,12 +101,6 @@ static int imx_dsp_probe(struct platform_device *pdev)
 		kfree(chan_name);
 	}
 
-	dsp_ipc->dev = dev;
-
-	dev_set_drvdata(dev, dsp_ipc);
-
-	dev_info(dev, "NXP i.MX DSP IPC initialized\n");
-
 	return 0;
 out:
 	kfree(chan_name);
@@ -125,6 +112,30 @@ static int imx_dsp_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int imx_dsp_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct imx_dsp_ipc *dsp_ipc;
+	int ret;
+
+	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
+
+	dsp_ipc = devm_kzalloc(dev, sizeof(*dsp_ipc), GFP_KERNEL);
+	if (!dsp_ipc)
+		return -ENOMEM;
+
+	dsp_ipc->dev = dev;
+	dev_set_drvdata(dev, dsp_ipc);
+
+	ret = imx_dsp_setup_channels(dsp_ipc);
+	if (ret < 0)
+		return ret;
+
+	dev_info(dev, "NXP i.MX DSP IPC initialized\n");
+
+	return 0;
+}
+
 static int imx_dsp_remove(struct platform_device *pdev)
 {
 	struct imx_dsp_chan *dsp_chan;
-- 
2.17.1

