Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3477C233271
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 14:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgG3Mxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 08:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3Mxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:53:50 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350CEC0619D4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:53:50 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s16so20178975qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Axn2UqhWLSVFHKSnfRxdouhha5NVgiK5lnLse6I8u/A=;
        b=qKj3QG0jwvFT0NZqDejQIs9lBvfAq1rwCAK66yjilxPi02Gftmljq9/TtWuJSUrTdf
         0A5FsV1qzVsnazzVipjEF8aL3obfFIwsE6upFp4Gpec60UDOSzb1IsgyZZ46ujTxIn9o
         jDVf3LcgHaggfl5lPv0biDPFrN9viSMQtusPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Axn2UqhWLSVFHKSnfRxdouhha5NVgiK5lnLse6I8u/A=;
        b=FFs7q5amLApWhcYnrXeBewX11izp+twXwigKmfhbPZHn0O6iSO7yn3ltgk8fiik+5y
         qqY6dGY6yKAMBctJv0DhNrP5GyRIkHQbC/Ul67mdp4OX9KPIzjzjNqRFXhaQyRK6KgZU
         E2jWV7qcrbDToLUIJl43GIv09TJul+2wIg+v84H3BcuMS1HseKpV8lpc8us8IhkdXI4j
         JoaxMohIMIJ1Q2Gd4+ofLrXfWUGv992L6CFOa1wl4fGhHunH8zIn6REEt5Burc/FsFl2
         yQGO+n3p3truKfRQBOCieLF68x/wBvCWavbbgLuU98X3gjqGM1bsRj+7v2SgEB6+Gb3D
         tLRQ==
X-Gm-Message-State: AOAM5318T+HDIpL/OetKymll/NmSc23RIaVYeM8Bge35p/ZgNojz+caW
        6Iifa4pSy2NbhvZfi14Kqq4hgA==
X-Google-Smtp-Source: ABdhPJwbJddY2ae4n72jMCi/8IovQDNd2woE1dqvSEGMExUQGBjQpyx1XNeAtFII7RIAYjVw1ykbwQ==
X-Received: by 2002:ac8:7741:: with SMTP id g1mr2701917qtu.28.1596113629333;
        Thu, 30 Jul 2020 05:53:49 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id 205sm4166584qkn.104.2020.07.30.05.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 05:53:48 -0700 (PDT)
Date:   Thu, 30 Jul 2020 08:53:48 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH v2 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200730125348.GA2074029@google.com>
References: <20200727211012.30948-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727211012.30948-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:10:12PM +0200, Uladzislau Rezki (Sony) wrote:
> If the kernel is built with CONFIG_PROVE_RAW_LOCK_NESTING
> option, the lockedp will complain about violation of the
> nesting rules:
> 
> <snip>
> [   28.060389] =============================
> [   28.060389] [ BUG: Invalid wait context ]
> [   28.060389] 5.8.0-rc3-rcu #211 Tainted: G            E
> [   28.060389] -----------------------------
> [   28.060390] vmalloc_test/0/523 is trying to lock:
> [   28.060390] ffff96df7ffe0228 (&zone->lock){-.-.}-{3:3}, at: get_page_from_freelist+0xcf0/0x16d0
> [   28.060391] other info that might help us debug this:
> [   28.060391] context-{5:5}
> [   28.060392] 2 locks held by vmalloc_test/0/523:
> [   28.060392]  #0: ffffffffc06750d0 (prepare_for_test_rwsem){++++}-{4:4}, at: test_func+0x76/0x240 [test_vmalloc]
> [   28.060393]  #1: ffff96df5fa1d390 (krc.lock){..-.}-{2:2}, at: kvfree_call_rcu+0x5c/0x230
> [   28.060395] stack backtrace:
> [   28.060395] CPU: 0 PID: 523 Comm: vmalloc_test/0 Tainted: G            E     5.8.0-rc3-rcu #211
> [   28.060395] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [   28.060396] Call Trace:
> [   28.060397]  dump_stack+0x96/0xd0
> [   28.060397]  __lock_acquire.cold.65+0x166/0x2d7
> [   28.060398]  ? find_held_lock+0x2d/0x90
> [   28.060399]  lock_acquire+0xad/0x370
> [   28.060400]  ? get_page_from_freelist+0xcf0/0x16d0
> [   28.060401]  ? mark_held_locks+0x48/0x70
> [   28.060402]  _raw_spin_lock+0x25/0x30
> [   28.060403]  ? get_page_from_freelist+0xcf0/0x16d0
> [   28.060404]  get_page_from_freelist+0xcf0/0x16d0
> [   28.060405]  ? __lock_acquire+0x3ee/0x1b90
> [   28.060407]  __alloc_pages_nodemask+0x16a/0x3a0
> [   28.060408]  __get_free_pages+0xd/0x30
> [   28.060409]  kvfree_call_rcu+0x18a/0x230
> <snip>
> 
> Internally the kfree_rcu() uses raw_spinlock_t whereas the
> page allocator internally deals with spinlock_t to access
> to its zones.
> 
> In order to prevent such vialation that is in question we
> can drop the internal raw_spinlock_t before entering to
> the page allocaor.
> 
> Short changelog (v1 -> v2):
>     - rework the commit message;
>     - rework the patch making it smaller;
>     - add more comments.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  kernel/rcu/tree.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 21c2fa5bd8c3..2de112404121 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3287,6 +3287,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  		return false;
>  
>  	lockdep_assert_held(&krcp->lock);
> +	lockdep_assert_irqs_disabled();
> +
>  	idx = !!is_vmalloc_addr(ptr);
>  
>  	/* Check if a new block is required. */
> @@ -3306,6 +3308,29 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  			if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  				return false;
>  
> +			/*
> +			 * If built with CONFIG_PROVE_RAW_LOCK_NESTING option,
> +			 * the lockedp will complain about violation of the
> +			 * nesting rules. It does the raw_spinlock vs. spinlock
> +			 * nesting checks.
> +			 *
> +			 * That is why we drop the raw lock. Please note IRQs are
> +			 * still disabled it guarantees that the "current" stays
> +			 * on the same CPU later on when the raw lock is taken
> +			 * back.
> +			 *
> +			 * It is important because if the page allocator is invoked
> +			 * in fully preemptible context, it can be that we get a page
> +			 * but end up on another CPU. That another CPU might not need
> +			 * a page because of having some extra spots in its internal
> +			 * array for pointer collecting. Staying on same CPU eliminates
> +			 * described issue.
> +			 *
> +			 * Dropping the lock also reduces the critical section by
> +			 * the time taken by the page allocator to obtain a page.
> +			 */
> +			raw_spin_unlock(&krcp->lock);
> +
>  			/*
>  			 * NOTE: For one argument of kvfree_rcu() we can
>  			 * drop the lock and get the page in sleepable
> @@ -3315,6 +3340,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  			 */
>  			bnode = (struct kvfree_rcu_bulk_data *)
>  				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +
> +			raw_spin_lock(&krcp->lock);

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


>  		}
>  
>  		/* Switch to emergency path. */
> -- 
> 2.20.1
> 
