Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9E297552
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460851AbgJWQws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:52:48 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10189
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S375002AbgJWQws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:52:48 -0400
X-IronPort-AV: E=Sophos;i="5.77,409,1596492000"; 
   d="scan'208";a="362621182"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 18:52:45 +0200
Date:   Fri, 23 Oct 2020 18:52:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Chen Yu <yu.chen.surf@gmail.com>
cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: check for idle core
In-Reply-To: <CADjb_WSG-z78KYmS=f2cLYdYLeqi=eqmLw+Q=sMGOBEM7Bw2Ug@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2010231850320.2707@hadrien>
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr> <CADjb_WSG-z78KYmS=f2cLYdYLeqi=eqmLw+Q=sMGOBEM7Bw2Ug@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Oct 2020, Chen Yu wrote:

> On Fri, Oct 23, 2020 at 1:32 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> [cut]
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index aa4c6227cd6d..9b23dad883ee 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5804,6 +5804,9 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
> >         if (sync && cpu_rq(this_cpu)->nr_running == 1)
> >                 return this_cpu;
> >
> > +       if (available_idle_cpu(prev_cpu))
> How about also taking  sched_idle_cpu(prev_cpu) into consideration?
> if (available_idle_cpu(prev_cpu) || sched_idle_cpu(prev_cpu))

I have no opinion about this, because it wasn't relevant to the
application I was looking at.  The available_idle check on prev previously
in wake_affine_idle doesn't check sched_idle_cpu, so I didn't put it here.

julia
