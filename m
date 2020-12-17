Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6ED2DDAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbgLQVpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:45:49 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:48192 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgLQVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:45:49 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 744771C0B7D; Thu, 17 Dec 2020 22:45:06 +0100 (CET)
Date:   Thu, 17 Dec 2020 22:45:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alex.gaynor@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20201217214506.GD28574@duo.ucw.cz>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200710062803.GA1071395@kroah.com>
 <20200710125022.alry7wkymalmv3ge@wittgenstein>
 <20200710225934.GA16881@localhost>
 <CAHk-=wipXqemHbVnK1kQsFzGOOZ8FUXn3PKrZb5WC=KkgAjRRw@mail.gmail.com>
 <20200711210317.GA60425@localhost>
 <20200728204037.GC1012@bug>
 <20200729063417.GD286933@localhost>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OROCMA9jn6tkzFBc"
Content-Disposition: inline
In-Reply-To: <20200729063417.GD286933@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OROCMA9jn6tkzFBc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-07-28 23:34:17, Josh Triplett wrote:
> On Tue, Jul 28, 2020 at 10:40:38PM +0200, Pavel Machek wrote:
> > > We just need to make sure that any kernel CI infrastructure tests that
> > > right away, then, so that failures don't get introduced by a patch fr=
om
> > > someone without a Rust toolchain and not noticed until someone with a
> > > Rust toolchain tests it.
> >=20
> > So... I'm fan of Rust, but while trying to use it one thing was obvious=
: it
> > takes _significantly_ longer than C to compile and needs gigabyte a lot=
 of RAM.
> >=20
> > Kernel is quite big project, can CI infrastructure handle additional lo=
ad?
> >=20
> > Will developers see significantly longer compile times when Rust is wid=
espread?
>=20
> I wouldn't expect the addition of Rust to the kernel to substantially
> impact overall build time; on balance, I'd expect the major bottleneck
> in kernel builds to continue to be linking and other serialized steps,
> not compiling and other highly parallel steps.

Well.. not everyone has 32 cores in their notebook.

> There are also *many* things that can be done to improve Rust build time
> in a project. And I don't expect that in-kernel Rust will have many
> dependencies on third-party crates (since they'd need to be checked into

Okay. I did some refactoring recently and I really wished kernel was
in Rust (and not in C)... so lets see what happens.

Best regards,

  	       	  	      	     	    	   	      	      Pavel
--=20
http://www.livejournal.com/~pavelmachek

--OROCMA9jn6tkzFBc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX9vRYgAKCRAw5/Bqldv6
8r/sAJ0f6R0WCigrZ+64GanHpJ80b8yluQCgjACVU5BmqjDetFt6rHSvyZuf9Sg=
=8C7H
-----END PGP SIGNATURE-----

--OROCMA9jn6tkzFBc--
