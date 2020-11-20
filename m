Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EC52BA60C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgKTJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:25:25 -0500
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:23005
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbgKTJZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:25:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoqZHZpspKOqNqiHm6VUm0sMLfSERmGK+oCGiB+mjEZO/iliVLyK5FE3cN4sYNN3ac1T26HAZWRx40rOFn7dn5199nDJrv4hCDs2Iz3HMJqIfETtXb1eg4emu+LZYQBqkuVXdekRiA12zCd1hJ3CaXFrx740f8UO1p+G62+XNNS7CavgrLjvfQDqT9KvNBsf4EknVNbKj08rk4Vr6TGj7kAKrJ8QDEjVxvdh9FfWDbMwKznBPuArtUzCQGK7Y1PDJB0hlApkgTePsX94UMFBpvb0mkByif1c8lBuFbI1naIhvpyjtZTdJEZsF3jduKqQZyrzYqWE2RbYqF8OZwJuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucaxcOkTjtBRqjpCtkjSk8RnBkAgn6RdQaGn3W4ko/I=;
 b=FTose8j69ziarWktmvVb35wBhwvSO+fTZNVl5xVsOQEPMDami/ukbHZT2lOos8kGDKQ7Q517Jf3plqDg972YiuUn2s562uAsA55vdty0oqqbZURrDcLGvpZxhGaxjegwcZYPEWdGSm3y2XUGZUgYFNAj/YBcnMA7eUnxyv+lvDx7sYHIhv2uFHnmAbkKe5aVIXVjW4YQb4DaCKKRwEAWTy8QYcmbSLgP94XOD8qSwJ/sFdnXz6zT7XJIHOWUyPJBppu5SNfMNZPodrmhDE2uFLkZ1iQo9CFgDq2LuMBCBvYLr16d/CCf2MVVU5+USdZ2PvSg1fDOuevKbynykZKudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucaxcOkTjtBRqjpCtkjSk8RnBkAgn6RdQaGn3W4ko/I=;
 b=OXclYspAezIV9xrDacby+Y5nViLwFCPKaA8ttn7IztEN3ZHYNt3fw9Cvcv4EvZmkuFz12jTOb0mNTWqsoBGdYbjklSAyArhM87lfGEBZDLhUHawSzK+fLi+d/Nmt8yYKtSMzRi1t5NONCuYlwrTh2iCXXDstiP136Ax2v+FtaeQ=
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com (2603:10a6:7:21::31) by
 HE1PR0401MB2473.eurprd04.prod.outlook.com (2603:10a6:3:86::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.22; Fri, 20 Nov 2020 09:25:14 +0000
Received: from HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::a5f9:47b0:c473:7ddf]) by HE1PR04MB3196.eurprd04.prod.outlook.com
 ([fe80::a5f9:47b0:c473:7ddf%7]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 09:25:14 +0000
From:   Ashish Kumar <ashish.kumar@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: RE: [EXT] [PATCH v3 4/9] arm64: dts: ls1028a: use constants in the
 clockgen phandle
Thread-Topic: [EXT] [PATCH v3 4/9] arm64: dts: ls1028a: use constants in the
 clockgen phandle
Thread-Index: AQHWtgAqNmhPttZH1kyEI8J7SIVcLanQ0Dog
Date:   Fri, 20 Nov 2020 09:25:14 +0000
Message-ID: <HE1PR04MB319684750CF7D1920DCCCDD095FF0@HE1PR04MB3196.eurprd04.prod.outlook.com>
References: <20201108185113.31377-1-michael@walle.cc>
 <20201108185113.31377-5-michael@walle.cc>
In-Reply-To: <20201108185113.31377-5-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [122.177.30.104]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7213c44a-cb92-477a-f7db-08d88d362fe5
x-ms-traffictypediagnostic: HE1PR0401MB2473:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <HE1PR0401MB24739011D1653FB1DA74457A95FF0@HE1PR0401MB2473.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CwgOgTnuznWowLoTWW9rcz1AUOHDmEUGBngjNx1lAV88Qp5pS+sU+GlxpGIkVJoJccSHAUJd7Z4FvF3eZAieWt8xeA7jcKedBCjOm3aNOVO1NM4u7oe/3G4L2d6pLH0P+Gtnl6TAIHtYWWzUBoT67aIE+pCqm8HYuCHfhfVKjmsNJLLzp/jcpK1xxlTQEGddTFjKZjHGNT60RHv3qi9UAatH0qTOiBirCTUtstnP/J1T+cWH7tTwe4kWeVQ92+7y57sUp0Z0CNou1bmPbe41OkZruTKenkMoF2XYq7pQd2y5p5ep9Xxon/VK54h8VOQl+msG207H2KA29L/kCFFkUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3196.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(52536014)(316002)(30864003)(55236004)(6506007)(53546011)(8676002)(110136005)(76116006)(66476007)(66446008)(64756008)(8936002)(5660300002)(55016002)(2906002)(33656002)(66946007)(66556008)(44832011)(83380400001)(7696005)(26005)(71200400001)(478600001)(86362001)(4326008)(54906003)(186003)(9686003)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +c1EZZe1s2+q+TbpzyfbpxGqEerFx1GzaBsWzqpJZ96x6QU4x4F7TMTKG4O3AJS/wuOQydMQLapO1JvceQ5WcqDM387Ivk8XhheB+jfJ4mn2HuILG2JoYBXev3H9CdLjySKa0eIKHRumlE10yyFe67KPRCQGJC0x6+ddy8TNXeTw7iMdxVymF8uGS1QPG4ZA8Te6FkZ5lRKBPCXlLrxrgSXjupgLFnICd6y/3Q6m6O0mD/eyy9NarMkF6WruMyiTJ/OdW5QoXCWhOSjD/2+5/tYALliXtOVWC5qn0tX1bfBM5Ixi5cfVUuOr8+Oz75unsO37U92j1Bu2fJK/vycOEVIgZkLWF+eKFoQxsDkPHMqXMHDTwnuE81a7q92b9qn0JSEQLz3N7HnkXItT7N09ho9TAlmvAet6y685Jyn5Hi032yzrIh7AoGGJFIzEjq1n4EmVUUnlgcGXOEcKmD2YrLTu90GvalJiZthkdzamrQRKRGXxRgn3eQDWg8LKR0cppdBV5tkAg70qs6hPvAmiv1FjSwLR3yOVX4xbsf28ecE79biAHO7OM0UXqyVoWk7izDPKkDeKyjIiyz5TGEPKvlRdeZWVo44x1THDoVakD5zPxYPSRdxjBvznLffhLgOYcKD/Qx5S+FeJivRx2lQrOQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3196.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7213c44a-cb92-477a-f7db-08d88d362fe5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2020 09:25:14.2796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSh7duOeqM0bExnH/anRPvyQcn5i2gTZd1f2MXjvs2iARCAgVDskuXm7gebpM7IDIcUfZhiP8i0wpHFd2BDO6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2473
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Michael,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Monday, November 9, 2020 12:21 AM
> To: linux-clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Y.b. Lu
> <yangbo.lu@nxp.com>; Xiaowei Bao <xiaowei.bao@nxp.com>; Ashish Kumar
> <ashish.kumar@nxp.com>; Vladimir Oltean <vladimir.oltean@nxp.com>;
> Michael Walle <michael@walle.cc>
> Subject: [EXT] [PATCH v3 4/9] arm64: dts: ls1028a: use constants in the c=
lockgen
> phandle
>=20
> Caution: EXT Email
>=20
> Now that we have constants, use them. This is just a mechanical change.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v2:
>  - new patch

I am not able to apply this patch cleanly, does it have any dependency patc=
h that I have missed?
My assumption is that this patch series is superset of=20
Series 1: [1/4]  dt-bindings: clock: document the fsl-flexspi-clk driver
And=20
Series 2:  [v2,1/5] clk: divider: add devm_clk_hw_register_divider_table()

Regards
Ashish=20
>=20
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 162 +++++++++++++-----
>  1 file changed, 116 insertions(+), 46 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 2f60a6ba7e14..055da2c710c3 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -8,6 +8,7 @@
>   *
>   */
>=20
> +#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/thermal/thermal.h>
>=20
> @@ -32,7 +33,7 @@
>                         compatible =3D "arm,cortex-a72";
>                         reg =3D <0x0>;
>                         enable-method =3D "psci";
> -                       clocks =3D <&clockgen 1 0>;
> +                       clocks =3D <&clockgen QORIQ_CLK_CMUX 0>;
>                         next-level-cache =3D <&l2>;
>                         cpu-idle-states =3D <&CPU_PW20>;
>                         #cooling-cells =3D <2>; @@ -43,7 +44,7 @@
>                         compatible =3D "arm,cortex-a72";
>                         reg =3D <0x1>;
>                         enable-method =3D "psci";
> -                       clocks =3D <&clockgen 1 0>;
> +                       clocks =3D <&clockgen QORIQ_CLK_CMUX 0>;
>                         next-level-cache =3D <&l2>;
>                         cpu-idle-states =3D <&CPU_PW20>;
>                         #cooling-cells =3D <2>; @@ -236,7 +237,8 @@
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x2000000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 3>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(4)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -246,7 +248,8 @@
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x2010000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 3>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(4)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -256,7 +259,8 @@
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x2020000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 3>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(4)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -266,7 +270,8 @@
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x2030000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 3>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(4)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -276,7 +281,8 @@
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x2040000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 3>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(4)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -286,7 +292,8 @@
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x2050000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 3>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(4)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -296,7 +303,8 @@
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x2060000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 3>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(4)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -306,7 +314,8 @@
>                         #size-cells =3D <0>;
>                         reg =3D <0x0 0x2070000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 3>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(4)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -318,7 +327,8 @@
>                               <0x0 0x20000000 0x0 0x10000000>;
>                         reg-names =3D "fspi_base", "fspi_mmap";
>                         interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 2 0>, <&clockgen 2 0>;
> +                       clocks =3D <&clockgen QORIQ_CLK_HWACCEL 0>,
> +                                <&clockgen QORIQ_CLK_HWACCEL 0>;
>                         clock-names =3D "fspi_en", "fspi";
>                         status =3D "disabled";
>                 };
> @@ -330,7 +340,8 @@
>                         reg =3D <0x0 0x2100000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-names =3D "dspi";
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         dmas =3D <&edma0 0 62>, <&edma0 0 60>;
>                         dma-names =3D "tx", "rx";
>                         spi-num-chipselects =3D <4>; @@ -345,7 +356,8 @@
>                         reg =3D <0x0 0x2110000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-names =3D "dspi";
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         dmas =3D <&edma0 0 58>, <&edma0 0 56>;
>                         dma-names =3D "tx", "rx";
>                         spi-num-chipselects =3D <4>; @@ -360,7 +372,8 @@
>                         reg =3D <0x0 0x2120000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-names =3D "dspi";
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         dmas =3D <&edma0 0 54>, <&edma0 0 2>;
>                         dma-names =3D "tx", "rx";
>                         spi-num-chipselects =3D <3>; @@ -373,7 +386,7 @@
>                         reg =3D <0x0 0x2140000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-frequency =3D <0>; /* fixed up by bootloade=
r */
> -                       clocks =3D <&clockgen 2 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_HWACCEL 1>;
>                         voltage-ranges =3D <1800 1800 3300 3300>;
>                         sdhci,auto-cmd12;
>                         little-endian;
> @@ -386,7 +399,7 @@
>                         reg =3D <0x0 0x2150000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
>                         clock-frequency =3D <0>; /* fixed up by bootloade=
r */
> -                       clocks =3D <&clockgen 2 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_HWACCEL 1>;
>                         voltage-ranges =3D <1800 1800 3300 3300>;
>                         sdhci,auto-cmd12;
>                         broken-cd;
> @@ -399,7 +412,8 @@
>                         compatible =3D "fsl,ls1028ar1-flexcan", "fsl,lx21=
60ar1-flexcan";
>                         reg =3D <0x0 0x2180000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&sysclk>, <&clockgen 4 1>;
> +                       clocks =3D <&sysclk>, <&clockgen QORIQ_CLK_PLATFO=
RM_PLL
> +
> + QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "ipg", "per";
>                         status =3D "disabled";
>                 };
> @@ -408,7 +422,8 @@
>                         compatible =3D "fsl,ls1028ar1-flexcan", "fsl,lx21=
60ar1-flexcan";
>                         reg =3D <0x0 0x2190000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&sysclk>, <&clockgen 4 1>;
> +                       clocks =3D <&sysclk>, <&clockgen QORIQ_CLK_PLATFO=
RM_PLL
> +
> + QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "ipg", "per";
>                         status =3D "disabled";
>                 };
> @@ -417,7 +432,8 @@
>                         compatible =3D "fsl,ns16550", "ns16550a";
>                         reg =3D <0x00 0x21c0500 0x0 0x100>;
>                         interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -425,7 +441,8 @@
>                         compatible =3D "fsl,ns16550", "ns16550a";
>                         reg =3D <0x00 0x21c0600 0x0 0x100>;
>                         interrupts =3D <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -434,7 +451,8 @@
>                         compatible =3D "fsl,ls1028a-lpuart";
>                         reg =3D <0x0 0x2260000 0x0 0x1000>;
>                         interrupts =3D <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "ipg";
>                         dma-names =3D "rx","tx";
>                         dmas =3D <&edma0 1 32>, @@ -446,7 +464,8 @@
>                         compatible =3D "fsl,ls1028a-lpuart";
>                         reg =3D <0x0 0x2270000 0x0 0x1000>;
>                         interrupts =3D <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "ipg";
>                         dma-names =3D "rx","tx";
>                         dmas =3D <&edma0 1 30>, @@ -458,7 +477,8 @@
>                         compatible =3D "fsl,ls1028a-lpuart";
>                         reg =3D <0x0 0x2280000 0x0 0x1000>;
>                         interrupts =3D <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "ipg";
>                         dma-names =3D "rx","tx";
>                         dmas =3D <&edma0 1 28>, @@ -470,7 +490,8 @@
>                         compatible =3D "fsl,ls1028a-lpuart";
>                         reg =3D <0x0 0x2290000 0x0 0x1000>;
>                         interrupts =3D <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "ipg";
>                         dma-names =3D "rx","tx";
>                         dmas =3D <&edma0 1 26>, @@ -482,7 +503,8 @@
>                         compatible =3D "fsl,ls1028a-lpuart";
>                         reg =3D <0x0 0x22a0000 0x0 0x1000>;
>                         interrupts =3D <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "ipg";
>                         dma-names =3D "rx","tx";
>                         dmas =3D <&edma0 1 24>, @@ -494,7 +516,8 @@
>                         compatible =3D "fsl,ls1028a-lpuart";
>                         reg =3D <0x0 0x22b0000 0x0 0x1000>;
>                         interrupts =3D <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "ipg";
>                         dma-names =3D "rx","tx";
>                         dmas =3D <&edma0 1 22>, @@ -513,8 +536,10 @@
>                         interrupt-names =3D "edma-tx", "edma-err";
>                         dma-channels =3D <32>;
>                         clock-names =3D "dmamux0", "dmamux1";
> -                       clocks =3D <&clockgen 4 1>,
> -                                <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                 };
>=20
>                 gpio1: gpio@2300000 {
> @@ -576,7 +601,8 @@
>                                 <0x7 0x100520 0x0 0x4>;
>                         reg-names =3D "ahci", "sata-ecc";
>                         interrupts =3D <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         status =3D "disabled";
>                 };
>=20
> @@ -748,14 +774,20 @@
>                 cluster1_core0_watchdog: watchdog@c000000 {
>                         compatible =3D "arm,sp805", "arm,primecell";
>                         reg =3D <0x0 0xc000000 0x0 0x1000>;
> -                       clocks =3D <&clockgen 4 15>, <&clockgen 4 15>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(16)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(16)>;
>                         clock-names =3D "wdog_clk", "apb_pclk";
>                 };
>=20
>                 cluster1_core1_watchdog: watchdog@c010000 {
>                         compatible =3D "arm,sp805", "arm,primecell";
>                         reg =3D <0x0 0xc010000 0x0 0x1000>;
> -                       clocks =3D <&clockgen 4 15>, <&clockgen 4 15>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(16)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(16)>;
>                         clock-names =3D "wdog_clk", "apb_pclk";
>                 };
>=20
> @@ -764,8 +796,14 @@
>                         compatible =3D "fsl,vf610-sai";
>                         reg =3D <0x0 0xf100000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> -                                <&clockgen 4 1>, <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
>                         dma-names =3D "tx", "rx";
>                         dmas =3D <&edma0 1 4>, @@ -779,8 +817,14 @@
>                         compatible =3D "fsl,vf610-sai";
>                         reg =3D <0x0 0xf110000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> -                                <&clockgen 4 1>, <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
>                         dma-names =3D "tx", "rx";
>                         dmas =3D <&edma0 1 6>, @@ -794,8 +838,14 @@
>                         compatible =3D "fsl,vf610-sai";
>                         reg =3D <0x0 0xf120000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> -                                <&clockgen 4 1>, <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
>                         dma-names =3D "tx", "rx";
>                         dmas =3D <&edma0 1 8>, @@ -809,8 +859,14 @@
>                         compatible =3D "fsl,vf610-sai";
>                         reg =3D <0x0 0xf130000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> -                                <&clockgen 4 1>, <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
>                         dma-names =3D "tx", "rx";
>                         dmas =3D <&edma0 1 10>, @@ -824,8 +880,14 @@
>                         compatible =3D "fsl,vf610-sai";
>                         reg =3D <0x0 0xf140000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> -                                <&clockgen 4 1>, <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
>                         dma-names =3D "tx", "rx";
>                         dmas =3D <&edma0 1 12>, @@ -839,8 +901,14 @@
>                         compatible =3D "fsl,vf610-sai";
>                         reg =3D <0x0 0xf150000 0x0 0x10000>;
>                         interrupts =3D <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> -                       clocks =3D <&clockgen 4 1>, <&clockgen 4 1>,
> -                                <&clockgen 4 1>, <&clockgen 4 1>;
> +                       clocks =3D <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>,
> +                                <&clockgen QORIQ_CLK_PLATFORM_PLL
> +                                           QORIQ_CLK_PLL_DIV(2)>;
>                         clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
>                         dma-names =3D "tx", "rx";
>                         dmas =3D <&edma0 1 14>, @@ -961,7 +1029,7 @@
>                         ethernet@0,4 {
>                                 compatible =3D "fsl,enetc-ptp";
>                                 reg =3D <0x000400 0 0 0 0>;
> -                               clocks =3D <&clockgen 2 3>;
> +                               clocks =3D <&clockgen QORIQ_CLK_HWACCEL
> + 3>;
>                                 little-endian;
>                                 fsl,extts-fifo;
>                         };
> @@ -1056,8 +1124,10 @@
>                 interrupts =3D <0 222 IRQ_TYPE_LEVEL_HIGH>,
>                              <0 223 IRQ_TYPE_LEVEL_HIGH>;
>                 interrupt-names =3D "DE", "SE";
> -               clocks =3D <&dpclk>, <&clockgen 2 2>, <&clockgen 2 2>,
> -                        <&clockgen 2 2>;
> +               clocks =3D <&dpclk>,
> +                        <&clockgen QORIQ_CLK_HWACCEL 2>,
> +                        <&clockgen QORIQ_CLK_HWACCEL 2>,
> +                        <&clockgen QORIQ_CLK_HWACCEL 2>;
>                 clock-names =3D "pxlclk", "mclk", "aclk", "pclk";
>                 arm,malidp-output-port-lines =3D /bits/ 8 <8 8 8>;
>                 arm,malidp-arqos-value =3D <0xd000d000>;
> --
> 2.20.1

