Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5C2A1B4AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgDVQkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 12:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgDVQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:40:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89AA42082E;
        Wed, 22 Apr 2020 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587573630;
        bh=a2zbWjxgVMa4iTxFb1SLUG61ZNNgjj/Et8+PzaCsSe0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=qfaF0NviQu//KdrHWbbYtmKA8beHJ70ZQGHIYEquUvYd6hQkY6FTrk0iUh/mM3oeT
         2PvLSWWBJvCrwI+DlnTiCqpmD54umubrpwVY4eCI3LwFwZhg5DnoTksCj5yrlNy+qg
         5f7oybvXKD9SZxaHBXubWjY7cK3HgD/HXuGxJ1MU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6378C3520480; Wed, 22 Apr 2020 09:40:30 -0700 (PDT)
Date:   Wed, 22 Apr 2020 09:40:30 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, airlied@redhat.com,
        alexander.deucher@amd.com, awalls@md.metrocast.net,
        axboe@kernel.dk, broonie@kernel.org, daniel.lezcano@linaro.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        herbert@gondor.apana.org.au, hverkuil@xs4all.nl,
        john.stultz@linaro.org, nico@fluxnic.net,
        rafael.j.wysocki@intel.com, rmk+kernel@arm.linux.org.uk,
        sudeep.holla@arm.com, ulf.hansson@linaro.org,
        wim@linux-watchdog.org
Subject: Re: [PATCH 01/23] sched: Provide sched_set_fifo()
Message-ID: <20200422164030.GA17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200422112719.826676174@infradead.org>
 <20200422112831.266499893@infradead.org>
 <20200422131138.GL17661@paulmck-ThinkPad-P72>
 <20200422132648.GJ20730@hirez.programming.kicks-ass.net>
 <20200422155006.GR17661@paulmck-ThinkPad-P72>
 <20200422123331.30b00018@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422123331.30b00018@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:33:31PM -0400, Steven Rostedt wrote:
> On Wed, 22 Apr 2020 08:50:06 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > Indeed, an extreme form of insanity would be required to try to make core
> > RCU be a module.  Not that such a form of insanity is a bad thing in and
> > of itself, but it might best be directed towards less futile ventures.  ;-)
> 
> That's like making the core of mutexes a module. How would that ever work
> (without becoming a microkernel).

Someone somewhere has probably done it.  Perhaps you really could make
mutexes be a module within the Linux kernel using kpatch or similar.
Sort of, anyway.

Not saying it is not insane, mind you!  ;-)

							Thanx, Paul
