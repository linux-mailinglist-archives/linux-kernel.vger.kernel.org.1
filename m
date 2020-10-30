Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834322A0938
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgJ3PHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:07:37 -0400
Received: from mail-40131.protonmail.ch ([185.70.40.131]:12392 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgJ3PHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:07:36 -0400
Date:   Fri, 30 Oct 2020 15:07:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1604070453;
        bh=dO067Du616gppn3odIoUv7mhFuoUfCE7iufuNp8y+eI=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=qYlIUahx2xPgGksqR1/dQ0PntZ6lRV40wZ0fKYI7xJpV57g54vt66C8tbNs5ZBGPC
         Oc9i1HTKF05vRyzfYz4BLdMHQpVGbyEItvAsfNRmIFv5npaEeFXsSLFj1ORJA3TirJ
         lcc7Tj+wneJRehrfeSZR71Uwc4g0PXRSTTVNO44M=
To:     Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: Re: Python 2.7 support and automarkup.py - Was: Re: [PATCH v2 1/5] docs: automarkup.py: Use new C roles in Sphinx 3
Message-ID: <C6QBFCF3JXER.2W4KLG5ZMXH13@ArchWay>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 30, 2020 at 11:39 AM -03, Matthew Wilcox wrote:
>
> On Fri, Oct 30, 2020 at 08:14:40AM -0600, Jonathan Corbet wrote:
> > On Fri, 30 Oct 2020 15:10:26 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >
> > > I see a few alternatives:
> > >
> > > 1) fix automarkup.py for it to work again with python 2.7;
> > >
> > > 2) conf.py could gain some logic to disable automarkup with
> > >    Python < 3;
> > >
> > > 3) scripts/sphinx-pre-install already detects Python version.
> > >    It should likely be easy to ask the user to use python 3.x,
> > >    if an older version is detected.
> > >
> > > Doing (1) or (2) will require an additional step when we raise
> > > the bar for Python version.
> >
> > We haven't dropped support for Python 2 yet, so this constitutes a
> > regression.  My own approach would be something like this at the top of
> > automarkup.py:
> >
> > =09if python2:
> > =09    ascii =3D 0
> > =09else:
> > =09    ascii =3D re.ASCII
> >
> > ...then s/re.ASCII/ascii/ throughout.  I can probably put together
> > something later this morning.
>
> Could we have a warning somewhere that python 2.7 is going to produce
> inferior docs?

But I don't expect the docs to have inferior quality using python 2.7.
The fix proposed by Jon should be enough to solve the issue.

>
> Alternatively, https://docs.python.org/2/library/re.html suggests
> using "The third-party regex module".

I still think Jon's solution would be better, as it doesn't add any additio=
nal
dependency.
In the end the issue is just python 2 defaults to ASCII while python 3 defa=
ults
to unicode.

Thanks,
N=C3=ADcolas

