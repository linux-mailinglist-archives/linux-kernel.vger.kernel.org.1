Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4EF19D15A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 09:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbgDCHhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 03:37:38 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41830 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbgDCHhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 03:37:37 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9A9CF1C33E7; Fri,  3 Apr 2020 09:37:36 +0200 (CEST)
Date:   Fri, 3 Apr 2020 09:37:21 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: 5.7-rc0: hangs while attempting to run X
Message-ID: <20200403073720.GA23229@duo.ucw.cz>
References: <20200402213253.GA2691@duo.ucw.cz>
 <20200402213506.GA2767@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <20200402213506.GA2767@duo.ucw.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Hardware is thinkpad x220. I had this crash few days ago. And today I
> > have similar-looking one, with slightly newer kernel. (Will post
> > as a follow-up).

As part of quest for working system, I tried 5.7-rc0, based on

Merge: 50a5de895dbe b4d8ddf8356d
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed Apr 1 18:18:18 2020 -0700

It hangs in userspace, at a time when X should be starting, and I'm
looking at blinking cursor.

5.6-rcs worked, I'll test 5.6-final.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXobnsAAKCRAw5/Bqldv6
8k6jAJ0cxrbwMvEynKPP4Spf2+6c5PWqAgCfatSwytzFrhnxjTz64MIbOkWv7q8=
=HF3s
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
