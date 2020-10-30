Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343C62A077F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgJ3OKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgJ3OKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:10:32 -0400
Received: from coco.lan (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 763E0206F7;
        Fri, 30 Oct 2020 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604067031;
        bh=vtiRxNbEy+gM88Ub3zLztcjaUW8rsYPrflGqYT98Cp4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FRXIwTOCwrgNpPpAwII8TU2AKjH+oJ+vWUF+020EC6eZ3SFlT5iDE9vEzbdyId8e/
         eSKzQ/GHfGrWInrSygQJXo9+yxWQ9Z0DBDbDEjklDrg/Rxo8+p0bc6PG06lRN8h2OU
         WhTU+nalICuNkZLhL74oR3VpXcsmktJOSLm1RPTo=
Date:   Fri, 30 Oct 2020 15:10:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     "=?UTF-8?B?TsOtY29sYXM=?= F. R. A. Prado" <nfraprado@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkcamp@lists.libreplanetbr.org,
        andrealmeid@collabora.com
Subject: Python 2.7 support and automarkup.py - Was: Re: [PATCH v2 1/5]
 docs: automarkup.py: Use new C roles in Sphinx 3
Message-ID: <20201030151026.3afd7997@coco.lan>
In-Reply-To: <5053e824-625b-5a76-d862-2c855c79c427@collabora.com>
References: <20201013231218.2750109-1-nfraprado@protonmail.com>
        <20201013231218.2750109-2-nfraprado@protonmail.com>
        <5053e824-625b-5a76-d862-2c855c79c427@collabora.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dafna,

Em Fri, 30 Oct 2020 14:33:52 +0100
Dafna Hirschfeld <dafna.hirschfeld@collabora.com> escreveu:

> Hi
>=20
> Am 14.10.20 um 01:13 schrieb N=C3=ADcolas F. R. A. Prado:
> > While Sphinx 2 used a single c:type role for struct, union, enum and
> > typedef, Sphinx 3 uses a specific role for each one.
> > To keep backward compatibility, detect the Sphinx version and use the
> > correct roles for that version.
> >=20
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
> > ---
> >   Documentation/sphinx/automarkup.py | 55 ++++++++++++++++++++++++++----
> >   1 file changed, 49 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/sphinx/automarkup.py b/Documentation/sphinx/=
automarkup.py
> > index a1b0f554cd82..db13fb15cedc 100644
> > --- a/Documentation/sphinx/automarkup.py
> > +++ b/Documentation/sphinx/automarkup.py
> > @@ -23,7 +23,21 @@ from itertools import chain
> >   # bit tries to restrict matches to things that won't create trouble.
> >   #
> >   RE_function =3D re.compile(r'(([\w_][\w\d_]+)\(\))')
> > -RE_type =3D re.compile(r'(struct|union|enum|typedef)\s+([\w_][\w\d_]+)=
')
> > +
> > +#
> > +# Sphinx 2 uses the same :c:type role for struct, union, enum and type=
def
> > +#
> > +RE_generic_type =3D re.compile(r'(struct|union|enum|typedef)\s+([\w_][=
\w\d_]+)')
> > +
> > +#
> > +# Sphinx 3 uses a different C role for each one of struct, union, enum=
 and
> > +# typedef
> > +#
> > +RE_struct =3D re.compile(r'\b(struct)\s+([a-zA-Z_]\w+)', flags=3Dre.AS=
CII)
> > +RE_union =3D re.compile(r'\b(union)\s+([a-zA-Z_]\w+)', flags=3Dre.ASCI=
I)
> > +RE_enum =3D re.compile(r'\b(enum)\s+([a-zA-Z_]\w+)', flags=3Dre.ASCII)
> > +RE_typedef =3D re.compile(r'\b(typedef)\s+([a-zA-Z_]\w+)', flags=3Dre.=
ASCII) =20
>=20
> I use ubuntu 18.04, my default python is 2.7,
> when running 'make htmldocs' with that fix I get:
>=20
> AttributeError: 'module' object has no attribute 'ASCII'

FYI, there's a discussion at kernel-doc ML about dropping support for
python 2.7 at Kernel 5.11. While not explicitly mentioned at the
discussion, this is the rationale:

	https://www.python.org/doc/sunset-python-2/

As this is currently broken with Python 2.7, then perhaps we can
do that for 5.10 :-)

Jon,

What do you think?=20

I see a few alternatives:

1) fix automarkup.py for it to work again with python 2.7;

2) conf.py could gain some logic to disable automarkup with
   Python < 3;

3) scripts/sphinx-pre-install already detects Python version.=20
   It should likely be easy to ask the user to use python 3.x,
   if an older version is detected.

Doing (1) or (2) will require an additional step when we raise
the bar for Python version.

Thanks,
Mauro
