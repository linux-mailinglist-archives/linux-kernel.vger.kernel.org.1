Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B838A2FB70B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389119AbhASJvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:51:14 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:58577 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387667AbhASJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:38:10 -0500
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 807B6C0015;
        Tue, 19 Jan 2021 09:37:25 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:37:25 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        youlin.pei@mediatek.com, devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 06/33] of/device: Move dma_range_map before
 of_iommu_configure
Message-ID: <YAaoVTlCjriJt+iY@aptenodytes>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-7-yong.wu@mediatek.com>
 <20210114192732.GA3401278@robh.at.kernel.org>
 <1610688626.4578.1.camel@mhfsdcap03>
 <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
 <1611048011.14702.6.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZpZRInV+koQDOukd"
Content-Disposition: inline
In-Reply-To: <1611048011.14702.6.camel@mhfsdcap03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZpZRInV+koQDOukd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue 19 Jan 21, 17:20, Yong Wu wrote:
> On Mon, 2021-01-18 at 15:49 +0000, Robin Murphy wrote:
> > On 2021-01-15 05:30, Yong Wu wrote:
> > > On Thu, 2021-01-14 at 13:27 -0600, Rob Herring wrote:
> > >> On Mon, Jan 11, 2021 at 07:18:47PM +0800, Yong Wu wrote:
> > >>> "dev->dma_range_map" contains the devices' dma_ranges information,
> > >>> This patch moves dma_range_map before of_iommu_configure. The iommu
> > >>> driver may need to know the dma_address requirements of its iommu
> > >>> consumer devices.
> > >>>
> > >>> CC: Rob Herring <robh+dt@kernel.org>
> > >>> CC: Frank Rowand <frowand.list@gmail.com>
> > >>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > >>> ---
> > >>>   drivers/of/device.c | 3 ++-
> > >>>   1 file changed, 2 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/drivers/of/device.c b/drivers/of/device.c
> > >>> index aedfaaafd3e7..1d84636149df 100644
> > >>> --- a/drivers/of/device.c
> > >>> +++ b/drivers/of/device.c
> > >>> @@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, st=
ruct device_node *np,
> > >>>   	dev_dbg(dev, "device is%sdma coherent\n",
> > >>>   		coherent ? " " : " not ");
> > >>>  =20
> > >>> +	dev->dma_range_map =3D map;
> > >>>   	iommu =3D of_iommu_configure(dev, np, id);
> > >>>   	if (PTR_ERR(iommu) =3D=3D -EPROBE_DEFER) {
> > >>>   		kfree(map);
> > >>> +		dev->dma_range_map =3D NULL;
> > >>
> > >> Not really going to matter, but you should probably clear dma_range_=
map
> > >> before what it points to is freed.
> > >>
> > >> With that,
> > >>
> > >> Reviewed-by: Rob Herring <robh@kernel.org>
> > >=20
> > > Thanks for the review. I will move it before "kfree(map)" in next
> > > version.
> >=20
> > Paul noticed that we already have a bug in assigning to this=20
> > unconditionally[1] - I'd totally forgotten about this series when I=20
> > theorised about IOMMU drivers wanting the information earlier, but=20
> > sweeping my inbox now only goes to show I was right to think of it :)
> >=20
> > We should really get something in as a fix independent of this series,=
=20
> > taking both angles into account.
>=20
> Thanks this info. Following your suggestion, Move this into the "if (!
> ret)". Then it is like this:

Thanks for preparing the change :)

>=20
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -163,8 +163,10 @@ int of_dma_configure_id(struct device *dev, struct
> device_node *np,
>  	dev->coherent_dma_mask &=3D mask;
>  	*dev->dma_mask &=3D mask;
>  	/* ...but only set bus limit if we found valid dma-ranges earlier */

Maybe the comment would need some update too, like:
/* ...but only set bus limit and map if we found valid dma-ranges earlier */

> -	if (!ret)
> +	if (!ret) {
>  		dev->bus_dma_limit =3D end;
> +		dev->dma_range_map =3D map;
> +	}
> =20
>  	coherent =3D of_dma_is_coherent(np);
>  	dev_dbg(dev, "device is%sdma coherent\n",
> @@ -172,6 +174,8 @@ int of_dma_configure_id(struct device *dev, struct
> device_node *np,
> =20
>  	iommu =3D of_iommu_configure(dev, np, id);
>  	if (PTR_ERR(iommu) =3D=3D -EPROBE_DEFER) {

And maybe one here, something like:
/* don't touch range map if it wasn't set from a valid dma-ranges */

> +		if (!ret)
> +			dev->dma_range_map =3D NULL;
>  		kfree(map);
>  		return -EPROBE_DEFER;
>  	}
> @@ -181,7 +185,6 @@ int of_dma_configure_id(struct device *dev, struct
> device_node *np,
> =20
>  	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> =20
> -	dev->dma_range_map =3D map;
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_configure_id);
>=20
>=20
> If this is ok, I will send this as a independent patch.

With the suggested changes, this looks good to me!

Thanks,

Paul

> >=20
> > Robin.
> >=20
> > [1]=20
> > https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be097c=
7ceb32@arm.com/
> >=20
> > >>
> > >>>   		return -EPROBE_DEFER;
> > >>>   	}
> > >>>  =20
> > >>> @@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, str=
uct device_node *np,
> > >>>  =20
> > >>>   	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> > >>>  =20
> > >>> -	dev->dma_range_map =3D map;
> > >>>   	return 0;
> > >>>   }
> > >>>   EXPORT_SYMBOL_GPL(of_dma_configure_id);
> > >>> --=20
> > >>> 2.18.0
> > >>>
> > >=20
> > > _______________________________________________
> > > iommu mailing list
> > > iommu@lists.linux-foundation.org
> > > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> > >=20
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--ZpZRInV+koQDOukd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmAGqFQACgkQ3cLmz3+f
v9E3gwf8CT7hHXO41OxQvi2MFcgYFzwhZZyobCae68dTmEbC4OQjOxfwex0hT0Fc
fSqWrI33YU977JQ5MA+ZDZKJ9LenssabEikucOUfCCaiTxjy+EK7Sn83ub51okw+
IHa+n83H1G5nwTHPP1fn40z97Lyvk9wgOGRGtkqOuzADCoQ1ouQ6j0m+/nN0xJme
ORP/0J4qvKaZJznz7yDSPNP6QQ4UHXmg8e9CU9Oo9L6IaqH75jOJ0EtZDTrvqetL
Y2AzrZSrGESdcqXGAgO0sPICDorDbvP9dFGTsCeZwuM2lpCyWFRhE4sCQAA86NtG
JsLC4pzVbtkIepjP8eXSMmJf93G32g==
=pOip
-----END PGP SIGNATURE-----

--ZpZRInV+koQDOukd--
