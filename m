Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422822A8C61
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732984AbgKFCAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:00:14 -0500
Received: from mail-eopbgr60049.outbound.protection.outlook.com ([40.107.6.49]:45213
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730414AbgKFCAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:00:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Juf/BByKZ84OArQsV0VTQme9KmecdXnTsdGhZ9Mo/QmZi6AjfEH4jEj8npuameynTRUVLtS3H24C/GB7rsv0dzVB9mX/+pczEi5w/0N3F2qA0DOF6iaGsT5F2PSaOTIFnkLgZ3B7d0c0Oy0qGoTb5G/zsbC2fM3uA/gsEzleC9Pv3+Mr8PW8r4LPuoSRQMNdrApwp9MPmjQbPu559afDr9plQX9Ktl6dguuNCs9R9Fi84NxrPYb6YGS8qm+uiNXhNFuyVbhO2Cv7glVbBHa8FCoNmGMNzzDM3dI+hSuu8pltO0A7a606I/9PXrff07c92ZqRwcRGCEpOBaI7uthjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spKp2QXyQvMynh8wBxrACUhZdtKYc5r2i94j1V5Wcmw=;
 b=EezBsW9ojshKTU1+4z+iCaCubOcdgyH3xwNfdNGtJOm0379ecflW7J4bpTwac4ZCYRvMrrpMLRTLMp1H90vwPbMAb3F/0IZxrUa82w9RMS9OzdI3PzUvR7mYC0rKMJH2rsoax9K+ETUVV0T3w3TGWp2q5zppmpl6IxoHlzlAckOLZ4LL90Kne5pDvmcJEpHNCfndLlRqeQSzpxXq6RCY2ek7vvO+ik+IP5VyM6TQtUfSJ7tv5vvHh0WnIVFSnu5GUK+bCAdONw6WwYYG5QV/4cTltyUGyj/CIMOoNi35DjMK9GO+kHJr3OrjG61nNlMgQpEEQ9GCdfrLW2shjOb1cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=spKp2QXyQvMynh8wBxrACUhZdtKYc5r2i94j1V5Wcmw=;
 b=hPogSb9MTw4KbqKYnQAKNcsQIaXVrWlDVsYmboaJgUwWBH5yUiv3+B6Eqr+kAmhMxDUnK1fXQLxiWoxdLtn3hN4k4+16GBjo3KKXc7QaUZaaCATCMlkQZs2hEVf4mTvO7Vt3hKokjAr8z4fJ9uG65DlZpqH/07o746cYkHlHEHs=
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com (2603:10a6:803:121::30)
 by VI1PR04MB6159.eurprd04.prod.outlook.com (2603:10a6:803:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 6 Nov
 2020 02:00:10 +0000
Received: from VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8]) by VE1PR04MB6687.eurprd04.prod.outlook.com
 ([fe80::b106:ac49:e3c7:6dc8%7]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 02:00:10 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Michael Walle <michael@walle.cc>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: RE: [PATCH v2 5/5] arm64: dts: lx2160a: fix FlexSPI clock
Thread-Topic: [PATCH v2 5/5] arm64: dts: lx2160a: fix FlexSPI clock
Thread-Index: AQHWs6rPgIwszLN78UeuTDUjVvg++am6V+oA
Date:   Fri, 6 Nov 2020 02:00:10 +0000
Message-ID: <VE1PR04MB6687EC27F8C230A8F334119E8FED0@VE1PR04MB6687.eurprd04.prod.outlook.com>
References: <20201105193512.22388-1-michael@walle.cc>
 <20201105193512.22388-6-michael@walle.cc>
In-Reply-To: <20201105193512.22388-6-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [136.49.1.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7352ee88-633f-4c63-7b0f-08d881f7b130
x-ms-traffictypediagnostic: VI1PR04MB6159:
x-microsoft-antispam-prvs: <VI1PR04MB6159BA704AE879548366665C8FED0@VI1PR04MB6159.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YAs+odL91ldozC4oMZvNIPn5ksQW0urI3H0gKzzJW1ED75Z7AFE7FsKx03b6vB0eTQBljfi2L3Ik7jk34+0zmEeEGhSlPAQOBVo9zP2XP+3MgCf/vO+mHfd4XY34bGYMa+bE+KPABnMkpGV2Pjbv3BIgSMhYaU9+QHRIm4PrAcWcqTNXIZwMzgbsFJnpbi4OeGBg2G/UzjjTmcIHg4Ep9DRABHvNZi4TaEqDEdzgTcTdrA5nCBtIPMxRJvilc/P20arphi7+htNiYZKY/5XTBK7q9GbevC76OFqmJ+NViPyz9scKS3SWYinSAfv2EdJj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39850400004)(8936002)(8676002)(55016002)(66946007)(76116006)(9686003)(83380400001)(2906002)(4326008)(66556008)(64756008)(66446008)(110136005)(316002)(7696005)(86362001)(478600001)(5660300002)(52536014)(26005)(53546011)(33656002)(71200400001)(66476007)(186003)(6506007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wbaPhL7EwuXuQccQ3AOb4SxUqOUTq5DtqXjDrK6cVOqEkpI3NuflD1PwLgc+bNw28xF1UBys+56Z2sfMccJNWoRSg6kTQWs1zJNZu7Kk2MAHtF2kGEDOzD0e2M3dJmb/h++oPQb5s3xTk2hF3V/C4zUcadN3Vs6FEtqRlrO5wg4B9RdEbQ77gUDLQOM1q5ZCxQCh5gs3BFpBNGfIravE/UJDOoIZaL6O1HJTycSRRDd6spQvthG3loXi4dzRkJiV2eG4xaqPFkt1QrfHj6pVDETyfUbtp7yJBdl6dKJblQ0R7Vx4+b5PWxlKyyntVGoTQMIEiZrkY4kClgVWxVyL7PEAQ+38BICs6eeCGE9PMrKdM2DYqtp/3hU3Sy2VdnXOOV7DlanLu/dnoTuhZ/0Q47mIAYgQ9JzXUL7VvhfMEg8YHhCakCb78prhudnPU688fnhZoNYTuxAZO7TC4U+FlvI0JQIXSwB0uokOg24RqmuRGUW7or2AKVdXoC1OGIYCOW8fIIiNTX1JpfE2QE//Qcac9wMbZKXihBzjdKL+OCewgwah3dNGxwNQrALKBvxg4hl8gc2eLPDwBzx1HXwAEvjRvClB6OTjg3YBOgdP2bCsFDOm3mT0X7gXu8rPWfuXk47kPkAFlajqcXAWC/zTow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7352ee88-633f-4c63-7b0f-08d881f7b130
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 02:00:10.1965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l6erWvRU9q0nM4pPDgpXJESpRUsPZU3JdrrPtqdkMKfZNpVGdJcrcaQQhMookrK74OosxIKF/He2WLmXCMfY/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Thursday, November 5, 2020 1:35 PM
> To: linux-clk@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Michael Turquette <mturquette@baylibre.com>; Stephen Boyd
> <sboyd@kernel.org>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Leo Li <leoyang.li@nxp.com>; Michael Walle
> <michael@walle.cc>
> Subject: [PATCH v2 5/5] arm64: dts: lx2160a: fix FlexSPI clock
>=20
> Now that we have a proper driver for the FlexSPI interface use it. This w=
ill fix
> SCK frequency switching on Layerscape SoCs.
>=20
> This was only compile time tested.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v1:
>  - none
>=20
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index 83072da6f6c6..6e375e80bd35 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -659,9 +659,20 @@
>  		};
>=20
>  		dcfg: syscon@1e00000 {
> -			compatible =3D "fsl,lx2160a-dcfg", "syscon";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			compatible =3D "fsl,lx2160a-dcfg", "syscon", "simple-
> mfd";
>  			reg =3D <0x0 0x1e00000 0x0 0x10000>;
> +			ranges =3D <0x0 0x0 0x1e00000 0x10000>;
>  			little-endian;
> +
> +			fspi_clk: clock-controller@900 {
> +				compatible =3D "fsl,lx2160a-flexspi-clk";
> +				reg =3D <0x900 0x4>;
> +				#clock-cells =3D <0>;
> +				clocks =3D <&clockgen 4 0>;

This is different from the current <&clockgen 4 3>, is it an intended chang=
e?

> +				clock-output-names =3D "fspi_clk";
> +			};
>  		};
>=20
>  		tmu: tmu@1f80000 {
> @@ -776,7 +787,7 @@
>  			      <0x0 0x20000000 0x0 0x10000000>;
>  			reg-names =3D "fspi_base", "fspi_mmap";
>  			interrupts =3D <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> -			clocks =3D <&clockgen 4 3>, <&clockgen 4 3>;
> +			clocks =3D <&clockgen 4 3>, <&fspi_clk>;
>  			clock-names =3D "fspi_en", "fspi";
>  			status =3D "disabled";
>  		};
> --
> 2.20.1

