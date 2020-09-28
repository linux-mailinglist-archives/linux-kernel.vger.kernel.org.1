Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA2B27A4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 02:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgI1AIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 20:08:15 -0400
Received: from mail-eopbgr00048.outbound.protection.outlook.com ([40.107.0.48]:24557
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbgI1AIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 20:08:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4B1HMnN0TULKn7xsUtD+XD8ov0w/WB33TVAv7LVC3KQg4Ach340AjCNtNC8QPmNZges48iGTmKq04H8RQegm/yY2G2bJOSAJaQUF1FRN+k3ZwweIatBO0Hmi3EFyKUG+TNsI+le6Dzi7T53dXv8VTZpF5IkMrQSqzZEjMt4OwBz+/+/SCTm687XMmnrUVfyLpnt2L9jkY6mSoWK3wus68Fn5iwqHJ57xlAVW/0JoauwELANIviwgoKzpxEAviqIn6y+p2QIBla+xV7fC7hMImydXGLnse7vDNeKI0E4QdJzYoyZRFw3FAZLdmT9OkElWTwxiCO/cYvZyXLRSSz7kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmeKfMcKqfSc99P+v2bENsHgC3uFBImvTC+8YynsiRA=;
 b=cYPPg5Lpv2T56dSRjC3dM5Cio35rn4cmL75dfaPzFlmwmLE9hKoY7OhIKPYojJLr0W0mQXjZvCugyBrfYznQVHB/+9sZMEHOh81PzBxBUCs+nJgp55A80oWhcC3QTyybOMCBlhmRC+kwIyEQp/JyqIrB/7wkUir6C/AgKtfPj1KsCHrvynuEK1A2tGuFcnNMM58nF/EMz/F+mkLRLsmSMniEGb8Rz748zWsNFd8ncMQVkACQzn1rhu91mhRPzNYtzK2ZhliCd+K2Ys/9DX9059/mp5HAzqPQJfg4TOpQtLDlzWp0GdADKzy+TyIxOFnogGDNMU9F9VVkcEVmVf4nSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmeKfMcKqfSc99P+v2bENsHgC3uFBImvTC+8YynsiRA=;
 b=MDndroPeQ/IbaP3ux30TkQ0TiHmsEq2pk6PPKP2zLymTKtO6d+qlf0C0xu5fqzTaP90Bqs3Q0ow3nRa9m4GojAsAziJh5p5ufRd3eFKHEdFpYCMa8Tl3laPQWeBK8QKpn/l6k2WOpBPuza2PJwMrvrvpZlb6XtFT+sABxY/zkKE=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6998.eurprd04.prod.outlook.com (2603:10a6:20b:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Mon, 28 Sep
 2020 00:08:11 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%4]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 00:08:10 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Gong <yibin.gong@nxp.com>
Subject: RE: [PATCH 5/6] arm64: dts: imx8mn-ddr4-evk: fix missing PMIC's
 interrupt line pull-up
Thread-Topic: [PATCH 5/6] arm64: dts: imx8mn-ddr4-evk: fix missing PMIC's
 interrupt line pull-up
Thread-Index: AQHWlO+4wbPb14xMY0+7xTz4y5ySvql9LObg
Date:   Mon, 28 Sep 2020 00:08:10 +0000
Message-ID: <AM7PR04MB715780C6B4BCDCC86EF91AA68B350@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200927165947.7317-1-krzk@kernel.org>
 <20200927165947.7317-5-krzk@kernel.org>
In-Reply-To: <20200927165947.7317-5-krzk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.158.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29dd70af-4a7a-4c19-1942-08d863429614
x-ms-traffictypediagnostic: AM7PR04MB6998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB699899A19E38E179AFFF4F718B350@AM7PR04MB6998.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jqPNvzcPQjA9sLctELMyW/FravK2uv3XIBMBum/DVfn9YISuLkZqRBqBakUK6lO1UgzhuSXuYiXSivdpYPid5kfn5leaikZqktFT2U9oJiBhRmvgQo8lYZ5DfMiWZU4wPyk65v9egAPZ9lxp0kb5HugoYaNLIShEElnNidUvneQrRchvcvxJIW5MSjbUWKmv3+N10r04bXUmkZRptbty5nBzQBuMFc49najOKwuzCRJJNjdePt+jhr7Q7pNtyGcfPsaDo7hK966pEm+CTgV5AZWgOmqmGTYuZWzYoySBWYWnHy9hd4EI5UMQNosQWOqPjwb0ukKqHpvu0rGYFqSNr9uDbmmMorXyUeBdiDh+sd3OcdKfuxKoZ+4DA6l+m4GmiVZjdH9fCS2qCmMqAEgtINy+v+uKu/wWOHKnrUzCii7YVq8FOiUR3je5zXDMyCKn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(7416002)(6506007)(26005)(6636002)(55016002)(5660300002)(9686003)(86362001)(71200400001)(186003)(478600001)(52536014)(110136005)(7696005)(2906002)(64756008)(66556008)(66446008)(8676002)(66476007)(316002)(76116006)(33656002)(66946007)(8936002)(44832011)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 7acgYCF3XNKTGPqEV5l6kq11Gkrih8qDhpJSpiKiKAfIYS318hxoam1ORKc5IXfuHYpjhoXXDx3x4hJSo5wHgXfARb1bsX3AlzIrkuWBBLrGMtdUlpoi7cH0ohT57Km7qvT2RVYAM1ve07+7DpieJ+38TU3SeGnjsGByF6mrJOSbHgQoC2WS77tKqeU1GaPrS8+v0NDNTKIJnzbYa/ca9IzOan3HOm52Gy6y2uedyxRJKiDroEpwTrnOGU+0UTTRg8gW/dYJdsc+Q8u18rulUm2iVopJsXh/cdX1lmvwgf0hWCKS02j7r2d0+VeM0uZvexE4LwLyULOe+8ZjfVWpNdH8JzkI6Tbd+HU38QrDtQByF8ee3VWpqlahZupQvEMrtS6lHXz1BINlP314t3/5UDnzmjdHnvKHjc7Ha0YNyldo59FTXU72pxkuSCS4xrVQI1nIXEwS34jnYImH7C/4rOD0epyyonJ3AMG0tKDUrlDmojnx/df0icjbUV3XaILl5NOxm1ebEYlYPsg4/fU6qFjhXC3lqUo4wSPZZglV5R34taCDHCOj4Qu0jMeVA7wZz32Bs53fSPEZskMDyA5os4hBpqH4qnQ322oxfpYC3KnxUSLoJ2lSxPnG1RbXxz8wK5pjllitr8AFrluWuy8L+Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dd70af-4a7a-4c19-1942-08d863429614
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 00:08:10.8930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: degft1yRteNmJnMIg+Y621u+N056UKaiNvT8d392/Xx0fqaTuX3bqYh2QAlCQu1CNIWHGwN23ROQLJsDyl8NgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6998
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
Add Robin Gong.

> Subject: [PATCH 5/6] arm64: dts: imx8mn-ddr4-evk: fix missing PMIC's
> interrupt line pull-up
>=20
> The PMIC's interrupt is level low and should be pulled up.  The PMIC's de=
vice
> node had pinctrl-0 property but it lacked pinctrl-names which is required=
 to
> apply the pin configuration.
>=20
> Fixes: 4153f7811a9b ("arm64: dts: imx8mn: correct interrupt flags")
> Fixes: 3e44dd09736d ("arm64: dts: imx8mn-ddr4-evk: Add rohm,bd71847 PMIC
> support")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> index 46e76cf32b2f..7dfee715a2c4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> @@ -53,6 +53,7 @@
>  	pmic@4b {
>  		compatible =3D "rohm,bd71847";
>  		reg =3D <0x4b>;
> +		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&pinctrl_pmic>;
>  		interrupt-parent =3D <&gpio1>;
>  		interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> --
> 2.17.1

Peter
