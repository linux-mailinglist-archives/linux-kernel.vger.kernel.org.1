Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACC6281AAC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbgJBSN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBSN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:13:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E07DC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xhQlY0JkE8VSgRmAWRCxmMRj374+etsiscJ83Nt4YS4=; b=Zw39RRLMQl/FOkrgq8hH60JbY8
        EdMSnjWmbLbHts5ChvV6ARnzgTXo77B+srQSxZOjRhzNK+hlqK9U1yyszUXQ4JyblNmWO1qEKDmob
        VFrylyY1kiqsndysxUQgenxv9p7fnIFk8ewItm4+fuy9HvMvNJ0DMJpnKtDcojNrsGDOZJFLDONI4
        ahsqMUg70jlzChgpn6NhmNduuGxqMR4bVSnWad6G4WorNXGVyCXYuPRR26bbZL9EvyX+zVqO0uT/e
        HLNTlRcbRQCcBv0sb4VYO2vTQvqGg2P1o1jNu1m4FLLdQtkOlW7vGtgU5mgCHTq0VAB1+c39EhY5x
        ycbd61pw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOPYV-0002zX-MI; Fri, 02 Oct 2020 18:13:20 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AC76D980DD5; Fri,  2 Oct 2020 20:13:13 +0200 (CEST)
Date:   Fri, 2 Oct 2020 20:13:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [WARNING] kernel/rcu/tree.c:1058 rcu_irq_enter+0x15/0x20
Message-ID: <20201002181313.GM29142@worktop.programming.kicks-ass.net>
References: <20200917131647.2b55ebb1@gandalf.local.home>
 <20200930181323.GF2628@hirez.programming.kicks-ass.net>
 <20201002135644.7903d0e5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002135644.7903d0e5@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 01:56:44PM -0400, Steven Rostedt wrote:
> On Wed, 30 Sep 2020 20:13:23 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Blergh, IIRC there's header hell that way. The sane fix is killing off
> > that trace_*_rcuidle() disease.
> > 
> > But I think this will also cure it.
> 
> I guess you still don't build modules ;-). I had to add a
> EXPORT_SYMBOL(lockdep_recursion) to get it to build, and then move the

Correct, my regular configs are all without modules.

> checks within the irq disabling to get rid of the using cpu pointers within
> preemptable code warnings

Ah, I think I lost a s/__this_cpu_read/raw_cpu_read/ somewhere. The
thing is, if we're preemptible/migratable it will be 0 on both CPUs and
it doesn't matter which 0 we read. If it is !0, IRQs will be disabled
and we can't get migrated.

Anyway, let me go write a Changelog to go with it.
