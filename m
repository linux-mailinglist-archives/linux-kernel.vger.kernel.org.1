Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5C22873FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgJHMZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgJHMZO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:25:14 -0400
Received: from coco.lan (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FAAA20659;
        Thu,  8 Oct 2020 12:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602159914;
        bh=3KpYhHQ85TqDmljH+UC/i0KAIqnhq3Y7TnXDFqhugvg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M3xmhMwIGTnSJtAgbMZJJA0Ks9kTC3Q85NEpwt6QPquV5V9aN3dyW5+NP6T3ZUFNV
         o/sot55fZZ4EJWUVjOOEoTyBK1soBcimn+hqXeLu1zMtDO43ZKyuIEcSe00QhKGtsw
         CQMlEg5A69Aks0YmaTRMqAUyqFRmBICXcbKCK1Gw=
Date:   Thu, 8 Oct 2020 14:25:05 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: [PATCH] docs: Make automarkup ready for Sphinx 3.1+
Message-ID: <20201008142505.0cf36409@coco.lan>
In-Reply-To: <20201008113127.GA20115@casper.infradead.org>
References: <C674RBXSO9XN.1LXXU71QQNTF1@ArchWay>
        <20201008024706.GZ20115@casper.infradead.org>
        <20201008080306.25e89901@coco.lan>
        <20201008113127.GA20115@casper.infradead.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 8 Oct 2020 12:31:27 +0100
Matthew Wilcox <willy@infradead.org> escreveu:

> On Thu, Oct 08, 2020 at 08:03:06AM +0200, Mauro Carvalho Chehab wrote:
> > Em Thu, 8 Oct 2020 03:47:06 +0100
> > Matthew Wilcox <willy@infradead.org> escreveu:
> >  =20
> > > On Thu, Oct 08, 2020 at 02:15:24AM +0000, N=C3=ADcolas F. R. A. Prado=
 wrote: =20
> > > > > I have a feature request ... could you automarkup NULL as being
> > > > > :c:macro?
> > > > > Or maybe just anything matching \<[[:upper:]_[:digit:]]*\>
> > > > > (i may have my regex syntax confused ... a word composed of any
> > > > > arrangement of upper-case, digits and underscores.)   =20
> > > >=20
> > > > I think what you are suggesting are two separate things.
> > > >=20
> > > > For NULL, what you're interested in is that it appears in a monospa=
ced font, as
> > > > if written ``NULL``, right? As I don't think a cross-reference to "=
the NULL
> > > > macro definition" would make much sense.
> > > >=20
> > > > While "anything containing only upper-case, digits and underscores"=
 would
> > > > actually be for cross-referencing to the definition of the macro sy=
mbol in
> > > > question, right?   =20
> > >=20
> > > Well, maybe!  What I'd really like is to remove all the markup from
> > > xarray.rst.  Jon managed to get rid of most of it with the (), but
> > > there's still markup on:
> > >=20
> > > LONG_MAX
> > > NULL
> > > -EBUSY
> > > true
> > > XA_MARK_[012]
> > > XA_FLAGS_*
> > > ENOMEM
> > > EINVAL
> > >=20
> > > I'm not sure there's much that automarkup can do about ``true``, but =
all
> > > the others fit the all-caps-and-underscore-and-digits pattern.
> > >=20
> > > I don't know how much we want errnos to link to anything in particula=
r.
> > > So maybe split these into 'well-known' (eg defined by ANSI C or POSIX)
> > > definitions and things which are local macros:
> > >=20
> > > LONG_MAX
> > > NULL
> > > -EBUSY
> > > ENOMEM
> > > EINVAL =20
> >=20
> > Yeah, a nice improvement would be to auto-markup error codes and NULL as
> > literal blocks.
> >  =20
> > >=20
> > > vs
> > >=20
> > > XA_MARK_[012] =20
> >  =20
> > > XA_FLAGS_* =20
> >=20
> > Actually, things that end with an * (but doesn't start with an *)
> > are good candidates for being literals - although extra care should
> > be taken on such case, as parsing those automatically will likely hit
> > lots of false-positives. =20
>=20
> I do apologise.  I was trying to be concise in email.  In the actual
> text file, I currently have:
>=20
> ``XA_FLAGS_ALLOC``
> ``XA_FLAGS_ALLOC1``
> ``XA_FLAGS_LOCK_IRQ``
> ``XA_FLAGS_LOCK_BH``
> ``XA_FLAGS_TRACK_FREE``

Ah, OK!

>=20
> > > I'm willing to add more inline kernel-doc to get this to work better.=
 =20
> >=20
> > Why? inline kernel-doc should be evaluated just like normal blocks.
> >=20
> > Right now, kernel-doc handles constants like NULL and XA_FLAGS_* using
> > two ways:
> >=20
> > 	%FOO
> > or
> > 	``FOO``
> >=20
> > The regex for those are:
> >=20
> > 	my $type_constant =3D '\b``([^\`]+)``\b';
> > 	my $type_constant2 =3D '\%([-_\w]+)'; =20
>=20
> Right, but that's in kernel-doc ... in a .rst file, I believe we have
> to use the ``SYMBOL`` syntax.

As you mentioned that you're "willing to add more inline kernel-doc",
I assumed that you were talking about kernel-doc markups at the C files.

Yeah, inside a .rst file, this should be ``SYMBOL``.

As you suggested, the automarkup.py could help with replacing some
of those.

-

Just my two cents: a documentation writer hat, it sounds weird to me to=20
mix ``SYMBOL`` (with markup) with NULL (without explicit markup) at the
same file.

Thanks,
Mauro
