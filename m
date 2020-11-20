Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11242BA719
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 11:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgKTKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 05:11:07 -0500
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:10759
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgKTKLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 05:11:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPmJargvccRpdlLV8FGW32AB3t8R0g+m6b79EkMCD1hLZCZpAFZ3qYr8Kw/nFyAi4yaJEq4HV7+GRzsiZ0Prj+LK3c4qMmBNRcEPY6to1B8V0eXrp/bvJny6cKiX7H7wHY7LweeMlKQGBthjo+3BmLiKi+TrCSfklZhL7uEouQRrp0TEP+s/IaWg9kN2Ylo2pHrS/pM3zvtRlhC5pJfmZ7VkDE1yHFIwmlDru/BYP4gN5opKnNr2Xy9dFS/DH8wew3kuMU3y+WhylMiLFuKI2z3YCb+2ogU2EK3KXaMGLpeT3UuZdH9QHplP6S9ll4L8bkRzxM/CkEArq6fzA3B6Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TOvxZAeISpFsyzycAXHdvb34Ev0MuXwiVuCWS3/Q8U=;
 b=ftLSq4PsGu3tbHrkMqeivzl92mB6qOXqU3tRgOEtFFskg+sqMG7qBy8pAHWlqlrkzntPhU8ej8T9ndFkKI3r/hYLN85Dq8smj3jX/v8X62YAp8d1RW1ZAcG8GwWIVh+rnxjbaDlkpYB/BOLfopRYYcCmnctyPVC4lAnpIYY/j/rdoxkbPfY58xkML/WLzrK1i5eeu6gqN41ZVbWtshj8+EBbxqRQZlIuWVmPtPV5HiYM0VY9QtE1y6CB04clvFdM3wSK1QhhtPbArLJvE+3LavYoT35ht61OmE3QrlZ7KxFmxZM2wEkdd8kpieyW2h6SFgciK/FG+xm4C9Y9ONeT3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TOvxZAeISpFsyzycAXHdvb34Ev0MuXwiVuCWS3/Q8U=;
 b=PvUaXfihDxuNUOfqnw74x86lXQLo4aG2mKwQiZ+znKFLsyuosbfI/DSf9YQKlaYa7uqUfVz01PlCLeBZ91cAVsmwAv/juHmeDdc/woDa903i1HXB5Bjk2gCWQcL6hvV8nFV29aKhVqv2TD1tt6wfXJudn+j73CuJbFIK1oTodD4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AS8PR04MB7799.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 10:11:03 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::a968:d7c0:c9f8:b4db%7]) with mapi id 15.20.3564.034; Fri, 20 Nov 2020
 10:11:03 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Fri, 20 Nov 2020 18:11:09 +0800
