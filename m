Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7345284800
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgJFH75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:59:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFDEC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=weyj1+oVB2sF+RH5dsw1s1tXmXnPwOyJE9YEld1yZag=; b=B0IOu1RR/yddt4XwCdocTUQ1Cz
        5QDOemccGMGKREg1N8rG4xjwZRYdrIcX/9Ztdf/5PC2lgnvFTfTP1Z3434Fshf4VNW5flqP55Sr8N
        1iW+cWLDcnpkjQmcp+gYxOvdFUI24JR0eqlcP5ObHj9xytBjo98TPcj4azlsW5og82P9lV602IjU7
        bR0EZAtv3GfCnKr4Kmv6arnY8f40Qrek2ZlbETOHr9gsEcUt7f0F2+sHL2tuiKyX9vfVVaXSG+0dI
        fdCISJ4i7rBwW5UlbNgFXAAaGzqdn4pIK0/QmzIxTdnU6AOmmNtARlcaAVha7zesxa4KzBx+HcVrl
        n+rgOLDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPhss-0004HY-5g; Tue, 06 Oct 2020 07:59:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29E1F3006D0;
        Tue,  6 Oct 2020 09:59:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0C052026833C; Tue,  6 Oct 2020 09:59:39 +0200 (CEST)
Date:   Tue, 6 Oct 2020 09:59:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201006075939.GL2628@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005150922.458081448@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 04:57:32PM +0200, Peter Zijlstra wrote:
> +static inline struct task_struct *get_push_task(struct rq *rq)
> +{
> +	struct task_struct *p = rq->curr;
> +
> +	lockdep_assert_held(&rq->lock);
> +
> +	if (rq->push_busy)
> +		return NULL;
> +
> +	if (p->nr_cpus_allowed == 1)
> +		return NULL;

This; that means what when we're stuck below a per-cpu thread, we're
toast. There's just nothing much you can do... :/

> +
> +	rq->push_busy = true;
> +	return get_task_struct(p);
> +}
