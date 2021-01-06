Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2532EC2CE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbhAFRxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:53:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:56052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbhAFRxk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:53:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D12722312A;
        Wed,  6 Jan 2021 17:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609955579;
        bh=ogK6EhDts7KKPTEN1wdoBtfrIejUxcfZxSEvAnZq7g0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q1MRsKEBA08ucUjVtNSd/DAqD2y+Sa/ro0iwGC0Emf3ICFl93zu6nTvFu0Gj3QZyJ
         BZQ4cu1Y8paxSfRM/w5PzEEVlyZvvj6pw3CRxHpNzEWGml6+KBwKxMz75XubWj6yFL
         BJzwwjyifMLfj0CjJ1VO8757VcIZcRisDU/4wotNmZvGlzpfaMGfZJ4YO9//6XiWFL
         dT1urlHmyb3oHOzBpbY0kWAKX1oC+jcvJ5eB2g6hxqnwj+Xr9F+cRtmuvMnfpMvaTp
         taQK6yHq2bImuu56GK66TFyf9WkU4cJ6dq3a2xpDtLDvR6M8jm4TVjwubRDYYwviGo
         rNslWNAeTU2Qg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7E9F835225EC; Wed,  6 Jan 2021 09:52:59 -0800 (PST)
Date:   Wed, 6 Jan 2021 09:52:59 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, bristot@redhat.com,
        frederic@kernel.org
Subject: Re: lockdep splat in v5.11-rc1 involving console_sem and rq locks
Message-ID: <20210106175259.GM17086@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210105220115.GA27357@paulmck-ThinkPad-P72>
 <X/WITr5JuNvuMH+p@hirez.programming.kicks-ass.net>
 <20210106144621.GJ17086@paulmck-ThinkPad-P72>
 <X/Xa1fwplnZIOm+U@hirez.programming.kicks-ass.net>
 <jhj1reyawv9.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj1reyawv9.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 03:49:46PM +0000, Valentin Schneider wrote:
> On 06/01/21 16:44, Peter Zijlstra wrote:
> > On Wed, Jan 06, 2021 at 06:46:21AM -0800, Paul E. McKenney wrote:
> >> What would break if I made the code dump out a few entries in the
> >> runqueue if the warning triggered?
> >
> > There was a patch around that did that, Valentin might remember where
> > that was.
> 
> There is http://lore.kernel.org/r/jhjpn4bwznx.mognet@arm.com which is a
> dumb inline of print_rq() / print_task().

Thank you both!  I will add this to the next round of testing.

							Thanx, Paul
