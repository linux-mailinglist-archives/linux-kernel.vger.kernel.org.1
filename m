Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0995B248E5E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 21:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgHRTAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:00:48 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B616EC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:00:48 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id g14so22352320iom.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6y7jaq85qVWyUjsIUSZ25WamPn+4eSTzE9M7XKfX/FM=;
        b=dH63OBwnuhjcOBJxjXMhjufxWX6ONCsuAceeqQIiqN6TqgJ/1YsyUbcxqd9l4JSzgE
         xRTl2ij4bbzVQyRQqhh+wjGCWwI1Lx2F29C6z+aO3wV/Fkv7nm5DVK1gG0CxyHSTy2tY
         c+/hxn4w/RvuxY6Vg6GSelXM7VK3NLF2xQ6sE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6y7jaq85qVWyUjsIUSZ25WamPn+4eSTzE9M7XKfX/FM=;
        b=Hw0HaZGFWxliAR7lfIkFQvBwH8lLPJGFHqzkXTS+ln6t+QcvpvclFtzgoYEhXyZTxR
         3tjXe4b6du1a7WcOftJdhmdOQikCeuTetHGCHro5OBBiQj5KwCgFSpVS3EsE0ESrs0hk
         u5bGgK9KDr5GziuDYRYBrdL1wVi/sopfXkVnbT93ONiFiQzvwyfRi8z6MhPIDzxB234z
         o6ypvsWVyIEpindQPJiKSWLhiUVr/ByWCHI5SDUVcLHU8RSbp9kPPJ6Z6Ef4C5Hdtutk
         GlHpslYZZUYkJU/ZzcbHU78lIZ0f6h0Ll8vRk/vV9SwEFN5plKvTE+PwQF3n8K8rFegt
         cfyQ==
X-Gm-Message-State: AOAM530hIA81ZBB3huEjOJ4l+Cayvbc5gEhMmuxXrxYuOdyBgv0BRIuY
        risydv+SAtNWCWFA4JSvwA80/wivYA3NAAIqUCFHug==
X-Google-Smtp-Source: ABdhPJy8MyeJce2Quxo1tyOawcOEzlS+kBjEMXHglIDsFc5FDaQjH6+UI3GatQx6TYGSywF57VSNfMNJvhH6aw4DIbQ=
X-Received: by 2002:a05:6602:2dc9:: with SMTP id l9mr17608751iow.154.1597777247683;
 Tue, 18 Aug 2020 12:00:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636> <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
In-Reply-To: <20200818171807.GI27891@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 18 Aug 2020 15:00:35 -0400
Message-ID: <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, qiang.zhang@windriver.com,
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

On Tue, Aug 18, 2020 at 1:18 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Aug 17, 2020 at 06:03:54PM -0400, Joel Fernandes wrote:
> > On Fri, Aug 14, 2020 at 2:51 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> > >
> > > > From: Zqiang <qiang.zhang@windriver.com>
> > > >
> > > > Due to cpu hotplug. some cpu may be offline after call "kfree_call_rcu"
> > > > func, if the shrinker is triggered at this time, we should drain each
> > > > possible cpu "krcp".
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > > > ---
> > > >  kernel/rcu/tree.c | 6 +++---
> > > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 8ce77d9ac716..619ccbb3fe4b 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3443,7 +3443,7 @@ kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
> > > >       unsigned long count = 0;
> > > >
> > > >       /* Snapshot count of all CPUs */
> > > > -     for_each_online_cpu(cpu) {
> > > > +     for_each_possible_cpu(cpu) {
> > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > >
> > > >               count += READ_ONCE(krcp->count);
> > > > @@ -3458,7 +3458,7 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
> > > >       int cpu, freed = 0;
> > > >       unsigned long flags;
> > > >
> > > > -     for_each_online_cpu(cpu) {
> > > > +     for_each_possible_cpu(cpu) {
> > > >               int count;
> > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > >
> > > > @@ -3491,7 +3491,7 @@ void __init kfree_rcu_scheduler_running(void)
> > > >       int cpu;
> > > >       unsigned long flags;
> > > >
> > > > -     for_each_online_cpu(cpu) {
> > > > +     for_each_possible_cpu(cpu) {
> > > >               struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
> > > >
> > > >               raw_spin_lock_irqsave(&krcp->lock, flags);
> > > >
> > > I agree that it can happen.
> > >
> > > Joel, what is your view?
> >
> > Yes I also think it is possible. The patch LGTM. Another fix could be
> > to drain the caches in the CPU offline path and save the memory. But
> > then it will take hit during __get_free_page(). If CPU
> > offlining/online is not frequent, then it will save the lost memory.
> >
> > I wonder how other per-cpu caches in the kernel work in such scenarios.
> >
> > Thoughts?
>
> Do I count this as an ack or a review?  If not, what precisely would
> you like the submitter to do differently?

Hi Paul,
The patch is correct and is definitely an improvement. I was thinking
about whether we should always do what the patch is doing when
offlining CPUs to save memory but now I feel that may not be that much
of a win to justify more complexity.

You can take it with my ack:

Acked-by: Joel Fernandes <joel@joelfernandes.org>

 thanks,

 - Joel
