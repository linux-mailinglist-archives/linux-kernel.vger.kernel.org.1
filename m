Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C5B2AB69E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgKILVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgKILVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:21:36 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369C3C0613CF;
        Mon,  9 Nov 2020 03:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=23JvPsCJ8bZTGypus7M+0zut1iK9VvweCbVk0Ig98f8=; b=bQ6jS/sW9qpECD2vEn0Z0bk35I
        jy2A56RXzfv+InB3KOVZ5AxftSOhgBz24VXHMnZNfV3ylx3Yt7eV33Q1nCwChjificIwtmBfi+XTa
        nPTgGdweB2wtibgtPne9/WvUUgvNwLUZHP6/msRJU7Vu49B80Ajr1h2b5XIWDFTJgdk2erGMWFQHh
        HyOfmFBU9Q8sCXp6j77lsWamUspYg41Ruoxxk6Bc2zDv47u7bcaIRoF52A096EG+goReJA4i5n2wn
        PUSe0/XehVsKjg1vBH5LaJwG3gQ67bx2mstnIstbFeStCThTrSuangzmmTK4L85/4WX8Z9cPPZPre
        ImgPsMSw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc5Ep-0005Rb-16; Mon, 09 Nov 2020 11:21:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B51F306099;
        Mon,  9 Nov 2020 12:21:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC2E92B09ACF6; Mon,  9 Nov 2020 12:21:28 +0100 (CET)
Date:   Mon, 9 Nov 2020 12:21:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] futex: Don't enable IRQs unconditionally in
 put_pi_state()
Message-ID: <20201109112128.GF2594@hirez.programming.kicks-ass.net>
References: <20201106085205.GA1159983@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106085205.GA1159983@mwanda>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 11:52:05AM +0300, Dan Carpenter wrote:
> The exit_pi_state_list() function calls put_pi_state() with IRQs
> disabled and is not expecting that IRQs will be enabled inside the
> function.  Use the _irqsave() so that IRQs are restored to the original
> state instead of enabled unconditionally.
> 
> Fixes: 153fbd1226fb ("futex: Fix more put_pi_state() vs. exit_pi_state_list() races")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This is from static analysis and not tested.  I am not very familiar
> with futex code.

It it exceedingly rare if at all possible to trigger this, but yes, your
patch is correct.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> 
>  kernel/futex.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/futex.c b/kernel/futex.c
> index f8614ef4ff31..ca84745713bc 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -788,8 +788,9 @@ static void put_pi_state(struct futex_pi_state *pi_state)
>  	 */
>  	if (pi_state->owner) {
>  		struct task_struct *owner;
> +		unsigned long flags;
>  
> -		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
> +		raw_spin_lock_irqsave(&pi_state->pi_mutex.wait_lock, flags);
>  		owner = pi_state->owner;
>  		if (owner) {
>  			raw_spin_lock(&owner->pi_lock);
> @@ -797,7 +798,7 @@ static void put_pi_state(struct futex_pi_state *pi_state)
>  			raw_spin_unlock(&owner->pi_lock);
>  		}
>  		rt_mutex_proxy_unlock(&pi_state->pi_mutex, owner);
> -		raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
> +		raw_spin_unlock_irqrestore(&pi_state->pi_mutex.wait_lock, flags);
>  	}
>  
>  	if (current->pi_state_cache) {
> -- 
> 2.28.0
> 
