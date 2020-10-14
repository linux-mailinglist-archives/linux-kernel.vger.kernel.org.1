Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73C028DAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 09:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgJNHtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 03:49:21 -0400
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:52007
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbgJNHtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 03:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c764yrlMiv4Nxr4ODganYR11WUL1Xe5bGxa0sU/8qKIgs3v8bYqxqAlIWFdykWKy1wsTX0iOYj7yEAxUEjnrsrxLnEyhQWsP67Z+IGkjPgaba/Y3+TZsbKGldSSMtLOs5ofdmq0Rh8heJCeltZE+vFyvTUEANPJTFNJork2PpHX1+kf+8TheB/BKPsCmEPZxR9mjzOy1V39KEH7u9im2jUioIsUy+E9461/LfEQ8ct83NPhdAJKoT3kk1eBYnyDJx4vODCPgBppQH/DUFxUT6b04sPwiTXhmzTggJsKMdAKcgtuGCcl/ZnEXUSGTVpq7JKlWvslw1TFzhZCMviHMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En/0WB8Xhbke5xeKsZQUU3Ct6LKayMrWLwcq+V/DdCc=;
 b=PNdBlw/b5A/T0X/9UWpPH/fdAym7HQT7r1ptWuO9u75EpLocCNZHb8jGTr3hE8TqB+xBF/wLx2ZvkNEa7Np88ML++unS/mOuH5kkoOyrce2n7DmzTioCdCYxXjuLSl7JgpfKmsJSIDxkOPWfR/VUDzbFPLcI8Im4ni/axtnH8Ap22y2hd0DzefRvjFg403AV9YuXkFmsSGt9V9Wfr15YmB7QJe+EsucML297TM5DJYteIhqzWrm07xY/kWfn2YN5wBaqzTR5m7JHVD7bVrSmtFYM0pNQrSVyNMbSJ/bo3aQpXbCUlL6lafPI2V1iJuTmQkGz+XPP5WMbv1qmW2LJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=En/0WB8Xhbke5xeKsZQUU3Ct6LKayMrWLwcq+V/DdCc=;
 b=Wr8AdJHF4YVhAzpxHp6lIucHNyThCDMZxFFsVeQLJDh2h/nU8ikUrJI2901Wbhs9VbU5cegdytS1HWAA1Vp+VgQmJQHozWVnVaJMUdXBkKbISlTXj+2fZRdvIIBJJgntK6UbhEM+5sne03L6/dNyzsJXAnQ16ZV4mu7q5zEgvDQ=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM6PR04MB4744.eurprd04.prod.outlook.com (2603:10a6:20b:5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Wed, 14 Oct
 2020 07:49:17 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::1953:c81a:cca2:60ec]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::1953:c81a:cca2:60ec%7]) with mapi id 15.20.3477.021; Wed, 14 Oct 2020
 07:49:17 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Peter Chen <peter.chen@nxp.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jun Li <jun.li@nxp.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: host: fsl-mph-dr-of: check return of dma_set_mask()
Thread-Topic: [PATCH] usb: host: fsl-mph-dr-of: check return of dma_set_mask()
Thread-Index: AQHWnsxMrWuAbFJbHUG0vd4wVtv8WqmRf/+AgAU+0tA=
Date:   Wed, 14 Oct 2020 07:49:17 +0000
Message-ID: <AM6PR04MB541398FE3D01D0759D9D98EBF1050@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20201010060308.33693-1-ran.wang_1@nxp.com>
 <20201010234028.GA16433@b29397-desktop>
