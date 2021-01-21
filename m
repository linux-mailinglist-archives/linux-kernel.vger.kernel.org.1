Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6919B2FF918
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 00:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbhAUXvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 18:51:09 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:43407 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbhAUXvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 18:51:02 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DMJzb64BMz9sB4; Fri, 22 Jan 2021 10:50:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611273019;
        bh=Fft6pWIJCCE1z0Xgrl/5owEfMcAMg0noSxLROl4cxvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kooLkeky/2rOolxJVwXBIx4krNxon30ZQvzeCTqsDq++Y7jscpc/ccnl4cGcu2WP/
         hGVPigYyrNPk7mrHwQZRyXFQmtdvcHG+K070zkF+FP2rwZuqSh6AmDYZDs48ZBuyqQ
         e070wakrBkJW2wNRQLdPWKkZBDp7IwNXE+TiWE2U=
Date:   Fri, 22 Jan 2021 10:41:38 +1100
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
Message-ID: <20210121234138.GB4400@yekko.fritz.box>
References: <cover.1611124778.git.viresh.kumar@linaro.org>
 <696c137461be8ec4395c733c559c269bb4ad586e.1611124778.git.viresh.kumar@linaro.org>
 <20210121005145.GF5174@yekko.fritz.box>
 <7d6adfd9-da1e-d4ca-3a04-b192f0cf36b0@gmail.com>
 <a6b5e6ac-90ec-9571-4fce-de7344bfcee9@gmail.com>
 <20210121054340.e4do45uvdns5bl5f@vireshk-i7>
 <91dadafc-26e1-13c1-37a2-d05ebd7b151f@gmail.com>
 <20210121055820.e5z3uykfttvxffhe@vireshk-i7>
 <3431c306-a62c-76c6-f236-fef35fa7ebc7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline
In-Reply-To: <3431c306-a62c-76c6-f236-fef35fa7ebc7@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2021 at 01:04:46AM -0600, Frank Rowand wrote:
> On 1/20/21 11:58 PM, Viresh Kumar wrote:
> > On 20-01-21, 23:55, Frank Rowand wrote:
> >> yes, but using the modified versions ("/plugin/;" removed) of
> >> testcases.dtb and overlay_base.dtb.
> >=20
> > Okay, that would work fine I guess. I will try to implement this in
> > the new version.
> >=20
> >> I apologize in advance if I get confused in these threads or cause con=
fusion.
> >> I find myself going in circles and losing track of how things fit toge=
ther as
> >> I move through the various pieces of unittest.
> >=20
> > Me too :)
> >=20
> > Today is the first time where we have some overlap in our work hours
> > (probably you working late :)), and we are able to get this sorted out
> > quickly enough.
>=20
> Working quite late.  I swear I stopped working 3 hours ago and that was
> already late.
>=20
> I reacted quite negatively to the attempt to restructure the unittest
> .dts file in the original patch.  Now after walking around the problem
> space a bit, and reviewing the ugly things that unittest.c does, and
> coming up with the approach of sed to copy and modify the two base
> .dts files, I think I finally have my head wrapped around an easier
> and cleaner approach than sed.
>=20
> I'll describe it for just one of the two base files, but the same
> concept would apply to the other.  Don't take my file names as
> good suggestions, I am avoiding using the brain power to come up
> with good names at the moment.
>=20
> 1) rename overlay_base.dts to overlay_base.dtsi
>=20
> 2) remove "/dtgs-v1/" and "/plugin/:" from overlay_base.dtsi
>=20
> 3) create a new overlay_base.dts:
>    // SPDX-License-Identifier: GPL-2.0
>    /dts-v1/;
>    /plugin/;
>    #include overlay_base_dtsi

"overlay_base" is a terrible name - it's not clear if it's supposed to
be a base tree or an overlay.  I'm still not seeing any reasonable
use for the plugin version either, fwiw.

>=20
> 4) create a new file overlay_base_static.dts:
>    // SPDX-License-Identifier: GPL-2.0
>    /dts-v1/;
>    #include overlay_base_dtsi
>=20
> 5) then use overlay_base_static.dtb as the base blob for ftdoverlay
>    applying overlay.dtb
>=20
> Untested, hand typed, hopefully no typos.
>=20
> -Frank
>=20
> >=20
> > Thanks for your feedback Frank.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmAKETEACgkQbDjKyiDZ
s5K0yhAAwCkVaxbqv5aRtfwY6wUEEovCVfjUbUAFMENyD/850dxeErl53pywQr2+
9cidj/u+uSQVD5rKCUeliO0WmEXaVjxmmW3OY2uLmIRGaBzUihSpO/0qN+fW0voZ
MIziJp1wIjU8EgRyippocI6O8yRD5Csb/NLABle+38ayf9HoQoWDO4EE0TQVOxXC
zd29gYy89sKtZMb+2cOI1HJYZC5eqcRYHH9t1TB8J4TFoB7j3RFBL/Un92254XtQ
GKHMN/eAUlHeK0RN1wSrVr6ZNBUl05GZWaKdbrcHxXPVaz/qN8Ch093wJ/BqIwWO
1CW9Nmr+0lON5xf9ecvn/olHcHIc+V2pYJYgu8IZ9d33uOMYZxibDgxv8l1lS3sy
31G52JlTV9HzgEpNuMjjgXUF1tcg12cTUyCJ+t0AkjoR8nnhD3WF4+R9x90dUaYo
NXwT0CgLq7KhTch9g9H7vMqgL/9HK/qhomXormm2lB6bOsN8EIdNkhZ5nJxBqZS4
nxmABnIpJR1R1gEIffVX0Zi9z7+WxLCsF5IOtMOUCCsP0wbF9bFgTFLdH8KWsoku
NECFIj65EXYJ1XyJ1IOBn/YmSZ231qQ6kR26N5achOMDHEf3s1iq8T+mXE4/JOm8
R9lEEdylp5qxOyoN4xIdtftobxOIylezGinenbxHQhf2A5OhkjE=
=CRoR
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
