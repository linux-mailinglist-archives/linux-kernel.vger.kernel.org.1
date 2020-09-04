Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5821D25E341
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 23:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgIDVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 17:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgIDVVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 17:21:03 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00587C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 14:21:02 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id ay8so7382966edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d/bbf2Btlz4O8O7mwAo6eW49nsY6yI+2OlbwP4d2f1k=;
        b=s7F2RaTjJUzNuzYVM/OOWKjs/bBR734diSeL5TizFjBzV+Jjmt6y3Crw3MWPBkyBqd
         XUwG5Xtln2yLXufHduRVqMS3WW4PcMcKI7u7qMKujF+yVipwbXAEUCIDKRRVnlwWaWjR
         QmZXWJj2BL37kkqol1X/umWXOQuDKGtAOPUvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d/bbf2Btlz4O8O7mwAo6eW49nsY6yI+2OlbwP4d2f1k=;
        b=gg9ofa7Q8qvA56mmkAKVUO+1gW/d3O8FvvbbdXuJ6l5iE6k0XcdbUyph+ZxjzflAN3
         8rXnrApZaOXIrEaf2xdp+TdmsYwrHNHNpyQHMVsYLbFnAUsL2i8kQWze804I3CINRbGy
         R8oCOxnunqXsnMFvgNiqvHlh8Re1WHZgHW8caGnuYsw8EYhME5CFSOlS58ZatLL5UJ4U
         scQNd3eFhnY1afK/hRZUuFtHKd57tR0cpNAl056fkWWU845/rQivuurtt7RhpSKcMmYd
         dDXpFVCdGIA+DUxYGONr7YYaK1uo11ynGEorGtVk2MMYdCRYlXl7Hwn/XSPVxjZaGwSo
         kmNg==
X-Gm-Message-State: AOAM531dCg86qqhoA2dAQmlqUeoIwnJTa76kUxYRszw1OA3SqYHLAgVz
        AqXnXgj7KoD9lcH1eP2U//0xhCuFDSaEdXaf6Gc7bw==
X-Google-Smtp-Source: ABdhPJz3MVW+ImiihsCu1nXqsWPXiyjxjt9c0fteSDxJXpiLt0CzU9YiT2w63Ulx0de/K6Ucmx8QjnnsQ9l69toGduE=
X-Received: by 2002:a05:6402:12d1:: with SMTP id k17mr10489575edx.323.1599254461608;
 Fri, 04 Sep 2020 14:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <1598856077-58603-1-git-send-email-chao@eero.com>
 <20200904175007.GG29330@paulmck-ThinkPad-P72> <CAOr4Z-uwhX3LY=2x84da_uqAnX3dgpsgGSztQJLE6YEduCrR0w@mail.gmail.com>
 <20200904203718.GO29330@paulmck-ThinkPad-P72>
In-Reply-To: <20200904203718.GO29330@paulmck-ThinkPad-P72>
From:   Chao Zhou <chao@eero.com>
Date:   Fri, 4 Sep 2020 14:20:50 -0700
Message-ID: <CAOr4Z-u6yvcJZojrfMt_eeBxUfY8H7ede1rQRKi6PtPkKK9DxQ@mail.gmail.com>
Subject: Re: [PATCH] rcu: allow multiple stalls before panic
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Paul, sounds good!

Much appreciated your guidance.

Chao

eero inc.

660 3rd St, 4th Floor

San Francisco, CA 94107



