Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839422849AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgJFJvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 05:51:33 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:63816 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgJFJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:51:33 -0400
Received: from [151.61.51.211] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 151709920; Tue, 06 Oct 2020 11:51:31 +0200
Date:   Tue, 6 Oct 2020 11:51:26 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 4/6] sched/deadline: Introduce deadline servers
Message-ID: <20201006115126.453db362@sweethome>
In-Reply-To: <20201006093523.GD4352@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
        <20200807095051.385985-5-juri.lelli@redhat.com>
        <20201006095612.381d806f@sweethome>
        <20201006093523.GD4352@localhost.localdomain>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Oct 2020 11:35:23 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
> > > +			if (dl_se->server_has_tasks(dl_se)) {
> > > +				enqueue_dl_entity(dl_se, dl_se, ENQUEUE_REPLENISH);
> > > +				resched_curr(rq);
> > > +				__push_dl_task(rq, &rf);
> > > +			} else {
> > > +				replenish_dl_entity(dl_se, dl_se);  
> > 
> > I am wondering if here we need a "task_non_contending(dl_se)" after
> > "replenish_dl_entity(dl_se, dl_se);"...
> > 
> > Basically, what happened is that all the served tasks blocked while the
> > server was throttled... So, now the server should be disabled (so, we
> > replenish the dl entity but we do not insert it in runqueue).
> > But when the server finished its budget and has been throttled, it has
> > not been disabled (so, its utilization is still in running_bw).  
> 
> Hummm. For CFS, we call dl_server_stop() after the last CFS task blocks
> and that calls dequeue_dl(SLEEP), which should be calling
> task_non_contending(). That should be happening also while the server is
> throttled and CFS tasks are running outside of it, no?

You are right... I somehow lost this detail.


> Guess I'm missing something.

No, I was the one missing something :)
Sorry about the noise.



			Thanks,
				Luca
