Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434032FE32B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbhAUGpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:45:36 -0500
Received: from ozlabs.org ([203.11.71.1]:38525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbhAUGog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:44:36 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DLtCB6Lv7z9sRR; Thu, 21 Jan 2021 17:43:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611211430;
        bh=7D2iM5ol0oQXma1CA9p7NiGgC5W035XE4aOk2Xmry8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RQfOYrX8+zmVI4/7f8vppDZf7NEO3LNTO9HSEB7xv7aks75Pxeikar4Y5w1ARXO1d
         MBzcmr0IWhqhkpPpAF3Fl/+3QyVD9EJsKYWb41gPlKbCAlnpHHIjs+3ArYdnyWaZ3M
         oxYNr46mY1pULRcoIjyvqJCc1sgYcc6+UTALyKTw=
Date:   Thu, 21 Jan 2021 17:34:38 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210121063438.GJ5174@yekko.fritz.box>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <20210121053426.4dw5oqz7qb4y7hvm@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRtZRu2mMGBZ6YQ7"
Content-Disposition: inline
In-Reply-To: <20210121053426.4dw5oqz7qb4y7hvm@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRtZRu2mMGBZ6YQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 11:04:26AM +0530, Viresh Kumar wrote:
> On 20-01-21, 23:14, Frank Rowand wrote:
> > It is a convenient FDT to use because it provides the frame that the ov=
erlays
> > require to be applied.  It is fortunate that fdtoverlay does not reject=
 the use
> > of an FDT with overlay metadata as the base blob.
>=20
> > This is probably a good idea instead of depending on the leniency of fd=
toverlay.
>=20
> I believe fdtoverlay allows that intentionally, that would be required
> for the cases where we have a hierarchy of extension boards or
> overlays.

Um.. no.

> A platform can have a base dtb (with /plugin/;), then we can have an
> overlay (1) for an extension board (with /plugin/;) and then an
> overlay (2) for an extension board for the previous extension board.
>=20
> In such a case overlay-(2) can't be applied directly to the base dtb
> as it may not find all the nodes it is trying to update. And so
> overlay-(2) needs to be applied to overlay-(1) and then the output of
> this can be applied to the base dtb.

No, this is the wrong way around.  The expected operation here is that
you apply overlay (1) to the base tree, giving you, say, output1.dtb.
output1.dtb is (effectively) a base tree itself, to which you can then
apply overlay-(2).

What you're talking about is "merging" overlays: combingin overlay (1)
and (2) into overlay-(X) which would have the same effect applied to
base.dtb as (1) and (2) applied in sequence.  Merging overlays is
something that could make sense, but fdtoverlay will not do it at
present.

> This is very similar to what I tried with the intermediate.dtb
> earlier.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--wRtZRu2mMGBZ6YQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmAJIH4ACgkQbDjKyiDZ
s5KrnRAAgnRANEqiGa9LnP9kEhlZSHac8+LrVLbu/NYiWSkmK30e98XIlTxGgeOf
1A+sOQpK7QoZw4SVtsA5QCYA69fio1FLxjaJIs8fJPQuNXqiH/6S0riH7BtdqFQ0
r1NGrgHaL2nFpuVm2HH7pAyg3TEpYhgx0SWxVbdjXHDQl5E/JoL3zhoh40H0ur45
Ef1tNNaHZKoK8fJBm0l/rTUxSW8oMVZ3+wiMawR+Z3sGQnn1+NFU2aRRN/W4gPc0
2eUliZoZwxWSFWziOEyJxiNqSuYlGqtQ/G3JeVkrvZAGHM08+Q4sPK3H7/En8v8o
wvcT2CV92YRX3+g1HALUfJ+Nw9xq6fZhap56iVEp7xHNg1tM3kMzHtJLLlTpDMJW
qHqXZTUsY3fJe/VnZ+mm9Z9QlzQpRyR+nkM+xKVKs4LqoheM5VMP0PXY0F5OZ1XP
v9I2UaBId99AW4M6fPOVZ9Gj/DwKlbi2sBxl9m6qPK8zcA6DCA7wc3g1Pr4hyEl4
kYKTvw3vUKOBTE7wcW6WDvqbIuVFq0piqoIaWb58t4i5nT9wM+P3KAzZqRXNLxmV
MF5cAduCI1j5cCyRHTy61mJ7dE1blzCLpd0thggr3o9NaTLwBfMcc4WofSYlPvp3
3syXvfdu4yPZHGatVCQxnK1FOvAhecacMMINM7WXwR7zt6K4ugE=
=0YJH
-----END PGP SIGNATURE-----

--wRtZRu2mMGBZ6YQ7--
