Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29A929E97F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgJ2KvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:51:13 -0400
Received: from mail-am6eur05on2067.outbound.protection.outlook.com ([40.107.22.67]:5984
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725774AbgJ2KvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZHDkp69MbVu+QyhUJ4wH37B0IL3USmujjHhbWQ4c+VZlSdwUT1Q5rXcoyrltslEjeuK5xX+4d33s0nO9cRSW0+2zaS4quRuSEa3N3abACHcW08V/XskzyCqfI8vr7narQeIHhBgltXEix4lFgBho6EavqFytG8RhnroQxhKig1AIXDP39hdeT1G+reYTC/B+0cNs2un6JTg1Ktn7P5OLA16EY2iweB0U0s5nZlT7JsBrrlgiERNn9Q+U2MCnMkoV7/IAGg2awk5KbjNhy+gkJsVRv38ou4nD2aqzYORzlSMcdyx3dinGaZKYg316R30b3Bdya6e1AXnqaaAIe3KMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sLca1kSh9kP+8B8dLWBPJUfWWxBAWS4aNKSoEWkzxo=;
 b=Ln0UonMF5Ue3wBTMiHPtfiRW9XSjOfmVVOIK/EZnXihhExQMw61qV7aNbLpmLTJ5uOeppE1CJVJRjpVblanSaj1r2WxhJuVjA8N42Hnt8D4mrTePWhTFKGPiQjpY501vislislGVh2Xx+hEej3rHPH4MX/pwEa+scAv0maKS3a1XB2wdGY2OlbykFi8IcKBd5uX3vr30aLMUQWozdGCyX9AhHeSali4/tSikz+BQbx0NuiLJvO287xOcHk48NXGli6NkxzZCxPluzaxMe2aUMwcKcjk6V71lPhJAt8LkCCMoUZ7UPKFzQK7bEe8PIleLFtATIfAS3hXGQ/wQ3TmHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sLca1kSh9kP+8B8dLWBPJUfWWxBAWS4aNKSoEWkzxo=;
 b=hcqG9GarKuRNyEiZ3IFm1VF6wAksqzDBhAmVdyZaoyYUEoyIqpEhgo8S1f6HOtdf3vmVcDdR0w+xSsD+Gi3sneZwvwBSvj4Ud9wXeO2BSQYPdZjfV0I7sgBOUpCLxOh0c42z7ugklG71OWpq1y/KqWOfORrOarTbDjxUaoNxZlE=
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12)
 by AM0PR04MB6849.eurprd04.prod.outlook.com (2603:10a6:208:181::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Thu, 29 Oct
 2020 10:51:08 +0000
Received: from AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2]) by AM8PR04MB7300.eurprd04.prod.outlook.com
 ([fe80::b902:6be0:622b:26c2%4]) with mapi id 15.20.3499.027; Thu, 29 Oct 2020
 10:51:08 +0000
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
Subject: Re: [PATCH 05/17] phy: freescale: convert to
 devm_platform_ioremap_resource
Thread-Topic: [PATCH 05/17] phy: freescale: convert to
 devm_platform_ioremap_resource
Thread-Index: AQHWrZ7+eyIXOPN/lEm5LqW1eUAhZKmuZ2+A
Date:   Thu, 29 Oct 2020 10:51:08 +0000
Message-ID: <20201029105039.GD30677@b29397-desktop>
References: <1603940079-8131-1-git-send-email-chunfeng.yun@mediatek.com>
 <1603940079-8131-5-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1603940079-8131-5-git-send-email-chunfeng.yun@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2a6c8b44-b161-47c0-7f26-08d87bf88ad1
