Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD1C202D53
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 00:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgFUWEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 18:04:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:45666 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgFUWEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 18:04:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 935251C0C0A; Mon, 22 Jun 2020 00:04:32 +0200 (CEST)
Date:   Mon, 22 Jun 2020 00:04:32 +0200
From:   Pavel Machek <pavel@denx.de>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     corbet@lwn.net, changbin.du@intel.com, masahiroy@kernel.org,
        rostedt@goodmis.org, j.neuschaefer@gmx.net,
        andy.shevchenko@gmail.com, mchehab+samsung@kernel.org,
        logang@deltatee.com, abbotti@mev.co.uk, jacob.e.keller@intel.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        mgreer@animalcreek.com, tytso@mit.edu, jack@suse.cz,
        ebiggers@google.com, tglx@linutronix.de, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        jgross@suse.com, mike.kravetz@oracle.com, cohuck@redhat.com,
        jacek.anaszewski@gmail.com, alex@alexanderweb.de,
        dwlsalmeida@gmail.com, dsterba@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/admin-guide
Message-ID: <20200621220432.GA916@amd>
References: <20200621132049.45624-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <20200621132049.45624-1-grandmaster@al2klimov.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.

> +++ b/Documentation/admin-guide/README.rst
> @@ -1,6 +1,6 @@
>  .. _readme:
> =20
> -Linux kernel release 5.x <http://kernel.org/>
> +Linux kernel release 5.x <https://kernel.org/>
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

You need to add one "=3D" here, IIRC.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7v2W8ACgkQMOfwapXb+vI5cgCdGFRLd9+refQsglCD5LdtNPVx
/CgAnRZd9VJjSbmBH3rNbU7YAeh+0vCw
=18By
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
