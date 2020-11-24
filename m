Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C52C1B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 03:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgKXCAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 21:00:03 -0500
Received: from mail-eopbgr70048.outbound.protection.outlook.com ([40.107.7.48]:58572
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726904AbgKXCAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 21:00:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyB9VpU15UBbsei+2bMa+SYk5vjb7KCor3qjZSh23C6UjUFRU/MzV5J+FFtjJgA+/XCn+S0e0hqG2IeTWl4XbmVXMH/5YidABulSNeFCvKyM5uzX+h29/ZdEK+5Wtxdt4gCUqPme2pRlj0jZdGv+Fe6zn5l2x9FKskqklDn2eaT1ru2+6zRQP/lOnQmNZeHi+OJaDiDM7f//NPx5D3XXZhAxqFcYgzyTj3eEgOOJAhWZUOSu7sueUHOuh4yApE+a43VXw+rUQWbozVNcSbCS0DzBNbZ4yZ/7N8B0t5Y9AJ3/iBvczOXgkOtHa6Os8ugsAkDpvguU3ghgaVB05TfL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvrBEwp0KWEfnEV+BosvPVS4dz9eZWKBNU7ttKza4ko=;
 b=cCNSuKwv4SzMOebFNeBJ+YW63Wdz3+K4mjSlk5PjWj3ynX6XjsWrBMgjHUXd8WLF0uzcpsx9L2KB/5EIGGVOWsv2PLMVMiAHzZ46CFY043UYj1wlJXrIcsBBhprZiTkCADg6OU5x9zPQX2w1HTejS8X2wXeD9KHaoKZRmZ9D83fpoGEm45cwIdbVHj+KdiE7NKQpkpUQGrbIMAi9Kx/B83EJ9D7TnBD507yyXE/TCeapn5w3Ge6FFV4wmGpPdDK5sqVN/GIELVHw5BAAp8fBNHkxSz0+Iet02VKfPTkbTPHVTrjuRMEfJBBtAVReMqVNJwRLCWQXnZy3UO421NoSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BvrBEwp0KWEfnEV+BosvPVS4dz9eZWKBNU7ttKza4ko=;
 b=ZKBjLXziQz1C8J5LT0mhFL9bPLR8Za/EVI/KYIW5l7HSnzy/M4xhnzYnTgT8EyYckMstH0JZpWA13knzTwO9E5HO60DSfVx8WQRulC0L33YQnJayKKQV/IN2bwBrLTSPfROXboZWK7K27RrhZZdJfDZprMVem22oLVSRTPzlI8c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 01:59:58 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 01:59:58 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Tue, 24 Nov 2020 09:59:46 +0800
Message-Id: <20201124015949.29262-1-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR04CA0188.apcprd04.prod.outlook.com (2603:1096:4:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 01:59:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5573adf9-4bb9-46da-c9e7-08d8901ca569
X-MS-TrafficTypeDiagnostic: AM7PR04MB7096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7096A834423E7D9670199CD4E2FB0@AM7PR04MB7096.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: el7b0zI9ZdBnaE4ti9xZ58BnPHC+BXUs6UjCsXRwsGqM68MvZFIa7CIJO6f+a0uS9ErnVhQo/NqKixf5vkdGZ+OvMMCa5Rfq6yTPSmnfk8QQqFR3ngW+9Q13w2wWfpEP5kn2YZvxpVXTQ0xeB1F/wK+N9Y2Ng7gNaECKv28YgPC3Fx9RjZjp7jSJbX3UqAkAoaUK8Y0rNEUh4QRYqpSWuI5ZVBtC7GxNXn48LITFl2DD+G5Tg7MxAGRZFQMT6s2kYNoaMzL50Wqg4ADdhejyf7YHa54lucMyQe1ikN16jRoHyYJbHfhpnmguzbv75ixwoqgVNDQcxXm93NFnM6XfwNQVy/UZHZR2izus7IAtRoEHUxV/VaSOP2jCPwAPjEbQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(956004)(478600001)(36756003)(2616005)(6512007)(8936002)(44832011)(4326008)(316002)(6486002)(26005)(8676002)(52116002)(2906002)(6506007)(16526019)(186003)(66476007)(66556008)(6666004)(66946007)(83380400001)(1076003)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xJ5nD/wdJyUAgCAdb65xrxlndB3cyPEsPILBJMwOqcTntuM2XiO3vn8PkcZCgVZ95lCZDgkp2ZLKIBdGqJT9D+ZtGlgQkRi7a0TDSiVINUgnQOno+OZkyQ1AmAW2ux9yg9R6p+raNH79QgqF/cIWd7wW5H/KdtwZdsKucfpg/fUDGDqVmCS8uVy9HWlxTYE7pyQOo8NbPRLu49H+XNqQzMO+Q0o0fhUSWdTSWNW1w17KiixaMvD59TfzYH4KEeyx7miep3Swv5QrxGZLWiVCkThd56BDd+O5t3DxkuWqhoZWre2nA79TPqHkTobsqN4MAvo4CVcdIMXZk54ZlwkXy+obfaF/xB0AFV0dZ9Yc9A7XeoVaYnGOeOCxWNoQ9HA0djfgMudk4lVReke31cHJpSlB3xLBI/59ZZFSTyAUIWNrZFwZo7QmxmjnQJHngFzLs4CnPNNa6FQiRqO2y3kDxcAT2wRqp24EFrv4WrCCJa/JdzVmUJcQm++mAHuq8TsKii2Zy5UW0Nt8A8Ns+bU7mCdkB2ACdthWfrprQl+3QaXmkwvF/O5m4M8AswwrdlQX9coRQA4uOL+nRTV6oTi13Pwr9/XNA1LViFww2L5ZEe+k7nNRnAartSZ9CD5IsuGkOYt3OXqx09mxT9GNe8BpD/cGOfbNEVE2hoVv3GbDMSBXb3RGDeEAEgsH95DbaC+AegTAndNGxvE0LD4NrPvqT0e3Y4nVAX/bWr8XZJ2LJtLetFWAWXDrhnOyWDwXCGV1o/QTy8/Gc+lbW54KH/eWASN8lsLJ81/6YTLvTHCkpxC5dA8vxN+e9FdaGAJV7eIRHXXNYM5nsmErKaORMa3bW5SsTz21tw8PhRR7s0VtsDo/aJLZulIwkYKoVoooPh80deIwDwnmgBnHwdNnadgFAg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5573adf9-4bb9-46da-c9e7-08d8901ca569
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 01:59:58.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nGptwQQFotYxSzpkAsrCtgxzxCWeSBgwkUY6+OQQ1mV2r5H9eTudAdRIi116FEcxydOFJcWGblo/Vi3nD4L3Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT Binding doc for the Unique ID of i.MX 8M series.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

v2: remove the subject prefix "LF-2571-1"
v3: put it into Documentation/devicetree/bindings/arm/fsl.yaml
    modify the description of nvmem-cells
    use "make ARCH=arm64 dtbs_check" to test it and fix errors
v4: use allOf to limit new version DTS files for i.MX8M to include
    "fsl,imx8mm/n/p/q-soc", nvmem-cells and nvmem-cells-names
v5: correct the error of using allOf
v6: none

 .../devicetree/bindings/arm/fsl.yaml          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 67980dcef66d..7132ffd41abb 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -918,6 +918,53 @@ properties:
               - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
           - const: fsl,s32v234

+  soc:
+    type: object
+    properties:
+      compatible:
+        oneOf:
+          - description: new version compatible for i.MX8M SoCs
+            items:
+              - enum:
+                  - fsl,imx8mm-soc
+                  - fsl,imx8mn-soc
+                  - fsl,imx8mp-soc
+                  - fsl,imx8mq-soc
+              - const: simple-bus
+
+          - description: old version compatible for i.MX8M SoCs
+            items:
+              - const: simple-bus
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8mm
+              - fsl,imx8mn
+              - fsl,imx8mp
+              - fsl,imx8mq
+
+    then:
+      patternProperties:
+        "^soc@[0-9a-f]+$":
+          properties:
+            compatible:
+              items:
+                - enum:
+                    - fsl,imx8mm-soc
+                    - fsl,imx8mn-soc
+                    - fsl,imx8mp-soc
+                    - fsl,imx8mq-soc
+                - const: simple-bus
+
+          required:
+            - compatible
+            - nvmem-cells
+            - nvmem-cell-names
+
 additionalProperties: true

 ...
--
2.17.1

