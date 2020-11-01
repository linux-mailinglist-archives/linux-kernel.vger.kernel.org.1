Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFFA2A1F8B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 17:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgKAQcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 11:32:50 -0500
Received: from mail-eopbgr140073.outbound.protection.outlook.com ([40.107.14.73]:49922
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726790AbgKAQct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 11:32:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HwK8AchbyHnpi2lOx24C8F8peczXcfi1Rc1KXV7B2yUlZO3WGO1wtaLgQto3iXY1UeWpGKjNgQvJcq9k6r4JDD5NiNXGGwgRgABWHLAPXmXvTXCkdNAblBiNBe6duw5B8qe3SkE3Ih6dcV7AX9mAIW8tg0tHw1MMPrPylIBxlYuy1y/hjJXEVD9hMzDS/4deFsKJwk+Ct45JkBMVXYfBgz6g56lXbG3cOIQTtzQ9TXh6OvdSI+AiLS9YJOar0XucsfijhfZPnkURKko7HwNRkXeMoTdqLTXjJZOkleJoLcYByVkmt0wf/B0KUfe/ZAtshCYuCmMwkwPX09fynzfVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIjbsPf4FLVh5Eqwn4dTQIA/jY3rdrOy+fOUyvQJdk4=;
 b=VHolNQIDXchGyEGnW26YZUo53H3+FyoVdHPdZlKB7XBXeTN+515HPaBXJ8PZTC756NUmk2YMA2d261o6RVxjhcUM6IRFO15I5UZSyWH4NyjAZTH7ZQmR3lsDaimxfZVqKMNKTpIdqV9SAHhsYoQnxtMTpybrAYjWvCVJdOVdJw8wsRh4VLEclf8UIbh//cGAVs2oFUfj98aefVhSDBIneN22lDGiBArpu5fMVcccgtKclBsKTjdqlsKlBN+iJUgfLN/lIU2CituBEadOzIDoT2mJdIZVZGQiNJxia0pGAC9iXeuSdWgUwQf/YJLPpE6hlKVALrXOalvQNwvi4CjX7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIjbsPf4FLVh5Eqwn4dTQIA/jY3rdrOy+fOUyvQJdk4=;
 b=jj3P8WZT37lbxDzvGXuIqoZLcU6X26FR4sU606HdcJ5QbDr0xDJVxsolF8fhhX5xCC9m7LNcPy+oyod0ssspDm0c0Sr3ztXp2S2joX/LBlRi950T26IW3DevPY8oW/3ZR8COrYx68IhA7K4rPppDzUsZrNeDx0GRWfZqHSnOebk=
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com (2603:10a6:803:e7::13)
 by VI1PR0401MB2304.eurprd04.prod.outlook.com (2603:10a6:800:29::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Sun, 1 Nov
 2020 16:32:45 +0000
Received: from VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::983b:73a7:cc93:e63d]) by VI1PR04MB5696.eurprd04.prod.outlook.com
 ([fe80::983b:73a7:cc93:e63d%3]) with mapi id 15.20.3499.029; Sun, 1 Nov 2020
 16:32:44 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Michael Walle <michael@walle.cc>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH net] arm64: dts: fsl-ls1028a-kontron-sl28: specify in-band
 mode for ENETC
Thread-Topic: [PATCH net] arm64: dts: fsl-ls1028a-kontron-sl28: specify
 in-band mode for ENETC
Thread-Index: AQHWsFGeixGx/s/0HU6mwAEfgSmZwamzeJuA
Date:   Sun, 1 Nov 2020 16:32:44 +0000
Message-ID: <20201101163243.h5uc7snibqpprcap@skbuf>
References: <20201101131905.8316-1-michael@walle.cc>
In-Reply-To: <20201101131905.8316-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: walle.cc; dkim=none (message not signed)
 header.d=none;walle.cc; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [188.25.2.177]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2511183-e981-4e42-19f4-08d87e83c2c9
