Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9271A0820
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 09:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgDGHUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 03:20:50 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35104 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgDGHUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 03:20:50 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 935241C4A51; Tue,  7 Apr 2020 09:20:48 +0200 (CEST)
Date:   Tue, 7 Apr 2020 09:20:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        airlied@redhat.com, chris@chris-wilson.co.uk,
        matthew.auld@intel.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Linus, please revert 7dc8f11437: regression in 5.7-rc0, hangs while
 attempting to run X
Message-ID: <20200407072047.GA18532@amd.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Fri 2020-04-03 15:00:31, Pavel Machek wrote:
> Hi!
>=20
> 7dc8f1143778a35b190f9413f228b3cf28f67f8d
>=20
>     drm/i915/gem: Drop relocation slowpath
>    =20
>     Since the relocations are no longer performed under a global
>     struct_mutex, or any other lock, that is also held by pagefault handl=
ers,
>     we can relax and allow our fast path to take a fault. As we no longer
>     need to abort the fast path for lock avoidance, we no longer need the
>     slow path handling at all.
>=20
> causes regression on thinkpad x220: instead of starting X, I'm looking
> at blinking cursor.
>=20
> Reverting the patch on too of 919dce24701f7b3 fixes things for me.

I have received no feedback from patch authors, and I believe we don't
want to break boot in -rc1 on Intel hardware... so the commit should
be simply reverted.

Best regards,
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXowpzwAKCRAw5/Bqldv6
8kkIAKCeh1vybMCCVOEA5UsenI/abMGdJwCgpcZnBGOuqMUIojYfdcW6XC9hOIM=
=woPH
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
