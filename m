Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44C1274F12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgIWChp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:37:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:60888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbgIWCho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:37:44 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 238E4208E4;
        Wed, 23 Sep 2020 02:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600828664;
        bh=d4izl6dpSSYawdeLLlt3GvL/MMWMQbopA3NyOdIHh5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zi5nibJFbvIqHGkgQMhexiquJmRx3G3mVy4JHZLSogWQROBEjHSpDHaF/GOSq8My6
         vZDgDweFrVq4jP/hXMJRfBFKp9m2twROmTVq7Z4gYz7hIWSsUMO6+CBBpssxTgkobc
         V6NwSrcw8opA3zrPWHbrJ5nl6BZY7cARb9Lz899A=
Received: by mail-lj1-f178.google.com with SMTP id c2so15859691ljj.12;
        Tue, 22 Sep 2020 19:37:44 -0700 (PDT)
X-Gm-Message-State: AOAM530e9cC3t/LJMFtlbbZAfZeZJflDhSZ3WsMwot2c/mviw29EsPCb
        o4T3WilWl8OS6kmxpk2zCamKf6dsO4+X8QhUmIM=
X-Google-Smtp-Source: ABdhPJxMKfoDnnIR8Jm+7mqsxUZGEzpO1lEhgC9tt320qgEvtzLQaSCEoXL4l45/1MQNDBa+uCcAtgQWAKtEKWVF/3Q=
X-Received: by 2002:a2e:e1a:: with SMTP id 26mr2231873ljo.377.1600828662321;
 Tue, 22 Sep 2020 19:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200922091505.471-1-zhenzhong.duan@gmail.com>
 <20200922162901.GA3421308@ZenIV.linux.org.uk> <CAJF2gTSMWc_=j1NKCTXqhLj7cmSB_A3dYB7nL4F7H3jqT+u38A@mail.gmail.com>
 <20200923002315.GC3421308@ZenIV.linux.org.uk>
In-Reply-To: <20200923002315.GC3421308@ZenIV.linux.org.uk>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 23 Sep 2020 10:37:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSU4e4yU63z1q502SeuTf2m2BKaD0yZ0deFj0TkiVupFg@mail.gmail.com>
Message-ID: <CAJF2gTSU4e4yU63z1q502SeuTf2m2BKaD0yZ0deFj0TkiVupFg@mail.gmail.com>
Subject: Re: [PATCH] csky: Fix a size determination in gpr_get()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 8:23 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Sep 23, 2020 at 08:03:20AM +0800, Guo Ren wrote:
> > Thx Duan,
> >
> > Acked-by: Guo Ren <guoren@kernel.org>
> >
> > Hi AI,
> >
> > I found the broken commit still has a question:
> >
> > > commit dcad7854fcce6a2d49b6a3ead5bbefeff047e559
> > > Author: Al Viro <viro@zeniv.linux.org.uk>
> > > Date:   Tue Jun 16 15:28:29 2020 -0400
> >
> > >    csky: switch to ->regset_get()
> >
> > >    NB: WTF "- what the fuck :(" is fpregs_get() playing at???
> > The fpregs_get() is for REGSET_FPR regset used by ptrace (gdb) and all
> > fp regs are stored in threads' context.
> > So, WTF question for?
>
> The part under
> #if defined(CONFIG_CPU_HAS_FPUV2) && !defined(CONFIG_CPU_HAS_VDSP)
>
> What's going on there?  The mapping is really weird - assuming
> you had v0..v31 in the first 32 elements of regs->vr[], you
> end up with
>
> v0 v1 v2 v3 v2 v3 v6 v7 v4 v5 v10 v11 v6 v7 v14 v15
> v8 v9 v18 v19 v10 v11 v22 v23 v12 v13 v26 v27 v14 v15 v30 v31
>
> in the beginning of the output.  Assuming it is the intended
> behaviour, it's probably worth some comments...
FPU & VDSP use the same regs. 32 FPU regs' width is 64b and 16 VDSP
regs' width is 128b.

vr[0], vr[1] = fp[0] & vr[0] vr[1], vr[2], vr[3] = vdsp reg[0]
...
vr[60], vr[61] = fp[15] & vr[60] vr[61], vr[62], vr[63] = vdsp reg[15]
vr[64], vr[65] = fp[16]
vr[66], vr[67] = fp[17]
...
vr[94], vr[95] = fp[31]

Yeah, this is confusing and I'll add a comment later.




--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
