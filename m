Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365AA1D15D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbgEMNjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 09:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388537AbgEMNjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:39:08 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A63C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:08 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a2so14245489ejx.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqbYeA4KoNOGLDU4w91JLxJmMWvxI9R71hazf6AYiqA=;
        b=BX8FOjSkWi+v7YmCoxcilRdbPXqC8noIYuJCrduGbzn7537ea+xIbgIIp4kaWmk8Fs
         OTtCKMG89H8kgolwqbUez64KldKIG5RfESbd/KBLwEF04/mFeqR5Q/M/J8iRKKbBtBf8
         QujUSjjVo+cCnRhDeoXPCoBzvM8jtZQale0ODZX6wk4CqYNjakmZNjCfXhGRTc1f7u57
         toHx7cR/YJ4wVHPRbfAee+NDufr/UM/bPDeq1jEBmLchIRFN8CL5VAgHtdeQNsnA1mFY
         3PYx71UqIzxvlNEpY90a4aK/ll0JFFZnlPudLKn75GnHLMKSNdftS84UEznv8S60EVGL
         yOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqbYeA4KoNOGLDU4w91JLxJmMWvxI9R71hazf6AYiqA=;
        b=N50TzbfV+NO+J4b2GscRbbNkxg5GRsiQ4i/NvNzlD6m7cExLVrPhjtA++GuvhX1+s2
         OU9F6VhN7LN38hyYcYE/sBHbdidYZmGX5NQ5sgbX4t5DTIYDt5NIC7V6Mm8uWFJudEh9
         zPn4eiVnB82fF5WYs7SCnsEOL+BWbn1ytuXu0CPZhuh1SMu8wzyglB71kxE73XQrPhFh
         kruo0RbIi+BqaluqjfsXu+IUAV7+4X/j0D2L+OVwnD7zbdh24+FJ51ZORtJdhH83j0/E
         UHZ2xNrCovMGEfFR6wxwFiC8KmcndHLCdg+vOWNzxGrIXeAQEem2bJp4i0o6AqUrcu/g
         +g7g==
X-Gm-Message-State: AGi0PuYvUs6TJeQOwE8KDOL1cbL5jLjMFn8MAXT5GvpFlTirelG/qAHI
        fdol25pEMwLDyeNYURzpLRHlzPKzNaC5jJNoPibUlw==
X-Google-Smtp-Source: APiQypLIJhK5jdQTRXtb2GsY0qald7EfY5psTJrvJi1KrsW4dsSGbEwUlykmB7/sYpaDHqVIlbD6ewQbLhXudrNqGrI=
X-Received: by 2002:a17:907:9d6:: with SMTP id bx22mr20613524ejc.110.1589377147162;
 Wed, 13 May 2020 06:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200507180553.9993-1-john.mathew@unikie.com> <20200507180553.9993-3-john.mathew@unikie.com>
 <jhjh7wrtpjk.mognet@arm.com> <b974b959-7b9a-2874-dca6-674b74ad5b42@arm.com>
In-Reply-To: <b974b959-7b9a-2874-dca6-674b74ad5b42@arm.com>
From:   John Mathew <john.mathew@unikie.com>
Date:   Wed, 13 May 2020 16:38:55 +0300
Message-ID: <CAJz2qXkrcobNC0Oh94p1e5chMdgzm6X1VCU9Es-1_=Zm5V0HMg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/3] docs: scheduler: Add scheduler overview documentation
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com, tsbogend@alpha.franken.de,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>, x86@kernel.org,
        linux-mips@vger.kernel.org, tglx@linutronix.de,
        Mostafa Chamanara <mostafa.chamanara@basemark.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Oleg Tsymbal <oleg.tsymbal@unikie.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 1:58 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 07/05/2020 23:15, Valentin Schneider wrote:
> >
> > On 07/05/20 19:05, John Mathew wrote:
>
> [...]
>
> > It would also be an opportunity to have one place to (at least briefly)
> > describe what the different sched classes do wrt capacity asymmetry - CFS
> > does one thing, RT now does one thing (see Qais' work), and DL will
> > hopefully soon follow (see Dietmar's work).
> >
> > I'd be happy to contribute (some of) that, if it can be deemed useful (I
> > personally think it might).
>
> I like the idea.
>
> Essentially all the code which is guarded by the 'if
> (static_branch_unlikely(&sched_asym_cpucapacity)' condition or which
> sets it during bring-up.
>
> * 'Cpu capacity < SCHED_LOAD_SCALE for non-big' CPUs setting during
>    bringup (necessary dt binding, CPUfreq influence)
>
> * CFS capacity awareness:
>
>   * wakeup - select_idle_capacity() (replaced wake_cap() & slow path to
>              cover DynamIQ and classical big.LITTLE)
>
>   * load_balance - misfit handling
>
> * RT & DL capacity awareness
>
> * ... & the relation to EAS (Documentation/scheduler/sched-energy.rst)
>
> This is what we referred to (at least internally) as CAS (Capacity-Aware
> Scheduling).

Added in pathset v4.

Thanks
