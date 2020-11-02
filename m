Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F222A2E61
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgKBPdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:33:18 -0500
Received: from mail1.protonmail.ch ([185.70.40.18]:28825 "EHLO
        mail1.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgKBPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:33:17 -0500
Date:   Mon, 02 Nov 2020 15:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1604331195;
        bh=TXoUXaAzWtbC4Rwq/jtQmzg/TrPNEkhD8i8SzWELcbk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=TmpBUow0drhYdo+re8jGWy2j0wBXODFYJ4loGuPs62JLCaaEqNUwBAjlPt2wTLQw5
         Qy0VjXiv9EZBdgyaZ0/3NFF9eHLI1+rcfSOiK7gbHEVSck1yMOHDqPOkKOV8sgPUNC
         DNBVCP2x9gwsPvYk6tNETEVDiOodUlO4030HQHlM=
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
From:   =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
        <nfraprado@protonmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org, andrealmeid@collabora.com
Reply-To: =?utf-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= 
          <nfraprado@protonmail.com>
Subject: Re: [PATCH v2 5/5] docs: automarkup.py: Allow automatic cross-reference inside C namespace
Message-ID: <C6SV6B4N81VS.2IDXIL452NF5N@ArchWay>
In-Reply-To: <20201014131900.1137cdc8@lwn.net>
References: <20201013231218.2750109-1-nfraprado@protonmail.com> <20201013231218.2750109-6-nfraprado@protonmail.com> <20201014115644.7bda9918@coco.lan> <20201014131900.1137cdc8@lwn.net>
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

On Wed Oct 14, 2020 at 4:19 PM -03, Jonathan Corbet wrote:
>
> On Wed, 14 Oct 2020 11:56:44 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>
> > > To make the first step possible, disable the parallel_read_safe optio=
n
> > > in Sphinx, since the dictionary that maps the files to the C namespac=
es
> > > can't be concurrently updated. This unfortunately increases the build
> > > time of the documentation.
> >
> > Disabling parallel_read_safe will make performance very poor.
> > Doesn't the C domain store the current namespace somewhere?
> > If so, then, instead of using the source-read phase, something
> > else could be used instead.

The issue is that C domain parsing happens at an earlier phase in the Sphin=
x
process, and the current stack containing the C namespace is long gone when=
 we
get to do the automatic cross-referencing at the doctree-resolved phase.

Not only that, but the namespace isn't assigned to the file it's in, and
vice-versa, because Sphinx's interest is in assigning a C directive it is
currently reading to the current namespace, so there isn't any point in sav=
ing
which namespaces appeared at a given file. That is exactly what we want, bu=
t
Sphinx doesn't have that information.

For instance, printing all symbols from app.env.domaindata['c']['root_symbo=
l']
shows every single C namespace, but the docname field in each of them is No=
ne.

That's why the way to go is to assign the namespaces to the files at the
source-read phase on our own.

> That seems like the best solution if it exists, yes. Otherwise a simple
> lock could be used around c_namespace to serialize access there, right?

Actually I was wrong when I said that the issue was that "they can't be
concurrently updated". When parallel_read_safe is enabled, Sphinx spawns
multiple processes rather than multiple threads, to get true concurrency by
sidestepping python's GIL. So the same c_namespace variable isn't even
accessible across the multiple processes.

Reading multiprocessing's documentation [1] it seems that memory could be s=
hared
between the processes using Value or Array, but both would need to be passe=
d to
the processes by the one who spawned them, that is, it would need to be don=
e
from Sphinx's side.

So, at the moment I'm not really seeing a way to have this information be s=
hared
concurrently by the python processes but I will keep searching.

Thanks,
N=C3=ADcolas

[1] https://docs.python.org/3/library/multiprocessing.html#sharing-state-be=
tween-processes

