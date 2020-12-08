Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9829F2D2877
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgLHKHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727122AbgLHKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:07:54 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E754BC061749
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 02:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/cbg0yWJlkVgkdQRE8gAJUwBms4pTAlYLahKPvCS91M=; b=anEw8/6aKdXJ8H7aopQ/mcvoGi
        VtFEhI9C5lnXYgwasWsNM5tP3WVp7eGbnZbc3banrikySSOtwAmyTl5myrRbIPf60CG5W5WcC57oM
        ONo3mNblKSo/Jb2fkvTKMnZG1pBqITR2yLGAtnRxA/CgYEsOuf563Kx6kwkQBmNHEjtWhRr+wW8XB
        VfHoEnCeLVEfx7RBhJq/Z7Pp7JW0EkEbqMukWC1ZwhyNf4W1TgSMmd4vf92WDUDvPTKjCOLGuI8Jf
        M+92435LMZVCO/xozf4dnAlQtVykwSZY+7jIQSau3btxeMAn7PO1zgG85PjCxUMZQSp41rDGASEcY
        clOK6C4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmZtl-0007bU-BK; Tue, 08 Dec 2020 10:07:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 131E73007CD;
        Tue,  8 Dec 2020 11:07:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0E61200AABB2; Tue,  8 Dec 2020 11:07:04 +0100 (CET)
Date:   Tue, 8 Dec 2020 11:07:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2 5/5] locking/rwsem: Remove reader optimistic spinning
Message-ID: <20201208100704.GU2414@hirez.programming.kicks-ass.net>
References: <20201121041416.12285-1-longman@redhat.com>
 <20201121041416.12285-6-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121041416.12285-6-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 11:14:16PM -0500, Waiman Long wrote:


> @@ -1032,40 +901,16 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, int state, long count)
>  	 *
>  	 * We can take the read lock directly without doing
>  	 * rwsem_optimistic_spin() if the conditions are right.

This comment no longer makes sense..

> -	 * Also wake up other readers if it is the first reader.
>  	 */
> -	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF)) &&
> -	    rwsem_no_spinners(sem)) {
> +	if (!(count & (RWSEM_WRITER_LOCKED | RWSEM_FLAG_HANDOFF))) {
>  		rwsem_set_reader_owned(sem);
>  		lockevent_inc(rwsem_rlock_steal);
> -		if (rcnt == 1)
> -			goto wake_readers;
> -		return sem;
> -	}
>  
> -	/*
> -	 * Save the current read-owner of rwsem, if available, and the
> -	 * reader nonspinnable bit.
> -	 */
> -	waiter.last_rowner = owner;
> -	if (!(waiter.last_rowner & RWSEM_READER_OWNED))
> -		waiter.last_rowner &= RWSEM_RD_NONSPINNABLE;
> -
> -	if (!rwsem_can_spin_on_owner(sem, RWSEM_RD_NONSPINNABLE))
> -		goto queue;
> -
> -	/*
> -	 * Undo read bias from down_read() and do optimistic spinning.
> -	 */
> -	atomic_long_add(-RWSEM_READER_BIAS, &sem->count);
> -	adjustment = 0;
> -	if (rwsem_optimistic_spin(sem, false)) {

since we're removing the optimistic spinning entirely on the read side.

Also, I was looking at skipping patch #4, which mucks with the reader
wakeup logic, and afaict this removal doesn't really depend on it.

Or am I missing something?


