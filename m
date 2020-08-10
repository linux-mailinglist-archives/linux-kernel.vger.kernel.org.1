Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFCA2406F8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 15:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgHJNtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 09:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgHJNtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:49:51 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0263DC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zHfLH2pg1OucUn05ZnXEsdKjOpibB6QAf/23JPd8gx8=; b=L5sjTPbBcez16YM9CU6ZatApuG
        MyJ6o+zuEQaLRWikiixj3Bf96THLkt/zNXBiojRaQBSBJHM2hM3woVS2knARsAsBB+mZbX6Qy8InP
        CNACxce0PQb3a3i5k949TLiNBOkrDKmLawK6kkEopahePmtV6L4mEsYqJYbwbp6Ru7MhC7p4kpeaQ
        ue1uVxFU5I4JhYxpa/8EvvwYUT5YWK29LptypMjAzTBfCGYzJBjVMGu18a5UAeQN5DbDTmTslVEnx
        aLjnYETxMmDavK20kO0oT8W/ABS/voGVs/RbN4m0B7rMy8jGatx7eLERyfdWpDxpHEE2WdZj9mKvK
        Q0eDF7PQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k58BJ-00030R-Cp; Mon, 10 Aug 2020 13:49:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C3EE30015A;
        Mon, 10 Aug 2020 15:49:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CCD5A200D415D; Mon, 10 Aug 2020 15:49:38 +0200 (CEST)
Date:   Mon, 10 Aug 2020 15:49:38 +0200
From:   peterz@infradead.org
To:     tglx@linutronix.de, mingo@kernel.org, will@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net
Subject: Re: [RFC][PATCH 2/3] locking,entry: #PF vs TRACE_IRQFLAGS
Message-ID: <20200810134938.GX2674@hirez.programming.kicks-ass.net>
References: <20200807192336.405068898@infradead.org>
 <20200807193018.060388629@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807193018.060388629@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 09:23:38PM +0200, Peter Zijlstra wrote:
> Much of the complexity in irqenter_{enter,exit}() is due to #PF being
> the sole exception that can schedule from kernel context.
> 
> One additional wrinkle with #PF is that it is non-maskable, it can
> happen _anywhere_. Due to this, and the wonders of tracing, we can get
> the 'normal' NMI nesting vs TRACE_IRQFLAGS:
> 
> 	local_irq_disable()
> 	  raw_local_irq_disable();
> 	  trace_hardirqs_off();
> 
> 	local_irq_enable();
> 	  trace_hardirqs_on();
> 	  <#PF>
> 	    trace_hardirqs_off()
> 	    ...
> 	    if (!regs_irqs_disabled(regs)
> 	      trace_hardirqs_on();
> 	  </#PF>
> 	  // WHOOPS -- lockdep thinks IRQs are disabled again!
> 	  raw_local_irqs_enable();
> 
> Rework irqenter_{enter,exit}() to save/restore the software state.

So with #3 v1.1, we can maybe do away with this patch.

So the actual case that triggered the above was:


	raw_local_irq_disable();
	trace_lock_acquire()
	  ... tracing ...
	  <#PF/>

Now, as Marco spotted, DEBUG_LOCKDEP would trigger in this case, because
'... tracing ...' includes rcu_dereference(), and that in turn calls
lock_is_held()/check_flags() and goes *boom*, because we did
raw_local_irq_disable().

Now, the new patch, moves the tracepoint out from under the
raw_local_irq_disable() too, and given RCU-lockdep complains in this
situation, I'm thinking we're actually free of such cases... fingers
crossed.


