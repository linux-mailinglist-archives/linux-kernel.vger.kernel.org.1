Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484C7274D94
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 02:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgIWADg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 20:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIWADf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 20:03:35 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E775B20757;
        Wed, 23 Sep 2020 00:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600819414;
        bh=i58ypvkgLjLghB96ZUovykSRgFAs1lf7vEOaMTuu5Z0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ivo+aU4F5Ovmissa17bOszq2nvN9ZTM3cWJly+f8zqpNzwl7YJgM2EE73uxWKeQJB
         4M6kJwy4roA+eqG61qZ+l7Pj1GYBHyuY20bXET9eqIYpxAO5Te+tKONQRBSV7Fm0zP
         YeO7SMS+14z/pr5mVD69WJI3BPmpg7I77fWUIn0g=
Received: by mail-lf1-f42.google.com with SMTP id b22so19966054lfs.13;
        Tue, 22 Sep 2020 17:03:33 -0700 (PDT)
X-Gm-Message-State: AOAM530FTaTdojpQsGgqT38GLofHBOx6ixxqtvVtqQhSPvLtBVAlGsAH
        roFe6HUBH1Wj6sHrpsG0wPV7ErU6NAw7FI+Xz1w=
X-Google-Smtp-Source: ABdhPJxzsHes4chXBhlUMVanCfLt3orAEKdPUPooP+Scdvmd2OOjL177tqamlgnbhh0pF+87gQqTIf5p9KgcxPdEvoI=
X-Received: by 2002:a19:a41a:: with SMTP id q26mr2281545lfc.121.1600819412236;
 Tue, 22 Sep 2020 17:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200922091505.471-1-zhenzhong.duan@gmail.com> <20200922162901.GA3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200922162901.GA3421308@ZenIV.linux.org.uk>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 23 Sep 2020 08:03:20 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
Message-ID: <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thx Duan,

Acked-by: Guo Ren <guoren@kernel.org>

Hi AI,

I found the broken commit still has a question:

> commit dcad7854fcce6a2d49b6a3ead5bbefeff047e559
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Tue Jun 16 15:28:29 2020 -0400

>    csky: switch to ->regset_get()

>    NB: WTF "- what the fuck :(" is fpregs_get() playing at???
The fpregs_get() is for REGSET_FPR regset used by ptrace (gdb) and all
fp regs are stored in threads' context.
So, WTF question for?

Best Regards
 Guo Ren

On Wed, Sep 23, 2020 at 12:29 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Sep 22, 2020 at 05:15:05PM +0800, Zhenzhong Duan wrote:
> > "*" is missed  in size determination as we are passing register set
> > rather than a pointer.
>
> Ack.  I can push it to Linus today, unless you want it to go through
> csky tree.  Preferences?
>
> > Fixes: dcad7854fcce ("sky: switch to ->regset_get()")
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> > ---
> >  arch/csky/kernel/ptrace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
> > index d822144906ac..a4cf2e2ac15a 100644
> > --- a/arch/csky/kernel/ptrace.c
> > +++ b/arch/csky/kernel/ptrace.c
> > @@ -83,7 +83,7 @@ static int gpr_get(struct task_struct *target,
> >       /* Abiv1 regs->tls is fake and we need sync here. */
> >       regs->tls = task_thread_info(target)->tp_value;
> >
> > -     return membuf_write(&to, regs, sizeof(regs));
> > +     return membuf_write(&to, regs, sizeof(*regs));
> >  }
> >
> >  static int gpr_set(struct task_struct *target,
> > --
> > 2.25.1
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
