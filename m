Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897F4242281
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 00:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHKW3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 18:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgHKW3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:29:22 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257DD206DC;
        Tue, 11 Aug 2020 22:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597184962;
        bh=822tlIKm9vbmsGGZ1MjxjvGdfOn3MLvDmYXzWXq9CHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FdFOy72dW4BsJMnw79c6FRAVIrHW8aqRZWWTM3HHRUjshu3pEP2iBnWDp8gk+xYaV
         fNOwVYS/hTwH2rtHO5g8vggkb+3F5yMmBZzJPTjIaUv9lmD547F7/psi8CBVBp7iT0
         KtD/o1eYo8kJoeBPfrzg/iwb9/dlRprIK3CeDopA=
Date:   Tue, 11 Aug 2020 15:29:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michel Lespinasse <walken@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched, mm: Optimize current_gfp_context()
Message-Id: <20200811152921.1d43e34ad7aff928c6c1267f@linux-foundation.org>
In-Reply-To: <20200618212936.9776-1-longman@redhat.com>
References: <20200618212936.9776-1-longman@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 17:29:36 -0400 Waiman Long <longman@redhat.com> wrote:

> The current_gfp_context() converts a number of PF_MEMALLOC_* per-process
> flags into the corresponding GFP_* flags for memory allocation. In
> that function, current->flags is accessed 3 times. That may lead to
> duplicated access of the same memory location.
> 
> This is not usually a problem with minimal debug config options on as the
> compiler can optimize away the duplicated memory accesses.  With most
> of the debug config options on, however, that may not be the case.
> For example, the x86-64 object size of the __need_fs_reclaim() in a
> debug kernel that calls current_gfp_context() was 309 bytes. With this
> patch applied, the object size is reduced to 202 bytes. This is a saving
> of 107 bytes and will probably be slightly faster too.
> 
> ...
>
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -181,18 +181,20 @@ static inline bool in_vfork(struct task_struct *tsk)
>   */
>  static inline gfp_t current_gfp_context(gfp_t flags)
>  {
> -	if (unlikely(current->flags &
> +	unsigned int pflags = READ_ONCE(current->flags);

Why use READ_ONCE() here?

> +	if (unlikely(pflags &
>  		     (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_NOCMA))) {
>  		/*
>  		 * NOIO implies both NOIO and NOFS and it is a weaker context
>  		 * so always make sure it makes precedence
>  		 */
> -		if (current->flags & PF_MEMALLOC_NOIO)
> +		if (pflags & PF_MEMALLOC_NOIO)
>  			flags &= ~(__GFP_IO | __GFP_FS);
> -		else if (current->flags & PF_MEMALLOC_NOFS)
> +		else if (pflags & PF_MEMALLOC_NOFS)
>  			flags &= ~__GFP_FS;
>  #ifdef CONFIG_CMA
> -		if (current->flags & PF_MEMALLOC_NOCMA)
> +		if (pflags & PF_MEMALLOC_NOCMA)
>  			flags &= ~__GFP_MOVABLE;
>  #endif
>  	}

