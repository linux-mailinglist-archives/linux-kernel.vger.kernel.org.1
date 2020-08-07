Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D582D23EE7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgHGNzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 09:55:19 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:22642 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:55:19 -0400
Received: from [94.37.192.58] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 150297235; Fri, 07 Aug 2020 15:55:16 +0200
Date:   Fri, 7 Aug 2020 15:55:10 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807155510.2b380f49@nowhere>
In-Reply-To: <20200807134353.GR42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
        <20200807095604.GO42956@localhost.localdomain>
        <20200807152832.591f462e@nowhere>
        <20200807134353.GR42956@localhost.localdomain>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Aug 2020 15:43:53 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> On 07/08/20 15:28, luca abeni wrote:
> > Hi Juri,
> > 
> > On Fri, 7 Aug 2020 11:56:04 +0200
> > Juri Lelli <juri.lelli@redhat.com> wrote:
> >   
> > > Starting deadline server for lower priority classes right away
> > > when first task is enqueued might break guarantees  
> > 
> > Which guarantees are you thinking about, here? Response times of
> > fixed priority tasks?  
> 
> Response time, but also wakeup latency (which, for better or worse, is
> another important metric).
> 
> > If fixed priority tasks are also scheduled through deadline servers,
> > then you can provide response-time guarantees to them even when
> > lower-priority/non-real-time tasks are scheduled through deadline
> > servers.  
> 
> Right, but I fear we won't be able to keep current behavior for
> wakeups: RT with highest prio always gets scheduled right away?

Uhm... I think this depends on how the servers' parameters are
designed: assigning "wrong" (or "bad") parameters to the server used to
schedule RT tasks, this property is broken.

(however, notice that even with the current patchset the highest
priority task might be scheduled with some delay --- if the SCHED_OTHER
deadline server is active because SCHED_OTHER tasks are being starved).



			Luca
