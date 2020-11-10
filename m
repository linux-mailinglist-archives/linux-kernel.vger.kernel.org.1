Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52052AD85C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732181AbgKJOMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:12:49 -0500
Received: from mail-eopbgr30044.outbound.protection.outlook.com ([40.107.3.44]:52782
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732036AbgKJOMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:12:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJ0Y5990guV6OT4e9eY+5sCS9SyayzajRE6n/Jh3F/MVPJSjiIs+IjMW4XWjC2k+XGri/5nWgxVifv2vniG1kziBIUpk5tYcv9M0kHFaa/7kfrdWqcSZ6zbV9mobkZuVRpMyBWzHhvW5ZXfkoYSwN3f1qqExlpRjn4eo+QwkU4/wdyoTPgPIVIjL4aBkxEQp8Sitxe1fgWTDOeov0nuIpAHHgVw3/Ib1NmeQJeQ+bPKs8kiCNGozZ7jyMPvQijaLV1bi0KkTQ7rkZvksXRO0MhJU/uvEwDdli6pEzBb49EIWNL7MNDEeAYxx/4DwthkhYcjSeeu/SNDGPnamNUF3Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKh9XZkW9Bg/RRnRMswGzrN/E4oIRi4kmVGjHlBc89c=;
 b=Q4srz9j2WG0SWzlJfsJRgjEcGl3/0cOZ5xTo9xlLDL1fqZEpfmI5F6GUMOvlbwkR7fqkrIQWl9C1TSN5nZ/GMuXLBnzpcvMusnexACmH1tAqpfv8PPC8H5Lg3V0S3dcb6CqoQAgkXk+5NtBmlbfCC+MYwDNrzrut5pWf+jKaPISN1RVRZn3B9+da5yE+7G+IU7V/i5wtiEnNcKz7yJNkVRwY2zMjlk1H6ELhnbQ3lUZr/OCj39QQoVVIsLP7ozhin8s0EAiKSihCp5zMOtoJEDPHZYRoU4rDbtezVEu3m+k+fd4qpejnLQM8OtIi5su6N3EvkfqVDluJOSJLmkWnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKh9XZkW9Bg/RRnRMswGzrN/E4oIRi4kmVGjHlBc89c=;
 b=EMSSmfxAicP1eHuMYg53M2ChtgGfetMcead5+AqBnQdLeiAbUyyH+5pxyojzFJrSg0+RaUBUMxCIzSPUnh0Kfues+5aazmm+vg6pXBAJyf1vRSjTJAqJw9HtJrGxzCPCAIJj9Vk3bSOjvWTr6rHSGqrkH4vY8DkZsp8n6lYkYaI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB4931.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 10 Nov
 2020 14:12:35 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::fd3f:1280:bcea:2ab5%8]) with mapi id 15.20.3541.025; Tue, 10 Nov 2020
 14:12:35 +0000
From:   franck.lenormand@oss.nxp.com
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com
Cc:     franck.lenormand@oss.nxp.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, aisheng.dong@nxp.com, abel.vesa@nxp.com,
        Anson.Huang@nxp.com, linux@rempel-privat.de,
        leonard.crestez@nxp.com, daniel.baluta@nxp.com,
        qiangqing.zhang@nxp.com, peng.fan@nxp.com
Subject: [PATCH V3 4/5] dt-bindings: arm: imx: Documentation of the SC secvio driver
Date:   Tue, 10 Nov 2020 15:12:13 +0100
Message-Id: <1605017534-87305-5-git-send-email-franck.lenormand@oss.nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605017534-87305-1-git-send-email-franck.lenormand@oss.nxp.com>
References: <1605017534-87305-1-git-send-email-franck.lenormand@oss.nxp.com>
Content-Type: text/plain
X-Originating-IP: [81.1.10.98]
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SOPDPUATS05.ea.freescale.net (81.1.10.98) by AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend Transport; Tue, 10 Nov 2020 14:12:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9950bac7-ce4c-4bc8-690c-08d88582a571
X-MS-TrafficTypeDiagnostic: AM0PR04MB4931:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB4931B36D8B226B49ECE484A8D3E90@AM0PR04MB4931.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +NhjLC1JrEUxvdHzZ83KJCANFfCZPdynLKvaknmZivaEp/9fcMgl1vd6HEK+X/JnTESZ4Ny/gQuCj/Nl0qKZ1vUB1w7t3zK1yeGhUi0GrhSGA50uRlbZu5S5vTqPN27YaCLrlEQ4H48E8ng0u9s61cbwDYVxKNtzUz9seEzYnainHhAj+1PrlCDFr/FEmkiuVlZe5IPKljJwOBvECIQ4don0OX10s0zqi8a4T3UeRfs8Cc7T9qummQT/Nx015EUoOANPCcjphdTaX/BEuv/+HtkNsgyLkZsYTb8YSCe/VvaiLWme351Sox+Cd2/wv4XQG+SeW6aPyUZjW1YINeheclnDnNiUTqmGRb/zAsmWXEPvsd3FkbGrHTqWVTYYRhAtUbDSpeFlG2zSUk7hoBRpzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(2906002)(2616005)(16526019)(8676002)(9686003)(186003)(66556008)(66946007)(5660300002)(966005)(6486002)(6506007)(52116002)(26005)(956004)(6666004)(83380400001)(6512007)(86362001)(66476007)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YiL98jjy8oQ5DUV0qZoVwU3oniE2+cznVsVvMuclf2gXbiiKR8OzqlqBZRpyUsOUDHMoG30KBfZDo4Xcb3opk88Rvp40qytPt76q1lceCDaL36Y4GxqLAraf+/lR2sJqqkZbZcavCjqs6KFLPini+q3AWu23GpBK/csJzdfvijzpJ2PZoUbCsLnPrThs9HPUbNaM0+BfhkV97p1fINWARg/ERmX5/32R8D85KHt40BvIACxKHZwL2xEimvc5vUfZm4gN2Sp9gHGwc8/IBcHtI1iTig6NXkxX7LLXU8cLrAW9gs8cERCumKmhpzNFpwA3h1OX+X2/aAipnbKGPNCxOjOKYIbkfRDfNTF9cpOOfNQr8eSU6UL148ZafwzMh45RnAn5wwkic0naMOL+MMNy+OXgM/rkdB1S4XVoH8u46FzRCCHYMD9h8M4ot6+tyNPYLuI+4oaK9emDkytqob00ZLv/fjlfE0j2e/JoIiT3TlkIhHE5l1A2WD7kPsbKpBBCdRhLfO5sPlGrGi4u3evjxnOnleDYA4gDMvGQvsGzQnyzPm2o/QD/28Mfk48aDXSfoJcdP8LbuzUUMbyqWxFLYPW9QIjSiq6ZlQslQ3zTz9kjwrOMZerMVtBIgrQr0+s7
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9950bac7-ce4c-4bc8-690c-08d88582a571
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 14:12:24.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpCrQu40L0yG8Ub+GtQWCR8NuNd6UE9GrexVCC+w1CeIVawD8zms9UIcO7CYxtMn/7A5D5Xt4DjHAdZMtnVeBeo0geExaZO79alKu8ACsn4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4931
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