x-ms-traffictypediagnostic: AM0PR04MB6849:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB68492438EB84BC0BC407CF208B140@AM0PR04MB6849.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:454;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MWSm5wH0cV4tNW8lyMQoKfhzu+9p9CGTyb9M3iuVa2/Ad3K8KuYJIPnRw/OLJaDg3YBKuB2d6v87g6Y4p3bt4vfi3dmzYuEQJE2H/S41KZaK9lNUw/eKiuvwa1KVczDfxWP9SBRgSPe4tTsx1sH9aPW2Bzms09c2Q8DxeZp8XRqCAxw0WxA9w+6DfXEucWx5LRgdRPgj1X/VMuGqP0H02gkrW+burAhoQTuNgw1D+sD9Jsf8ioXoCjlLthuo6fz07RZiEZNYqpFmC6+bdJFkUWI8f2IgAiSdGomvYREAmTEWMwjhXn9JuXb7OJYR9jtcoSgqtLxGuuSEbRHx+RuTWg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7300.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(346002)(396003)(376002)(136003)(39860400002)(366004)(66556008)(66476007)(1076003)(6486002)(316002)(64756008)(6512007)(83380400001)(4326008)(71200400001)(8936002)(9686003)(6916009)(76116006)(44832011)(91956017)(66946007)(66446008)(8676002)(5660300002)(7416002)(7406005)(2906002)(186003)(478600001)(6506007)(26005)(54906003)(33656002)(33716001)(86362001)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ToCoI16rgWH1HMqSJUKQ6tLvFZmltIbisBv0uAFf854oyVe24RIgoSsxlUbG5Zwqt4szIXs2SESn2jWPkBEOL0UXupoL/VU08QzB/m2r7JKXCdfPlu7VE/7q/jJ72IViTRgSA3bqdNf+esWJpNJeaf9wzdzT5jQlDxveZAPUr9QcHwnUpcr8vZoU49Zy4RWkQM6repXTGpFKqX+hTa+suNrJCxnsHjRmjlxvs/kFGawXyrrvt/z9sOOyHqE0ulOEa/0Qx1XzqkBfmXHmV0bE72heBqZUxON9qkJWUP62hzyJzi/fgHu4EDvuz2pEMPEFG6oW5rQ73lhVdQM0Nr6JOd6HoNPlvOTpuNPoyr98GG5JJKNOT6CXkhPkbTTFCopkwL95Fa/qKzN8tyLx1x6blOA+ACy6lXppOku9ul4H67lSjS1024sjewyo83X4Hnf2WvpDldDpR/NARHdfB2sjxMQdzeKr3cj4j8uIZ70G0yVd4nMi/wZ8RElVZq7n9IDKBQKhXhzXbCtBkLvITf9kKwZPg/inms2grEL/JGUhkBt8Vbdv5M+Kd4kKOq2wIhsB72duHgXnM5K0h7vor4sOuUc6f89oSdaXR2NGCJbUX+MFVPGHQ5oIH/qeygHNl4AZhTWMmKL3P7FfyrbBCbayeQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FCE28ECC80A9694B95AB18F74BAA4158@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7300.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6c8b44-b161-47c0-7f26-08d87bf88ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2020 10:51:08.2941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fvA03lufXxSIAYn2xFHeAHJtDlBNmq6sNmOV98KpPyrC66J+JSsE34WXjq5sGnfXIAGAEUhgHp0jmyc/+j1M0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-29 10:54:27, Chunfeng Yun wrote:
> Use devm_platform_ioremap_resource to simplify code
>=20
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c | 4 +---
>  drivers/phy/freescale/phy-fsl-imx8mq-usb.c     | 4 +---
>  2 files changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c b/drivers/phy=
/freescale/phy-fsl-imx8-mipi-dphy.c
> index 9f2c1da14f5a..a95572b397ca 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8-mipi-dphy.c
> @@ -434,7 +434,6 @@ static int mixel_dphy_probe(struct platform_device *p=
dev)
>  	struct device_node *np =3D dev->of_node;
>  	struct phy_provider *phy_provider;
>  	struct mixel_dphy_priv *priv;
> -	struct resource *res;
>  	struct phy *phy;
>  	void __iomem *base;
> =20
> @@ -449,8 +448,7 @@ static int mixel_dphy_probe(struct platform_device *p=
dev)
>  	if (!priv->devdata)
>  		return -EINVAL;
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	base =3D devm_ioremap_resource(dev, res);
> +	base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
> =20
> diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/fre=
escale/phy-fsl-imx8mq-usb.c
> index 62d6d6849ad6..0b9ee2b1716f 100644
> --- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> +++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
> @@ -152,7 +152,6 @@ static int imx8mq_usb_phy_probe(struct platform_devic=
e *pdev)
>  	struct phy_provider *phy_provider;
>  	struct device *dev =3D &pdev->dev;
>  	struct imx8mq_usb_phy *imx_phy;
> -	struct resource *res;
>  	const struct phy_ops *phy_ops;
> =20
>  	imx_phy =3D devm_kzalloc(dev, sizeof(*imx_phy), GFP_KERNEL);
> @@ -165,8 +164,7 @@ static int imx8mq_usb_phy_probe(struct platform_devic=
e *pdev)
>  		return PTR_ERR(imx_phy->clk);
>  	}
> =20
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	imx_phy->base =3D devm_ioremap_resource(dev, res);
> +	imx_phy->base =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(imx_phy->base))
>  		return PTR_ERR(imx_phy->base);
> =20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
