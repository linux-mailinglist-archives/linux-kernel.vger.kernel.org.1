Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190A71BD03B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 00:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgD1WzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 18:55:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50706 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD1WzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588114511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7uAqY8p0pjY0KMACKKK3etw1n75eHJHi1TZE1AVD8U=;
        b=F2bCXtMO1Exu6EF+xXZtyNfsfHGreF4b55NiZsTM/yNpE2i3zRLl3ptAthlqliSCuR6BWG
        LWDiERyUyr9KKs9evXPjNCQTixzJVD2Fpq/Mb72cw9FofL4X/nIgy50AeJOl9OGMZXP3wQ
        sKbJcuf/Pdpzl74R8SnxRfXwmscn/6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-bD6M3SYYNKyG_p9xUVnZ5w-1; Tue, 28 Apr 2020 18:55:09 -0400
X-MC-Unique: bD6M3SYYNKyG_p9xUVnZ5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C4C5107ACCD;
        Tue, 28 Apr 2020 22:55:07 +0000 (UTC)
Received: from ovpn-112-24.phx2.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4A311002388;
        Tue, 28 Apr 2020 22:55:03 +0000 (UTC)
Message-ID: <c4a8d1f044b721a2c396fa00a0244eff0b851ae4.camel@redhat.com>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Date:   Tue, 28 Apr 2020 17:55:03 -0500
In-Reply-To: <20200428220917.GB16027@hirez.programming.kicks-ass.net>
References: <20200428050242.17717-1-swood@redhat.com>
         <20200428050242.17717-2-swood@redhat.com> <jhjftcns35d.mognet@arm.com>
         <20200428220917.GB16027@hirez.programming.kicks-ass.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 00:09 +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 10:37:18PM +0100, Valentin Schneider wrote:
> > On 28/04/20 06:02, Scott Wood wrote:
> > > Thus, newidle_balance() is entered with interrupts enabled, which
> > > allows
> > > (in the next patch) enabling interrupts when the lock is dropped.
> > > 
> > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > ---
> > >  kernel/sched/core.c  |  7 ++++---
> > >  kernel/sched/fair.c  | 45 ++++++++++++++++---------------------------
> > > -
> > >  kernel/sched/sched.h |  6 ++----
> > >  3 files changed, 22 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 9a2fbf98fd6f..0294beb8d16c 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3241,6 +3241,10 @@ static struct rq *finish_task_switch(struct
> > > task_struct *prev)
> > >       }
> > > 
> > >       tick_nohz_task_switch();
> > > +
> > > +	if (is_idle_task(current))
> > > +		newidle_balance();
> > > +
> > 
> > This means we must go through a switch_to(idle) before figuring out we
> > could've switched to a CFS task, and do it then. I'm curious to see the
> > performance impact of that.
> 
> Also, if you move it this late, this is entirely the wrong place. If you
> do it after the context switch either use the balance_callback or put it
> in the idle path.
> 
> But what Valentin said; this needs a fair bit of support, the whole
> reason we've never done this is to avoid that double context switch...
> 

balance_callback() enters with the rq lock held but BH not separately
disabled, which interferes with the ability to enable interrupts but not BH.
It also gets called from rt_mutex_setprio() and __sched_setscheduler(), and
I didn't want the caller of those to be stuck with the latency.

-Scott


