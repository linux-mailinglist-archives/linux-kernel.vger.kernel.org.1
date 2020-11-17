Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4D02B5B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKQI4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:56:53 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:51713 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725792AbgKQI4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:56:53 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cb0DP59tPz9sT6;
        Tue, 17 Nov 2020 19:56:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1605603410;
        bh=4k2FM2iwntXu5XEZn7PjQ9gnMW+2g9MGuOE3cfBOGbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lgdiGiaTAPbEcIP5Q4zpgttcdzELZcdNBkOFN7r1kaLYnSo9tbRtjS2IPMsPK+9EH
         M9OOza6ZGRfdudWn4hw6R0qj1c/tLRg63JlL82up3QTOan0VxeyESLH/rWIxgnj8X9
         QsHE/2vJYy1L6QQ8VVEOMGnHfeP3t/xtw5ibZ96PdD/fUApm8E5WkOC1k/VpUPJXfX
         8dBT4oXVNE+OdsoQowZbZD2sGMIaazxDA6+T3VjrsNYVoWBEoNp7j6XcqypnPh3W41
         sLpelTfg/2PvUq5dwg9Qiwt87vlDZblks1cwKWXY/a8leHG6KE52A2FO7j/VSsfwM7
         Yqz/3AW7Ero1A==
Date:   Tue, 17 Nov 2020 19:56:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com
Subject: Re: next-20201117: fails to boot on 32-bit thinkpad X60
Message-ID: <20201117195636.7692ccce@canb.auug.org.au>
In-Reply-To: <20201117084435.GA30872@duo.ucw.cz>
References: <20201117081722.GA7420@amd>
        <20201117084435.GA30872@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qUl==2.o3KXVQEJrkeFjpDd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qUl==2.o3KXVQEJrkeFjpDd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On Tue, 17 Nov 2020 09:44:35 +0100 Pavel Machek <pavel@ucw.cz> wrote:
>
> > Subject pretty much says it all, I end up with blank screen at time
> > when resolution normally changes.
> >=20
> > If it is known-broken, let me know... =20
>=20
> I was too fast hitting send key. next-20201116 was broken, but
> next-20201117 actually works ok... so I guess nothing to worry about.

Good to know.  I wonder what got fixed? :-)
--=20
Cheers,
Stephen Rothwell

--Sig_/qUl==2.o3KXVQEJrkeFjpDd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl+zkEQACgkQAVBC80lX
0GzeCwgAkLmLH3v9zCPfLyL/oDuNrSjWHoMB6KBfdUb1Kg3EgA1MiR6n1rvQu0/a
uprSW9UuSGmPpsZW5EmA/13QQ1HzOM9DPtorqb0uJ+p/P21h3WOlikKKRKxeawfs
zqnvtHIMZU6EWht58PF2NYRYcsuVShBxY6oUy7ire/nhf6gAIfyYPgiGr3TuJFSs
Rxby8B+o5vHsjz6+WqiwnUmBRQKWlSlXSqdj6l/eJka/RqhS5QL+FiZyqd56dGbX
puyYp45Slutn0UAJYIDP3ngnpIWabQ4/9+xVABeyJ4y3iZzdUr1OwknsEZ68xbeF
vbZz4yEiCiC+Pp5CJHT97dM71BHm0g==
=Izet
-----END PGP SIGNATURE-----

--Sig_/qUl==2.o3KXVQEJrkeFjpDd--
