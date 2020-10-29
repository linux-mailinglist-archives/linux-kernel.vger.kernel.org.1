Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB42729E97C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgJ2Kuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:50:39 -0400
Received: from mail-am6eur05on2077.outbound.protection.outlook.com ([40.107.22.77]:19630
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgJ2Kui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:50:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/aLlaAaWYbH9lHA70/BCfaFze/OvLPh1VBazy1FBE1F84seQ+ILSqDrBA7VVtXMvQzNQaS4xmitDFXQAUMyojmSvOSN7zmxfW8gxXe+RyTdWXk8yi/JBnz/leY92Xcq3Tlmvc1+ZvXSnw+vIBXe1HygEd6loqX+nMwBIfG/G3snQOiREvVmZdX/hW3pnX9y0O4jzcjz1KOEuAvL9dCJq7nADgVedr6oAaQ/c7JUmDgxBb/yhz5cefoXe0gs/bNQzK/za2hA77aiXiP9x8XhN0r8FdTU/mA/8310e9dUNc9XCJB7etpI2cEqf7b8uxrQv6OZMl/BnZudxV0VZkzZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5k577hyCvEzLfhKaSfulAryoBU4dcEdhD6Nt1r84Kw=;
 b=FMechsBQWXX7CAirN3eyLaGIkfRKZWt9BSL2fag9ecOEcUC7bNPbaZ+5fD7rXsBamg9O9pLYu2q12dBY1846E4+61C3z+JVgBb3ngx6hPiNy9ZbQUiW4KKwiGMsAL00SR7/kyYqp+mr4KGPkoq0RyvslQhgLoNtX8y/2AB1G9OP2Glcx1PhZcOEpu7ko0nKqqyNOGTfv1TTZq/B/FAFBTaaTxM0rbv8RDAqtCTWkYH16FN9mfWezFhM9ceYdNPxrk9CaiTv1zc/Ucj4Fun5FFOGaMzejItTjxOSXBIEzq+PcY8cNvxcf8sgIQvWIF5Vie65C28p3A334YJnv6hSBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5k577hyCvEzLfhKaSfulAryoBU4dcEdhD6Nt1r84Kw=;
 b=VBbueE3HDShwMokAl2AlRLUuR3prxF28P10KIKsjhwIGEZpWd8DAGu9ddbtwtpjP1jTn+NWu25+xf2GxbIMhU4WdOvbf/g1H/1GU6MDBQIszm0ROUvPSLkjsvgEdwndtDGcSCYjYJbGsiZjx/gkJAtlk7Y4hW5pkZXGqBW9GfNY=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR04MB6849.eurprd04.prod.outlook.com (2603:10a6:208:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 10:50:34 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2%4]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 10:50:34 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Ondrej Jirman <megous@megous.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Remi Pommarel <repk@triplefau.lt>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Yue Wang <yue.wang@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Joe Perches <joe@perches.com>,
        Bharat Gooty <bharat.gooty@broadcom.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Roger Quadros <rogerq@ti.com>, Jyri Sarha <jsarha@ti.com>,
        Sanket Parmar <sparmar@cadence.com>,
        Anil Varughese <aniljoy@cadence.com>, Jun Li <jun.li@nxp.com>,
        Ma Feng <mafeng.ma@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 04/17] phy: cadence: convert to
 devm_platform_ioremap_resource
Thread-Topic: [PATCH 04/17] phy: cadence: convert to
 devm_platform_ioremap_resource
Thread-Index: AQHWrZ79HoPsXManfEu7l56QIQ802qmuZ0eA
Date:   Thu, 29 Oct 2020 10:50:34 +0000
Message-ID: <20201029105004.GC30677@b29397-desktop>
References: <1603940079-8131-1-git-send-email-chunfeng.yun@mediatek.com>
 <1603940079-8131-4-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1603940079-8131-4-git-send-email-chunfeng.yun@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b65114c3-b56e-44b3-4bfb-08d87bf8768d
