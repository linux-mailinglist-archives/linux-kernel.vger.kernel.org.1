Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38972CD26F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgLCJV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgLCJVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:21:25 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043E3C061A4D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 01:20:39 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id y18so1419711qki.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 01:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gUGdlGNoL1O7VEWU2AVMCRfeTyTWIlfCjjdVrD+3qL4=;
        b=YNaTjEMPw2uqFxgiLDxwQKGIYKuGORcEAZ1Fg5A/QLnnulKDKTT7IavUVd1gXfPq9K
         f9vwuHFrKApqi6VDgVwJW8ODLyQBA+cjsdMF41LBebtSz701Dp/ioGGXIhWJ+2a4efmE
         /Nd/FIyt1KHhloJy2tIYci7CSz2ZGcnSG0KCYK6fxwYsOguxHQ+c+vlkdfSCnYrGyBJP
         +2LqqGv4Eu3+KXZkeoU52KWHszczFs7myUqQEIAzAVMxyNWX28YTsuwoM8edtSVQJ55m
         VUhUiNMtoXGZFU8zxsF+NNOitSl5dCKB8bzVhZ0WYIajLci0yoDRPv25srVH2FR4TSLi
         yaxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gUGdlGNoL1O7VEWU2AVMCRfeTyTWIlfCjjdVrD+3qL4=;
        b=pNCyId1dir0XVO70IobryomvAo1rXJV8FPQpNZ/wmU6KdDq22yiLoe+8UuQx5FmPp+
         ShZCeSP/gzeNhi1FytuMLEAnQdW7IbA9/Zj8cyZbMR0VCNXKHRtWvAIXocfkcJDsnyf0
         T1r2ATDjcp7wnYyUI2r2ffXgbPwy3T1H3OF7CwU+VzvoVJlSNJBwSITCFTgp/oon2K9Q
         eHiL/4pLVYvfSMASceRSf2HwbHLfUZ0n9jdymQExHMK3wqJSdkr6mHQayPS4f6bYMpah
         JA4PLxVH6iCquZW8mpHxM0UvMl+3gSH8xUg3KfUzBCZwpd7/NN5ZPPC9s9QSOFxOpDhI
         fHpg==
X-Gm-Message-State: AOAM532Gu+Odd16Svnc2EEjCBGW2UwO0zaRguosufmh3kMyoAS2EDb19
        4D4VdEohrFchpVTkFmiVeXW7N9KNWUvJLjwqdmmE7LahYMI=
X-Google-Smtp-Source: ABdhPJzV0sj/nO118gIR3H0BVqIeI38CqGW0oahBJ6Eh1M+UtkCXFlIUr914OvdvpLeaGcbPcyJA1wQBHf2bQ6LMCZY=
X-Received: by 2002:a05:620a:12e4:: with SMTP id f4mr1945051qkl.265.1606987237985;
 Thu, 03 Dec 2020 01:20:37 -0800 (PST)
MIME-Version: 1.0
References: <87f443cf-26c0-6302-edee-556045bca18a@ozlabs.ru> <CACT4Y+ZAyhk6CuddQNix0fAupXhOpv1t3iOdcXbDh4VDEPyOJQ@mail.gmail.com>
In-Reply-To: <CACT4Y+ZAyhk6CuddQNix0fAupXhOpv1t3iOdcXbDh4VDEPyOJQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 3 Dec 2020 10:20:26 +0100
Message-ID: <CACT4Y+ZHH5DiDj7KvRKtPqkV1CS0TFOkCH-M5bitfCgd5PWotg@mail.gmail.com>
Subject: Re: WARN_ON_ONCE
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 10:19 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Dec 3, 2020 at 10:10 AM Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >
> > Hi!
> >
> > Syzkaller triggered WARN_ON_ONCE at
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/tracepoint.c?h=v5.10-rc6#n266
> >
> >
> > ===
> > static int tracepoint_add_func(struct tracepoint *tp,
> >                                struct tracepoint_func *func, int prio)
> > {
> >         struct tracepoint_func *old, *tp_funcs;
> >         int ret;
> >
> >         if (tp->regfunc && !static_key_enabled(&tp->key)) {
> >                 ret = tp->regfunc();
> >                 if (ret < 0)
> >                         return ret;
> >         }
> >
> >         tp_funcs = rcu_dereference_protected(tp->funcs,
> >                         lockdep_is_held(&tracepoints_mutex));
> >         old = func_add(&tp_funcs, func, prio);
> >         if (IS_ERR(old)) {
> >                 WARN_ON_ONCE(PTR_ERR(old) != -ENOMEM);
> >                 return PTR_ERR(old);
> >         }
> >
> > ===
> >
> > What is the common approach here? Syzkaller reacts on this as if it was
> > a bug but WARN_ON_ONCE here seems intentional. Do we still push for
> > removing such warnings?
>
> +LKML

+LKML for real

> Hi Alexey,
>
> Yes, see the guidelines here:
> https://elixir.bootlin.com/linux/v5.10-rc6/source/include/asm-generic/bug.h#L67
>
> Without a criteria for kernel but/not a kernel bug no kernel testing
> is possible.
>
> But this may be a real bug as well. The code seems to assume that
> ENOMEM is the only possible error here, which is not the case in
> reality.
>
>
> > Another example is:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/tracepoint.h?h=v5.10-rc6#n313
> >
> > My VMs crash on dereferencing it_func_ptr which is easily fixable by:
> >
> > @@ -307,9 +307,11 @@ static inline struct tracepoint
> > *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >                                                                          \
> >                  it_func_ptr =                                           \
> >
> > rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
> > +               if (it_func_ptr)                                        \
> >                  do {                                                    \
> >                          it_func = (it_func_ptr)->func;                  \
> >                          __data = (it_func_ptr)->data;                   \
> >
> >
> > But - this only happens when OOM killer starts killing syzkaller
> > processes (I do not give it much memory so it is quite artificial
> > environment). Do we push these?
> >
> > Are there guidelines of some sort? Thanks,
> >
> >
> > --
> > Alexey
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller/87f443cf-26c0-6302-edee-556045bca18a%40ozlabs.ru.
