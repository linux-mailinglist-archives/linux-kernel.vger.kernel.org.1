Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064E12214C3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgGOS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 14:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgGOS4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:56:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D78C061755;
        Wed, 15 Jul 2020 11:56:31 -0700 (PDT)
Date:   Wed, 15 Jul 2020 20:56:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594839390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PN8gG1ug5BCAvCUnGhwhg5gYQ43BA/zafzatUzWINU=;
        b=R4D+AiV2imCWssvgqXOuVrfKHCQtMW+CVuWoK3NtD2qZklOSLot8laIhJ9mJeLlGyf0uax
        yzX6CyIiRxUMJ6rjtf8109vdayCECBU56t5ZlQ2nJfYq5HivepxGvBG1xJ5w5FGnL2IltR
        D5MSBBbDlceV8dQRmru3wnT18irOKyEi/OU/ZptBkF/uu+EpJkYE5Kae6k80rfNUnYnVwo
        ln41llnDzcrNIagkKDtPklwBwqXQmrYFGJMMAe5gbXuom/pxIWxHJxWObWa/kgmJdAJL/Q
        MRvuTDvfhWZ3B5MpEI1rrkP6y735RUNe3Io1T4u9TjYFDG9k/bs3WN86F0wAsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594839390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PN8gG1ug5BCAvCUnGhwhg5gYQ43BA/zafzatUzWINU=;
        b=BYgsGz19jrlreZ3rVkXyiR3JGReye/jbdQZdcxicBlFNJqUSI7TCoFuncbKXVcW9rG55m/
        Fs4+kWRGKkBNRVBw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, "Paul E . McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 1/1] rcu/tree: Drop the lock before entering to page
 allocator
Message-ID: <20200715185628.7b4k3o5efp4gnbla@linutronix.de>
References: <20200715183537.4010-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200715183537.4010-1-urezki@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-15 20:35:37 [+0200], Uladzislau Rezki (Sony) wrote:
> @@ -3306,6 +3307,9 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
>  			if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  				return false;
>  
> +			preempt_disable();
> +			krc_this_cpu_unlock(*krcp, *flags);

Now you enter memory allocator with disabled preemption. This isn't any
better but we don't have a warning for this yet.
What happened to the part where I asked for a spinlock_t?

> +
>  			/*
>  			 * NOTE: For one argument of kvfree_rcu() we can
>  			 * drop the lock and get the page in sleepable

Sebastian
