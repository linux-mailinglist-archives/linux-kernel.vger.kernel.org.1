Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D6A2D2C27
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgLHNoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgLHNoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:44:13 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F26C061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 05:43:26 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id y19so11110102lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 05:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kflDldrUVBnU+zaORG7eppJHWXrlCjBCnv5S+tUfd+w=;
        b=tQwkZ1s4zPuhs/fr1TPlXQVpAKVO6zBoDYr0kmduqYQOul+wxZEn+VRTgw8pJWy6rC
         Dcx5bbop6RzZXcTzAKVtwtig9NVqJVhg/Jw7SY5UoHArgGcvr+0rhcQ+dEi3NrZAbvc9
         EeZryRVpqRxlkVvTdJZZlc0a4Wwf5cdSRIqE0peFv3niv/8QhGHpiM1xbQGuOHbRQP4I
         W2mJdrsxwyBOJGZ4WF3+2vXAtn6eySk/qTjz3Urqa83mu4vj7N/zcDTJ5ieLwar3yLxN
         AVBwvpZoPmM0xwqbYvTGif4JQNDQKEaJwq1+wlMf+m71Dc5EbVlA34mLPUiuENBJKZUI
         VcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kflDldrUVBnU+zaORG7eppJHWXrlCjBCnv5S+tUfd+w=;
        b=LtzjuakJR2JopYTvIyl1P9Y+EFS8dQitS0WyRet0LmcrgPhHab9iqJY+9a9D4rUJL+
         7Y6PGWwp9v3hDNDUfUJi7JQxIJ/ulCUmppdetO+OGFhf0vmIjSuO/yFAvrahzA1LSMhN
         xz/uwpAoOBJ1puF+B+SDVSRExKgjFBG1u6njquVeAr3xFUPt3AeiSDqfGXgtd9y9fA+H
         GTbAAf5cb7y0amHtkSEWuIKnKSL67ljCJuUFMTncLzZghs+j7Y0u8vdAyiWbPhDO1qy8
         3GU3EtsGVUdb2AydoWEHgV+zi76sfsXGg6I4CqKA/jwYZUBMU0qYdK4TZCJ8+WrdLr9z
         6jRA==
X-Gm-Message-State: AOAM533kfev65VUgw9GVTgTyhnrltD9RE6D97Dah4DqIKI0LBj/GSiCt
        l15wjcI7LWspWYP1yF4Eaq1PjAh9VyMHjdPCciB1DldsFHQR9A==
X-Google-Smtp-Source: ABdhPJza0CEfkjZ7hzl00G6HV1M6G1O8bG/bMr/IoTq/hmZgvhjFkKItk72qjaJ2b8m/bsyL1SRgYaMAtCStLDUsjgE=
X-Received: by 2002:a19:5e5e:: with SMTP id z30mr9941793lfi.277.1607435001313;
 Tue, 08 Dec 2020 05:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20201207091516.24683-1-mgorman@techsingularity.net>
 <20201207091516.24683-2-mgorman@techsingularity.net> <25a8c4bd-792b-2851-b10a-c4375eb83dfe@arm.com>
 <20201208105900.GG3371@techsingularity.net> <CAKfTPtBgo5vCrN87fqKjyaowONLMWeUusLmvE4bmGmDq10+Yrw@mail.gmail.com>
 <20201208133650.GI3371@techsingularity.net>
In-Reply-To: <20201208133650.GI3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 8 Dec 2020 14:43:10 +0100
Message-ID: <CAKfTPtDbUoVSvnjFrpomvTJD0jCA6vH_Y3LP=csW8fHntOG_6A@mail.gmail.com>
Subject: Re: [PATCH 1/4] sched/fair: Remove SIS_AVG_CPU
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Tue, 8 Dec 2020 at 14:36, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Dec 08, 2020 at 02:24:32PM +0100, Vincent Guittot wrote:
> > > > Nitpick:
> > > >
> > > > Since now avg_cost and avg_idle are only used w/ SIS_PROP, they could go
> > > > completely into the SIS_PROP if condition.
> > > >
> > >
> > > Yeah, I can do that. In the initial prototype, that happened in a
> > > separate patch that split out SIS_PROP into a helper function and I
> > > never merged it back. It's a trivial change.
> >
> > while doing this, should you also put the update of
> > this_sd->avg_scan_cost under the SIS_PROP feature ?
> >
>
> It's outside the scope of the series but why not. This?
>
> --8<--
> sched/fair: Move avg_scan_cost calculations under SIS_PROP
>
> As noted by Vincent Guittot, avg_scan_costs are calculated for SIS_PROP
> even if SIS_PROP is disabled. Move the time calculations under a SIS_PROP
> check and while we are at it, exclude the cost of initialising the CPU
> mask from the average scan cost.
>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 19ca0265f8aa..0fee53b1aae4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6176,10 +6176,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>                         nr = 4;
>         }
>
> -       time = cpu_clock(this);

I would move it in the if (sched_feat(SIS_PROP)) above.

> -
>         cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>
> +       if (sched_feat(SIS_PROP))
> +               time = cpu_clock(this);
>         for_each_cpu_wrap(cpu, cpus, target) {
>                 if (!--nr)
>                         return -1;
> @@ -6187,8 +6187,10 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>                         break;
>         }
>
> -       time = cpu_clock(this) - time;
> -       update_avg(&this_sd->avg_scan_cost, time);
> +       if (sched_feat(SIS_PROP)) {
> +               time = cpu_clock(this) - time;
> +               update_avg(&this_sd->avg_scan_cost, time);
> +       }
>
>         return cpu;
>  }