x-ms-traffictypediagnostic: AM0PR04MB6849:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB68495ABED848D2DB8EE102D98B140@AM0PR04MB6849.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vU5QJuFqZ1G+bNV/r86J3XMMK1VO5rn2Aklcq4JMIn7PASHwD1j+udCUvA7jDH6rL2agNO7+Zg0EeBHEvLYK/vyhZxzSBHnS1/tVd24zdryF1Ge6T1gqU9+BqDUs/XIei5Ih670qebx1gkndUo3Si89dLubI/ju5OS0W29VU5rcJkcGOt5ziQapNhZvvpX/rzmE6LqN5LnVVD6uGzK0tH9e1qbuglmYEy2b36QUTJXqFBalTyYkGShkJ9YFk/M2ZPMr8iQWxrzv9hQBHILI+fcVtV9JNYZRKzdriRkhbNXpwtal93v2XlXy0Lls7kwKUcpFwTKOK+MrKQzwSkiNO4Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(396003)(376002)(136003)(39860400002)(366004)(66556008)(66476007)(1076003)(6486002)(316002)(64756008)(6512007)(83380400001)(4326008)(71200400001)(8936002)(9686003)(6916009)(76116006)(44832011)(91956017)(66946007)(66446008)(8676002)(5660300002)(7416002)(7406005)(2906002)(186003)(478600001)(6506007)(26005)(54906003)(33656002)(33716001)(86362001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hTML+6E4FqEJLmz6tVZXlmZ4Gk/E4xerwj/YNQV/9LfqUspBpCk6KIWdBPE5JNuJuX00if48KGr5imLt/AZ51MwdbpyPCPjo9/HAaX1ppnQNpqH2mGGLn3Z21S/uEF5lDfiZCteXndZo06hvMlIe5UUQ6L1NtSBhtIp01d81ObDSf3eIV+KBSwMHMIDceOFJD8DfEUKY8anYhVAyv+Y0oCwXq+8JZEj96uD7+/QqFP9YRWkZAGMJe/tQaH0vBWYBjvuIEyrh4+wrtNG0nlZL3tu5q5qjc07R4EE2+TOxD9P8vjE0RL26I2NRHqbwG0Xu7BdIqNPnc7Msdqij7Xw0R4/MlgP6MOiZ+8tMV0FOwyppUGF4GCrcVJRVk9OY+8W10MBDeGVZ1ydC8gQPLQDy0nxx5L2a4aj/lpZTCG+YlAeiTtBd5ebguJhJ6HLwNHn/H8m3MaGYHNl2/U1t3rdGO372j3buYjY/V/xRx6u2VpQK+ZIftzkwdWui2QaWM1rY/tBwoVAcdTkOfkiM3wCnUlnDDdYsuApL9kZWq2BL6Mkn0Hb8py4c41rosnSjZD7oU+ekMznQbxUsPyODnRFGhfS7m72jMZebTebNKujTBmjdMkLjIoKlCUT1dzp/ANOpbET/6Y2jNZIzqM2NhMpVCA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E666853BC4238D4784104C8256E2F1AD@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65114c3-b56e-44b3-4bfb-08d87bf8768d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 10:50:34.3106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sej4EAnnGQLGZz+lWNl/3ubyGNRigeJ6d0R23DGvU5q3iUV5Jy1P8hNEWrGh9midwRSg2VnJ6s5qoqzoV4Ekhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-29 10:54:26, Chunfeng Yun wrote:
> Use devm_platform_ioremap_resource to simplify code
>=20
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/phy/cadence/cdns-dphy.c          | 4 +---
>  drivers/phy/cadence/phy-cadence-salvo.c  | 4 +---
>  drivers/phy/cadence/phy-cadence-sierra.c | 4 +---
>  3 files changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-d=
phy.c
> index 90c4e9b5aac8..ba042e39cfaf 100644
> --- a/drivers/phy/cadence/cdns-dphy.c
> +++ b/drivers/phy/cadence/cdns-dphy.c
> @@ -314,7 +314,6 @@ static int cdns_dphy_probe(struct platform_device *pd=
ev)
>  {
>  	struct phy_provider *phy_provider;
>  	struct cdns_dphy *dphy;
> -	struct resource *res;
>  	int ret;
> =20
>  	dphy =3D devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
> @@ -326,8 +325,7 @@ static int cdns_dphy_probe(struct platform_device *pd=
ev)
>  	if (!dphy->ops)
>  		return -EINVAL;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	dphy->regs =3D devm_ioremap_resource(&pdev->dev, res);
> +	dphy->regs =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(dphy->regs))
>  		return PTR_ERR(dphy->regs);
> =20
> diff --git a/drivers/phy/cadence/phy-cadence-salvo.c b/drivers/phy/cadenc=
e/phy-cadence-salvo.c
> index 88e239adc3b8..51c0b98f5fd7 100644
> --- a/drivers/phy/cadence/phy-cadence-salvo.c
> +++ b/drivers/phy/cadence/phy-cadence-salvo.c
> @@ -263,7 +263,6 @@ static int cdns_salvo_phy_probe(struct platform_devic=
e *pdev)
>  	struct phy_provider *phy_provider;
>  	struct device *dev =3D &pdev->dev;
>  	struct cdns_salvo_phy *salvo_phy;
> -	struct resource *res;
>  	const struct of_device_id *match;
>  	struct cdns_salvo_data *data;
> =20
> @@ -281,8 +280,7 @@ static int cdns_salvo_phy_probe(struct platform_devic=
e *pdev)
>  	if (IS_ERR(salvo_phy->clk))
>  		return PTR_ERR(salvo_phy->clk);
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	salvo_phy->base =3D devm_ioremap_resource(dev, res);
> +	salvo_phy->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(salvo_phy->base))
>  		return PTR_ERR(salvo_phy->base);
> =20
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/caden=
ce/phy-cadence-sierra.c
> index 453ef26fa1c7..26a0badabe38 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -479,7 +479,6 @@ static int cdns_sierra_phy_probe(struct platform_devi=
ce *pdev)
>  	const struct of_device_id *match;
>  	struct cdns_sierra_data *data;
>  	unsigned int id_value;
> -	struct resource *res;
>  	int i, ret, node =3D 0;
>  	void __iomem *base;
>  	struct clk *clk;
> @@ -502,8 +501,7 @@ static int cdns_sierra_phy_probe(struct platform_devi=
ce *pdev)
>  	sp->dev =3D dev;
>  	sp->init_data =3D data;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base =3D devm_ioremap_resource(dev, res);
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base)) {
>  		dev_err(dev, "missing \"reg\"\n");
>  		return PTR_ERR(base);
> --=20
> 2.18.0

Acked-by: Peter Chen <peter.chen@nxp.com> for phy-cadence-salvo.c.

--=20

Thanks,
Peter Chen=
