Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C252E2484
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 07:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgLXF7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 00:59:55 -0500
Received: from mail-am6eur05on2085.outbound.protection.outlook.com ([40.107.22.85]:4576
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbgLXF7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 00:59:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOZeg5A3TQNtgfutVSIEslU10gen3ehQlN6i6HPvfb1OuPxIf/JmRzwpIiyO392HG+7fyAZTIfwZIAHHyLr/ApjBDVdXhsWXdCVtQdffxRWDOYlnGHcU9RfxoKKsfvufs31Lbc1jHNRKfSeKz6cUOMVuib1P4F+C83X5Us0CQAJ9nIdSGcr0uiAV+qvitYccpTyl60Yzi2NR2TAcofojbCVL4HgpiSjXFJeCsZZLO0SKnttj4Vjh7Fil+Nfg/g+vAeISXBBsj1AMCQpreeB/NSaX8Raq1hV2coCiaobD2amX5G7DHruh/uzr5EEvRow9VcpgJlyJCJpmwhTFo6IGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7zY/OkGHBciTiYfx4QVVYEf3no2W8CrkvdROFK1Dzc=;
 b=CldPcbQ46nq/BZhU8TR9ak+GTIZ/X27nJW/jHnE1waHppem2vaUTRl/XGvX9+1q2r0TGgfnTBKtTICIAAcjoPjZIqHsT36HZjaJWWbGaXBc5TuEmaptVyaUDbxvnULaaVEkedK5XBvUEfToVvbo0Cz/qW+MenCfdp/bJqvkayGbXXiWy9RluC0fT9xld2crSENOn7aeKygZFKpg92obxv6+25rKGXBgZL12u0Fa2yY6zCS/JhunNB+Z9BNJOXBhtKUCx+2r7oDdw+vYfFiPeuCRbDAuHAewK7zjnDS7QT7kwfCZFVlVpdPPOxxDjNHadk1Wl8me/NwEdhL2TPWPHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7zY/OkGHBciTiYfx4QVVYEf3no2W8CrkvdROFK1Dzc=;
 b=hwmaTc0/xAhdo8nvbXtpF4JLNTdzHEPKPR/il7oSUpfntaNraVctV6nomnbZ9jHyEm5IJbZLzg94salA8QE9ohlLj3oU59OA5ZDW6WnGZ0MtIFE4AcPlaY87svNBk805F3Q12qN4Gy4iZuf0pjNe5B85YoeteWF2QXzLlIinTII=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB7PR04MB5241.eurprd04.prod.outlook.com (2603:10a6:10:1d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Thu, 24 Dec
 2020 05:59:05 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3676.033; Thu, 24 Dec 2020
 05:59:05 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] usb: host: xhci-plat: fix support for
 XHCI_SKIP_PHY_INIT quirk
Thread-Topic: [PATCH v2] usb: host: xhci-plat: fix support for
 XHCI_SKIP_PHY_INIT quirk
Thread-Index: AQHW2UdVBN3eWtZvM0+3FjfukhY+naoFwRQA
Date:   Thu, 24 Dec 2020 05:59:05 +0000
Message-ID: <20201224055836.GB27629@b29397-desktop>
References: <20201221150903.26630-1-pali@kernel.org>
 <20201223161847.10811-1-pali@kernel.org>
In-Reply-To: <20201223161847.10811-1-pali@kernel.org>
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
x-ms-office365-filtering-correlation-id: 545cb671-b09f-448b-6bd1-08d8a7d10549
x-ms-traffictypediagnostic: DB7PR04MB5241:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB524104E20FBC66D56838BD3A8BDD0@DB7PR04MB5241.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0w7y3uBMVuz28SzkPwjOvJ24sRp8mjriDq1jbBUerxcx+8P7NvpVO/bNUedmg43TagcSWEZcc/kf5iCKQkNMq4HoSvuZeY3ZyO37kSS39fRQ/Ln78CFVlDFC5pb3FJozIPNjPPylHk6UG5DOk/wcZJmB1iHRhVlXwEr5OvXbO4l6wm4PNITQkIY8py4/0V4KlgSzAhy91jGzRsVM1qwxTQzHASTx+Y8ArdhP+uBLP7kB6rpHkkJ/Ew2Atrbb+I9vkJlUCAN3nvv7iSX/n4oRU/UpPme1BJ7jFCQdYfdc4zFgIOIwEwY+J2d4hG+MmHNeJV7x3uG2QT33EG1fE35EZjuRXyxLrnjIlLDzSQOUBMc7XxbJvv2u3vj9P2kI144utqGTO1M0igSN/nj+bm3DMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(316002)(1076003)(8676002)(44832011)(186003)(6512007)(9686003)(54906003)(83380400001)(4326008)(6916009)(33656002)(2906002)(26005)(71200400001)(86362001)(8936002)(66476007)(6486002)(33716001)(6506007)(5660300002)(66556008)(478600001)(53546011)(66946007)(91956017)(76116006)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?+FUFkxEw6rbnQ1WJRddrQl2g9Z3J+8s74Jol0+Okm6nY/vS+qbepp5CPMe?=
 =?iso-8859-1?Q?ihvscp3NawnV8lssblKQIfhAcrTuAGYAw0X2bJCSwTHx7AxRgBUmajqpp9?=
 =?iso-8859-1?Q?AOJtQTwgCLuckratCSeavUdHvbtisqPvCU5+7xEV+KVPss47ooaZEMNQlf?=
 =?iso-8859-1?Q?mUchenQrufI/0AduqXImzaqXZvMDjKQL6u/omaNzaqkWdYFOwgAF+n/SIN?=
 =?iso-8859-1?Q?FATB3lTfW4QRBR48eO1CF49gKqt2cJcTQYXoObCn9EntYGfCjOLn/0XLpP?=
 =?iso-8859-1?Q?0IP0vcKRgSEMeqsZ4cpxqIJ6NpElKidzPJPJD3KghgsMZc5J+7bCGiNS6X?=
 =?iso-8859-1?Q?voPhKsHpnzdLfL5npTj3/ddUb7fJGK4NUiereZdEyMFBnjPptKMjz8f4mh?=
 =?iso-8859-1?Q?ILa1T0BnAnCf4bM2Q/haWRXG551373hupeJ4sQ7HJb2vadQhognvNAbtmW?=
 =?iso-8859-1?Q?WeDhD4okFPe49raIqFrCR9G0JLWpjNThPQW+/XuMSw6Zd6iABgDbbwKt/q?=
 =?iso-8859-1?Q?xemKov0NqgsLCdYk4yWITamd6PL4lciECA9E5XOdeTlgpA6TJvJWPok4Tx?=
 =?iso-8859-1?Q?9MkKW1mJcz1V+vDIFGQIXc9Kxy97YMIDbPMo4/155dsqS3c+DoO13ZUoOL?=
 =?iso-8859-1?Q?JeGRYvOtHctP+Br+cuw9HIg9eTPDvFE0+zMeS0qV/l+4yaSW7DyDl5aRs1?=
 =?iso-8859-1?Q?Fa6mTGVp3OGG+p5NJGpUtg6EdFNMDqpmogum4jc20kqMhvrv+egrwYrmof?=
 =?iso-8859-1?Q?UbtJjkNs0UsFZzGQfwnm6XSAWwILxclo5EEY9IjNmde4AAYG7On7Ltce9z?=
 =?iso-8859-1?Q?Y1Gr3OXa9wCejHn+ZX2KkWB4l6+4ICU5ZZ1cCYYYrqY1WizowwJLHpECBL?=
 =?iso-8859-1?Q?j3RFObYBA/faVovgP4AJYslSjrHgE7F2Q+tEv8wrpmVmG1xoz1KgMZBsX6?=
 =?iso-8859-1?Q?gOQFZPsJ/ir84Z1+RLp3LpMHlatRHVZnAuL4fhgRZZFrOzATQL9CXENgfy?=
 =?iso-8859-1?Q?crXHkmV+ugbRnHxuKS2ettRs5h5kz1Kt6by1Ek?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B163240469F87C40AF066F083983745A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 545cb671-b09f-448b-6bd1-08d8a7d10549
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2020 05:59:05.0610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k2JuedDDIktgpfyom0Ffbm9uHyPrzZNgedb+864jg/eCIBrpWiKs+rO8rPkzB6FXUhMgH7fMv4bX7qg5XRMVZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5241
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-23 17:18:47, Pali Roh=E1r wrote:
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
> XHCI_SKIP_PHY_INIT is set. Also checking if either xhci->quirks or
> priv->quirks contains this XHCI_SKIP_PHY_INIT quirk.
>=20
> Signed-off-by: Pali Roh=E1r <pali@kernel.org>
>=20
> ---
> Changes in v2:
> * Check also xhci->quirks as xhci_priv_init_quirk() callbacks are setting=
 xhci->quirks
> * Tested with "usb: host: xhci: mvebu: make USB 3.0 PHY optional for Arma=
da 3720" patch
> * Removed Fixes: line
> ---
>  drivers/usb/host/xhci-plat.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> index 4d34f6005381..0eab7cb5a767 100644
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
> @@ -330,7 +323,14 @@ static int xhci_plat_probe(struct platform_device *p=
dev)
> =20
>  	hcd->tpl_support =3D of_usb_host_tpl_support(sysdev->of_node);
>  	xhci->shared_hcd->tpl_support =3D hcd->tpl_support;
> -	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
> +
> +	if (priv) {
> +		ret =3D xhci_priv_init_quirk(hcd);
> +		if (ret)
> +			goto disable_usb_phy;
> +	}
> +
> +	if ((xhci->quirks & XHCI_SKIP_PHY_INIT) || (priv && (priv->quirks & XHC=
I_SKIP_PHY_INIT)))
>  		hcd->skip_phy_initialization =3D 1;

I am not sure if others agree with you move the position of
xhci_priv_init_quirk, Let's see Mathias opinion.

--=20

Thanks,
Peter Chen=
