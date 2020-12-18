Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568812DDFFF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbgLRIij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:38:39 -0500
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:32167
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732972AbgLRIii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:38:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkjc/Lt37jrTZVFdYMxczCn1shrGGAkEtV1qJG+8U58e98M8huaVK1lNKMVUH7Ngr+opAuPFv0Nq6T2p9L6LaDyKTug9Rk9x5XJDhdJymU5BJCadnKqsU3yHOSctwM3zU8C9WpeLDS7f2p6R+otpdjasV8/moGc25bsDaf74+orZmNjOlVLxuMRkVx5Sj2t0F4UxwP3k1ZhdE3LaGcAc/4cKnmxAsIWlei89w4h29AqDWLyngv0xgkuOcPtQ+DEBEo2YwM7JRPQG/dlY2sXrvfnDUSNpcBKAGdzgImIOglH17N1+WNoGwiPpJaDlmyoLFqePMOCQ7A6ZuqXkuIJBug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZjENg3QHes9SO65wM2vi7aBdXC+p2Vrzf6VIqQkBFk=;
 b=koqMFHm9Ar+b3YWke4NK2AMTY9F8g7uXjyYRtKDckafndWrUTnQsbcYoquo3uwQGunypcRBc8b4itzR+mmIuJBIVDboIISGHo1zs+uXhRHEIYfAx1tAWAnMDV3RzKTdx3lm+/XvU20UwXJ6oZbpWpS+IEW9+6hDa2vbQ8hqC/HODHLJf6dLQT0+pomv4pv1wvdzJpH1WBymWaVB7Ma2LvuiWHFVPalfKl3JVZtUcFL2SrhWo2V8hW7mGMYCF8IXXd3y2FqIg0/edvzqIVBKmNKmxzaNDil4rBs2A7xN/sZmm2NVX8YAs9s+SnlJDjqqz4aanVJEi4UMF5FkH8hl0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZjENg3QHes9SO65wM2vi7aBdXC+p2Vrzf6VIqQkBFk=;
 b=ADsfOUNWxSG27SiCsXIfzUr5B76IXdo4S60YRt83nSikLj3xwGiMo5mMF7gb7HO+M7UMSmmt6/Bkcz+ZuPjO0Wt3duER8budMusapHoz5OYXHy/DNhcb2GroSJM8JNvId52tV2/6gudR1J3KjOpAx6iaJ3HwNO4JqN6ZhA9f78c=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Fri, 18 Dec
 2020 08:37:46 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.025; Fri, 18 Dec 2020
 08:37:46 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v8 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Fri, 18 Dec 2020 16:37:23 +0800
