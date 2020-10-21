Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F18A1294B20
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409763AbgJUKNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409686AbgJUKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:13:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCBEC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tFpjcc9cdWKp1cBRbTamz/gcMJfKJyza4tq2Ct5YEII=; b=ZAHP+jPYWdLqMCmcoTSmmpHMlk
        69ebxKBv4qSbYUsqtdedLadBjL3syv31k5rpsCExXEAXEbi0iG82v+U+U3749CM8CxoVUHXboZ+Jj
        ETes5SvzgLpCryYWrX+JEpCJOmgdxCQ7qgZSooOexiPbvjT5l+Vw0wb9Ho4HT+PTfjZpsvcus8AUz
        V5I2rQsIOKj5XzLGrHKpWIfgc0Na7fvsl2Tidlrbulf2e17VG3FxaYwpiA+/oTl3MM3Tnt83XDCqk
        pcI4Vp7z15qZtvdC/bplE0zjcF3WyPE3ZffE4j94TaqyAeALiXpx3OmLwSzDPz8LOl2Kha5LQ0o8I
        BwfYRdMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVB77-0004EZ-C5; Wed, 21 Oct 2020 10:13:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7A593035D4;
        Wed, 21 Oct 2020 12:12:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4535203CC49B; Wed, 21 Oct 2020 12:12:57 +0200 (CEST)
Date:   Wed, 21 Oct 2020 12:12:57 +0200
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
Message-ID: <20201021101257.GC2628@hirez.programming.kicks-ass.net>
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

> +	if (watchdog_touch_with_sched) {
> +		/* Trigger reschedule for the next round */
> +		set_tsk_need_resched(current);
> +		set_preempt_need_resched();

Blergh.. that's gross. This relies on this being in IRQ context and
either: PREEMPT=y *OR* this always being from userspace. Otherwise
there's no guarantee the return-from-interrupt will actually schedule.

> +		/* sched_count increase in __schedule is taken as watchdog touched */
> +		if (sched_get_count(smp_processor_id()) -
> +		    __this_cpu_read(watchdog_sched_prev)) {
> +			__touch_watchdog();
> +			__this_cpu_write(soft_watchdog_warn, false);
> +			return HRTIMER_RESTART;
> +		}
> +	}
> +
>  	/* check for a softlockup
>  	 * This is done by making sure a high priority task is
>  	 * being scheduled.  The task touches the watchdog to
> -- 
> 2.29.0.rc1.297.gfa9743e501-goog
> 
