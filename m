Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC93B2CF0EC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgLDPoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:44:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgLDPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:44:08 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96F7C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 07:43:22 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id o25so6587413oie.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H8Wxg7BjSla33ZJgJ/hXpUqDeZ12y5ojbtdcdfbU0ZU=;
        b=FR+YiOMm83Dae4nm2208tDt2NFi/tGIzV2MR1lhUpCMckqgnJ+D5UVbiq/r6eub2TT
         a8+COkF6homTMy7vcApzJtBSmgK4e5qpEGZcEUIMoOR1psJ8qcQg1GzWzYEqw86cW9yb
         /3jiiIzK96zG1Qt5RUSqVuycM/KJn9lBn1jrjXdZmJphF4rQHx7ItpaEWQ7o5LO/wyUa
         3pZlYnwpIzrno8jN95t4jbsYsmgnNGWnhLfsepontyDzY7046xNfzdSa08ZyjXq60Z29
         SQBCuXMEGTqsjlrqw56C6ZxiV7GJoC68E6CJOq16NIaEpZ1sNSAi/TsD5xaoWIz0OaHG
         osdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H8Wxg7BjSla33ZJgJ/hXpUqDeZ12y5ojbtdcdfbU0ZU=;
        b=VEPEJThzP7kmvOPqVLoQBXZfLHq1qk1V40NmRe737cZAIGUyRDNGdcpTGNO9adberN
         EexJ7OUID2/89MEY/o9xG5XDlTOGNdEl3sxRzHTlZHUvdDVNQMSxqkKtkY/XqgockYnC
         qZ3zGO/S96jLkYTFr8vWvKHlwIe3h7C9fQmLn50SkZoG7lRbGTVwoN5ZCmZ6QoNR1uGh
         eJ6dMc8F1xudNTNPcBQViNjBqaxG04vSE5UVTBjqxOJ4FZdNkzI9FXb7THvBe2KxEmhO
         Ml5Jd2AlWz2PgZQ5q+KgneARAtR0AuK7bw3aeKRve2EkFjVXhC50GtBgFbqh0wIfVUis
         f6GA==
X-Gm-Message-State: AOAM533hyZeVnZAfEQE/ZqBqNmzBkF6RcWxHG/8E3VYxfDBDh/xM7tpF
        yUndFt3mcDMSX50mZMjHhVyyqBB81lVS0Ba37mQxPA==
X-Google-Smtp-Source: ABdhPJzD9wEYp9732nKxKCLK324q7XPWwU6IQtV96l2BMQGFynfkIv0rPWZzoXiENWxF7mA1FgtO3gAFnxPsRJDquNE=
X-Received: by 2002:aca:a8d4:: with SMTP id r203mr3628839oie.3.1607096598862;
 Fri, 04 Dec 2020 07:43:18 -0800 (PST)
MIME-Version: 1.0
References: <CAKfTPtDm880Rs7D1xUCQd_X9okqzhgrmCJVhwg90Rt3krq9ytg@mail.gmail.com>
 <20201203175204.GY3371@techsingularity.net> <CAKfTPtBGsXb0RqE_qs2miZGi_uax4VY1_8y1NGhQ17Q8mBx8dw@mail.gmail.com>
 <20201204113030.GZ3371@techsingularity.net> <CAKfTPtDRqwUoX51rU0Xd3H9Dwqf8bLAFBxhoeMF1brKYmAZDJg@mail.gmail.com>
 <CAKfTPtBABBY1QSfFtbhBQ7+a8HOp2YfTyJaMVo07T5GU7sp_MA@mail.gmail.com>
 <3d8a6d19-afac-dc93-127d-da6505402cdf@linux.intel.com> <CAKfTPtAp+SyjmAsxTpSo5owQq0AeDpBWdo5ds0fVZvDr2OK_iw@mail.gmail.com>
 <20201204143115.GB3371@techsingularity.net> <CAKfTPtBXUK7NnhN1Rxeq-o5t-G+csN6Tj0yP=BSV_sdD1uZS0g@mail.gmail.com>
 <20201204154029.GC3371@techsingularity.net>
In-Reply-To: <20201204154029.GC3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 4 Dec 2020 16:43:05 +0100
Message-ID: <CAKfTPtDX1wGWD3bEC=YZ74uvKGmkHPf3rLobr_wGy7MSFwtcdw@mail.gmail.com>
Subject: Re: [PATCH 06/10] sched/fair: Clear the target CPU from the cpumask
 of CPUs searched
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Fri, 4 Dec 2020 at 16:40, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Dec 04, 2020 at 04:23:48PM +0100, Vincent Guittot wrote:
> > On Fri, 4 Dec 2020 at 15:31, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Fri, Dec 04, 2020 at 02:47:48PM +0100, Vincent Guittot wrote:
> > > > > IIUC, select_idle_core and select_idle_cpu share the same cpumask(select_idle_mask)?
> > > > > If the target's sibling is removed from select_idle_mask from select_idle_core(),
> > > > > select_idle_cpu() will lose the chance to pick it up?
> > > >
> > > > This is only relevant for patch 10 which is not to be included IIUC
> > > > what mel said in cover letter : "Patches 9 and 10 are stupid in the
> > > > context of this series."
> > > >
> > >
> > > Patch 10 was stupid in the context of the prototype because
> > > select_idle_core always returned a CPU. A variation ended up being
> > > reintroduced at the end of the Series Yet To Be Posted so that SMT siblings
> > > are cleared during select_idle_core() but select_idle_cpu() still has a
> > > mask with unvisited CPUs to consider if no idle cores are found.
> > >
> > > As far as I know, this would still be compatible with Aubrey's idle
> > > cpu mask as long as it's visited and cleared between select_idle_core
> > > and select_idle_cpu. It relaxes the contraints on Aubrey to some extent
> > > because the idle cpu mask would be a hint so if the information is out
> > > of date, an idle cpu may still be found the normal way.
> >
> > But even without patch 10, just replacing sched_domain_span(sd) by
> > sds_idle_cpus(sd->shared) will ensure that sis loops only on cpus that
> > get a chance to be idle so select_idle_core is likely to return an
> > idle_candidate
> >
>
> Yes but if the idle mask is out of date for any reason then idle CPUs might

In fact it's the opposite, a cpu in idle mask might not be idle but
all cpus that enter idle will be set

> be missed -- hence the intent to maintain a mask of CPUs visited and use
> the idle cpu mask as a hint to prioritise CPUs that are likely idle but
> fall back to a normal scan if none of the "idle cpu mask" CPUs are
> actually idle.
>
> --
> Mel Gorman
> SUSE Labs
