Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B90812B88D3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbgKRXxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:53:08 -0500
Received: from mail-40134.protonmail.ch ([185.70.40.134]:23682 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgKRXxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:53:08 -0500
Date:   Wed, 18 Nov 2020 23:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1605743585;
        bh=JLhtwV/RTQCLYF40yQDEoyV3nfuGUacfufpHAhABNG0=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=iaigbkry/atxYd7cT6AqoT9VFlSmpR6SVHT7xfsGoM3hj8kdfuRrPDvs0uJQSOSCp
         mDRqbQsS3INgH7AAKSV1GXi2Xgt7ALUDYw8Z/0FSSHGRP4KLaU0A0BjTjUyAjMnVwX
         QIVDpNvdhZMqZP/5+qgKh7pPfZUsNC+N7G9L/vQU=
To:     Jonathan Corbet <corbet@lwn.net>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: Re: [PATCH v2] docs: automarkup.py: Allow automatic cross-reference inside C namespace
Message-ID: <C76SLA2MZ7PJ.1I3UT6HA93TAK@ArchWay>
In-Reply-To: <20201118133704.43977072@lwn.net>
References: <20201117021107.214704-1-nfraprado@protonmail.com> <20201118133704.43977072@lwn.net>
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

On Wed Nov 18, 2020 at 5:37 PM -03, Jonathan Corbet wrote:
>
> On Tue, 17 Nov 2020 02:12:01 +0000
> N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com> wrote:
>
> > Sphinx 3.1 introduced namespaces for C cross-references. With this,
> > each C domain type/function declaration is put inside the namespace tha=
t
> > was active at the time of its declaration.
> >
> > Add support for automatic cross-referencing inside C namespaces by
> > checking whether the corresponding source file had a C namespace Sphinx
> > directive, and if so, try cross-referencing inside of it before going t=
o
> > the global scope.
> >
> > This assumes there's only one namespace (if any) per rst file.
> >
> > Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@protonmail.com>
> > ---
> >
> > To those following from v1:
> >
> > I ended up doing the simplest solution possible, which is to just direc=
tly read
> > the rst source corresponding to the doc page right before doing the aut=
omarkup.
> > It's not very efficient in the sense that the source is being read
> > twice (first by Sphinx, then by this), but it sidesteps the "data shari=
ng
> > between processes" issue, so parallel_read_safe can be reenabled, and I=
 didn't
> > notice any performance hit from this patch (as opposed to the big hit f=
rom v1).
> > Works with both Sphinx 2 and 3.
>
> The solution does lack elegance, but it is a solution, which is more than
> we had before :)

Exactly :P

> That said, rather than re-opening and re-reading the
> file, why not just connect to the source-read event, which will happily
> hand you the document source that it has already read?

Unfortunately that wouldn't work. What would happen is that Sphinx would sp=
awn a
python process to handle the source-read event for file X, then later it wo=
uld
spawn another python process to handle doctree-resolved for the same file X=
.
Being two different processes, data can't easily be shared between them, wh=
ich
is why I originally disabled parallel_read_safe, to force everything into a
single process, enabling data to be stored in the source-read phase to be l=
ater
used at the doctree-resolved phase.

What we need is a single process that both reads the source and uses that i=
nfo
to make the auto markup. With parallel_read_safe enabled, that is only poss=
ible
by doing everything in a single Sphinx event (namely, doctree-resolved), an=
d
therefore the read needs to be done manually outside of Sphinx.

Thanks,
N=C3=ADcolas

>
> Thanks,
>
> jon

