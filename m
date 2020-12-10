Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BC32D55A7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbgLJIum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:50:42 -0500
Received: from mail-am6eur05on2076.outbound.protection.outlook.com ([40.107.22.76]:48193
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388219AbgLJIuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:50:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mlQjcWe2mo3qylsx8IsGqAMUTrNINw695GUU771N6xHKOdJsM1ZKpQUc5pDWw7h09SQZovTXsMxFXQUk7DJweb+9CcGHvncsHzS/kXFfmE3zKBAWw6C7+5tptBIN4yF6r1nSO4AjTXdPuxBs6FWsEo6KYIz3jxWsaxK3ebQTbvKw+fxJYPb+wlBKEKFo2iZ0DD0NPzQ9+jQqYwg4EfF7J33q61+zf/2jwa0d9q2cUhtlpcnPeqkfqElQf3raX220oEiTE9bhlPjCgxdYBWHENncq2xzdgahpIe+n+iklT0Cim3XsJA4g1ItPIUYKafddglFSq/DKaeQBfsULltdo7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKh9XZkW9Bg/RRnRMswGzrN/E4oIRi4kmVGjHlBc89c=;
 b=aixATyXJg3UPp4vHTDR8DG61eZpgAhoZaIpVdrQi48lb8DzXZsZJ0WR82qVCi7r06Ho2l8uYriKEXLZP7VVTL2CywXVF/hdRTpcifD5bYnAeBn1GKxhRcwTPy3A/xsCr+5AOonZCJ5l9pm1kqrasJt3j/e1yFsdKAbIWQb62Q+A3r3u1VBTgxdyR7ugLjYSV2VJ1+YP4v4MPlCgw1qMX9dXS+WyjE8D5PY/RFONzQfQAFm/oNOYl+LVv1OglfbD8P6iN4OJQiBVN4z7n9XarOuIFavMenJDGwlvkONoCQy48aJghsUOX+FL/0UnYI+CtqRK07vQe2afaqTWAAZX6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKh9XZkW9Bg/RRnRMswGzrN/E4oIRi4kmVGjHlBc89c=;
 b=gZ1G8StrhNO7DN4C9SKK+ynJKv/ql+S7p/Ecy3UDcVACTDdgxWQ/cknOC3NFzMvvf5nV9z09d4p7HPlnpWiZdcN1Jer3Liaa3jtFHnOcYIr5jWAgwPNhHTUyJlsibVloCk45If3Wv4rBKmSt8ztXaXYib7krBolP0BMdKHMMqbA=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB5635.eurprd04.prod.outlook.com
 (2603:10a6:208:127::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18; Thu, 10 Dec
 2020 08:48:57 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::8939:96a:bb5f:e4a6%8]) with mapi id 15.20.3654.013; Thu, 10 Dec 2020
 08:48:57 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH v4 4/5] dt-bindings: arm: imx: Documentation of the SC secvio driver
