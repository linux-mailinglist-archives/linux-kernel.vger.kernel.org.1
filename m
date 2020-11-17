Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01352B5ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKQIR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:17:29 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:48982 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgKQIR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:17:28 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6E2AC1C0BD1; Tue, 17 Nov 2020 09:17:24 +0100 (CET)
Date:   Tue, 17 Nov 2020 09:17:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, sfr@canb.auug.org.au,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Subject: next-20201117: fails to boot on 32-bit thinkpad X60
Message-ID: <20201117081722.GA7420@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Subject pretty much says it all, I end up with blank screen at time
when resolution normally changes.

If it is known-broken, let me know...

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+zhxIACgkQMOfwapXb+vLxWQCdFsQ7SAIFzGNNvPE7dv6wUg/z
UaYAniALgyohu/fJt6bHYomk8/eFfbRs
=8mqr
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
