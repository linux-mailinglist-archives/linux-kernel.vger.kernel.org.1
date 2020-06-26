Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D272C20B238
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 15:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFZNMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 09:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgFZNMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:12:19 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36014C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HR+4c9AAqoff1jf49kNj5qLtp8bMDAoCQxcnvw4UhvI=; b=s+hzMbaiLjuMK3/qoVhh685IoS
        /s6/IjdnBub73abmHqD7K1GxMc/K2wCXUNKGpaNp9LVG7ozOTWjIMla0LfBwKXUKYc9S5iqwdEDrk
        qHZezPF+8nOpr6iB5UGAbUfU7SrTUrq0HN7E82YsaNBh/6O3lnSbcWowtrZzMu+NOYhyZGg06hIEr
        MONdk8/MeMeltSNBmouO16g1o9vraT09qpRo7dyPjeTL2vHK4FhQMO/9jTiiIwHB+xnVAOWv7T7il
        ZOcodDnACzYd3aWowVikove9VfKYQihBKOlVqMOORImZqgzCr1V75/Luh4HlpxVxPT4fLFtp7uosd
        IpRBz+AQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joo8y-0005o9-Ew; Fri, 26 Jun 2020 13:11:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B54DF3003E3;
        Fri, 26 Jun 2020 15:11:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A828329CC71D8; Fri, 26 Jun 2020 15:11:45 +0200 (CEST)
Date:   Fri, 26 Jun 2020 15:11:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] init: Align init_task to avoid conflict with MUTEX_FLAGS
Message-ID: <20200626131145.GK4800@hirez.programming.kicks-ass.net>
References: <20200625204410.3168791-1-shorne@gmail.com>
 <20200626111208.GD4817@hirez.programming.kicks-ass.net>
 <20200626114522.GI1401039@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626114522.GI1401039@lianli.shorne-pla.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 08:45:22PM +0900, Stafford Horne wrote:

> I think we can make this unconditional.  The only reason I used the condition is
> because the only architecture that sets CONFIG_ARCH_TASK_STRUCT_ON_STACK is ia64
> which already has 64-bit alignment.
> 
> I can change it to (not incorporating max_t(ARCH_MIN_TASKALIGN) as not sure how):

The only arch that has ARCH_MIN_TASKALIGN larger than L1_CACHE_SIZE is
some daft x86 config and it shouldn't be fatal to them.

So with this:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> diff --git a/init/init_task.c b/init/init_task.c
> index 15089d15010a..ab6173f8e6a8 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -65,6 +65,7 @@ struct task_struct init_task
>  #ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
>         __init_task_data
>  #endif
> +       __aligned(L1_CACHE_BYTES)
>  = {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>         .thread_info    = INIT_THREAD_INFO(init_task),
> 
> -Stafford
