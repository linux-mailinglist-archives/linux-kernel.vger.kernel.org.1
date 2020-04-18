Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A275D1AEBDE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 12:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDRKnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 06:43:45 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36530 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 06:43:45 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 76D761C0193; Sat, 18 Apr 2020 12:43:43 +0200 (CEST)
Date:   Sat, 18 Apr 2020 12:43:44 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, hadar.gat@arm.com,
        herbert@gondor.apana.org.au
Subject: Arm CryptoCell driver -- default Y, even on machines where it is
 obviously useless
Message-ID: <20200418104343.GA5132@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm configuring kernel for x86, and I get offered HW_RANDOM_CCTRNG
with default=3DY, and help text suggesting I should enable it.

That's... two wrong suggestions, right?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl6a2d8ACgkQMOfwapXb+vL8iwCfV8gdCmhR4tfU1vM0cj31zolx
ucAAn3qnYejUvn8mohVYIBTcoQ+KeRm1
=67uF
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
