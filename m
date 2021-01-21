Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02C82FF917
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbhAUXvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:51:05 -0500
Received: from ozlabs.org ([203.11.71.1]:39559 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbhAUXvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:51:01 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DMJzb5N6Fz9sCq; Fri, 22 Jan 2021 10:50:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611273019;
        bh=xTG5XVNkIwXcIiAOn1Fh5pms3H7iX51GWtP1XonaSjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DV7h3CklTlnLdAopTAmuPOVj7q70VyDJttUhgsJtrh4KV0+iZhxBUZm7zm0EzwKXO
         qo2KECZqaapbXISVcGbpyA0zlDEfpZ3gEMCh3P9HZiw+/x6mDJdzbX9ZEEeyo5P9r9
         PBidWmeYyWEYzFLdy2hJ3s1DCAnnHFsZH2MSphB8=
Date:   Fri, 22 Jan 2021 10:39:57 +1100
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
Message-ID: <20210121233957.GA4400@yekko.fritz.box>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <20210121053426.4dw5oqz7qb4y7hvm@vireshk-i7>
 <20210121063438.GJ5174@yekko.fritz.box>
 <20210121065728.trqph5uwvp43k46l@vireshk-i7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
In-Reply-To: <20210121065728.trqph5uwvp43k46l@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 12:27:28PM +0530, Viresh Kumar wrote:
> On 21-01-21, 17:34, David Gibson wrote:
> > No, this is the wrong way around.  The expected operation here is that
> > you apply overlay (1) to the base tree, giving you, say, output1.dtb.
> > output1.dtb is (effectively) a base tree itself, to which you can then
> > apply overlay-(2).
>=20
> Thanks for the confirmation about this.
>=20
> > Merging overlays is
> > something that could make sense, but fdtoverlay will not do it at
> > present.
>=20
> FWIW, I think it works fine right now even if it not intentional.

No, it definitely will not work in general.  It might kinda work in a
few trivial cases, but it absolutely will not do the neccessary
handling in some cases.

> I
> did inspect the output dtb (made by merging two overlays) using
> fdtdump and it looked okay.

Ok.. but if you're using these bizarre messed up "dtbs" that this test
code seems to be, I don't really trust that tells you much.

> But yeah, I understand that we shouldn't
> do it.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmAKEMsACgkQbDjKyiDZ
s5JD6BAAxyJ8gCpeVBw1QexzPlEm23rvxieWePGJcbRk5vFPn1ecYzxa1yT+vBqu
vX2V14IkHWelaymeLHhq42wWwG1tIszLMXl5zV34MBBpyG4VlQKRWAKAi4aY/kwc
FNpsXTo8fIOwkkWJsg0IQaXW7I8hy4og5SQHjpSXCTc0t2M9tyYQhhfr5CB73hbs
/hxQ1uyoRaXXow5m0dkr8OMs8L8ci6rUujC8cIatADyLHZ6aB5S0BraosibJ4n1W
+MfxW2qrpZl+7fiwH00BOxUG0FTFpdic6JZz7y4cSq5bNRHSw56qM9rRSO73bzLj
351cnSETFSPOcT3auBPQglbRyeeLHBXxmbI4p/Rv7k9sxWmEjX6kxDwLPRx/SJiq
mDSJXDLXCAj/XChzjFexCb0mArOOqzMowBNFLbrmRNSOTzs+jAKvKO05IyS5wwRp
4uwgXPM6dfT4U/eQ4M7Zls3OG6cSQP14MIkwZoy+LNxKMxvi4rryfEkfOeqwUlYC
koQOSHRuH6Y24PlVsQfgf5pVU7vQf8NzYulhlXbRc13OFVH2QLTQxcNhjb6inKSH
J1Yq9APmU27Cm7sAO26KnPfnzHHz04wtnKpoKVqDNOHDhKOepQr1MWxxX1xHS9vB
sxSRdOLn10lsycUP506Y59DnPwYhFUalrztsBu8Jc9MtE//wW7w=
=Ttey
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
