Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3A82B19D3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 12:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgKMLQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 06:16:01 -0500
Received: from mail-eopbgr10088.outbound.protection.outlook.com ([40.107.1.88]:56293
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726567AbgKMLEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 06:04:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lmyLGwbg4KLPRuk24A8ZmpM9yT5Eelx7LdRfURUJh/oKB1j7IPED80doeCuiyVwY3nBqO/kFUYDD6bwOf0r3JEyFeAY86pLzDDJ8iFPkQjkvWoRez4+DUWPehfLOPxVvlUqzs6XvpH8URHmlx6KL89CD/AerbMazYpRH9+Hv0wjHxhDMZ1T7Js9lNzefprDHysilY/z/gvateyJPACly7WHm4oxqWyq77qCuI2gR2I+dqmgdh7f5FBsg549MJhLZZY2te0s1Z+LjOIRwUxPJwV/7qwYykxCAPqkCrnowNKhi6tPVAMIkvXfObyG1JX3tDKTQnzLJMgoauB4idvplfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V697U2okGgqJToREl1RIHEzPYza0pngjrHq9IalKaZQ=;
 b=jGO+Xs7eKzM/mKrvpL3eA1UBK1KpQKbSmU7/+OSKCLP8pRxWkqD24fYD9JafDv0X0POmfNlxiSLajlLFSYyFs+XUkzqv+JkXtK8/EayHIeZMjUstKzzNvb+RgWT5ttBRFM1/M8czAMtZV3yFoHDFAivluQMToYkXI0RYklBlvSdJizCOCyX4gRMherYf8trsym9maBnH2sXDr3WSx2E8NS59HMw1Azk28ujz6tQiJu1MjMxIUQt/PxB3lm98dazP6cIPw804oVK5IbOpSWgtU7SYMJT9/r4Kee7eX7xbdpmW47APY8X82oxMyZE0fU+IIex312B3leZssC5Pki5urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V697U2okGgqJToREl1RIHEzPYza0pngjrHq9IalKaZQ=;
 b=Z34fNkWKiOAJPcDCCkFEryY1cVqVHTdqg/N4oAS/OXa0eeD9MJv6PJ5rNa3Zz9p/A5CxyDsRW6FLq+qkRa1xaO7xNJcy58463Iujtz2tP0+lnJKej6sQSfbM8e39hNRALuvGjyB1wYF5F3irnU1du32olagxb1Nv5xouwGFQduw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com (2603:10a6:800:128::8)
 by VE1PR04MB7279.eurprd04.prod.outlook.com (2603:10a6:800:1a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 11:04:02 +0000
Received: from VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944]) by VI1PR04MB7071.eurprd04.prod.outlook.com
 ([fe80::1de8:9a84:bb92:f944%7]) with mapi id 15.20.3541.025; Fri, 13 Nov 2020
 11:04:02 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Fri, 13 Nov 2020 19:04:06 +0800