Message-Id: <20201218083726.16427-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::40) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend Transport; Fri, 18 Dec 2020 08:37:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3ca114e6-5762-4ac9-2c54-08d8a33031e0
X-MS-TrafficTypeDiagnostic: AM7PR04MB7096:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7096A653D606604B04F8B925A3C30@AM7PR04MB7096.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xlBN/E7ZbK1u5aBqh5/0cXQIT5O7xwF+0zmB6p7ZrZi0Sj3Z0tDb849hQK/MHwgN/Pz1A7M8mH3Nr3qDS1dS+eY4TAPaSRhFejKYudxwMvmPGN9C/S46pPqfrrCmPDy/F0q2YWan4XB0DUnyXz24M/vkPfDZCDT50JNOQhjSBEbwlamQBOxC2pL8/PCrO0k903t+XPzthbosnY2FDPtaqGAJ0fZzRNnqOcqNDXLIw48Lh4V8jvLUzWAvU7tAusmYdFe3XvinX0dCSQIl3NuQqsVTb7CwRp/bcbdCIUfeougcwLLMi8ThLwoDpypCFgbe5dg5F4SnMlsA7PYeVoc6GWgw6a4GD2VM7Giq97qW31l+YdmZ3QoLNVa/1aLoqwLKJZFqV5KpotTVTyjH0Cwc01jcTxIH460ZOoNstENTcy6/DSos8/rZL8+ATyUzcKZocbW9JOxhumENV/uebreiiSYHnnmCgaUArCLEzBPQzCDQbW5eZJaiC/BpAqF+AEZ9PpXy73GBjbwY+hJFdDt8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(396003)(39860400002)(966005)(83380400001)(4326008)(86362001)(6506007)(6666004)(316002)(6486002)(6512007)(1076003)(186003)(26005)(5660300002)(16526019)(52116002)(956004)(478600001)(66946007)(2906002)(66556008)(2616005)(66476007)(8676002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?NIJveke/fOJbsEgeklO6Y4tM5Gj8veCzpwj5F0mDVs02ce4Ct692VlicJL6D?=
 =?us-ascii?Q?djFixoft74JD646etFqCzKhGRHZej/y0GaIQdF85kGLQlxnn6MeJt2ttcELr?=
 =?us-ascii?Q?H6dNEYsLVQTxWBuljy7mdbbWXFPAElbudE0+0Sj6Lu4KMCrj+CSk8ueusQkF?=
 =?us-ascii?Q?DH43TlDXkse76EVINbBBJ2d/IYN8DIMTORz4HkfOIMpK/y/9uFs7PmkcKURA?=
 =?us-ascii?Q?EhLF73vopty9x8L3ai0WkVbj2IVG3L1VfpHGY67xBHb/d7nQa9/0jE6zKScS?=
 =?us-ascii?Q?b/EWPJ/F1f2cd3D+drd82QpoZRL5+W37oDasqZMg6NaHmfRHq3HCj5k6Ybax?=
 =?us-ascii?Q?7ZGsIbPsEwy8LKW4Y2EpTrBcNYntzyGZaY3kivX8gMaGHGtFBmOKc9eXHnDN?=
 =?us-ascii?Q?O0HNF3ZedylcPMv3q9tGAzsSuTBifWhQ3j42B8M1i5bSaQ7oDeNapV0pyRPe?=
 =?us-ascii?Q?KQdTL1LWoB+OC0EzpDo4JtJMOE1TGrKjyod8B+wXQq1MtlMqS6Rn2ci6gZii?=
 =?us-ascii?Q?pWgiEDCTRGZZ8Lh32J8iuqC2E7pJ91KQmco1vumbFuffk1gF17JJiTk+5Fac?=
 =?us-ascii?Q?v08i4P68QiUB399jVx+p8YVEFODdc0xQtTyfbdPStvKPC/ThNuQ9WYgayT4Z?=
 =?us-ascii?Q?F6KGjZhLUdN4Fy8LI0gZfk9voeNng0qKPuEKzAzZy0Na7nLncQvSHVK8DCwq?=
 =?us-ascii?Q?o39fDydKXAYsi+Z0kXnzqhUf7+ud7nTF3X8zQvHuGYDQB/O2AbYkImAFYpxF?=
 =?us-ascii?Q?hc6ZYd96G78Kp7LIYRjdnX3z1EAwgh7uckFeoCyRD9s6DtbnkG/lU5aREN3j?=
 =?us-ascii?Q?7pew0+8kFixJN36/ttxD2U60gNs7Gxxfbd9vV1dqmr4+CkyZLDksL4WCBnqF?=
 =?us-ascii?Q?LtXFoi5ZRETMTfo3aKiNANa3T85cTfpdLGZJFZSR20guN/RJe0c0GD8KT8M2?=
 =?us-ascii?Q?uhnfB/srh2dkLtl3CxVtS/go/jk2ajq5c7OJbmYaiWCV2GDMYpkiVL8SgWHd?=
 =?us-ascii?Q?c27z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2020 08:37:46.2068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca114e6-5762-4ac9-2c54-08d8a33031e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWQcCjBKcmBjyaJx2E5HMJ3ZLBGZ/hM/Z8wVE7XE9rn0YsKAvGCDKamrUx2d65YXcHjtlPrdRrrtN9ZTfMVBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add DT Binding doc for the Unique ID of i.MX 8M series.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

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

 .../bindings/soc/imx/imx8m-soc.yaml           | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml b/Documentation/devicetree/bindings/soc/imx/imx8m-soc.yaml
new file mode 100644
index 000000000000..f0b0fc7b3ac6
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

