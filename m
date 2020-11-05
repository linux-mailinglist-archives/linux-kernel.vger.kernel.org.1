Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC52A77F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgKEH0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:26:34 -0500
Received: from mail-eopbgr50043.outbound.protection.outlook.com ([40.107.5.43]:58244
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725320AbgKEH0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:26:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ivjg8qFhUBAJNrlv7pUZk8ya9Mbqo65tPN/gAufokNpOD7bKP77CslEE/ifR6K41H31btEQkiiOoRLpt1rLo31y9Q+B9QVFCuBhsKnBTLMnDc4/0rHv4V9fpfY9uCKzrVGhcJ8iHq5rOFkNcO1vRcwfAuBsdGutTFpSKBRx4ca/Kht7ostAI+Gr+CUEinlYXqBJ38+Qi9f+hobj+6jfEbv0+DKoN9C5zaek11hiXWkLhLRLBrXtQX4mu5d+2EDCgsiChxlSC9hYGTtTBcrlWLleY/Jc/nKIleuAgAewHZlBT/PrwCU0VqLts2lv4JdaPDKvqIpln/qCWJMiXgWmB8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK5hFw9oZr+xplMFEbpoblSZBQfys0eL5mwf81ioG7Y=;
 b=cV+WPbjIToyYgc0Gx4gMB1tGkT0tXmoUyNnx1cLrRmcUnJyAVqh2zCytUOgCTXdOqEg1cB9fy6pwz108L8d2bKJw1FKu3kzF45/NjCXROM3m7IhK5DOtTBPFa8z/ZjRqCi2IEnBZNHBBEg1oRYxochsfF1UUonwfLPF4nyhAwc4tdIteORz1uEaBc8D3j4/rFLfSvXiwK5DOnUeJdERDf2wnQD8Cs4OdHOwMK8lq3UVWi/c3eAACQ++hzwTpCg93f+Po0bEaPoqfiHmBCp3VugQpfQtlBfpeEvMUfgTaImRfQv2wlZGTWhNhSu4bZEDLnzK0rq+aLQMr07aoP1WS7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eK5hFw9oZr+xplMFEbpoblSZBQfys0eL5mwf81ioG7Y=;
 b=dUI2AftmS6W+6Na4EitBCLmdYXzmvaKtQTxGet8burd1YQp3LtPtA+T2yOPjCTPOoN/chWxGYfSp2WfSzIv8+xhRGg7hRYlGQW9vmIePxSZSVTxLu1NeJ8uCzPcwql6VOEWVYMYaiUSFNT7z3BEmi10bbadYLlTcCp02Df8DIgM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DB8PR04MB6906.eurprd04.prod.outlook.com (2603:10a6:10:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Thu, 5 Nov
 2020 07:26:27 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Thu, 5 Nov 2020
 07:26:27 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Thu,  5 Nov 2020 15:26:26 +0800
Message-Id: <20201105072629.24175-1-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:54::18) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR02CA0054.apcprd02.prod.outlook.com (2603:1096:4:54::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend Transport; Thu, 5 Nov 2020 07:26:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 532dbbee-5be4-49d1-c57d-08d8815c1b43
X-MS-TrafficTypeDiagnostic: DB8PR04MB6906:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB6906E572D8DF49321E63CF5BE2EE0@DB8PR04MB6906.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aIAH7piyR8H3gFK95r42+4SC4D7C5W0lU5NfcHl/FQidNq+eFk7GMcQXlBGsS0wV8tHWymTgmgr5LSPGmV4ycHzqNCYJ3QPvfnYfDqQduzLKOwIRmYrNbn7x9bTNo6pJCupJSmPLVCnG63ob9rhV4WfgiWUZWU1GlfJ0Ejul6sAhrIj4j3Qq4UBtM4FLxYOOZf7w5jvlRgW6Y6uxdmYM3HQDiN/OSJHT4osmYGCSISOOcoaqlHxeY402aBnQQ/zu00Jyxcm8Me788fhT66CuwMBLI+9coIiAEnYAJLMb0gFdC73Syeky2t+hCjyG1z7GkZ0nS1nu81ZcxzircpwIxUjuuYe4brNWWgMkEAfFPualpqLhVL2m9/3RXggJODDE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(5660300002)(316002)(6512007)(44832011)(478600001)(66946007)(8676002)(52116002)(6506007)(2906002)(86362001)(36756003)(4326008)(186003)(8936002)(66556008)(2616005)(26005)(6486002)(66476007)(956004)(16526019)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Oq04JQDUJpvR8sz0m05PJYFkoFMk0Cm3kd1Zt1XzjdFCc4fSEpaAJTj/vK4XNGgJTkgJdd10nBocct3FN0zO7wArxglrEieCHMTmhV07wzXZlhrTU3KFWDNVbK68cUy78RsI3rzoKZ/b47CS46n32SLsvrF2cZsvuIkx0mk5qCiWA9gr403DA7JK29C9osYrqbGvmmrywqSK7r2IuHfhJsD4NVzEqGC6WqxI47EHKrBHBamLar/unKO7Xk0qkz88/YUj7J+WHrXACzMOIncgRED3kSDMm1IleN0AScTpy8tL2QOd15pMJzBkwgRbWJcZYtIsvUlju6AXmoH/vP4oa2i+mtF7RwOHkDM7m2eeefcF6Qfg20YWKEBfA9UGZOX3XiuWgV5rplEcB95MQ1ITGvztlX7F5I/wRaj85QQv8k7UV93w+jqyYqbXN2NCOMrbF+r5yv9ZsvmJbKe6h3+MQOBEi+3TO6L92CouDnBCxzUiJkmdoRkqNjdKAbQMDZ7QcfNRoLGtfu3gpni4nMk7zCSFzscvNXNsgccV5ZFenaUunJF2qVbQ8moEx/KZbYzpqbLWglDL8jNb/23vVWj7fIBVQOo/2ukj+MdHVh4f4OMZz6kVWNIyulf3qo+fPjJ+IwHXi/6FJTi+XL89gHGKbA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532dbbee-5be4-49d1-c57d-08d8815c1b43
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2020 07:26:26.9476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdfIIRvT6QyrL8czQZD6pLZ3MjNTOuVEoYom7c0VnFJBSBsqkXwWvHep5Ou7UerGFJQXbXllTFAQMd0C7EPOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6906
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT Binding doc for the Unique ID of i.MX 8M series.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 .../devicetree/bindings/arm/fsl.yaml          | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index e4db0f9ed664..0419f078502b 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -901,6 +901,39 @@ properties:
               - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
           - const: fsl,s32v234

+  soc:
+    description:
+      i.MX8M Family SoC must provide a soc node in the root of the device tree,
+      representing the System-on-Chip since these test chips are rather complex.
+    type: object
+    properties:
+      compatible:
+        oneOf:
+          - items:
+              - const: fsl,imx8mm-soc
+              - const: simple-bus
+          - items:
+              - const: fsl,imx8mn-soc
+              - const: simple-bus
+          - items:
+              - const: fsl,imx8mp-soc
+              - const: simple-bus
+          - items:
+              - const: fsl,imx8mq-soc
+              - const: simple-bus
+
+      nvmem-cells:
+        maxItems: 1
+        description: Phandle to the SOC Unique ID provided by a nvmem node
+
+      nvmem-cells-names:
+        const: soc_unique_id
+
+    required:
+      - compatible
+      - nvmem-cells
+      - nvmem-cell-names
+
 additionalProperties: true

 ...
--
2.17.1

