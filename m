Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18528E3F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 18:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgJNQFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 12:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728035AbgJNQFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 12:05:06 -0400
Received: from coco.lan (ip5f5ad5dc.dynamic.kabel-deutschland.de [95.90.213.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A585F20B1F;
        Wed, 14 Oct 2020 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602691505;
        bh=UyfuipMpBBXN4pHNIZOafb1pP5DePQ6km5QUP57Anc0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WXc15mHus01dI1sEILxIKonKWxojhho/Cahj3LH0cAgE3Qbul94NOtdmKZR5it4lW
         lTy/wAOiyw+TQw7lO7+3UMaDpf8Lj6ce9zFpL8SZOIuYsjoGF5XIv7ksaLNMhwVC4j
         krlwkJBt/5d/MblU0+3qMfaDEZt6IZCfwpo7eW+s=
Date:   Wed, 14 Oct 2020 18:04:59 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/24] docs: lockdep-design: fix some warning issues
Message-ID: <20201014175143.3d594341@coco.lan>
In-Reply-To: <20201013150250.GJ20115@casper.infradead.org>
References: <cover.1602590106.git.mchehab+huawei@kernel.org>
        <c76318f859a78adb80a6eef63c5c777d05501198.1602590106.git.mchehab+huawei@kernel.org>
        <20201013125206.GU2611@hirez.programming.kicks-ass.net>
        <20201013131116.GG20115@casper.infradead.org>
        <20201013140941.GC2594@hirez.programming.kicks-ass.net>
        <20201013150250.GJ20115@casper.infradead.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 13 Oct 2020 16:02:50 +0100
Matthew Wilcox <willy@infradead.org> escreveu:

> On Tue, Oct 13, 2020 at 04:09:41PM +0200, Peter Zijlstra wrote:
> > On Tue, Oct 13, 2020 at 02:11:16PM +0100, Matthew Wilcox wrote:
> > > On Tue, Oct 13, 2020 at 02:52:06PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Oct 13, 2020 at 02:14:31PM +0200, Mauro Carvalho Chehab wro=
te:
> > > > > +   =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > +   ``.``  acquired while irqs disabled and not in irq context
> > > > > +   ``-``  acquired in irq context
> > > > > +   ``+``  acquired with irqs enabled
> > > > > +   ``?``  acquired in irq context with irqs enabled.
> > > > > +   =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > NAK!
> > >=20
> > > You're seriously suggesting that:
> > >=20
> > > -   =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > -   '.'  acquired while irqs disabled and not in irq context
> > > -   '-'  acquired in irq context
> > > -   '+'  acquired with irqs enabled
> > > -   '?'  acquired in irq context with irqs enabled.
> > > -   =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> > > +   =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +   ``.``  acquired while irqs disabled and not in irq context
> > > +   ``-``  acquired in irq context
> > > +   ``+``  acquired with irqs enabled
> > > +   ``?``  acquired in irq context with irqs enabled.
> > > +   =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > this change makes the lockdep docs less readable?
> >=20
> > Definitely makes it harder to read for me. My C trained eyes go WTF at
> > seeing it, which breaks the flow. ',' is a regular single character
> > constant, '','' a syntax error.
>=20
> OK, that's fair.  'a' is definitely a character constant.  Perhaps
> the automarkup script can take care of this for us?  We'd have to
> be careful not to catch anything we shouldn't've [1], but I'm sure
> there's a regex for it.  Something like "\<'.'\>", perhaps?

I guess that this regex could work:

	/\b\'\S\'\b/=20

would get this very specific case, or maybe even:
	/\b\'\S+\'\b/

in order to get things like 'foo'.

Adding support for something like this at=20
Documentation/sphinx/automarkup.py should be trivial. However,
checking if this won't be doing anything wrong with the other existing
files can be painful.

Yet, there are 3 issues related to '.' character usage.

See, the first table is:

   =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
   '.'  acquired while irqs disabled and not in irq context
   '-'  acquired in irq context
   '+'  acquired with irqs enabled
   '?'  acquired in irq context with irqs enabled.
   =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

There, it uses '.' in order to indicate the dot character and so on.

The second table uses a different notation:

   +--------------+-------------+--------------+
   |              | irq enabled | irq disabled |
   +--------------+-------------+--------------+
   | ever in irq  |      ?      |       -      |
   +--------------+-------------+--------------+
   | never in irq |      +      |       .      |
   +--------------+-------------+--------------+

which uses just a question mark without aphostrophes, instead of
'?' (and the same for the other symbols).

The text describing them returns back to the notation used at the
first table:

	"The character '-' suggests irq is disabled because if otherwise the
	 charactor '?' would have been shown instead. Similar deduction can be
	 applied for '+' too."

-

The above has actually 3 separate problems:

1) This problem has nothing to do with Sphinx notation. The notation
   is not coherent: It should use either ., ``.`` or '.' everywhere. =20

2) This is Sphinx-specific: a single minus or a single plus character
indicates a list. On both cases, this is actually replaced by an UTF-8
bullet character: '=E2=80=A2'.

3) This is a minor issue:

   using '.' will produce an html table that will display, using
   a normal font, as '.', while ``.`` would use a monospaced=20
   font and won't display the apostrophes. IMO, at the html output,=20
   it would be better to just a dot without apostrophes, as the
   text of the dmesg output doesn't have apostrophes either:

     "When locking rules are violated, these usage bits are presented in the
      locking error messages, inside curlies, with a total of 2 * n STATEs =
bits.
      A contrived example::

        modprobe/2287 is trying to acquire lock:
         (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24

        but task is already holding lock:
         (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24"

   Yet, we could live without addressing this one.

> [1] I'm quite proud of that one.
>=20
> > > It's not the markup that makes the lockdep documentation hard to
> > > understand.
> >=20
> > I'm not sure what you're alluding to, the subject just isn't easy to
> > begin with.
>=20
> Absolutely.  The problem is (similar to most Linux documentation)
> the document doesn't know who its audience is.  It mixes internal
> implementation details of lockdep with what people need to know who
> are just trying to understand what a lockdep splat means.  I don't
> have time to restructure it right now though.

Yeah, that is one of the the main issues with this. This specific=20
section of the file describes something that a sysadmin or a Kernel
newbie may see on his system. He'll likely seek the web for some
documentation about that, in order to try to understand it.

If someone is willing to do that, it will get this:

	https://www.kernel.org/doc/html/latest/locking/lockdep-design.html#state

Where it presents a plain wrong table that it would look like this:

   +--------------+-------------+--------------+
   |              | irq enabled | irq disabled |
   +--------------+-------------+--------------+
   | ever in irq  |      ?      |       =E2=80=A2      |
   +--------------+-------------+--------------+
   | never in irq |      =E2=80=A2      |       .      |
   +--------------+-------------+--------------+

If you prefer, I can send a new version of this patch using this at
the second table:

   +--------------+-------------+--------------+
   |              | irq enabled | irq disabled |
   +--------------+-------------+--------------+
   | ever in irq  |     '?'     |      '-'     |
   +--------------+-------------+--------------+
   | never in irq |     '+'     |      '.'     |
   +--------------+-------------+--------------+

and keep using '.' at the other parts of the document.

This should solve the Sphinx issue, although the Sphinx output
won't be using a monospaced font.

Thanks,
Mauro
