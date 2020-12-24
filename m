Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162292E2482
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 07:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgLXFzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 00:55:45 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:31068
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbgLXFzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 00:55:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgQl2JmODta+jb0dkMQCB2jsg7N6V14dh+KZGamwnW7qcOF0/TeaayJmKFHj0Y4Mg94AoDrlYQ8HAaKfBzi525Iixe4yVg3s6fLGqduLT54U/Ft2k6HS6p4g0DSFCdu29sfUlMAyAEaXwROntk6c7JJlTdsjiVSL0adzUmvtFgGIG6wkEwwPRBWC0ukU1Xto6mKAoWREModx/YQqPd6PPi0Qif+EeWKYHhqrkfq1rWC8GKLrFi71sdnT+iqHiwBJzKdf1mjJ9mWQ1uubyvV7MQEVEeGPRSheyndoXh5dscBKJ0IrfhVNFycolhToEXmJZl9QD3PDk1GgI4ZZdxNuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAFj1xrANRdC4MLkSHuPklJtPhzLFNdWpw8z41OzMSQ=;
 b=j8jkIT4w3Cj1Q31UTYf/U5JmPnr/NfQbEx0ryptRkdI7GRSnEWe+zayR5+UzRCnPxH+z7yfRFvdtNQRQ7y7MqGAf25r5E0wFDKNf+aS+ZfwcAjAcqOhvt+A20zPj7tx587BEzVmDeAE0fMh9HTByg0LIlEj5swzZH2NTbFxlf0Dftot1bY3WdMAPRw7PAnzm9Yrk9kTOg1veYcsJiWF36KI5BI9OWoKyPYfaBFWD0dM/a53ynVxS39EhxB9AII/bJjGpDDfWyBO3IjizzTiB/NgJGFxp2YdNITKndCbjVsIigGxOI15C36pSTSpAlKCqbxUeLPBedLH1P7nAImUUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAFj1xrANRdC4MLkSHuPklJtPhzLFNdWpw8z41OzMSQ=;
 b=fHmxe+P3UMyUkvwggZ8w5j9h7nTRISGtLaLmWE4ZNdAQSU5qGv5YeFAuMCGMiVZpFu/8IO+2UrLeFyT4L0tqXiXl/jRd/qnxO4+1C24CQv+kez6UcIY8+EptsB9pDo1ST5I+oZffyGxcLtbEtGXgtf9Lj/pbHVB4e+DJ+L8bOMg=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.29; Thu, 24 Dec
 2020 05:54:55 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3676.033; Thu, 24 Dec 2020
 05:54:55 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Thread-Topic: [PATCH] usb: host: xhci: mvebu: make USB 3.0 PHY optional for
 Armada 3720
