Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367BA2FDA07
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392770AbhATTt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392735AbhATTqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 14:46:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6152C061757;
        Wed, 20 Jan 2021 11:45:56 -0800 (PST)
Date:   Wed, 20 Jan 2021 20:45:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611171955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqCWqoEMB8rBTV6QB2UOBYY60bN7ea+2m2DiSZd98qs=;
        b=JUwCUy0xmHNg5xHwL57Sn/Iv/mpCd9DgqXu98VymoerM2i8Sil3kbwwT2JMo3ji6D+JlLn
        XcoWo9vWkRIhiqJIwqoShDb5MRuvm0eHkfKLDou+qQE28bBc1+OIQuO7Vt85k2UmMG+cVm
        PGpOTvQj6D0h1UqrXTt6BlKNkuE7MwpaYYtIK8HGDr7sihLv4tfY+/nKXPTUTNpAZXXHYc
        vYF0qfv9hmz1jSyWHfGAtL8nclSCzAmAKIx9f8CrLjFua/r7kmpD0hJWDPJdbvxZSnO6nA
        Z3XWbI7xEEFBUn3QVtiuVNSVtxfmKFNXczljUkRyXeDvEhoWSIHL6OF9GxVuSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611171955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AqCWqoEMB8rBTV6QB2UOBYY60bN7ea+2m2DiSZd98qs=;
        b=WuIFVzrcsoMLJHP184Dv9FVREOZ8iwbXkCrSIOaFrZUWk0TQFZp5SPZijwfC39dD/450l4
        TSmQzGEqlENOycBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 3/3] kvfree_rcu: use migrate_disable/enable()
Message-ID: <20210120194554.34dby47iipmyplts@linutronix.de>
References: <20210120162148.1973-1-urezki@gmail.com>
 <20210120162148.1973-3-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120162148.1973-3-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-20 17:21:48 [+0100], Uladzislau Rezki (Sony) wrote:
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3489,10 +3489,12 @@ add_ptr_to_bulk_krc_lock(struct kfree_rcu_cpu **krcp,
>  			(*krcp)->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
>  		bnode = get_cached_bnode(*krcp);
>  		if (!bnode && can_alloc) {
> +			migrate_disable();
>  			krc_this_cpu_unlock(*krcp, *flags);

Why is krc_this_cpu_unlock() defined as
| static inline void
| krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
| {
|         raw_spin_unlock(&krcp->lock);
|         local_irq_restore(flags);
| }

instead of raw_spin_unlock_irqrestore()?
Should something with the locked section trigger a scheduling event by
setting TIF_NEED_RESCHED then there will be no scheduling event on
unlock. It will be delayed until a later "random" preempt_enable().

raw_spin_unlock_irqrestore() will reschedule if the flag is set,
local_irq_restore() will not.

Sebastian
