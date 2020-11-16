Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E002B44EA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 14:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgKPNos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 08:44:48 -0500
Received: from mail-db8eur05on2087.outbound.protection.outlook.com ([40.107.20.87]:52193
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726308AbgKPNor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:44:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hau1KG89548IkBALyw598czDHMJyO3MrP6/blVScKBsEg0wVNMfkTGjREKEQcVQ7SFNXWwJva5svUH9112/A1zodQGMmq8aXVWh5SETZYdHE7Tlb5CTj8NUUwFHOu91SZ4WJ3fcePS24Ex4Lt+E/0KTuvek2eBwa1d3TsTRrQJPfJ3q/1ZITXstAoGwaSlOy9AwGP6kiiMnRtM7sUOwguJb++UV4YuwVTED3Ay50gUJGi4IqX3fOxaq1ajXGlJ4QNS2nEFJBNJkkwIbsSCIchfvyBs3oox3aw1sfPsGL4YTu8R4KIAfel1CtCeKCuG2zCF5rhEltyz+6k/zBt4Pfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUeKC0jSxyPDVPkDl8M7OEdb0zDvwVwZ6HZEiXOD6ok=;
 b=F2dwY32GZdQzj9/RUqudlfODXV5xbKJypcn/7ufc8dbxY3OYI80Za2DG4sE+pBqo6euSMtUybypSOomyEn3Ev22vI9AqiaAO+6JUa/xeuySAXalRM2cvfCdIN8DzxQ9rOpmotT+NBmce8k++ZgDNR1h6rAiwpM9I//gV4PPIYvTSy2BOYuyOXlnLRg+3soPGtOVTJEw1sECrpXdf8R8G2LG2RY8EGFoX6gfJ1GGBTz7J/6lmDBkBs2X2Afl52On92vvK6jee4RVGJO8xIUosjFpVFmkAOi1HTdHmngqPnHGnmyTGB7xuuSf+aAxYzCbLr4zEXTvWl5l1U7aKqkJDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUeKC0jSxyPDVPkDl8M7OEdb0zDvwVwZ6HZEiXOD6ok=;
 b=jW1BIuHoVy0drjD/VoozjeX6tPzGmLgiJy5Z5U3KsQLhl6WBltgKhX3UhibHFEbzky6Fj1rT/muKDdpi1wa6TRPMOuktGSSTFaEOtYLNGaNFW6D0g1EyXbeudMqPab9TtBu1tebPHBsKgmqTmrbq8o4fvXtCaVcP2YuZQTfx+8Y=
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com (2603:10a6:10:1ec::9)
 by DB8PR04MB6715.eurprd04.prod.outlook.com (2603:10a6:10:10d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Mon, 16 Nov
 2020 13:44:44 +0000
Received: from DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c]) by DBBPR04MB7979.eurprd04.prod.outlook.com
 ([fe80::c8c:888f:3e0c:8d5c%5]) with mapi id 15.20.3564.028; Mon, 16 Nov 2020
 13:44:44 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Wesley Cheng <wcheng@codeaurora.org>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Thread-Topic: [PATCH 2/3] usb: gadget: composite: Split composite reset and
 disconnect
Thread-Index: AQHWul46tgzH+l3JtUq0myvSjgQebKnKyGiA
Date:   Mon, 16 Nov 2020 13:44:44 +0000
Message-ID: <20201116134415.GE28313@b29397-desktop>
References: <20201114081247.25063-1-wcheng@codeaurora.org>
 <20201114081247.25063-3-wcheng@codeaurora.org>
