Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810882B213A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgKMRAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKMRAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:00:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4766C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:00:47 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdcRK-00084V-DL; Fri, 13 Nov 2020 18:00:46 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kdcRJ-0005BI-MB; Fri, 13 Nov 2020 18:00:45 +0100
Date:   Fri, 13 Nov 2020 18:00:43 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/2] checkpatch: document the function renaming and
 deprecation around devm_ioremap_resource
Message-ID: <20201113170043.osr63jash7anc3xn@pengutronix.de>
References: <20201113085327.125041-1-u.kleine-koenig@pengutronix.de>
 <20201113091157.125766-1-u.kleine-koenig@pengutronix.de>
 <fe5ad7c72eadac32eda6a41b61feaa42c04392b0.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wtj7d2m3pw3mnq7d"
Content-Disposition: inline
In-Reply-To: <fe5ad7c72eadac32eda6a41b61feaa42c04392b0.camel@perches.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wtj7d2m3pw3mnq7d
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2020 at 08:36:44AM -0800, Joe Perches wrote:
> On Fri, 2020-11-13 at 10:11 +0100, Uwe Kleine-K=F6nig wrote:
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >=20
> > this can also be squashed into the respective patches instead.
> >=20
> > Best regards
> > Uwe
> >=20
> > =A0scripts/checkpatch.pl | 5 +++++
> > =A01 file changed, 5 insertions(+)
> >=20
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -615,6 +615,11 @@ our %deprecated_apis =3D (
> > =A0	"rcu_barrier_sched"			=3D> "rcu_barrier",
> > =A0	"get_state_synchronize_sched"		=3D> "get_state_synchronize_rcu",
> > =A0	"cond_synchronize_sched"		=3D> "cond_synchronize_rcu",
> > +	"devm_platform_get_and_ioremap_resource" =3D> "devm_platform_get_requ=
est_and_ioremap_resource",
>=20
> Do we really need 46 character length function names?

I can drop the "_and" and maybe "_get", so we're down to 38 "only".
Other than that I think all name parts are relevant.

> > +	"devm_platform_ioremap_resource"	=3D> "devm_platform_request_ioremap_=
resource",
> > +	"devm_platform_ioremap_resource_wc"	=3D> "devm_platform_request_iorem=
ap_resource_wc",
> > +	"devm_ioremap_resource"			=3D> "devm_request_ioremap_resource",
> > +	"devm_ioremap_resource_wc"		=3D> "devm_request_ioremap_resource_wc",
> > =A0);
> > =A0
> >=20
> > =A0#Create a search pattern for all these strings to speed up a loop be=
low
>=20
> And do please send your proposed patches to the appropriate maintainers.

Yes, sure. This patch 3/2 was only a quick shot and it was already clear
to me that I have to redo it. I want to squash this change in the patch
that does the actual renaming, I assume that's fine for you?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--wtj7d2m3pw3mnq7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl+uu7gACgkQwfwUeK3K
7AmhZwgAn8M592lJ6WFng4B8Ss7PMBBEPJkZWITtxKBr9fZ0KLGrvhnOmGjRaj0D
/PVZQwsVfbjJE561XTliNRMKFqUEzDBZYR0ipk9vpXHA5nFVuvT72w8gxgT+jBmZ
YrpajNSnF1l57ata6ruGxVt4LVsmxpBc1aucL/rEwfneNTHMtzC78erE/7xE5zj/
sy9q6ojTax0Ni6RCRVBEUTAzWL/1ZlENIovndy/64xwqpd/pPYOCoqsW6Kwmm5i9
1dhJfflcsBqqaaRzv+IehNUG8JHaJJLEgPJ6SjxVUVqBLh20CR0GLHOcnsRdBcGi
dBlu8pbpqcIssRDIAvHdOy7Fu+A/cg==
=D38b
-----END PGP SIGNATURE-----

--wtj7d2m3pw3mnq7d--
