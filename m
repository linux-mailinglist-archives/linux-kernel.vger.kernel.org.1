Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53CD2AB327
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgKIJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:07:49 -0500
Received: from mail-bn8nam12on2071.outbound.protection.outlook.com ([40.107.237.71]:54618
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729769AbgKIJHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:07:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5LInsxn7FXr4JTANHHy67dFwdGIeEN/v8+MjfsJf/Kv/WEcN2YYeLD/UZtKKpMcqDDZlX9aUbjDt+kR5FmO0yNYpB+umSqapgFLKSnYEpCCPor5R/kBMHhqiVfxFisQ1PLCZk4YFWpyXEopafiVImo+K7UCJmVSBmagMGnmfVIdFqRGZlkftpxIFPbWbuK6hT4L/qK45WEKZjCHT316SVuS7lGLQKt8v8ONHUZpPIeY2pg9Y3HKvOwBifz5c1ux7DdU/GNSHIP8dlbvfxr5+lCHOB5Re1aoxWHZslZG5WZTznJXLyZgOBGVEUUVcYednGmDRjleSVf0Tj5jeJgyNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0BpXoWtb/H8C4EbeHEcOxKORMVJKCQPNnmvFxkPnjQ=;
 b=iXOQm7o2PFnOvmYeAgdOkGcy59i5Ep/Vj/pRUZHHGPOVrir88QMRLWg3rrVdi4m/nRH7kxoPeZTW8633njSr4dsFM4KlyVJOTuZ7+qXn6q9heE+rBSAX7p6wIvuGtHkqLDRXhjC8BFgm1jXQMPTQDApzz9kegBWS8m0aKnPAFtzLh39hzJ4JwBlNwRQlR6fXYjZH+eqftx/FzgMvD42mtg097+3WmbjauIOvXFwSxKH/g/tj8ZBQY2nSxjoMAHdL4sT8TeryThWMPjwMasyZzOR56TtAPeRoBF5vQy8J6b0jRZi/7Tu6bspSTtZYJe1LuwN9q9suTppJtFoJ3Zo6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0BpXoWtb/H8C4EbeHEcOxKORMVJKCQPNnmvFxkPnjQ=;
 b=lO5wQYWK8BRa4e8FuSS+WVaX7EXUduAVkGOP+eCkoBwPEJb9XaEdwTKFQlLa7TGfh1/zWr4IGKJgLbPd5fcYGCC/Yh3D4MhaTS7OIdulhbsc2YHUGj0hM3AVxAhZR/ASq8yqf3jinRtfr76Mh3O6y5YimKjZ+P097k+dmTXB3N8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5497.namprd03.prod.outlook.com (2603:10b6:806:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 09:07:46 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:07:46 +0000
Date:   Mon, 9 Nov 2020 17:06:22 +0800
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
Subject: [PATCH 6/8] arm64: dts: synaptics: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201109170622.29f7bfb6@xhacker.debian>
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
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 09:07:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a4fabfd-4f10-44db-2ffe-08d8848eec86
X-MS-TrafficTypeDiagnostic: SA0PR03MB5497:
X-Microsoft-Antispam-PRVS: <SA0PR03MB5497D029AECD6C8147010AF3EDEA0@SA0PR03MB5497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/mVFxCdLoTDdoTvoJfeKyhvF0RSqVB+CC7ESRrIbnz1H4FeJmqWfNh7u2cqTlFZkDBZnrvMPfB6o5YTABgeuHvzgF7poerE+RxAU83W9m4fwq1vmmCVw8AaBOQRK2//IFGhG1u6YblqQfGUe5Du6TD+vHWQ2s1s6z6WdS5ORDabvG8/DHSe+CMCeVhfoYi12YCdkcEvFZG4rhDT0+Xb2e3pJexbgsPK/Glk3scMI9GFsuTk/l9BL8mlycWsQWyt5NPUt9Bz/1sLukT5LZkqj+E69hT39Wy6z3jhgqHY/62UyebYdKH1aHCLrKe7HnWXBiawIEI/9fuplEqW2MpRvSVcOHWlvsjD+QhIZdG9ndFwQ8Vh8cKIZlQkL+ula1pk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(9686003)(54906003)(66946007)(52116002)(8676002)(8936002)(66556008)(55016002)(110136005)(66476007)(26005)(7416002)(4326008)(2906002)(7696005)(186003)(478600001)(316002)(1076003)(86362001)(5660300002)(6506007)(83380400001)(956004)(16526019)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vwwA/N71yidhy6Su4HtftrifgNxAjrePP2xCUAHQ02P3tPuBx7af86IKgl4wpeng1/luWM7ahgxbUQ3sifNrUQyI0+Z1Jh0RqOB+ShXbqNXeyW975JWeo77TN63NEZXM6F7Rn7KiJRUfQN+feg7zv2ENMtBEl/AQQ3JRtSmu1uZBFl8SuZbfoufZuTLMmJRWDc/sCGjjzyN0ynN1q5FhxVY1cLnOAQW5KX0qzVEJlVnKN+mPT9tcPCjYwj3N4Z5PcWZpGplGaar+N387Y9rK6XVW013WD1nKDin5S1hOvZ8v2g2LID0sAvPYmTU4dDPqyuNTEJxgg2TjD3lGOKVKM283JvW+plHjRz+flYqM4+8mOudkHzsDfYrNmJAcUtx7lLbSjWFnll06DyM7/8eluMFziA6VxJZ8ixBHCc7zMcXtpyP3e0x9bZTneyFrBKHRLZ1hmOXJlX01hlrclZFSzJfzNsEWpgI76PB0EpZh9cAgH2LHeIMAE2sel8CiqLt2wwk9bWWw/Us1GGCCtnXP2SpP7xZ5W9+EfKlF99ZOZ2BbdHwyB/FJ3essfqEdXeFk5SzFm8KN/mp0hhA5A9yZUP1/jX23dfVImJw/5jO+aTGvfRli5ejWSOuANSZFB3wbYEyCzPImufInnl9hE5lpPg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a4fabfd-4f10-44db-2ffe-08d8848eec86
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:07:46.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AfZoA6tMu7j8u8O/2EqC9y3Yrm3oyqtqY8zdIvpPdBjqdxxpgNHOTnjRRh90ElKGZUPaP+mSo9ii+HKBIPpC5A==
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
 arch/arm64/boot/dts/synaptics/as370.dtsi     |  4 ++--
 arch/arm64/boot/dts/synaptics/berlin4ct.dtsi | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/synaptics/as370.dtsi b/arch/arm64/boot/dts/synaptics/as370.dtsi
index addeb0efc616..4bb5d650df9c 100644
--- a/arch/arm64/boot/dts/synaptics/as370.dtsi
+++ b/arch/arm64/boot/dts/synaptics/as370.dtsi
@@ -143,7 +143,7 @@ porta: gpio-port@0 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -161,7 +161,7 @@ portb: gpio-port@1 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
diff --git a/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
index 15625b99e336..0949acee4728 100644
--- a/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
+++ b/arch/arm64/boot/dts/synaptics/berlin4ct.dtsi
@@ -140,7 +140,7 @@ porta: gpio-port@0 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -158,7 +158,7 @@ portb: gpio-port@1 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -176,7 +176,7 @@ portc: gpio-port@2 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -194,7 +194,7 @@ portd: gpio-port@3 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 					interrupt-controller;
 					#interrupt-cells = <2>;
@@ -269,7 +269,7 @@ porte: gpio-port@4 {
 					compatible = "snps,dw-apb-gpio-port";
 					gpio-controller;
 					#gpio-cells = <2>;
-					snps,nr-gpios = <32>;
+					ngpios = <32>;
 					reg = <0>;
 				};
 			};
@@ -284,7 +284,7 @@ portf: gpio-port@5 {
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

