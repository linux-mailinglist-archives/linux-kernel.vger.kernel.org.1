Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B22286339
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgJGQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 12:08:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F8AC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NBDR8z9Krw/0Dr4RVbqC3cKm4wMq2dtVQF736GkrtRE=; b=G2QqLtu3hLukWPl/dLwS8JP3n3
        4/diavCcKbTcqEj3KbLkZXI34jL6fBzer3mb5UcZbPmQPCx1lhgzsLOO5F9MdopKywaO5JDZ8KUh7
        EyVlr28FFBBs0ZNuSQhZLsxczLq4AFuYeejKMwtRRXSYYpRZ6RxYL8y5P0+hX4DtgGZdrmMw1OEA7
        W+q1G/MirlbgOz21ldnuR5a6YWKy/3qukT23h9e9SlB6s3toSABq+soeEL8d3pdFIfo+NnZ+8XhTo
        0WCV/EwfzU5WrPCrJ4QgDBklkb+RKkHm8aK191zPxx1iduAX+g26YcnnwvzA2+e/S5TXXJfgfhBjW
        nf09mOGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQBzK-0004bF-J9; Wed, 07 Oct 2020 16:08:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 25B99300B22;
        Wed,  7 Oct 2020 18:08:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09A8224C0D72F; Wed,  7 Oct 2020 18:08:20 +0200 (CEST)
Date:   Wed, 7 Oct 2020 18:08:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v3)
Message-ID: <20201007160820.GK2628@hirez.programming.kicks-ass.net>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
 <20200924172508.8724-3-mathieu.desnoyers@efficios.com>
 <20201007150704.GH2628@hirez.programming.kicks-ass.net>
 <1286784649.11153.1602085170586.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1286784649.11153.1602085170586.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:39:30AM -0400, Mathieu Desnoyers wrote:
> Moving the membarrier_switch_mm to cover kthread cases was to ensure (2), but if we
> add a p->mm NULL check in the global expedited iteration, I think we would be OK
> leaving the stale runqueue's membarrier state while in lazy tlb state.
> 
> As far as (1) is concerned, I think your idea would work, because as you say we will
> have the proper barriers in kthread use/unuse mm.
> 
> I just wonder whether having this stale membarrier state for lazy tlb is warranted
> performance-wise, as it adds complexity: the rq membarrier state will therefore not be
> relevant when we are in lazy tlb mode.
> 
> Thoughts ?

Well, the way I got here was that I considered the membarrier state
update tied to switch_mm(), and in that regard my proposal is a
simplification.


