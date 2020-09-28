Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473C427A948
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 10:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgI1IGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 04:06:14 -0400
Received: from mail-am6eur05on2071.outbound.protection.outlook.com ([40.107.22.71]:30113
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725308AbgI1IGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 04:06:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kA4GGf64Ogn6NsgdrXUo3zf1pseP0dWBJJ0iA8fgsPxk4+nwG7xWjDIadt30SIWUJWJ+WmOU/2XxaWrAbfIwVmPwpcyOxm/6YjqxcWnjZXHvqc/eEdykiFpe68ODJxbR0P4QnyEPLaBl17ankLka5CwYXws0JtXrsOKwP6hW8N9QgRxAZZHEddf//+LdVmZMl47YkqQB2tjyR4AubVFL2smFTEVL5C/ZOKFNCHETp8TERgJEqy5ORAnXCmr1czih0HqqN2/xnUhiNqAPNl672+UxsXO5eLs3CR76mNGnjxY2JMBHlj7ynBjcjA7jk+nWb6cqzVOCclrVwDMZRtsL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ8jIIX11/Jy7Pob3cjz7SMIXiDxWR6zSmSZTQ3DfJI=;
 b=gp6FCE+iTWuSmSZW9cteI8nS4ceVzZvXKMltOTjtrHhXqws4hncTgiwj6NKCcuuu8Z5w/++czgtm2qMIOmGALS1P+ii7R/i4++0yrG2KWG1eB+R4h5DiJUS7zRwB57Ia5r/WkXIklB79AXaCUZRBSmAsR0hvNnHT08HN2tr8/vKHDvRL0vvm24CPNuwxz+irn/igZW+UWMglxHMnX0Pbon7RYgyu2DXqOX0aXeeJPof2MLozVeCzDpGxBfotCDEIxchU+0Emdo8e+VkfR2MYEktcU2IOVSCrjSbHhJQ7IVlf++8w77zueFMR5Gwouy2a22k2QI55ddEDrW8IiblLYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ8jIIX11/Jy7Pob3cjz7SMIXiDxWR6zSmSZTQ3DfJI=;
 b=pR5XbNr+ZfrzhNhDBID9jww9fHANtgO+8hGpxOGSYlqXMWFUZjvYxnHCNZ5p/piVUzMQ7CDYlR89mCKTaNHewf+00Zc7uzQLmW1wzny59sqYqDGLdmavoZclq1OmCkg1civVeyRI7LgfyLb5EmbyeXqa7w/KYOJBNQoZl+Jx0Sg=
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15)
 by VI1PR04MB4815.eurprd04.prod.outlook.com (2603:10a6:803:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Mon, 28 Sep
 2020 08:06:10 +0000
Received: from VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950]) by VE1PR04MB6638.eurprd04.prod.outlook.com
 ([fe80::ad7f:d95a:5413:a950%3]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 08:06:10 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Peter Chen <peter.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/6] arm64: dts: imx8mm-evk: fix missing PMIC's interrupt
 line pull-up
Thread-Topic: [PATCH 3/6] arm64: dts: imx8mm-evk: fix missing PMIC's interrupt
 line pull-up
Thread-Index: AQHWlO+orzxSy6wcu0yvbSG+niNqx6l9sYXg
Date:   Mon, 28 Sep 2020 08:06:10 +0000
Message-ID: <VE1PR04MB6638D590D325B4CEABB4806B89350@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20200927165947.7317-1-krzk@kernel.org>
 <20200927165947.7317-3-krzk@kernel.org>
