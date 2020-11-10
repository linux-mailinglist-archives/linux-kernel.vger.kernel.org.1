Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EF12AD951
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbgKJOyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731011AbgKJOyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:54:00 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D0C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:54:00 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id z16so12732017otq.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbcyUD14O34qORQweJ7OM0zfYmKvTkKcQqefmr2UkfI=;
        b=mNP/K9iv5SYU27emsjB5W17wgZ7cLje94t1rArD5f7lC/L5J98/SvmNImo0623rskX
         kasAc/JGxTZ5n7ILmHtJbYeD1Umhh05nHDrERl5XklzG/faCGnMqaDT/0wfh/+uibkWC
         hSHW1p4AoQS82PgP6gXp8Tq0FN+ezzjS9rrzXvvCqdv0INZkid7p2X3A4iKND19XC6VH
         qQBSxp3kA0i6HVA7WlWhsN8ecJ5h/G9k+7WgvIndzqnR36gler+H9FwJ2SUekC3YH3FF
         oGx7GLq11eGrqZ+2NCtOHGfP8TfgFv+qPKnI/7GJKEA6f5DtEvEg4kfVjWgcS31A7W8i
         mnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbcyUD14O34qORQweJ7OM0zfYmKvTkKcQqefmr2UkfI=;
        b=tPc1A6I/3YYNVlR0GM16xxZXCYGStdlfOIGcVPBKBDlLycZhzBgaPb95b9/jvAQIiI
         PyNPIjEYgziruTp88tSCvCA6dyGTjU0AsOlk/ajuitXPlq7vka6fw8IUFlcnoYUojgbE
         ScqXh2BZONz70sc37VVwPm5lM75kjmnU7WqycZ1Xkh0SsHqqq2CAE47+J+dCJjwLI31G
         IT3c8EKNrlDz2DgFBHdkvATMDbuhf92pST/pvdfe6bv9kZecVJYiI2dw5H5ioc0fEDhI
         vNE6Y62kdkT85/ghv5wdfFPaLxvR4aa0Y2J/tm2MfApgYo3s+x0NLWsvn+vO8uH2wncg
         7SJw==
X-Gm-Message-State: AOAM530S2YnfIWN8892nh9KIGtjtW4MBQPZ/zhxF/7Hgl+VLi5zHMVl2
        99Q7EkXLt54+t3YR71H9AuMyzGcYqe8sBZjQCYfwuQ==
X-Google-Smtp-Source: ABdhPJzuFinlenRa8Bx5uePYypLWzX7wWoUwM8r8lQOjW5+vTNLUDGXOSqq2AKEBjVDLyJoEuP2UPRdRU9h84Bnhw4U=
X-Received: by 2002:a9d:f44:: with SMTP id 62mr15154590ott.17.1605020039230;
 Tue, 10 Nov 2020 06:53:59 -0800 (PST)
MIME-Version: 1.0
References: <20201110135320.3309507-1-elver@google.com> <CACT4Y+Y_QarAf_cCNPgRZiSEKty0eSusA1ZMuY61LoGP1RaVtg@mail.gmail.com>
In-Reply-To: <CACT4Y+Y_QarAf_cCNPgRZiSEKty0eSusA1ZMuY61LoGP1RaVtg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 10 Nov 2020 15:53:47 +0100
Message-ID: <CANpmjNNTDznf3hWFw5tD1+vGoN-p1VrR8BrQvSZqtVtUmFPF3A@mail.gmail.com>
Subject: Re: [PATCH] kfence: Avoid stalling work queue task without allocations
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 at 15:25, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, Nov 10, 2020 at 2:53 PM Marco Elver <elver@google.com> wrote:
> > To toggle the allocation gates, we set up a delayed work that calls
> > toggle_allocation_gate(). Here we use wait_event() to await an
> > allocation and subsequently disable the static branch again. However, if
> > the kernel has stopped doing allocations entirely, we'd wait
> > indefinitely, and stall the worker task. This may also result in the
> > appropriate warnings if CONFIG_DETECT_HUNG_TASK=y.
> >
> > Therefore, introduce a 1 second timeout and use wait_event_timeout(). If
> > the timeout is reached, the static branch is disabled and a new delayed
> > work is scheduled to try setting up an allocation at a later time.
> >
> > Note that, this scenario is very unlikely during normal workloads once
> > the kernel has booted and user space tasks are running. It can, however,
> > happen during early boot after KFENCE has been enabled, when e.g.
> > running tests that do not result in any allocations.
> >
> > Link: https://lkml.kernel.org/r/CADYN=9J0DQhizAGB0-jz4HOBBh+05kMBXb4c0cXMS7Qi5NAJiw@mail.gmail.com
> > Reported-by: Anders Roxell <anders.roxell@linaro.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> >  mm/kfence/core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index 9358f42a9a9e..933b197b8634 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -592,7 +592,11 @@ static void toggle_allocation_gate(struct work_struct *work)
> >         /* Enable static key, and await allocation to happen. */
> >         atomic_set(&allocation_gate, 0);
> >         static_branch_enable(&kfence_allocation_key);
> > -       wait_event(allocation_wait, atomic_read(&allocation_gate) != 0);
> > +       /*
> > +        * Await an allocation. Timeout after 1 second, in case the kernel stops
> > +        * doing allocations, to avoid stalling this worker task for too long.
> > +        */
> > +       wait_event_timeout(allocation_wait, atomic_read(&allocation_gate) != 0, HZ);
>
> I wonder what happens if we get an allocation right when the timeout fires.
> Consider, another task already went to the slow path and is about to
> wake this task. This task wakes on timeout and subsequently enables
> static branch again. Now we can have 2 tasks on the slow path that
> both will wake this task. How will it be handled? Can it lead to some
> warnings or something?

wake_up() does not require tasks to be in the wait queue, nor is there
any requirement that it's exclusive (it takes the appropriate locks
unlike wake_up_locked()). One of the wake_up() calls will wake the
task, and the other is a noop. So this will work just fine.

Thanks,
-- Marco
