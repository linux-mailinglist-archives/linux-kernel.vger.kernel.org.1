Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3B3298879
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 09:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1771872AbgJZIio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 04:38:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38814 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1771843AbgJZIik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 04:38:40 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6233E1C0B96; Mon, 26 Oct 2020 09:38:37 +0100 (CET)
Date:   Mon, 26 Oct 2020 09:38:37 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ian Kent <raven@themaw.net>, Ondrej Mosnacek <omosnace@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        autofs@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Peter Anvin <hpa@zytor.com>
Subject: Re: autofs: use __kernel_write() for the autofs pipe writing causes
 regression in -next was Re: 5.9.0-next-20201015: autofs oops in
 update-binfmts
Message-ID: <20201026083836.GA24911@duo.ucw.cz>
References: <20201016123530.GA30444@duo.ucw.cz>
 <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
 <20201017100234.GA3797@amd>
 <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
 <20201017194758.GA9904@duo.ucw.cz>
 <CAHk-=wikZkCGVkeuDUb6jvz7xyeO4RsH3zQU4bCCnP=MBrd95g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <CAHk-=wikZkCGVkeuDUb6jvz7xyeO4RsH3zQU4bCCnP=MBrd95g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-10-17 17:13:20, Linus Torvalds wrote:
> On Sat, Oct 17, 2020 at 12:48 PM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > But: you are the last one to sign it off, so I assume committed it to
> > git, and you are the one to talk to about fixing it.
>=20
> The thing is, the commit you point to - and the one I signed off on - is =
fine.
>=20
> The buggy one is in linux-next, which breaks that whole "NULL means no
> position" thing.
>=20
> IOW, the real bug is in commit 4d03e3cc5982 ("fs: don't allow kernel
> reads and writes without iter ops"), which does that bogus
>=20
>         kiocb.ki_pos =3D *pos;
>=20
> and no, I never signed off on that.
>=20
> Get it? Stop confusing people. This bug does not exist in mainline,
> and never will. Because I'm not pulling that buggy commit.

And I guess that's a good thing. It is now fixed in -next, too. Sorry
for the noise.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX5aLDAAKCRAw5/Bqldv6
8l3iAKDA9QgXwAVJMYPECRYiZvls/4K58wCfQVKE+alumoUT3rMzunV+vN1L8Jk=
=r+i9
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
