Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9356A294AF6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441633AbgJUKAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387526AbgJUKAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:00:05 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CA3C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=71Xlt+zEhHuV8q7O6Pf+oaz3XSY1+RGX4VdJ9eBhlUk=; b=yUUf2uI7cd9Gk41H3tW69Hqp1Y
        j7awMbSC6GbcPG67QpMKrinqsVgMr0URafOSPpIrgO/lF11l2RZI2uny+nD/Xb6H7sCGebYIQ37S/
        dxxNLMF/NaGZGy0OGgCoTZQAH7iNb5pxqX2bgtOnQM8DJVRXuVJja7cBty01XFBaa3+MhHtQmC56+
        8OIyz3/0We7rdfu/ocR+UyGPyIv+vFYjojimnS/CBoGcY37OJDwzeY9+T7OmPA7u6MhcK7PHZEOZI
        /TC5cEjRprkSqSzKlMT+Bz1MU6YZvn0AnifUGUMDqHolaxPXn8kA0cljsnGyeyJDrHNj36jK1f7CC
        iFvULn1g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVAuQ-0002QS-RC; Wed, 21 Oct 2020 09:59:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 53A1B304D28;
        Wed, 21 Oct 2020 11:59:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 409CC203CC49C; Wed, 21 Oct 2020 11:59:51 +0200 (CEST)
Date:   Wed, 21 Oct 2020 11:59:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xi Wang <xii@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v2 1/1] sched: watchdog: Touch kernel watchdog with sched
 count
Message-ID: <20201021095951.GB2628@hirez.programming.kicks-ass.net>
References: <20201020205704.1741543-1-xii@google.com>
 <20201020205704.1741543-2-xii@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020205704.1741543-2-xii@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 01:57:04PM -0700, Xi Wang wrote:
> The main purpose of kernel watchdog is to test whether scheduler can
> still schedule tasks on a cpu. In order to reduce latency / jitter
> from periodically invoking watchdog reset in thread context, we can
> simply test if pick_next_task can run. This is done by forcing resched
> and checking rq->sched_count.

Whitespace exists for a reason, use more of it. Also, the above isn't
actually accurate anymore and carried over from the previous
implementation.

> Compared to actually resetting watchdog
> from cpu stop / migration threads, we lose coverage on: a migration
> thread actually get picked and we actually context switch to the
> migration thread. These steps are unlikely to silently fail. The
> change would provide nearly the same level of protection with less
> overhead.
> 
> With this patch we can still switch back to the old method with the
> boot option watchdog_touch_with_thread. However code for the old
> method can be completely removed in the future.

I'd suggest removing all the #ifdef and config muck. Either its a good
idea or it's not.
