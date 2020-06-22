Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0C2034D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 12:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgFVKa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 06:30:28 -0400
Received: from foss.arm.com ([217.140.110.172]:39072 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgFVKa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:30:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 922271FB;
        Mon, 22 Jun 2020 03:30:25 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C9323F71E;
        Mon, 22 Jun 2020 03:30:23 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:30:21 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Fix initialization of strut uclamp_rq
Message-ID: <20200622103020.i2x2oh367j57cowh@e107158-lin.cambridge.arm.com>
References: <20200618195525.7889-1-qais.yousef@arm.com>
 <20200618195525.7889-2-qais.yousef@arm.com>
 <20200619173055.GA576888@hirez.programming.kicks-ass.net>
 <20200619173944.blwuimtuqmcxlj2v@e107158-lin.cambridge.arm.com>
 <20200619181303.GD576888@hirez.programming.kicks-ass.net>
 <20200619184225.ospkxdg5gzh42y2b@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200619184225.ospkxdg5gzh42y2b@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/20 19:42, Qais Yousef wrote:
> On 06/19/20 20:13, Peter Zijlstra wrote:
> > On Fri, Jun 19, 2020 at 06:39:44PM +0100, Qais Yousef wrote:
> > > On 06/19/20 19:30, Peter Zijlstra wrote:
> > > > On Thu, Jun 18, 2020 at 08:55:24PM +0100, Qais Yousef wrote:
> > > > 
> > > > > +	for_each_clamp_id(clamp_id) {
> > > > > +		memset(uc_rq[clamp_id].bucket,
> > > > > +		       0,
> > > > > +		       sizeof(struct uclamp_bucket)*UCLAMP_BUCKETS);
> > > > > +
> > > > > +		uc_rq[clamp_id].value = uclamp_none(clamp_id);
> > > > 
> > > > I think you can replace all that with:
> > > > 
> > > > 		*uc_rq = (struct uclamp_rq){
> > > > 			.value = uclamp_none(clamp_id),
> > > > 		};
> > > > 
> > > > it's shorter and is free or weird line-breaks :-)
> > > 
> > > Sure. I just sent v2 so that people will be encouraged to run tests hopefully.
> > > But will fix in v3.
> > > 
> > > Do we actually need to 0 out anything here? Shouldn't the runqueues all be in
> > > BSS which gets initialized to 0 by default at boot?
> > > 
> > > Maybe better stay explicit..
> > 
> > C99 named initializer (as used here) explicitly zero initializes all
> > unnamed members. Is that explicit enough? ;-)
> 
> Hehe yes, but what I meant is that unless
> 
> 	DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> 
> has some special rules, it should be in BSS and already zeroed out when we do
> sched_init(). So do we really need to explicitly zero out anything? It seems
> redundant, but again maybe being explicit is more readable,
> so maybe better keep it the way it is (named initializer of struct).

FWIW, they end up in .data section actually. So they're assumed to be
initialized. So we must explicitly initialize everything..

Cheers

--
Qais Yousef
