Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447F92E0715
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 09:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgLVIMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 03:12:15 -0500
Received: from mail-eopbgr140041.outbound.protection.outlook.com ([40.107.14.41]:44613
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725947AbgLVIMO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 03:12:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzHsWS1B51+TRmprQA8xwj7TFaGej+XDG2yYQ1hdC64PHW67jNNrEO2HCHuL8uralVPlMbK02rXHR1OU4BBkySWcrxDDhaCl2IKzM619cw7pmhdKqNzUN735vYX5EYF7LBDm+PLd9DImvZFQhZPNCcO1PVZFGxhnltdaPpY9Rc5xRNLo0SwWpZfL+giUhB+CyEL+Eo4gJzoxm2VlvLAcK27LZIrCR4s0QZOg7+KmgDOfDFncU1iuxnssqoNiJwuqsSmnwUi7XhB+830WPrQnwkJNAjG3G21Wh6ic067Z9y6ILrnnQ8sZ/QUuyPnB1sM6U/wFBlpGplEGtFNxtkM8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00lhLzYF6lIZAj4+XBE3FO4LJIKt2j7DhYOesh5fO3c=;
 b=AIqHthcCme4ZMSejVAT1Ooi1OAffFL4eFgI/FV/kdmvImXO0rPLhg3MyO3WcCP5rWlAJu5Kryfr7j+OLn4I8V3VT/mfKkZUZq/gXMZMpRdfXRhdynhKIGd7DadBocyhTuRjVzF+eZ/pSdJqt7IkdJByqoh6aWFlMJ1X6z/KzzpoYO+jbNFeopl44g7Gb+KSSNGTj/bluMpC4GgM3tVrQdZH4Igstitd9Ti7J2RPtdaXlC49ncSBtT+0KLG7gjEkzhyG3nJml+KSAe/lh1HPgG+E2vo2DFlILAC6JKt9IqrHWr++o1FZkSnoGk518V9VuFBLCmRnRjy1lZgM9HHA8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00lhLzYF6lIZAj4+XBE3FO4LJIKt2j7DhYOesh5fO3c=;
 b=YAYtcIm2lQMUNpPXBNA2QHR/OqiukXcLhPNevwxu78E9BUcGaKdAE3C09Sdi8Y77FkbRJ97y2WsYMrqoCshcy5ouSTrXwDSt8r+BIj4RT75fLweCn9gtFm5GWFMLDg+hs9k1uDd7V5rhVj3P60vuZFjaaTVus/S7d1HWTS5+r8M=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR0402MB3413.eurprd04.prod.outlook.com (2603:10a6:209:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Tue, 22 Dec
 2020 08:11:22 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 08:11:22 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, krzk@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH v9 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Tue, 22 Dec 2020 16:10:54 +0800
Message-Id: <20201222081057.26401-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR0601CA0022.apcprd06.prod.outlook.com (2603:1096:3::32)
 To AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR0601CA0022.apcprd06.prod.outlook.com (2603:1096:3::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29 via Frontend Transport; Tue, 22 Dec 2020 08:11:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ace1448d-9e48-4370-baf9-08d8a6512b49
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3413:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB341338A1C9C9A24F570DC4BFA3DF0@AM6PR0402MB3413.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dyhtkh9Buh0aAjFWrIruOM9SvYJJDSEvjTnEjaWxWVQpdFsY6QKu9cfY5a7Tr2oI9YWtaqWJoIShWYsjuozM06o4rmKamDH+QOZddLR6kJ+aAXdyybLxOMiDmn2nPuBSBf/PXpo5Cn9yv77sekXln8KMCOEIfjYkuh6Gq1BNbR0cMrmRmg2BFuhXoZMintXsbVpolpZO6k89dng2v77m1i5js9by7Cd0YGFT1+QuUq9RzBO/CYttK7w2vEvfgpkf99RPQaEsANJvEQHF3vLfGMbhzWCA9sipExNNWBRY8LniiKYQGtoVd8c7Qwf70dDCFV+9TzKXsDCSGuDNZ9hrC/BExE1GH4THSp9ayxBoA4/6uHs0eTG8ZJOhV6q3pJvS0mRjUTnXntpIK043U0rJk/PjkMIwVum2n7pUiZOWQ45DmVz2CY+6E5XogzTMmKPLRvNw6VQpZF5Q7QEffBy3gEGoZufJjVFGu5g25SvX8ZjEGVp1YRET6VaZlxuf1QkqHqnneY36096sGq5WPFvf1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(83380400001)(1076003)(66476007)(8676002)(8936002)(66556008)(478600001)(6506007)(316002)(26005)(5660300002)(52116002)(16526019)(2906002)(4326008)(956004)(2616005)(86362001)(6666004)(966005)(66946007)(6512007)(186003)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?yWMl/IPLkspFLFz7Tk3PwUSnDw4N6kgwJssURNsvIGCTRtdDrhCZs8RxNRGx?=
 =?us-ascii?Q?HBw8w4ho+qPgxzx46i1XH5rNvdnCa1yA+8txEfgCUqd2m0bOk263HMBtYXr2?=
 =?us-ascii?Q?2rn/Nbs6XFb+sydJ1zZyTwWq+3Yt5r394JYGUO2UMjYPW6D40trfxF2Rk/BQ?=
 =?us-ascii?Q?PKPJXo/rXmcUSCW9ELxyF706HyZ0yIBu5BFsUKnbpDXxYV6rWwgd73W1Y5cP?=
 =?us-ascii?Q?tmtAQeDogVxds6hQDpWOGqbVG8oemFWs0WM+zS6j9kgQcVzS+u1xEqnttsJ/?=
 =?us-ascii?Q?s+d3BZLyZf4eVXEUwl3uZm+WdJzj8cbSvnJDdDanOzQRDrsxvQsIG+TUq6Ys?=
 =?us-ascii?Q?xyBovLe3dYYy7JE/b5OTjlfoaRmmfVeGWhJ1c1yPftyajUkMLo/JSZ3EIynz?=
 =?us-ascii?Q?yzLZ4nNggToIVXZrzdbS1bebTNajDvwa48N7pOk1x9jNmF+FX4JFGYXn5QdU?=
 =?us-ascii?Q?N7AC5JBm63sClWbuSUaKMVPlAA5t12T69nGTnQ/JFAMkAjIKzFDyBTOD3OFe?=
 =?us-ascii?Q?Xs/ichBnZIBytTceqmNzZ99MAB0CR1PpC6jPfobA9sIKg6DLuWVhCoahdSVF?=
 =?us-ascii?Q?s8UTH7iJn/mXf+YloNKpN7YaZd9pJ2d4l/cGCbSqEuD0n6FzX0w10q2Ilx+o?=
 =?us-ascii?Q?3FeDrQ0ifxR1eBCYwSWnY7eCHtLEh7CRzK9hATg6ZL9i3tcnfrZht7xIsWJK?=
 =?us-ascii?Q?iATccmZfF49uHnknZGDbSPqgQcP6+rrNMJcFfmiWN8DB/10kP2/T/oN1v95v?=
 =?us-ascii?Q?feSUe3jlxwYeXhR9ZQyxwWyBPOv8JkwRrNfax4IGw7s2S0TLbl62C1hqNAvu?=
 =?us-ascii?Q?8J6x7I2wepf//Ru8BHqS6ResaJEWGRXrEkcWXrSJxU/76JlmOatdAiERntWS?=
 =?us-ascii?Q?vVaAawYs9RooLo1nNnMHN0sn3VidGjJ+W1RH+5y3QYM/Gzxm5HTT3yVwNMtD?=
 =?us-ascii?Q?KslVcHfJ7Cd9dtG/us72B9faRx+d8LSaUGPvxYbAaqNNuU0WsBWSkujp8Aig?=
 =?us-ascii?Q?Vg4w?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2020 08:11:22.1299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: ace1448d-9e48-4370-baf9-08d8a6512b49
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jvN6PfJeY4LXkAr78Sy+7h9Y/LFzAFVa7af22kye/8aWzzm+/PyHVnBg1GD32otdnv87QP5Hjm9kdUxUl+SLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3413
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Guo <alice.guo@nxp.com>

Add DT Binding doc for the Unique ID of i.MX 8M series.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

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

