Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAA32C0289
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgKWJvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:51:36 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:17993
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725275AbgKWJvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:51:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGt8zyaIRCo+D2m1iCP+Uvj46r8VD7bBPkSqG8vBx9OFM2zGt8AHN+lKHN84qyAb9n2z7RY9h4hvBg8MM03nQyYlUB0Y2HhERh3JonPnFj9WyyHvp2My2ieN1L+A/um5sYtBuJd/m4JcQ9MDgFV1HKJ1jhOjNM8VLkPkjbbnjOfZJ5uyAx1ZYUVzVxr3rBmlqV+KzBT2u3kDyQUThl4NAfqsVQW9zZq9yyG8n7lgHa2jHT8zJGOJk0kt68IgRAfKdsGqdhXM0ezri3YaXcWgQmPtp8ojHdCg1CnaHvVT7ZpbT58eNazJo7UEuCk0hqA0mA37KV+yKvdjxYTfvycRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9tW+5mIADY4usrFOv+S5a3+2SU2dQ6RziprLWmT26Y=;
 b=BRtNJexpYo1XgF5UPbr/tR7XtIsN6Efry0FYruCegk9iANYo6HqSYC8x+ojFWgRh9Z+dj6Xi+sLAvW03MXiq9yLMpoanHB0Z8Y6hOR0NDcRm93FuOsDQAb1piYH5zFfKxZKavTtlU/5sSR3/OsvFZnffqtdxPQ7KMZUu4iWw4OEY+mLP6cn4JMVAG5OuFqU7nv1y/oRvNVaZE/Tv1rlMcYK/cK3nrnHCiMuMHE7rmkqOE44TmEQ0JnwAU+wcxl0nqFC8efstClKftityP7WPd7r2VVknmEnV3JwiaRT/DhXxp3D9Wtmi9QxIMBegsrxxlmNiummqgrayIb5p39LtIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G9tW+5mIADY4usrFOv+S5a3+2SU2dQ6RziprLWmT26Y=;
 b=qrpgWzx449iWzWARj2O0AHvrLwyTfoJgiAToILxuC6oCu9gBrKICEUmvPbwPdl5vEczUHrT9FBjKvI9g+IHQbfdmzVCFnGlvYHMrO5nWWBDDoxviWEluFnByjbN/BMoGu/tSqI9WFwaRocPEZUD0SPJqSfOG96mIdTVeAoFAly0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7048.eurprd04.prod.outlook.com (2603:10a6:20b:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 09:51:32 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 09:51:32 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Mon, 23 Nov 2020 17:51:05 +0800
Message-Id: <20201123095108.19724-1-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::41) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 09:51:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 485c8454-4cc9-48f6-5c2c-08d88f955b71
X-MS-TrafficTypeDiagnostic: AM7PR04MB7048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB704852B67EBD805532E74963E2FC0@AM7PR04MB7048.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICz0r1RiqC6AYmp+7OSGAqFxyAkZ4Bc8HaYKvDK9IWJFR9LJWzfgxSCGqXvE0sOi1q/s8KJeumtoo+jx3bOrzKRuMU+LX+UEfTfZ5LVM1PFzyRJN3740HMOjoznRXh/JXaZWtFTEkrGtTD1wAIve00eL4p/j9QhDXmFh7qdcRSoFglgwa3a/kKfClkEx7rwT9J3RNaLTXgrnwEM+XFx2VyA3R79kKtkHAvFEBJ8+UzCU5LgXBUhIrwnXsGjBb9HPezEOeklWU7F+b19QBI4kDTsMGXEYrIz4yXiJeltMXjQ/6lnh/ZxuE5DyJzjIcfGKKNtnTLHqfw7ip3v+UqSINhqOAx+P2lgmOUKueY8/6zToezEV7/QVPHWCs1XA4kDN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(2616005)(478600001)(6666004)(4326008)(52116002)(8936002)(8676002)(6486002)(316002)(2906002)(6506007)(6512007)(36756003)(186003)(16526019)(26005)(44832011)(66946007)(66556008)(956004)(83380400001)(66476007)(1076003)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7HJPXVfDMOCuOpL8NckIXgobAP+LypbikX/m5Wd4Ug/HVhy58JsNffQ3AoR9r4TPzg7Lt2PfKPeL3GIttuWGiu/+rn/SX6P6Ne0VQDDHZSAWG3+e/zs/x4eyo1SVD/++XmVKnB1e+US6t9Zwr4UZCzymBuZ3Dj837816CDsC1NIMQliOIIqyh+JP9CTlJhub/C0HUtqGO09+Y06nvCuT/Fm8MEjVuf5Ba57Q5tPxg5TmJ8QLZCad05TrNZ9K6ur89kiUBlZ9JVUcsdssvKoVlV94uEr3iSN4BRRs1jSmzgnItmSnio1QbIdLC8JJngbbxeVcRrgdcBCRJisO091KEOxqHWQX/ChqbNDin0qDw2vvnc+WZLGdimgX8hDWHTpwjJeVUiz3ohCYrcxGt7MimUVquneZPztnzye//mqDBtKrXiT+5TpSScZ/NKwyHJT36hT53WL94Awut3igJMTwX6g+gqiBedZtHDfDpvhHBxckOY7s4zhJy1oCGgvcWx1S9FTxRiNxPCJu8Y9Wvep28IvOVoElgrfSGsotEzWnAio5inNWG75X/7q9pRs84MEXdGENEpT5zp0v+6ebjl/twVRjkLufHt2fakRVOPbloFUJYKLcgJuDD2/xuIFFZmoFv6Zwi6RwhFb7A7o+OAYXW8KNfrDlMjjR9Z1YFMNxmTO3d+/NHLf1fT65jgXBzNpBT/k9wp5LBoZhpBuglM2O9KC6bayDEY8A5PsmTjStU9tgm42wPCL/79/f53YcJgcbMyx982erKjUQGBE+26QIhfja+AlFhlrwmFpPLN4oukPYxgU0HboIqvCIdvb5e0q1xkNopXWXDZvcjSMWZcrarGj9uTedm2ExRjVsaf5Fc4omFQ9+ZFmS8BajATREfhRUIzPiC1yzUbj2SwbHc4Dkfw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485c8454-4cc9-48f6-5c2c-08d88f955b71
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 09:51:32.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7TKYnyDcP4ggExalRLNqeJ+f6jUwzoHOerI7LNslsw091QYOeFiKvYrty6imeDgfST3XK/Favd/Tx3sl+no8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7048
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

