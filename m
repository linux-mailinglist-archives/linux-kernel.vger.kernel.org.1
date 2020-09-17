Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4E4B26D654
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgIQIWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:22:43 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:41343 "EHLO
        9.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgIQIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:22:35 -0400
X-Greylist: delayed 4203 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:22:33 EDT
Received: from player788.ha.ovh.net (unknown [10.108.57.188])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id 705CA9AD7A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:03:43 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player788.ha.ovh.net (Postfix) with ESMTPSA id B8759163D3A20;
        Thu, 17 Sep 2020 07:03:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G002ceaa2b6f-b6d7-4589-8d40-daab5e75c234,
                    CDC8E273B2E96CDC0F82EF6907E74C03A725C516) smtp.auth=steve@sk2.org
Date:   Thu, 17 Sep 2020 09:03:32 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: rewrite admin-guide/sysctl/abi.rst
Message-ID: <20200917090332.27925ea1@heffalump.sk2.org>
In-Reply-To: <20200916124310.1a06c89e@lwn.net>
References: <20200911190152.29730-1-steve@sk2.org>
        <20200916124310.1a06c89e@lwn.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/Yw2udeXEVTr3EM5I+=L7CpF"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 742812465100246405
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrtdefgdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpefgtdehleegkeejfedulefhjeehtedvueettdejfefgffegveekfffgieeigfeiheenucffohhmrghinheplhhkmhhlrdhorhhgnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yw2udeXEVTr3EM5I+=L7CpF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 16 Sep 2020 12:43:10 -0600, Jonathan Corbet <corbet@lwn.net> wrote:
> On Fri, 11 Sep 2020 21:01:52 +0200
> Stephen Kitt <steve@sk2.org> wrote:
> > Following the structure used in sysctl/kernel.rst, this updates
> > abi.rst to use ReStructured Text more fully and updates the entries to
> > match current kernels:
> >=20
> >   * the list of files is now the table of contents;
> >   * links are used to point to other documentation and other sections;
> >   * all the existing entries are no longer present, so this removes
> >     them;
> >   * document vsyscall32.
> >=20
> > Mentions of the kernel version are dropped. Since the document is
> > entirely rewritten, I've replaced the copyright statement.
> >=20
> > Signed-off-by: Stephen Kitt <steve@sk2.org> =20
>=20
> Replacing a copyright makes me a little nervous, but I guess that is OK
> here since everything else is replaced too.

I hesitated too, but after checking carefully that the original contents we=
re
all gone, decided it sort of made sense... I could just drop that line too,
I=E2=80=99m not sure there=E2=80=99s much point in documentation that=E2=80=
=99s supposed to be
collectively maintained (and authorship is determined by the commits anyway=
).

> Could I trouble you, though, for a version that adds an SPDX line at the
> top while you're at it?

No problem, v2 incoming.

While I=E2=80=99m at it, might I ask if it would be possible to carry
https://lkml.org/lkml/2020/8/12/181 (sort-of-re-submitted in
https://lkml.org/lkml/2020/9/11/1079) in the docs tree? It fixes a docs
commit...

Regards,

Stephen

--Sig_/Yw2udeXEVTr3EM5I+=L7CpF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl9jCkQACgkQgNMC9Yht
g5xQkA/+M/VWiQ4nrh2Jc6KSI3+GEpVO46PAd6ocBtaN0gKq7MbwVahpTUXzi9AG
lQOsKpziwDldo5yLF+M2DR5Wd3AkvWoD/uSuciqY5SyVffNm43tYYOSRw8mARRwO
aLwLzMZAqoZ4+ODhVuMLnwp+x1vWWjF1bY//eK8FqyaX6WkJaeZi4eTVmyuMpdPf
ypwFScdL52WThJAMaZ7h6eIrGOZLGzAQsHLeVVTyiWYcHaKlMBO6o2Z4bJ7AVtGn
QBRNlL1yAs2gHpEArPC4A+Jmo58lfXYY1YyKXlhV3nj5Af/jzEcIqcbmFOF3PApa
KggdeVDowvqxkBXPatG9+6F83iziBcR/BVmFJiwEu8nXoa9w49L1Tl1vDY6gCsO/
iCvEQ8TAAU85/b4VxxVqlkAtffe6184rAyuC0377hRMXI0idUHED3ZQaMATJLjmg
zSP4xv5y8QIjDnUIqzhfzXcZWLtff0c6WcVNn9NvgabM+FLcjWUb05+a3S8spdzt
taE1RVlg/01/FXxq+CsbWUAHPolVcjviGHah0WnZlbs54X1oGhf8eYLHRIY6SDEi
fCyBaP8p1bx+hRDNhjpuYTqwOQQ+sj0RaCmXo5UWNkH+xB8tuYQ0CN7AgNmp3Qhb
x2Ti3xyWwlNStOtf1NI76pC5wM9cFSh8DHWvaV63LdeK606nceE=
=llSE
-----END PGP SIGNATURE-----

--Sig_/Yw2udeXEVTr3EM5I+=L7CpF--
