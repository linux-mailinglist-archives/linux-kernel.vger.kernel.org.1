Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFE828B21C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 12:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgJLKUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 06:20:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35804 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgJLKUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 06:20:43 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 78FE71C0B77; Mon, 12 Oct 2020 12:20:40 +0200 (CEST)
Date:   Mon, 12 Oct 2020 12:20:39 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        darrick.wong@oracle.com, dchinner@redhat.com, sandeen@redhat.com
Subject: -next: Kconfig asks about XFS formats when I don't have XFS enabled
Message-ID: <20201012102039.GA1588@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I don't have XFS enabled, yet I'm asked if I want to support its old
format:

+config XFS_SUPPORT_V4
+       bool "Support deprecated V4 (crc=3D0) format"
+       default y

This needs to have dependence on XFS_FS.

+         This option will become default N in September 2025. Support for =
the
+         V4 format will be removed entirely in September 2030. Distributors
+         can say N here to withdraw support earlier.

This seems... "interesting", contrary to "no regressions" rule.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+ELfcACgkQMOfwapXb+vJyywCgjn3Pzs62zE9URhUhrHnXHjH0
OUsAn3wVgox7V7wiXOwzyAriHM2xXK69
=H8AP
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
