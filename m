Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA62E044C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 03:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgLVCPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 21:15:35 -0500
Received: from mail-db8eur05on2057.outbound.protection.outlook.com ([40.107.20.57]:64545
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725869AbgLVCPe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 21:15:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEfILTdqVTabYs9GRcIM+5BU4/Rpow80uML6zlP7+gKZ/LSehAQ4Wy7NbWjrwZZrBqiqnJO6yqdkeIbnJX7bI2NiojOr62UTywca+Hh3UbnFefw1fEYS44OSiMagGle1FjQ92Vusc9GwNio7UeFYMHrV/3zPuPD/QaxWXuITTuIidV8VYEnX12J2k8vxLn70ZqFgx+Syv6/9M15qzPXh1QDQAt/OuU3k6s0QRIf5u/cKnYvZPf93WIRJcBi0r1Yv7hHxUJppL9hl5Qg9Osng8LBcgtQt+XPbxEvw4//umIE/kIcl1qFlFGMOYfbq/hzQ6f7op0mAsI9NxGZs1FvHdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3mm5epzfeFDHkpN2s4EzUVNzer0UK3r0IPUsi9QQT8=;
 b=Q1m2QJJyyeFhj3AhIaWewhfa/v9NPIvTTqFsxuy1pBc6SsJjAso+fs6YU+QoAgfHN8k0GnoAOrnq4xI3A/EpAZH8yQhAGm2mi1dS0FZVSMbBORbUGx7oi/sMP0YNxhHtfEEhh7UrXDBODmxxjAdPSG8Uv6K5eu5fGnpBC2QVJtpfRK5MCF6VRlKDCOh0gHiVCoq5lGjkZln7NzGQTdK637YP/w9ZzcO0m+LHoY24F9UUhYMRhc48+LuoONkGMHD2WVXKkK+EASCHqr28PiregurdDEj1Atg4t7xgM59Rw6lzoHbG/lklu4mXEmo2Y/f65pJOIwfG1rNvfWZWxz6ZPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3mm5epzfeFDHkpN2s4EzUVNzer0UK3r0IPUsi9QQT8=;
 b=REd9XoQbH1yTZhr45eZsd7Fzh36Z82SS49rwoP14YJAhOAZvL6NlVc8N88rbAV91Z6eBfmApucaP8eSmgeyAPOhwGsskOE07Al2IYn+4QjbkHAh3umPlWx5Z+MCwn3gvdaDbnQ4jYecE3HdNnXOC2ZoREtoZCqtGZelWfHGbsrA=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB5802.eurprd04.prod.outlook.com (2603:10a6:10:a4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.25; Tue, 22 Dec
 2020 02:14:45 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3676.033; Tue, 22 Dec 2020
 02:14:45 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: host: xhci-plat: fix support for XHCI_SKIP_PHY_INIT
 quirk
Thread-Topic: [PATCH] usb: host: xhci-plat: fix support for XHCI_SKIP_PHY_INIT
 quirk
Thread-Index: AQHW16tInodopkLEv0Oy1XwtiA3jeaoCYPUA
Date:   Tue, 22 Dec 2020 02:14:45 +0000
Message-ID: <20201222021416.GB4706@b29397-desktop>
References: <20201221150903.26630-1-pali@kernel.org>
In-Reply-To: <20201221150903.26630-1-pali@kernel.org>
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
x-ms-office365-filtering-correlation-id: cc196fa4-e8e9-4986-8d45-08d8a61f5a17
x-ms-traffictypediagnostic: DB8PR04MB5802:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB58022CBA9DA6EFFC5F22EC0B8BDF0@DB8PR04MB5802.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DiPxCBA+MPOaRZ4QAnUIt0tcavHs5HmGVE8XYGDue0EmYLzYGXqL1+Xc70NeWIs+7MVULtjs6Eg5R1oizrzA01wsFnuik5VSiVt6MwUPwLBHs/dI0LTcVQIpAV4URFkE2KX0hza8++FBZmOAOf256Yrdm0v7clurN01zkGGNmFeStNRRFNGfzo7zaLws65iOYEK/C7cDasbSDH22VfcW/tiSIDs5Kpz4Vxz9fmsJtRxunQHvVs7yTqmSoM0pgMC/41M4/syv0E1FAj3Epo96HX5r8JID7fFJO9Ar6ocoWD+zLFr8Yj3Wr9TpdXWwhSAm36WME354MJljiB0bQJZt8M7A164cAm4lONAu8E0oRbHBTzgcYZ5I2Gl8xg4mupymkXCLstw64Jh/jxFNXW0I2w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(2906002)(91956017)(76116006)(9686003)(64756008)(66476007)(83380400001)(66556008)(66446008)(8676002)(66946007)(5660300002)(8936002)(33656002)(26005)(1076003)(6486002)(44832011)(478600001)(6506007)(53546011)(6916009)(4326008)(33716001)(86362001)(186003)(54906003)(71200400001)(316002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?QOiUBrDK7JglslmOQcxBn+BBKlhzsZtlAmifQX/U6S4jauC2garpu28sr+?=
 =?iso-8859-1?Q?nc/edb11XbF0Lw2qV/IGWMrXvD04ARJvCBwjWV2JRXciAYqePXyub7XTNY?=
 =?iso-8859-1?Q?diqWLK9oRnD0J8d2Y11lbh3AUYppLMEcqVgjqTra+V4GUEurJ2hr6yJCKI?=
 =?iso-8859-1?Q?3JbfMxpessnytC1c5LCC4iazpFOwW72+tMlztfvIdQWJxqulGlZJlJx7x6?=
 =?iso-8859-1?Q?I2Drmez9lEJUG6DXM5D6s5N9P6g3Zb0a6PeoDB5pY497iva56npRbG3NQL?=
 =?iso-8859-1?Q?3xKRCW1zd/y1BkJH16s8QwvywcgSs4W5bQzBQdxRJuemIHI1CCIl72hV2Z?=
 =?iso-8859-1?Q?7j0yVpfI33Jl7mLMo01YS3mxiKOperxKcoAMW4ECw+hiCgComz7hjG+PuM?=
 =?iso-8859-1?Q?062dYdsY5XVskBl1f21A1p6/LQYQkrKGdYGRATXQEtz4lg04KPAmkoC+x6?=
 =?iso-8859-1?Q?eanne/kaIM8bj6ehZS/D+eeArqWOMfp3+4Ov+AgkW1B+BArG0SI5KGqoj2?=
 =?iso-8859-1?Q?W4L4UeF8Qjmf0hE+htwvQCYjYR3geOouDzKuhfxlXOw0dGTD7u2ghWsrVK?=
 =?iso-8859-1?Q?sn50KRTgRmZdEwscHZ1n33v4BfJgmr7VXq8vLQHs9uh4aw9xEj6ZsfdG/A?=
 =?iso-8859-1?Q?TKYQd5e32evv48rgRyDM9++nHS01UQTqF6Fs/mjxzxeCVW2YWNakX5dmHt?=
 =?iso-8859-1?Q?izg40GVbf+J1UXMGX3Jv2ZOzpQ1S0v2SVOOgZ1ljedvcWRgmqQ9TYr8pe1?=
 =?iso-8859-1?Q?MhperGAyc5Ku0V2sCw84DjNkDyhkLuQ7/AzMUCgPWy0/ZT2T+yxr4eEloQ?=
 =?iso-8859-1?Q?kK/k1Tmh0mXnnkRRVPOUTmxN0S2fjo5NtOY28+60lDX+JAV6Aqfso66Gp0?=
 =?iso-8859-1?Q?sujeAB4mwAPihLQTDalhS6HC8F7sTu8pRD+A7N5GM29/hZLE5cj6H5IQqo?=
 =?iso-8859-1?Q?MurRQOPMoFjrQWHEW2/kEwFLvY/SAO02mnTOzZyNawuqPG0hQRHDuC0O9Q?=
 =?iso-8859-1?Q?GmQqRz/LsbeFvFjyXuK9SgCL1Q6LKJSEsbZdsa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <64D545FCBDE45745A1C8ED47C41C2BEE@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc196fa4-e8e9-4986-8d45-08d8a61f5a17
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2020 02:14:45.7798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4LVq3bGaMQCV5+GyO5akn8BHyZqSe8ikUZeoUdYw0OHk/E37DpSalWh3ZWbMi8YXCsdt5iLkf6fOn0qcEB6huA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5802
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-21 16:09:03, Pali Roh=E1r wrote:
> Currently init_quirk callbacks for xhci platform drivers are called
> xhci_plat_setup() function which is called after chip reset completes.
> It happens in the middle of the usb_add_hcd() function.
>=20
> But XHCI_SKIP_PHY_INIT quirk is checked in the xhci_plat_probe() function
> prior calling usb_add_hcd() function. Therefore this XHCI_SKIP_PHY_INIT
> currently does nothing as prior xhci_plat_setup() it is not set.
>=20
> Quirk XHCI_SKIP_PHY_INIT is only setting hcd->skip_phy_initialization val=
ue
> which really needs to be set prior calling usb_add_hcd() as this function
> at its beginning skips PHY init if this member is set.
>=20
> This patch fixes implementation of the XHCI_SKIP_PHY_INIT quirk by callin=
g
> init_quirk callbacks (via xhci_priv_init_quirk()) prior checking if
> XHCI_SKIP_PHY_INIT is set.
>=20
> Fixes: f768e718911e0 ("usb: host: xhci-plat: add priv quirk for skip PHY =
initialization")
> Signed-off-by: Pali Roh=E1r <pali@kernel.org>
> ---
>  drivers/usb/host/xhci-plat.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 4d34f6005381..58704c5b002b 100644
> --- a/drivers/usb/host/xhci-plat.c
> +++ b/drivers/usb/host/xhci-plat.c
> @@ -89,13 +89,6 @@ static void xhci_plat_quirks(struct device *dev, struc=
t xhci_hcd *xhci)
>  /* called during probe() after chip reset completes */
>  static int xhci_plat_setup(struct usb_hcd *hcd)
>  {
> -	int ret;
> -
> -
> -	ret =3D xhci_priv_init_quirk(hcd);
> -	if (ret)
> -		return ret;
> -
>  	return xhci_gen_setup(hcd, xhci_plat_quirks);
>  }
> =20
> @@ -330,6 +323,13 @@ static int xhci_plat_probe(struct platform_device *p=
dev)
> =20
>  	hcd->tpl_support =3D of_usb_host_tpl_support(sysdev->of_node);
>  	xhci->shared_hcd->tpl_support =3D hcd->tpl_support;
> +
> +	if (priv) {
> +		ret =3D xhci_priv_init_quirk(hcd);
> +		if (ret)
> +			goto disable_usb_phy;
> +	}
> +
>  	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
>  		hcd->skip_phy_initialization =3D 1;
> =20

Hi Pali,

What's problem you have met? In structure xhci_plat_priv, the quirks are
defined at .quirks entry which is got at below code. .init_quirk is the
routine if special initializations are needed.

	if (pdev->dev.of_node)
		priv_match =3D of_device_get_match_data(&pdev->dev);
	else
		priv_match =3D dev_get_platdata(&pdev->dev);

	if (priv_match) {
		priv =3D hcd_to_xhci_priv(hcd);
		/* Just copy data for now */
		*priv =3D *priv_match;
	}
--=20

Thanks,
Peter Chen=
