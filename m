Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3678B24A481
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 18:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHSQ5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 12:57:39 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41942 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgHSQ5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:57:22 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 607D51C0BBB; Wed, 19 Aug 2020 18:57:17 +0200 (CEST)
Date:   Wed, 19 Aug 2020 18:57:17 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to
 mainline
Message-ID: <20200819165716.GA3803@amd>
References: <20200817161132.GA4711@amd>
 <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
 <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
 <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > I think there's been some discussion about reverting that change for
> > other reasons, but it's quite likely the culprit.
>=20
> Hmm. It reverts cleanly, but the end result doesn't work, because of
> other changes.
>=20
> Reverting all of
>=20
>    763fedd6a216 ("drm/i915: Remove i915_gem_object_get_dirty_page()")
>    7ac2d2536dfa ("drm/i915/gem: Delete unused code")
>    9e0f9464e2ab ("drm/i915/gem: Async GPU relocations only")
>=20
> seems to at least build.
>=20
> Pavel, does doing those three reverts make things work for you?

Thanks.

I got "[PATCH 1/2] drm/i915/gem: Replace reloc chain with terminator
on..." in my inbox; I believe that's related. Let me try those, first.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--oyUTqETQ0mS9luUI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl89WewACgkQMOfwapXb+vJnQACfYEYDrymKuDTAa+JArLe4U9Ld
5xcAnjjWjwoOVl2xtpo/o+mbX+714h85
=kU8f
-----END PGP SIGNATURE-----

--oyUTqETQ0mS9luUI--
