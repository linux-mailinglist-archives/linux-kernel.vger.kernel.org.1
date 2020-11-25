Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE242C4899
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbgKYTle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:41:34 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:37764 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbgKYTle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:41:34 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7C5DF1C0B81; Wed, 25 Nov 2020 20:41:30 +0100 (CET)
Date:   Wed, 25 Nov 2020 20:41:30 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: Re: next-20201117: fails to boot on 32-bit thinkpad X60
Message-ID: <20201125194130.GB9791@amd>
References: <20201117081722.GA7420@amd>
 <20201117084435.GA30872@duo.ucw.cz>
 <20201117195636.7692ccce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20201117195636.7692ccce@canb.auug.org.au>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-11-17 19:56:36, Stephen Rothwell wrote:
> Hi Pavel,
>=20
> On Tue, 17 Nov 2020 09:44:35 +0100 Pavel Machek <pavel@ucw.cz> wrote:
> >
> > > Subject pretty much says it all, I end up with blank screen at time
> > > when resolution normally changes.
> > >=20
> > > If it is known-broken, let me know... =20
> >=20
> > I was too fast hitting send key. next-20201116 was broken, but
> > next-20201117 actually works ok... so I guess nothing to worry about.
>=20
> Good to know.  I wonder what got fixed? :-)

No idea. It seems 32-bit x86 is so old it is occassionally broken and
then fixed...

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl++s2kACgkQMOfwapXb+vKOOQCfYqo2kwX/0Dn4YYeLuuhoby48
IusAoIPAT1kV01qa0HzlZGBQLwqeGKcP
=VI+P
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
