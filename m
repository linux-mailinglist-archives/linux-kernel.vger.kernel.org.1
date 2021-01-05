Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D272EADD6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbhAEPBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:01:01 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45291 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbhAEPBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:01:01 -0500
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id DDD2B6000A;
        Tue,  5 Jan 2021 15:00:17 +0000 (UTC)
Date:   Tue, 5 Jan 2021 16:00:17 +0100
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Simon Ser <contact@emersion.fr>,
        devicetree <devicetree@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v8 4/4] NOTFORMERGE: drm/logicvc: Add plane colorkey
 support
Message-ID: <X/R/AY7YXBEyWNG1@aptenodytes>
References: <20201223212947.160565-1-paul.kocialkowski@bootlin.com>
 <20201223212947.160565-5-paul.kocialkowski@bootlin.com>
 <oDsOkjfTYKa11LxfNy4LBLqutkVidfFn8--tjQPZj4w9gzCYNTOFglHqxXohsrYqTJ4uDv2xgJNKXPHzgAsACGnCkbKQis95SScGucOb1PI=@emersion.fr>
 <CAKb7UvhgHPkG5Sn-HLdpsFw0R=kATJKUmjSwPSuwviDCk0RGyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OSDOGVu8nZtJl5tY"
Content-Disposition: inline
In-Reply-To: <CAKb7UvhgHPkG5Sn-HLdpsFw0R=kATJKUmjSwPSuwviDCk0RGyw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OSDOGVu8nZtJl5tY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed 23 Dec 20, 18:31, Ilia Mirkin wrote:
> FWIW this is something I added, hoping it was going to get used at
> some point, but I never followed up with support in xf86-video-nouveau
> for Xv. At this point, I'm not sure I ever will. I encoded the
> "enabled" part into the value with a high bit (1<<24) -- not sure that
> was such a great idea. All NVIDIA hardware supports colorkey (and not
> actual alpha, until the very latest GPUs - Volta/Turing families),
> although my implementation only covers the pre-G80 series (i.e. DX9
> and earlier GPUs - pre-2008). Should a determination of usefulness be
> reached, it would be easy to implement on the remainder though.

Interesting to know!

Regarding a generic colorkey property, there was a discussion under thread:
drm: Add generic colorkey properties for display planes

and the latest proposal (RFC v4) can be found here:
https://patchwork.ozlabs.org/project/linux-tegra/patch/20180807172202.1961-=
2-digetx@gmail.com/

It looks like this was much more complex than anticipated and the series
was more or less abandonned. I didn't feel like picking it up in my logicvc
series so I kept the colorkey patch as not for merge.

If someone's up for picking the proposal and continuing the discussion,
I could provide insight on how it would fit with logicvc though!

Cheers,

Paul

> On Wed, Dec 23, 2020 at 5:20 PM Simon Ser <contact@emersion.fr> wrote:
> >
> > nouveau already has something for colorkey:
> > https://drmdb.emersion.fr/properties/4008636142/colorkey
> >
> > I know this is marked "not for merge", but it would be nice to discuss
> > with them and come up with a standardized property.

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--OSDOGVu8nZtJl5tY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl/0fwEACgkQ3cLmz3+f
v9HOhgf8DU4twNl4hL4kO9201ULcHXezYqI7Ep2Kv9H4WmGOQHCYsz0Orr6KL8x7
xWdRsnet9x2vfN4UZRBRmSiXv2SA8nQL2TZHWH/VKyrwxmOD4Btt9C+qs0YWhfii
XfvU0IGYI8Y10uA03JTB44BfiXn409OR7otd1abp9/cO0GAf3zspshGdVuWST4wh
SgglQZvdpYQljgQJjIcmGJvwJ9hQ1Eyk1+XnBLFLBvZrsrrVgqboKRDSrJ28i+p2
fJIf2TSAzIdLnJbNBx77dRDiHTuHQlsdpOYomZyeeBPqcYvwiHBhJgE87JO27w03
OlOzyMecE1vud4/LLA7ySAHGczWt6Q==
=Ahth
-----END PGP SIGNATURE-----

--OSDOGVu8nZtJl5tY--
