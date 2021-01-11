Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217722F10C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbhAKLFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbhAKLFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:05:16 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1F9C06179F;
        Mon, 11 Jan 2021 03:04:36 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1007)
        id 4DDrSc72Mcz9sjD; Mon, 11 Jan 2021 22:04:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=gibson.dropbear.id.au; s=201602; t=1610363072;
        bh=QjrIJsy+sDTV8RqXTwVI4hjuHj+8s1FwQRQGdWnyhLY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IT2R5xfnNEn4LD7qbZZRnHCkajV+dxR1J/c6bSj4gX8I5OrDOeS4KAfEAypzwFWqo
         aaHnGl9NBIjCKjxo2poXyVeU3GbxLQtKT2rGP2v3CmUtmUvpJDtEX8m545HEoK3m/1
         LfNdbkR8UHiy/UD7wD2GUbPsQkLtY62gyrT11dTQ=
Date:   Mon, 11 Jan 2021 21:56:11 +1100
From:   David Gibson <david@gibson.dropbear.id.au>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     devicetree-compiler@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>, anmar.oueja@linaro.org
Subject: Re: [PATCH] dtc: Allow overlays to have .dtbo extension
Message-ID: <20210111105611.GD3051@yekko.fritz.box>
References: <30fd0e5f2156665c713cf191c5fea9a5548360c0.1609926856.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <30fd0e5f2156665c713cf191c5fea9a5548360c0.1609926856.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 06, 2021 at 03:26:08PM +0530, Viresh Kumar wrote:
> Allow the overlays to have .dtbo extension instead of just .dtb. This
> allows them to be identified easily by tools as well as humans.
>=20
> Allow the dtbo outform in dtc.c for the same.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Seems reasonable.  Applied.

>=20
> ---
> Hello,
>=20
> This was earlier posted for the Linux Kernel and here is the thread
> where Rob gave his feedback:
>=20
> https://lore.kernel.org/lkml/CAL_Jsq+0dL=3DLHo8r9mY_weBP_bQ97UOBnt596J3Jo=
VHwGNinHA@mail.gmail.com/
> ---
>  dtc.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/dtc.c b/dtc.c
> index bdb3f5945699..838c5df96c00 100644
> --- a/dtc.c
> +++ b/dtc.c
> @@ -122,6 +122,8 @@ static const char *guess_type_by_name(const char *fna=
me, const char *fallback)
>  		return "dts";
>  	if (!strcasecmp(s, ".yaml"))
>  		return "yaml";
> +	if (!strcasecmp(s, ".dtbo"))
> +		return "dtb";
>  	if (!strcasecmp(s, ".dtb"))
>  		return "dtb";
>  	return fallback;
> @@ -357,6 +359,8 @@ int main(int argc, char *argv[])
>  #endif
>  	} else if (streq(outform, "dtb")) {
>  		dt_to_blob(outf, dti, outversion);
> +	} else if (streq(outform, "dtbo")) {
> +		dt_to_blob(outf, dti, outversion);
>  	} else if (streq(outform, "asm")) {
>  		dt_to_asm(outf, dti, outversion);
>  	} else if (streq(outform, "null")) {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl/8LskACgkQbDjKyiDZ
s5LJRxAAyZuKDfckgaD4VT7+dn1SApdLNnYU/KlgjI4dU/PdBoTJefdZw0oncDn0
dTk1LawxDTmNpJUXR/Q587Y7aFWqYrVhc5Xb4SGKhCCH/MsEOYHKrgh3N2ffE1JG
KnZC6Cvze8pEzIZxn/Umqo90GRr561i1G0n+H8fZsgwfbVAR0j953Np6LJsfJUVn
9a6tRPuwPLR1IHZuNdd6aFa5N/XYSALmKr3CPHeuaE1BFfRUXdIaF7JTnZM3xMlw
/3Bc23x7BKlOml0epR9zdG4HHYRNdXCyrAzSdE5HonBiuRfTI2oZ5r+nb5hUQAP1
57aPfub2zrsgQMTxKQs6YnCsOyBLJHJaqzGy+DS1Ki1sH3pdbEi56TDe82oZeoGh
1/bEoRGx16gv9CatY63wyM7E31Du3l7XJC9lR/NwITuxMcVr/ywyKzrkw235KcA7
yjnJz5+fqCTHhMZ0VatGeeSuBzKAUhsBeyc3FU9EGhLB+hS2BXLwjuti37G+0wd3
38u5WWF/HVewxsFatLSQ1+Ivn8LDOHjMli/UUloYKuS6UzTYJddYsT5HL/sI6qO1
Ie1KYlnObcxXrMqwRftBO7ife9pfygQna+cBX6xbBFWM0+WgUYbvAwh3Usf0CTEH
nVFSURLCy3sALfkBd5S8cujqJq27//01JF1gHONWtNdMpVg1Co0=
=riIS
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
