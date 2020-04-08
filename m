Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6979E1A27F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 19:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgDHR1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 13:27:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57544 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgDHR1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 13:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yfk+hYQHUvVW/PrkrZrfMM7rbzjh5C9tuDBr7oGr+7k=; b=l6qFbTUb4kaR/SXlW9WT8Nq+W7
        YMx/Vr7QH7HeWQam0yY5SBFH7WVrZTKBXE2XUOXOkA5P8LU4zCxq3OknX8mZ3026K47rPS6o+Xc9u
        eP7bUwxU8OAT8sjdFbuWz4ctOWl3iaCQkgqvV0235f1g09at/dLWn1ew5fxrYT1eyfMPckbZWYM1k
        cEmmajq0YR2aIijtGfA3kNYUkQwEhH1Vg/1ujITwgDGBcXjEl9LVmnaRcnnznfjWlKZdIS+t/IMjY
        oEUHpSw3YTX8WyxKwKKNrEEIWsX4xbhQshtk23HCzciNRYHoL+ebAUAgbWwyjJEd9f1xVGZEDfWQ2
        GhgVJSbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMEU3-0006e2-0d; Wed, 08 Apr 2020 17:27:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1CBB6304DB2;
        Wed,  8 Apr 2020 19:27:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0F3A02BB0C016; Wed,  8 Apr 2020 19:27:23 +0200 (CEST)
Date:   Wed, 8 Apr 2020 19:27:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot+3be1a33f04dc782e9fd5@syzkaller.appspotmail.com,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/gup: Let __get_user_pages_locked() return -EINTR for
 fatal signal
Message-ID: <20200408172723.GR20730@hirez.programming.kicks-ass.net>
References: <20200408155924.107722-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408155924.107722-1-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 11:59:24AM -0400, Peter Xu wrote:
> From: Hillf Danton <hdanton@sina.com>
> 
> __get_user_pages_locked() will return 0 instead of -EINTR after commit
> 4426e945df588 which added extra code to allow gup detect fatal signal
> faster.  Restore that behavior.
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
> Reported-by: syzbot+3be1a33f04dc782e9fd5@syzkaller.appspotmail.com
> Signed-off-by: Hillf Danton <hdanton@sina.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> PS. Patch verified with syzbot.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/gup.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index afce0bc47e70..6076df8e04a4 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1326,8 +1326,11 @@ static __always_inline long __get_user_pages_locked(struct task_struct *tsk,
>  		 * start trying again otherwise it can loop forever.
>  		 */
>  
> -		if (fatal_signal_pending(current))
> +		if (fatal_signal_pending(current)) {
> +			if (!pages_done)
> +				pages_done = -EINTR;

Why -EINTR here and -ERESTARTSYS at the other site?

>  			break;
> +		}
>  
>  		ret = down_read_killable(&mm->mmap_sem);
>  		if (ret) {
> -- 
> 2.24.1
> 
