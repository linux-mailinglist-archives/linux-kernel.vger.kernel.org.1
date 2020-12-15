Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B6B2DB4A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgLOTsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:48:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:45172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728222AbgLOTsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:48:13 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2194622B2C;
        Tue, 15 Dec 2020 19:47:26 +0000 (UTC)
Date:   Tue, 15 Dec 2020 14:47:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: Re: __local_bh_enable_ip() vs lockdep
Message-ID: <20201215144724.40ab7612@gandalf.local.home>
In-Reply-To: <20201215190152.GA22285@osiris>
References: <20201215190152.GA22285@osiris>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 20:01:52 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> Hello,
> 
> the ftrace stack tracer kernel selftest is able to trigger the warning
> below from time to time. This looks like there is an ordering problem
> in __local_bh_enable_ip():
> first there is a call to lockdep_softirqs_on() and afterwards
> preempt_count_sub() is ftraced before it was able to modify
> preempt_count:

Don't run ftrace stack tracer when debugging lockdep. ;-)

  /me runs!

-- Steve

> 
> [ 1016.245418] ------------[ cut here ]------------
> [ 1016.245428] DEBUG_LOCKS_WARN_ON(current->softirqs_enabled)
> [ 1016.245441] WARNING: CPU: 8 PID: 8300 at kernel/locking/lockdep.c:5298 check_flags.part.0+0x196/0x208
> [ 1016.245580] CPU: 8 PID: 8300 Comm: sshd Not tainted 5.11.0-20201215.rc0.git0.d33ce49dca6c.300.fc33.s390x+debug #1
> ...
> [ 1016.245691] Call Trace:
> [ 1016.245698]  [<000000004c1537fa>] check_flags.part.0+0x19a/0x208
> [ 1016.245705] ([<000000004c1537f6>] check_flags.part.0+0x196/0x208)
> [ 1016.245711]  [<000000004cced786>] lock_is_held_type+0x8e/0x1b8
> [ 1016.245716]  [<000000004c172924>] rcu_read_lock_sched_held+0x64/0xb8
> [ 1016.245724]  [<000000004c1b151c>] module_assert_mutex_or_preempt+0x34/0x68
> [ 1016.245730]  [<000000004c1b2e04>] __module_address.part.0+0x2c/0x118
> [ 1016.245735]  [<000000004c1b9dca>] __module_text_address+0x3a/0x90
> [ 1016.245741]  [<000000004c1b9ed4>] is_module_text_address+0x34/0x78
> [ 1016.245748]  [<000000004c0f9a1a>] kernel_text_address+0x5a/0x130
> [ 1016.245752]  [<000000004c0f9b16>] __kernel_text_address+0x26/0x70
> [ 1016.245757]  [<000000004c094038>] unwind_get_return_address+0x40/0x68
> [ 1016.245763]  [<000000004c099dac>] arch_stack_walk+0xac/0xd0
> [ 1016.245768]  [<000000004c18be10>] stack_trace_save+0x50/0x68
> [ 1016.245774]  [<000000004c22d80c>] check_stack+0xc4/0x348
> [ 1016.245780]  [<000000004c22db46>] stack_trace_call+0xb6/0xd0
> [ 1016.245785]  [<000000004cd00082>] ftrace_caller+0x7a/0x7e
> [ 1016.245791]  [<000000004c1081d6>] preempt_count_sub+0x6/0x138 <---
> [ 1016.245795]  [<000000004c0d3d46>] __local_bh_enable_ip+0x13e/0x190 <---
> [ 1016.245811]  [<000003ff8023c34c>] nft_update_chain_stats+0xdc/0x168 [nf_tables]
> [ 1016.245820]  [<000003ff8023c916>] nft_do_chain+0x53e/0x550 [nf_tables]
> [ 1016.245827]  [<000003ff80251974>] nft_do_chain_ipv4+0x6c/0x78 [nf_tables]
> [ 1016.245833]  [<000000004cb0ab00>] nf_hook_slow+0x58/0xf8
> [ 1016.245839]  [<000000004cb1dc24>] nf_hook.constprop.0+0xfc/0x1d0
> [ 1016.245844]  [<000000004cb207b2>] __ip_local_out+0x92/0xe8
> [ 1016.245848]  [<000000004cb20d00>] __ip_queue_xmit+0x1d8/0x640
> [ 1016.245854]  [<000000004cb4578c>] __tcp_transmit_skb+0x3dc/0x770
> [ 1016.245858]  [<000000004cb46e86>] tcp_write_xmit+0x38e/0x758
> [ 1016.245863]  [<000000004cb47298>] __tcp_push_pending_frames+0x48/0x118
> [ 1016.245868]  [<000000004cb2f604>] tcp_sendmsg_locked+0x95c/0xb78
> [ 1016.245872]  [<000000004cb2f864>] tcp_sendmsg+0x44/0x68
> [ 1016.245878]  [<000000004ca30c3c>] sock_sendmsg+0x64/0x78
> [ 1016.245882]  [<000000004ca30cc2>] sock_write_iter+0x72/0x98
> [ 1016.245887]  [<000000004c3dcfda>] new_sync_write+0x10a/0x198
> [ 1016.245891]  [<000000004c3dd6a6>] vfs_write.part.0+0x196/0x290
> [ 1016.245896]  [<000000004c3e0220>] ksys_write+0xb8/0xf8
> [ 1016.245900]  [<000000004ccfd326>] system_call+0xe2/0x29c
> [ 1016.245904] INFO: lockdep is turned off.

