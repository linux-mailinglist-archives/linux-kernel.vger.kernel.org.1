Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA13286F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 09:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgJHHPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 03:15:11 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:53524 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJHHPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 03:15:11 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 839421C0B8A; Thu,  8 Oct 2020 09:15:08 +0200 (CEST)
Date:   Thu, 8 Oct 2020 09:15:07 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel test robot <lkp@intel.com>
Cc:     Dan Murphy <dmurphy@ti.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: arceb-elf-ld: include/linux/leds.h:193: undefined reference to
 `devm_led_classdev_register_ext'
Message-ID: <20201008071507.GA29893@amd>
References: <202010081415.2R50UmDQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <202010081415.2R50UmDQ-lkp@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t master
> head:   c85fb28b6f999db9928b841f63f1beeb3074eeca
> commit: 92a81562e695628086acb92f95090ab09d9b9ec0 leds: lp55xx: Add multic=
olor framework support to lp55xx
> date:   3 months ago
> config: arc-randconfig-r035-20201008 (attached as .config)
> compiler: arceb-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3D92a81562e695628086acb92f95090ab09d9b9ec0
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/=
git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 92a81562e695628086acb92f95090ab09d9b9ec0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cros=
s ARCH=3Darc=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Hi robot. Do you have human around to talk to?

> All errors (new ones prefixed by >>):
>=20
>    arceb-elf-ld: lib/stackdepot.o: in function `filter_irq_stacks':
>    lib/stackdepot.c:331: undefined reference to `__irqentry_text_start'
>    arceb-elf-ld: lib/stackdepot.c:331: undefined reference to `__irqentry=
_text_start'
>    arceb-elf-ld: lib/stackdepot.o: in function `in_irqentry_text':
>    lib/stackdepot.c:323: undefined reference to `__irqentry_text_end'
>    arceb-elf-ld: lib/stackdepot.c:323: undefined reference to `__irqentry=
_text_end'
>    arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqe=
ntry_text_start'
>    arceb-elf-ld: lib/stackdepot.c:324: undefined reference to `__softirqe=
ntry_text_start'
>    arceb-elf-ld: lib/stackdepot.c:325: undefined reference to `__softirqe=
ntry_text_end'
>    arceb-elf-ld: lib/stackdepot.c:325: undefined reference to

What is going on here? Did you just start testing arc? The commit
is... really old.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl9+vHsACgkQMOfwapXb+vIrhwCgub0IW5bfS+I0+ejoXXuOIX6H
OaEAnjExe5TkzP5Yk9FK/X33D/YZ2Vqr
=QC/V
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
