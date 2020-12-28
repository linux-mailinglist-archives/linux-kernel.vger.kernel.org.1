Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536DA2E6574
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390230AbgL1N36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:29:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390132AbgL1N3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:29:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C384322AAD;
        Mon, 28 Dec 2020 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609162131;
        bh=QcOoA9D9ThsvL4uxQqbflIfCi98+/vXgTdIczfXKWsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ducxyJuw9SIgbZ8Zl3VdvaksykK+bELoH+yJOWKwm27rRXUavIReqq1kznzgkDrEe
         T14zTMPO/7vWkIVWMNXjeUT6P0k5MHeP2ZYXdRML6rf+V1cxeO5xwxC0OkX0km5cM1
         8zw5odk7Zt9Xu9CNb05Rxcd63RnLkmOYCa5md2i8HsuhL89isPrD7gFLl11NUJvOAb
         YpY7VdiODLLZUzoFnWbRtbWoaHlTFhTySFI+k9CkWhxbd85ijzOklT7EjCQvTOGG8f
         el9h8Osn7KAl9wVDMozG5lLgGJNYGeisC3/v/XviMcvSiHUHACgJgWRR8aJfD7+2C5
         GfpKKgwQFBvAg==
Date:   Mon, 28 Dec 2020 14:28:48 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     chenshiyan <chenshiyan@linux.alibaba.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1] nohz: exit nohz idle before invoking softirq
Message-ID: <20201228132848.GA10119@lothringen>
References: <1609127268-40179-1-git-send-email-chenshiyan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609127268-40179-1-git-send-email-chenshiyan@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 11:47:48AM +0800, chenshiyan wrote:
> From: "shiyan.csy" <shiyan.csy@alibaba-inc.com>
> 
> exit nohz idle before invoking softirq, or it maymiss
> some ticks during softirq.
> 
> Signed-off-by: Shiyan Chen <chenshiyan@linux.alibaba.com>
> ---
>  kernel/softirq.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 9d71046..59bd6fe 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -404,6 +404,10 @@ static inline void tick_irq_exit(void)
>  		if (!in_irq())
>  			tick_nohz_irq_exit();
>  	}
> +
> +	/* need to exit nohz idle if there's a softirq */
> +	if (in_serving_softirq() || local_softirq_pending())
> +		tick_nohz_idle_exit();
>  #endif
>  }
>  
> @@ -416,10 +420,11 @@ static inline void __irq_exit_rcu(void)
>  #endif
>  	account_hardirq_exit(current);
>  	preempt_count_sub(HARDIRQ_OFFSET);
> -	if (!in_interrupt() && local_softirq_pending())
> -		invoke_softirq();
>  
> +	/* must call before invoke_softirq */
>  	tick_irq_exit();
> +	if (!in_interrupt() && local_softirq_pending())
> +		invoke_softirq();

You can't reverse the order here because the softirqs may update
the next tick expiry. And that needs to be taken into account by
tick_nohz_full_update_tick().

But what issue are you trying to solve exactly?

Thanks.

>  }
>  
>  /**
> -- 
> 1.8.3.1
> 
