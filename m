Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642612D760F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 13:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405975AbgLKMw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 07:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406012AbgLKMwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 07:52:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F43C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 04:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AtrqjaBhwhhm+g6TOXOtlBu/O/X4VKdXfAX1UBzn9+4=; b=r42Qrr0gdwEaZUG11FH7PyquBw
        181t6QHqYSsF8uQiCJZsKPT6iyz/91GMYs/dHf3SBp3+udnqMU9qa3G5C4cWepM0eCRP9R+Xn8XoH
        kYHOtodat/J8eItF/ol2AKc2LvRRTMrQ9WGdLyKeaSXBbkHLLasCQcCplOJCRMA/nkeYkTw2+eNOe
        J4DsXNHXlvSrhiPBW6IDpKRblJcEzlnwl5fkzfWJ3WsfXEGycbwsKRMSHvE3HN7F5NctKocnQfNok
        Xq8LLry+v4yLD/2OWAXx+89vtAJoyZnskstw9vZXUOGG4sAsMr3F03fwT8oZe7ay3fWfuq5EwQqXP
        Zpw4GDDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knht1-0002a4-FW; Fri, 11 Dec 2020 12:51:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB4923007CD;
        Fri, 11 Dec 2020 13:51:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F92C200EC4EA; Fri, 11 Dec 2020 13:51:01 +0100 (CET)
Date:   Fri, 11 Dec 2020 13:51:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH 2/2] workqueue: Fix affinity of kworkers attached during
 late hotplug
Message-ID: <20201211125101.GX2414@hirez.programming.kicks-ass.net>
References: <20201210163830.21514-1-valentin.schneider@arm.com>
 <20201210163830.21514-3-valentin.schneider@arm.com>
 <20201211113920.GA75974@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211113920.GA75974@e120877-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 11:39:21AM +0000, Vincent Donnefort wrote:
> On Thu, Dec 10, 2020 at 04:38:30PM +0000, Valentin Schneider wrote:
> > +	if (pool->flags & POOL_DISASSOCIATED) {
> >  		worker->flags |= WORKER_UNBOUND;
> > +		set_cpus_allowed_ptr(worker->task, cpu_active_mask);
> > +	} else {
> > +		/*
> > +		 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> > +		 * online CPUs. It'll be re-applied when any of the CPUs come up.
> > +		 */
> 
> Does this comment still stand ? IIUC, we should always be in the
> POOL_DISASSOCIATED case if the CPU from cpumask is offline. Unless a
> pool->attrs->cpumask can have several CPUs. In that case maybe we should check
> for the cpu_active_mask here too ?

IIUC it can be a numa mask, and would still be valid in that case.

> > +		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> > +	}
