Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6CC2881D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 07:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbgJIFyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 01:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJIFyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 01:54:01 -0400
Received: from coco.lan (ip5f5ad5d0.dynamic.kabel-deutschland.de [95.90.213.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A522222F;
        Fri,  9 Oct 2020 05:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602222840;
        bh=IsKZBtZjGxV8D/buzpbbAbqpzlM09DUTQcsVZaQmIaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t++t1gYkbMkUlClHXPeg8Iy8VoPVRNG6+BCoRKUQoRwa0RiYjkTXDWz0vb8Prugl+
         mmVTYINW55OKFCNp9N2u0KA9E8W/PrG5toVoTWvNVUJsq9mIfKlETEjrJgGiG12Llc
         VvrQG3E1B0Stm6//0vzk9Ze+wYr7R4KgAYSiwFEY=
Date:   Fri, 9 Oct 2020 07:53:53 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: [PATCH] docs: Make automarkup ready for Sphinx 3.1+
Message-ID: <20201009075353.16e05c65@coco.lan>
In-Reply-To: <C67JVCS5C9NG.LIAW4RFKE6A9@ArchWay>
References: <C67JVCS5C9NG.LIAW4RFKE6A9@ArchWay>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 08 Oct 2020 13:54:59 +0000
N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> escreveu:

> On Thu Oct 8, 2020 at 2:27 AM -03, Mauro Carvalho Chehab wrote:
> >
> > Hi N=C3=ADcolas,
> >
> > Em Wed, 07 Oct 2020 23:12:25 +0000
> > N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> escreveu:
> > =20
> > > While Sphinx 2 used a single c:type role for struct, union, enum and
> > > typedef, Sphinx 3 uses a specific role for each one.
> > > To keep backward compatibility, detect the Sphinx version and use the
> > > correct roles for that version.
> > >
> > > Also, Sphinx 3 is more strict with its C domain and generated warning=
s,
> > > exposing issues in the parsing.
> > > To fix the warnings, make the C regexes use ASCII, ensure the
> > > expressions only match the beginning of words and skip trying to
> > > cross-reference C reserved words.
> > >
> > > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
> > > ---
> > >
> > > Hi,
> > >
> > > after Mauro's series making everything ready for Sphinx 3.1, only the=
 automarkup
> > > was left to be ported.
> > > This patch makes the needed changes to automarkup so that we can soon=
 flip the
> > > switch to Sphinx 3.1.
> > >
> > > This change was tested both with Sphinx 2.4.4 and Sphinx 3.1.
> > >
> > > This change doesn't add any warnings to the Documentation build.
> > > I tested it with Mauro's series but later rebased it to docs-next, an=
d it can be
> > > accepted independently of that series.
> > >
> > > I ended up doing more than one thing in this single patch, but since =
it was all
> > > changing the same lines and for the same purpose, I felt it would be =
better to
> > > keep it as a single commit.
> > > =20
> >
> > Thanks for doing this! That was the last missing part on fully
> > supporting
> > Sphinx 3.1+.
> > =20
> > > Mauro,
> > > if this patch is ok, the 3rd patch in your series, which disables aut=
omarkup for
> > > sphinx 3, should be dropped. =20
> >
> > Yeah, sure.
> > =20
> > > Although I'm not sure what the implications of your patches adding na=
mespaces
> > > and using the c:macro for functions are. =20
> >
> > With regards to namespaces:
> >
> > Currently, only the media docs use namespaces, and it declares it at the
> > beginning of each file that needs it, without overriding it later[1].
> >
> > [1] btw, the cdomain.py backward compat code doesn't support namespace
> > changes - as it parses namespaces before handling the C domain tags.
> > I doubt that we'll need to have a single .rst file using more than
> > one namespace anyway.
> >
> > The main usage is to avoid conflicts for uAPI documentation for
> > syscalls - actually for libc userspace wrappers to syscalls. It
> > documents
> > things like: open, close, read, write, ioctl, poll, select. =20
>=20
> If it's mainly for that, I think automarkup could skip handling namespace=
s.
> From automarkup.py:
>=20
> #
> # Many places in the docs refer to common system calls.  It is
> # pointless to try to cross-reference them and, as has been known
> # to happen, somebody defining a function by these names can lead
> # to the creation of incorrect and confusing cross references.  So
> # just don't even try with these names.
> #
> Skipfuncs =3D [ 'open', 'close', 'read', 'write', 'fcntl', 'mmap',
>               'select', 'poll', 'fork', 'execve', 'clone', 'ioctl',
> 	      'socket' ]
>=20
> So unless I'm confusing things and the namespaces actually sidestep that =
issue,
> the namespace handling could be left out of automarkup.

Maybe I didn't express well enough. We need namespaces due to the
syscals.

Yet, if a .rst file uses it, *all* functions, structs, ... declared
there will be under the namespace.=20

In other words, looking at the V4L docs, for instance, all
functions there will be under "V4L" namespace.

It should be noticed that a side effect of this change is that
we may need to use namespaces on *all* (or almost all) uAPI=20
media documents. I'll double-check this for v5.11.

If automarkup would try to generate a cross-reference for one
of the many V4L2 API structs without using the "V4L" namespace,
it will fail.

Btw, considering that the namespace will solve the issues
with those functions, I suspect that we can avoid skipping them,
at least with Sphinx 3+.

> >
> > I'm not sure if the automarkup should be aware of it, or if the c.py
> > code
> > at Sphinx 3.x will add the namespace automatically, but I suspect that
> > automarkup will need to handle it as well.
> >
> > One file you could use for checking it is this one:
> >
> > Documentation/userspace-api/media/v4l/hist-v4l2.rst
> >
> > It contains a namespace directive and documents what changed without
> > using any explicit reference (after my patch series + linux-next).
> >
> > With regards to c:macro vs c:function:
> >
> > I suspect that automarkup should test both when trying to do
> > cross-references for function-like calls. E. g. test first if
> > there is a :c:function, falling back to check for :c:macro.
> >
> > I would add a "sphinx3_c_func_ref" function that would handle
> > such special case, e. g. something like:
> >
> > markup_func_sphinx3 =3D {RE_doc: markup_doc_ref,
> > RE_function: sphinx3_c_func_ref,
> > RE_struct: markup_c_ref,
> > RE_union: markup_c_ref,
> > RE_enum: markup_c_ref,
> > RE_typedef: markup_c_ref} =20
>=20
> Sounds good.
>=20
> I'll make this patch into a series and add that function/macro handling a=
s a new
> patch, and the namespace handling depending on your answer on the above c=
omment,
> for v2.

Thank you!


Thanks,
Mauro
