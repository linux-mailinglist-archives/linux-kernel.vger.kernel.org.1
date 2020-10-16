Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE18290B40
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391638AbgJPSY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391390AbgJPSY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:24:28 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B805C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:24:28 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q9so5038593iow.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5NngvCZlpVByT++f7qE91SLdHEnOV1NRAu0YOMS/Lo=;
        b=tfke49wMmVeEHZ47+rOE8ezeTppkX/1ALYR5HM/MCTLUJU9PtwVpKQm+5LKx1H5t/A
         Z1S0sAV3EEiyUj8D4lhzFhbkIdluNTU3MSW1j3yUhcXDhmGfD6Pt8yGXs5WX5/rFoeRL
         LPyZYHdK4082r/fSC2bXOL/TjzC+EK8fnWigQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5NngvCZlpVByT++f7qE91SLdHEnOV1NRAu0YOMS/Lo=;
        b=Jh9a9zXkQKyn97mJdKwmD/OzYjGF62ocuI7BRTEo4ivzijFaAu4ReLkSPGcTVMNAa2
         +smOSY71kBtf5svg/qcwgQbVSsIxs5/aqKLL08FUGeu3A9Lr/qhBvhrYb1sCXc30KzAW
         PWWbNWYiymuIP/mW0IC/Aix6Zv2WmOdoi14zxO2TvFjrp848pEXBhDVBpCsxpztLDQJn
         pRNMluZGqGo9XqNwTv97PmBJHVL82wToXrS/3ZlXXoUqykrzfrF96/1VNWn4FOojvlpv
         CUbHplP9gkPrv+TVucXd2rBGTbj2QmKeQTCqVUHH3Fx7Ouwzxtnz5lxzUawY5JmS+GW8
         VQVA==
X-Gm-Message-State: AOAM530Zdht7TWzldKN7JnBs9hk8+IX8QbwpeyC/7nfX61b/ZHPbds92
        aGJxFflRLZ8RFipLm18sbjtuFyov9CXXJD+jeUNf
X-Google-Smtp-Source: ABdhPJxp/UIgSj0aDdvVfswZDSxjOZfD1HWCnBxkYKJwU/swpzjmfUCncgyzEmR83S4Y4o6+E5hxvOhG/KuGSjsc9Uc=
X-Received: by 2002:a02:6952:: with SMTP id e79mr3738592jac.24.1602872667636;
 Fri, 16 Oct 2020 11:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201009211344.2358688-1-atish.patra@wdc.com> <20201009211344.2358688-5-atish.patra@wdc.com>
 <CAHCEehJvMv=CYD1+QXb0uB36Hv4pvO36BAKSLOcxTXvmADZFbA@mail.gmail.com>
 <CAOnJCUKPjkm_=5eHn6=GjVGr67okZkVzqP7-ciphn986BQoc9w@mail.gmail.com>
 <CAOnJCULZMRu+sHmnjoBwtvaB3BjmCiZLzYxNOeWZmoYLKG+wTw@mail.gmail.com>
 <CAHCEehJJmLQ6W5AdH+hEZSJxpDC8HG0UN=EGt9M0Tp5NTfQnaw@mail.gmail.com>
 <CAOnJCUJN-XMZ+N5w+RbVhJag9D_dey7DAopb0Q35GDfXptyMjA@mail.gmail.com>
 <CAFyWVaYORWYZTXyXOWiY6xK-SFTvsUxDNDqKQnhVUwzc5N045Q@mail.gmail.com> <CAOnJCU+3xFyFW4ATCdYAv5zVyBSLE0mTevrJLCXW7HDgy4D4EQ@mail.gmail.com>
In-Reply-To: <CAOnJCU+3xFyFW4ATCdYAv5zVyBSLE0mTevrJLCXW7HDgy4D4EQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 16 Oct 2020 11:24:16 -0700
Message-ID: <CAOnJCUJWf9Hu4frFOJGQLUZ2BQ8qHBd7mvspgvfM1k6e4z5CcA@mail.gmail.com>
Subject: Re: [PATCH 4/5] RISC-V: Protect .init.text & .init.data
To:     Jim Wilson <jimw@sifive.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Kito Cheng <kito.cheng@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Michel Lespinasse <walken@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:24 PM Atish Patra <atishp@atishpatra.org> wrote:
>
> On Tue, Oct 13, 2020 at 6:21 PM Jim Wilson <jimw@sifive.com> wrote:
> >
> > On Tue, Oct 13, 2020 at 3:25 PM Atish Patra <atishp@atishpatra.org> wrote:
> > > This happens only when copy_from_user is called from function that is
> > > annotated with __init.
> > > Adding Kito & Jim for their input
> > >
> > > @kito, @Jim: Please let me know if I should create a issue in
> > > riscv-gnu-toolchain repo or somewhere else.
> >
> > I can't do anything useful without a testcase that I can use to
> > reproduce the problem.  The interactions here are complex, so pointing
> > at lines of code or kernel config options doesn't give me any useful
> > info.
> >
> > Relaxation can convert calls to a jal.  I don't know of any open bugs
> > in this area that can generate relocation errors.  if it is a
> > relaxation error then turning off relaxation should work around the
> > problem as you suggested.
> >
> > A kernel build problem is serious.  I think this is worth a bug
> > report.  FSF binutils or riscv-gnu-toolchain is fine.
> >
>
> I have created an issue with detailed descriptions and reproduction steps.
> Please let me know if you need anything else.
>

It may be a toolchain issue. Here is the ongoing discussion in case
anybody else is interested.

https://github.com/riscv/riscv-gnu-toolchain/issues/738

> > Jim
>
>
>
> --
> Regards,
> Atish



-- 
Regards,
Atish
