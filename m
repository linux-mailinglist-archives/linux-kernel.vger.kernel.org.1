Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E030824CE4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 08:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgHUGyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 02:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgHUGyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 02:54:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2A3C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ikfb1AaX9wkoHBf8/UT2hnG0ErdlIqGr6ZDcicRW4dc=; b=3eUZsyD765F5R7XWGuPE7Sg/DI
        Jm5ry0xfOfdbGcpg4Tn97zwQIftH7rueOvJ5v0SoKfAXA+1r0YDtAKsWjrM31bZiRAqNVSabf81Sv
        K0j2HjBlMBwWvj5QMwh8t2+8WrisbkmMM3AcHGdCTXTuACI7qI+DXs1j0b61ie1V6nEOCncadjb9O
        Qoo7qlERIDrSh/gmwHDa8lkD4IleqHSBP12HkNo6QVIKIWHW8HywmjF2qqwL+CP9oztOnLZsqdIPb
        RgrP5w7w1qj4vUBBjyssugOFTMV1O5EQ/1EF3Yo0qNIeWwIBQW4Y8f8NglhxqtBRRa8n/CGA5liaI
        azN3Zo2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k90wN-0001ZT-SZ; Fri, 21 Aug 2020 06:54:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 801F7302526;
        Fri, 21 Aug 2020 08:54:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 66B362B62898E; Fri, 21 Aug 2020 08:54:13 +0200 (CEST)
Date:   Fri, 21 Aug 2020 08:54:13 +0200
From:   peterz@infradead.org
To:     Marco Elver <elver@google.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, will@kernel.org, npiggin@gmail.com,
        jgross@suse.com, paulmck@kernel.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH 0/9] TRACE_IRQFLAGS wreckage
Message-ID: <20200821065413.GG1362448@hirez.programming.kicks-ass.net>
References: <20200820073031.886217423@infradead.org>
 <20200820103643.1b9abe88@oasis.local.home>
 <20200820145821.GA1362448@hirez.programming.kicks-ass.net>
 <20200820172046.GA177701@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820172046.GA177701@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 07:20:46PM +0200, Marco Elver wrote:
> From 4ec9dd472c978e1eba622fb22bc04e4357f10421 Mon Sep 17 00:00:00 2001
> From: Marco Elver <elver@google.com>
> Date: Thu, 20 Aug 2020 19:06:09 +0200
> Subject: [PATCH] sched: Turn inline into __always_inline due to noinstr use
> 
> is_idle_task() may be used from noinstr functions such as
> irqentry_enter(). Since the compiler is free to not inline regular
> inline functions, switch to using __always_inline.
> 
> Signed-off-by: Marco Elver <elver@google.com>

Fair enough I suppose; didn't that generate an objtool warning on your
build? (of course that requires PARAVIRT=n, I should get back to fixing
that)

> ---
>  include/linux/sched.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 93ecd930efd3..afe01e232935 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1666,7 +1666,7 @@ extern struct task_struct *idle_task(int cpu);
>   *
>   * Return: 1 if @p is an idle task. 0 otherwise.
>   */
> -static inline bool is_idle_task(const struct task_struct *p)
> +static __always_inline bool is_idle_task(const struct task_struct *p)
>  {
>  	return !!(p->flags & PF_IDLE);
>  }
> -- 
> 2.28.0.297.g1956fa8f8d-goog
