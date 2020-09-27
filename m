Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE59279F1D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 09:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgI0HGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 03:06:51 -0400
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:63453
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729125AbgI0HGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 03:06:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOdrsRkWS75eWmWU37DnCBv5L/liBNkYflO7dmgUigEo7LfCumCe9EXEK3lNQQ4iqwdR32WIMK0qOlxGRc+hf0WVixJXcyD127zBlZx//fHsQ6cMbwrAhSbKW7N3AanopH4zt6aCiaGvVezHaMhkRVYAorCkp0N77It0UV2FnNf2khobo/0zKaOfTUimiUpSwSQPodaY68NDG2kEffGYz07cm5oeLcLb4aFxEmhXBW+ORh2kmx3L/1fM0TAheHD36W5Zfdq1h5nqFrfno3n5uY1rXdvPM3FDBN5SeqvHrT5wZmnKmQuvAwbPuX5irDGGkfj6UFtVruPIKl0ZFgfCTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPkzbiA8UFxk3F6BXyqVPSbaMjkPoi7Pe7x34VTjNt8=;
 b=MiJVuevMn+f831rXnRPkD/K4T8chuVwHZzU2vUAz2B3pO2Hw+WxCJDv9pGKdRLNDrNj9qcHa8rJA0kicMsy6JM3YTle8YomagPz3FTuiC0jTTM5xza4+DQZhrp6gx8vH5oah/uxbHGO+vJKyiQBOIEyzsyTPbSWhIs4AN44yFX53I/uF0oOPA2/M7BKg8PEcEMsUtYI2peK9z1JIUBykXH9BZP6T9KtJzwg8whX9auKA44Fd2qRWmNQ50zbZXJx5GYL/lgbE4VLaAHzxRW6KgcVwKWf3uZVtktpJeF/MWS6P1Kiq/UvacBC+3rwKoWfBFk6dGQm2SE0QO2Ep1NpoIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPkzbiA8UFxk3F6BXyqVPSbaMjkPoi7Pe7x34VTjNt8=;
 b=MbdqLFmYDADHCoUx2Ua3g3HD67cpe8qdiSugp56G9QxzLtQTQo649gkfIEIlcxtAg5Htak3aOUUiZnjU+nz+xXt/KZZxInHvBvfzusv9OApTXJhPoluBXOKSHraclMttJB7qtAXXa5lJ7X1OxrPp3uoNGiHXpotTHerXlvaD4OE=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB3102.eurprd04.prod.outlook.com (2603:10a6:802:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22; Sun, 27 Sep
 2020 07:06:45 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.024; Sun, 27 Sep 2020
 07:06:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "sudeep.dutt@intel.com" <sudeep.dutt@intel.com>,
        "ashutosh.dixit@intel.com" <ashutosh.dixit@intel.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wang.yi59@zte.com.cn" <wang.yi59@zte.com.cn>,
        "rikard.falkeborn@gmail.com" <rikard.falkeborn@gmail.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>,
        Andy Duan <fugang.duan@nxp.com>
Subject: RE: [PATCH 1/5] misc: vop: change the way of allocating vring for
 noncoherent platform
Thread-Topic: [PATCH 1/5] misc: vop: change the way of allocating vring for
 noncoherent platform
Thread-Index: AQHWkw1Ua/wMKuww70uQvYAscuCr2al5RScAgAK645A=
Date:   Sun, 27 Sep 2020 07:06:45 +0000
Message-ID: <VI1PR04MB4960F2D68C171402C4EE2A5692340@VI1PR04MB4960.eurprd04.prod.outlook.com>
References: <20200925072630.8157-1-sherry.sun@nxp.com>
 <20200925072630.8157-2-sherry.sun@nxp.com>
 <20200925121600.GA2680110@kroah.com>
In-Reply-To: <20200925121600.GA2680110@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f460b98c-5131-4353-c548-08d862b3e4f2
x-ms-traffictypediagnostic: VI1PR04MB3102:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB3102B03D7830901B8A8CBF5D92340@VI1PR04MB3102.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RWUQBe7o/L2cHv8WQYQRFT3qibhRM64kg5TxQfdU2HjLzqLOL+Q5EZB45Bm1l2C20u93D4OR74jyYsoQ+CPCBhJzfpJPH2y1bg98BA2M9hsPtpFFs4iWRHGm2lm65yxxQQ7h938ca+5RfUYScCyAwDP7m9iycASmeN1uATgeV7axrCvULyqWs4c5nIV0IlKDVDZ27yg+zbEiv9k1EZLYa2zaj5tHQTQVLKx/OmnDDJp5I4g3bk/6do4uSVHAA9dLJB4zVcIxCO5FYooLe4Snmna0GuwO4mw1KQwwejftahlYM8zGpyq/D4JRWsOS64LJiP/Vife/maR5VM9JzDqFlPw7APmhUwrnB5PJpKtXln1qX+tjdlbVd7RyYmeUZWK/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(8676002)(2906002)(4326008)(6916009)(55016002)(9686003)(66476007)(66556008)(64756008)(66446008)(83380400001)(86362001)(71200400001)(44832011)(8936002)(33656002)(54906003)(186003)(316002)(5660300002)(76116006)(66946007)(26005)(6506007)(52536014)(478600001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tGXlj1Pu+yrle9MstgOCNZhkGokagRoWqe4Ioki8008vVXZT9fQ3yo/8ypPOYNBOkG9hqEzeXLFmC/gpAZdtMKIWb557X/6qCaBvE2D1F+FhTqrlmNyb524tMxvjV1jPOKxMjX6MT+IpXci2yperPGrtZbmydaA/bQtUgJSdLJjGko45g15IbtgGvKYz2epuLNVXQQuJriliS/Q6fRQ8dw3kn5dvQAtnN+gfXbYofkT69+P+s//H62MW/GFAgmbZysAUccHSf3Jzgog2m6D/VISsk+UfUWAKja3J6DoTxjBmWBcqBclPA5sC4aYtgk19fT3fhtmmMzTODhEMdVc1QTfI6KMNnDgGYqtfm0JZQgzQIv5SFSA65dQs7UnubGDhEmk7z3XI2atxwVSB2yA9oxW0uaVEYX5IJkUqpRWfBXokhphiY0WzBmyoFvbQwnPjrY/sxBwjN4T2WBYKnq4gBKCcAIEOZ52wxg0E7H8yNRnFoG6Hx7fXkeIFu6E+l74+DZocL6FRKrRJBbZZ63HCew7erOuK4p2JTnMusKQCr3Z2NYFWmr163FVpHKSynfWDrRPWaVfNGLS+lEW4dYHXoZQMqcM5xmUIcs5pUL4tS7wYZogQ3NAUyc2hSw+hAEIYEn7O50dZQR4x1FioGKvuMA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f460b98c-5131-4353-c548-08d862b3e4f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 07:06:45.1449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUF//dzCbuvzD/IC+JD7t1bZpq1OMOJKFPiSMxtawnjiPF9TtinMIL14squ1Oiy61LyK02C632CL9Q7ijilESw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> -----Original Message-----
> On Fri, Sep 25, 2020 at 03:26:26PM +0800, Sherry Sun wrote:
> > For noncoherent platform, we should allocate vring through
> > dma_alloc_coherent api to ensure timely synchronization of vring.
> > The orginal way which used __get_free_pages and dma_map_single only
> > apply to coherent platforms.
> >
> > Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  drivers/misc/mic/vop/vop_vringh.c | 101
> > ++++++++++++++++++++----------
> >  1 file changed, 67 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/misc/mic/vop/vop_vringh.c
> > b/drivers/misc/mic/vop/vop_vringh.c
> > index f344209ac386..fc8d8ff9ded3 100644
> > --- a/drivers/misc/mic/vop/vop_vringh.c
> > +++ b/drivers/misc/mic/vop/vop_vringh.c
> > @@ -9,6 +9,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/poll.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/dma-noncoherent.h>
> >
> >  #include <linux/mic_common.h>
> >  #include "../common/mic_dev.h"
> > @@ -67,11 +68,12 @@ static void vop_virtio_init_post(struct vop_vdev
> *vdev)
> >  			dev_warn(vop_dev(vdev), "used_address zero??\n");
> >  			continue;
> >  		}
> > -		vdev->vvr[i].vrh.vring.used =3D
> > -			(void __force *)vpdev->hw_ops->remap(
> > -			vpdev,
> > -			le64_to_cpu(vqconfig[i].used_address),
> > -			used_size);
> > +		if (dev_is_dma_coherent(vop_dev(vdev)))
> > +			vdev->vvr[i].vrh.vring.used =3D
> > +				(void __force *)vpdev->hw_ops->remap(
> > +				vpdev,
> > +				le64_to_cpu(vqconfig[i].used_address),
> > +				used_size);
>=20
> That's really hard to read, don't you agree?  We can go longer than 80
> columns now, and why the __force?
>=20

Yes, it's really hard to read, here I moved the original code into the if()=
 without change the code style.=20
Sorry for that, will change it.

For the __force used in the original code, I think  this is because vpdev->=
hw_ops->remap() return type is void __iomem *, but vring.used need type voi=
d *.=20
Maybe this is a workaround for Intel MIC platform, as it reassigns the used=
 ring on the EP side.

But as far as I'm concerned, there is no need to reassign the used ring on =
the EP side.=20
So move it into if (dev_is_dma_coherent(vop_dev(vdev))) to keep consistent =
with the code below.

>=20
>=20
> >  	}
> >
> >  	vdev->dc->used_address_updated =3D 0;
> > @@ -298,9 +300,14 @@ static int vop_virtio_add_device(struct vop_vdev
> *vdev,
> >  		mutex_init(&vvr->vr_mutex);
> >  		vr_size =3D PAGE_ALIGN(round_up(vring_size(num,
> MIC_VIRTIO_RING_ALIGN), 4) +
> >  			sizeof(struct _mic_vring_info));
> > -		vr->va =3D (void *)
> > -			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
> > -					 get_order(vr_size));
> > +
> > +		if (!dev_is_dma_coherent(vop_dev(vdev)))
> > +			vr->va =3D dma_alloc_coherent(vop_dev(vdev), vr_size,
> > +						    &vr_addr, GFP_KERNEL);
>=20
> Are you sure this is correct?  If dev_is_dma_coherent is NOT true, then y=
ou
> call dma_alloc_coherent()?
>=20

