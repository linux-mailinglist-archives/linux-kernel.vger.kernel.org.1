Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED04303296
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 04:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbhAYJfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 04:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbhAYJ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 04:26:46 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13740C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:26:06 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id v24so16687828lfr.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 01:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnHeIwqxBtkc8QdAEDyiefJYi3lqnllVIwzZtHS/B8g=;
        b=w6k6hAuCgmKRlMvfak3gAwLBF1ghJ7OJMdzv94wIXyk+McQu600jCNJRMlFKJOzu1/
         4bb0EeexNpiwLgylwSbU/iJ5jQcD48zepuuZDnemJ14pqne0VjOjbLxbQBid1jMv278y
         xoCPOl9K182hLiqElQuy9wwMbNVp0j4sGkAjr2YkXV/k/4KIHcGcQf4ZNWcSM+XzTF3w
         m76e0qrv18wYDNZ43IPZy2SF38TA3E+8MFv9p02+qJnP+EBFHtk40wIbwkKqgJX5CzAx
         /dPSZlMgiQ1Efr06sfI7fMGhIgeVdIQxn1v/CA2hIawa9tsYc9rahiH4uRHkQGBB9d4X
         f3xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnHeIwqxBtkc8QdAEDyiefJYi3lqnllVIwzZtHS/B8g=;
        b=G8BXiLJ12OgsOJahCoRHI8BYr5tg1Neav1GO/OP0CEcozo7YHDsFnbkxuob0XQ16hu
         HfRuFtfH7N3FJ4U9PM4eqif6C80i2DoFepwScE4q/q1/qXIsSx773cRnZXtCsC+a25Ox
         LtFKLlyRcXoGCCNgBZ6MC4IPPfqxuKRkIVKfpsAnQojICzVDNHM4YqRyx8XMfDsO3uKp
         xCig+yPTGxKHTFFiAWFbinbHCnzOaFxx7vpMMk79tQ5aJc5pHQBHSsSpIvACO+sg4Jl+
         2boqUe7tXQgYqlJWACyJDTbuv7Zj9yQe0R4vox+JkX/5Jxib7Prnp7sveFggysCF9j5w
         ctEw==
X-Gm-Message-State: AOAM532Y0ZOdWm/HUOPDbUX531wD54yR9jU8RT/YztMg7MuuQtCtut4p
        hOKVigLBxza665rrlv4bbOMYAdlghfdRfM3V8eWBCw==
X-Google-Smtp-Source: ABdhPJzll3PPyYXYd0I8wnd4RuNtKdjP0BBHZkPGmyH//U/sZs25PD8QjdjNEfYnZfMRvPwpIsmPh/PHTOG+1Qv9j2I=
X-Received: by 2002:a19:83d3:: with SMTP id f202mr665248lfd.277.1611566763364;
 Mon, 25 Jan 2021 01:26:03 -0800 (PST)
MIME-Version: 1.0
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr>
 <20201027091936.GS32041@suse.de> <alpine.DEB.2.22.394.2101242134530.2788@hadrien>
 <20210125091238.GE20777@suse.de> <alpine.DEB.2.22.394.2101251017480.5053@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2101251017480.5053@hadrien>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Jan 2021 10:25:52 +0100
Message-ID: <CAKfTPtDePZam9q7pR8-uSOif75d3EDmcZsawc2_Vx3RfDdLzOw@mail.gmail.com>
Subject: Re: [PATCH v2] sched/fair: check for idle core
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 10:20, Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>
> On Mon, 25 Jan 2021, Mel Gorman wrote:
>
> > On Sun, Jan 24, 2021 at 09:38:14PM +0100, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 27 Oct 2020, Mel Gorman wrote:
> > >
> > > > On Thu, Oct 22, 2020 at 03:15:50PM +0200, Julia Lawall wrote:
> > > > > Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in wakeup path")
> > > > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > > > > Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>
> > > > >
> > > >
> > > > While not a universal win, it was mostly a win or neutral. In few cases
> > > > where there was a problem, one benchmark I'm a bit suspicious of generally
> > > > as occasionally it generates bad results for unknown and unpredictable
> > > > reasons. In another, it was very machine specific and the differences
> > > > were small in absolte time rather than relative time. Other tests on the
> > > > same machine were fine so overall;
> > > >
> > > > Acked-by: Mel Gorman <mgorman@suse.de>
> > >
> > > Recently, we have been testing the phoronix multicore benchmarks.  On v5.9
> > > with this patch, the preparation time of phoronix slows down, from ~23
> > > seconds to ~28 seconds.  In v5.11-rc4, we see 29 seconds.  It's not yet
> > > clear what causes the problem.  But perhaps the patch should be removed
> > > from v5.11, until the problem is understood.
> > >
> > > commit d8fcb81f1acf651a0e50eacecca43d0524984f87
> > >
> >
> > I'm not 100% convinved given that it was a mix of wins and losses. In
> > the wakup path in general, universal wins almost never happen. It's not
> > 100% clear from your mail what happens during the preparation patch. If
> > it included time to download the benchmarks and install then it would be
> > inherently variable due to network time (if download) or cache hotness
> > (if installing/compiling). While preparation time can be interesting --
> > for example, if preparation involves reading a lot of files from disk,
> > it's not universally interesting when it's not the critical phase of a
> > benchmark.
>
> The benchmark is completely downloaded prior to the runs.  There seems to
> be some perturbation to the activation of containerd.  Normally it is
> even:  *   *   *   *

Does it impact the benchmark results too or only the preparation prior
to running the benchmark ?

>
> and with the patch it becomes more like: *     **     **
>
> That is every other one is on time, and every other one is late.
>
> But I don't know why this happens.
>
> julia
>
> >
> > I think it would be better to wait until the problem is fully understood
> > to see if it's a timing artifact (e.g. a race between when prev_cpu is
> > observed to be idle and when it is busy).

I agree that a better understanding of what is happening is necessary
before any changes

> >
> > --
> > Mel Gorman
> > SUSE Labs
> >
