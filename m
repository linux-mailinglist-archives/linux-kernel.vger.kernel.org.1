Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C236B27D298
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgI2PTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:19:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgI2PTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:19:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69586207C4;
        Tue, 29 Sep 2020 15:19:05 +0000 (UTC)
Date:   Tue, 29 Sep 2020 11:19:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul McKenney <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, kim.phillips@amd.com
Subject: Re: [PATCH] rcu,ftrace: Fix ftrace recursion
Message-ID: <20200929111903.3e3e8c23@gandalf.local.home>
In-Reply-To: <20200929144953.GP2628@hirez.programming.kicks-ass.net>
References: <20200929113340.GN2628@hirez.programming.kicks-ass.net>
        <20200929103620.06762622@gandalf.local.home>
        <20200929144953.GP2628@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Sep 2020 16:49:53 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Sep 29, 2020 at 10:36:20AM -0400, Steven Rostedt wrote:
> 
> > > +notrace bool rcu_is_watching(void)
> > >  {
> > >  	bool ret;
> > >    
> > 
> > I think the patch I suggested is more suitable.  
> 
> Both, with only your patch we'd still take the pointless mcount call,
> which is then pure overhead.

Yep, and I stated the same thing to Paul ;-)

-- Steve