Yes, we have verified it on the i.MX platform based on vop driver.

Here dev_is_dma_coherent is just a check to see if the device hardware supp=
orts dma coherent.=20
If the hardware supports dma coherent, it is simple to handle the vring bet=
ween EP and RC like the original MIC do(use __get_free_pages and dma_map_si=
ngle, but without dma_sync_single_for_cpu/device).

But for some devices don't support hardware dma coherent, we should use dma=
_alloc_coherent to allocate consistent memory without caching effects, whic=
h can ensure timely synchronization of vring.

Actually the more common way to allocate vring in kernel is to use dma_allo=
c_coherent.

>=20
> > +		else
> > +			vr->va =3D (void *)
> > +				__get_free_pages(GFP_KERNEL |
> __GFP_ZERO,
> > +						 get_order(vr_size));
> >  		if (!vr->va) {
> >  			ret =3D -ENOMEM;
> >  			dev_err(vop_dev(vdev), "%s %d err %d\n", @@ -
> 310,14 +317,17 @@
> > static int vop_virtio_add_device(struct vop_vdev *vdev,
> >  		vr->len =3D vr_size;
> >  		vr->info =3D vr->va + round_up(vring_size(num,
> MIC_VIRTIO_RING_ALIGN), 4);
> >  		vr->info->magic =3D cpu_to_le32(MIC_MAGIC + vdev->virtio_id
> + i);
> > -		vr_addr =3D dma_map_single(&vpdev->dev, vr->va, vr_size,
> > -					 DMA_BIDIRECTIONAL);
> > -		if (dma_mapping_error(&vpdev->dev, vr_addr)) {
> > -			free_pages((unsigned long)vr->va,
> get_order(vr_size));
> > -			ret =3D -ENOMEM;
> > -			dev_err(vop_dev(vdev), "%s %d err %d\n",
> > -				__func__, __LINE__, ret);
> > -			goto err;
> > +
> > +		if (dev_is_dma_coherent(vop_dev(vdev))) {
> > +			vr_addr =3D dma_map_single(&vpdev->dev, vr->va,
> vr_size,
> > +						 DMA_BIDIRECTIONAL);
> > +			if (dma_mapping_error(&vpdev->dev, vr_addr)) {
> > +				free_pages((unsigned long)vr->va,
> get_order(vr_size));
> > +				ret =3D -ENOMEM;
> > +				dev_err(vop_dev(vdev), "%s %d err %d\n",
> > +						__func__, __LINE__, ret);
> > +				goto err;
> > +			}
>=20
> What about if this is not true?
>=20
> Same for other places in this patch.

If it is not true here, means the device doesn't support hardware dma coher=
ent, we can use dma_alloc_coherent to get both va and pa.
But for the true case, means the device hardware is dma coherent, two steps=
 are needed to get va and pa(1.__get_free_pages 2.dma_map_single), such as =
here.

Best regards
Sherry=20

>=20
> thanks,
>=20
> greg k-h
