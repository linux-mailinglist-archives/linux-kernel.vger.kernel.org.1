Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E8126BA65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 04:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgIPCzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 22:55:47 -0400
Received: from mail-db8eur05on2079.outbound.protection.outlook.com ([40.107.20.79]:23584
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726156AbgIPCzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 22:55:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Udi11AsMiTpDoyC9YyiyKDXCrwOSgKuk9hMv5KWw+CwcBaFwdw0s1auSlG8XXYZAA/XxBgnq22HYv6iJKpsOH1ibdes5IhWjFLr4V2FLMBInm0f+PDLsi3hxbsYeduCUU2EsxHqkqxoD/X63Jx+mfXEfU6uJFV1hXN3x2zBQcGUK9y314rpCU8vdLiqCI+P02c4EXzZtSoGRmLqiblHeHSkYtczyE1eGzEhPX0DW9RxRSecXWr9Z9atj7uHqC7FpJiApLVgk9AXaCkkTt37ZQTdSJI5C8OCNv1Cd10aC641Aul377CAN4jH6DywNRSKuh1JrjuXKQmR0QXMbY9XeIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5KeC3uLI52UlSoH2elWBMIO8smbIF+NLWaESjlxhT4=;
 b=gluWMxOCBhZm6qKV05W94Dq8Q+kBFxO0Ig3/szubbfO6IQFUA5wmKSsnW+vYYXOztkQkRdYhSU37/98Zm6gNMS4+ZXK2p/HSNbxyo/niGQ9WHHiinnRJCJ4JhSJpNlrbjZfqTTnpbtNf1SqBp2qKQiaDwKv99GI+w4F3CaJxwVcDp/L0cS9EvkldU9bfRELnKWad1IaPNcydZ53UW1GPN5Ae0q7FXMHsUt5pymSMYte1+b6OV21528gYOSuRxA0UiHAh88bh/hxBNhc9Nw8MmDJBGOFia16YV1siEuPKDcBBdEimFjdnbsAFiZg6kvpRuCP3BsceqUouAlDw9+bWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5KeC3uLI52UlSoH2elWBMIO8smbIF+NLWaESjlxhT4=;
 b=mNrGG4y7/CvnyCbpozOxWwYt4krCh8OvzrtlOYIMO9Ule0LKg+RBuBNTHwNFsUNav3ePO3XF1DYYksLcIsjfMuVkOfh+to4Ans/CAbG3ZdfRhr0qov2lSKFZKnuBVACveE1zxG+FOrgG3JPS1pgAsAsLU5S63T0Bffbmk1+ZAj0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Wed, 16 Sep
 2020 02:55:38 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::39ff:13b4:4f28:1413%10]) with mapi id 15.20.3370.019; Wed, 16 Sep
 2020 02:55:38 +0000
From:   peng.fan@nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        abel.vesa@nxp.com, robh+dt@kernel.org
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 1/4] dt-bindings: fsl: add i.MX7ULP PMC
Date:   Wed, 16 Sep 2020 10:48:34 +0800
Message-Id: <1600224517-31465-2-git-send-email-peng.fan@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
References: <1600224517-31465-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0165.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::21) To DB6PR0402MB2760.eurprd04.prod.outlook.com
 (2603:10a6:4:a1::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 10.192.242.69 (119.31.174.67) by SG2PR01CA0165.apcprd01.prod.exchangelabs.com (2603:1096:4:28::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3391.11 via Frontend Transport; Wed, 16 Sep 2020 02:55:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [119.31.174.67]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 276110db-8821-4560-f25c-08d859ebfd98
X-MS-TrafficTypeDiagnostic: DB8PR04MB7177:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7177C71F4C6AFF19364D104A88210@DB8PR04MB7177.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G4WtghxApFeEeQaFhEn/qwRFu8Mr6ewFlqMmvxjXv297PJcxIHz8mBiehGXRnbXJuJgV7KqdtQqd3WDO6yKz2YyumIxCfvnc35CuB8Fo5DUdtCm6snIlpwEttJ19P+Z2PoDPJUdsIdifYVTuC25NoYQvtJ4wog4NMYeXt54v1DDfwDA2NvrsCh8fDJcHw7WRf/jmAi/RpklG3fO5aczJPJZJV4gozk0E7xmWVGKe1ZDiT/7svBTtg3d3fQXVDCYTA8GQU3GxoLUu8YOoaUyQtt3b8d8Lis4DDk62f0L3++iClsUKkWekwFgvgPA2JQLr9sWRmvos1+A6jq6gjeOe7mVDdceMJwk5YDRvn//WJWnH3q/ymyrQzfp0SbvOMChK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(136003)(39860400002)(4326008)(8676002)(66946007)(36756003)(16576012)(316002)(86362001)(8936002)(9686003)(16526019)(186003)(5660300002)(26005)(66476007)(66556008)(478600001)(52116002)(6486002)(2906002)(83380400001)(956004)(4744005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +Y3fQbTQqxfnk1SUmgjCpvMdYQ5ERCGC52PNRC/868q+SwIbH4mpG4v/8I5kGz4Mn+Nn27FrLO8PWnvGrLJ6XsR/FXRZd3RE1aCs+GeQfRGW5EZIQ48YSvuiyftW7HvxkufmSyo6073Xm8BSqlSwY9va5RvLrITWW4v507MIgrrvttzrJLKD563ykadxNUdTYa1efBHKzJYIP1cQD2vReuvqa92DvXy82JXXp08NyohWDzYX9qaEjO/iSuLkwhWlBPCIz2EgGpNTv6by5fSp/uJKx1u4kGdMvscHFAuKnCPdngw1zwAJDdf5VJinRiMvDlGXurALfopUcF2ZsDw1Hyl9A0dtrmYnJtKMHjZN6A9D8BV2Quc8Vh3A+vvJMhQZcExxhqkpGVd/mGZH6DZ0KRGZ1k6QzF5+Az1sJZVQJ6ApiGL1UKHcvP6ZfogxNoiix5LykenV74ZzTKb/wvtoDcIMoCJ1/AmE+bFHMWEia2uJTjnmBHspvHXk7V5+0vtAjK/FW99E54o0rsMfXw2xNKRnh1jTm7V/59pFt2ginn+pZ4ei/DqwqwxS39slEWo0sJGuIKbwA3eZNEmbQlT+rO/vI4TOvnk9ptSkQ7GAkpHWL22W9KEQaM5KhJUN6HwTqfBcSnXyjkAK1PB8ONpXtQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276110db-8821-4560-f25c-08d859ebfd98
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 02:55:38.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPl2URhF2ceLIJALrVJlGOwsYUIGzxSTNSpQiqE6DEyHnIMSlAl0U3yCfb4g3uYavUa64w25FpjKbAk5qI8Oog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Update fsl,imx7ulp-pm.yaml to include pmc

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
index 3b26040f8f18..28ebaa8b1d1e 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
@@ -23,7 +23,11 @@ description: |
 
 properties:
   compatible:
-    const: fsl,imx7ulp-smc1
+    items:
+      - enum:
+          - fsl,imx7ulp-smc1
+          - fsl,imx7ulp-pmc0
+          - fsl,imx7ulp-pmc1
 
   reg:
     maxItems: 1
-- 
2.28.0

