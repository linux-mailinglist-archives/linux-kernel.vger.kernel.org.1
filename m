Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721EC1E6D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 23:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436470AbgE1VCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 17:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407418AbgE1VCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:02:37 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590A0C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:02:37 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e125so17425096lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 14:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKXkd/2Goa9jMS89Q94W0ujkvkQZZc4XoblLXbs8npU=;
        b=VfT9vvveDYPm9Ryth8faOYkMaXrBtezGHU2cIz3grKvOlKpU8UUiJtMaij5vwXdW6c
         MdF+q4O4dv+Jcb8D5cFvQ1NJMY+og5fVguE2A9OfoPMqsVw4L0Ys54+bGGMFewoVziYQ
         I19+A4AjOq2Syf5MqR79HZ1F/ONCu86nWMh23r2Mt/ZHnchlc/NfKuw3KtyCBOoeEA2U
         I2ooyEe7iOvV59F5vNcHsuMdRmiaF40OXrPlQxhj1Kx2iO7yklM43zS+UdLMIcuawhef
         6XF7vJbPNkWQmaMi/0UuVksVuaFlAvo7OKkZaNJdBRLauXunE5A0gi7f+t16KjS1/7uU
         eQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKXkd/2Goa9jMS89Q94W0ujkvkQZZc4XoblLXbs8npU=;
        b=ru9eC1OcKtADHyu07JoEMLg5FDrvfGQYx8gv0U8ConKJ1NP4GA5oMbq59432NL4xUp
         RMTjbopQovYxjmXWqpc7Lyc/FTn7eWaV+RXZBU5pOmanELf3ZevXSVL7mkvrKODK153c
         8QYGT/TE1/isPRW0f8R7G7Y7mvsCjA4EZ4yy89DECOwcubNNpjLonc/93wRk29k+uXxt
         xEGrku7skt9n0npgIpx4FuCxNDlFPxLBo8HV7b9fMjJyPeXL6JTyTLYFARPcIjUF4mUN
         v4QWlm4x//i/GOWg+oVIO2UmomO818RCtO+XQlhniZ7RB3AmPzDsyX8ydsSaV3XcvQfS
         sc2g==
X-Gm-Message-State: AOAM5304v7v4q3llm6GrNa44MkwiGaKUOYR101qx6DISTkaSrF1+2QtB
        3S+KHDN6KZEq0HPbOOmlFGVSkxGSmoC6zCZrik877Q==
X-Google-Smtp-Source: ABdhPJzsrob+TxrXT/0Qxvf0fgqGmcH4Xue4XBajqa+4Mv7HoQYtZH7bYZw06Z/fs+xonMgNz+UV+FKJ3O5OyaiTy2M=
X-Received: by 2002:a19:6cd:: with SMTP id 196mr2622048lfg.216.1590699755398;
 Thu, 28 May 2020 14:02:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200520143712.GA749486@chrisdown.name> <CALvZod7rSeAKXKq_V0SggZWn4aL8pYWJiej4NdRd8MmuwUzPEw@mail.gmail.com>
 <20200528194831.GA2017@chrisdown.name> <20200528202944.GA76514@cmpxchg.org>
In-Reply-To: <20200528202944.GA76514@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 28 May 2020 14:02:24 -0700
Message-ID: <CALvZod62+Me-n_54W+GiJrXafwFOzd8nfvkLmOBM190sEGJF=g@mail.gmail.com>
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 1:30 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Thu, May 28, 2020 at 08:48:31PM +0100, Chris Down wrote:
> > Shakeel Butt writes:
> > > What was the initial reason to have different behavior in the first place?
> >
> > This differing behaviour is simply a mistake, it was never intended to be
> > this deviate from what happens elsewhere. To that extent this patch is as
> > much a bug fix as it is an improvement.
>
> Yes, it was an oversight.
>
> > > >  static void high_work_func(struct work_struct *work)
> > > > @@ -2378,16 +2384,20 @@ void mem_cgroup_handle_over_high(void)
> > > >  {
> > > >         unsigned long penalty_jiffies;
> > > >         unsigned long pflags;
> > > > +       unsigned long nr_reclaimed;
> > > >         unsigned int nr_pages = current->memcg_nr_pages_over_high;
> > >
> > > Is there any benefit to keep current->memcg_nr_pages_over_high after
> > > this change? Why not just use SWAP_CLUSTER_MAX?
>
> It's there for the same reason why try_to_free_pages() takes a reclaim
> argument in the first place: we want to make the thread allocating the
> most also do the most reclaim work. Consider a thread allocating THPs
> in a loop with another thread allocating regular pages.
>
> Remember that all callers loop. They could theoretically all just ask
> for SWAP_CLUSTER_MAX pages over and over again.
>
> The idea is to have fairness in most cases, and avoid allocation
> failure, premature OOM, and containment failure in the edge cases that
> are caused by the inherent raciness of page reclaim.
>

Thanks for the explanation.

> > I don't feel strongly either way, but current->memcg_nr_pages_over_high can
> > be very large for large allocations.
> >
> > That said, maybe we should just reclaim `max(SWAP_CLUSTER_MAX, current -
> > high)` for each loop? I agree that with this design it looks like perhaps we
> > don't need it any more.
> >
> > Johannes, what do you think?
>
> How about this:
>
> Reclaim memcg_nr_pages_over_high in the first iteration, then switch
> to SWAP_CLUSTER_MAX in the retries.
>
> This acknowledges that while the page allocator and memory.max reclaim
> every time an allocation is made, memory.high is currently batched and
> can have larger targets. We want the allocating thread to reclaim at
> least the batch size, but beyond that only what's necessary to prevent
> premature OOM or failing containment.
>
> Add a comment stating as much.
>
> Once we reclaim memory.high synchronously instead of batched, this
> exceptional handling is no longer needed and can be deleted again.
>
> Does that sound reasonable?

SGTM. It does not seem controversial to me to let the task do the work
to resolve the condition for which it is being throttled.