Date:   Thu, 10 Dec 2020 09:48:49 +0100
Message-Id: <1607590130-11065-5-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607590130-11065-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1607590130-11065-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [81.1.10.98]
X-ClientProxiedBy: AM0PR04CA0104.eurprd04.prod.outlook.com
 (2603:10a6:208:be::45) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM0PR04CA0104.eurprd04.prod.outlook.com (2603:10a6:208:be::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 08:48:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fbb13c8-6133-46a8-7f58-08d89ce86eaf
X-MS-TrafficTypeDiagnostic: AM0PR04MB5635:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5635EE0B2C2F87E151466053D3CB0@AM0PR04MB5635.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ku5AMLfuP/SoTjuvhhUcT7EGq85iX0ShRhfqk5xTZvzbZrCgy06UO5r1sqpmCbwYQQMTJ1U8PKZM8j1T7CK2n3YUUEQJqMMhN6PFudJ5DYD0hDKSO+0VeWQxRwkduloSzsaKb+w/Ee4G03SmZPOd7nVREkNYalElO14VcOqJNAaIDyGguTJHzC4IjJGl99Qnwwu9PXryevlJeM9PkmtpfEuDJKZoDkOWxX3L3qpvEpeZWqybk7HzMhLRrUetv7d8I2x3+ZnREuOahtaf0F6+5TEnJ3ioWyH8kaRw7MaJ2joRblrXjI3BwIXzHXX7uYvEW+uLf/AYwN28Nhrkol1gJLEPY2cE5f8jvPWiOcyw3xiXLNbgzl+KHLDwIHGoFqrbWLeJDfcdHnmm84aCtGaAUQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(5660300002)(4326008)(316002)(66556008)(6666004)(52116002)(6512007)(9686003)(6486002)(26005)(66476007)(2616005)(8936002)(478600001)(186003)(8676002)(66946007)(2906002)(6506007)(86362001)(16526019)(83380400001)(966005)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rNGOYC7MXrQGp7btUiuHIDQuQChII7Vylln5P+2tuXh6apd12TgSluAMMxYA?=
 =?us-ascii?Q?sr0dPB/J/ELqgkMIntXKPeWuuMs3OstlL6gQ1Nj7XHYS5KRnnqLX7t5hqJps?=
 =?us-ascii?Q?3uIN7Lb3lvdBmOqQSRrzJLNWLxrVQdGdJV4rayJjpfzOiCaLOQF5PCO26WlE?=
 =?us-ascii?Q?TnLS41VXObnKePWxo0bzOuJm/VO+4zU2Cc5JP4+ww9FwrDVEF+pwBylaQxla?=
 =?us-ascii?Q?XXBdMs2D5nrAJBl9InljZGeg+IA9l3hGps9ZxrzZKIUxII8M7EEuybBlIfkE?=
 =?us-ascii?Q?XYmpk7A60gKPEe8FrN21cIle/jqpaWUXJK/Z6YIbIKu3tthIjh8sOmXiCAWI?=
 =?us-ascii?Q?IUG0ggzvHLOoN0+WQKbUJCaVs+Npjsq6axe2wGEAWsoDhpbAkPvXw0IWoJ89?=
 =?us-ascii?Q?u83ljU+GVHRy16NmmE5mZYKinHqlAHtFdjS3mXS6oamKsEbQBi4rASj8Z2j/?=
 =?us-ascii?Q?Ng4QkHpTLXYQADxAxIoKpqYVYBZ2WqUaFhNkjzAjORroJNgmjx1EK2r40trE?=
 =?us-ascii?Q?cXOehrN2n02OOMG/nmqC2363wRA0f4Qrm7onr4m9N1ycF9wcwUimZfTzCfaP?=
 =?us-ascii?Q?6A+o+SMRE8tnMpblwv9fe4yhpbS/T14WLIyKdLW9HTlRQOU7NXS7GoZs5AZs?=
 =?us-ascii?Q?KMiIAW9MFZWcXL5oBGibXdajSjovYEBlI/OFNeZduA+2WWqqA90Ae3o+926h?=
 =?us-ascii?Q?10Ic2hgtOLN0RFad6mO2hVQu9BSTZtMoooBaTjG7jUOoAD1B3iia6cqQNPFM?=
 =?us-ascii?Q?TQsrBv6Rp9CgP7UlJt1iDCTo8JIRhlYzxJUR0MLRdKmgh6q88IDJLdq/HfVY?=
 =?us-ascii?Q?IPJErIjCST4dU63XXxi+gI9i89KacQlYHwkz4DRzQdYYgwTNqoVforLYyhOp?=
 =?us-ascii?Q?qkFrXX1CvV2BmBtc7sRZ+P0WtLSQAh63y7vRWkdIglmJlNztKK486G9N3QUw?=
 =?us-ascii?Q?Mwz4XXviV4X4Hx7ZvFRJH1Pqsn58h0B+V1nTP0i3hmQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 08:48:57.3967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fbb13c8-6133-46a8-7f58-08d89ce86eaf
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNe+/H/moCoy9eVK7AYQLJsk5j4TV0c2YoxCSO0ZK6ErIMZPV6tHWrD6XGpRQtkoEwvO2tVFPpD4Cf4hBpDazj0/U968LXgXUdBB0FrZkyA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5635
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Franck LENORMAND <franck.lenormand@nxp.com>

This patch adds the documentation for the security violation
driver using the SCU on imx8x and imx8q.

Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
---
 .../bindings/arm/freescale/fsl,imx-sc-secvio.yaml  | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml
new file mode 100644
index 0000000..8037395
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,imx-sc-secvio.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,imx-sc-secvio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX Security Violation driver
+
+maintainers:
+  - Franck LENORMAND <franck.lenormand@nxp.com>
+
+description: |
+  Receive security violation from the SNVS via the SCU firmware. Allow to
+  register notifier for additional processing
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx-sc-secvio
+  nvmem:
+    $ref: http://devicetree.org/schemas/nvmem/nvmem-consumer.yaml
+    description:
+      Phandle to the nvmem provider.
+
+required:
+  - compatible
+  - nvmem
+
+examples:
+  - |
+    sc_secvio: sc-secvio
+        compatible = "fsl,imx-sc-secvio";
+        nvmem = <&ocotp>
+    };
-- 
2.7.4