Thread-Index: AQHW2UgQyk5+oV5VRE2UEkoGEW5gpKoFv+eA
Date:   Thu, 24 Dec 2020 05:54:55 +0000
Message-ID: <20201224055425.GA27629@b29397-desktop>
References: <20201223162403.10897-1-pali@kernel.org>
In-Reply-To: <20201223162403.10897-1-pali@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ec73829-89d2-4ca3-4b05-08d8a7d07092
x-ms-traffictypediagnostic: DBBPR04MB7979:
x-microsoft-antispam-prvs: <DBBPR04MB797973C44A150506CD4D26958BDD0@DBBPR04MB7979.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 35e1n5EmkYRTPheKFrEIgEfGCTIp8I4IeJfLlR7Ab/NEJNV2I0obsujEc1YrOIp6sCwoZZF09rg6BuLP0JV4JjF/fSufowRz0iWGuZlRlE8sk95GZbKglc6SL65dwnnD1D6GGqpsD8qOzWXEdQO6ZPp+z2pbxVbUNmhJcSUMASOMXgkBlI0Le8utXjbqUTf96Y6Io3OvV1d7QY0UWA2P/5mnhnLNWqzSZdftqOAvbD4+Orr9ks9fRajzI07jpHy8wndcooqoyocYNtj5rtyV9ciiSXRF9PdsiXLBlHdabSzx6yHYT6dTVsUGFMbvDaCtaeExxsS7yoT+/MwOuzri/QZsgr6J8SMvJ4rryWYEJgVimAWen6O8Olf5Jj414Ygm2bo3QSukWKrH/6AT5laC0Ec5/F2EszR06mbC0L96qKYp252aDAajrpRSAAyLXgMHvH7uc5tavGBIE5J/L7k9JA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(54906003)(316002)(66476007)(6512007)(186003)(66946007)(53546011)(33656002)(6916009)(76116006)(44832011)(66446008)(6506007)(26005)(66556008)(6486002)(4326008)(5660300002)(2906002)(1076003)(9686003)(8676002)(8936002)(86362001)(478600001)(71200400001)(64756008)(966005)(91956017)(83380400001)(45080400002)(66574015)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?VDkLWg1S7R1hmWv+IywHolWNFrXJz9Th2XVQVfHKj043mDDiR7ma5X5g29?=
 =?iso-8859-1?Q?fFtyCNVXeEGmykcOPabT/7Er/gEGLgktfTPAyntjrrnRv/dTwDuh+a98J3?=
 =?iso-8859-1?Q?cLAWMkCzSbxXWSehCK9D0C8T8QqFzVlOySWB9G9GCooWSxOkbf9XbXr9kJ?=
 =?iso-8859-1?Q?ma5ftaUyEwcOd3HnE5bxg8aYBwUaK0caBho5hrt7IMBIKLU0oetpkvRvYJ?=
 =?iso-8859-1?Q?vBRVPJ15gcwMaPSX6EJCXAV5zOQqurTG+3HJ7ZBGSFpepCD35j7NhmN37H?=
 =?iso-8859-1?Q?CWELjLjw1aR1BuJQ6cYolbcZIWLXoqGCHAoPZPN0CdQwkWK78huaRVXVKe?=
 =?iso-8859-1?Q?reGmYFFD/BknfDHMK+KOFMtOXTO6wpalxZu7WBl/T+FOoXuYPLPLLIraem?=
 =?iso-8859-1?Q?ptb5qforpdZ2vYIAruUTmedG1qKqJEZKpJFcGx4P+NFznxIPuYNrCQMjPp?=
 =?iso-8859-1?Q?YTCiH5Ji2Y75Eyt4DC9A5lC1Y9pYCvrBr/hVw68OMsznN8tVgSxfmnTf8J?=
 =?iso-8859-1?Q?5djPbOqfIkmOXRy4X/Pmg6Mz/4kVvmBy9IzDHnDLNY7OsDQ3emm/PYgP3m?=
 =?iso-8859-1?Q?kgUddFeynTcUxQN0/WOyyCWjMhz0gtIMln2uopXArzmRY7dPCarlxirJA9?=
 =?iso-8859-1?Q?KeiZx+er2sVFvrCrLPRJgY/ESV0naDVVUM5Eiiou0XTteRTXL8fv6SF93w?=
 =?iso-8859-1?Q?EbQtQ1jkAweCP+MmW60gu6PfA/SQH3K1zv09AmTkCWo4+qTPFzRrFrZ1cv?=
 =?iso-8859-1?Q?kHhA4wnpdgNtbhSr3DbVINGI38/SRBvmuoFRVLCgBWPi2BFyc2+SuB16f+?=
 =?iso-8859-1?Q?PjDZm3A0eI9A9E11HsE/djX20bZA2B9tlDA/+163/qAWhdPKqI4y+WxWG7?=
 =?iso-8859-1?Q?943PNh/AU3Q7NyRU2Aw75hBnkAlGIKPhMUABvG0/2qt5KntFpqOffvemnW?=
 =?iso-8859-1?Q?WIUiabh3n53KbveBeOND/z0EAIBRpW31vQWw/2tM84Xl7uwC3y2FDnUjzv?=
 =?iso-8859-1?Q?aSCQRuZACs3V4BjO8zD6uboy/MWKEXSyD25f7/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <A34E83DFA7C59E4494DD727FB07AD7E2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec73829-89d2-4ca3-4b05-08d8a7d07092
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2020 05:54:55.5292
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: su2pi358LCXst36j8qg9lIr/5VryMZyJ1TrZQi2g5vE2ckEBZ2bqZtZdVqE3xjSy3jPtal6+P1Mc+U9Kt6gjBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7979
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-23 17:24:03, Pali Roh=E1r wrote:
> Older ATF does not provide SMC call for USB 3.0 phy power on functionalit=
y
> and therefore initialization of xhci-hcd is failing when older version of
> ATF is used. In this case phy_power_on() function returns -EOPNOTSUPP.
>=20
> [    3.108467] mvebu-a3700-comphy d0018300.phy: unsupported SMC call, try=
 updating your firmware
