Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43E22F3434
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391689AbhALPeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731029AbhALPeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:34:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E38C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IidWsm3K3031BfekPBZ8zSws05SHAizn385jOXLdDos=; b=gKOt7w1et6e7bA+pKojtARVyP6
        hweCd32OtX8RoWxTxp1YxPOn8tV6Gj+d7QJRXl77g4s+bY+CUJu0jH32atLDDGpzU6IPiVifWWmyh
        +kkOrWxig6X3B9filmPFSQc1zm28wZhwO7YQGorHEqBfMgqqu+Dh6BNWe7ta+sxZHJfyGvRp2ffaZ
        wE9KUZ1qfOO3bDU2YwTtGLomJFMzzrAgIQndAikWRcQbizPafTmHBmawaIdu9HrkQRu0mWKcHsx0e
        Oz8bXP9ROOHoBpfUkq6tQJ+AnOSfG9BpH22Trx8XP7wgnT+KXPKqBBb/gWhp1N6vbjByFOLVI8HQr
        zRNX1yLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1kzLep-004xsL-Cc; Tue, 12 Jan 2021 15:32:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1BD13006E0;
        Tue, 12 Jan 2021 16:32:30 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4CC0210710A6; Tue, 12 Jan 2021 16:32:30 +0100 (CET)
Date:   Tue, 12 Jan 2021 16:32:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Will Deacon <will@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] perf/x86: Only expose userspace rdpmc for events on
 current CPU
Message-ID: <X/3BDlQxTCYd2HJs@hirez.programming.kicks-ass.net>
References: <20210108000136.1556129-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108000136.1556129-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 05:01:36PM -0700, Rob Herring wrote:
> Userspace access using rdpmc only makes sense if the event is valid for
> the current CPU. However, cap_user_rdpmc is currently set no matter which
> CPU the event is associated with. The result is userspace reading another
> CPU's event thinks it can use rdpmc to read the counter. In doing so, the
> wrong counter will be read.

Don't do that then?

> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index a88c94d65693..6e6d4c1d03ca 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2490,7 +2490,8 @@ void arch_perf_update_userpage(struct perf_event *event,
>  	userpg->cap_user_time = 0;
>  	userpg->cap_user_time_zero = 0;
>  	userpg->cap_user_rdpmc =
> -		!!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
> +		!!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED) &&
> +		(event->oncpu == smp_processor_id());
>  	userpg->pmc_width = x86_pmu.cntval_bits;
>  
>  	if (!using_native_sched_clock() || !sched_clock_stable())

Isn't that a nop? That is, from the few sites I checked, we're always
calling this on the event's CPU.
