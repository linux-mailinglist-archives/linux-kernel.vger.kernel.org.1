Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4832E926E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 10:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbhADJRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 04:17:12 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:1335
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbhADJRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 04:17:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YM5JVvsj3O3ebhS3rJEcry5eaS/Znk/KZAmb3GXoeoZw/qOKl5lW3XiyI/0xuENMnaeIqs4J9WT+MSUbkaP2/u1bGT09AlIfLKpXtgKxbD8qMdwMLWNjcxRQa6xQaCE7vQv7i1Spab9i43WJqxVYFjIdl7++9NLTiNjLF7v05DhMQq8qkMlDv3kKhs5cVKfMjrGRzuOXS2JifYQG9zQFBwQBdjar3vQGaAzijuMU6qcu6SVAWQbSqCuJzdH6Th8agHKS+B5q1duAIlG9KYqRM+Lp735YY5t7XbJKHdLskxAJXjxjpP70VVPznj3CT4dWYvM1k2wYTetCMra2qTd2tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg++rQanPLVRbp6RpVTU5674Hm/IELg9h7Ye5AyOd/Q=;
 b=E0lRn1xR3anNocF3MmS5iqI7ROHMqZCM44k+ZnAajOpN7ULK9hR2+J9JOysfk1ottrZonpDRSL50np88/g/iE/fnFGyOLisEd8L6e749AYcGPhXZxAjM3yn5MwyuEva8T8xz3QNUDuY3YSxF9Df0sseg2hrLhDkQf5OymN0VgnE2cDiFxdNSrFx1VtKYm5DiVway2HQke8ooX5uD9c3QjEDPnMQHlRZ7Pkuce/RwTYdubRGsETN59Jp7TUW+A7KZxM3+hSHhk7DQ73BFh1v2nq/MW5yVHfhSh8sBFCv2CCCXGtagCRWDydUch+rjaPo1St/b/wg7ubeHW0MkP6OBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dg++rQanPLVRbp6RpVTU5674Hm/IELg9h7Ye5AyOd/Q=;
 b=L5+jtrkID0aGh1AP3vz+u4y5h4KJGdLLwHDCxJPpxX6ww+WhczzTL5h54kvi+8MIQJQklDDNFcP9WiAL6Q8QucTVOs17oDLp6dCawUDqxB8dzalZtQLPdSlgySPgSZNzR0dB91t9/Duv7sTqz9ukNvwtktkLIs4BnMlqpwqgKVI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB6982.eurprd04.prod.outlook.com (2603:10a6:20b:dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Mon, 4 Jan
 2021 09:16:22 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 09:16:22 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v10 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Mon,  4 Jan 2021 17:15:41 +0800
Message-Id: <20210104091544.13972-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0055.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::35) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20 via Frontend Transport; Mon, 4 Jan 2021 09:16:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 98e77c4f-9e87-4686-8db5-08d8b091672a
X-MS-TrafficTypeDiagnostic: AM7PR04MB6982:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6982394B8C0EEF9CD0893266A3D20@AM7PR04MB6982.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5d7X4f3EZacFg3Wr0hECJmj7YxYdWXyKubZiSMBM0T8MVbuqoPg1PbO5vNkm7W1iX0p0EyxOeyg159wGRt83C5pSgf8GSpJeFmjMfJRfmlM0hZU7/Xu+9rKaymtKK81+IBPq655kDpKN4xB6SzmDR8r6A90N5SQ1EbFJZkddF4mgpSafu/RCYsYlmUre8XgbPSf4cmWe1NmrWUcL1y8gJ4aYQS29EtZm7k5rSQsd9VtQK+gMQyUrzvZ5BW3HUQ8+oe9aPy+0LSzFifo6XG5nvqCZHE2quKTM7y53ibCjO15pstZbLQVDvXAAQ5riQZm2tGqDoQyL/kh2UHlUJD/RcFSO7rbnWv8kLU4x/l8Nvuqvy0Pemo7Jm/aSxKPJXkPTkO+gyWoZBwtL9zIgqpYNtrxmOpbccB9w9y3DfulGVv+I0LCwZpgMSSjwd01/2iWKemwfrUhei0kRX9QzDCvoY3qkAeuSo/4SX7z4RUJPj3SoZ5/xC67K1DpM04BgfKcGFNYRcUqSoAnkf97AljYAKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(66476007)(66556008)(316002)(6512007)(6486002)(8936002)(8676002)(6666004)(1076003)(86362001)(2906002)(66946007)(4326008)(5660300002)(52116002)(16526019)(2616005)(6506007)(26005)(956004)(186003)(83380400001)(478600001)(966005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?41ZklPOjE1q7jnCAjVxQvRyG+hZEQtn+/ivyfeAw/z3/hdcLEU+g0YgsecOV?=
 =?us-ascii?Q?X3VyAOQpxoClGVcLZGNoijs2AV/NpByPX9cu/G9wNquRZhqfgoGWAbg1xhUM?=
 =?us-ascii?Q?nO2lCcRgOLdz0TosfaD+/psNzsWCTGdovME0s8lqkiK9Gss5VxBceuzjokjf?=
 =?us-ascii?Q?k0xPe9grmNt4Kc1nQuJQBRlZH6JMcuAJrOit6pgZcD/dtlEY3sv/A8IbMhsD?=
 =?us-ascii?Q?7zGL5sT+vI2RCTaLyCA0VkMhsoApBQn4K6mqemAyc9wCUrg5DifiPR2PAq0U?=
 =?us-ascii?Q?2HYyhCwiQfWNCJj7uupPJUpNF2kbRVbU+GmdeYc85oxjL9G+wtkG/3xGZ9OG?=
 =?us-ascii?Q?1NvUCMY4ZvcyOwLi2J297oNefS4PZ4A7J4YtYKtu0sO6xvlD7Y4qQCFSTlFp?=
 =?us-ascii?Q?mA9w2Sm2U4809cJjkbQHCORH+verSaUFgioTGbRx5efU1PSiRVa91uXKJlrZ?=
 =?us-ascii?Q?VY78pP8MUMaWa3uSFf36UM2wFv2Toz4hZax4ZyXrRegfo/+Ntk1nPkdTe3Hi?=
 =?us-ascii?Q?HuqPsempby+jkmtNzxxg7zk+sV3lSa5hkZYItNIES34hr1WBO1JBLSute7Xh?=
 =?us-ascii?Q?Fh4UIZ3i+yOzsRuJcA7kABbma6ucBn2gZx42vhsFE2ybbreNjRW/hQYWD6ZN?=
 =?us-ascii?Q?aWz5woMzf7124GyRaIs+HL8PbhbzD7+7ZaaVV2xu23BuPORIRWvMTFPYxCtD?=
 =?us-ascii?Q?3CPWPAwVmo0VL/lWq/G2f9DCoi2CshaCkSE/OryqEIoA6VF1G0um/FU8Tbil?=
 =?us-ascii?Q?UpCkWsIe8CqCzjlZbi2nEAhgACBwUY9E18r2F+NuSUoacvT+mrJBJMYKIvEq?=
 =?us-ascii?Q?l6TD8IBCjAya4xOPRfLW+L1arRSm659jPpFSwsta/+H52Hv+CgySilLyScqK?=
 =?us-ascii?Q?awVsI0EiY508SFMAWvHsj1i5ea4HDXsm3O84yNLH3KsjHccJinOBfncBF6dS?=
 =?us-ascii?Q?dTXTaXjYZlis2Oikd7CtqPijwNW9b81fiMx6mi67ZO5gozunMSE7uN0Okz4/?=
 =?us-ascii?Q?Otw/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2021 09:16:21.9244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e77c4f-9e87-4686-8db5-08d8b091672a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1ZBofOQrS5nsty7wmd/R5xO8bqaH9ICw6fZhBUQeZu9AOulMq9RDUnj9v6yXdWmo2sYVHy73vVIfnWyPaAzMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6982
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add DT Binding doc for the Unique ID of i.MX 8M series.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

Changes for v10:
 - add Reviewed-by
Changes for v9:
 - add additionalProperties for "^soc@[0-9a-f]+$"
 - add examples
Changes for v8:
 - match soc node with regular expression
Changes for v7:
 - change to a separate schema file
Changes for v6:
 - none
Changes for v5:
 - correct the error of using allOf
Changes for v4:
 - use allOf to limit new version DTS files for i.MX8M to include
   "fsl,imx8m*-soc", nvmem-cells and nvmem-cells-names
Changes for v3:
 - put it into Documentation/devicetree/bindings/arm/fsl.yaml
 - modify the description of nvmem-cells
 - use "make ARCH=arm64 dtbs_check" to make sure it is right
Changes for v2:
 - remove the subject prefix "LF-2571-1"

 .../bindings/soc/imx/imx8m-soc.yaml           | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
new file mode 100644
index 000000000000..effcc72f9425
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/imx8m-soc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8M Series SoC
+
+maintainers:
+  - Alice Guo <alice.guo@nxp.com>
+
+description: |
+  NXP i.MX8M series SoCs contain fuse entries from which SoC Unique ID can be
+  obtained.
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - fsl,imx8mm
+          - fsl,imx8mn
+          - fsl,imx8mp
+          - fsl,imx8mq
+  required:
+    - compatible
+
+patternProperties:
+  "^soc@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        items:
+          - enum:
+              - fsl,imx8mm-soc
+              - fsl,imx8mn-soc
+              - fsl,imx8mp-soc
+              - fsl,imx8mq-soc
+          - const: simple-bus
+
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 1
+
+      ranges: true
+
+      dma-ranges: true
+
+      nvmem-cells:
+        maxItems: 1
+        description: Phandle to the SOC Unique ID provided by a nvmem node
+
+      nvmem-cell-names:
+        const: soc_unique_id
+
+    required:
+      - compatible
+      - nvmem-cells
+      - nvmem-cell-names
+
+    additionalProperties:
+      type: object
+
+additionalProperties: true
+
+examples:
+  - |
+    / {
+        model = "FSL i.MX8MM EVK board";
+        compatible = "fsl,imx8mm-evk", "fsl,imx8mm";
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        soc@0 {
+            compatible = "fsl,imx8mm-soc", "simple-bus";
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0x0 0x0 0x0 0x3e000000>;
+            nvmem-cells = <&imx8mm_uid>;
+            nvmem-cell-names = "soc_unique_id";
+        };
+    };
+
+...
--
2.17.1

