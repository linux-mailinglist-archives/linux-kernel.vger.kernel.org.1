Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38826953B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgINTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:00:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgINTAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:00:53 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C053206B2;
        Mon, 14 Sep 2020 19:00:51 +0000 (UTC)
Date:   Mon, 14 Sep 2020 15:00:49 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joerg Vehlow <lkml@jv-coder.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>, dave@stgolabs.net
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in
 interrupt context
Message-ID: <20200914150049.309e985c@gandalf.local.home>
In-Reply-To: <20200907114140.GQ2674@hirez.programming.kicks-ass.net>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
        <20200528084614.0c949e8d@gandalf.local.home>
        <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
        <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
        <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
        <20200821110848.6c3183d1@oasis.local.home>
        <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
        <20200821170334.73b52fdd@oasis.local.home>
        <20200822123252.GQ1362448@hirez.programming.kicks-ass.net>
        <20200822194928.54ee4cb5@oasis.local.home>
        <20200907114140.GQ2674@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 13:41:40 +0200
peterz@infradead.org wrote:

> > I may have once known the rationale behind all this, but it's been a
> > long time since I worked on the PI code, and it's out of my cache.  

Now I'm trying to cache all this in from a long PTO ;-)

> 
> I suffer much the same problem.
> 
> So cenceptually there's the problem that idle must always be runnable,
> and the moment you boost it, it becomes subject to a different
> scheduling class.
> 
> Imagine for example what happens when we boost it to RT and then have it
> be subject to throttling. What are we going to run when the idle task
> is no longer elegible to run.
> 
> (it might all work out by accident, but ISTR we had a whole bunch of fun
> in the earlier days of RT due to things like that)

I'm thinking if a mutex_trylock() happens in an interrupt context, which I
believe is the only way idle could trigger it, it could not be throttled if
boosted, because it's in interrupt context. And it would have to release
the mutex before leaving interrupt context putting it back to the idle
state before throttling could take effect.

Thus, I'm still not convinced that mutex_trylock() is still bad in interrupt
context yet. At least not from what I can tell.

-- Steve
