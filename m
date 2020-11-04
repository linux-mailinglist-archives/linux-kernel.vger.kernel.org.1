Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876FA2A5CED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 04:10:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgKDDKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 22:10:24 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:7072
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730070AbgKDDKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 22:10:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERRs9OcLRbsATnQMMFyREClJLafXIdfyGlTLbXI05q+INtsq2oG31v4ohdKqI3i9wX02b+algbwVz/j7K9Xm9FTfxgseE+Cb/QlIOawRhss6NyzjMS5vu/PNQ5LK/tpv7F+InH8fgXpcgERl4YQWhFcbGXjrjaHXlvM2j+F/Wz/uVcI/4yjpm9XD7IPhRscg8B/FEKXS+xWaoWtw+L8yHjp6U6LoBnrnobzI6yF+h2/hVDgbBYuwIqnHOohGCGVcCHNZPeEj1GFLBseM1/DkDH0TWeFueUcHiKtkXh13FMYCxzMOQFa5ZxCLfHgxoESncBnxoJLuYJ1cEx1pclNQ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbUksOFV0pcpkoaCCbRhnww0hbnAsUZacbEGgiKMRUU=;
 b=kxqe+qZ3RR4U5qgXBDWs7DVkYjuB/LZE6d1LBe/gv9QkGHRkSOOMMFCOqN+bwzeFMDmIKXpSBI16+3Ket9GcG+atWUd71IabYvuKiFhRVKtjMUXV20IGffjeKmBgdyluyqvT17L3ud6/VBp7QSip0w0YYqp6n7vMG1rKbFeZup9BCkM+XEO2RlhaYA2vwclIoLGX0Am3mYVohpgG699JpKCrtatRmv0TzU0IsPjRmdPrPb/qPHesI1uk4NERJychdHYeO+K/VsoH6YzOvxVtfgNtFtHKNaFWw1msDPKuHCmqq7Fm+Z+QvkZAqdhVOW35Ev7iVVVsHOzTk6Tsgg1dgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbUksOFV0pcpkoaCCbRhnww0hbnAsUZacbEGgiKMRUU=;
 b=iRAQ2KbcXBVLA71rMOcR9IIf08KPL7P32rHkQimL05ELk4DbaQBRFCE7s3fc0P6Kr1Uk1FZ19OrR5gWgJJts9DKK0UI+IVV0GBKeIEb2GW2NhOR2eFVZYS7676Xq0CLjyHhkHg5WuACpszwC2Kx5vcKfkuA2a+8c08BY8UqNMjk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 4 Nov
 2020 03:10:21 +0000
Received: from DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618]) by DB8PR04MB7065.eurprd04.prod.outlook.com
 ([fe80::ed87:8435:3012:9618%8]) with mapi id 15.20.3499.032; Wed, 4 Nov 2020
 03:10:21 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        peng.fan@nxp.com
Subject: [PATCH v1 1/4] dt-bindings: soc: imx8m: add DT Binding doc for soc unique ID
Date:   Wed,  4 Nov 2020 11:09:56 +0800
Message-Id: <20201104030959.13264-2-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201104030959.13264-1-alice.guo@nxp.com>
References: <20201104030959.13264-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To DB8PR04MB7065.eurprd04.prod.outlook.com
 (2603:10a6:10:127::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR02CA0113.apcprd02.prod.outlook.com (2603:1096:4:92::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 4 Nov 2020 03:10:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: be59e439-12bc-49e5-4a52-08d8806f2a02
X-MS-TrafficTypeDiagnostic: DBBPR04MB7961:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DBBPR04MB79618EACDA652995D6C80DABE2EF0@DBBPR04MB7961.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hS4AG31AqHVKZJ7EIUo7jIQTKWmegeXW3e+egMVEPNQRP+h2GggDg5Zf59n2WRq1IPu8aNNZePEB+GeFgggLJOd2iTQQmBxOyPziIac3m/DVKmVkjhp/V924U228DCosI/w++1Wzk+WrITywpQjZlM+rb6larLIF4/LFMbUTF/P4k/34LdQi3beyZmv6HKpt0+ypjXzhFvgrldsO24RNLKp4PIvHYakAIapNwccQhbkkSXyboL/9FK04lTdj3hkhR6MKmCuw4fLRgbSbs07dC53loZaQg9yhyNJnXddzD9oyZQ5jA96YNYEmrfREp1MtW1tu/mW4p+US4DgGjnLo34aHOpJ6ZyE11Dp0QKtCjPwEVXUGqETHx7NrZoHv+YB6/B5v9ddFd7fQAI7rqwg1/OpDo8ePgsY1QZd9TImxy+qBqM0LROV9zgalJRmIeoFG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR04MB7065.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(52116002)(2616005)(1076003)(4326008)(956004)(66946007)(66556008)(36756003)(316002)(6512007)(66476007)(8936002)(6486002)(966005)(478600001)(186003)(8676002)(86362001)(44832011)(2906002)(6666004)(16526019)(5660300002)(26005)(6506007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: UjHFa4nK1w16pv2IpTHM9BMuYp98ALpt75CCREvyPCMXmarmMGmzoi9SwaB3kwdzy5s8pWmitw60awIPuw08Mc3emZ8C+dsGUk9xmvmeinFohXyShD5KvPKV5dp2Ou9GAkZN/lEXsN/MeH8RGK65rIbeqEMyzKUwCAhBlSRzWfcNpLcIn05KSA9SjwOuf+r/6WB63Sl5JjpOmsjSuEj0SsRuH85+aig5XdHOQuVjLA9t1X7ZYFNp45iAoRmWhkuOr71Dib+42GCtYOz/rHjngp8OWIpk3XM60Jw0TI8tPDioL6bNm+agKSCbW1XncDZhtej8Z7LrzJ9cngPRXGaGMNmHPf426h7xHJ1hSCWW0aCAKnsyfvGxl5qy6QDALk918j1TF9E5dJ6ExGYmhu07TvGh3P5GHF5PzqSauzZIhWDNK1A5QT6tUow4nbrpKKwfiw69QzN4bkenKDRBKsxtQxpEzemZteI5BqYCvhsfT7mz1HGaX8FysPT/3crLOPL9hJREt4ewtW7Um7QGsdHmnejdtNQtCyL3vlo3V3SUZUc3X172ASsrmwmytaaUDZldeSmlP/ttlXcamxOUzT4MXwBlr79PSYLGs149S3O52pgUF3TKf1eHMQM9kzMUswfl5hhaPzKnQp40P2Nnp8Lf4w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be59e439-12bc-49e5-4a52-08d8806f2a02
X-MS-Exchange-CrossTenant-AuthSource: DB8PR04MB7065.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2020 03:10:21.0798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejJaEZjh/vmNkohnnR1D6JIIs5v/cqSHJS9Tap1l+oi4l/cX6dXc3J5OQ3HNv5jbNC4+3FjAzyIcM3KUTI/kjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
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

