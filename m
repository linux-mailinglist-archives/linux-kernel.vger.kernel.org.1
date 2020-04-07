Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 445DE1A04B8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 04:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgDGCF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 22:05:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36074 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDGCF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:05:28 -0400
Received: by mail-qt1-f193.google.com with SMTP id m33so1601951qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QE9feUnP6i9X/aj/z/7/gJs0TCfrmf+hqNm1oT5H5Wo=;
        b=Ug+nh1/Djrrr/Q9qUloEDJX7nwoQbukp++5BAg8jRhC6bKO5v2srUpBPJ5CSdxM8+y
         DZM3V/FCvDfVTAdln6l0g4IpB2p5Q+zSAwEMPnG4Mpn7Id6AxXESijE8ghTVWJ6YUHrQ
         ldTC1LqkITSR7e14Q2G+OgeqG3MEEF1b1wsaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QE9feUnP6i9X/aj/z/7/gJs0TCfrmf+hqNm1oT5H5Wo=;
        b=EHlHVT0ajTRUX+ZH5dicYQvehLzW4WiHNOGIFDDEl2c0veuCQhykajkrKaa8lqzCLg
         32EPgBRFWlDISSpKrxWCfqXVZc6YTk+xUtH+ty7mH4woRqjwrHmjNE0RSe6bataRINGg
         J7u+tJtX5oUxYgx9fywbpw1rSW8DSEtTWrx8a6RKSq+5K+4YmtIzrx6CtavGJpMj59Wp
         P8sy9P0D00z5KEZ9yVly3jNjq/YWNqQvPG38tqzoPwqqeZO0RSxPYTR/UQaKjz1Ykz6u
         R+vhp7F/xn23k1wgBxIv0uNRqO1ccDwjP6VtGykxz11DpowmsgkPOjBks8Qio+uT0awU
         y/Iw==
X-Gm-Message-State: AGi0PuaXw0SkTghZc5DCiGF6rwVXt6VoKCuZdBTDfDqWQxzqjig86fb9
        XdVjUlkGuFPX5+8Ytnm9/ZE4yA==
X-Google-Smtp-Source: APiQypKtWDj3oedlvF3bwvLFauAg3ZIkbXpPPfDmPdit0eD4VUDvGdBp5v89JmUTbXIWhz19qDHGug==
X-Received: by 2002:aed:37a8:: with SMTP id j37mr213233qtb.272.1586225127531;
        Mon, 06 Apr 2020 19:05:27 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n5sm15879583qkn.4.2020.04.06.19.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 19:05:26 -0700 (PDT)
Date:   Mon, 6 Apr 2020 22:05:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/3] rcu/tree: use more permissive parameters when
 attaching a head
Message-ID: <20200407020525.GA113967@google.com>
References: <20200402123253.10382-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402123253.10382-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:32:51PM +0200, Uladzislau Rezki (Sony) wrote:
> It is documneted that a headless object can be reclaimed from
> might_sleep() context only. Because of that when a head is
> dynamically attached it makes sense to drop the lock and do
> an allocation with much more permissve flags comparing if it
> is done from atomic context.
> 
> That is why use GFP_KERNEL flag plus some extra ones which
> would make an allocation most likely to be succeed. The big
> advantage of doing so is a direct reclaim process.
> 
> Tested such approach on my local tiny system with 145MB of
> ram(the minimum amount the KVM system is capable of booting)
> and 4xCPUs. For stressing the rcuperf module was used. During
> tests with difference combinations i did not observe any hit
> of our last emergency case, when synchronize_rcu() is involved.
> 
> Please note, the "dynamically attaching" path was enabled only,
> apart of that all types of objects were considered as headless
> variant during testing.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Beautifully done, thanks Vlad! I agree with this and the other 2 changes and
I applied it to my rcu/kfree branch for further testing by both of us.

thanks,

 - Joel

> ---
>  kernel/rcu/tree.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6172e6296dd7..24f620a06219 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3148,13 +3148,10 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
>  {
>  	unsigned long *ptr;
>  
> +	/* Try hard to get the memory. */
>  	ptr = kmalloc(sizeof(unsigned long *) +
> -			sizeof(struct rcu_head), GFP_NOWAIT | __GFP_NOWARN);
> -
> -	if (!ptr)
> -		ptr = kmalloc(sizeof(unsigned long *) +
> -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> -
> +		sizeof(struct rcu_head), GFP_KERNEL |
> +			__GFP_ATOMIC | __GFP_HIGH | __GFP_RETRY_MAYFAIL);
>  	if (!ptr)
>  		return NULL;
>  
> @@ -3222,9 +3219,20 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  	if (!success) {
>  		/* Is headless object? */
>  		if (head == NULL) {
> +			/* Drop the lock. */
> +			if (krcp->initialized)
> +				spin_unlock(&krcp->lock);
> +			local_irq_restore(flags);
> +
>  			head = attach_rcu_head_to_object(ptr);
>  			if (head == NULL)
> -				goto unlock_return;
> +				goto inline_return;
> +
> +			/* Take it back. */
> +			local_irq_save(flags);
> +			krcp = this_cpu_ptr(&krc);
> +			if (krcp->initialized)
> +				spin_lock(&krcp->lock);
>  
>  			/*
>  			 * Tag the headless object. Such objects have a back-pointer
> @@ -3263,6 +3271,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
>  		spin_unlock(&krcp->lock);
>  	local_irq_restore(flags);
>  
> +inline_return:
>  	/*
>  	 * High memory pressure, so inline kvfree() after
>  	 * synchronize_rcu(). We can do it from might_sleep()
> -- 
> 2.20.1
> 