In-Reply-To: <20201114081247.25063-3-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99de4b26-ed5e-4129-55dc-08d88a35c6a7
x-ms-traffictypediagnostic: DB8PR04MB6715:
x-microsoft-antispam-prvs: <DB8PR04MB6715D8FD01CB24E525D12C588BE30@DB8PR04MB6715.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: id0bWmQQ8CW7Ej92gXBONNGapbxiuYttHObu351JBegxMZNZNecaL/NwE1Ehxz2UgI1b0e1SCO2dl096EC20dIxHkpfsgEMleqNpXkiQdOIg15otiHI9Lf66iOre/tGQiP6J84aZQaNYNcZK9yT62Q9qdIxKhOxJpD1ZKd1LTzjHh2Yv+xSNyCcyRjtbmbekclitovpHs3rnQD0yvvdoWG2jE8TfRTDThkLkHyXOGz18PVfj0PIO8CESl2p2DSpxCDcKaQ+Ezv9afWVlNHEfwLtd9+NjdCxKIjXgfPRwgvZZ4g4JfPacCcXahhd8xbE3/MpDYjIM+v70ELKH/vnHRw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7979.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(39860400002)(396003)(366004)(136003)(346002)(71200400001)(6506007)(6512007)(44832011)(86362001)(54906003)(26005)(8936002)(8676002)(91956017)(316002)(6486002)(53546011)(1076003)(9686003)(66446008)(186003)(2906002)(478600001)(33656002)(64756008)(83380400001)(66556008)(33716001)(76116006)(4326008)(66946007)(6916009)(5660300002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: KM18ZCzQmDJatm0uqr0CcT2VIEDSAFwR7QDPdYzJCwu/i5t68kfxLYxt1RFPjcQ90qu/g0TNWWa2D2/reAed7cfmucb1+O49UAgh9iN0fB4IrXsIoGXimfBlGVnNCV60APZwny9oPsUMdxNuGdUstcsEhUqDfAArzbouHn39ocA4ZACEhS1b4eGUJdUnMOoDQ/Tw3pHfU7/UVNNFj3WCjU+8sQMe2CKJx6JS7NwWwt4IUnzZppHrbglY+7+NGHkhvMWeMXTqot0dlcHJyr5xDOqTIXcjPgxt3ydx9rPgenpP9nxRIRGjkX2aIr2l9Jylx+wYwDgDOTEZUr/E5QZAeaLm60B38TphVHqTScMb+Ymlb/Xa4iWoeiGgihPrSjwc7g2DsVaaWZ14ihECLVW8grzEV5VIAn5Rr265aW1ijGdVXRueqfyCqCLwkvc/u5CHo/VkCYtpefQ+HeAU81gP1XFlKY0B4+r8uhpeZHC6ZZHrsTNbBKw2rjoCZ0q8Y22jSTQ2oleYJxzfD3HyiNhBhQ9e5bmvrtlMccVWfJkHtSPAq9hTUWr5r3MUL6073kFIDLEZu4QhiutWbH2xT8GyPNvxNahbg6hSP0plINosgK/+bROIpbbrgEXJGH/+CudpVQ8K81AabgQYlaJw3PvMPg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E85BF8C3D8C6E4AB828D102E9C44787@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7979.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99de4b26-ed5e-4129-55dc-08d88a35c6a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2020 13:44:44.2784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dJD5z4wSEwViixBH7YoO1U4q/Qc2+/sAVRreBYkj6vNSm5risHx5FIqo6B9A8CQWspG1hZuXFSIO7LOqOqlLFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6715
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-11-14 00:12:46, Wesley Cheng wrote:
> Add a specific composite reset API to differentiate between disconnect an=
d
> reset events.  This is needed for adjusting the current draw accordingly
> based on the USB battery charging specification.  The device is only allo=
wed
> to draw the 500/900 mA (HS/SS) while in the CONFIGURED state, and only 10=
0 mA
> in the connected and UNCONFIGURED state.
>=20
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter
> ---
>  drivers/usb/gadget/composite.c | 21 +++++++++++++++++++--
>  include/linux/usb/composite.h  |  2 ++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composit=
e.c
> index 05b176c82cc5..a41f7fe4b518 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -2036,7 +2036,7 @@ composite_setup(struct usb_gadget *gadget, const st=
ruct usb_ctrlrequest *ctrl)
>  	return value;
>  }
> =20
> -void composite_disconnect(struct usb_gadget *gadget)
> +static void __composite_disconnect(struct usb_gadget *gadget)
>  {
>  	struct usb_composite_dev	*cdev =3D get_gadget_data(gadget);
>  	unsigned long			flags;
> @@ -2053,6 +2053,23 @@ void composite_disconnect(struct usb_gadget *gadge=
t)
>  	spin_unlock_irqrestore(&cdev->lock, flags);
>  }
> =20
> +void composite_disconnect(struct usb_gadget *gadget)
> +{
> +	usb_gadget_vbus_draw(gadget, 0);
> +	__composite_disconnect(gadget);
> +}
> +
> +void composite_reset(struct usb_gadget *gadget)
> +{
> +	/*
> +	 * Section 1.4.13 Standard Downstream Port of the USB battery charging
> +	 * specification v1.2 states that a device connected on a SDP shall onl=
y
> +	 * draw at max 100mA while in a connected, but unconfigured state.
> +	 */
> +	usb_gadget_vbus_draw(gadget, 100);
> +	__composite_disconnect(gadget);
> +}
> +
>  /*----------------------------------------------------------------------=
---*/
> =20
>  static ssize_t suspended_show(struct device *dev, struct device_attribut=
e *attr,
> @@ -2373,7 +2390,7 @@ static const struct usb_gadget_driver composite_dri=
ver_template =3D {
>  	.unbind		=3D composite_unbind,
> =20
>  	.setup		=3D composite_setup,
> -	.reset		=3D composite_disconnect,
> +	.reset		=3D composite_reset,
>  	.disconnect	=3D composite_disconnect,
> =20
>  	.suspend	=3D composite_suspend,
> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.=
h
> index 2040696d75b6..0d8a71471512 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -525,6 +525,8 @@ extern struct usb_string *usb_gstrings_attach(struct =
usb_composite_dev *cdev,
>  extern int usb_string_ids_n(struct usb_composite_dev *c, unsigned n);
> =20
>  extern void composite_disconnect(struct usb_gadget *gadget);
> +extern void composite_reset(struct usb_gadget *gadget);
> +
>  extern int composite_setup(struct usb_gadget *gadget,
>  		const struct usb_ctrlrequest *ctrl);
>  extern void composite_suspend(struct usb_gadget *gadget);
> --=20
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum=
,
> a Linux Foundation Collaborative Project
>=20

--=20

Thanks,
Peter Chen=
