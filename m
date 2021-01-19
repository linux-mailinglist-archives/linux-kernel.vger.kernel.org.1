Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37F42FB6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbhASJ1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:27:08 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:33029 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbhASJN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:13:58 -0500
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 702B24001D;
        Tue, 19 Jan 2021 09:13:11 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:13:10 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh@kernel.org>,
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
Message-ID: <YAaipp7Srf6uUdFZ@aptenodytes>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
 <20210111111914.22211-7-yong.wu@mediatek.com>
 <20210114192732.GA3401278@robh.at.kernel.org>
 <1610688626.4578.1.camel@mhfsdcap03>
 <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9JUkddB3RODiIlTw"
Content-Disposition: inline
In-Reply-To: <1853732d-0efd-171e-9e1f-7ee7ed72a98f@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9JUkddB3RODiIlTw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon 18 Jan 21, 15:49, Robin Murphy wrote:
> On 2021-01-15 05:30, Yong Wu wrote:
> > On Thu, 2021-01-14 at 13:27 -0600, Rob Herring wrote:
> > > On Mon, Jan 11, 2021 at 07:18:47PM +0800, Yong Wu wrote:
> > > > "dev->dma_range_map" contains the devices' dma_ranges information,
> > > > This patch moves dma_range_map before of_iommu_configure. The iommu
> > > > driver may need to know the dma_address requirements of its iommu
> > > > consumer devices.
> > > >=20
> > > > CC: Rob Herring <robh+dt@kernel.org>
> > > > CC: Frank Rowand <frowand.list@gmail.com>
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >   drivers/of/device.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > > index aedfaaafd3e7..1d84636149df 100644
> > > > --- a/drivers/of/device.c
> > > > +++ b/drivers/of/device.c
> > > > @@ -170,9 +170,11 @@ int of_dma_configure_id(struct device *dev, st=
ruct device_node *np,
> > > >   	dev_dbg(dev, "device is%sdma coherent\n",
> > > >   		coherent ? " " : " not ");
> > > > +	dev->dma_range_map =3D map;
> > > >   	iommu =3D of_iommu_configure(dev, np, id);
> > > >   	if (PTR_ERR(iommu) =3D=3D -EPROBE_DEFER) {
> > > >   		kfree(map);
> > > > +		dev->dma_range_map =3D NULL;
> > >=20
> > > Not really going to matter, but you should probably clear dma_range_m=
ap
> > > before what it points to is freed.
> > >=20
> > > With that,
> > >=20
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >=20
> > Thanks for the review. I will move it before "kfree(map)" in next
> > version.
>=20
> Paul noticed that we already have a bug in assigning to this
> unconditionally[1] - I'd totally forgotten about this series when I
> theorised about IOMMU drivers wanting the information earlier, but sweepi=
ng
> my inbox now only goes to show I was right to think of it :)
>=20
> We should really get something in as a fix independent of this series,
> taking both angles into account.

Okay, I can also fix this while fixing my case. So we'd go for setting
dev->dma_range_map =3D map; under the if (!ret).

Then I think the error case for of_iommu_configure should be to set
dev->dma_range_map =3D NULL; only if map !=3D NULL (otherwise we'd be overw=
riting
and leaking the previously-set map).

I think a comment to remind that dev->dma_range_map can be set prior to this
function would be useful too.

What do you think?

Cheers,

Paul

> Robin.
>=20
> [1] https://lore.kernel.org/linux-arm-kernel/5c7946f3-b56e-da00-a750-be09=
7c7ceb32@arm.com/
>=20
> > >=20
> > > >   		return -EPROBE_DEFER;
> > > >   	}
> > > > @@ -181,7 +183,6 @@ int of_dma_configure_id(struct device *dev, str=
uct device_node *np,
> > > >   	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> > > > -	dev->dma_range_map =3D map;
> > > >   	return 0;
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(of_dma_configure_id);
> > > > --=20
> > > > 2.18.0
> > > >=20
> >=20
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> >=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--9JUkddB3RODiIlTw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmAGoqYACgkQ3cLmz3+f
v9GonQf/efUk6Macghd2ipStYZpoRfxYwHOuemUNFudMoUEZ3WfF8oq65Qp+I6jx
5f0iHYTgcPXsTDkMgyPINgSmcuagEYEDUH+IkPoJBvZZ8T2/oI5E0y4xGbbpLtfK
hGfAg1spG4E0akpjq/2wNSYkiUiVIdXsFHPXrMNez3j0Z8VJKTBoETeb88QoAOaJ
KtcJHmcIW3Gi2fYp/EMBbe+oMbairUCcnnqXZLZjYRSfHl+4EpH9T/FmaI2rtgoE
xXedTQFz7axYSXPqHR0WWkg0P876yNO+jkd387VvBvC9AxZYMyFngHVDYM4e4Edx
eE2MYAMyuHp/V4AlneqACADHWyS/oQ==
=2EGZ
-----END PGP SIGNATURE-----

--9JUkddB3RODiIlTw--
