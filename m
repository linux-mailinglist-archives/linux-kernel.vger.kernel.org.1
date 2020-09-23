Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAA527550E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgIWKEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 06:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWKEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 06:04:55 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2435C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:04:54 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y13so23019982iow.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 03:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U3SJLMlf/gmjcb1bIq1gmYKwOwQU6kOmc4/dD7hBTLI=;
        b=AnF9bkr+Aofx+XR6HFARYdNts9+MCFj6xElg03TL4mbKqwB33/RxxUR1B3JuBGn6Ep
         lKE+ysLgFx7oo3ZOCViOcEHvaYNSlzitXJTRbSe4rP8BqboWFVVyfQoYiW65+8JMvFv7
         VQ3Yr1iHP1QGE17uMY81/BtOdLDHWrDH9jGlFyzUwnXxSM61fNUOCHXMIADit8pK09eC
         VPjY3Sn60haZM8/pIODuSTwT7kva4LPnIYQCO9yY49V3p3fItl1B6KGp1nw4J41W1Kxb
         CyM8judgx+xv6GXc8AS77zzqWLaSBKmyWTjz7kWNtRZNbf8tMG5QnzQjZz2uVrvzxMhw
         uGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U3SJLMlf/gmjcb1bIq1gmYKwOwQU6kOmc4/dD7hBTLI=;
        b=X5r13VmN2DwKmatUd2DMWpO6ahTf0Dwq18M6MKZfdzEDKMigxTQmfQ4eneqEVBVfEW
         Q3bN1fQdPQKRoBkIyJuHsmzJsb4kbN6QrmjuE4V7SMkOUm8YYO7Nv9XlOxOL+PSS/KrZ
         B8eRZIbGg6QzaMnNhu5mrtB0iL6NKmJZoqi0TG+l9NdYg81Khw4rkY+z4j1KC8UFmflP
         JdrdDOtzFrNQeFZXFcWO+b1CEu3ghg/9dt4lrUcPSymMsiuAHgcNMmU8X7Uxc0CVdbxM
         1+aU6/IzM2wRKND8eTIUZqQbTg2ruVlG1WscceYMbKNs7UMekTdepUnLYeYk/2zZnrTz
         cpZg==
X-Gm-Message-State: AOAM5304+KUIsOU5O5t7vihWLws1kJBqUtvrL//ZqKxRyQ8ZrFSQIxof
        +eJVJVtuYExNl1xj9luoHuIaElVaMaSN2WlpS/8=
X-Google-Smtp-Source: ABdhPJxqbN0Ql5FC1qxjeBTn3rLaRsch4PfTVq6Y5dMRz+dkBBngdnkN1RXN+z39qc0QoQMv2mKP5RT5jG1+H2xQhbQ=
X-Received: by 2002:a6b:7005:: with SMTP id l5mr6728218ioc.10.1600855494306;
 Wed, 23 Sep 2020 03:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200917181347.1359365-1-axelrasmussen@google.com>
 <CALOAHbDSHGeXjJN3E5mTOAFTVsXAvQL9+nSYTqht5Lz8HRNv0A@mail.gmail.com>
 <CAJHvVcg6eY0vVtfi8D6D9aus7=5zeP2H7Yc0mY5ofXztSzOFqQ@mail.gmail.com>
 <CALOAHbBr=ASfvHw1ZscWBE=CY-e7sBrLV0F5Ow=g1UGxmQsWcw@mail.gmail.com> <20200922125113.12ef1e03@gandalf.local.home>
In-Reply-To: <20200922125113.12ef1e03@gandalf.local.home>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 23 Sep 2020 18:04:17 +0800
Message-ID: <CALOAHbD2qgvd7CHy6ZFJ_h8drtRWEU=E-hPofY-TuGTNfxyQbw@mail.gmail.com>
Subject: Re: [PATCH] mmap_lock: add tracepoints around lock acquisition
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 12:51 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 22 Sep 2020 12:09:19 +0800
> Yafang Shao <laoar.shao@gmail.com> wrote:
>
> > > > Are there any methods to avoid un-inlining these wrappers ?
> > > >
> > > > For example,
> > > > // include/linux/mmap_lock.h
> > > >
> > > > void mmap_lock_start_trace_wrapper();
> > > > void mmap_lock_acquire_trace_wrapper();
> > > >
> > > > static inline void mmap_write_lock(struct mm_struct *mm)
> > > > {
> > > >     mmap_lock_start_trace_wrapper();
> > > >     down_write(&mm->mmap_lock);
> > > >     mmap_lock_acquire_trace_wrapper();
> > > > }
> > > >
> > > > // mm/mmap_lock.c
> > > > void mmap_lock_start_trace_wrapper()
> > > > {
> > > >     trace_mmap_lock_start();
> > > > }
> > > >
> > > > void mmap_lock_start_trace_wrapper()
> > > > {
> > > >     trace_mmap_lock_acquired();
> > > > }
> > >
> > > We can do something like that, but I don't think it would end up being better.
> > >
> > > At the end of the day, because the trace stuff cannot be in the
> > > header, we have to add an extra function call one way or the other.
> > > This would just move the call one step further down the call stack.
> > > So, I don't think it would affect performance in the
> > > CONFIG_MMAP_LOCK_STATS + tracepoints not enabled at runtime case.
> > >
> >
> > Right, it seems we have to add an extra function call.
> >
> > > Also the wrappers aren't quite so simple as this, they need some
> > > parameters to work. (the struct mm_struct, whether it was a read or a
> > > write lock, and whether or not the lock operation succeeded), so it
> > > would mean adding more inlined code, which I think adds up to be a
> > > nontrivial amount since these wrappers are called so often in the
> > > kernel.
> > >
> > > If you feel strongly, let me know and I can send a version as you
> > > describe and we can compare the two.
> > >
> >
> > These tracepoints will be less useful if we have to turn on the config
> > to enable it.
> > I don't mind implementing it that way if we can't optimize it.
> >
> > Maybe Steven can give some suggestions, Steven ?
> >
>
>
> What you can do, and what we have done is the following:
>
> (see include/linux/page_ref.h)
>
>
> #ifdef CONFIG_TRACING
> extern struct tracepoint __tracepoint_mmap_lock_start_locking;
> extern struct tracepoint __tracepoint_mmap_lock_acquire_returned;
>
> #define mmap_lock_tracepoint_active(t) static_key_false(&(__tracepoint_mmap_lock_##t).key)
>
> #else
> #define mmap_lock_tracepoint_active(t) false
> #endif
>
> static inline void mmap_write_lock(struct mm_struct *mm)
> {
>         if (mmap_lock_tracepoint_active(start_locking))
>                 mmap_lock_start_trace_wrapper();
>         down_write(&mm->mmap_lock);
>         if (mmap_lock_tracepoint_active(acquire_returned))
>                 mmap_lock_acquire_trace_wrapper();
> }
>
>
> -- Steve


Great!

Thanks Steve.

-- 
Thanks
Yafang
