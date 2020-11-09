Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F22AB325
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgKIJHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:07:43 -0500
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:12097
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729769AbgKIJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:07:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mdsqx+9+GyJ/H4kQwtGRcRD+BrFyATpfhgzxm5LnZjc51RVVdn0B4x32fdW0gfJSfNkbJAofATt5Dyl9ApRYoMzxkpyqALkJbtpYjlYQqya0mbdEXls0xMhTMxY55zwiFHdwujUnRE1Tv7FYqJ1q0dorQQwcLVXNoLskmI3TiVRD9gDqQ5hJCgD2xY6YT5EWBBgXmMLa9zN1TW6JlXcTx3/veAd/I8nlR6X1e0ZrJLPSAw7vz+qYBNQ+fWJX4tFfg4Z9rjxKdFdlD6HdUG0aE7Otq9iY/pLqxEkrtrbgPh2JVGeL7oogExU/eqX8/gZxqShxk7r6bwi3SNAIVg0G9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeK0z9wCaZW6PCOLNSeuvjwFW0NKhoZIknqut1qA7yY=;
 b=EaKzcsKUiM5buJSVUXXxkY69YAaH3H1Rt1vCE3c8vbMMhGPeYaby8H/VKsk/bFk015pIjMX3dCoWH9F5+Ze+Jc2tuyE/B+z4JD5MZIBX+jYmesMndpGJj2jlXdvJ3jpqqfM2M9L4de1U+8bSNTc1y0nhm2pbZieHdpOY8rCFc6PsbeFNalvomPcqE8uX+HnzROOb17Fo+yirHJ933qmVS2SBeDsEkzA1Y8R6jaKTImuchx2n7No4SzbmNDjpIGUQFvSPf6ZKXl/a88L7LOMxlj38308n7FGpkLuykmRwPiRmqM0a6uIKZjaKvddL9lE9p/Zgt3xA56HNWhz/YlMOKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BeK0z9wCaZW6PCOLNSeuvjwFW0NKhoZIknqut1qA7yY=;
 b=aSGPQPV51RAdNzM32RcwwfrC1xGIeTi22ZgiPc+cPnqJ45wz76F+kGBEDf5yqnKlHPggMG+dDk8u26lCA7Xdcog3iKbReQ8zY0uLcxf927CKQnBFicjuM1DGLrhbn/KBBRZ00yYHXby31xlow6qAI4eHWLVYxwIpnyXxsfgUauQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5497.namprd03.prod.outlook.com (2603:10b6:806:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 09:07:40 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:07:40 +0000
Date:   Mon, 9 Nov 2020 17:04:31 +0800
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
Subject: [PATCH 3/8] arm64: dts: bitmain: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201109170431.5687732e@xhacker.debian>
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
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 09:07:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 710c79e4-ded2-4c3f-dd68-08d8848ee8e6
X-MS-TrafficTypeDiagnostic: SA0PR03MB5497:
X-Microsoft-Antispam-PRVS: <SA0PR03MB5497F4360F825190B0C4E44FEDEA0@SA0PR03MB5497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/V4196Us5Bpt2XLgt5CeUdUYTRAIfX07lXoJUL7BipGGbuEO9uS5egyZsL7zQgq+MTRYUEjn5iEANvg8JxJ0RZkKByzh66A104otmQoXtyG9TTnOnmAaSaDtAa3/w037bJVz8dTkpl5IyzyVqWGtpYMqHxo77fsYWAN+a7P793TdsNHIwFsUvs8U/5zTuYOAHYpt7DM8xCsk5V9b79kdJ/6BKdxWVyeiWr1kUwbWmsO2TZuzxSa7Hlo2ClRpkYoik5xczl0Q6feTW1SUHoU8XAVilPRFjGmL/SnfqCH5x2NHxIrdHPnZ6mSaJzXTlwz/3IPO9TRdTeneHxvrFfIN2zf7XSf3HVZYOKhv1/hXwHWjfyvzXjhTZD8ONcXU95+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(9686003)(54906003)(66946007)(52116002)(8676002)(8936002)(66556008)(55016002)(110136005)(66476007)(26005)(7416002)(4326008)(2906002)(7696005)(186003)(478600001)(316002)(1076003)(86362001)(5660300002)(6506007)(83380400001)(956004)(16526019)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: F1SLcoabP9kKYqraB6fTTPCxK1CmQ/omK0pYVQJWH6fYD3BR0cTM5iVnxDCvdA9E5tRqlwUIk98FKWeqlc4/Icji2VnZUjhLctC1LIsrV6jj43uzKd/13lmlV1dtwnQfvybEVTch6qCRhXoaqbaDKyaXd8oxcSR9mTAnZksvlgFE3FTUD35V09rc3EAsjpPMZKU8yGpgF+47WL869nKN/BgOAo01aUWR24p96bW0jzhFR6TJe0FkEnrZdiLPE6gGVo0UDMLTOOfKkkH1+69ePbL8DRJWvRYDOd3TuMEyXa8stpVu6T02oVS9d9kDTIq0ElzcIcDIXRfWygreL4c+16Mi+G8GOtJOc6VfPe/FubIYv8uh37vI69TezI4d+lMLpGm8KV3N7uCcgE+RV4tkJQSZINT+qstXHMFFNTFe6Gx01G1ZL5evuP8Fn0e2ui8OafAuMprXe890ysZE8fVPAcKsvFJGtHtwEOkp/w6AzKkkzZYLuUYy7b8kTfQXdfCoZNCkglpfHEU2p2v/OJMN894fSaDq9xwdDF7bikE/W0P+am/AlovspaPZNGXoZG8C66Z1+s29tkgiFwyt9i6fu/Tli1NfHpTW/WUpbVZEVOSuoum438bH8q5G63zic5hEoPKKZM3Ix9UJAMnnsqKt3A==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710c79e4-ded2-4c3f-dd68-08d8848ee8e6
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:07:40.1841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9bVzio/WNY3Dfzyq/Mxu73QP5ut60LMU5+MsMOqYXjW4b5JIq+mOt5rCe6juNJvbVNNtAtz4oFeA+NHJVoKtA==
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
 arch/arm64/boot/dts/bitmain/bm1880.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/bitmain/bm1880.dtsi b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
index fa6e6905f588..53a9b76057aa 100644
--- a/arch/arm64/boot/dts/bitmain/bm1880.dtsi
+++ b/arch/arm64/boot/dts/bitmain/bm1880.dtsi
@@ -127,7 +127,7 @@ porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
+				ngpios = <32>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -145,7 +145,7 @@ portb: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
+				ngpios = <32>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -163,7 +163,7 @@ portc: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <8>;
+				ngpios = <8>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-- 
2.29.2

