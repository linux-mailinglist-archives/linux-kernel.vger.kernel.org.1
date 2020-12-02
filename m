Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1305D2CBA8A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgLBK1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:27:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgLBK1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:27:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5ABC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 02:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mpFhBJLlltbKw40eF8HiUTe5zh1GYzEdNdTxzNCbtNU=; b=ZImqDItzhXafEGsb970mEPKgWm
        8li8EqzXkQqtqv7Fhmx5I1jDK648SGvzqgBVoTKGGJRPwmeHNrePzX8CMLDBK2wFil86XHrdS6U+V
        NJrgaiswQ5dPbYm7hf0Xeg7pWpN/QdntIhDYQx3oKbO0iBTURRVHFGjCvQ/DKWt57jesS+Xe+IyX1
        +z47muqU5wTlAv7zucLmS4spBIzZRnXuEYkRhrmf0Bd3jQB6i9N16GvF9f3Uyw1eCec9yFyy2gF0S
        qOEPyUYgKjeLLdo7mTtAUKfYt66AjcGsuIDfrbIrHt8gd/n96hcurwoOyrHTJSDIXd4/12DI79RWk
        vgrUU6sg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkPKt-0005jl-Kq; Wed, 02 Dec 2020 10:26:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E08233059DD;
        Wed,  2 Dec 2020 11:26:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 39D0C2227D8EE; Wed,  2 Dec 2020 11:26:09 +0100 (CET)
Date:   Wed, 2 Dec 2020 11:26:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, irogers@google.com,
        gmx@google.com, acme@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au
Subject: Re: [PATCH V2 3/3] perf: Optimize sched_task() in a context switch
Message-ID: <20201202102609.GO3092@hirez.programming.kicks-ass.net>
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
 <20201130193842.10569-3-kan.liang@linux.intel.com>
 <20201201172903.GT3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201172903.GT3040@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 06:29:03PM +0100, Peter Zijlstra wrote:
> +static void context_sched_task(struct perf_cpu_context *cpuctx,
> +			       struct perf_event_context *ctx,
> +			       bool sched_in)
> +{
> +	struct pmu *pmu = ctx->pmu;
> +
> +	if (cpuctx->sched_cb_dir[sched_in] && pmu->sched_task)
> +		pmu->sched_task(ctx, false);
> +}

s/false/sched_in/


