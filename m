Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9612826CD29
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgIPUyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:54:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43338 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgIPUyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 16:54:37 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DC5031C0B76; Wed, 16 Sep 2020 22:54:34 +0200 (CEST)
Date:   Wed, 16 Sep 2020 22:54:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Yuan Ming <yuanmingbuaa@gmail.com>, Willy Tarreau <w@1wt.eu>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        NopNop Nop <nopitydays@gmail.com>,
        =?utf-8?B?5byg5LqR5rW3?= <zhangyunhai@nsfocus.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: fbcon: remove soft scrollback code (missing Doc. patch)
Message-ID: <20200916205434.GA10389@duo.ucw.cz>
References: <git-mailbomb-linux-master-50145474f6ef4a9c19205b173da6264a644c7489@kernel.org>
 <c9cd22ec-60dc-d761-b488-d3a1392708c0@infradead.org>
 <CAHk-=wiNTWpqUF0HgzoyPGEaaAjxD-Bor+EE3DbJ52S30cfCWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <CAHk-=wiNTWpqUF0HgzoyPGEaaAjxD-Bor+EE3DbJ52S30cfCWg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2020-09-14 18:28:34, Linus Torvalds wrote:
> On Mon, Sep 14, 2020 at 6:19 PM Randy Dunlap <rdunlap@infradead.org> wrot=
e:
> >
> > Now someone can remove the documentation for scrollback (and "no-scroll=
")...
>=20
> Note that scrollback hasn't actually gone away entirely - the original
> scrollback supported by _hardware_ still exists.
>=20
> Of course, that's really just the old-fashioned text VGA console, but
> that one actually scrolls not by moving any bytes around, but by
> moving the screen start address. And the scrollback similarly isn't
> about any software buffering, but about the ability of moving back
> that screen start address.
>=20
> Do people use that? Probably not. But it wasn't removed because it
> didn't have any of the complexities and bitrot that all the software
> buffering code had.
>=20
> That said, I didn't check how much of the documentation is for the VGA
> text console, and how much of it is for the actual software scrollback
> for fbcon etc. So it is entirely possible that all the docs are about
> the removed parts.

Could we pause this madness? Scrollback is still useful. I needed it
today... it was too small, so command results I was looking for
already scrolled away, but... life will be really painful with 0 scrollback.

You'll need it, too... as soon as you get oops and will want to see
errors just prior to that oops.

If it means I get to maintain it... I'm not happy about it but that's
better than no scrollback.

 Kernel is now very verbose, so important messages
 during bootup scroll away. It is way bigger deal when you can no
 longer get to them using shift-pageup.

 fsck is rather verbose, too, and there's no easy way to run that under
 X terminal... and yes, that makes scrollback very useful, too.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX2J7igAKCRAw5/Bqldv6
8uAQAKCJl9d/+C94slkWoDEqnA9Sxe/f1ACePzzUiVttoyERR+W9wtLGIlFDYHU=
=//6K
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
