Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC3A2A5CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgKDDHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:07:23 -0500
Received: from mail-eopbgr20042.outbound.protection.outlook.com ([40.107.2.42]:26775
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729078AbgKDDHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:07:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4Sl9OTcP0HOVNeIcj49dgmSFLJyilTipYWW/Clyb7xUShcLDVo1lVz1sSzDO08o+leLvhEP+xqrYZGrxevHi6BZgJKpnKKheXxfU4dJJVaaex7Z9AHv626x0QpBwmKv2WHK4T7UE+BkaF3oLRZ1aqGFtO+bGPdbIVoAqpAduoVZrmoTH6VsStr53O4o0wV/tbURe1jpXlA9W8ZD17g4cewcxAqbn2i8ubAby/pbaWJ7jcasftd/xyM3Db6H/v3ySHoFH7nwWQg6AIt2PjT/R9Odq3hFoGZslk5AtElDYLTC00hAUI9wUXaKAP7QrdOPRyeHtsKKBmmb1rfhF/A1Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbUksOFV0pcpkoaCCbRhnww0hbnAsUZacbEGgiKMRUU=;
 b=QiA69b7S0rlvt2yDxzs+mO+2f2pGUUeQBMPQSTMDfXbIVXmMssGxbNfVFGSRDSgxIcV8S7V2JoOfPEyyOUIwyrxMcZFWxZwWWFwZmi+dfVvsSznEUbl8DPe5snDSqK3+YJEuDQwfehyxb79wxh5xhzzjJWWxWCUGxyQeDFU5sykTZeF7WwgDm8HXLQJM8RQVs2eD//urFeQ6FOM4fRj8DGgcVkv/t8d88k6buKrVJ/M/sfSNfvbO8f7uJYEKEBoVDu7m52SCl2WyYydlE63rf9MRoaRUDOZnUbcktKUUSyOsdp6YZFKTJfLB6yFudSyI7jmZDueDrgfNxB0Fo74+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbUksOFV0pcpkoaCCbRhnww0hbnAsUZacbEGgiKMRUU=;
 b=gFF0wWfel2NyudMXbvc0WcbJDHlob1DnXhuYYJUzeo2q+xGFQiopmNdZyMfc7sBegazxYRJKs/MJ0xNFt/qzYMlF2CBWSSfpyX9I+MUfqWs1OLBnod37jjupM8a7E3ANxeI1uiKPxPnlRe2uovQvtGOp9XcsAUOthmiIzjYsRuk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBAPR04MB7365.eurprd04.prod.outlook.com (2603:10a6:10:1a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:07:15 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:07:15 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 1/4] LF-2571-1: dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Wed,  4 Nov 2020 11:06:42 +0800
Message-Id: <20201104030645.12931-2-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104030645.12931-1-alice.guo@nxp.com>
References: <20201104030645.12931-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR06CA0225.apcprd06.prod.outlook.com (2603:1096:4:68::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:07:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: cc104374-f69a-4fb9-991d-08d8806ebb8c
X-MS-TrafficTypeDiagnostic: DBAPR04MB7365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBAPR04MB73658588CB0A82D27707B12EE2EF0@DBAPR04MB7365.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UaOnZHtdnkiCgsP1O8FPOInZTzDkV8W2wWWiGIZlC7VWXp83dmOVamNGA0zMhZ5c0gMyg4PoUwHHhBt7bvSHwhYhpIcaFfzQZKCDS3gwBJ3HxFN0xz+LkA3dDoFoTWZRMKqefy13E8ztqMRGx1tlJJqLYlYKC9FfIapQ7+4Nlv77w2GZ7GucF4If+F0YfNmqaO7jZRr/YUG+S7jswGdCF1Iw10MY+HDmnI+D8lABR6PcYR2oRWVEmSeQzfece8XwiiocjyB/woLGB36YsJqEV7vJRcGh/xbK7Me7QG2o/i77csjLSKLi/+fW4bkhVgJRNVRSlvAj6vDrUsFBiqxt7sBkePty6n+Z2w1oYRhUzl4YC02p68xw4pq12A4woEaUTW6HwRhpROiZH+5XMcHQb5p5Wktg1HeVOiC+9OlcMojWcIt0BNdnr7Xiurr3WG+1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(1076003)(26005)(6506007)(2906002)(2616005)(956004)(36756003)(966005)(186003)(6666004)(6486002)(16526019)(478600001)(8676002)(4326008)(5660300002)(52116002)(316002)(66946007)(86362001)(44832011)(8936002)(66476007)(66556008)(6512007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xRZrXKWB1V+kzXBikz3bClO6df+u+aIe2UFZBfS8dV6W13yV41pArcMFmgML/ENQ1uum99Vuem43RVk0ysDFxVruBqfhbZ2NOlzBPhCwb2ArxRwqsmApgmEZttWIvp6qx5bZYiB/kPgrXo7Mph5wHdu86QIvK11F45M/qrQN5QV33sWO4ewkiHjyxXUMvPJtTY2uLQvMVaPCfDkBY6TqYa1Qu3XbGBxbP5NLvTskiezjTQUljCH+rkngvFmP8AFCcG6/oOBXf++dCmyk/IiG2d4NAw84GrfDOOY2Umxx/VdmGN84GKONGIbAFvPM8Ehs0+uvwg3Q6Q4q1fVl4PowZScJzt9zHEJuSj06Yy084PpcVaGAsH2ZADKgH1CJYSUyselUyohAO7dw6ick358/zCcI/J3oIxh/QH1HVyxHgQhsaCAv1FzZTN/I2z1oGX9ByRylEiRcdD/X5jBFZI4c1kbwKjFVL1xgAiy1xy8mqHxbvgSplRX001hEgwOs+OkBCsj5PiXQOmTsYk/76Bm0xizizX+8odWGD9l2mo/IJuEeIJQj/xGV27Hh75ItNKwwBNscXAwJBC5g3QRU3jUcncF2NXDFWLMizwDQ92DDJsS1IMuHNvNV/k2zFbtlttTgLvOD+KvNXQMPBE43RSQPlA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc104374-f69a-4fb9-991d-08d8806ebb8c
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:07:15.7552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ux6ne2xd1h4ts8yuKEQylQ/MKomZWkczynDTMl3SQ/hpzIKCKFrvxLrpRlN8S/uOB/zrmNMEajNctssE/ABq8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT Binding doc for the Unique ID of i.MX 8M series.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 .../bindings/soc/imx/imx8m-unique-id.yaml     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml b/Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml
new file mode 100644
index 000000000000..f1e45458cec7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/imx8m-unique-id.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/nxp/imx8m-unique-id.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8M Platforms Device Tree Bindings
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - fsl,imx8mm-soc
+              - fsl,imx8mn-soc
+              - fsl,imx8mp-soc
+              - fsl,imx8mq-soc
+          - const: simple-bus
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      Reference to an nvmem node for the SOC Unique ID.
+
+  nvmem-cells-names:
+    const: soc_unique_id
+
+required:
+  - compatible
+  - nvmem-cells
+  - nvmem-cell-names
+...
--
2.17.1

