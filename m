Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109112FE32F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbhAUGqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbhAUGoe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:44:34 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051DCC061757;
        Wed, 20 Jan 2021 22:43:53 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DLtCC1Y1jz9sWf; Thu, 21 Jan 2021 17:43:51 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611211431;
        bh=ValQBPEAvTKeEODI/pbH9QBYku4uWa+xPyK7x/7MmUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=geRiSr+X2q4XJBA6E3et7WOyIf1KS3yjycOLDlhEXW2bGjR5TU/w+IOqkXJnN7EXi
         qTzywphksyC7u+9zEptquOqck66pgQRgV1HMtayt4ASEcxksTCll8MizAmy1pX8qRT
         2jIIDhfrfSDR+GzA0M2LGCDcQaDY0jEkHp0Es3ec=
Date:   Thu, 21 Jan 2021 17:37:44 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH V5 5/5] of: unittest: Statically apply overlays using
 fdtoverlay
Message-ID: <20210121063744.GL5174@yekko.fritz.box>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <a6b5e6ac-90ec-9571-4fce-de7344bfcee9@gmail.com>
 <20210121054340.e4do45uvdns5bl5f@vireshk-i7>
 <91dadafc-26e1-13c1-37a2-d05ebd7b151f@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sMZCuqyhuhd4ycTi"
Content-Disposition: inline
In-Reply-To: <91dadafc-26e1-13c1-37a2-d05ebd7b151f@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sMZCuqyhuhd4ycTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2021 at 11:55:08PM -0600, Frank Rowand wrote:
> On 1/20/21 11:43 PM, Viresh Kumar wrote:
> > Hi Frank,
> >=20
> > On 20-01-21, 23:34, Frank Rowand wrote:
> >> It should be possible to apply this same concept to copying overlay_ba=
se.dts
> >> to overlay_base_base.dts, removing the "/plugin/;" from overlay_base_b=
ase.dts
> >> and using an additional rule to use fdtoverlay to apply overlay.dtb on=
 top
> >> of overlay_base_base.dtb.
> >=20
> > Are you suggesting to then merge this with testcases.dtb to get
> > static_test.dtb
>=20
> no
>=20
> > or keep two output files (static_test.dtb from
> > testcases.dtb + overlays and static_test2.dtb from overlay_base.dtb
> > and overlay.dtb) ?
>=20
> yes, but using the modified versions ("/plugin/;" removed) of
> testcases.dtb and overlay_base.dtb.

I really don't understand why you want /plugin/ in *any* version of
testcases.dtb.
> >=20
> > Asking because as I mentioned earlier, overlay_base.dtb doesn't have
> > __overlay__ property for its nodes and we can't apply that to
> > testcases.dtb using fdtoverlay.
>=20
> Correct.
>=20
> I apologize in advance if I get confused in these threads or cause confus=
ion.
> I find myself going in circles and losing track of how things fit togethe=
r as
> I move through the various pieces of unittest.
>=20
> -Frank
>=20
> >=20
> >> Yes, overlay_base_base is a terrible name.  Just used to illustrate th=
e point.
> >>
> >> I tried this by hand and am failing miserably.  But I am not using the=
 proper
> >> environment (just a quick hack to see if the method might work).  So I=
 would
> >> have to set things up properly to really test this.
> >>
> >> If this does work, it would remove my objections to you trying to tran=
sform
> >> the existing unittest .dts test data files (because you would not have=
 to
> >> actually modify the existing .dts files).
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sMZCuqyhuhd4ycTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmAJITgACgkQbDjKyiDZ
s5JoJw//YUkQZsjhP5gU77SfykmZ3FE00Dtu+IFP70ak4Me9X9tqKTkcZ1GsPGqt
um9Hm8UPWietIolxe9hweYts0uPaKUD0UkVecTHbHKsX+f7yZUsDiosaimi4n7rk
QwANbaU7bXelVVqV9XMPkbI9RGhoPwuLjaDOYV9NjjlfIj49xRfmiIgZiKr4vWUQ
3sKW9omszIbg7OF57zQXzLxJNQMR+E1f7hsxS9jwyzXdRpIzT7rzATZ2BeToxtEQ
r48QUTChaFn9rVaMFufo5dSAvnvKYVioauXnT135tzLmWtiaNTTLpo84jx339rBO
hLqhZ9c0M//JGR4HQUJI98TEA0H/v+j7ASkPLPAnUxVYS7fmwuDx6UBzNLzmq9RY
6P7FjACmNELjT3GPZ1ZWonHW5NucovApCvzI5bmRXN8u1++pVnqcxE0XyN8Ceb9q
Pqy3L/V3XRqsB8/aMBxIUKemBm3p13m1Nd9+o7DXjJuDAN6JIh5FWfkPsiXFMgj9
gg+1A1RHQlpkhOKt925zjRnB6Opkfu4I76jzssWmWSlTwV2FN2Pc3wcegTzt5Uxk
jFKFXdVKGFGkPo4qrHr3q91zpcjy04yaN7DXo72ltmGNO1Nj40xjkjHYHRx/ol7h
hUa/x4w5N2gbNG30oKogbPupvORJtnfMGokWM1Nef4jPxJS8dIo=
=FcH8
-----END PGP SIGNATURE-----

--sMZCuqyhuhd4ycTi--
