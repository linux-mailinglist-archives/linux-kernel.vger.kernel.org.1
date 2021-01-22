Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455322FFC0A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 06:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbhAVFSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 00:18:32 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:40069 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbhAVFSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 00:18:24 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DMSFF71C7z9sCD; Fri, 22 Jan 2021 16:17:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611292657;
        bh=i1DcXl93lSfMMtoG7izlw54QZ4IZck6Ry2AtX9KRgPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UqHqjq6bzprqJxazvkReHWJiX28Cvjf9bL2Tkb1UmszDRPFcWedidS77w6SzNYYol
         Czjn/80/HCx9+bNPk2Zv97XxM9pP55kZlensX1RAXbej0VW32vwkecbTLIdV006nrK
         Q1bdI0RA9r17bMKuKngrAzOgV+c0c5iy3pgjIszM=
Date:   Fri, 22 Jan 2021 15:27:04 +1100
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
Message-ID: <20210122042704.GC4400@yekko.fritz.box>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <20210121053426.4dw5oqz7qb4y7hvm@vireshk-i7>
 <20210121063438.GJ5174@yekko.fritz.box>
 <20210121065728.trqph5uwvp43k46l@vireshk-i7>
 <20210121233957.GA4400@yekko.fritz.box>
 <20210122031049.u3nmxxzzhue5rniu@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <20210122031049.u3nmxxzzhue5rniu@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CblX+4bnyfN0pR09
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2021 at 08:40:49AM +0530, Viresh Kumar wrote:
> On 22-01-21, 10:39, David Gibson wrote:
> > No, it definitely will not work in general.  It might kinda work in a
> > few trivial cases, but it absolutely will not do the neccessary
> > handling in some cases.
> >=20
> > > I
> > > did inspect the output dtb (made by merging two overlays) using
> > > fdtdump and it looked okay.
> >=20
> > Ok.. but if you're using these bizarre messed up "dtbs" that this test
> > code seems to be, I don't really trust that tells you much.
>=20
> I only looked if the changes from the second overlay were present in
> the merge and they were. And so I assumed that it must have worked.
>=20
> What about checking the base dtb for /plugin/; in fdtoverlay and fail
> the whole thing in case it is present ? I think it is possible for
> people to get confused otherwise, like I did.

/plugin/ doesn't exist in the dtb, only in the dts.  From the dtb
encoding point of view, there's no difference between a dtb and a
dtbo, a dtbo is just a dtb that follows some conventions for its
content.

If we were doing this from scratch, it would be better for dtbos to
have a different magic number from regular dtbs.  I think I actually
suggested that sometime in the past, but by the time that came up,
dtbos were already in pretty widespread use with the existing format.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmAKVBYACgkQbDjKyiDZ
s5KBwBAAhmYCf1xBVR2o9aVhiRoPo6T65geIcthIYGsA07vLvsabGOHv+F5LemnK
lHpfG9C1SFrkrpI1Eb/Es1cRTX66p+Ih3CJTjCcjuPlLBrRJo/x3d4SvgbyLz0pJ
jW/BjU2ft5DJHC8fZX2q0jSXULR4yw1Uyme6v0X5kXjHbvRfyCUd4pDwb+pQRWjG
7bwYQgDadQ8z0JS2N7IH93vdZdj0mYEjVsVBctebglTqE6O13xdWdkSunTcvRWhf
XUtWbCoiCCJ5qZn7Wr7vrcS+fBagJZSyE6rAVCcDXIbuu1iV2tN4hlM+9j7pft/J
ddMGaObnk6cXunLlhUu5Kd+ELBy7A1k9BlVLE6ssgArJ3P39vYke6ZhjapFM0Vdq
FEEivxZ9SAx527O+lzAIkOWAWH7ilfY3R3jYF/5lpThQ+DSYUdsQJshocTzaM1jr
yQAhjoKgjJ1bVh5cuRd857pnkclpwotIVoVNblFtfAswj1VKDKRx01gWRhrHXsdP
nQ2U05uSTYBA7S+N5gB1geQeNyIsQWq7fQkizaIB4NTsso8OrxOUN5VHcK2AJSTF
8XMyUVbx2efitQDi8RmJjlUG+h7/hVk/vO9ODz42CYSPFGKUDmDS7xc0Yg9xnunZ
OPbFVKJUTqEkY03S1Iw7OT50w5RJnTfIliLjE7uarzyiUQ2Y7m0=
=B+Jq
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
