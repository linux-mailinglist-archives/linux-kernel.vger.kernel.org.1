Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28FB2D04B5
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbgLFMNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 07:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFMNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 07:13:12 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE2AC0613D0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 04:12:31 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id z188so10011829qke.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 04:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z0RlWkXMtthVekyKZRubcNi0FSjuQz90V66K04gN4AE=;
        b=NPVLaUOqqOQ3JJ/dXEG99WymHJrCrzUH0avfSR3Zy4GnFr+JKEor2Qj8RzCOLeVoHN
         oc/ZWBqz3QSyUJ/IOup0zNNxHz2oDaY0aa6mWYf4NSkbJPUqpN2L72eJuJrhm6aibI1l
         zacqdQ1+SChJSubG0cZtRUn9DfWQP0drZhPwaqBu1zJ0Gu1/tt8LgvaF7ZrFfVbpYbWM
         BtRiDwZjchpgAToMTA3jpzNFe8JNUyj+ORBNptxDDY1zSSmjRCGPSCuGfyHvMJop+bkU
         nJNOFO1GupI+alNKykKWSVn5ylfznvap836ak8iUJUZ5myOET4qpi8zG5mqdtXSkekH5
         xzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z0RlWkXMtthVekyKZRubcNi0FSjuQz90V66K04gN4AE=;
        b=WlOukfCL6wgRUtNFDx0eCXCc6MQPH4nJHl9+lfHW9jsXB+yMsV4aS1UULyuNesd+GL
         2Juqi2qfnBHth1z16L708+qbWenDVLJD4LtaF0ka/PoVUbPEc5Q4APoxcduhx6tDg9IW
         JS8VOAgiOUqBE/lhgl4qrfiO7mDxifyvoD8z2xWwNabuNNImfPG1/Thef5qxs8KsLVZe
         l9pG9aaz4Lgckpzwc3L272/PilyeJj5yb/z0k8X1V3JYXbFYLLRV4jCpXIyQdnBEgMFE
         epM1VZWirnKU7VCN4xr005UfO70pyDqkbq+eMokdgX3miOA7nyd2BiTHLIHfHXrVrkwh
         IjyA==
X-Gm-Message-State: AOAM532oN8IILnCEQdEaquINWTDz+zECvr0QIoZ7Qy45Lq3Vhcaej3oV
        TFNBrGwyPXgKkue6wGG33nyQrR75y+zGcAQA6Z8z0Q==
X-Google-Smtp-Source: ABdhPJzGC4+XoR/RGdnWwPXusLzcoyyDc3iu/BvscOa9zSf4q85jvECMqG5CQV4x5qSw3pKHJoPkoZiKkCr+2ki9p0M=
X-Received: by 2002:a05:620a:12e4:: with SMTP id f4mr19474599qkl.265.1607256749320;
 Sun, 06 Dec 2020 04:12:29 -0800 (PST)
MIME-Version: 1.0
References: <87f443cf-26c0-6302-edee-556045bca18a@ozlabs.ru>
 <CACT4Y+ZAyhk6CuddQNix0fAupXhOpv1t3iOdcXbDh4VDEPyOJQ@mail.gmail.com>
 <CACT4Y+ZHH5DiDj7KvRKtPqkV1CS0TFOkCH-M5bitfCgd5PWotg@mail.gmail.com>
 <87k0tyuztw.fsf@mpe.ellerman.id.au> <414bc088-9441-70c7-88e2-2c928b97db36@ozlabs.ru>
 <87o8j8tq44.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o8j8tq44.fsf@mpe.ellerman.id.au>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 6 Dec 2020 13:12:17 +0100
Message-ID: <CACT4Y+bwv1XPU=cW5MsQuocHik5-8daYUjZc+jPJWtjrs7=s0Q@mail.gmail.com>
Subject: Re: WARN_ON_ONCE
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        syzkaller <syzkaller@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 1:05 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> > On 04/12/2020 12:25, Michael Ellerman wrote:
> >> Dmitry Vyukov <dvyukov@google.com> writes:
> >>> On Thu, Dec 3, 2020 at 10:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >>>> On Thu, Dec 3, 2020 at 10:10 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>
> >>>>> Hi!
> >>>>>
> >>>>> Syzkaller triggered WARN_ON_ONCE at
> >>>>>
> >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/tracepoint.c?h=v5.10-rc6#n266
> >>>>>
> >>>>>
> >>>>> ===
> >>>>> static int tracepoint_add_func(struct tracepoint *tp,
> >>>>>                                 struct tracepoint_func *func, int prio)
> >>>>> {
> >>>>>          struct tracepoint_func *old, *tp_funcs;
> >>>>>          int ret;
> >>>>>
> >>>>>          if (tp->regfunc && !static_key_enabled(&tp->key)) {
> >>>>>                  ret = tp->regfunc();
> >>>>>                  if (ret < 0)
> >>>>>                          return ret;
> >>>>>          }
> >>>>>
> >>>>>          tp_funcs = rcu_dereference_protected(tp->funcs,
> >>>>>                          lockdep_is_held(&tracepoints_mutex));
> >>>>>          old = func_add(&tp_funcs, func, prio);
> >>>>>          if (IS_ERR(old)) {
> >>>>>                  WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
> >>>>>                  return PTR_ERR(old);
> >>>>>          }
> >>>>>
> >>>>> ===
> >>>>>
> >>>>> What is the common approach here? Syzkaller reacts on this as if it was
> >>>>> a bug but WARN_ON_ONCE here seems intentional. Do we still push for
> >>>>> removing such warnings?
> >>
> >> AFAICS it is a bug if that fires.
> >>
> >> See the commit that added it:
> >>    d66a270be331 ("tracepoint: Do not warn on ENOMEM")
> >>
> >> Which says:
> >>    Tracepoint should only warn when a kernel API user does not respect the
> >>    required preconditions (e.g. same tracepoint enabled twice,
> >
> > This says that the userspace can trigger the warning if it does not use
> > the API right.
>
> No I don't think it says that.
>
> It's saying that it should be a WARN if a *kernel* user of the
> tracepoint API violates the API. The implication is that this condition
> should never happen if the kernel is using the tracepoint API correctly,
> and so if we hit this condition it indicates a bug in the kernel that
> should be fixed.
>
> >> or called
> >>    to remove a tracepoint that does not exist).
> >>
> >>    Silence warning in out-of-memory conditions, given that the error is
> >>    returned to the caller.
> >>
> >>
> >> So if you're seeing it then you've someone caused it to return something
> >> other than ENOMEM, and that is a bug.
> >
> > This is an userspace bug which registers the same thing twice, the
> > kernel returns a correct error. The question is should it warn by
> > WARN_ON or pr_err(). The comment in bug.h suggests pr_err() is the right
> > way, is not it?
>
> Userspace must not be able to trigger a WARN.
>
> What is the path into that code from userspace?

There are lots of info on this WARNING in the syzbot report:
https://syzkaller.appspot.com/bug?id=41f4318cf01762389f4d1c1c459da4f542fe5153
https://lore.kernel.org/lkml/000000000000a6348d05a9234041@google.com/

There are lots of sample stacks and reproducers, also happens on 4.14 and 4.19.

> Either something on that path should be checking that it's not violating
> the API and triggering the WARN, or if that's not possible/easy then the
> WARN should be removed.
>
> cheers
