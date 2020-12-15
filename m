Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD772DA94F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 09:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgLOIjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 03:39:11 -0500
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:12590
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727082AbgLOIio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 03:38:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqNIT0M+eg5oe99jwcIXE4ifqaUIIpcGKHp2jry1irLkd73aWV3ISU+eXN4r4ZYGHWrewCALvezG16viDrqhdlAoDLkVz0PDvT3XUFAi6SJraiGrntQPBcmSFl1sP3lKl/89ySLUxKco2ZTehP6iNCP+qabVtE0ysClKUEjVIkSjf6M79ix9g2n+9eHwqkdi7Fvf9O2yxA6/xWjJEoXxMZh07qsxAXPSrLKa2Xb4KrIdDitAU+v26+GJi7gQKj/uM5cUa8f4kOnbnG1SNLZ1cIiAWx7JUTWtL66BZAtEE96qfUaCEkjVI2f4IVX4K96vMa2Sc+Jn0KuHePa+4cXciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZqFOd7RqSyNuryOTwjnFln4saf3bUKoQZ9NCJ+gUHk=;
 b=mdNakFA9HOt/DY1vD9DrW19tAbZfLJqvSoc0JjfEPybFHwe9XHpvsd59wIkQQcvaK21omrw0AlQotC+JCGk6r+nm5XjBc40HEjFuBCq0j9hXQ9s/6E18Rsw2LfMHpE2gdffKnUbBx7LkF+H5XmM0MI/YuEyXeaH2Q/c49qLOhfIu3npVEuO77AUhKo8xfN5BrrfRQIo45xXt3Og3rhW5hXghi9hhYlbvxxLmgFnfkBqREe16sF4xJhQnUPQEh5NrKZjzmbRzL9DnfuAjUUiVx77Yrl+ZACnle+Ws87aJqZZ0uR7+ccJN/74wg+bssdVpUKEifIjQvlpeLlEzrzPEFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZqFOd7RqSyNuryOTwjnFln4saf3bUKoQZ9NCJ+gUHk=;
 b=MleKWwluWnIQSPxF1pKA6FCeLrY5/uPLJurrVdxVYrN+qVNU6cek8r2PdNOPm4241CxJ0w7+Pz8EPYEEGzC/JhV3Dk3hvVCR+VauqAqgR34swYQvzzDUQIaBwttHuebybSfQ1x5C8v1y3l1fZ8o6t5pZ03wiMG65h9PDa9lfvgo=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB6807.eurprd04.prod.outlook.com (2603:10a6:20b:104::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.14; Tue, 15 Dec
 2020 08:37:51 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 08:37:51 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v7 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Tue, 15 Dec 2020 16:35:48 +0800
Message-Id: <20201215083551.6067-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0250.apcprd06.prod.outlook.com
 (2603:1096:4:ac::34) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR06CA0250.apcprd06.prod.outlook.com (2603:1096:4:ac::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Tue, 15 Dec 2020 08:37:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41e1c5da-2007-400b-d666-08d8a0d4b5ab
X-MS-TrafficTypeDiagnostic: AM7PR04MB6807:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB6807DC6054EC5982FE247588A3C60@AM7PR04MB6807.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /oFGOXsyo/gSJtN8Pfv8G/dofnSJEe5mPCPtR1zQAeurCOUQveWT51h4V2esfA5NYcsVwqB/XiNhgaJJ+HGZ2bq3+purTUBo2kgPyjG49mAqj1NH6kXw61OBzN6CHij6HMlJ/qviHTNaBnW4EL9h2gU76aPLi8lKURiqZzt6DnFkTpFW80XLvL8/JagFAA6uX3Op2WxMKnxP0JcjD/s6pUOiCo2xd7HrlbLLQJ5fafWccFmlShJShDy7Lo5OxGjJvuBDdpqp0T2J4UiAKg5U2Veh9u1u/kO8z633l3XixArmmL8nABq5z7fhTCz0QbSZg3osLqVZgQ5eYfJJDd2m2ht5Sy9Yt9gkkwfjHfWIw4jDEcpgdPDCNlZuu2YflO/SZcmcowiYPqX+ciM6TR6tjDjyqgKvIeD5/Jmz8UWK5xazkaxekzUxuprgB43XPQyU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(83380400001)(16526019)(186003)(66476007)(86362001)(26005)(8676002)(5660300002)(6486002)(8936002)(316002)(66556008)(66946007)(2906002)(4326008)(1076003)(6512007)(478600001)(2616005)(956004)(52116002)(6506007)(966005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YNxRMWVSsELOCNdrhNBmI9KuqwVrCLtwKOo5IoNBl/irN0gY92qWAEMGO6pw?=
 =?us-ascii?Q?SXE9jNyBTOo4V6/Yc2Yd0SbZwfbtOsExjPh3zdZQIPv8HcbigjZFdzaN+24Z?=
 =?us-ascii?Q?cFhj6XNFGkIDOKTNueKt9Fxd1LmrmRvb0q7UxYUF34SpxUrOcfNuuQJ18Sp+?=
 =?us-ascii?Q?TsKvAuK+I/QyuJWl0yvq0nGvygdGuuW7cO1GEdv06kC3XKmZI5BzsuHRB/Ft?=
 =?us-ascii?Q?mxB3HeToKQxWk+Lm3ozAOKc8KFKy1dz9wIXKBFfu/DpOr50lWMNaYUV5pKv8?=
 =?us-ascii?Q?KTsZTUFIzxduor224DbbGxREKyyROrEn9z6DJN1LLsz+0sy5zT9IEs1AUaz8?=
 =?us-ascii?Q?i0N5TdeM9ZL25RoJHSCKm3B0IZo8yietHaA3LeuYD7N1ZLyLD/pbaagE6gGJ?=
 =?us-ascii?Q?oGuoMvnZl79/pCHzoWaJ1RmbKJ6VMLTFuCzVZ8q1hbkdq3yTOyxtMvzTspFh?=
 =?us-ascii?Q?RXAG5+1niP5n+4jUOc79kH/FBsdsiSIWTAQI/fkxLBzOwXN/hA4xoK+Jy78D?=
 =?us-ascii?Q?R/f2Oq0ZuTYGQpad7Sa0PHgHm3TFOyi05h7oxVEMoflIqBSToLhk8CsUzgVZ?=
 =?us-ascii?Q?2virXs8lIDolu6tRjLhrA9KkENhoWbexHi3Ds79i/W5wXwWwZbl1dhHA7VRT?=
 =?us-ascii?Q?fqncY2FJUT65+0oFJodwttEXVvKzqAmrpkpyLgTvcQr+WANdaxsn+MTRpAmy?=
 =?us-ascii?Q?Vs5FJbthfDmD9sJdh+JaNpY6M4DpS4zKyfJzUosnleELqJKiiScm3wDMk600?=
 =?us-ascii?Q?/hcQ59X4fzimGKMv74vX/3vMpoKdk81YzvWDF2vbLS6BsZP5GmTtAIpj7ISQ?=
 =?us-ascii?Q?NlqK/+KvFJhJfBe7F9z6IwxWdkbSwDLKZGwXRN+SWVOTGMdgObK31V91ENpb?=
 =?us-ascii?Q?ayF79UtZS+0chtc7l9j1aSfZc9zNPVNiiYVhoZoTjZ/9mw6PK3KS9uVZmmwE?=
 =?us-ascii?Q?hOARyZYi9XUu9KWCX29KN7parsWFNTXAlghka1+qAN6kccM4brMV9QgaXBIq?=
 =?us-ascii?Q?/+9Y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2020 08:37:51.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e1c5da-2007-400b-d666-08d8a0d4b5ab
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCcyppSH0KehKWk/6j8IuksKWZdDgSNgXbf1Vc66vKAE5U9My7l1tLl0M/yP9YEJF5OJcL/kxwZnxpyyXiZPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6807
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add DT Binding doc for the Unique ID of i.MX 8M series.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

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

 .../bindings/soc/imx/imx8m-soc.yaml           | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
new file mode 100644
index 000000000000..a2f7dc0c9b35
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
@@ -0,0 +1,54 @@
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
+properties:
+  soc:
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
+additionalProperties: true
+...
--
2.17.1

