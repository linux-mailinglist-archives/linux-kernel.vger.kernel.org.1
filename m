Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C8E2E10FF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 02:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgLWBDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 20:03:35 -0500
Received: from mail-eopbgr140070.outbound.protection.outlook.com ([40.107.14.70]:25905
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725931AbgLWBDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 20:03:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lz9p5uDSZQI5uSlhzei6tprT8gitLyJFa4C/oF7M4tbMlmQRDYvnhK/3xuHBJW1z8gqG3q26pEc9bpEsQtrogDtYfP9BlYwxmbSPWqgNZt3oUonDR0uEyA0FN39qrgYWA/QC+CCXBeO5Evqt7VKroDBcDvwEIU/FiPa1Gjj372YL8qHDtAByPhTCskhrSSM+DrBCw/KUOcI9Bhn5QDA7j9gU3UYulhNmBfL/1fNYZQ3IEEiK0yR/Rbxlbn3Tai2AxZMXQKL9KP+kQ+pq+QbiNYjnl/uTdJIk4RnaK8djQg9GGtlb4dc0LnVp52HB+fsHlUZFqPlIqNZpJkstCYzlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djpjKa8k3M2XoaBIrVkca+6Fo8HttauCcacHdVLt7aw=;
 b=dK89zqQ3m86rQeq9yN7OFdrn0hx5VQrplaHuFltynXSBHn0Ibi4Rx4RzsPmLEZ3Ui/zUOJe8dkhL9RQ41mbVBNpGjIIyW1l95eBcN8B24T693IzkYftjtNGPMV4WJXRlhtxUYqawBRGiS/Ewu44ZBzy8xmyZglUeWKmNVTjslO1q9YyxTqGBK2JHmA8J3nlI76O3fDaSConoRmve+BIdowfHfAxKu1eB2VLQSvk/eHIRe2UTY7XZ5/XCk3VdEb//LBWbruddUm5Il3pHl8/mf9Ig/XgwGdMSy9I7d4EVy3hr9IFOm3xIQBGGsAluoJyCH+J9ppi3xC4vyhvleaQBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=djpjKa8k3M2XoaBIrVkca+6Fo8HttauCcacHdVLt7aw=;
 b=hkEtVIrVdyuuSbysPjfj0Qyz3qeuowqIrA5A+6jKv8kzqX+rbSwVT1z3r91RG3GW9c+CCOK9kXr/HnnH15RLODUrAlhkDkh8qEILHeq3m2A3ZQSVNP+5MQmcOdOss2RMkH8AXFMjVJIVownoTQKsMYyMtr0Imgkd/R99DsqOcns=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB5657.eurprd04.prod.outlook.com (2603:10a6:10:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3676.33; Wed, 23 Dec
 2020 01:02:43 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3676.033; Wed, 23 Dec 2020
 01:02:43 +0000
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
Thread-Index: AQHW16tInodopkLEv0Oy1XwtiA3jeaoCYPUAgAB36YCAAEUggIAAwSsA
Date:   Wed, 23 Dec 2020 01:02:43 +0000
Message-ID: <20201223010214.GA18398@b29397-desktop>
References: <20201221150903.26630-1-pali@kernel.org>
 <20201222021416.GB4706@b29397-desktop> <20201222092327.jq5b7g4bffeccq3o@pali>
 <20201222133051.jfvrgkcdhjnldz3z@pali>
In-Reply-To: <20201222133051.jfvrgkcdhjnldz3z@pali>
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
x-ms-office365-filtering-correlation-id: 1e38425c-6355-452d-921a-08d8a6de7449
x-ms-traffictypediagnostic: DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB5657B678A2FAAEEE8BF2574F8BDE0@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vfeBaFUD2Khw3Mecc0HlXXCryrkH76qUWWD1AEE1sWufi3Zc1re5ARWfqPkgcRDgWA6ZKKfTmWVJvER0c4GrD7tmwe9OEWDGedJIdbbhWo5GujyeYatwJc3aNOkW2TiR2/RjbR9Pt5YqiPV3XMYBjcaq7zGUPrQG4KVanAk+5DUtQYmfDuvl1zt8udS0FAjd5aS+QPVjo9BWQnA4x2rRXiyRm3/ioCrD5pX4IdOdA17ENEU3k/XXQESEkUrBAPvXkbTSarbVx2fF/OR3XMxgIXRAxE3rbyVtIseL09QcA8+Y9erWXat6UVqZ+BgstpSabB0GniOaPEYwO9DEttVBJccXFMxHNOOQ7FVCReTFdsN7d25kULZ+lfO53GvN31WmJ4QgOmNFNh9GOPGouG1NSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(66946007)(6486002)(316002)(8936002)(186003)(4326008)(33656002)(8676002)(5660300002)(6916009)(9686003)(2906002)(54906003)(1076003)(71200400001)(76116006)(53546011)(26005)(66556008)(66476007)(6506007)(478600001)(64756008)(6512007)(44832011)(66446008)(33716001)(86362001)(66574015)(91956017)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?TsMg5UHsMYFDp2xqWdGKcmUhpCM+oLMUlo9p8ZQy43tmi7fiTYQjJnSDHF?=
 =?iso-8859-1?Q?LWU0JH1Kuf+xmmSEExBbiYVTcG+IJ7J5qPF/ydDyrHL6zTvb3mAe0+WW8Y?=
 =?iso-8859-1?Q?zu6tsmlJYNisVgqq/y7Z7HdiOthGfM9xt0O+yk1srUrRp/+iCXfF/h+pag?=
 =?iso-8859-1?Q?hpbW3kCImBZuyuUmHE+ycNOF4lBfIuF685qXxD2Tsk7JoKTw+ZwjbyKxNz?=
 =?iso-8859-1?Q?KU5Ioxw18Begbn+0/6jkj8aava9cLDqa7zRFPIOeRNPKCwqDvgrX4/27CD?=
 =?iso-8859-1?Q?b+9+wNMKbRvAu2c83YWtuKn/fBZSqGblm8y2E9emxVxswo99FoVFa8+H6G?=
 =?iso-8859-1?Q?lBxwIw/anhQ4IwofJ5y31GZmon4G9bVshPKqEobXNut5UKvvo0bV/rTnjQ?=
 =?iso-8859-1?Q?usnI4SuDewOfvoRnIViYC52nGrnNsK+/TAtfG4MNtx+/TuBFh7lFn7XgS0?=
 =?iso-8859-1?Q?+bBZ0Kp53idOVpCrZKaVyOGDoSgQt3U/KuO0T5Eh2iGy5bgAPyB7+MQjnR?=
 =?iso-8859-1?Q?vaa2twdQw3NX111jsfSypy7cDKZp8UaJZ0PFVFTyvT8+eYMv0/AwawYehI?=
 =?iso-8859-1?Q?HazYGFH2ZNboPwBTSYl3WY9TYVDhKTAaC3owu7GmxC4gpTYOOfHHb3qDsL?=
 =?iso-8859-1?Q?gszcKbJDCE7dWUBbg8cwR0cChRwH+fcycFEk19lcRF2zpQjieeji+edW+A?=
 =?iso-8859-1?Q?fox/WruDJ72qHYfkSZcUH2kBIpNpeftBrs05HOL3NgZinR1LfnBZQoOGPy?=
 =?iso-8859-1?Q?96k9NVWkoibAxrsA3ppoprMOAAJ+UDBeV7sLf6kML1RsfMZbE3bkwEalgW?=
 =?iso-8859-1?Q?frIGceRwCjZx8C97llMAZSgf+3ZToHScvcHNZaS//mEb98RdNy5CpDLtdM?=
 =?iso-8859-1?Q?AGQwjo0XA3rAf0d4Wp41DXNg6u2QGGKsiZr64Y3//cxcuJMRAaQ8z50GMM?=
 =?iso-8859-1?Q?66Bm5JXWlG/zb29+9R3P0Wv2U9bjzy7via4n936Sj6yRDNBFaI/7pAu4uL?=
 =?iso-8859-1?Q?zY8uELH4qa8vtzoFB4qI+8ngWVXEkm2cyKu+YR?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <AE1B4FFCE038BE4CB4ACBFBFAA11914B@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e38425c-6355-452d-921a-08d8a6de7449
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 01:02:43.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q86W/lIHmJd0MiXkNLVJwyj1P6vfyPpGaQjh43Dew70EvQqsnsN1LhUuGkh1va2JufNXharNrF6i1ROfwbJ42w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-12-22 14:30:51, Pali Roh=E1r wrote:
> On Tuesday 22 December 2020 10:23:27 Pali Roh=E1r wrote:
> > On Tuesday 22 December 2020 02:14:45 Peter Chen wrote:
> > > On 20-12-21 16:09:03, Pali Roh=E1r wrote:
> > > > Currently init_quirk callbacks for xhci platform drivers are called
> > > > xhci_plat_setup() function which is called after chip reset complet=
es.
> > > > It happens in the middle of the usb_add_hcd() function.
> > > >=20
> > > > But XHCI_SKIP_PHY_INIT quirk is checked in the xhci_plat_probe() fu=
nction
> > > > prior calling usb_add_hcd() function. Therefore this XHCI_SKIP_PHY_=
INIT
> > > > currently does nothing as prior xhci_plat_setup() it is not set.
> > > >=20
> > > > Quirk XHCI_SKIP_PHY_INIT is only setting hcd->skip_phy_initializati=
on value
> > > > which really needs to be set prior calling usb_add_hcd() as this fu=
nction
> > > > at its beginning skips PHY init if this member is set.
> > > >=20
> > > > This patch fixes implementation of the XHCI_SKIP_PHY_INIT quirk by =
calling
> > > > init_quirk callbacks (via xhci_priv_init_quirk()) prior checking if
> > > > XHCI_SKIP_PHY_INIT is set.
> > > >=20
> > > > Fixes: f768e718911e0 ("usb: host: xhci-plat: add priv quirk for ski=
p PHY initialization")
> > > > Signed-off-by: Pali Roh=E1r <pali@kernel.org>

Hi Pali,

I know your case, you need to choose XHCI_SKIP_PHY_INIT quirk
conditionally, but you may can't add Fixes tag at your patch
since your issue was existed before my patch.

Peter


> > > > ---
> > > >  drivers/usb/host/xhci-plat.c | 14 +++++++-------
> > > >  1 file changed, 7 insertions(+), 7 deletions(-)
> > > >=20
> > > > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-p=
lat.c
> > > > index 4d34f6005381..58704c5b002b 100644
> > > > --- a/drivers/usb/host/xhci-plat.c
> > > > +++ b/drivers/usb/host/xhci-plat.c
> > > > @@ -89,13 +89,6 @@ static void xhci_plat_quirks(struct device *dev,=
 struct xhci_hcd *xhci)
> > > >  /* called during probe() after chip reset completes */
> > > >  static int xhci_plat_setup(struct usb_hcd *hcd)
> > > >  {
> > > > -	int ret;
> > > > -
> > > > -
> > > > -	ret =3D xhci_priv_init_quirk(hcd);
> > > > -	if (ret)
> > > > -		return ret;
> > > > -
> > > >  	return xhci_gen_setup(hcd, xhci_plat_quirks);
> > > >  }
> > > > =20
> > > > @@ -330,6 +323,13 @@ static int xhci_plat_probe(struct platform_dev=
ice *pdev)
> > > > =20
> > > >  	hcd->tpl_support =3D of_usb_host_tpl_support(sysdev->of_node);
> > > >  	xhci->shared_hcd->tpl_support =3D hcd->tpl_support;
> > > > +
> > > > +	if (priv) {
> > > > +		ret =3D xhci_priv_init_quirk(hcd);
> > > > +		if (ret)
> > > > +			goto disable_usb_phy;
> > > > +	}
> > > > +
> > > >  	if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
> > > >  		hcd->skip_phy_initialization =3D 1;
> > > > =20
> > >=20
> > > Hi Pali,
> > >=20
> > > What's problem you have met? In structure xhci_plat_priv, the quirks =
are
> > > defined at .quirks entry which is got at below code. .init_quirk is t=
he
> > > routine if special initializations are needed.
> >=20
> > Hello!
> >=20
> > I'm talking about .init_quirk. And if XHCI_SKIP_PHY_INIT quirk is set i=
n
> > this function then has no effect.
>=20
> Ok, this patch is not enough, I will send V2.
>=20
> > I'm working currently on patch for xhci mvebu which conditionally enabl=
e
> > or disable XHCI_SKIP_PHY_INIT quirk (it is going to fix existing
> > regression since v5.1 kernel) and without this patch XHCI_SKIP_PHY_INIT
> > quirk from the init_quirk does not work.
>=20
> And now I have tested V2 with my mvebu regression fix. I will send it to
> mailing list for review.
>=20
> > > 	if (pdev->dev.of_node)
> > > 		priv_match =3D of_device_get_match_data(&pdev->dev);
> > > 	else
> > > 		priv_match =3D dev_get_platdata(&pdev->dev);
> > >=20
> > > 	if (priv_match) {
> > > 		priv =3D hcd_to_xhci_priv(hcd);
> > > 		/* Just copy data for now */
> > > 		*priv =3D *priv_match;
> > > 	}
> > > --=20
> > >=20
> > > Thanks,
> > > Peter Chen

--=20

Thanks,
Peter Chen=
