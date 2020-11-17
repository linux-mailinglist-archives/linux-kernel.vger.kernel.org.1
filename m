Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D13F2B5B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKQIoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:44:38 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:51526 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgKQIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:44:37 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 52AB01C0BA1; Tue, 17 Nov 2020 09:44:35 +0100 (CET)
Date:   Tue, 17 Nov 2020 09:44:35 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Subject: Re: next-20201117: fails to boot on 32-bit thinkpad X60
Message-ID: <20201117084435.GA30872@duo.ucw.cz>
References: <20201117081722.GA7420@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20201117081722.GA7420@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Subject pretty much says it all, I end up with blank screen at time
> when resolution normally changes.
>=20
> If it is known-broken, let me know...

I was too fast hitting send key. next-20201116 was broken, but
next-20201117 actually works ok... so I guess nothing to worry about.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7ONcwAKCRAw5/Bqldv6
8qPdAJ4qpR927H1+iWMDRAgOGLb2QrEZ2QCeNgUkfcC4wH6nRVMbG2r6BBDniKk=
=0YMm
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
