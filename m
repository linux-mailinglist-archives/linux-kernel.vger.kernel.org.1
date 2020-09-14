Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E8F26887A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgINJeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:34:02 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:61021
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726263AbgINJcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:32:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NLFA59uV0nFOKDIMXmhXWlBifoPW+MrlISfOF2+q3NdfX/A7dwMNnjqtv/kYeH9gy+nd+vul6NAGQ1L6/aqFL+cKDiFpd4Q/ERIEZTh9O9sgpSybGL1gtNNCD615+t5j9GsYiHrBpxj3wh1MK922V25tNJVINOkbYOzA3h1vOTCM7UzHYTBO1fCF6o48kPsJvJZBbjb/DzmLLq0nzeI+2DHHkYEMP4lcpCG8lzlhJ/f57RuRHM36SnUs2wTR/u6JnC3w1iuzCsJlo9HkKa92lbm1qj+ybnlL1lghriBLFKx677+qKPfxjxNqHYJkj/3eRv40NFSehQvtdLliS8ykLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctbrXbxWHo7a8KTPqVjF8oAJXeCzS8iEqaR1fl62DtU=;
 b=a5fi0x+82AiRdoxN+9SbLr6myL5cuhMuWMxVmvm0a/x2iNUZBkWs8WUZWii51z+DfYa/z85OmSZE7zrQe/vNClNeJuOhsK1S64aMIpk+DZ7bzwFNvExnKlXpo6ltsKeeqM0lIM6A1f6YI4v5omUy6oekFIEcm+vj7k5Xw76zX+kzvn8Qd0XTWUxnydDbtdh6nWE1ptKZ8feNb3lyp6PutDYbzBJJRCGeDXjtldfwyhL6+u5PYNezk8R+jeAHfVFebd3ayactIhg4gbdYANzO60Ix5myNVVIsxXQ9f9Z8Cp0TYmphRn0VawF/IuJwq1p19xUVx/QxXf5ayOrO6IMv2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ctbrXbxWHo7a8KTPqVjF8oAJXeCzS8iEqaR1fl62DtU=;
 b=mVA6Ve6CpNQbCAdq7HtH3WLq1zJxIds+0N1B3xa4InP6i+vsV6wFZ5wQ95eza4RVIGlwokYsFhJg2H60K0vKuhtuIwn2hXOctwWe+nqSoTjHJkavXRWmOXEPBcb2U6/HSnFoGCuRjrfFqRliI6okwLo+lUsYoodC34ZgY8Nzy10=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19) by VE1PR04MB6688.eurprd04.prod.outlook.com
 (2603:10a6:803:127::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 09:32:44 +0000
Received: from VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88]) by VI1PR0401MB2287.eurprd04.prod.outlook.com
 ([fe80::174:edc4:7d33:9c88%12]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 09:32:44 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     shawnguo@kernel.org, o.rempel@pengutronix.de
Cc:     kernel@pengutronix.de, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/3] firmware: imx: Introduce imx_dsp_setup_channels
Date:   Mon, 14 Sep 2020 12:32:25 +0300
Message-Id: <20200914093227.5094-2-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914093227.5094-1-daniel.baluta@oss.nxp.com>
References: <20200914093227.5094-1-daniel.baluta@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0133.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::38) To VI1PR0401MB2287.eurprd04.prod.outlook.com
 (2603:10a6:800:2e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-103.ro-buh02.nxp.com (83.217.231.2) by AM0PR06CA0133.eurprd06.prod.outlook.com (2603:10a6:208:ab::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 09:32:43 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6219698c-9c4c-4d42-2088-08d858912245
X-MS-TrafficTypeDiagnostic: VE1PR04MB6688:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB66883E32175A9C13770AF2F6B8230@VE1PR04MB6688.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dQyVoVKj+k/uqEfysXauIzFUXtj+3zQN82ei/VkqMSBFL30Xidbd2XdisbYJiDLs16R7D+UEWa63EdBM66XXL/ORMr6n7Sp6njAhz5QOHaEnCp64jLBNpY8Oq3+59mD4XEgNqz0BvzrzayefyeenZQw4YjfS2THLUFXNDIx1whvL9duMP72LAeMQrYuOn9T9XvKVCq6QA+exOg9qtpPyX/cS/1aNtNfhG6VfTEfVM5eJ3PRubFGNgUqxOG1z3/HLqKrceFpwWBfsiB87vhVRWBbKx7erffC8ZOWDZnkPDUbedlj8xCkn0g8AOno+ReBYVqovufgwzdtqBHxXOKe2VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2287.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(16526019)(6512007)(186003)(6486002)(66946007)(52116002)(66556008)(66476007)(316002)(26005)(6666004)(6506007)(478600001)(956004)(2616005)(2906002)(44832011)(8936002)(5660300002)(86362001)(8676002)(1076003)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: tqA2KT0x0jcc+JCkeOyjhiF0ou/0cDb0Md5Gqha2lviOwHr2q0BA1fXCXxkGPkfhu/nSTSEW5Tht25oIeh34M0+8sb7tdiU9Kia8wbb0XVWNSLuy0sK5M2nuVP5Ap8yr7nFwa+AmYpSZ4rw9ej1kHyq3VkHYDZ+dgYktDvAE369uliJM4wIe+FikVwyHo+sVMnS6t7Gv7wgHrzyy/nlzfw/q9HVfn9G4iCPG6AQQTBW9V4RhOtrlfMGzDrSm/+HIb04wca1Hmr0TPVez/6JdUpMKrAeq5PaLDqGgQjpUw6seMcmzZDGfb6GhDVKr/TELI1bOG+iRlEsNHvAFfXdprBaAdr6b5XwFYoT4lldFfTsetbw17A+eypNuKW2Q3WV1J5nIEYtS/IopbT140WZNX5vzb3+6lK0raDu8c/X9GpXNU1GYFsTBNyVq8p089IcEWgikipurDJ1tvXcYqeCJzg/Q/2h50va/cP7Jd3/Vr+4w1MVF7n3t993g+nh9pb7uhZ7HsDl7ye3N7ScmF1F4BLpRTRSB5mzw5rbUL+whXGE8M4LpvNJydlSkD8f000chBVYtsvaIfQli/l5ckIACMlmKia0nQ0RpnOd0Jt7TbQ7kb5IzDp+VbcPoE7/d1qr9sLQD4b8DOxhkxLW6swqHGA==
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6219698c-9c4c-4d42-2088-08d858912245
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 09:32:44.3901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dto8XSyGotv6crwQEHOW465R3dXIPGY1taqqXnbNLFO7MPBFkJvzbk1AvKYiD9nfIPE+KQOzcGu+c0mQZx1tmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

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

