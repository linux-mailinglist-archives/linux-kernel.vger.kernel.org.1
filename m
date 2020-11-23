Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2895E2C028E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgKWJvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:51:49 -0500
Received: from mail-eopbgr130085.outbound.protection.outlook.com ([40.107.13.85]:60037
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728108AbgKWJvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:51:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JVYHwTx+jgjekJnKu0Lk4dx80mGmkSlT9y+hPW13pvYSUocCvSNVYY7ltvhUY1WbUziRlEiKR0jdZVHKPjwfxtcIIZBvmfku520rzBI8mKHtXSwy21qQYhM9oywPvz/ZkSY1cQKPZPh7UaNqsM0qjGt0eqE8BnM2ORZbzSN+UU/FZ49OdYdwILlLlgJ4n1HqVmlsMGZ+Mo/3jFx1Ia3Dp4g7+q6ETk2JPOitNy1gIHdjyUrqstrq9BPRTgwgp4zysuqHg2NbGqqvlQYWhHnVNAMsOUrH0S1n3ic3k8snUJ6ns7GFK79jvL2NeECbrap8rHEGm/uItPuNe58CkXlSeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEy5Gooqm2QWHc7HHETCddUNTPucrDPyRbq8lkWBDO8=;
 b=X2zG2LGcuns2X9duY4AbX0tiDdrJhI6npgfQWmvswE5UsoWJTr6XG7h+VyCwaY92/jW/DGsiOpifNzZvxpON6EiGf00992jxeYK8O0KOwGlpqZHv9NQwo0kos+X8UnwoluKXi/4CaQGJ0VSDQs+nMp6XRE9hwaz1wHcWgz1RGNvwLWpbxabzLr6zandDwsHAKSGOVvBry5HkydwSGenIkdCtX9tQ2trq6ZGoYQtL/vVdXf9lJYHlX6DdPjsLvBP7rzFoOpc+HyvG6ISvMK8TEG1z9LlGZo4N5+IsDlKXOkaKDpayzunj/hommpfBPjsIkmXMZbQJW06q3t9OXsf36Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fEy5Gooqm2QWHc7HHETCddUNTPucrDPyRbq8lkWBDO8=;
 b=dgSZOskTV3DY7Vj92BPrt54MSDVg21ZHAr7BokEALEdioPXXSBR+a4kxjJnizbzQaBc+Vw45psMZe5KDlON4W9CzAZpW2KzOwE4rD69VDMZS7QQCVcWXzHPhdKW+DlT8nHgUbCbSbzLQL7CJo93zFYutnNHBH2XoShkcJbGoXqk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM7PR04MB7048.eurprd04.prod.outlook.com (2603:10a6:20b:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Mon, 23 Nov
 2020 09:51:45 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::78fe:9b7a:a2ac:9631%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 09:51:45 +0000
From:   Alice Guo <alice.guo@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        krzk@kernel.org
Cc:     linux-imx@nxp.com, peng.fan@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 3/4] arm64: dts: imx8m: add NVMEM provider and consumer to read soc unique ID
Date:   Mon, 23 Nov 2020 17:51:07 +0800
Message-Id: <20201123095108.19724-3-alice.guo@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201123095108.19724-1-alice.guo@nxp.com>
References: <20201123095108.19724-1-alice.guo@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.71]
X-ClientProxiedBy: AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::41) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxf55104-OptiPlex-7060.ap.freescale.net (119.31.174.71) by AM0PR10CA0088.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 09:51:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d4ae426-2068-41f9-6d9a-08d88f956309
X-MS-TrafficTypeDiagnostic: AM7PR04MB7048:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB7048827D8C4C47EE01202613E2FC0@AM7PR04MB7048.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kpNWn9JfhsIJqvAr5IH3ZXMNaxOK7ea2H2gJdynuuAiY5yxKrLnf61WNLOUxTUl7rP3dXls6K/l/1Qw7NPLqixC14zyGfNyZB7NpB7QgFwCOOe6rZQfmdglarMJ86YK8qnzTmxfeEskuITtROGfaO445xAyu5Sjg569XI7FmYBUQLjNLEoQQOKg4+RbyVyWzsG8SKeuM3FyfHhyLJbSLYzjvr9FtNJvOGRkc+xiHS48PD8Z9Va1i9YIVhrzAfrWV8ZC4eodY74/L0ByyWp4U/ZnDOK9Zm69BnNXiF40VBedEcb4Pl+/Lc28RcNft3duFwDWrquuVwZFdCMibKItdOz7/gUn+L9gPy/HFn0KW6SM4czbPV92wcddqwihGwWu9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(2616005)(478600001)(6666004)(4326008)(52116002)(8936002)(8676002)(6486002)(316002)(2906002)(6506007)(6512007)(36756003)(186003)(16526019)(26005)(44832011)(66946007)(66556008)(956004)(83380400001)(66476007)(1076003)(86362001)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7pSxvbVivAQ4ErfVzRiBAtMOqFMetjEkZn+DdCp1CB1KGQkUE0LKxo81D+O1dYKoiGL34r6hSz9HKWvtiY64hP9lN1ZeBQhf7WGdWJY3OYhomGcNnBS6AI+ABfOgt07jLIBktiCoIUmA/S36kz5WYccJCEW5TGN8SfzA4Ikd68RvCzW51VH1OKE7eZBI+AkFDllK/Arz8PSyOAlcJyS7ryd2yRMYzi2oKhwSdRmbNLh22QxXNz0COfIqYt7dvDVBPWn588JZ3yetbYiWatqK7F0GM4SCeMVjzqFYYl5FdXZB1Blu/6KigoQwzlqyalgA0/00dGOqLwpwxRoUxvfVUy6NeVwlhv/Oygl1IWX7Wetg72pCxRFobPeoiywbW2Tnh6wLRl3wZs8FomSEIXC6va1XNGU69xFK5PDz2dW7426MZiss9Jq8UitBBln3y8/yij+OVWXRaDatiOr2vTulnOJrXkpodf5qBaMzIGXLgF6d6GyAEw/V8T2QlOz9x3NVuLaWcdszdFQc4tDu5I8eVtT/1U3BvatxT4HFhfyCw87LEIiuCNcypKCzZo3czD8pJKgjIGnGsWbPmpHBw81vfU6LGx81+hXeYwQ30rmxV7xy6MPnVlRwOLylnhKd6Lr0S8JhY78PJuhKXE0ggGmxtzjsfQtOn3EqrDP7ekq5gNKFtNYkqvxOXkpxsQOwkBNYQjeNflwj3etMKQtpH3dfqCj2DNLLjmHVs/nxj3x+lk9MJrz8Z81+YxvujkI8i1tLApA8gjN/2vzgmvqvcIRZA5TchXPZNgZpPJuKinc/dQhlf7Rig5GxAEzkHvwXnB1lFdZjF8x0N+06Qt9Q8vMmJNThoyOVHR1fd/rfgitWEPr3KxFTh44RtSh+gRk/WoB1SVuvhydrJATO8rUWd7E8EA==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4ae426-2068-41f9-6d9a-08d88f956309
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 09:51:45.2213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TKIaEnPPy6NaNG1MAPN4OqoUTdVZbEskKmhGWQeyIJDGkRcXhcJENLogXTZ0kr81dZ65/tGecRhaXm/oj6XrJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7048
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

