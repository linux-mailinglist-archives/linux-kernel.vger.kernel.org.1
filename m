Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B98522C493
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 13:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGXLxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 07:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXLxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:53:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB311C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:53:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a6so8438515wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9fkc7zQHbUKv6oJjCYqFeYv2U4+eCFKPgmt6sjvkA0s=;
        b=DVzMykgb/gQhd0NTWcO/irYJ0RTSihM6KanWZg+kdl5fqcHifyMc1zLr75yPskD6AJ
         w3qrbSY4CSOE7riMxfVvngn1gN2Gi5BdAcv6eKZh7CM8LfWKKjvf/OnGHl4o4mmiE7lM
         WZ8osSabsAlWVyOn35cEwktdnz/QM2wMURw3030CfoXq2qq8hmtmAebkKEitDXtall3M
         71dE/3dBBZEPFf8cYkAU4OrTcXVbuHW0MT3ZFl/BbtzZ5iO1+DtqmgpjQC20PuNlBob+
         0R/26x3A0+1mgXLSq23uy5q7gmcjzkEnU9Mm7RU3mYJtpvk9YBVSEkfw/JFdRYAn9MCm
         Nt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9fkc7zQHbUKv6oJjCYqFeYv2U4+eCFKPgmt6sjvkA0s=;
        b=e1UhX/Phyhg/rHDZ8MmHNA7OIrxcox4X+LAEK1ZlIfcjD6olXmvFpwKtboT7YH5uDR
         VhV/BUY6CWgrVz2JevFL6tou58xp+vCxvBsRpcP+vQTGnwkNPwfgkBFLbsYzAnCvUK7m
         xzTb6lwrMhIAFl4sqUpw87PLo/GK73el8hP/zht5tcd6gLQGLEWrm1svYKVCIqkrgwy8
         BrVGUAvIh/Yi8jsothLXeogDDuPfl+Kr+jmRtWvJtAT9m4AheJVaNCZlv+zEGvgEiPuk
         AZXsKAE5/VZC1GXfpSbsd0JFioO7JCqUP0Gr5u1mM5Z+I/I55XqVMXD31Gt9WDSiguHn
         TRNQ==
X-Gm-Message-State: AOAM532JQrCWU97T1AnhUZ3gencOWdvaLtJSEIi5FCm4ffV3n+MlwkGi
        7t2gS5/V8bEfbEuglPbfNC+N4GOEMHp0myYMX9A=
X-Google-Smtp-Source: ABdhPJw/p5FV5jm6je4FzYrCOdZubGFdTWc/Z4paicIz9b3b1hQzYh1I4zb8wpZP216HoFQqtQdZ5vth1u9LRwSHSlU=
X-Received: by 2002:a1c:28a:: with SMTP id 132mr8308761wmc.109.1595591610712;
 Fri, 24 Jul 2020 04:53:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200723233853.48815-1-humjb_1983@163.com> <CAKfTPtCnewaivay7bftUY27+-qB=ct3eSNEoZW=-2Z6k0S4B4Q@mail.gmail.com>
 <CAPJCdBnv4W5+u6OZ4vbAdJ2U8ubhfAU7+Zt0JUFjfxKEDuGJSw@mail.gmail.com> <CAKfTPtCXXGEDNG+YxBbRG4vFK1+ig5EBzntmyTxr7MbQw-Q7MA@mail.gmail.com>
In-Reply-To: <CAKfTPtCXXGEDNG+YxBbRG4vFK1+ig5EBzntmyTxr7MbQw-Q7MA@mail.gmail.com>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Fri, 24 Jul 2020 19:53:19 +0800
Message-ID: <CAPJCdBm=FJp8K1SubXP4Rfa-POr8hDh320faE+4Cjcjk3BL1JQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: consider sched-idle CPU when selecting idle core
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Jiang Biao <humjb_1983@163.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 at 18:34, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Fri, 24 Jul 2020 at 10:12, Jiang Biao <benbjiang@gmail.com> wrote:
> >
> > On Fri, 24 Jul 2020 at 15:24, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Fri, 24 Jul 2020 at 01:39, Jiang Biao <humjb_1983@163.com> wrote:
> > > >
> > > > From: Jiang Biao <benbjiang@tencent.com>
> > > >
> > > > Sched-idle CPU has been considered in select_idle_cpu and
> > > > select_idle_smt, it also needs to be considered in select_idle_core to
> > > > be consistent and keep the same *idle* policy.
> > >
> > > In the case of select_idle_core, we are looking for a core that is
> > > fully idle but if one CPU of the core is running a sched_idle task,
> > > the core will not be idle and we might end up having  the wakeup task
> > > on a CPU and a sched_idle task on another CPU of the core which is not
> > > what we want
> > Got it. sched_idle task may interfere its sibling, which brings me
> > another question,
> > If there's a core with smt1 running sched_idle task and smt2 idle,
> > selecting smt1
> > rather than smt2 should be more helpful for wakee task, because wakee task
> > could suppress the sched_idle task without neighbour interfering.
>
> But the sched_idle will then probably quickly move on the idle smt2
>
> > And there seems to be no consideration about that currently.
> > Is it worth improving that?
>
> This will complexify and extend the duration of the search loop  and
> as mentioned above, it will most probably be a nop at the end because
> of sched_idle task moving on smt2
Indeed, the complexity is not worth.
Thanks for the explanation.

Regards,
Jiang
>
> >
> > Thanks a lot.
> >
> > Regards,
> > Jiang
