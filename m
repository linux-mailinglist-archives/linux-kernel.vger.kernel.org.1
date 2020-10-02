Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1725A2814E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbgJBOWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBOWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:22:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD1BC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=spV20D8bUHJ1uxHiKnyQuuFbsdemVvIUVIXLYscdGns=; b=LfQsiSdS2YcZpxwdn4Jf6mMaeL
        zHZxjSpVqp/r3LjNdfGdeYaAQJ+mFvKnp2o6AfuACpXAEevxKopuK7s8o4jUYsBHjnMYtC0PrNSwk
        NfTIK5q6yT2V/wZVhyHYtBBHbRdZgfzoaIrxbnPbIeVpPnmVpPxN7faQH3C6wbBVqUcMlKnhyitTu
        YFrK44FfQHfJi9me3RMTdqyc3icGTW14qDBdwwqtozTlKghYHU5c8j13ozO8PHRZsO3xN4hbvLBID
        c2/ki4fqEc3R3EojEjvDIDcCFiF0Q+X+fsh69YO0nfu6O53b/A+yYL10I3PA58lx4X9n2thlWvDk/
        1AHfD0iQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOLwU-0008UB-Va; Fri, 02 Oct 2020 14:21:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7FF53011E6;
        Fri,  2 Oct 2020 16:21:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A9BE7203A8F69; Fri,  2 Oct 2020 16:21:49 +0200 (CEST)
Date:   Fri, 2 Oct 2020 16:21:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
Message-ID: <20201002142149.GZ2628@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.769861942@infradead.org>
 <20200925165047.iey2dlcdn4im2vv4@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200925165047.iey2dlcdn4im2vv4@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 06:50:47PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-09-21 18:36:04 [+0200], Peter Zijlstra wrote:
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1700,6 +1700,68 @@ void check_preempt_curr(struct rq *rq, s
> >  
> >  #ifdef CONFIG_SMP
> >  
> > +#ifdef CONFIG_PREEMPT_RT
> …
> > +static inline bool is_migration_disabled(struct task_struct *p)
> > +{
> > +	return p->migration_disabled;
> > +}
> 
> Just a thought: having this with int as return type and defined in a
> header file then it could be used in check_preemption_disabled() and in
> the tracing output.

Yeah, I didn't want it in a header where world can access it and attempt
creative use :/
