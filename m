Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1162FE326
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbhAUGov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:44:51 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42259 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbhAUGof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:44:35 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DLtCC0nF2z9sW1; Thu, 21 Jan 2021 17:43:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611211431;
        bh=pqa2zdPt+Ci9MoFpkyRGHHBGECXnxxdiWgKuuKz0eVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0TnzKHpGy1a8bGcXnHC5yJir2DWGcCSpVUqjNjMgkg2932Pl9FlNjER6tbDxWNyx
         fdSdTR1PCsHlm7D/aPVHX3cpTRjQJytkblbRN6HQwBzI0DNfOxsKdAGmV2fYwiBpXI
         c6gwVxeuD12Z3PXXswf7tQFMCR3DYLCZVCLG9/wA=
Date:   Thu, 21 Jan 2021 17:36:04 +1100
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
Message-ID: <20210121063604.GK5174@yekko.fritz.box>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <20210121053426.4dw5oqz7qb4y7hvm@vireshk-i7>
 <1cbafa2a-fe9e-04ec-35cc-d675a781a5b6@gmail.com>
 <20210121055040.eluxzb2uknuygkxz@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/rDaUNvWv5XYRSKj"
Content-Disposition: inline
In-Reply-To: <20210121055040.eluxzb2uknuygkxz@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/rDaUNvWv5XYRSKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 11:20:40AM +0530, Viresh Kumar wrote:
> On 20-01-21, 23:45, Frank Rowand wrote:
> > I have only the most surface knowledge of fdtoverlay, mostly from
> > "fdtoverlay --help", but you can apply multiple overlays with a
> > single invocation of fdtoverlay.  My _assumption_ was that the
> > overlays would be applied in order, and after any given overlay
> > was applied, subsequent overlays could reference the previously
> > applied overlay.
> >=20
> > Is my assumption incorrect?
>=20
> I think yes, if everything is in order then it should work just fine.
>=20
> I was only suggesting that fdtoverlay accepting the base overlay with
> /plugin/; may well be a requirement and so intentionally done.

No.  It's simply the result of the fact that a dtbo is still a dtb.
So, you can still apply an overlay to it.  However, a dtbo is a
weirdly structured dtb, so applying an overlay to it is very unlikely
to give you something useful.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--/rDaUNvWv5XYRSKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmAJINQACgkQbDjKyiDZ
s5JPkhAAkG/n4hfv2b18jI931aGpsGziNzw2ZD+g9/WIEGiXk9mVNIMmWFEPCxVE
6w7nz+OcoljS+S4UGs/koNzS35vvPfprnc6knL1axCLRjGSOZc8DUgP1CXTRFTOy
Nx1SzZ/ar2r6TurY4MxMGnuJcldkb/yOn9uOJ19g0J8vi10qLbj8aDziwqbgGIdC
AMszsRtl6MgZlj4i1yssEEC+BRVOo8dSayct3kF0pQD+JT9e64K8wqhnqOCyp+u4
qv3vgXtD/8MbI6d+Nln5uX6m6QeT0Po1bqNK+VymphBK2siXFMY66ELgY3dBxpBF
PFZhjxb4hM+ygcbd2aOyqluFB0zkXbkF16/h9VikmVq2ZGjswUg2Ft7XkQNqRxIV
ZwYZK99PcEyznj+G+nuwf11r1qnDN27GYJaG2zigMxtkjaQbc9uDVUUzj/RzN3/i
vgVU67ZX/89uv5oIa9pzKn4Qn6PN2VQE09vh1OfAQN1j20B2tfp4hQ5hPY0nzcqX
4HCjD+LQC9B2tKFG0Z/jS5XKdyd4vixOP+pHBYOzcuJlMeYJZzeRuNXXqco6lFls
tD0+EnKZSOOEISaprSN4aANhCPRfsxmbw38RemzsrTEysmZUFeGZe0HK4knRVEXE
349riclwgZCqhbxcgIk2dg1qezqvbSvVbf/GtsHBbikxCv138s0=
=MmwQ
-----END PGP SIGNATURE-----

--/rDaUNvWv5XYRSKj--