x-ms-traffictypediagnostic: VI1PR0401MB2304:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2304676A98D89D0CF4C8471DE0130@VI1PR0401MB2304.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x5EB1pcXuxDZmurIh2yLb+ClQkfDvUVChhoBuCooQ04gWuWXH8ziktfDh4RjhAZnkc1S7s15XzKL5qNyD7u/IXbIUUFHk2e8Pnwga5pm9q7YBcgG+2NnwCQQ/2JryQ+5+5G+OsiSxDI8Y92MqMvrRJH5QVDgniBaPH9MpvGuxYcjvPq3Dw+ZX51n0gJdQmERkNnrxw+OJXAcBAm7KAmwmeIRUoBGPSTcEmNYCI0zDRQIqX8jZeXoL4O2qwm8QP2O/camSJov/6rIuEOX1t6iAT1v/atAHyWE4PKPrvjmBUuC8RghVRgaidmx7pA6Qpmp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5696.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(376002)(346002)(366004)(136003)(39850400004)(4326008)(186003)(6506007)(478600001)(86362001)(1076003)(8936002)(316002)(8676002)(6486002)(26005)(5660300002)(71200400001)(76116006)(54906003)(66476007)(66446008)(64756008)(6916009)(66946007)(66556008)(2906002)(44832011)(6512007)(9686003)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GFtthDJEa/GjIXKHby/GelMa643EJzJzV2Pyt7/u8jU3pj1x6xobDedi6/UbkmnqEvy0LS1aFl759GercP1m+2Bmq5cJ2Xuu+JHgYdu2mMuan9qgDZLgR02qZWhaIhpdVBCIPMXJQENs78ASqwxw0O53wzv6uOtjZsDezQR+QmvoZNUcwX2j5lDTLyl0vi4ey/0m61DkaYxLcQFijbT7TChi1qVXTPJN9qWryqysV9MrLljMWTIRQzOF3bb/r9E3cQEf/f6v8L3TBPyfUmegqc3seVs+sV67KB6thNLKNm0hUbZHQJ8Nm3XG0gOTrh5IBZYvenprBHDhcc/lDivrT2/wcjD8Y0GOAe7yn6hJoBy34/C+dpkHANdIilcU3EaNg4k9cWj73cTJVS2ydQdf6vczh+jr/pkQ/jgZ7c8+kW57OlAiM3jb8U9ZWfeJeZiEn2Y09X70UGgqDySS8KfkTuuc+4g2K2A/QR9zDE1JK/fY8bK3Oi4aQad6gdLcTka9aRQEzCfdzfwJbz4pcwSRFmlpJvQ3xSiBeTbCT4XXkkHwy/2OfFEJxjbUnnas6UTdsbae4pJEd3uztiIvLWc8SZz+SDXXw4oU2BT2WRZN2TsitsqzPSTXhVHgfE7gW+bNN1SM4MnZj+Bah3fbtFDvig==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EBCB93F021094409765221236FF4208@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5696.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2511183-e981-4e42-19f4-08d87e83c2c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2020 16:32:44.5620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iujL9v4pDITYmOgxNC+BPbSeyaNVIuEPahRgsRiB3sXIfAYP7Abqd6uzHLaSP94x0NwNssXiLSOGi6cJFMT/Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2304
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 02:19:05PM +0100, Michael Walle wrote:
> Since commit 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX") the
> network port of the Kontron sl28 board is broken. After the migration to
> phylink the device tree has to specify the in-band-mode property. Add
> it.
>=20
> Fixes: 71b77a7a27a3 ("enetc: Migrate to PHYLINK and PCS_LYNX")
> Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

>  arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts b=
/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> index f46eb47cfa4d..8161dd237971 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts
> @@ -75,6 +75,7 @@
>  &enetc_port0 {
>  	phy-handle =3D <&phy0>;
>  	phy-connection-type =3D "sgmii";
> +	managed =3D "in-band-status";
>  	status =3D "okay";
> =20
>  	mdio {
> --=20
> 2.20.1
> =
