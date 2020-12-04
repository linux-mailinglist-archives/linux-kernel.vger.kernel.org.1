Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F502CEEB5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgLDNSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgLDNST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:18:19 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F48C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 05:17:33 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s27so7578936lfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 05:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgYMArn7S4eAe6KIOy5zLeLGQU/k2A4+qSnIEryVFDA=;
        b=WX3rrUEh7571qNcIktMgb1K6LZGWbAebA/LuCyu5g6ymMVvKppH/Of5IsUS0W0+PUp
         QZdIegCUbTjLbuyoqiGn0k1TY2u+st6pnZAwAl4nBiSgFJYPeAGxfkPLvhQjfXzv3yB3
         W1MBB6hMrtdHuai0IhoEPquK1yrQdzEat20Tw64aXtfuBWzgRldlnfrgZ7rHyf/Oh+mG
         0GwxXFnVdhSJiCotmogChuMkIrX0sDUpgf0INQZQ+vA0QvBMQS6xaVaOp3mwkW4BM+DL
         6zO4eGdFF4OZXNS4x1x+ZE7B202/1HhU/23jbAqlOBDszhPO8b2ETv8oz8ojqtNEThWa
         pVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgYMArn7S4eAe6KIOy5zLeLGQU/k2A4+qSnIEryVFDA=;
        b=FuSN+vhCXV5iqWLsbVn8cZOHpf8Ik/T7AnQOURUW2vwT6y53tZpert0W6AMuVAtfTV
         BdN3qK47kpgqiXKNkdv3f/XEoD87DRJOxikxm2fLI63NncxgwkuePRI1NLpqT2jJ+iR5
         5wvZkrG4HbT3M0OGEZ1GIGbnfJebEZ6uGn4AYGgE0GbiuLJ+wUrFrf30ZIPS8mwYcniw
         fNJDuc0j2k4M17lR2mBUbSgBCwgF+QBzj8ioh0k88Zm4xnOuG0Wp0nWhgS+QxS4iYqRD
         M7kz9IBXbPMEhK9nDU7+6Dbr4DIT1rX4MviGYIdqzVt0088CIlMx0s5ZBAEF/xN+oXjP
         jtvg==
X-Gm-Message-State: AOAM530cug1ruBhM25eehdGVLty8ClYzM+zyLTEAKAKW9rwucIFmyqNS
        zNPTM1ng3jKpNAGDGcTdosomS2htcoCmLM3LU4GWIw==
X-Google-Smtp-Source: ABdhPJxGMayNJR4CwFAM5FOHqLXagwctqU+MtHQNAQ7HiBZdYwrHvsTMSYXuSm4sCrQcpNOQIwYeU9/omZRoBHHM66Q=
X-Received: by 2002:a19:cc91:: with SMTP id c139mr3563961lfg.31.1607087851964;
 Fri, 04 Dec 2020 05:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-7-mgorman@techsingularity.net> <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net> <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
 <20201204113030.GZ3371@techsingularity.net> <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
In-Reply-To: <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Dec 2020 14:17:20 +0100
Message-ID: <CAKfTPtBABBY1QSfFtbhBQ7+a8HOp2YfTyJaMVo07T5GU7sp_MA@mail.gmail.com>
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 at 14:13, Vincent Guittot <vincent.guittot@linaro.org> wrote:
>
> On Fri, 4 Dec 2020 at 12:30, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Fri, Dec 04, 2020 at 11:56:36AM +0100, Vincent Guittot wrote:
> > > > The intent was that the sibling might still be an idle candidate. In
> > > > the current draft of the series, I do not even clear this so that the
> > > > SMT sibling is considered as an idle candidate. The reasoning is that if
> > > > there are no idle cores then an SMT sibling of the target is as good an
> > > > idle CPU to select as any.
> > >
> > > Isn't the purpose of select_idle_smt ?
> > >
> >
> > Only in part.
> >
> > > select_idle_core() looks for an idle core and opportunistically saves
> > > an idle CPU candidate to skip select_idle_cpu. In this case this is
> > > useless loops for select_idle_core() because we are sure that the core
> > > is not idle
> > >
> >
> > If select_idle_core() finds an idle candidate other than the sibling,
> > it'll use it if there is no idle core -- it picks a busy sibling based
> > on a linear walk of the cpumask. Similarly, select_idle_cpu() is not
>
> My point is that it's a waste of time to loop the sibling cpus of
> target in select_idle_core because it will not help to find an idle
> core. The sibling  cpus will then be check either by select_idle_cpu
> of select_idle_smt

also, while looping the cpumask, the sibling cpus of not idle cpu are
removed and will not be check

>
> > guaranteed to scan the sibling first (ordering) or even reach the sibling
> > (throttling). select_idle_smt() is a last-ditch effort.
> >
> > --
> > Mel Gorman
> > SUSE Labs
