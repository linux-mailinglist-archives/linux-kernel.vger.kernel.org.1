Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556DE285C61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 12:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgJGKGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 06:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbgJGKGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 06:06:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C51EC061755;
        Wed,  7 Oct 2020 03:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I5Etf9qEHTemyyx/AreDTAuwCMLmW2nSmju3sgma8Yk=; b=oDbrnmP6AupW3Ru7dXb9IEq/lg
        XSj9zp5GcMzkL3uMSR87apqdlU/zYGzAmUNfF+ESRKast3WvX8AJycao/XC1B/QaWIHQAH/6lF2zn
        yzHTIfQYnMUyht1oeOh3shHtiJaQeeLCqqXaRP0KaUiplQgP0R5hRYMeUGOmFCVkpnZ1+h+NApqCj
        BSgHXWGfv1Uxgz2oufRl/Cfq/Q+2uuP6qM2GZ58nOTBLdCklwOz5LaND/RrZrS7kPRoHwAd9Au9/7
        VyS5qWhiqA8XakUjQlUIfdBgLEX68lgqgI7gdDtOXVfLo73tZYCbiQ/Syj8JjA/fSquZzWw2mdUs6
        RDYNdz9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQ6KY-00085z-Qk; Wed, 07 Oct 2020 10:05:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A77293006D0;
        Wed,  7 Oct 2020 12:05:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B50F2BA0366F; Wed,  7 Oct 2020 12:05:51 +0200 (CEST)
Date:   Wed, 7 Oct 2020 12:05:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     hca@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: Re: [PATCH] s390/idle: Fix suspicious RCU usage
Message-ID: <20201007100551.GC2628@hirez.programming.kicks-ass.net>
References: <20200908133031.GT1362448@hirez.programming.kicks-ass.net>
 <yt9dimbm79qi.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yt9dimbm79qi.fsf@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 09:53:25AM +0200, Sven Schnelle wrote:
> Hi Peter,
> 
> peterz@infradead.org writes:
> 
> > After commit eb1f00237aca ("lockdep,trace: Expose tracepoints") the
> > lock tracepoints are visible to lockdep and RCU-lockdep is finding a
> > bunch more RCU violations that were previously hidden.
> >
> > Switch the idle->seqcount over to using raw_write_*() to avoid the
> > lockdep annotation and thus the lock tracepoints.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > [..]
> 
> I'm still seeing the splat below on s390 when irq tracing is enabled:

Damn... :/

This one is tricky, trouble seems to be that arch_cpu_idle() is defined
to enable interrupts (no doubt because ot x86 :/), but we call it before
rcu_exit_idle().

What a mess... let me rummage around the various archs to see what makes
most sense here.
