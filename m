Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 906C62CEEAD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbgLDNOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:14:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgLDNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:14:07 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0676C061A52
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 05:13:20 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id r18so6588949ljc.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 05:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uVdyctXUUQJ5ntkH5m/RI9F4Gm2fAdJt93bRP44fix4=;
        b=PsUNyDg5aD3WMPZeyZHEqEQa341o53K1BYwHzWvsFAQkErAcHkCxTzvpMu2WUJ6ONH
         IfoGXjQMrvWFPg/3DfQ9zuUsQwBV5g50psZrMlqX/mgiJvmeWyG9ZM88pWu+DwTGd+G/
         0J1JLKl3a56Bdko8ZfSQb9htE4R/CylRSd84NWvUQ8nPcYxBpCsvM17yRAvGtTOqcYjl
         yFnQwuwSERA7yGPaAXbKrq8wg/Pc7erpl98Bqvg76KLq+ePebm+iaZYjYadlQZ2LPlaP
         LbcKnjiXxpXtZkHE7Ua7sblI35qOL6FY/sI6pfI2mWMEJMInXD45o83RJVP3+L/mTQFU
         vvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uVdyctXUUQJ5ntkH5m/RI9F4Gm2fAdJt93bRP44fix4=;
        b=o0bDmo/X/rm/p5idiUK4bDBH8wJY9XvKZLe59KDioq0PbnIl34Rc5uWN3mA58Dtign
         g+mhgu4uInmjB6SzVk03xFaYwTYVLzMvLayO6eHJRpsdnY38AOHwfnXvh2f6NLaGs/Hp
         asgMJulZcuK2HWw9RAZ1puY4CkDUCleF8HSBbHueGR4n79Wwq/+GOtUQCKVT4t4cajpP
         /tydVj/6PFMzhXBYLeeaKAQyLWHdTQY9+KJLo+bO3NMxHh2S+X1qzgo/pOH07DHYm87p
         Gws2VsSVrfft1wT9ujHQ7nbORqVGmuaNm7+yDYA5o1ybon+zmyZl8zXSAOgIm0I5jIoj
         v7+A==
X-Gm-Message-State: AOAM531Najwn/p/IlHhy7pGbXAhIHCwEEtGFcFcDllLPJTzussy4ld1U
        EhBgh6kwG8/nj27ll8KHL52MTXeIYx9aPjs8VB202zFtZm8Rcg==
X-Google-Smtp-Source: ABdhPJxg+tG2hln9539IxiqH/SJEWm7yNOEXCkgyZByesUqclmQ+OzZ/35J+fhXsb+XAcfSfXGcCe9TWvcgU8njrCeg=
X-Received: by 2002:a2e:918a:: with SMTP id f10mr3245338ljg.156.1607087599377;
 Fri, 04 Dec 2020 05:13:19 -0800 (PST)
MIME-Version: 1.0
References: <20201203141124.7391-1-mgorman@techsingularity.net>
 <20201203141124.7391-7-mgorman@techsingularity.net> <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net> <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
 <20201204113030.GZ3371@techsingularity.net>
In-Reply-To: <20201204113030.GZ3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Dec 2020 14:13:08 +0100
Message-ID: <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
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

On Fri, 4 Dec 2020 at 12:30, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Dec 04, 2020 at 11:56:36AM +0100, Vincent Guittot wrote:
> > > The intent was that the sibling might still be an idle candidate. In
> > > the current draft of the series, I do not even clear this so that the
> > > SMT sibling is considered as an idle candidate. The reasoning is that if
> > > there are no idle cores then an SMT sibling of the target is as good an
> > > idle CPU to select as any.
> >
> > Isn't the purpose of select_idle_smt ?
> >
>
> Only in part.
>
> > select_idle_core() looks for an idle core and opportunistically saves
> > an idle CPU candidate to skip select_idle_cpu. In this case this is
> > useless loops for select_idle_core() because we are sure that the core
> > is not idle
> >
>
> If select_idle_core() finds an idle candidate other than the sibling,
> it'll use it if there is no idle core -- it picks a busy sibling based
> on a linear walk of the cpumask. Similarly, select_idle_cpu() is not

My point is that it's a waste of time to loop the sibling cpus of
target in select_idle_core because it will not help to find an idle
core. The sibling  cpus will then be check either by select_idle_cpu
of select_idle_smt

> guaranteed to scan the sibling first (ordering) or even reach the sibling
> (throttling). select_idle_smt() is a last-ditch effort.
>
> --
> Mel Gorman
> SUSE Labs
