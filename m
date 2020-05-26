Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1331BED94
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 03:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgD3BcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 21:32:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43967 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbgD3BcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588210320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dn/lWgNDUyOjkAW0d+CfM2/g1REm4TptTiXnq8Nxe00=;
        b=a5t2x5SQWs6kd1slZGVzEDZCQj1U8znW6DovxB/v+uAYqnBKoMJa4v04zeSh2I2zN1T9PZ
        gqSpjnEfN4BzKl2MXtJAA/Pwks2HXD4WRnhergqlz2/blPjGgbPJTZt/ixjhG9CUXVZhrd
        jonRlpzM1y20c1casqapgvATmpkHP20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-YRv229c6PBSsndGaIbz2-A-1; Wed, 29 Apr 2020 21:31:54 -0400
X-MC-Unique: YRv229c6PBSsndGaIbz2-A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 55701108BD0F;
        Thu, 30 Apr 2020 01:31:52 +0000 (UTC)
Received: from ovpn-112-24.phx2.redhat.com (ovpn-112-24.phx2.redhat.com [10.3.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D17DE5C1D0;
        Thu, 30 Apr 2020 01:31:50 +0000 (UTC)
Message-ID: <0945b70535f11c9abd45d3a3da2e984c4b1d832b.camel@redhat.com>
Subject: Re: [RFC PATCH 1/3] sched/fair: Call newidle_balance() from
 finish_task_switch()
From:   Scott Wood <swood@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
In-Reply-To: <20200429090533.GH13592@hirez.programming.kicks-ass.net>
References: <20200428050242.17717-1-swood@redhat.com>
         <20200428050242.17717-2-swood@redhat.com> <jhjftcns35d.mognet@arm.com>
         <20200428220917.GB16027@hirez.programming.kicks-ass.net>
         <c4a8d1f044b721a2c396fa00a0244eff0b851ae4.camel@redhat.com>
         <20200428230204.GE16027@hirez.programming.kicks-ass.net>
         <89043649a64fc97dd90eb25c85bcc8f65483cf4f.camel@redhat.com>
         <20200429090533.GH13592@hirez.programming.kicks-ass.net>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Date:   Wed, 29 Apr 2020 20:31:39 -0500
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 11:05 +0200, Peter Zijlstra wrote:
> On Tue, Apr 28, 2020 at 06:20:32PM -0500, Scott Wood wrote:
> > On Wed, 2020-04-29 at 01:02 +0200, Peter Zijlstra wrote:
> > > On Tue, Apr 28, 2020 at 05:55:03PM -0500, Scott Wood wrote:
> > > > On Wed, 2020-04-29 at 00:09 +0200, Peter Zijlstra wrote:
> > > > > Also, if you move it this late, this is entirely the wrong
> > > > > place.  If you do it after the context switch either use the
> > > > > balance_callback or put it in the idle path.
> > > > > 
> > > > > But what Valentin said; this needs a fair bit of support, the
> > > > > whole reason we've never done this is to avoid that double
> > > > > context switch...
> > > > > 
> > > > 
> > > > balance_callback() enters with the rq lock held but BH not
> > > > separately
> > > 
> > > BH? softirqs you mean? Pray tell more.
> > 
> > In https://lore.kernel.org/lkml/5122CD9C.9070702@oracle.com/ the need to
> > keep softirqs disabled during rebalance was brought up, but simply
> > wrapping
> > the lock dropping in local_bh_enable()/local_bh_disable() meant that
> > local_bh_enable() would be called with interrupts disabled, which isn't
> > allowed.
> 
> That thread, nor your explanation make any sense -- why do we care about
> softirqs?, 

I was trusting Steve's claim that that was the issue (it seemed plausible
given that system-wide rebalancing is done from a softirq).  If things have
changed since then, great.  If that was never the issue, then there's the
question of what caused the bug Sasha saw.

> nor do I see how placing it in finish_task_switch() helps
> with any of this.

It lets us do the local_bh_enable() after IRQs are enabled, since we don't
enter with any existing atomic context.  Though I suppose we could instead
do another lock drop at the end of newidle_balance() just to enable
softirqs.

> > > > disabled, which interferes with the ability to enable interrupts
> > > > but not BH.  It also gets called from rt_mutex_setprio() and
> > > > __sched_setscheduler(), and I didn't want the caller of those to
> > > > be stuck with the latency.
> > > 
> > > You're not reading it right.
> > 
> > Could you elaborate?
> 
> If you were to do a queue_balance_callback() from somewhere in the
> pick_next_task() machinery, then the balance_callback() at the end of
> __schedule() would run it, and it'd be gone. How would
> rt_mutex_setprio() / __sched_setscheduler() be affected?

The rq lock is dropped between queue_balance_callback() and the
balance_callback() at the end of __schedule().  What stops
setprio/setscheduler on another cpu from doing the callback at that
point?

-Scott


