Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94A72BB523
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732319AbgKTTWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732304AbgKTTWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:22:14 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C875C061A04
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:22:14 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id k26so11677801oiw.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x3bHHSoIiWnpt6sSCrh+oplbMynkFaA5raUA9UFenU8=;
        b=UoSVrsHFC/6ajfj53sIgq9KZJKGyJRjJagX2Jw9X+kmRK3eYNEjIDWo3EC7ORKCCpt
         hk/fUm411A5vkCbbI2r5PPlNm+uAaBCXyw5DDpdTbArnuiKB8R5jPukjeHq0yHn7JPuS
         FsYdW1mnUJGNGP9LYa6xm3+eTfwy/7XO2bHCZG4KcwKl84YjZ4USlMDjxaWiH1tG3yVm
         trknR40qepg10Ly4PsYPcJVI7J8g0G1SfqFziv1yGiS5O2RGR5vyrkrpXuBU5Qrs/2rq
         zFAen6YmbgB/hglU1e+oKw4WsXGUpwniG6CFV3YewJ7i2+mdR2ftYdEThiGPdxxaeKev
         2IKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x3bHHSoIiWnpt6sSCrh+oplbMynkFaA5raUA9UFenU8=;
        b=KpPlHn3aPs7/maUXdq1CFLbzQQWds/X0SbC+iXF0rELgbH6ZjSh71jSqIU9ULFEkb5
         FgmDaG+hSEeqtnOy85ZhGvgyiIdGkFLMv+NCd94hTiv7QxLnhS82/xEjZwd7HzC+x20n
         pKWhem3PcDfW0v1/EtSO9Q3xno6AfZe+s7+J3ubrSAu3asSVTE6MBrglaMa/gz+Cui+g
         hiBZEZ39wjyB79u8n+Bcj6+1nF/HOyyte12HuuPJ8NwGLG1lR1KfPR2ptCJ8051E2vWG
         VyIkq8DNqEa/EWz7Gmgd5DB2aqgjgU02qjnES9L5M74JKy+rDmpfyP05XZ4yp7k870ad
         usCw==
X-Gm-Message-State: AOAM531ftT0wh0lpCJpBHXMoGEUJ6Po77TtwQ6z2Q+jvlgMqrpgrJfCt
        qOwIKovHmC7PCaiB6uqyGRaByLybePrYcgOmXbZnPQ==
X-Google-Smtp-Source: ABdhPJxOU8HRyWfOhXUizg1VIov+ux7MpOo8HRr290PtSWN/SNAM+kBbp9E9fBX8fCWm0czXOt58ykdlbb+3hS00UcU=
X-Received: by 2002:a54:4681:: with SMTP id k1mr7597024oic.121.1605900133550;
 Fri, 20 Nov 2020 11:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20201118225621.GA1770130@elver.google.com> <20201118233841.GS1437@paulmck-ThinkPad-P72>
 <20201119125357.GA2084963@elver.google.com> <20201119151409.GU1437@paulmck-ThinkPad-P72>
 <20201119170259.GA2134472@elver.google.com> <20201119184854.GY1437@paulmck-ThinkPad-P72>
 <20201119193819.GA2601289@elver.google.com> <20201119213512.GB1437@paulmck-ThinkPad-P72>
 <20201120141928.GB3120165@elver.google.com> <20201120102613.3d18b90e@gandalf.local.home>
 <20201120181737.GA3301774@elver.google.com> <20201120141639.3896a3c8@gandalf.local.home>
In-Reply-To: <20201120141639.3896a3c8@gandalf.local.home>
From:   Marco Elver <elver@google.com>
Date:   Fri, 20 Nov 2020 20:22:01 +0100
Message-ID: <CANpmjNN+smYsdcJDDHNCT9aD_WULV3q6UmVRAutKPjzGVi_yfQ@mail.gmail.com>
Subject: Re: linux-next: stall warnings and deadlock on Arm64 (was: [PATCH]
 kfence: Avoid stalling...)
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>, rcu@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 at 20:16, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 20 Nov 2020 19:17:37 +0100
> Marco Elver <elver@google.com> wrote:
>
> > > > +++ b/kernel/rcu/Makefile
> > > > @@ -3,6 +3,13 @@
> > > >  # and is generally not a function of system call inputs.
> > > >  KCOV_INSTRUMENT := n
> > > >
> > > > +ifdef CONFIG_FUNCTION_TRACER
> > > > +CFLAGS_REMOVE_update.o = $(CC_FLAGS_FTRACE)
> > > > +CFLAGS_REMOVE_sync.o = $(CC_FLAGS_FTRACE)
> > > > +CFLAGS_REMOVE_srcutree.o = $(CC_FLAGS_FTRACE)
> > > > +CFLAGS_REMOVE_tree.o = $(CC_FLAGS_FTRACE)
> > > > +endif
> > > > +
> > >
> > > Can you narrow it down further? That is, do you really need all of the
> > > above to stop the stalls?
> >
> > I tried to reduce it to 1 or combinations of 2 files only, but that
> > didn't work.
>
> I'm curious if this would help at all?
>
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 2a52f42f64b6..d020ecefd151 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1094,7 +1094,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
>   * if the current CPU is not in its idle loop or is in an interrupt or
>   * NMI handler, return true.
>   */
> -bool rcu_is_watching(void)
> +notrace bool rcu_is_watching(void)
>  {
>         bool ret;
>
> Although I don't see it in the recursion list.

It seems a patch to that effect is already in -next ("rcu,ftrace: Fix
ftrace recursion"), and my experiments so far have all been with it.

Thanks,
-- Marco
