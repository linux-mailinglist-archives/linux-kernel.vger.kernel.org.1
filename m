Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 882E91A8389
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440771AbgDNPll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 11:41:41 -0400
Received: from foss.arm.com ([217.140.110.172]:58718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440742AbgDNPlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:41:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33EC830E;
        Tue, 14 Apr 2020 08:41:24 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F5483F73D;
        Tue, 14 Apr 2020 08:41:22 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:41:19 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        luca abeni <luca.abeni@santannapisa.it>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] sched/deadline: Improve admission control for
 asymmetric CPU capacities
Message-ID: <20200414154119.sffnwggqdibdwpp7@e107158-lin.cambridge.arm.com>
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-3-dietmar.eggemann@arm.com>
 <jhjeesyw96u.mognet@arm.com>
 <20200408153032.447e098d@nowhere>
 <jhjblo2vx60.mognet@arm.com>
 <31620965-e1e7-6854-ad46-8192ee4b41af@arm.com>
 <20200414114032.wigdlnegism6qqns@e107158-lin.cambridge.arm.com>
 <jhjy2qyrvir.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjy2qyrvir.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/20 15:29, Valentin Schneider wrote:
> 
> On 14/04/20 12:40, Qais Yousef wrote:
> >
> > I haven't followed this discussion closely, so I could be missing something
> > here.
> >
> > In sched_cpu_dying() we call set_rq_offline() which clears the cpu in
> > rq->rd->online.
> >
> > So the way I read the code
> >
> >       rd->online = cpumask_and(rd->span, cpu_active_mask)
> >
> > But I could have easily missed some detail.
> >
> 
> sched_cpu_dying() is wayyyy below sched_cpu_deactivate(). This doesn't help
> at all for the dl_cpu_busy() check in sched_cpu_deactivate().

It'd makes more sense to introduce rd->active then rather than a PERCPU global
variable IMHO.

> 
> > Regardless, it seems to me that DL is working around something not right in the
> > definition of rd->span or using the wrong variable.
> >
> 
> What DL is doing now is fine, it only needs to be aligned with the active
> mask (which it is). We're making things a bit trickier by adding capacity
> values into the mix.

I'm still worried that others might be affected by a similar problem.

Will dig deeper next week when I'm back from hols.

Thanks

--
Qais Yousef
