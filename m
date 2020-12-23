Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874532E1DA9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLWO6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 09:58:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgLWO6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 09:58:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8A17423357;
        Wed, 23 Dec 2020 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608735470;
        bh=TLE3aZVDMVf/dBzyKz+GNF0rhX/HaeL+aS6q1poDzuw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sWbi5yJPL721/6QJP7i5Y7nqjxFy0lWa61SgYgcFLOm7eQymYok/B151Aw4oKw5dg
         O0rJB3C+3S6CHb75UgkZHyZ3bhV2WRxy8ABHwabA54S1DFLJYcjSereE+zRHue0sV1
         sqQvlTcRLp771nMEnoyEcxmXcsrWffS1fPn4gkvTUjMI2xnJ8Lb12vTfdNR+Z1yX8A
         NavpczL/yGmZh438XUGdaFT1lpZ7yhNnN4xPSt5h1kaxUWfYGqj8jJvvcNKXyVFpTk
         hho3563ckKBnUmPEQfom/1H6Uhl96YiNFwmMw7E8wjs9RktQiFPGESUS6tkhG0ZFGA
         V0S0JzqdlDhZg==
Received: by mail-lf1-f49.google.com with SMTP id b26so31221803lff.9;
        Wed, 23 Dec 2020 06:57:50 -0800 (PST)
X-Gm-Message-State: AOAM531PqA9Q5YsKcWKY5W55UuklhM4lplagrTMjqxx4faAQLE97HKmh
        eehnzMhmfzOW368BPcssEBe4JzkNwQvQij3bGB8=
X-Google-Smtp-Source: ABdhPJwjv/PQVy9eEgBBiaM+zG3VaESWMf0pYs4e0I9AHWBMjphT2Ni2ant8Uc9H2ykpoDbQubOl/THd/St8eJMr3ho=
X-Received: by 2002:a19:58a:: with SMTP id 132mr10732419lff.355.1608735468890;
 Wed, 23 Dec 2020 06:57:48 -0800 (PST)
MIME-Version: 1.0
References: <20200922091505.471-1-zhenzhong.duan@gmail.com>
 <20200922162901.GA3421308@ZenIV.linux.org.uk> <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
 <20200923002315.GC3421308@ZenIV.linux.org.uk> <CAJF2gTSU4e4yU63z1q502SeuTf2m2BKaD0yZ0deFj0TkiVupFg@mail.gmail.com>
 <20200923045231.GH3421308@ZenIV.linux.org.uk> <CAFH1YnNwqrK+kHbLKH684AwPWM0TfOxKC37TfJe5FYZ4_AXRvA@mail.gmail.com>
In-Reply-To: <CAFH1YnNwqrK+kHbLKH684AwPWM0TfOxKC37TfJe5FYZ4_AXRvA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 23 Dec 2020 22:57:37 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTeqm7=NaUzSQ8NfJwvo8hNrHtkLx7rwyZE5FdmLL7+tw@mail.gmail.com>
Message-ID: <CAJF2gTTeqm7=NaUzSQ8NfJwvo8hNrHtkLx7rwyZE5FdmLL7+tw@mail.gmail.com>
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhengzhong,

I'll take it, thx.

On Wed, Dec 23, 2020 at 10:31 AM Zhenzhong Duan
<zhenzhong.duan@gmail.com> wrote:
>
> On Wed, Sep 23, 2020 at 12:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Sep 23, 2020 at 10:37:31AM +0800, Guo Ren wrote:
> >
> > > > What's going on there?  The mapping is really weird - assuming
> > > > you had v0..v31 in the first 32 elements of regs->vr[], you
> > > > end up with
> > > >
> > > > v0 v1 v2 v3 v2 v3 v6 v7 v4 v5 v10 v11 v6 v7 v14 v15
> > > > v8 v9 v18 v19 v10 v11 v22 v23 v12 v13 v26 v27 v14 v15 v30 v31
> > > >
> > > > in the beginning of the output.  Assuming it is the intended
> > > > behaviour, it's probably worth some comments...
> > > FPU & VDSP use the same regs. 32 FPU regs' width is 64b and 16 VDSP
> > > regs' width is 128b.
> > >
> > > vr[0], vr[1] =3D fp[0] & vr[0] vr[1], vr[2], vr[3] =3D vdsp reg[0]
> > > ...
> > > vr[60], vr[61] =3D fp[15] & vr[60] vr[61], vr[62], vr[63] =3D vdsp re=
g[15]
> > > vr[64], vr[65] =3D fp[16]
> > > vr[66], vr[67] =3D fp[17]
> > > ...
> > > vr[94], vr[95] =3D fp[31]
> > >
> > > Yeah, this is confusing and I'll add a comment later.
> >
> > Umm...  It would help if you described these 3 layouts:
> >         1) kernel-side with VDSP
> >         2) userland (identical to (1)?)
> >         3) kernel-side without VDSP
> > Still confused...
> >
> > PS: my apologies re commit message - I left a note to myself when doing
> > that series and then forgot about it ;-/
> >
> > Anyway, which tree should it go through?  In any case, that fix is
> > Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> > and I can take it through vfs.git or you guys can pick in csky tree;
> > up to you.
>
> Hi Al, Guo
>
> Seems this patch is still pending=EF=BC=8C could you help check it=EF=BC=
=9FThanks
>
> Zhenzhong



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
