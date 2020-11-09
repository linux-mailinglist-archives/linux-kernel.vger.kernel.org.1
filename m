Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B29F2AB331
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgKIJIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:08:23 -0500
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:22880
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726482AbgKIJIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:08:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0lGeJGl9+RZYJK7bUPJSjyuB9Iu/bkHjZmJonaTPNHLdmfEY/s3ymAdPs4dXNbcjpm2/bgFN8pwNuSykEFtNBgHH+GnCsIttirRHACdHhGpw7jExwkXJlaQIyz97NMeXBMuCZyHm5EkkWGWCOwJKil+zwaxHbvhISRTXyCNBY9hGNzFA5nk7W+2DDp65pNKtr9vKX/P5VoyRdfSb9lXO/MiPGaWx1P0yG9qNaFoc0NVwexxGVgR7PJvsTLJrEAHDf8uHKwx6E/KZMzXztybTOX2omIc65gK/eR/vxkinjqz+018oh+/ftV+wqLITo2UqjD2nZXnMHENhmxi5SuSoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP81t/vjxawhIHhMGHzmguhFNNxVMMr/ACDXTNrXsAo=;
 b=J5o4fuphe0KoQ3syhs8UGGeyc2BaAuVk0kkwRMfyVOUD9ksvMDBBieuCkFnXm0UDAZcA4j8vhlSlHlaFmFv+B8BORpo7FPKyO96t75vo5SDvLYqh5a1AGhpK/PoY6dlzBxinoU1WWTelRrpk9deb05iCHyfz1pxdm/G1c7i1QKOrAllvPH0LJx8kTseeAt6QBAINweko38Y/nean5yTvoemr5NXSId2Mz+MhmhTm6koQrUNJMJIRwoYyS57mYM374w7gmLu+p0C81E54IVE46WjgrRA7C4u6m3CTUOFzbY7dpcWnl/nImVSHlVJoPhiFgCHZhL8O3g9OZYKQL1hvAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP81t/vjxawhIHhMGHzmguhFNNxVMMr/ACDXTNrXsAo=;
 b=aCwii3c0tsmBFOrxZ/fdSJqsaV4hXEeKdp9YGmVEv+5ec8fKwWk0SzbWU1Gk1UdvAwCpVyjYOeEdsOmAtsr/Q1dZCtS/X2W8wD9+f1dxgN0i99EXSSZHsZc1f7UO8wmlmcA4lTEIhJ9KNm/M+TSeHL3/eFGEJgSTXeMmVGtNPSc=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SA0PR03MB5497.namprd03.prod.outlook.com (2603:10b6:806:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 9 Nov
 2020 09:08:20 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::49be:5ea3:8961:a22%6]) with mapi id 15.20.3541.024; Mon, 9 Nov 2020
 09:08:20 +0000
Date:   Mon, 9 Nov 2020 17:05:29 +0800
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
Subject: [PATCH 4/8] arm64: dts: hisilicon: Use generic "ngpios" rather than
 "snps,nr-gpios"
Message-ID: <20201109170529.2ee1f04e@xhacker.debian>
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
Received: from xhacker.debian (192.147.44.204) by BYAPR02CA0021.namprd02.prod.outlook.com (2603:10b6:a02:ee::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19 via Frontend Transport; Mon, 9 Nov 2020 09:08:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75e36e90-bf8c-483a-d088-08d8848f00e8
X-MS-TrafficTypeDiagnostic: SA0PR03MB5497:
X-Microsoft-Antispam-PRVS: <SA0PR03MB5497EF0D2D4F4658846BDDCCEDEA0@SA0PR03MB5497.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZbtDCRoRw8N8OFW8D+P1DPDbh4DWk7QkrFwa4yZy4hT+rHGjYds4z1PHg626l5k77NaAiGGOB9Lmng3RIK1hkZhbyf/zIwMseGc7s3+ZDRM6G6pp6Gs1oh+AisDewXb0vq542gOK33Nm59ObAEipa2qWJcedASAIGaMuyZABRpfCDROG1R7Jdsqth12c7iGUZvOIdt1oativO952fuxsy983pikefUuH6sc0KEijD2q9lpn6FfTdnPGdsWEwoPVkdMi12dB1C4+WHV0AMA7XVzPtUuI9modv3GvvdyW3qysiCxtwRHWkTdBY30iXSt952jwH8/jABLjT+6aHk/XRZRs4RNxZeeNbUW99vG9ldy+W4+WEJAzfQRC0d5vl3/lV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(366004)(9686003)(54906003)(66946007)(52116002)(8676002)(8936002)(66556008)(55016002)(110136005)(66476007)(26005)(7416002)(4326008)(2906002)(7696005)(186003)(478600001)(316002)(1076003)(86362001)(5660300002)(6506007)(83380400001)(956004)(16526019)(6666004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: qz+D9AoARnQVvuubOV0kfeAqYSpJ5ItMC/KEzrvr7A7tqPmFiG0oTWdQX4WPU75ASJ8tS3TgF5UXC5rc1KjMgmFRa78+ZzRELad6E/cBlal+GQRBI5THC5Sy6PGDLonrxLp6XqwAbJZPfZFWgEJ2AXcfBdQCzmOhTSZr7rCmGwSaG3tNZjUb9E5sGGnVBCktB+1dNELTUa2baN7OwGpP2uIVxDJAh+8+OhaQ+CkhrSPrVwAFHUex8hYuFkS6HLedEExuWxdtQyHoHGnqykJhSlXXp4SbDKbK2FbdX3ErRRjMwMiHZn8SNYbnrQIlVyOGfrOyfmS2sT2Oo1etLtKblHYV63HE1G1ilg+zZIjaiLBE6ypbPpkPMP6M6a2QxyoO2OyS/QZc7EEwZJtIQxjn+vXkkGlO77B0/5cah+bsIhDYWb1dxKu1XlMhiVIkKPSeI1oqrE4JXHyDQdS8SWCFMYm57w0DlB9jxvYKFINTmfMJ6Ia2Ku+Xy8RyoVd48Z2ofcPm//s+/CZZwJyNWj+ZoQ0puJdYWbsvOWdnEQhF/Fbz/JVsnAb4Rc9tfueoxLfps+IRX3t/AUBnaCHBh+OGJydijEKnfYtUpna8yLnMBpFdB0btbBPfmNyKHC97CVhjE9U3m6KNvA+blynSza4dzg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e36e90-bf8c-483a-d088-08d8848f00e8
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2020 09:08:20.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0pVR9c+ytYai6JIpNmVxpoYA5A76tNVG5L7iPFgIkdrmbvzmLK65fIAlNE7FQc3fmNawknk5S/GlMy3TERLvow==
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
 arch/arm64/boot/dts/hisilicon/hip05.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hip05.dtsi b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
index bc49955360db..fbe83eb9f77b 100644
--- a/arch/arm64/boot/dts/hisilicon/hip05.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip05.dtsi
@@ -335,7 +335,7 @@ porta: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
+				ngpios = <32>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
@@ -354,7 +354,7 @@ portb: gpio-controller@0 {
 				compatible = "snps,dw-apb-gpio-port";
 				gpio-controller;
 				#gpio-cells = <2>;
-				snps,nr-gpios = <32>;
+				ngpios = <32>;
 				reg = <0>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
-- 
2.29.2