In-Reply-To: <20201010234028.GA16433@b29397-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2d0882d7-4c82-43f6-efb1-08d87015a72d
x-ms-traffictypediagnostic: AM6PR04MB4744:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB47444A2EE8AC3342C260ABD5F1050@AM6PR04MB4744.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:285;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jb2FxJR1/7uSfg66jcvHSYiKbyGyc4OjK9xx4tF5uH9WML/kCAFrSvJxY4C7DHEu6cTa2xo5orXSTei90EM+vJqegt4r6WLfJyDtfaYB8fQNN7qUpyeHQfxqT0LEK+n6SJ+nNySSA4EgiRJWMZ25J9Xck42KoBjqTMSvQJJ6wOY2EXR+cpph3vPNVBvvhifCWN7nwkD3sRM4TVXY9tdGwXcMlz3xuH2H84Ys/I3LDE7Rc6fETd/8wARhgnSkzNUx8Vqy6IytGB3BSpD/Nz4hCrgStkOFq9w9u7bdBXf+pGa3UjRnBehBJCrp6IrMP6Rn3kuW+efX/7mGUcV8eBfd2g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(316002)(64756008)(7696005)(66476007)(52536014)(66446008)(8676002)(71200400001)(478600001)(66556008)(8936002)(26005)(83380400001)(86362001)(6862004)(33656002)(53546011)(9686003)(5660300002)(4326008)(6636002)(2906002)(6506007)(55016002)(186003)(66946007)(76116006)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UmScYELk8RACXqyn2nLZVCHing5qds6+hSguSupcHAIOGqCXVjuMj3sDi8yn8KCmgdmL/eHTyESTFgKuEiLcM8DiJsz2C8rdznSWVnJ5GzcBxIZ8AboJVMMoCL16N/LZ7Nf3r32VFYiyuL+X1rOp+kI3OMFV07Cbb+ffpcmC9N+1E4TVp2NAXkvICKic2NZUbZ51aJ7kXOtr2g2eG90RS5ZOKB/ZOmUbo3gI/vc6usBvtfg8U/7zu5TEW76jgTQPT/FvBoYByjTozaxzr2JyVk+FLzj7DMh6rWU3i2jy0N7Ii5CeECOlMk2gQL3Tf1fJAQUasvLIIK4xFvp6J+lGWlv2hw0ltu8Fs8WMGhKbRY0f3yGdTsy4Erm2BUuS8lii6IqSKvaxEJOuGcdn52XrWHCHpOCowIWcTzhfEeh1Eri+B2NDKixnM3ayGNFnaa5cS6jwZK0BVvSIohgCDsxjXPJdv0U8D/eGS0XDc6mXFRbGVKv/GoHuY9Nk+5ow2ZmxLbnhqwj3CisRG3K+qX0yt4oKf59+rp8tEz0zQF7pGMnnhVL9IMVYnOGBng1pvVZAIGOPLhOxErHGiIEaVFqkIqBMVNOB7DLtWr7wRMBiOJhG3mdroYzqVDjBa/12vV+H5HfCyKECNbm4hL/YI30ikg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0882d7-4c82-43f6-efb1-08d87015a72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2020 07:49:17.2445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pQmBWPbeHoXLnS+JMi6PnD3japijLvpQHh2vXhEgv8w+f8oES9iOsqt/ilI8qGq635s6h/aU9QU/KfFkp/M6lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4744
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Sunday, October 11, 2020 7:41 AM Peter Chen wrote:
>=20
> On 20-10-10 14:03:08, Ran Wang wrote:
> > fsl_usb2_device_register() should stop init if dma_set_mask() return
> > error.
> >
> > Fixes: cae058610465 ("drivers/usb/host: fsl: Set DMA_MASK of usb
> > platform device")
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> >  drivers/usb/host/fsl-mph-dr-of.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/usb/host/fsl-mph-dr-of.c
> > b/drivers/usb/host/fsl-mph-dr-of.c
> > index ae8f60f..44a7e58 100644
> > --- a/drivers/usb/host/fsl-mph-dr-of.c
> > +++ b/drivers/usb/host/fsl-mph-dr-of.c
> > @@ -94,10 +94,13 @@ static struct platform_device
> > *fsl_usb2_device_register(
> >
> >  	pdev->dev.coherent_dma_mask =3D ofdev->dev.coherent_dma_mask;
> >
> > -	if (!pdev->dev.dma_mask)
> > +	if (!pdev->dev.dma_mask) {
> >  		pdev->dev.dma_mask =3D &ofdev->dev.coherent_dma_mask;
> > -	else
> > -		dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +	} else {
> > +		retval =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +		if (retval)
> > +			goto error;
> > +	}
> >
> >  	retval =3D platform_device_add_data(pdev, pdata, sizeof(*pdata));
> >  	if (retval)
> > --
> > 2.7.4
> >
>=20
> Reviewed-by: Peter Chen <peter.chen@nxp.com>
>=20
> One more place need to fix, if platform_device_alloc returns NULL,
> it should not call platform_device_put to release platform
> device memory.
>=20
> 	pdev =3D platform_device_alloc(name, id);
> 	if (!pdev) {
> 		retval =3D -ENOMEM;
> 		goto error;
> 	}
> 	...
> error:
> 	platform_device_put(pdev);
> 	return ERR_PTR(retval);

Got it, let me check this later.

Thanks & Regards,
Ran

