Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F62E98FA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbhADPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbhADPjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:39:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8ABC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GMHVu2Yo3JicVvPIGq1d2qVQDfyOOOp6irhThspKv6I=; b=AHSYoRpe0/gg+nd/1ArLM4x6rc
        q1YooVjkAK0JxmDV7UHPyERl95sXpeE74wdnZqhu5mTIm4z0dS3C3uGMpFvwwk0Et9/YPGl2wLjlk
        gkyOzREYQwULChRB0PGzn50HxHLO8F/TyES8T4d2f4MeaOJCZgD1LnpIFEahfwJyxrmKYzAocQpA9
        eNk6Mbeviznm0eNZkCuGowcDMuJxOx2HejmPkjW0wXuxlOIY6+mPsMZcvr2ZCi4c207wR+YUgLFaW
        TnP0kdBU94c3KE6JscQ58ZKP4QnSOtpeQOex1MndJQ2sixLdMn9pt37Wmhmj+WMAg5kpx+d61wZ42
        KvBPDTyQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwRwM-0008Qs-4F; Mon, 04 Jan 2021 15:38:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BE66300446;
        Mon,  4 Jan 2021 16:38:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6813F2072C989; Mon,  4 Jan 2021 16:38:36 +0100 (CET)
Date:   Mon, 4 Jan 2021 16:38:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Paul McKenney <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH] locking/lockdep: Use local_irq_save() with call_rcu()
Message-ID: <20210104153836.GS3021@hirez.programming.kicks-ass.net>
References: <20201222225553.15642-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222225553.15642-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 05:55:53PM -0500, Waiman Long wrote:
> The following lockdep splat was hit:
> 
>  [  560.638354] WARNING: CPU: 79 PID: 27458 at kernel/rcu/tree_plugin.h:1749 call_rcu+0x6dc/0xf00
>     :
>  [  560.647761] RIP: 0010:call_rcu+0x6dc/0xf00
>  [  560.647763] Code: 0f 8f 29 04 00 00 e8 93 da 1c 00 48 8b 3c 24 57 9d 0f 1f 44 00 00 e9 19 fa ff ff 65 8b 05 38 83 c4 49 85 c0 0f 84 cd fb ff ff <0f> 0b e9 c6 fb ff ff e8 b8 45 51 00 4c 89 f2 48 b8 00 00 00 00 00
>  [  560.647764] RSP: 0018:ff11001050097b58 EFLAGS: 00010002
>  [  560.647766] RAX: 0000000000000001 RBX: ffffffffbb1f3360 RCX: 0000000000000001
>  [  560.647766] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffffb99bac9c
>  [  560.647767] RBP: 1fe220020a012f73 R08: 000000010004005c R09: dffffc0000000000
>  [  560.647768] R10: dffffc0000000000 R11: 0000000000000003 R12: ff1100105b7f70e1
>  [  560.647769] R13: ffffffffb635d8a0 R14: ff1100105b7f72d8 R15: ff1100105b7f7040
>  [  560.647770] FS:  00007fd9b3437080(0000) GS:ff1100105b600000(0000) knlGS:0000000000000000
>  [  560.647771] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  [  560.647772] CR2: 00007fd9b30112bc CR3: 000000105e898006 CR4: 0000000000761ee0
>  [  560.647773] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  [  560.647773] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  [  560.647774] PKRU: 55555554
>  [  560.647774] Call Trace:
>  [  560.647778]  ? invoke_rcu_core+0x180/0x180
>  [  560.647782]  ? __is_module_percpu_address+0xed/0x440
>  [  560.647787]  lockdep_unregister_key+0x2ab/0x5b0
>  [  560.647791]  destroy_workqueue+0x40b/0x610
>  [  560.647862]  xlog_dealloc_log+0x216/0x2b0 [xfs]
>     :
> 
> This splat is caused by the fact that lockdep_unregister_key() uses
> raw_local_irq_save() which doesn't update the hardirqs_enabled
> percpu flag.  The call_rcu() function, however, will call
> lockdep_assert_irqs_disabled() to check the hardirqs_enabled flag which
> remained set in this case.
> 
> Fix this problem by using local_irq_save()/local_irq_restore() pairs
> whenever call_rcu() is being called.

I'm not sure I much like all this,.. :/

> I think raw_local_irq_save() function can be used if no external
> function is being called except maybe printk() as it means another
> lockdep problem exists.

The reason lockdep is using raw_local_irq_save() is to avoid calling
into itself again, notably local_irq_restore() will end up in
mark_held_locks().

> Fixes: a0b0fd53e1e67 ("locking/lockdep: Free lock classes that are no longer in use")

Seems dubious, as the lockdep_assert_irqs_disabled() that triggered was
added after that patch.

I'm thinking another solution would be to increment the lockdep
recursion count before calling RCU, because then we'll fail
__lockdep_enabled and the assertion gets killed. Hmm?
