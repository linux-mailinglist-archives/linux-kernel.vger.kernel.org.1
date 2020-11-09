Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7098C2AB334
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgKIJIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:08:32 -0500
Received: from mail-bn8nam12on2060.outbound.protection.outlook.com ([40.107.237.60]:4833
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729903AbgKIJIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:08:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBeYOKAbIjGwziCZurZRdm/ycLPozFtXv3HRUIjwBLrebtqwwH06kM3UIhZzqA32nmM10sLb58Cp04XCVgN1auIqXlyeerf9yBnrw30bG4xxprTg6RD1SUrEbW7cFZkn5/jt88eUrt4qgByUVJHctAa4sSuTcptwLvwumB3kg34LWz2xs7dIHlWZsyO14EgahHKLF/lDx2yobQLOLeUh5bjwHO0/8ShDaPM3sbciz3V+VJuubijvvNFlr4MNJh3ngk9ElkFklEo6FmoNQmtFNAnCZ4w7sEGi8JUQPw/nC/rRnZ19tUpP1U4sC745T90oDZU6qoYaaNMMrZlOHwbytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvhr3/CTYYKFnN5lIxwyoMUGNlXTBZ3+8puAbIgQTUU=;
 b=Q5X2/jyZmvPpq9qTsFNQs1GEI4GXHtS8uX4Qo9FqIDPC6NPfKuQBC1783PTD4eJEIsdAEbcuUTdK7mw8U5+gLdh4HCUkjKweQ5OnPijPO8gXdS73+IabfsqYlctK/Ri+gjEmgyW4Lztgbzypng8eVWLIeY2Vaj12Ndo2jqi9CiFFIMEjx5ZWlZzQakk6rl42Mz77bXe75NVTE3I1YmftU7oMZ1BepTJJXHIl80FsRs4uBmdljhZcMjLG8oKg45I5H9LqpvqlbDtisUzGpkSfHAUzuGWIWtfbnc/980ZxfNU/pqDRgN4L8fY64GJAddfmF0kFbsce0MMkTNCBFzXspg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvhr3/CTYYKFnN5lIxwyoMUGNlXTBZ3+8puAbIgQTUU=;
 b=VDznTe0AJa9Bkf4wR1losAWy500CtEch3QH7YihcQ6HxnuwBkunvQ+OCbLg4sKhveAXDJuTad5P6inmsbx89eTq/RC8yjYSj5T9JNv4ogaBgVUFAoxd4CaRgoZjUgIULjlQfFJtLIGgcxiW1x58m1ClAaj766qca+yegqIwAK4E=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5497.namprd03.prod.outlook.com (2603:10b6:806:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 09:08:28 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:08:28 +0000
Date:   Mon, 9 Nov 2020 17:06:47 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Saravana Kannan <saravanak@google.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 7/8] ARM: dts: berlin: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201109170647.538ad459@xhacker.debian>
In-Reply-To: <20201109170258.4a70c768@xhacker.debian>
References: <20201109170258.4a70c768@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::34) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 09:08:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84120893-a024-4923-9bc0-08d8848f05f1
X-MS-TrafficTypeDiagnostic: SA0PR03MB5497:
X-Microsoft-Antispam-PRVS: <SA0PR03MB5497FDB3CC47C3EF75F13518EDEA0@SA0PR03MB5497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xQOPfXUxsLsrvXz2kaW90TMOTg8dqvLMzJSaEyiCP2b0Rj7uk0euWsTk8wFt384a1a8WzuC/YMVOB2E8C7najojVkG39qF7sl0XRYWlSSR/0ubMLhQMynz+TqlpwmwqUDWeGyU7u3pdqLXCGoavQQmy4ZFbNN7220Iohv6QRLEBpRfe7uBVgTyRoUZpg9jJ89iowUjZiPub8e80l+hK8z44ujvoe+Wdw8ue45zEpLyqEs526O22jjpTB0cpvQIkYy1A6EXab2lu3kxMexF7jHBqPPdZuqmva4e18EP14hdFOpC/ezi+O8Bt6REcJsWVp+4eUEHUbc0XGbxDII700QxDfsgsIAxcS3PSk50cyaoNBaM+pmaP7P54vVMAoHCqZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(9686003)(54906003)(66946007)(52116002)(8676002)(8936002)(66556008)(55016002)(110136005)(66476007)(26005)(7416002)(4326008)(2906002)(7696005)(186003)(478600001)(316002)(1076003)(86362001)(5660300002)(6506007)(83380400001)(956004)(16526019)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vtsbQssxSouMOg4+ddQAQSQKTMiKDyhbbVEa0iHBk5hRUvU5u+QggPoDC3TZoMgAMfyC+xKKL1VoHqqQ1m8wlsfj9VNAIGzXydA5OmoKa9ASDOa4Xf5CAR5WKkR8uQxSgpw92BxwrdU7Fd2jPLAUL2t0RWQUBK//z+tqoGimjthO4kEu6CSaazuMh8RWA314DmvSKTTGK+z2PXEmwlvqSXM4eMhyZle2tMt7x7g+Miw8664aSaEd9mljU98t4oKkB1Bxgm+U8RXIJA8/hwCjs9IiZDhPFkmTnNLQjp3XMWbjyLY5S4yO1vOd/+unqoDgOEj6mFUWhVWmqH135sBiZQ4q33VBTMZ+LEsAsEFB4Dxi6hBqr5hvUrJzXESlgiIh1K8H6/xR3bTYVce3LpwRWFf1/c1Mvww0yRMRpkcgeSZVzOKkC66pHA4dqPKJUvoQHo2HQk33mYs5k7HtfvO06oxMBgOYl7kdgTYbsQi4xrM8kWksLncVoxr09UVGsisgC4vgMzIR2SOKpL1esvT8RSOS8c5gJgAKrBudosgvgSN1IXYFW7HBx52vAHfzat/BL19bWjMOjQsGyRdyqvAis6xWBNk39zl91Wq1HghDaWEXtlRHulOxq7s7GpJZTlde4rRoOx9c81BSD13JvWWtvQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84120893-a024-4923-9bc0-08d8848f05f1
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:08:28.8864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9i2rTLfgigpqRHwKzjhs9KmkNKNnGdK8re7GkVabkmV9Qg0Dqd6E/gvoXiqhQHhlQ+LohVx4LX10yyOuJU14g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5497
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to remove similar errors as below:

