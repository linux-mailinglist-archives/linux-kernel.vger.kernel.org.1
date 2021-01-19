Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE3F2FB4D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 10:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbhASJKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:10:01 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:59533 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731669AbhASJF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:05:27 -0500
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 4AD73C002A;
        Tue, 19 Jan 2021 09:04:28 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:04:27 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH 1/2] of: device: Allow DMA range map to be set before
 of_dma_configure_id
Message-ID: <YAagmzfPXTW4Jlg0@aptenodytes>
References: <20210115175831.1184260-1-paul.kocialkowski@bootlin.com>
 <ddf44e96-187b-91c0-822d-ade4f1e5be2b@arm.com>
 <YAMdZ9peWRMRACv2@collins>
 <5c7946f3-b56e-da00-a750-be097c7ceb32@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VWPV4+qJKHV+hHEv"
Content-Disposition: inline
In-Reply-To: <5c7946f3-b56e-da00-a750-be097c7ceb32@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VWPV4+qJKHV+hHEv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Robin,

On Mon 18 Jan 21, 13:27, Robin Murphy wrote:
> On 2021-01-16 17:07, Paul Kocialkowski wrote:
> > Hi Robin,
> >=20
> > Le Sat 16 Jan 21, 14:57, Robin Murphy a =C3=A9crit :
> > > On 2021-01-15 17:58, Paul Kocialkowski wrote:
> > > > A mechanism was recently introduced for the sunxi architecture where
> > > > the DMA offset for specific devices (under the MBUS) is set by a co=
mmon
> > > > driver (sunxi_mbus). This driver calls dma_direct_set_offset to set
> > > > the device's dma_range_map manually.
> > > >=20
> > > > However this information was overwritten by of_dma_configure_id, wh=
ich
> > > > obtains the map from of_dma_get_range (or keeps it NULL when it fai=
ls
> > > > and the force_dma argument is true, which is the case for platform
> > > > devices).
> > > >=20
> > > > As a result, the dma_range_map was always overwritten and the mecha=
nism
> > > > could not correctly take effect.
> > > >=20
> > > > This adds a check to ensure that no previous DMA range map is
> > > > overwritten and prints a warning when the map was already set while
> > > > also being available from dt. In this case, the map that was already
> > > > set is kept.
> > >=20
> > > Hang on, the hard-coded offset is only intended to be installed when =
there
> > > *isn't* anything described in DT, in which case of_dma_get_range() sh=
ould
> > > always bail out early without touching it anyway. This sounds like
> > > something's not quite right in the MBUS driver, so I don't think work=
ing
> > > around it in core code is really the right thing to do.
> >=20
> > That's right, there is no practical case where the two are in conflict.
> > The problem that I'm solving here is that dev->dma_range_map is *always*
> > assigned, even when of_dma_get_range bailed and map still is NULL.
> >=20
> > This has the effect of always overwriting what the MBUS driver does
> > (and leaking its memory too).
>=20
> Oh, I should have looked closer at of_dma_configure_id() itself. I was
> assuming that b4bdc4fbf8d0 had been tested and at least *could* work, but
> apparently not :/
>=20
> Indeed it seems there was a fundamental oversight in e0d072782c73
> ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset"),
> equivalent to the same one I previously made myself with bus_dma_mask and
> fixed in 6778be4e5209 ("of/device: Really only set bus DMA mask when
> appropriate"). I think same simpler fix is the right one for this case to=
o,
> i.e. just move the assignment to dev->dma_range_map up under the "if (!re=
t)"
> condition. Assigning it this late - after the IOMMU and arch setup - looks
> wrong anyway, even if it isn't currently an issue in practice (in princip=
le
> an IOMMU driver *could* start trying to figure out reserved regions around
> DMA windows for a device as early as its .of_xlate callback, even though
> that's not the intent of the API design).

Okay sounds good, I'll resend a patch with the assignment under if (!ret)!

> Luckily dma_range_map hasn't been hooked up in the equivalent ACPI path y=
et,
> so you're off the hook for fixing that too :)

Good for me :)

Cheers,

Paul

> > > Do you have a case where one of the relevant devices inherits a "dma-=
ranges"
> > > via the regular hierarchy without indirecting via an "interconnects"
> > > reference? Currently you're only checking for the latter, so that wou=
ld be
> > > one way things could go awry (although to be a problem, said "dma-ran=
ges"
> > > would also have to encode something *other* than the appropriate MBUS
> > > offset, which implies an incorrect or at least inaccurately-structure=
d DT as
> > > well).
> >=20
> > No, I think things are good in that regard. No messed up dt or anything=
 like
> > that :)
> >=20
> > Cheers,
> >=20
> > Paul
> >=20
> > > Robin.
> > >=20
> > > > Fixes: b4bdc4fbf8d0 ("soc: sunxi: Deal with the MBUS DMA offsets in=
 a central place")
> > > > Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> > > > ---
> > > >    drivers/of/device.c | 9 ++++++++-
> > > >    1 file changed, 8 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/of/device.c b/drivers/of/device.c
> > > > index aedfaaafd3e7..db1b8634c2c7 100644
> > > > --- a/drivers/of/device.c
> > > > +++ b/drivers/of/device.c
> > > > @@ -181,7 +181,14 @@ int of_dma_configure_id(struct device *dev, st=
ruct device_node *np,
> > > >    	arch_setup_dma_ops(dev, dma_start, size, iommu, coherent);
> > > > -	dev->dma_range_map =3D map;
> > > > +	if (!dev->dma_range_map) {
> > > > +		dev->dma_range_map =3D map;
> > > > +	} else if (map) {
> > > > +		dev_warn(dev,
> > > > +			 "DMA range map was already set, ignoring range map from dt\n");
> > > > +		kfree(map);
> > > > +	}
> > > > +
> > > >    	return 0;
> > > >    }
> > > >    EXPORT_SYMBOL_GPL(of_dma_configure_id);
> > > >=20
> >=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--VWPV4+qJKHV+hHEv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmAGoJsACgkQ3cLmz3+f
v9EHhwf/elOyvLNl99Y6DkOE0jrgwROy6MwAy6sEWzlI8Ks3G9JqNi7yLpQ3A1Ak
0TvY9aChoHCSaoKMC/GoyxdbZrP662sELa4833LTLXNoLC7SZLMsqGeYDVriCA7p
VBJC4kJNyHXknWLDF4NMEe0m7UApXI7bmckz+eImWYiQQJvw8JHKTgnzTt8NDfHw
E5auZMZvtj5JJI2u9NriJUZeFxnwo4a9izHHTNsWWkWXXLZAieG3PCI+rdrOObmG
9W2e1FdctysCIFwzRRFTn2t9u1j9+epnFTNw+C1BueuUKCM/Q6ZGHbOeEveakbas
58uZgm9ppLgEZdCgFjduv7F1hjajvA==
=j/jd
-----END PGP SIGNATURE-----

--VWPV4+qJKHV+hHEv--
