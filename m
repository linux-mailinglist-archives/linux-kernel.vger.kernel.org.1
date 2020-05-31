Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B641E96F2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 12:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgEaKee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 06:34:34 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:42726 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEaKed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 06:34:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 59EC31C0BD2; Sun, 31 May 2020 12:34:32 +0200 (CEST)
Date:   Sun, 31 May 2020 12:34:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
Cc:     mhocko@suse.cz, vbabka@suse.cz
Subject: 5.7-rc0: kswapd eats cpu during a disk test?!
Message-ID: <20200531103431.GA28429@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

This is simple cat /dev/sda > /dev/zero... on thinkpad x60 (x86-32),
with spinning rust.

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+  COMMAND
   1000 root      20   0       0      0      0 R  53.3  0.0  57:34.93  kswa=
pd0
  27897 root      20   0    6976    580    536 R  44.5  0.0   1:44.53  cat

It keeps both CPUs busy... and I don't think that's right.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7TiDcACgkQMOfwapXb+vIOgwCgwPJXAvc3BlYb65/G1EdTUOdb
J0YAnR/wwMOyH2kOpkKICFhV7ky6ml2w
=vv3Y
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