Message-Id: <20201113110409.13546-1-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To VI1PR04MB7071.eurprd04.prod.outlook.com
 (2603:10a6:800:128::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.15 via Frontend Transport; Fri, 13 Nov 2020 11:03:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d6bd94fe-8034-4b3d-06ce-08d887c3d445
X-MS-TrafficTypeDiagnostic: VE1PR04MB7279:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB7279F685AA39B8EDE80559DAE2E60@VE1PR04MB7279.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0lJGQaVC+0OSDyALDIrbselzri8K/9OL0nGsfTTc2lqIhkbRel3HbCvNuPKBnGcf0WFym9tCKEJYoYGiAai29zDfXRcr4LbpxhEOrZWJ9yAK5KHHRLcfD3tFbde5RZrhPjmdY2zKnFI3DGy9na4vHrJFEraOgUMkIYY+iXsPR5x/q+epyMxHpOlef/zu0izKXWIhpi+PGvkpuPhc8T+zBQsaIXKL4jOF3iAtUXfYyY+66LULgGvbGYj5HkY45ZF0YmntJqMDYduSN51aKW80UF+bA7GZxRDsjkAxB5xjnFozCjkFL1wSBvDjTf6xRNppjFFUs2PfgU5pU8fnPtPSpdx6VPh1eiNBL8cq/RroRTXitDO2A1cb/44scT6hilm+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB7071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66476007)(956004)(478600001)(86362001)(66556008)(6486002)(186003)(16526019)(6512007)(1076003)(66946007)(36756003)(2616005)(2906002)(316002)(44832011)(26005)(8936002)(8676002)(5660300002)(4326008)(52116002)(6506007)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: thrO+RLyM5Q0lg0CSuet15QwAT/liZn4RkC6nU2rVV75eoMYXGTLw403VRsnweizb5WvmpXM3UEcJ/ltlhYuze8aFdWXRF4Gacw5BxaF0QursUHE2moHtI1Rz+BPKIMSSXZFEuL38lVg4hGc78YZkcZObuCA+EWBVB35kIOED392WMrxhvIpyn+eORETdvxTJ3vMLjd7cW4X+oRh0Pj1aGL0PrIBqHhnNwisqN7c555Owzoq/psYQ1vJHEmpDO5s0QPYnx3nErHqn/Gf3KNCFyrC8RwiyJ1+7bDYgW9vW++DaRCtFxnJe8C5Ouz7NXfQrFLf4cLe/F088JvvNSyBwhah6Bf6TXDgyi2atdNofObpxVU6t4ugxltvi4WskkeW3GCJw8WrSplrS3/XzG32mAcIDssUmq+/LQQtfUBqTPnrFPxD5zsgc2vt7/L/nM5G51MwpvOFnUoSbD2jQ72ALQzyAJdynVdOjZVO1Q8YnF/73pKsWANSq23JoWbTA23XhUljI69WwK+9bQ4/SdQ+//8/KD+tGutOwqC6mOZm+qvG408x/GvopXZzseZc1CznhHqxcPqR50GuK9fYFDseGXx3yAbhNqdXuHxhnHEvz7vYpVqejNUP9ZC8hlafwWXtFOgf3nv4gjIBet9uJAkhDYQdrVkAIS30+0cjGgffXoQrfsYT6U7r9rhYJPo628syRd8InzAXHdxZDtdla9qbGqOQFtB2bpcJs3o1o+mP5kwFF+davphrufowC+mHNxJE3/F57nSj+TfO3t8iF8QO/hB+CpzddAgUOEkS59x0kpmHHzQN5YTUrdRPXC2JRFnBPKM38m6v6WsQEHH3mZTaPS9QwVW3Lt8mdZ94ijOnx8c/Syq0ldJ/PHkQ2wagsHLpCINmODWv5FanIeGKRgn54A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bd94fe-8034-4b3d-06ce-08d887c3d445
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB7071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 11:04:02.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zXkkP8oN0wv1twoawlfsmaxlC3aAN//1Zp2EL8pzbryZcGya1c+wiPRglMrs0CO2BQJHisnkEmR0w8lv47QAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7279
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT Binding doc for the Unique ID of i.MX 8M series.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 .../devicetree/bindings/arm/fsl.yaml          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index e4db0f9ed664..f4faebbb57da 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -901,6 +901,31 @@ properties:
               - fsl,s32v234-evb           # S32V234-EVB2 Customer Evaluation Board
           - const: fsl,s32v234

+  soc:
+    type: object
+    properties:
+      compatible:
+        oneOf:
+          - description: i.MX8M SoCs
+            items:
+              - enum:
+                  - fsl,imx8mm-soc
+                  - fsl,imx8mn-soc
+                  - fsl,imx8mp-soc
+                  - fsl,imx8mq-soc
+              - const: simple-bus
+
+          - description: Other SoCs
+            items:
+              - const: simple-bus
+
+      nvmem-cells:
+        maxItems: 1
+        description: Phandle to the SOC Unique ID provided by a nvmem node
+
+      nvmem-cells-names:
+        const: soc_unique_id
+
 additionalProperties: true

 ...
--
2.17.1

