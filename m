Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13D92B221E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgKMRXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:23:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbgKMRXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:23:40 -0500
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4818B20A8B
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605288233;
        bh=xdI4a+xUuM+3KapunHb9S4q3Py4nYSLtac0fxYZM4bY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CY9yWHCQ+tP+1TIyKTkT3vsqYlDuc3N76uLp7jbeyzS2hgn/EfH5SmdISdyudJacb
         T1nFHYUGIAR4VgWYCGIt5Cj4BSBB6E4Ds/yqhVAcvYOw/HXaJLlHRL3e+W8mVEOL7+
         i4JqdM+h8Y7EL24rfFQvHRY7OkbM/JzHv3fVkuKY=
Received: by mail-wr1-f47.google.com with SMTP id 33so10746790wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:23:53 -0800 (PST)
X-Gm-Message-State: AOAM531FuF/qzng7IoSfl7BH7BZIvEt2mvR4aiZ/I7b7uwyjCu0SOA6q
        6CR7J6UHQXmPQ0HuIvExKsDqyII4nCnyedmgvP4zWA==
X-Google-Smtp-Source: ABdhPJyuLa/IGWBqBEvU6kFuppAO2CbY8dAnGudjaPXm6LAcsHGnz3exUbtUKK8ht+/fwV1HAp3xGb/X8XB1DFuip9A=
X-Received: by 2002:a5d:49ce:: with SMTP id t14mr4669967wrs.75.1605288231563;
 Fri, 13 Nov 2020 09:23:51 -0800 (PST)