Message-Id: <20201120101112.31819-1-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::49) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend Transport; Fri, 20 Nov 2020 10:11:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 610de259-5c70-4866-a8ac-08d88d3c95fd
X-MS-TrafficTypeDiagnostic: AS8PR04MB7799:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB7799CBB685800A1C5DE716C2E2FF0@AS8PR04MB7799.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LI8CtxZQK9YPPR3Ir1QnXCxg5gthietWAVkYA7pm9Orf8Atr2TI9iIEqPy7brfGGUEJU2ssQa9sQOE/A8UXgarDEBLFe3nxxpqv0E8ae31jpJNnqgVC3TgZAKQkllkM96Egp7Bdn1AR+6DSlG04mVsnCgxIZO9nYfpUcMddR0a28HQLpZ2zVMM3+hX+F8dLd5WiOPCC+U4vWreC57bts4srHPG1hqTZo/j6DmEle9HdXQAKzAVsg/Rg19mD2Eepds+rtjKXsJ241yyh/dJIAM09F1e0r9NFfa9ovmQ5EbhFSWONZI1q49XbuiGlpAv8n4ftY4KUgJSPk5XGocPH0TOGZKgTCWdANVvMJceeCwNimPnsymNbcpQE+xCmEK6nR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(2906002)(66946007)(1076003)(5660300002)(6512007)(66556008)(52116002)(16526019)(26005)(6486002)(86362001)(186003)(66476007)(6506007)(316002)(36756003)(956004)(4326008)(478600001)(44832011)(2616005)(8676002)(8936002)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qTKeXJRhMJ3J4cMXP5nj5hLHAiYHH8IhT67bjUEAtrCv/rQVmoapFq7xGAFD/zIV14s3n6DdAjdf6rX1k5IdYhzaFY+OY23vhCoMUBiKG5SZmKUZdw06ZXt0oWLVyIx0i/mAgu6k2vdo+cpU0Xj4VV0W8/0KeX/mpWzLBA3XbgxbKXZRcQWWhmFXsq39Bs2ba8phBqTMqb5hsrR+QhYDzTUVCx99bbJim59yNlFkE9k5o3Bv4r3dgwZPYw9t2+U7+g+h3gaEeYQOAPn+OhxPGuX0QfJHaQ96h2TKad/Zvh1iHid/6lekzHPAuSzphVxBtROrNX2g+E4/39+upDY/bDOJYB4cDXDUo9TeLsy/ia3PeNVd/cQZxOcntC+k6xsKAEujCbo6LwR6TAEXMZbKRAlr0CVnxtxkjIY4D49IKcfU39s710xwTodmFNMexwEMrm6EdWm1EHSFNA6o/fLL+4SkD8NdnjgGNnRCBn7gU7G6Z3aHjzfnslZZG3yD6caXa4/S/FnLhVenpDS516jPWUEn2O7Udc9NKKi8i+WF4PJsd40BB4BN+3mKtjiwRi8vryAC/zOLyH6ZAvbPTilz/X7DRlbD6emQynjuVUwuWvqlsTLdsMxJ2DvbdtCj7486uddRfxXeuVy4wRdc9JHk8y7G9Hpl8dCyZZRNds9t67HhdAerF4LBQh0AhpN9L+205vB81gfCkJN+RhfEOc+x+0cI9dTRfkooFGVPcMfmopXiY6VMrPuWhz75vaCdNobZpDnjuMNiW/KkRNOk4Attwf5WQS/wrUq3PbuLXIpWdARUKR86newH+Kcz6ezcFi788YLCA8+S/Pzj31JFa2ioLadLZxlcmUM7DIYpDx1zDJ4cV/QvxpxkDvz+klt11Ko5K8gdhgXsTkUqtkKZd8vvEA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 610de259-5c70-4866-a8ac-08d88d3c95fd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 10:11:03.1055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rx+7TG2bAEa69HVEA5BcnfByEUujDyRDQ5gQcNeE4Ab5opkX9BicL8GMCHTBTDKr03MVwVvissuv5YspJlFOTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7799
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT Binding doc for the Unique ID of i.MX 8M series.

v2: remove the subject prefix "LF-2571-1"
v3: put it into Documentation/devicetree/bindings/arm/fsl.yaml
    modify the description of nvmem-cells
    use "make ARCH=arm64 dtbs_check" to test it and fix errors
v4: use allOf to limit new version DTS files for i.MX8M to include
    "fsl,imx8mm/n/p/q-soc", nvmem-cells and nvmem-cells-names

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 .../devicetree/bindings/arm/fsl.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 67980dcef66d..d8048323a290 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -918,6 +918,57 @@ properties:
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
+      nvmem-cells:
+        maxItems: 1
+        description: Phandle to the SOC Unique ID provided by a nvmem node
+
+      nvmem-cells-names:
+        const: soc_unique_id
+
+    allOf:
+      - if:
+          properties:
+            compatible:
+              contains:
+                enum:
+                  - fsl,imx8mm
+                  - fsl,imx8mn
+                  - fsl,imx8mp
+                  - fsl,imx8mq
+
+        then:
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
+            - nvmem-cells
+            - nvmem-cells-names
+
 additionalProperties: true

 ...
--
2.17.1

