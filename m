Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 060022BAC01
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgKTOgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgKTOgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:36:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D874C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 06:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uW9m6X0sGYeo9TrzobhIhL9x1TKruwQVFq+Eh06u0tA=; b=W4yn0IxUZsKUDIR1fIpUUpORoD
        QIbaWkcuozDl/RkQEYXIcI2krHWqi+f1ow28sZTRplIqoN3q2mZ3RFAUPFfTbFTFCE+o9djseuJzT
        CvZ29cPQ0xaW59P98HCcq06fR4mbFDw756HEneo0CyBPVuiMfdN4zJOv0/kazId7uxHq/tfawA1VL
        TCcC/B3+5Gcz4OhRA2m4r3sG8uJaFI+fH66aSqCrWCwl2ZJK1jdmN5xIqgBQ8ZPNMlx7spbensnPQ
        GmccJqBEuuP4dtIKoaZo6d0bS5eotI8RGdRDtsj3olAdQfpjxoZ6imTags3iIBO4WQlsyoKZd3wX2
        z5RQJ+aw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg7WU-00070s-V9; Fri, 20 Nov 2020 14:36:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4A787307697;
        Fri, 20 Nov 2020 15:36:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3B707201B4C4C; Fri, 20 Nov 2020 15:36:24 +0100 (CET)
Date:   Fri, 20 Nov 2020 15:36:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 3/5] locking/rwsem: Enable reader optimistic lock stealing
Message-ID: <20201120143624.GD3040@hirez.programming.kicks-ass.net>
References: <20201118030429.23017-1-longman@redhat.com>
 <20201118030429.23017-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118030429.23017-4-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 10:04:27PM -0500, Waiman Long wrote:
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index ee374ae061c3..930dd4af3639 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -957,6 +957,12 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>  	}
>  	return false;
>  }
> +
> +static inline bool osq_is_empty(struct rw_semaphore *sem)
> +{
> +	return !osq_is_locked(&sem->osq);
> +}
> +
>  #else
>  static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem,
>  					   unsigned long nonspinnable)
> @@ -977,6 +983,10 @@ static inline bool rwsem_reader_phase_trylock(struct rw_semaphore *sem,
>  	return false;
>  }
>  
> +static inline bool osq_is_empty(sem)
> +{
> +	return false;
> +}

Hurph, the naming seems to suggest this ought to be in osq_lock.h, but
it really is part of rwsem, it captures the lack of osq member for this
configuration.

How about: rwsem_no_spinners() instead ?

>  static inline int
>  rwsem_spin_on_owner(struct rw_semaphore *sem, unsigned long nonspinnable)
>  {
> @@ -1007,6 +1017,22 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
>  	   !(count & RWSEM_WRITER_LOCKED))
>  		goto queue;
>  
> +	/*
> +	 * Reader optimistic lock stealing
> +	 *
> +	 * We can take the read lock directly without doing
> +	 * rwsem_optimistic_spin() if the conditions are right.
> +	 * Also wake up other readers if it is the first reader.
> +	 */
> +	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF)) &&
> +	    osq_is_empty(sem)) {
> +		rwsem_set_reader_owned(sem);
> +		lockevent_inc(rwsem_rlock_steal);
> +		if (rcnt == 1)
> +			goto wake_readers;
> +		return sem;
> +	}

AFAICT this saves at least 3 atomic ops; how common is this case
(you did add a counter but forgot to mention this).
