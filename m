Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608353011DB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbhAWBGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbhAWBFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:05:50 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC38C0613D6;
        Fri, 22 Jan 2021 17:05:13 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DMybT2gT5z9sVF; Sat, 23 Jan 2021 12:05:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1611363909;
        bh=cw4MJLoL4iCYdM34JKiLrZohbnz8a07QlIEgA33G1Lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3WJV5yCmEgsdFeCJX2WLmNnOkWru83EjhgZ6mIX6OUppMEX9ltVeFDhUDFcF29s2
         xgQTAXCZh3P7iCW8ALyRUDswiY0tlWOSh1NMdIfrBLW6vp9Udjo2dIV8wnLFyfBraD
         noIXHdxx6i3IKcINyJIv0yugH/26KkU2kNSQ8VFc=
Date:   Sat, 23 Jan 2021 11:35:18 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, anmar.oueja@linaro.org,
        Bill Mills <bill.mills@linaro.org>, devicetree@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH V6 2/6] scripts: dtc: Build fdtoverlay tool
Message-ID: <20210123003518.GG4400@yekko.fritz.box>
References: <cover.1611312122.git.viresh.kumar@linaro.org>
 <2dfec4acb1bfbab08b431908ace0a77cc3279434.1611312122.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline
In-Reply-To: <2dfec4acb1bfbab08b431908ace0a77cc3279434.1611312122.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2021 at 04:20:32PM +0530, Viresh Kumar wrote:
> We will start building overlays for platforms soon in the kernel and
> would need fdtoverlay going forward. Lets start building it.
>=20
> The fdtoverlay program applies (or merges) one or more overlay dtb

Saying "merges" here is probably misleading, since as I mentioned
elsewhere fdtoverlay can *not* merge overlays, only apply them to a
base tree.

> blobs to a base dtb blob. The kernel build system would later use
> fdtoverlay to generate the overlaid blobs based on platform specific
> configurations.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  scripts/dtc/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
> index 4852bf44e913..5f19386a49eb 100644
> --- a/scripts/dtc/Makefile
> +++ b/scripts/dtc/Makefile
> @@ -1,13 +1,17 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # scripts/dtc makefile
> =20
> -hostprogs-always-$(CONFIG_DTC)		+=3D dtc
> +hostprogs-always-$(CONFIG_DTC)		+=3D dtc fdtoverlay
>  hostprogs-always-$(CHECK_DT_BINDING)	+=3D dtc
> =20
>  dtc-objs	:=3D dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>  		   srcpos.o checks.o util.o
>  dtc-objs	+=3D dtc-lexer.lex.o dtc-parser.tab.o
> =20
> +libfdt-objs	:=3D fdt.o fdt_ro.o fdt_wip.o fdt_sw.o fdt_rw.o fdt_strerror=
=2Eo fdt_empty_tree.o fdt_addresses.o fdt_overlay.o
> +libfdt		=3D $(addprefix libfdt/,$(libfdt-objs))
> +fdtoverlay-objs	:=3D $(libfdt) fdtoverlay.o util.o
> +
>  # Source files need to get at the userspace version of libfdt_env.h to c=
ompile
>  HOST_EXTRACFLAGS +=3D -I $(srctree)/$(src)/libfdt
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAmALb0QACgkQbDjKyiDZ
s5L25hAAzgErhIoUSWmqgWOJ/RWsxTyC1cH+mViBKq1puH2Uyezry9uiouop3tMo
upioTF0UnWcchq2AQCdEEa2XcnrFKNg/pVM3/qS4lqY2X0fZQN3gNwH6rh2/AzP4
TPjFv7ITQUtVuJtthzVXV7jnvRX1r2TyniP3NDI6nokopMjZYHyzxaz6d305wnjY
m6vCID+g7im9gDzNacN3vLU9l1Z863Fss03PXIKyBOkzTjm6i8V1sxAnUAHKS9Mp
7BE/YHz5ulHfw7iUIXMmVXJV1V4464qlRD+kt03AjcvrtIgQP59v54Pxo/EUjM/c
j0H8GyVUsP3XODKMDyI8Dv/dChsYmfVFIuk1QpHNLeeLwh6pLmpAJO5aqiuzYcMi
Z3O/CPyXXGYOO5kAyJZ6fkVP/BtaRe8IOyhQ92V0QllPIu8mKG9O/JVm5Uu+2qTY
ZAOrZHhQTjFhPJkq33N6BVV6+DcdLrPzChCzxtsx4jg2gGSI2FZVsMzbbFtrdZRP
C6DhhTjx/wP6/S32YdQdUje4/K3ocPH1Yr3xRYUgJAamwLApENhnKpQYIZV0/vfh
uLulef1EV1Fb13vxdku4sVKE3Fsrs4ytIFo54W/0TzsIcmD/rVQPH7hiF5c9tGib
TtaEgvRpI0Q10HTL+UApmHvtiT9JX6yAxDXE0QfIlBb4gl3lJ1w=
=J/iO
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--
