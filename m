Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BBA2C9EC4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgLAKHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgLAKG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:06:59 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3C7C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3VOeL6ahUmr9+G09zhe+extBNQY5Umcstc5a99TkNTs=; b=M5Ia40PTfyeZ3O3jPpLod+nkyJ
        TZpjQzzbnQtEo1mA0bCAz8D/kQDT23MiC2ajp9ud2vELf33PlIHaQ/dQSrHanWRXnO1YrGmkzZCys
        5OMDTw9LUfPMLra73kb+dsUsykGdJjalT2KEfJtOYm1Kxn3EPISFXkAYtcat9BVL/FCHumqgQ8w+k
        t6JiV8UcCjuFvTMqN7CCxReI/uSxWr/OCFZwKiEMy2ZQWQfVSJuC1eTYsjFAJaPH3fmoayzneI55y
        kgwFErSakMWVGQyiun6anh9Z9gKfCzoScZL1J1PwYbnXcuyJ4tyN7jO1G1PzkKggKD1vHmkw5rCXg
        lfWjBKxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk2Xx-0003ek-5M; Tue, 01 Dec 2020 10:06:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4ABB302753;
        Tue,  1 Dec 2020 11:06:04 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B0B702BDDA85F; Tue,  1 Dec 2020 11:06:04 +0100 (CET)
Date:   Tue, 1 Dec 2020 11:06:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/3] membarrier: Add an actual barrier before
 rseq_preempt()
Message-ID: <20201201100604.GT2414@hirez.programming.kicks-ass.net>
References: <cover.1606758530.git.luto@kernel.org>
 <c67b85690f9cb42d1e92db30e19c78e872bdd0e4.1606758530.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c67b85690f9cb42d1e92db30e19c78e872bdd0e4.1606758530.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 09:50:34AM -0800, Andy Lutomirski wrote:
> It seems to be that most RSEQ membarrier users will expect any
> stores done before the membarrier() syscall to be visible to the
> target task(s).  While this is extremely likely to be true in
> practice, nothing actually guarantees it by a strict reading of the
> x86 manuals.  Rather than providing this guarantee by accident and
> potentially causing a problem down the road, just add an explicit
> barrier.

A very long time ago; when Jens introduced smp_call_function(), we had
this discussion. At the time Linus said that receiving an interrupt had
better be ordering, and if it is not, then it's up to the architecture
to handle that before it gets into the common code.

  https://lkml.kernel.org/r/alpine.LFD.2.00.0902180744520.21686@localhost.localdomain

Maybe we want to revisit this now, but there might be a fair amount of
code relying on all this by now.

Documenting it better might help.

> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  kernel/sched/membarrier.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index e23e74d52db5..7d98ef5d3bcd 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -40,6 +40,14 @@ static void ipi_mb(void *info)
>  
>  static void ipi_rseq(void *info)
>  {
> +	/*
> +	 * Ensure that all stores done by the calling thread are visible
> +	 * to the current task before the current task resumes.  We could
> +	 * probably optimize this away on most architectures, but by the
> +	 * time we've already sent an IPI, the cost of the extra smp_mb()
> +	 * is negligible.
> +	 */
> +	smp_mb();
>  	rseq_preempt(current);
>  }

So I think this really isn't right.
