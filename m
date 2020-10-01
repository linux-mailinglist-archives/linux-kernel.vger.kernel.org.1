Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F6928024E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732511AbgJAPPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:15:22 -0400
Received: from mail-eopbgr130101.outbound.protection.outlook.com ([40.107.13.101]:14562
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732104AbgJAPPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:15:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZ5azaBjwaxxpI6v4sXrmvXNOLpkGZNxG+nebot+ELY62fIU8o0rXZdAsM3pZVNtQj18QvKxSnLbu5/VI4DJI0yq++bw0ygmM/bHXMh/aNNsrC3V0g/NpWQUoSHZmP/isCVbF5fJZIbaKY0JMYMDCChXhtlM3nAtVfrR9+ACrq1xICC01Fl/aocOafHcpsAVdPOMLqAHl6j82NGebrCNcCYlZo+0kLFIKgoZDZc79l/2CZWGh88mvW1r7MdpRpocAyuhpqfwy2XRw1ZsKB/IrlBHBXl1TnRvgoQjG5eoa6qdktIbOpMfCX5gWg9FJTcJtlz/0g+T5XBMzQcw6OoEUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bwcAkhfQte3NzjduOZoWaA9ZSIGrxfH7Um39PEiCVk=;
 b=A6ByYULKuYyEeiY7ny003Jy3eqfCAlk4L5oBz+O8aNWPUjDpzKMUa01ERaEQnRDWA9dv8FgeaNf0bPzGIlCU/E7TxmKACVijCDvt8Wr4XEF8S9TMmktjK9QmhTV4ARz+KKg+vWdT5ZK6JXUWa+J0do212D7ykjUNSoIAs9jxDOfeeyM/EdvxPbwHPsy8OgKll7ZDS2Nt0TiMrHdOHMtSkW+wgLrxII5EiXPruV7QEx8SRtAENFSOWMXu/+4A+ZrgHsd+BkIVtESrO0fYJWNJEALa7sXUj8sAvizPzopiWIY/fpAdM20uWjGL1KwVl5Z0/DoFIaZyeDfU+7OQ6PY8UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bwcAkhfQte3NzjduOZoWaA9ZSIGrxfH7Um39PEiCVk=;
 b=UXa4eGRAIoZ+qXeqb3aEpj1j4zmZW7y9GOZ25KvdWHyPa6ISZYAOaBCXt1PbQvKWi5i53E+4mu9HGnRtcFHLSWYlYUqnqS2zRtkx+hulfu3SzzeST8CqLGL6tvPMYgiRstPHdcrsx6cBOlyNVE/V4Gvboy0Bgp8kiEJkvYoqt88=
Authentication-Results: kemnade.info; dkim=none (message not signed)
 header.d=none;kemnade.info; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Thu, 1 Oct
 2020 15:15:18 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852:b8d:8b04:d2f5%6]) with mapi id 15.20.3433.032; Thu, 1 Oct 2020
 15:15:18 +0000
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Andreas Kemnade <andreas@kemnade.info>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Michael Walle <michael@walle.cc>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Robert Jones <rjones@gateworks.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] dt-bindings: arm: fsl: Add Kontron i.MX8M Mini SoMs and boards
Date:   Thu,  1 Oct 2020 17:13:38 +0200
Message-Id: <20201001151422.16028-2-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001151422.16028-1-frieder.schrempf@kontron.de>
References: <20201001151422.16028-1-frieder.schrempf@kontron.de>
Content-Type: text/plain
X-Originating-IP: [89.247.42.197]
X-ClientProxiedBy: AM5PR04CA0031.eurprd04.prod.outlook.com
 (2603:10a6:206:1::44) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fs-work.localdomain (89.247.42.197) by AM5PR04CA0031.eurprd04.prod.outlook.com (2603:10a6:206:1::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Thu, 1 Oct 2020 15:15:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c4db0b9b-65eb-428a-178c-08d8661ccea6
X-MS-TrafficTypeDiagnostic: AM0PR10MB2322:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB23221E8BB5C5729927BA7C85E9300@AM0PR10MB2322.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zy4l7JLfSmCLF9aT9dJj9HNvsEGE4i8twbswgdI5JKvFbJhAOk+n+YeGBOzS0m9pYKWfp0ofVIFvljvhBJz73bpQv2ttgJUt66v5jVpk7DsuACvsBZH1DjNdmMq6CF2fPS4MfkXSCVTtA5vE/K+09VqsRhBZpw1NNGYPtlSvcTUJZ5LyIhIdndFIPdcOJL/h3t266fEuMKneKg8mS8wqHqNH79ooRVRHestG1j9MW93orSMuk1xc3brFWT6vvJ2L9n6gsu5Qnf1vUE3zwKT1i/xhn2/6qKakm6NPV4Y7r8tgZkUzpAbeIGqU0J5e+rvyNPrTzaXhfsdFSAhs7NvnSjIAMNWh7BE6GdjGpA7Jyd35XwGrRaJTdXCmd+LBiu1B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(6029001)(4636009)(366004)(396003)(39850400004)(136003)(376002)(346002)(8936002)(6486002)(478600001)(1076003)(956004)(2616005)(7416002)(2906002)(8676002)(6512007)(86362001)(36756003)(4326008)(16526019)(66476007)(5660300002)(66556008)(66946007)(110136005)(26005)(316002)(186003)(6666004)(52116002)(6506007)(921003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: WiZvrQmTMMILU0CLgqqmaNf6DCmZqjlBVBU4fQf03akUmAKHD0QysWPq5utABu3kJg+fLGYqHL89cBrsEnLBjUc2TnfeZRIRwoJzJMWA3P1XkI54kreYuzxU+ofrYv4r6CS7DJWaPvJPvt+lnjUw/G1f6NGz0ToZWJEo8zmks5YMgsXrRzKdeKLsBq+UHxv/PMcZW3O3KOXlR1I0rP0lSABOAHJAeg5HyzL5I0qKsgIROnqrck8QDrPPP+nM3NuhNr3UWtRBgxLqZvDV/IsNnz8qJ0P8lLX/NsenbBbqd5bODlzQKZsj8qkXTzROg0kL8HbMAdZAiPpdfBt3dBQ6h7o+mnVowA0YtzsQzk2j+cEPKTfMOjG2nMxaUc9wthu1ZITrzqeeFxHWzLhM8FYSbuV4wrH3qQeJD594dNIVr8s1iNzv+VoN8LXj0gcaPumzAmavixTivoRJTF0NqHKDrQIev71Vx1j6RAkobDZZNGr3J32cDrCO6HbVByf8wS1AUEVdYUE/Ck+bl6WxRLI5HkYenYil9RWD5EsB2xNDfDI1G8gThY5HPdXvH/DagxahMQKR8H0yah2lU82sIUJDviKpJNR0ExVxqOAjJzRkuN/EX9DrINMxikBP6pSaaLxcANGlbnVve6XG+YrXO7erFg==
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c4db0b9b-65eb-428a-178c-08d8661ccea6
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2020 15:15:18.7452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HmrGSo14dttetzc21iWQTEr9g+We3O/QvUvUoCFbufzBebx6Y8SSA45IJU0iTpyhI09xuDVyKN3yQqdj4DPuV+rQdzBT7v8wPQOogLD/8AY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2322
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add entries for the SoMs and boards based on i.MX8MM from Kontron
Electronics GmbH.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes for v5:
* None

Changes for v4:
* Rebase on next-20201001
* Enhance SoM and board description

Changes for v3:
* None

Changes for v2:
* Merge the SoMs and baseboards N8010 and N8011 into a single
  configuration (N801X).
* Add Rob's R-b tag
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 1ca9dfa8ce9a..6daf4c046785 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -405,9 +405,16 @@ properties:
               - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
               - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
               - fsl,imx8mm-evk            # i.MX8MM EVK Board
+              - kontron,imx8mm-n801x-som  # i.MX8MM Kontron SL (N801X) SOM
               - variscite,var-som-mx8mm   # i.MX8MM Variscite VAR-SOM-MX8MM module
           - const: fsl,imx8mm
 
+      - description: Kontron BL i.MX8MM (N801X S) Board
+        items:
+          - const: kontron,imx8mm-n801x-s
+          - const: kontron,imx8mm-n801x-som
+          - const: fsl,imx8mm
+
       - description: Variscite VAR-SOM-MX8MM based boards
         items:
           - const: variscite,var-som-mx8mm-symphony
-- 
2.17.1