On Fri, Sep 4, 2020 at 1:37 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Fri, Sep 04, 2020 at 12:40:29PM -0700, Chao Zhou wrote:
> > Thanks Paul. Appreciated it.
> >
> > Initial intent was to give users a way to make their system more
> > tolerable, but prudent enough to recover if suspicious behavior
> > reaches a watermark. If a system experiences multiple stalls in one
> > lifetime, no matter how healthy it looks or whether the stalls are
> > from different sources, we still want it to dramatically recover.
> > Please share your guidance?
>
> I have no guidance in this case.  I was just wanting to verify that the
> patch was in fact doing what you want it to.  And it sounds like it does,
> so good!
>
> I have queued this for testing and further review.  If all goes well,
> I would submit it upstream for the v5.11 merge window, that is, not the
> upcoming merge window, but the one after that.
>
>                                                         Thanx, Paul
>
> > eero inc.
> >
> > 660 3rd St, 4th Floor
> >
> > San Francisco, CA 94107
> >
> >
> >
> > On Fri, Sep 4, 2020 at 11:05 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Sun, Aug 30, 2020 at 11:41:17PM -0700, chao wrote:
> > > > Some stalls are transient and system can fully recover.
> > > > Allow users to configure the number of stalls experienced
> > > > to trigger kernel Panic.
> > > >
> > > > Signed-off-by: chao <chao@eero.com>
> > >
> > > Hearing no objections, I have queued this with wordsmithing as shown
> > > below.  Please let me know if I messed something up.
> > >
> > > One question, though.  It looks like setting this to (say) 5 would panic
> > > after the fifth RCU CPU stall warning message, regardless whether all
> > > five were reporting the same RCU CPU stall event or whether they instead
> > > were five widely separated transient RCU CPU stall events, where the
> > > system fully recovered from each event.  Is this the intent?
> > >
> > >                                                         Thanx, Paul
> > >
> > > ------------------------------------------------------------------------
> > >
> > > commit e710c928fb52d8e56bc6173515805301da6aa22b
> > > Author: chao <chao@eero.com>
> > > Date:   Sun Aug 30 23:41:17 2020 -0700
> > >
> > >     rcu: Panic after fixed number of stalls
> > >
> > >     Some stalls are transient, so that system fully recovers.  This commit
> > >     therefore allows users to configure the number of stalls that must happen
> > >     in order to trigger kernel panic.
> > >
> > >     Signed-off-by: chao <chao@eero.com>
> > >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > >
> > > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > > index 500def6..fc2dd3f 100644
> > > --- a/include/linux/kernel.h
> > > +++ b/include/linux/kernel.h
> > > @@ -536,6 +536,7 @@ extern int panic_on_warn;
> > >  extern unsigned long panic_on_taint;
> > >  extern bool panic_on_taint_nousertaint;
> > >  extern int sysctl_panic_on_rcu_stall;
> > > +extern int sysctl_max_rcu_stall_to_panic;
> > >  extern int sysctl_panic_on_stackoverflow;
> > >
> > >  extern bool crash_kexec_post_notifiers;
> > > diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> > > index 0fde39b..228c55f 100644
> > > --- a/kernel/rcu/tree_stall.h
> > > +++ b/kernel/rcu/tree_stall.h
> > > @@ -13,6 +13,7 @@
> > >
> > >  /* panic() on RCU Stall sysctl. */
> > >  int sysctl_panic_on_rcu_stall __read_mostly;
> > > +int sysctl_max_rcu_stall_to_panic __read_mostly;
> > >
> > >  #ifdef CONFIG_PROVE_RCU
> > >  #define RCU_STALL_DELAY_DELTA          (5 * HZ)
> > > @@ -106,6 +107,11 @@ early_initcall(check_cpu_stall_init);
> > >  /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
> > >  static void panic_on_rcu_stall(void)
> > >  {
> > > +       static int cpu_stall;
> > > +
> > > +       if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
> > > +               return;
> > > +
> > >         if (sysctl_panic_on_rcu_stall)
> > >                 panic("RCU Stall\n");
> > >  }
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index 287862f..1bca490 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -2651,6 +2651,17 @@ static struct ctl_table kern_table[] = {
> > >                 .extra2         = SYSCTL_ONE,
> > >         },
> > >  #endif
> > > +#if defined(CONFIG_TREE_RCU)
> > > +       {
> > > +               .procname       = "max_rcu_stall_to_panic",
> > > +               .data           = &sysctl_max_rcu_stall_to_panic,
> > > +               .maxlen         = sizeof(sysctl_max_rcu_stall_to_panic),
> > > +               .mode           = 0644,
> > > +               .proc_handler   = proc_dointvec_minmax,
> > > +               .extra1         = SYSCTL_ONE,
> > > +               .extra2         = SYSCTL_INT_MAX,
> > > +       },
> > > +#endif
> > >  #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
> > >         {
> > >                 .procname       = "stack_erasing",
