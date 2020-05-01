Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEAB01C2111
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 01:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgEAXEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 19:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAXEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 19:04:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1A32208DB;
        Fri,  1 May 2020 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588374239;
        bh=xBoygdR4zUjiy0NTuKVFFxyj1Jciu3Ihiif7h+sn0oY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Sg+1YFkfMs3uF6hAzELiHbFynWZkgOZIRfW/jBUbTcf1dL/ixEjKvetsjWncyl43B
         /1tXn5KIPi5IR4gquqPvVc0ZtXBaDTwaBLPaH/voYNU8iE3fI1oSF0cELuGol0EPjL
         A+cVRiwZa5guNDhdpy3ywICIbvELEoeutd6BgJ6g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AC4BF3522B72; Fri,  1 May 2020 16:03:59 -0700 (PDT)
Date:   Fri, 1 May 2020 16:03:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 21/24] rcu/tiny: move kvfree_call_rcu() out of header
Message-ID: <20200501230359.GH7560@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-22-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428205903.61704-22-urezki@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 10:59:00PM +0200, Uladzislau Rezki (Sony) wrote:
> Move inlined kvfree_call_rcu() function out of the
> header file. This step is a preparation for head-less
> support.
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/rcutiny.h | 6 +-----
>  kernel/rcu/tiny.c       | 6 ++++++
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
> index 0c6315c4a0fe..7eb66909ae1b 100644
> --- a/include/linux/rcutiny.h
> +++ b/include/linux/rcutiny.h
> @@ -34,11 +34,7 @@ static inline void synchronize_rcu_expedited(void)
>  	synchronize_rcu();
>  }
>  
> -static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> -{
> -	call_rcu(head, func);
> -}
> -
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
>  void rcu_qs(void);
>  
>  static inline void rcu_softirq_qs(void)
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index aa897c3f2e92..508c82faa45c 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -177,6 +177,12 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  }
>  EXPORT_SYMBOL_GPL(call_rcu);
>  
> +void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> +{
> +	call_rcu(head, func);
> +}
> +EXPORT_SYMBOL_GPL(kvfree_call_rcu);

This increases the size of Tiny RCU.  Plus in Tiny RCU, the overhead of
synchronize_rcu() is exactly zero.  So why not make the single-argument
kvfree_call_rcu() just unconditionally do synchronize_rcu() followed by
kvfree() or whatever?  That should go just fine into the header file.

							Thanx, Paul

>  void __init rcu_init(void)
>  {
>  	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
> -- 
> 2.20.1
> 
