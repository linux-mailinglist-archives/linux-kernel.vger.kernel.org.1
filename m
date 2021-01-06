Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5682EC437
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 20:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbhAFTyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 14:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbhAFTyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 14:54:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E30E222BEA;
        Wed,  6 Jan 2021 19:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609962801;
        bh=Va1xoBJrpnEa618+9mPMiJ4gX4WHK8rVsl5obx43Hag=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fdE9YNrYv4sEN7ql9eLreJTrYtCbeBVoymUX/NwzHQRBh9ZUmzMMTRUo1kYBjubq2
         49l3cqztR7yncWR3EnICkG8Is3kNSUCNnD72lMX5K9reAdZBjNAw81X+swKwMJt53c
         4bEvk6zQ4iYTevULaNC7fT/rsApGx+qLRBNpOhlsBvGbyNlnU3TeV/0zayu3jFJfJO
         Pn0NGANFKn8fNgf4mhXKmtZNYWSPOm7lvxTKErMSf8OEybODj0cRK/l9zwYmmZTkVE
         MLvYDLEfLtX6+wnNieE0Jl5aSe6ctLzLtzyf4e8tFDoletYx0Bf5MUQfqxNJ83+Jum
         tT3rpsS6MtmDg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B6AB135225DC; Wed,  6 Jan 2021 11:53:21 -0800 (PST)
Date:   Wed, 6 Jan 2021 11:53:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Rik van Riel <riel@fb.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH RFC clocksource 2/5] clocksource: Retry clock read if
 long delays detected
Message-ID: <20210106195321.GC2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106004013.GA11179@paulmck-ThinkPad-P72>
 <20210106004134.11467-2-paulmck@kernel.org>
 <edbe9ac5fc3f76601f752ce2c5a8052dc05fd4f6.camel@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edbe9ac5fc3f76601f752ce2c5a8052dc05fd4f6.camel@fb.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 11:28:00AM -0500, Rik van Riel wrote:
> On Tue, 2021-01-05 at 16:41 -0800, paulmck@kernel.org wrote:
> > 
> > @@ -203,7 +204,6 @@ static void
> > clocksource_watchdog_inject_delay(void)
> >  		injectfail = inject_delay_run;
> >  	if (!(++injectfail / inject_delay_run % inject_delay_freq)) {
> >  		printk("%s(): Injecting delay.\n", __func__);
> > -		injectfail = 0;
> >  		for (i = 0; i < 2 * WATCHDOG_THRESHOLD / NSEC_PER_MSEC;
> > i++)
> >  			udelay(1000);
> 
> Wait, patch 1 just added that line?
> 
> Should patch 1 not add it and this
> patch go without
> this removal? :)

Good catch, will fix.  ;-)

> +               wdagain_nsec = clocksource_cyc2ns(delta, watchdog-
> >mult, watchdog->shift);
> +               if (wdagain_nsec < 0 || wdagain_nsec >
> WATCHDOG_MAX_SKEW) {
> +                       wderr_nsec = wdagain_nsec;
> +                       if (nretries++ < max_read_retries)
> +                               goto retry;
> +               }
> 
> Given that clocksource_cyc2ns uses unsigned multiplication
> followed by a right shift, do we need to test for <0?

I am worried about the possibility of the "shift" argument to
clocksource_cyc2ns() being zero.  For example, unless I am missing
something, clocksource_tsc has a zero .shift field.

							Thanx, Paul