In-Reply-To: <20200927165947.7317-3-krzk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74f8c27d-6807-4772-c4fd-08d863855c51
x-ms-traffictypediagnostic: VI1PR04MB4815:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB4815FD12F25AA5488186059989350@VI1PR04MB4815.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwoq93MEl1wSWGxcO2WhuBtBjSW1gMjXwkm4oiAaGdgUaeDNIGlvP+MFpCvTi04fw9BLvs4mO/wtHK1LByrHTVZbE0UxIsBFnz4pJ/XwYyBRPG0Ehvk5pd6QZtwXCZDZacdK0RNBzW21xF7bpZPKjWr0amRWg4CfrR7Qt4cbsxigbBUBg3V+eW5qb36k0+3wOvvb/qJnLTVXZ2/wLqU80OFqOnck7oO9o+TM1dAGdx0yLRYytACv8Ny1T5ZHkQIE6B1VV02xPx0q8B9rRkfIP0fmEZdZj/cPBz7Vvd4tvRbIeUtkZCYKcRb77VW3WwRDkKV9EuwTkpmzUNN7E9ujHTpwHH/mtPgTyjy5U2Yxfj8hGi3AYcAZtQufWDFr3OpQvy8E4V+20dJEk1m8H0/YFGTJCO85C54FCSBckePIu4AOROEFw/EmVGTNdIa3xlrN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(6506007)(53546011)(478600001)(86362001)(110136005)(7696005)(186003)(33656002)(26005)(7416002)(8676002)(9686003)(2906002)(8936002)(66946007)(76116006)(71200400001)(316002)(66446008)(64756008)(66556008)(66476007)(5660300002)(55016002)(52536014)(32563001)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: e9i6rTGWFvCvClMgkm4wC944TmD+60qCnf/krYddEdUVpUOOcvzKOnZ7FvFSIVKE7Tt1V3kFr3NEQEXgX01utP7WG3o82JawVJcsVAj7BwTH9LWXTM6BtmeU/zt92kQGMH6Jx9nNDVO9tfhz0KJCSR1qlQR84Wb21gGvwsVG0JTnm0hsuL570xBNa2b6rCy5B3Y+xcg2JYYXtVEwRnQgEo6rsRuONyudGXvVZx2tTWCWr6TK14WR6uhVI295gELSf06Q1PdK3PrYzjFXTtKTEaFvo6dXnA2Q1SaCMj2kXtOI+BJH+UffRI0NmkC1u7I6cMLXYS7T4ZcQitsCy0KPDldvawJV6nJnLbnjhRz4j70hsEPyeOzxslIYY85y2xA03iThnvRa5z+5qOykoOutIQwSRKO6My3zQFVKvqb05FKPgrFOpX8fZlTnOXpYl5hLcauwLISNoSbzQx3sw9MrtDUeYjzS8TOoQ5TtA83m2CCpiNN7RENxB83VugL8Pqp/1NWVj1wdfOvc79sx8YxCOULsMvTgMJzPp/kR26kS1AV/Ubh1uPVhOJmsABD3Hm3E9Vxq8JsvW7qH2Zd+2q9+C+G7sggHa3hEOmsMucH5zne9dzIMyDcJi7392iAOKtmVsQdgMQdi5GMaAhIS8GVygA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74f8c27d-6807-4772-c4fd-08d863855c51
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 08:06:10.2388
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GRK3uxwHEUALaLJAgrnG7Sd/ix8AYxV9bBzhQVC1Hg1X9jybwAyX3QKgTsQnAAWY0SDAMCekGMh7CgxQlHq9Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4815
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/09/28 1:00 Krzysztof Kozlowski <krzk@kernel.org> wrote:
> The PMIC's interrupt is level low and should be pulled up.  The PMIC's de=
vice
> node had pinctrl-0 property but it lacked pinctrl-names which is required=
 to
> apply the pin configuration.
>=20
> Fixes: 5f67317bd967 ("arm64: dts: imx8mm: correct interrupt flags")
> Fixes: aa71d0648318 ("arm64: dts: imx8mm: Split the imx8mm evk board dts
> to a common dtsi")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Please tag me with the whole patch set, thanks.
Reviewed-by: Robin Gong <yibin.gong@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> index f305a530ff6f..521eb3a5a12e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
> @@ -121,6 +121,7 @@
>  	pmic@4b {
>  		compatible =3D "rohm,bd71847";
>  		reg =3D <0x4b>;
> +		pinctrl-names =3D "default";
>  		pinctrl-0 =3D <&pinctrl_pmic>;
>  		interrupt-parent =3D <&gpio1>;
>  		interrupts =3D <3 IRQ_TYPE_LEVEL_LOW>;
> --
> 2.17.1

