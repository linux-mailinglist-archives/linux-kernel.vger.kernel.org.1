Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7DB2C1B23
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 03:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbgKXCA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 21:00:28 -0500
Received: from mail-eopbgr70084.outbound.protection.outlook.com ([40.107.7.84]:15847
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727085AbgKXCA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 21:00:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0l02CfD4JAwnG4K9ydKwHH+ZWhbVuttHEf9CAT1iYICxKVZd6s+9tf95975Jv5Y75uQlXh56BSWwVaL1wOeWEjQCjsCsvvOkLdTVQp2FOorhDH4EJ/5yVfVRh8HoX9wAKpwNgC5xqfRRICUmMBvZxLv1m6qxAuYvr4UOWN1GmbsYhGbSwJG0KNU+DtrpqhVwpgn2Nj/ijSrmzp8xQIy09SN3reCWmAGiAyH7J0na5BGuRAHdnZa2waeNVWf+aXPk52UFBMTh1DEo4Zd7+0Fhtijwm/ltfH+xPFpOtkGkJyQy+okJ0ZwBOeyqNzbQ5sS9YE3XwJCepTHQnYQQu4ycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egt9ps5zJYj69R/JhIJ1+pNjwTYTSQ8Gsv9w7u92muw=;
 b=aBYtlCg0s/7/z5BfDMELrnLgbEOKKvm6jMiDegqZlhlrappb/lpdkLDmn5rElnAUykEBXM6pVUHI+g5ibkk5AjN3cg8WQLYdHm0OPoGv7z1vYQ6l9zLD8yrV/m2tJYspRsWU3/bXmVBug2AlR2nBkAptp8HBAJs1P8hq32b3zBPgeyobMbHP7vrpjqdi4tgJcOhj5TwidLHgCHAts6qk3VRM+rbv09vGwjLtFkZ1968cfXbKTq/NGpW/a6XXIu1HF1sr3ZfiwW/4e5TIkxeGMLmhuupV1FmuhRilp1QrsKT4tGJgWVlibPIG++nwlSHNB2XvX0cvHVPlOU5coKf/Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egt9ps5zJYj69R/JhIJ1+pNjwTYTSQ8Gsv9w7u92muw=;
 b=VSjh19U00k8fQa2dS1qs2y0SL5gS4IJ2tX6NZz6FmdLnDt8p7y7LcV6892Qyyk1WAsFaNtcrk+o0fs9qp2P3liS2YpWYtUXLyzwNGXjelJXiljhN6YHtM6385iiEBDpd2ZnvZgNTB2e7Yr9k/jGOkmPSTOlmblCZ1JDIGxlokbk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7096.eurprd04.prod.outlook.com (2603:10a6:20b:113::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 02:00:21 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3589.030; Tue, 24 Nov 2020
 02:00:21 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 3/4] arm64: dts: imx8m: add NVMEM provider and consumer to read soc unique ID
Date:   Tue, 24 Nov 2020 09:59:48 +0800
Message-Id: <20201124015949.29262-3-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124015949.29262-1-alice.guo@nxp.com>
References: <20201124015949.29262-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by SG2PR04CA0188.apcprd04.prod.outlook.com (2603:1096:4:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 02:00:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64668bf6-a04b-446c-f409-08d8901cb30e
X-MS-TrafficTypeDiagnostic: AM7PR04MB7096:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB70961FE8D931FF66F99B23F5E2FB0@AM7PR04MB7096.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MkS6SNejLspIC1wWcPHPLCu9q1CK/u+AhXlkSQP+BsIlpgDXwHkGeXOkIq1nJl5m0u4BR8B5U72leP7JuOQrIY7F0kjbYhgJOO6CnQ3xpnL7321L1HtZR5HeSD5XcAbmqtFA5hrtc2frEwj6Tu/dmVTsVw+qqGzbV+CW7/RWYX2OOUZnyr+pTOkYgfqBeUYQbsOlUf162XIgxZmUzTG4+l65+0V+S2+1Z2tT/+KVfataU8NuW5L00Ep6apMGWRiTNQwvhnEJXzU3tEekZ+tdHlSyPl0EYqJO8JifX7WeDitxgWWSSTrNgm8aRTNvrcy6YflyXTV/9EDxYIwY2y073NQZZQw6ccaaLhDzXF25Oaqxh7WDUzI4pYaOo4+X+HVt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(956004)(478600001)(36756003)(2616005)(6512007)(8936002)(44832011)(4326008)(316002)(6486002)(26005)(8676002)(52116002)(2906002)(6506007)(16526019)(186003)(66476007)(66556008)(6666004)(66946007)(83380400001)(1076003)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: P0unwneWcSB7Y1A3WFydS36YThYLS9LTd14UXELauaolko43u8A1yNmtq+Idl88hFZQnQ6o1YURRvWiPtLWakZOiH6KU/OIPPhFIoOFFeCWUPtZEQrtLTM8EoyQq4mXGs5evTi+YqOtK/9SjQa66R16F3FfkgbIDpyp1ErY0aWf38rKUsu5xsZTVB8bJNbmtfpkbjzK/YkGkBGN1FylM9vrHSDgslc3UBhlcW7/Go4S6pGGjffJ/qS+d2XAgiMnUHQxUnSXy+/gWTkei0nlXa7aZTCux5FJWYMPOG3qa08THyNc3ItYSy3ywQ89sddSD3ASxuKERwmekVjZcjwHjNQWu9Rj+3ikX0KgNsSV+5LuTiufyL8HYDafaL/Gz6gSlrU8+vT7LJReuqb5ralDsup/DypNoDmGE3LD+JXiSB3Tz8FQj1/+cFugtZ3duxOkkpCWbLv+KWYiiAgrp+oTjwlrngld3CU1ruVuIQOoRWr8MRhUe4N8ZktnRUBMY4rUdPA9otGPhsOgakn/uX9ZkPkPjRg+gVx4ycW/7loY96/5HG+vxb1hEJW3MB3sHJlR7OLUY8Qca3bRM0FqOt82BA+RPoydVR2zKhSruYDySBpc88PFtutp2Q/XMkx7T5E/qjRyPYZjLd8TxPALnffXsgNudkd42e7fT1buZEd3Dm1jI8Z4CiigzYQQRXk8FitHN9MjxdvkPaUbDV1VYDZt1GqGGfGj5d1Kab3h8atwW3u/QVSA3dpX42qKE76UkuCpUlW4giiEYMD1AHWmCejPE2GogEI/3yRLjpls0D3okhL0z56h3LCxRY5Cvtl6kNYwCgWqRCvq7nFImqBDsKNg+IzVs3TDkVNkQjBFbu38hBB8NUQmICMPkY5+/1UhzXAkelqtGRIXizgFIzmlLaOM++A==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64668bf6-a04b-446c-f409-08d8901cb30e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 02:00:21.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/m9b/vtitOI/AMZmQwdIOUypMaZLbbUuSkUAqmV5L65pAgNJ9HinMcOxHFiZnmBgWZdOdPFv9cQt6BtyA+TSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to use NVMEM APIs to read soc unique ID, add the
nvmem data cell and name for nvmem-cells to the "soc" node, and add a
nvmem node which provides soc unique ID to efuse@30350000.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---

v2: remove the subject prefix "LF-2571-3"
v3: convert register addresses and sizes to hex
v4: delete "stuff" in subject and commit message, add detailed
    description
v5: change underscore of device node to hyphen
v6: none

 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index d457ce815e68..9bee6f1889a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -261,6 +261,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
+		nvmem-cells = <&imx8mm_uid>;
+		nvmem-cell-names = "soc_unique_id";

 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -518,6 +520,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mm_uid: unique-id@410 {
+					reg = <0x4 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 6d3a809a00fd..2edfde1119b8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -245,6 +245,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
+		nvmem-cells = <&imx8mn_uid>;
+		nvmem-cell-names = "soc_unique_id";

 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -388,6 +390,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mn_uid: unique-id@410 {
+					reg = <0x4 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index ec6ac523ecfc..9401e92f1c84 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -222,6 +222,8 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
+		nvmem-cells = <&imx8mp_uid>;
+		nvmem-cell-names = "soc_unique_id";

 		aips1: bus@30000000 {
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -328,6 +330,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mp_uid: unique-id@420 {
+					reg = <0x8 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9b6d9307e5d7..a2a885f1a07a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -291,6 +291,8 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x0 0x3e000000>;
 		dma-ranges = <0x40000000 0x0 0x40000000 0xc0000000>;
+		nvmem-cells = <&imx8mq_uid>;
+		nvmem-cell-names = "soc_unique_id";

 		bus@30000000 { /* AIPS1 */
 			compatible = "fsl,aips-bus", "simple-bus";
@@ -555,6 +557,10 @@
 				#address-cells = <1>;
 				#size-cells = <1>;

+				imx8mq_uid: soc-uid@410 {
+					reg = <0x4 0x8>;
+				};
+
 				cpu_speed_grade: speed-grade@10 {
 					reg = <0x10 4>;
 				};
--
2.17.1