MIME-Version: 1.0
References: <20201113125332.GA2611@hirez.programming.kicks-ass.net>
In-Reply-To: <20201113125332.GA2611@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Nov 2020 09:23:39 -0800
X-Gmail-Original-Message-ID: <CALCETrWwwO8f0fjKTxQXu=0U=oMfOPs=Rg76CLOHVNGOk-Fx6Q@mail.gmail.com>
Message-ID: <CALCETrWwwO8f0fjKTxQXu=0U=oMfOPs=Rg76CLOHVNGOk-Fx6Q@mail.gmail.com>
Subject: Re: #PF from NMI
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Paul McKenney <paulmck@kernel.org>, eupm90@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 4:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hi
>
> Eugenio reported
> (https://bugzilla.kernel.org/attachment.cgi?id=293659&action=edit):
>
> [  139.226723] ------------[ cut here ]------------
> [  139.226724] WARNING: CPU: 9 PID: 2290 at kernel/rcu/tree.c:932 __rcu_irq_enter_check_tick+0x84/0xd0
> [  139.226725] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 nft_compat nft_counter nft_chain_nat nf_e
> [  139.226746] CPU: 9 PID: 2290 Comm: perf Tainted: G S                5.10.0-rc2+ #1
> [  139.226746] Hardware name: Dell Inc. PowerEdge R430/0CN7X8, BIOS 2.6.0 10/31/2017
> [  139.226747] RIP: 0010:__rcu_irq_enter_check_tick+0x84/0xd0
> [  139.226747] Code: 75 cc 48 8b 7b 18 e8 4b c9 84 00 80 bb 05 01 00 00 00 74 09 80 bb 06 01 00 00 00 74 11 48 8b 7b 18 c6 07 00 0f 1f 40 00
> [  139.226748] RSP: 0000:ffffbdb38586b8c8 EFLAGS: 00010006
> [  139.226749] RAX: 0000000080110000 RBX: ffff9cdc2f92b9c0 RCX: ffffffff9f600fb7
> [  139.226749] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffbdb38586b938
> [  139.226749] RBP: 000000000000000e R08: 0000000000000000 R09: 0000000000000000
> [  139.226750] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  139.226750] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [  139.226750] FS:  00007fb0c5a628c0(0000) GS:ffff9cdc2f900000(0000) knlGS:0000000000000000
> [  139.226751] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  139.226751] CR2: 000000000000000e CR3: 000000010e0ea001 CR4: 00000000003706a0
> [  139.226752] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  139.226752] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [  139.226752] Call Trace:
> [  139.226753]  irqentry_enter+0x25/0x40
> [  139.226753]  exc_page_fault+0x38/0x4c0
> [  139.226753]  asm_exc_page_fault+0x1e/0x30
> [  139.226753] RIP: 0010:__get_user_nocheck_8+0x6/0x13
> [  139.226754] Code: 01 ca c3 90 0f 01 cb 0f ae e8 0f b7 10 31 c0 0f 01 ca c3 90 0f 01 cb 0f ae e8 8b 10 31 c0 0f 01 ca c3 66 90 0f 01 cb 0f
> [  139.226754] RSP: 0000:ffffbdb38586b9e8 EFLAGS: 00050087
> [  139.226755] RAX: 000000000000000e RBX: ffffbdb38586ba30 RCX: 00007fb0c586f0d2
> [  139.226756] RDX: 0000000000000080 RSI: 000000000000007f RDI: 00000000ffffdff0
> [  139.226756] RBP: ffffbdb38586bf58 R08: 00000000bffffff0 R09: ffffffffa05a0460
> [  139.226756] R10: 00ffffffffffeff0 R11: 00007fffffffeff0 R12: 000000000000000e
> [  139.226757] R13: ffff9cd4daa017c0 R14: 0000000000000000 R15: 000000000000007f
> [  139.226757]  ? kvmclock_cpu_down_prep+0x20/0x20 [kvm]
> [  139.226757]  perf_callchain_user+0xf4/0x280
> [  139.226758]  get_perf_callchain+0x17b/0x1b0
> [  139.226758]  perf_callchain+0x71/0x80
> [  139.226758]  setup_pebs_fixed_sample_data+0x2a8/0x360
> [  139.226759]  intel_pmu_drain_pebs_nhm+0x477/0x5d0
> [  139.226759]  ? get_page_from_freelist+0x117d/0x1390
> [  139.226759]  ? page_counter_cancel+0x1f/0x30
> [  139.226760]  ? page_counter_uncharge+0x1d/0x30
> [  139.226760]  ? drain_stock.isra.54+0x64/0xb0
> [  139.226760]  ? get_page_from_freelist+0x117d/0x1390
> [  139.226761]  handle_pmi_common+0xc3/0x2d0
> [  139.226761]  ? alloc_set_pte+0xd3/0x5e0
> [  139.226761]  ? filemap_map_pages+0x2d2/0x430
> [  139.226762]  ? xfs_filemap_map_pages+0x44/0x60 [xfs]
> [  139.226762]  ? xfs_iunlock+0x86/0xd0 [xfs]
> [  139.226762]  ? handle_mm_fault+0x145b/0x1650
> [  139.226762]  intel_pmu_handle_irq+0xc9/0x1c0
> [  139.226763]  perf_event_nmi_handler+0x24/0x40
> [  139.226763]  nmi_handle+0x55/0x130
> [  139.226763]  default_do_nmi+0x49/0x100
> [  139.226764]  exc_nmi+0x121/0x150
> [  139.226764]  asm_exc_nmi+0x8e/0xd7
> [  139.226764] RIP: 0033:0x7fb0c586f0d2
> [  139.226765] Code: 48 89 44 24 30 48 8b 83 00 03 00 00 48 85 c0 0f 84 d3 00 00 00 48 8b 7c 24 20 8b 8b fc 02 00 00 8b 54 24 38 23 93 f8 08
> [  139.226766] RSP: 002b:00007ffcf13cde60 EFLAGS: 00010246
> [  139.226766] RAX: 00007fb0c309c2b0 RBX: 00007fb0c5a73500 RCX: 0000000000000006
> [  139.226766] RDX: 0000000000000000 RSI: 000000000000000a RDI: 00000000fc2c9fd0
> [  139.226767] RBP: 000000000000000e R08: 00007ffcf13cdf90 R09: 00007fb0c5a8f410
> [  139.226767] R10: 000000000000002b R11: 0000000000000246 R12: 0000000000000000
> [  139.226768] R13: 0000000000000001 R14: 00007fb0c32a1fbc R15: 00007fb0c5a69cd0
>
> Which is a #PF from NMI context, which is perfectly fine. However
> __rcu_irq_enter_check_tick() is triggering WARN.
>
> AFAICT the right thing is to simply remove the warn like so.
>
> ---
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 430ba58d8bfe..9bda92d8b914 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -928,8 +928,8 @@ void __rcu_irq_enter_check_tick(void)
>  {
>         struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
>
> -        // Enabling the tick is unsafe in NMI handlers.
> -       if (WARN_ON_ONCE(in_nmi()))
> +       // if we're here from NMI, there's nothing to do.
> +       if (in_nmi())
>                 return;
>
>         RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),

Reviewed-by: Andy Lutomirski <luto@kernel.org>

with the following caveat that has nothing to do with NMI: the rest of
irqentry_enter() has tracing calls in it.  Does anything prevent
infinite recursion if one of those tracing calls causes a page fault?

--Andy
