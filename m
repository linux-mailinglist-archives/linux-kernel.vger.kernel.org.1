Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854B929142A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 21:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439591AbgJQTsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 15:48:12 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:48484 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439439AbgJQTsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 15:48:12 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id A58821C0B76; Sat, 17 Oct 2020 21:48:07 +0200 (CEST)
Date:   Sat, 17 Oct 2020 21:47:58 +0200
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
Message-ID: <20201017194758.GA9904@duo.ucw.cz>
References: <20201016123530.GA30444@duo.ucw.cz>
 <bfac7ed28d79b8696cb8576790b27027a78cd3b7.camel@themaw.net>
 <20201017100234.GA3797@amd>
 <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <CAHk-=whFVYJabpFsSRL-t7PjDfisvNU=kUMPQUh=SDtLtT587w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Bad Linus!
>=20
> Christ people.

https://www.christpeople.church/ ? Those are unlikely to help, I'd say :-).

> The bug is in linux-next, not in mainline.  I've told the people
> involved already over a week ago.

Yes, I reported the bug against -next.

But: you are the last one to sign it off, so I assume committed it to
git, and you are the one to talk to about fixing it.

> I can't do anything about linux-next being broken and people not
>  fixing it.

90fb702791bf99b959006972e8ee7bb4609f441b causes oops at boot for me.

So... I'm not git wizard, but... if I do log on v5.8, it is not in the
list, and if I do log on v5.9, it shows it.

So yes, I believe this in mainline.

Should I test v5.9 next? Or do you want me to test some patch?

Best regards,

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX4tKbgAKCRAw5/Bqldv6
8syLAKCE6WS+jWqX5obzHcHFfaAfz97piQCglC1FqR+3LkZwDi+cFUNYzDLUtRE=
=H0CJ
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
