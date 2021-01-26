Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48EBE3045F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbhAZSG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390695AbhAZJ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:26:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80575C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ec8P0rHXEe05U3/gVRuWruSadVZsPnqiXTNPGBrzGOw=; b=E9RMINfvTFuBVKvDLSdCHC4Z20
        7STus/fXr7SOMhuapu1XbqrS6DqyvNMZVQMUfh6CyF2Ud1kZWOAvc+VQtEBEbZovNXWHTPuk6m79Y
        ag/B2Gpc9jns6KnNJ1dshXWQhgBlLwxqbwWM77ffhii3FaNmQz79HqlE1oOatPJEDzlfli1yPEe8p
        xewNgSFdM8DibRPwu2FUC6exMJE/serdPIbtA2tOpQcLZygocsC9jWqRDaVkIpYyQaX8ac4sdqxNi
        TYNEylwDQgKkxJ2tvvgnSiZPrXnpHJSxQtAdU/iYXLhjv2p/8XiudZragfCrEbzOPdBgUsZWd74uc
        wFWwuR+A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l4KZv-005MC3-71; Tue, 26 Jan 2021 09:24:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9CA703019CE;
        Tue, 26 Jan 2021 10:24:02 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E98420297EDB; Tue, 26 Jan 2021 10:24:02 +0100 (CET)
Date:   Tue, 26 Jan 2021 10:24:02 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>,
        rostedt@goodmis.org, jbaron@akamai.com, ardb@kernel.org
Subject: Re: [RFC PATCH 6/8] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Message-ID: <YA/fsnfGy4jgOaCB@hirez.programming.kicks-ass.net>
References: <20210118141223.123667-1-frederic@kernel.org>
 <20210118141223.123667-7-frederic@kernel.org>
 <20210122165226.GD16371@worktop.programming.kicks-ass.net>
 <20210125234039.mb5fvhyzzoujajhm@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125234039.mb5fvhyzzoujajhm@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 05:40:39PM -0600, Josh Poimboeuf wrote:
> On Fri, Jan 22, 2021 at 05:52:26PM +0100, Peter Zijlstra wrote:
> > On Mon, Jan 18, 2021 at 03:12:21PM +0100, Frederic Weisbecker wrote:
> > > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > > +DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func());
> > > +EXPORT_STATIC_CALL(preempt_schedule);
> > > +#endif
> > 
> > > +#ifdef CONFIG_PREEMPT_DYNAMIC
> > > +DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func());
> > > +EXPORT_STATIC_CALL(preempt_schedule_notrace);
> > > +#endif
> > 
> > So one of the things I hates most of this is that is allows 'random'
> > modules to hijack the preemption by rewriting these callsites. Once you
> > export the key, we've lost.
> > 
> > I've tried a number of things, but this is the only one I could come up
> > with that actually stands a chance against malicious modules (vbox and
> > the like).
> > 
> > It's somewhat elaborate, but afaict it actually works.
> 
> What about this hopefully abuse-proof idea which has less code, less
> complexity, no registration, no new data structures, no COC defiance.
> 
> Add a writable-by-modules bit to the key struct, which can be set when
> you define the key.  Enforce it in __static_call_update() with a call to
> __builtin_return_address(0).  WARN when the caller's text isn't in the
> kernel proper and the flag isn't set.
> 
> Hm?

What stops a module from clearing said bit? It has the key pointer.
