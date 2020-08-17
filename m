Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41C12479D7
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 00:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729655AbgHQWEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 18:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729493AbgHQWEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:04:06 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1676C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 15:04:05 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r13so11470304iln.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 15:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rsk5Ufj3tfIrfJ6olRq6fz/kGxDaBkxSgkFEQIO90T0=;
        b=WuXgw7h5Tk/E8vBdglUWikqi5bOy/Fv7Dz5TpYV61NOH5v0fYibnTBhld7LUAQD9+f
         V885kObZX10TGAufYJ4zdF6DfQ+Q0bYtM9jKwntIDFC5/1SzDgmpkQDkIYWUDnfY+SmI
         WfHyMjkDaoJjWt16UnDCUpTHm1vWxfxa6BNV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rsk5Ufj3tfIrfJ6olRq6fz/kGxDaBkxSgkFEQIO90T0=;
        b=mai45QXe18RbItU/ngkKz5ds3k9FBw16TMVQGFj/bvJszvv7TOjBDgH7gxa7h04jfy
         xx0Gpqivum1tlrqxyPChC2oqXKjzSr7x2d8Pt44GKI2BatPwpnS4t8GEXDjcajCaqotZ
         RYkk7++Y6hAqyNBdx8rtLlTLMHy53erTagzQBBFtlv8RRmyYkWuNMC8flyJ3B+Eq+uXF
         Pqiad8qU+xnr+rVmIiQqgzwnG9PtuvZdUOa/ooN5qFQvV11o/KCpFz8ZpKo3aFlJ4pg3
         B2oQRop3bEuWLPRUGHcew58qLggIaOPS3rpLofNZJ1uYtshUKZ3OeVl/eJ0djMCctNVJ
         UAZA==
X-Gm-Message-State: AOAM5322iC7S4Vyveoom6xWNAUDeQ33ftZKTUGsF3HWtN9fMYYQgIjYr
        7uPdk+tjG1/RvOd7vRjpeO65dL2GXCvZvd5M2/VC6w==
X-Google-Smtp-Source: ABdhPJwVqUdh5f3MtVp+PN/4FBPFUThmsxhqFPPDpKDQbD+YoOrCuEY86js8DzeXsUKLUQLuBrDjvEdRu9nj3su3Vxc=
X-Received: by 2002:a92:340d:: with SMTP id b13mr16328101ila.78.1597701845210;
 Mon, 17 Aug 2020 15:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200814064557.17365-1-qiang.zhang@windriver.com> <20200814185124.GA2113@pc636>
In-Reply-To: <20200814185124.GA2113@pc636>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Mon, 17 Aug 2020 18:03:54 -0400
Message-ID: <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     qiang.zhang@windriver.com, "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 2:51 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> > From: Zqiang <qiang.zhang@windriver.com>
> >
> > Due to cpu hotplug. some cpu may be offline after call "kfree_call_rcu"
> > func, if the shrinker is triggered at this time, we should drain each
> > possible cpu "krcp".
> >
> > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > ---
> >  kernel/rcu/tree.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 8ce77d9ac716..619ccbb3fe4b 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3443,7 +3443,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> >       unsigned long count = 0;
> >
> >       /* Snapshot count of all CPUs */
> > -     for_each_online_cpu(cpu) {
> > +     for_each_possible_cpu(cpu) {
> >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >
> >               count += READ_ONCE(krcp->count);
> > @@ -3458,7 +3458,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> >       int cpu, freed = 0;
> >       unsigned long flags;
> >
> > -     for_each_online_cpu(cpu) {
> > +     for_each_possible_cpu(cpu) {
> >               int count;
> >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >
> > @@ -3491,7 +3491,7 @@ void __init kfree_rcu_scheduler_running(void)
> >       int cpu;
> >       unsigned long flags;
> >
> > -     for_each_online_cpu(cpu) {
> > +     for_each_possible_cpu(cpu) {
> >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> >
> >               raw_spin_lock_irqsave(&krcp->lock, flags);
> >
> I agree that it can happen.
>
> Joel, what is your view?

Yes I also think it is possible. The patch LGTM. Another fix could be
to drain the caches in the CPU offline path and save the memory. But
then it will take hit during __get_free_page(). If CPU
offlining/online is not frequent, then it will save the lost memory.

I wonder how other per-cpu caches in the kernel work in such scenarios.

Thoughts?

thanks,

 - Joel