> [    3.117250] phy phy-d0018300.phy.0: phy poweron failed --> -95
> [    3.123465] xhci-hcd: probe of d0058000.usb failed with error -95
>=20
> This patch calls phy_power_on() in xhci_mvebu_a3700_init_quirk() function
> and in case it returns -EOPNOTSUPP then XHCI_SKIP_PHY_INIT quirk is set t=
o
> instruct xhci-plat to skip PHY initialization.
>=20
> This patch fixes above failure by ignoring 'not supported' error in
> aardvark driver. In this case it is expected that phy is already power on=
.
>=20
> It fixes initialization of xhci-hcd on Espressobin boards where is older
> Marvell's Arm Trusted Firmware without SMC call for USB 3.0 phy power.
>=20
> This is regression introduced in commit bd3d25b07342 ("arm64: dts: marvel=
l:
> armada-37xx: link USB hosts with their PHYs") where USB 3.0 phy was defin=
ed
> and therefore xhci-hcd on Espressobin with older ATF started failing.
>=20
> Fixes: bd3d25b07342 ("arm64: dts: marvell: armada-37xx: link USB hosts wi=
th their PHYs")
> Signed-off-by: Pali Roh=E1r <pali@kernel.org>
> Cc: <stable@vger.kernel.org> # 5.1+: ea17a0f153af: phy: marvell: comphy: =
Convert internal SMCC firmware return codes to errno
> Cc: <stable@vger.kernel.org> # 5.1+: f768e718911e: usb: host: xhci-plat: =
add priv quirk for skip PHY initialization
>=20
> ---
>=20
> When applying this patch, please include additional line
>=20
> Cc: <stable@vger.kernel.org> # 5.1+: <COMMIT_ID>: usb: host: xhci-plat: f=
ix support for XHCI_SKIP_PHY_INIT quirk
>=20
> with correct COMMIT_ID of mentioned patch which is available in the threa=
d:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flore.=
kernel.org%2Flkml%2F20201221150903.26630-1-pali%40kernel.org%2FT%2F%23u&amp=
;data=3D04%7C01%7Cpeter.chen%40nxp.com%7Ccc158fcd30104268b27008d8a75f32e1%7=
C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637443374600182963%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C1000&amp;sdata=3DvjuJxi9Kg1C7ZHJLB7rsct0kr93JSo4aYkitFubkLao%3D&amp;r=
eserved=3D0
>=20
> As mentioned patch is required for change in this patch to work. Above
> mentioned patch is prerequisite for this patch and therefore needs to be
> reviewed and applied prior this patch.
>=20
> Note that same issue as in this USB 3.0 PHY patch was already resolved an=
d
> applied also for SATA PHY and PCIe PHY on A3720 SOC in following commits:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommi=
t%2F%3Fid%3D45aefe3d2251e4e229d7662052739f96ad1d08d9&amp;data=3D04%7C01%7Cp=
eter.chen%40nxp.com%7Ccc158fcd30104268b27008d8a75f32e1%7C686ea1d3bc2b4c6fa9=
2cd99c5c301635%7C0%7C0%7C637443374600182963%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D%2FIULc1sakzNVWjbVPA2TRYZAMv72DGOhmYv4NGijrT8%3D&amp;reserved=3D0
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Fcommi=
t%2F%3Fid%3Db0c6ae0f8948a2be6bf4e8b4bbab9ca1343289b6&amp;data=3D04%7C01%7Cp=
eter.chen%40nxp.com%7Ccc158fcd30104268b27008d8a75f32e1%7C686ea1d3bc2b4c6fa9=
2cd99c5c301635%7C0%7C0%7C637443374600182963%7CUnknown%7CTWFpbGZsb3d8eyJWIjo=
iMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdat=
a=3D2mLHMBc9lgpB4BCrlJYBfO7OJk%2BCi%2Bq3AgpxJxfiCSU%3D&amp;reserved=3D0
>=20
> And these commits were also backported to stable kernel versions (where
> were affected commits which broke drivers initialization).
> ---
>  drivers/usb/host/xhci-mvebu.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/drivers/usb/host/xhci-mvebu.c b/drivers/usb/host/xhci-mvebu.=
c
> index 60651a50770f..ec4f6d6e44cf 100644
> --- a/drivers/usb/host/xhci-mvebu.c
> +++ b/drivers/usb/host/xhci-mvebu.c
> @@ -8,6 +8,7 @@
>  #include <linux/mbus.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> +#include <linux/phy/phy.h>
> =20
>  #include <linux/usb.h>
>  #include <linux/usb/hcd.h>
> @@ -77,9 +78,43 @@ int xhci_mvebu_mbus_init_quirk(struct usb_hcd *hcd)
>  int xhci_mvebu_a3700_init_quirk(struct usb_hcd *hcd)
>  {
>  	struct xhci_hcd	*xhci =3D hcd_to_xhci(hcd);
> +	struct device *dev =3D hcd->self.controller;
> +	struct phy *phy;
> +	int ret;
> =20
>  	/* Without reset on resume, the HC won't work at all */
>  	xhci->quirks |=3D XHCI_RESET_ON_RESUME;
> =20
> +	/* Old bindings miss the PHY handle */
> +	phy =3D of_phy_get(dev->of_node, "usb3-phy");
> +	if (IS_ERR(phy) && PTR_ERR(phy) =3D=3D -EPROBE_DEFER)
> +		return -EPROBE_DEFER;

Doesn't need to judge IS_ERR(phy).

> +	else if (IS_ERR(phy))
> +		goto phy_out;
> +
> +	ret =3D phy_init(phy);
> +	if (ret)
> +		goto phy_put;
> +
> +	ret =3D phy_set_mode(phy, PHY_MODE_USB_HOST_SS);
> +	if (ret)
> +		goto phy_exit;
> +
> +	ret =3D phy_power_on(phy);
> +	if (ret =3D=3D -EOPNOTSUPP) {
> +		/* Skip initializatin of XHCI PHY when it is unsupported by firmware *=
/
> +		dev_warn(dev, "PHY unsupported by firmware\n");
> +		xhci->quirks |=3D XHCI_SKIP_PHY_INIT;
> +	}
> +	if (ret)
> +		goto phy_exit;
> +
> +	phy_power_off(phy);
> +phy_exit:
> +	phy_exit(phy);
> +phy_put:
> +	of_phy_put(phy);
> +phy_out:
> +

You do power on and off again only want to know if PHY has already powered =
at
ATF, right?

--=20

Thanks,
Peter Chen=
