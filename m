Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324612780C4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgIYGeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgIYGeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:34:08 -0400
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDE17235F8;
        Fri, 25 Sep 2020 06:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601015647;
        bh=amAPdhrqPuLJn+5i6b8ttL9Z/Dbp2FpG/s3Qbb//sCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GCuLxUSZHg/qzQby6H0WlGzbrFIr/jkty0DUSk2SYaejqaGd4z46Sjro3dAb+x1YD
         eiT4fZ7/j3xLqZZPyEqnxYiRvv/rpE5/vzPmJIPXk3fz2nCDijfUmDcVXa7EcKNn2n
         ggEHpUQEM4/KlhbUA+f7WXkv/tQEvVJ6tOZpdYsA=
Received: by mail-lf1-f49.google.com with SMTP id y17so1526735lfa.8;
        Thu, 24 Sep 2020 23:34:06 -0700 (PDT)
X-Gm-Message-State: AOAM530RZeEZtdvTrZABHpbfJU+PdIbKGnY5z47wpCeOkaWurx8dm3s2
        34Ea5hF4diit5awRqDR7bhcL39jBYnbxm65H1pk=
X-Google-Smtp-Source: ABdhPJyj7MW82Lm69rSYI94+WN3tjHrUZIx1nispUPoncSCx8ouWV0ji/iKhmBQw8Og6fksOFpaqVmZZ+U1CYG99UtA=
X-Received: by 2002:a19:3c8:: with SMTP id 191mr754965lfd.549.1601015645132;
 Thu, 24 Sep 2020 23:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200922091505.471-1-zhenzhong.duan@gmail.com>
 <20200922162901.GA3421308@ZenIV.linux.org.uk> <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
 <20200923002315.GC3421308@ZenIV.linux.org.uk> <CAJF2gTSU4e4yU63z1q502SeuTf2m2BKaD0yZ0deFj0TkiVupFg@mail.gmail.com>
 <20200923045231.GH3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200923045231.GH3421308@ZenIV.linux.org.uk>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 25 Sep 2020 14:33:53 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTb1QN=BmbtcqkNPpUzGa1fQsQtMM2pjrRtNOVxdkkWkQ@mail.gmail.com>
Message-ID: <CAJF2gTTb1QN=BmbtcqkNPpUzGa1fQsQtMM2pjrRtNOVxdkkWkQ@mail.gmail.com>
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 23, 2020 at 10:37:31AM +0800, Guo Ren wrote:
>
> > > What's going on there?  The mapping is really weird - assuming
> > > you had v0..v31 in the first 32 elements of regs->vr[], you
> > > end up with
> > >
> > > v0 v1 v2 v3 v2 v3 v6 v7 v4 v5 v10 v11 v6 v7 v14 v15
> > > v8 v9 v18 v19 v10 v11 v22 v23 v12 v13 v26 v27 v14 v15 v30 v31
> > >
> > > in the beginning of the output.  Assuming it is the intended
> > > behaviour, it's probably worth some comments...
> > FPU & VDSP use the same regs. 32 FPU regs' width is 64b and 16 VDSP
> > regs' width is 128b.
> >
> > vr[0], vr[1] = fp[0] & vr[0] vr[1], vr[2], vr[3] = vdsp reg[0]
> > ...
> > vr[60], vr[61] = fp[15] & vr[60] vr[61], vr[62], vr[63] = vdsp reg[15]
> > vr[64], vr[65] = fp[16]
> > vr[66], vr[67] = fp[17]
> > ...
> > vr[94], vr[95] = fp[31]
> >
> > Yeah, this is confusing and I'll add a comment later.
>
> Umm...  It would help if you described these 3 layouts:
>         1) kernel-side with VDSP
With VDSP: we use vdsp ld/st instructions to access first 16
128bit-regs and use fpu ld/st instructions to access last 16
64bit-regs.

>         2) userland (identical to (1)?)
Identical to 1.

>         3) kernel-side without VDSP
Without VDSP: we use fpu ld/st instructions to access last 32 64bit-regs.

So, there are 96 32bit-vr[] for the struct. And with VDSP or not will
got different storage format.
With VDSP:
vr128[16] // contain first fp64[16]
fp64[16]; // second fp64[16]

Without VDSP:
fp64[32]
no-use for the reset vr[]

> Still confused...
>
> PS: my apologies re commit message - I left a note to myself when doing
> that series and then forgot about it ;-/
>
> Anyway, which tree should it go through?  In any case, that fix is
Thx for your job, and pushing to linus with Zhenzhong Duan's advice.

> Acked-by: Al Viro <viro@zeniv.linux.org.uk>
> and I can take it through vfs.git or you guys can pick in csky tree;
> up to you.

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