OF: /.../gpio-port@0: could not find phandle

Commit 7569486d79ae ("gpio: dwapb: Add ngpios DT-property support")
explained the reason of above errors well and added the generic
"ngpios" property, let's use it.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 arch/arm/boot/dts/berlin2.dtsi   | 12 ++++++------
 arch/arm/boot/dts/berlin2cd.dtsi | 12 ++++++------
 arch/arm/boot/dts/berlin2q.dtsi  | 12 ++++++------
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
index 6194857f8a02..1114c592e461 100644
--- a/arch/arm/boot/dts/berlin2.dtsi
+++ b/arch/arm/boot/dts/berlin2.dtsi
@@ -191,7 +191,7 @@ porta: gpio-port@0 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -209,7 +209,7 @@ portb: gpio-port@1 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -227,7 +227,7 @@ portc: gpio-port@2 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -245,7 +245,7 @@ portd: gpio-port@3 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -446,7 +446,7 @@ portf: gpio-port@5 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 				};
 			};
@@ -461,7 +461,7 @@ porte: gpio-port@4 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 6f30d7eb3b41..b2768f7a3185 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -181,7 +181,7 @@ porta: gpio-port@0 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -199,7 +199,7 @@ portb: gpio-port@1 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -217,7 +217,7 @@ portc: gpio-port@2 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -235,7 +235,7 @@ portd: gpio-port@3 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -473,7 +473,7 @@ portf: gpio-port@5 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 				};
 			};
@@ -518,7 +518,7 @@ porte: gpio-port@4 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <8>;
+					ngpios = <8>;
 					reg = <0>;
 				};
 			};
diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
index b6a0acac6836..598a46f96a82 100644
--- a/arch/arm/boot/dts/berlin2q.dtsi
+++ b/arch/arm/boot/dts/berlin2q.dtsi
@@ -252,7 +252,7 @@ porta: gpio-port@0 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -270,7 +270,7 @@ portb: gpio-port@1 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -288,7 +288,7 @@ portc: gpio-port@2 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -306,7 +306,7 @@ portd: gpio-port@3 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -552,7 +552,7 @@ portf: gpio-port@5 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 				};
 			};
@@ -613,7 +613,7 @@ porte: gpio-port@4 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 				};
 			};
-- 
2.29.2

