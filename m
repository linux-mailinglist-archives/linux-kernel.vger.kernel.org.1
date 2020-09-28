Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9768427A4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 02:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1AHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 20:07:42 -0400
Received: from mail-eopbgr70080.outbound.protection.outlook.com ([40.107.7.80]:10048
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726316AbgI1AHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 20:07:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xq73/Aid18yC/hEosMImPFuK2Omx2k3aEChzf4NjimTePGFYhrGvl+VNLc1S70taOH9ZXtu1KnI+GeaG6PBB67QWxaqh2nPBC4l4B4GmZwpYCORP0NiUehabVRFDdPwft4Gybmi/5E0bxq8f2xaR58V7WFg6R5SnRmCplM1DlgS5hHhRCBKVKj2GyvFSdV+8V3Sl7psB3M+fRtQEvsZF1xy9fCvdyrjBPRSJZvacjzOkWNcqWQwsCqPbcD4iwvubiFp+AxC93iEZIkq23F57HnbNhY4mzZJuopP8LqzELnkaKBxGyJBTykoklV3OntI4hQR24BKGjD2L70vjIICv+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNVmnMRpm7Qw7zdViAEqtgKyh8BW3srWgkqaqSmp3XE=;
 b=ZEX8iBS5PKo9vRagWlD9tinCySbJAr2geC5CWB578CLxoRiMK9ul2Q9HWtd9B/tAOJ1iyo3bSB+4uVdlIIMfnRt4zjUyS7/4edI75tMGn5iosyLSW68EwCMFUAtBNwOtHR3sGxahhNCDMSZYqh9mT6BEJd9gcRbMvkQ0opqJEXzDOAy8uaERvMYVexDErzw3qkJIcVHI+a8d0rJzzbX9kp3NH/0rN9UyFUF35lmZ+8fWwaEoXWZQteSesLKYdEhXuqDpPxUsxpOQ+H9nhcZbmEu7STNTCu7UDf3M8csDukodxkgfux8EWUAaVcBuN1A2oiViLYPWuew4ySls0XMjgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNVmnMRpm7Qw7zdViAEqtgKyh8BW3srWgkqaqSmp3XE=;
 b=nqf4bhltDjQ63ipzgKdq2DUFWvs2BgItTL7rqgW7Df1eBKMrIVITdn4UQZOVG5A6Bb3JtY2uLvI/FvbiUaFuHtivHEpw4PG6M9NZM+0URAgoAn+FSeSAm4latZlfahJcuLakoCRtQrTLQ6THB8nzGGyuVquXCXn1K6f9BVaqZz4=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6998.eurprd04.prod.outlook.com (2603:10a6:20b:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.24; Mon, 28 Sep
 2020 00:07:37 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1023:be8d:40c:efe1%4]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 00:07:37 +0000
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
Subject: RE: [PATCH 3/6] arm64: dts: imx8mm-evk: fix missing PMIC's interrupt
 line pull-up
Thread-Topic: [PATCH 3/6] arm64: dts: imx8mm-evk: fix missing PMIC's interrupt
 line pull-up
Thread-Index: AQHWlO+olLRGKxT3ukeC1Wj5HHirsal9LGpA
Date:   Mon, 28 Sep 2020 00:07:37 +0000
Message-ID: <AM7PR04MB7157F7BD17F220BA783EB0078B350@AM7PR04MB7157.eurprd04.prod.outlook.com>
References: <20200927165947.7317-1-krzk@kernel.org>
 <20200927165947.7317-3-krzk@kernel.org>
In-Reply-To: <20200927165947.7317-3-krzk@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [180.164.158.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16f93fdb-1063-473b-394d-08d8634281f8
x-ms-traffictypediagnostic: AM7PR04MB6998:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR04MB69989A768D3D3A0A0C08F3108B350@AM7PR04MB6998.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 38rh1kU5ZImQ7ufGNFcgvE+e4aBucZw1IKwkve3a4EtfvtYIZ/EafPQode1wQov16/bTNnWOoWVo1GccMhFKzUm8NeWRG4igldhSgN8p7ryjFyXWOX72D9lS+NU8b99ef/3d6ji+9YOTQhBPVLiOe0HPSkd2xJZnx6ystH1iVGTZK5G5Mu6Ozb6FNE7bmv/WNY6KHPf4asblYTbX3J5/vP7WF6XJk6BgZdRpd7bBVIA+tg4PX65LpKhmzCcMkMaFe6KDxZr6MqtbJSMmR3dpJbFKFuUoYSN7orKnIDmET3Sw7hlzo+H2fBSzmcY5PW6dsY2v2Nt5dekbdYpYZUcfErqpMsyaqF8vraB30NEI3kRkXlYu7Xqns9QpujoTGJk9Pb9sdX1DaaRRQbiD7KVptDMVdMvVG7N00cAbeUgmuQ7NpOH1ZVgwTGlH2SPUWNJj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(366004)(7696005)(2906002)(52536014)(110136005)(66946007)(44832011)(8936002)(64756008)(66556008)(66446008)(8676002)(66476007)(33656002)(76116006)(316002)(478600001)(86362001)(71200400001)(6636002)(55016002)(7416002)(6506007)(26005)(9686003)(5660300002)(186003)(921003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: QNLkWJXWM1GMVt3q1NAsmXllFPN8Q6l512ow6cTS7shDfvjb/TZw3UiIkrwJI9MFjeu70wZJ7ipe97W3V1SxbDonNuu37YPst5mp+TsWNnlTbJf72YhDOz5oEBuXmt7Z5tjnuudXtmk9UZtPwVUHbJTuFC6ExHXHZXhSvq9rcv8YFKh2aJBYlLnxCgkS1VshhAekO/9MHwyXXdZnSj2Aw2cBOnVrRgDQn0Hs7rOe57rzXbSF3MgNJlui0IGQTQfiHS/3o30E+doy4LxdlS32iH++tRFHDzqPyZd/ZNJmu8VrtNSVJflDi71OILpbPAZH3VQ8UaKzVJ3Z3IfdmYBRQCgNDrG4kwuOlNCTuYJgKXflwGDY9c+Hpr57R96to97fvO4GSGBtPjZsoofEFMGIWyrmxxaYUuBV9VJwHH9U9+OpdSGKzFtTvQqrvpgZYty6HutGMvLnHiYIGHubw9CO9RPTkw3wJYdJa/i9Vztns9UzntP4GGyt5tFCBAF+IUvqR/JJ4l7rjdeOmT7nDqhSE107aLKGy5BnSpQJEI7z8B3ElVwrswbOykp41Wuvcj9hlrjQXLj8IgE5hM9h8lcsE5h1APvJzml6Xu8ZNJ/HfZY+aIpjWqju/dN1J8MiQNW9A0tTezZD5VIuNkSxeVL6fg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f93fdb-1063-473b-394d-08d8634281f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 00:07:37.0822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85hud88a8CjGcu+eZWsQsX7KcC+TDjblFvcS6KuHFZHfvvp0BHmZE43p2X5qJpiNIJXWkbq58WhT1hRRYn3oUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6998
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=20
Add Robin Gong.

> Subject: [PATCH 3/6] arm64: dts: imx8mm-evk: fix missing PMIC's interrupt=
 line
> pull-up
>=20
> The PMIC's interrupt is level low and should be pulled up.  The PMIC's de=
vice
> node had pinctrl-0 property but it lacked pinctrl-names which is required=
 to
> apply the pin configuration.
>=20
> Fixes: 5f67317bd967 ("arm64: dts: imx8mm: correct interrupt flags")
> Fixes: aa71d0648318 ("arm64: dts: imx8mm: Split the imx8mm evk board dts =
to
> a common dtsi")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
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

Peter
