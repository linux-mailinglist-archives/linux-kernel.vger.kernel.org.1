Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57F252031D5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgFVIRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 04:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgFVIRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:17:01 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892A3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WmVFVFHY5o0EBZ78EX79SoVS8h9HKRzadyGKsoFMMO4=; b=vgxyPIHjCi+8II5LMtycwh3Zsi
        wQcXxss+K9r7a1zRjQvM4AWU4Os77WXjhyMNzJglw3wn1p5MEUNurHOrA/APW8agX08miS44fCUYv
        /Rm0+Cy3TCcyPJWK8KdBN6RUnuF8E81pRhyALbgcipR81KF0OU0cku0Omdx/grBUxObxrTTeRWPgw
        7skbw7oszVCun37tpJeOq5NluLIC8SXuapGKxVnC0yfeOJO5aP816tBM4BZKtGmafpNZKez+nmOtw
        vBGwM8ffglUvfie4wN+85URZrC5qfzhN42xYctnZf0o7ao2vb7pgvIlf8YCW4ATD0cC3fify3mT2f
        jIXaJGtg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnHd8-0002xF-C5; Mon, 22 Jun 2020 08:16:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42D24300261;
        Mon, 22 Jun 2020 10:16:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C5D22BF7CC08; Mon, 22 Jun 2020 10:16:35 +0200 (CEST)
Date:   Mon, 22 Jun 2020 10:16:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Biggers <ebiggers@kernel.org>, x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [tip: sched/urgent] sched: Fix RANDSTRUCT build fail
Message-ID: <20200622081635.GC577403@hirez.programming.kicks-ass.net>
References: <159178525684.17951.17825196124597318263.tip-bot2@tip-bot2>
 <202006192008.337CB5212E@keescook>
 <CAHk-=wgj17RR3zetey4fpbOxbC58A=jMt87bQ9QRe4QDnxE46w@mail.gmail.com>
 <20200622081027.GM576888@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622081027.GM576888@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:10:27AM +0200, Peter Zijlstra wrote:

> Instead of relying on BUG_ON() to ensure the various data structures
> line up, use a bunch of horrible unions.

>  struct irq_work {
> +	union {
> +		struct __call_single_node node;
> +		struct {
> +			struct llist_node llnode;
> +			atomic_t flags;
> +		};
> +	};
>  	void (*func)(struct irq_work *);
>  };

>  struct __call_single_data {
> +	union {
> +		struct __call_single_node node;
> +		struct {
> +			struct llist_node llist;
> +			unsigned int flags;
> +		};
> +	};
>  	smp_call_func_t func;
>  	void *info;
>  };

FWIW, I have 2 further patches, one for each of these structures to get
rid of the horrible union. They are somewhat larger and I was planning
to hold on to them for next round, but if you want them now, I can
certainly do that.
