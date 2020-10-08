Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD9286E62
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgJHGDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgJHGDM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:03:12 -0400
Received: from coco.lan (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E06092173E;
        Thu,  8 Oct 2020 06:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602136991;
        bh=vpzw2eAPwPm0AHcA/aZnYkEH6aH6DDHIDFv9+O5ovNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CDRzFJMF8lg4koIcHSZ5b9K6yXAf9BTq+2DS7fj4GKi7TYzJHtgJs3sr0cwBw/Atg
         ZxsyZiE8JOgZtUOvMQqJcXGpfuVe4+J6Be6icBJhBf7xGi4RfPvx0/dYxCq3fhdZE+
         eWtXD71GaJ7BzsP2HfoGLqvngjtIOeyPyUajpAJ4=
Date:   Thu, 8 Oct 2020 08:03:06 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Re: [PATCH] docs: Make automarkup ready for Sphinx 3.1+
Message-ID: <20201008080306.25e89901@coco.lan>
In-Reply-To: <20201008024706.GZ20115@casper.infradead.org>
References: <C674RBXSO9XN.1LXXU71QQNTF1@ArchWay>
        <20201008024706.GZ20115@casper.infradead.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 8 Oct 2020 03:47:06 +0100
Matthew Wilcox <willy@infradead.org> escreveu:

> On Thu, Oct 08, 2020 at 02:15:24AM +0000, N=C3=ADcolas F. R. A. Prado wro=
te:
> > > I have a feature request ... could you automarkup NULL as being
> > > :c:macro?
> > > Or maybe just anything matching \<[[:upper:]_[:digit:]]*\>
> > > (i may have my regex syntax confused ... a word composed of any
> > > arrangement of upper-case, digits and underscores.) =20
> >=20
> > I think what you are suggesting are two separate things.
> >=20
> > For NULL, what you're interested in is that it appears in a monospaced =
font, as
> > if written ``NULL``, right? As I don't think a cross-reference to "the =
NULL
> > macro definition" would make much sense.
> >=20
> > While "anything containing only upper-case, digits and underscores" wou=
ld
> > actually be for cross-referencing to the definition of the macro symbol=
 in
> > question, right? =20
>=20
> Well, maybe!  What I'd really like is to remove all the markup from
> xarray.rst.  Jon managed to get rid of most of it with the (), but
> there's still markup on:
>=20
> LONG_MAX
> NULL
> -EBUSY
> true
> XA_MARK_[012]
> XA_FLAGS_*
> ENOMEM
> EINVAL
>=20
> I'm not sure there's much that automarkup can do about ``true``, but all
> the others fit the all-caps-and-underscore-and-digits pattern.
>=20
> I don't know how much we want errnos to link to anything in particular.
> So maybe split these into 'well-known' (eg defined by ANSI C or POSIX)
> definitions and things which are local macros:
>=20
> LONG_MAX
> NULL
> -EBUSY
> ENOMEM
> EINVAL

Yeah, a nice improvement would be to auto-markup error codes and NULL as
literal blocks.

>=20
> vs
>=20
> XA_MARK_[012]

> XA_FLAGS_*

Actually, things that end with an * (but doesn't start with an *)
are good candidates for being literals - although extra care should
be taken on such case, as parsing those automatically will likely hit
lots of false-positives.

> I'm willing to add more inline kernel-doc to get this to work better.

Why? inline kernel-doc should be evaluated just like normal blocks.

Right now, kernel-doc handles constants like NULL and XA_FLAGS_* using
two ways:

	%FOO
or
	``FOO``

The regex for those are:

	my $type_constant =3D '\b``([^\`]+)``\b';
	my $type_constant2 =3D '\%([-_\w]+)';


In other words, "%FOO" should not contain any symbol, except for
'-' and '_'.

If there is any other symbol, like in "XA_FLAGS_*", the alternative
syntax is needed.

No matter if you use inline or block definitions, the same regexes
are used.

> Or even convert #defines to enums ... whatever gets this working better.

Using enums where possible[1] is nicer, IMHO.=20

[1] enums shouldn't be used on uAPI, as its size depends on the C
    compiler implementation.

Thanks,
Mauro
