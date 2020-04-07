Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A24141A089C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgDGHso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 03:48:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38148 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgDGHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:48:43 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D96751C4A6E; Tue,  7 Apr 2020 09:48:41 +0200 (CEST)
Date:   Tue, 7 Apr 2020 09:48:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, airlied@redhat.com,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com,
        kernel list <linux-kernel@vger.kernel.org>,
        matthew.auld@intel.com, rodrigo.vivi@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: Linus, please revert 7dc8f11437: regression in 5.7-rc0, hangs
 while attempting to run X
Message-ID: <20200407074841.GB18673@amd.ucw.cz>
References: <20200407072047.GA18532@amd.ucw.cz>
 <158624426770.4794.6070200474948860768@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
In-Reply-To: <158624426770.4794.6070200474948860768@build.alporthouse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > 7dc8f1143778a35b190f9413f228b3cf28f67f8d
> > >=20
> > >     drm/i915/gem: Drop relocation slowpath
> > >    =20
> > >     Since the relocations are no longer performed under a global
> > >     struct_mutex, or any other lock, that is also held by pagefault h=
andlers,
> > >     we can relax and allow our fast path to take a fault. As we no lo=
nger
> > >     need to abort the fast path for lock avoidance, we no longer need=
 the
> > >     slow path handling at all.
> > >=20
> > > causes regression on thinkpad x220: instead of starting X, I'm looking
> > > at blinking cursor.
> > >=20
> > > Reverting the patch on too of 919dce24701f7b3 fixes things for me.
> >=20
> > I have received no feedback from patch authors, and I believe we don't
> > want to break boot in -rc1 on Intel hardware... so the commit should
> > be simply reverted.
>=20
> Beyond the fix already submitted?

I did not get that one, can I have a pointer?

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXowwWQAKCRAw5/Bqldv6
8ptBAJ9iwHYXM0KdeR4HdWyZ7IEsER3vHACcC1g2U0sCmmYeFy9vvaeM+OCph0g=
=8TpN
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
