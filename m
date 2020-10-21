Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5029294D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440749AbgJUNSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:18:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41942 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436971AbgJUNSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:18:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7B91AD12;
        Wed, 21 Oct 2020 13:18:29 +0000 (UTC)
Date:   Wed, 21 Oct 2020 14:18:27 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles.Muller@inria.fr
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201021131827.GF32041@suse.de>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021112038.GC32041@suse.de>
 <20201021122532.GA30733@vingu-book>
 <20201021124700.GE32041@suse.de>
 <alpine.DEB.2.22.394.2010211452100.8475@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2010211452100.8475@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 02:56:06PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 21 Oct 2020, Mel Gorman wrote:
> 
> > On Wed, Oct 21, 2020 at 02:25:32PM +0200, Vincent Guittot wrote:
> > > > I see Vincent already agreed with the patch so I could be wrong.  Vincent,
> > > > did I miss something stupid?
> > >
> > > This patch fixes the problem that we don't favor anymore the prev_cpu when it is idle since
> > > commit 11f10e5420f6ce because load is not null when cpu is idle whereas runnable_load was
> > > And this is important because this will then decide in which LLC we will looks for a cpu
> > >
> >
> > Ok, that is understandable but I'm still concerned that the fix simply
> > trades one problem for another by leaving related tasks remote to each
> > other and increasing cache misses and remote data accesses.
> >
> > wake_affine_weight is a giant pain because really we don't care about the
> > load on the waker CPU or its available, we care about whether it has idle
> > siblings that can be found quickly. As tempting as ripping it out is,
> > it never happened because sometimes it makes the right decision.
> 
> My goal was to restore the previous behavior, when runnable load was used.
> The patch removing the use of runnable load (11f10e5420f6) presented it
> basically as that load balancing was using it, so wakeup should use it
> too, and any way it didn't matter because idle CPUS were checked for
> anyway.
> 

Which is fair.

> Is your point of view that the proposed change is overkill?  Or is it that
> the original behavior was not desirable?
> 

I worry it's overkill because prev is always used if it is idle even
if it is on a node remote to the waker. It cuts off the option of a
wakee moving to a CPU local to the waker which is not equivalent to the
original behaviour.

-- 
Mel Gorman
SUSE Labs
