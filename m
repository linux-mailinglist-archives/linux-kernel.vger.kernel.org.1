Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBCB2FE845
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbhAULBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:01:50 -0500
Received: from foss.arm.com ([217.140.110.172]:59470 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730287AbhAUK6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:58:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 46801D6E;
        Thu, 21 Jan 2021 02:58:03 -0800 (PST)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6EB3F719;
        Thu, 21 Jan 2021 02:58:02 -0800 (PST)
Date:   Thu, 21 Jan 2021 10:57:57 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH 3/4] cpu/hotplug: Add cpuhp_invoke_callback_range()
Message-ID: <20210121105756.GA312559@e120877-lin.cambridge.arm.com>
References: <1610385047-92151-1-git-send-email-vincent.donnefort@arm.com>
 <1610385047-92151-4-git-send-email-vincent.donnefort@arm.com>
 <YAhsLPLXg37fs/BA@hirez.programming.kicks-ass.net>
 <YAhuHdcfKnyWKdka@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YAhuHdcfKnyWKdka@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 06:53:33PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 20, 2021 at 06:45:16PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 11, 2021 at 05:10:46PM +0000, vincent.donnefort@arm.com wrote:
> > > @@ -475,6 +478,11 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
> > >  static inline void
> > >  cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
> > >  {
> > > +	st->target = prev_state;
> > > +
> > > +	if (st->rollback)
> > > +		return;
> > 
> > I'm thinking that if we call rollback while already rollback we're hosed
> > something fierce, no?
> > 
> > That like going up, failing, going back down again, also failing, giving
> > up in a fiery death.
> 
> Ooh, is this a hack for _cpu_down():
> 
> 	ret = cpuhp_down_callbacks(cpu, st, target);
> 	if (ret && st->state == CPUHP_TEARDOWN_CPU && st->state < prev_state) {
> 		cpuhp_reset_state(st, prev_state);
> 		__cpuhp_kick_ap(st);
> 	}
> 
> Where cpuhp_down_callbacks() can already have called cpuhp_reset_state() ?

Yes, it is now possible that this function will be called twice during the
rollback. Shall I avoid this and treat the case above differently ? i.e. "if we
are here, state has already been reset, and we should only set st->target".

-- 
Vincent
