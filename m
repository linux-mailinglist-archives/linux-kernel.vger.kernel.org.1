Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FFB241EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 19:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbgHKREG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 13:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729046AbgHKREE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:04:04 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71281C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:04:04 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e11so10666918otk.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCeRiVh6vPaecDrIdWPljTkapUhpeRVTmR3kunsiO48=;
        b=rpYoSTAjwv042WPkWR7I2ZB1OvMlxvCpJvkeO0KXMjmrhffrXd2YA9eryzKSK29lUI
         KroJeWEJB6Zd+u9D1rYfoeb2xyw3xN9kTPb5f0w40sUkH+j0rIZW7AtgOdhOie/VuTUL
         SyWvEgRsTphX8aiKjqvsia+Drj7MbtvcynPYiETLJ3tAb2pm/Te8HhTykkOmcCR9rNWT
         qxrMroHFWWXsWwA405t9eI6amsm1U0qbIaytVeE7lxjbh2TuoS+2cesWNaaeqCE0SALa
         C62tGi6L4uAK2jPtFoYjMSH29ZRfu56/Tku0st9M218nGziuHkpoksEQGCMLdKlf6LNS
         /+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCeRiVh6vPaecDrIdWPljTkapUhpeRVTmR3kunsiO48=;
        b=tGdNXXJ8DvncYOsg5fPlSo6M7vQx14Oa0oCCS2J+hsIcg7ckk0wu5CRrLPGtaq6gZE
         AVvpJYjV5jHvToZ0pfAXdcFFIA2e3fySAQCWOc4vtqXk+DeLQ9lIvJ99G+CUQ2cGl10+
         abCGEUX/i8/zSkTbjHCI/fIAxou7vyoi2HWitZJtTmZnjeKOg778J3kOZIQrsBkOFWRv
         d9nckrVwB75n4PdNgxaxTvO7EWmUflDyfpcPDWbkzBKcs1+jr8XlUfI5FKo7/EBaIydk
         erdutyyMCGX76srtdQHNGIeDSrWj/Q6tasaeyWvVqwX+NePHkmNEoklXF5MpRzALc/SI
         I7yQ==
X-Gm-Message-State: AOAM5314DXr2I43fzjjTJ07j8Kq9IOIJs2tH3HqLt28C0LpyLyLtfgTZ
        ICN3xxZdSx7wxTJCr9XjECUfwS2XivIsSuJaFCfWVg==
X-Google-Smtp-Source: ABdhPJzYuugOtC+Wb+6fmfcYEMHjCY+iRT8x6dSkskSN93//Z9s8mZkfx5MLbKaeIlF41Q7bnAMdvn681hPBgO9aQd8=
X-Received: by 2002:a9d:450a:: with SMTP id w10mr5892233ote.327.1597165442676;
 Tue, 11 Aug 2020 10:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200810213257.438861-1-urielguajardojr@gmail.com> <20200810214328.GM3982@worktop.programming.kicks-ass.net>
In-Reply-To: <20200810214328.GM3982@worktop.programming.kicks-ass.net>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Tue, 11 Aug 2020 12:03:51 -0500
Message-ID: <CAG30EecPEzM7hkPxagCD8GQb=JUZhatyW50KAoaHjrHoj4BiFw@mail.gmail.com>
Subject: Re: [PATCH] kunit: added lockdep support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 4:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 10, 2020 at 09:32:57PM +0000, Uriel Guajardo wrote:
> > +static inline void kunit_check_locking_bugs(struct kunit *test,
> > +                                         unsigned long saved_preempt_count)
> > +{
> > +     preempt_count_set(saved_preempt_count);
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +     if (softirq_count())
> > +             current->softirqs_enabled = 0;
> > +     else
> > +             current->softirqs_enabled = 1;
> > +#endif
> > +#if IS_ENABLED(CONFIG_LOCKDEP)
> > +     local_irq_disable();
> > +     if (!debug_locks) {
> > +             kunit_set_failure(test);
> > +             lockdep_reset();
> > +     }
> > +     local_irq_enable();
> > +#endif
> > +}
>
> Unless you can guarantee this runs before SMP brinup, that
> lockdep_reset() is terminally broken.

Good point. KUnit is initialized after SMP is set up, and KUnit can
also be built as a module, so it's not a guarantee that we can make.
Is there any other way to turn lockdep back on after we detect a
failure? It would be ideal if lockdep could still run in the next test
case after a failure in a previous one.

I suppose we could only display the first failure that occurs, similar
to how lockdep does it. But it could also be useful to developers if
they saw failures in subsequent test cases, with the knowledge that
those failures may be unreliable.
