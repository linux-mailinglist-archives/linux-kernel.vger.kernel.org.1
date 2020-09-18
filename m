Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3917726F47E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 05:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIRCBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 22:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgIRCB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 22:01:27 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02313208DB;
        Fri, 18 Sep 2020 02:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600394486;
        bh=omgJdr9rYdiavda9kyztPIqnnlNbQrY7gB2yWZZ7+D0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IfFGJD8zOP6+jXdWAKpMi5YaZWJGQkD3DgAhYluCpFd+VA/0F5qX8BnsSu0jjqZGd
         U5ZM5TwTgsc6dfNEwgRO/pR/ks8yJD4P1QgQv8yppq1uowm0z1Ry5qnIfDBJDZBQyx
         wKefZbLbVfTS/AAWplcPHRrpZGRJrwkuB3QD2IBk=
Date:   Fri, 18 Sep 2020 11:01:22 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] kprobes: Do not disarm disabled ftrace kprobe
Message-Id: <20200918110122.b77b5658bd0ae1e28f03f5af@kernel.org>
In-Reply-To: <20200917191754.0a2f8e46@gandalf.local.home>
References: <20200917191754.0a2f8e46@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Ah, this seems to fix same issue which I sent.

https://lkml.kernel.org/r/159888672694.1411785.5987998076694782591.stgit@devnote2

Could you confirm it?

Thank you,

On Thu, 17 Sep 2020 19:17:54 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> Only disable a ftrace probe if it is enabled, otherwise:
> 
> The following triggers a warning:
> 
>   # modprobe trace_printk
>   # echo "p:kprobes1/event1 trace_printk:trace_printk_irq_work" > /sys/kernel/tracing/kprobe_events
>   # rmmod trace_printk
> 
>  ------------[ cut here ]------------
>  Failed to disarm kprobe-ftrace at trace_printk_irq_work+0x0/0x76 [trace_printk] (-2)
>  WARNING: CPU: 5 PID: 4852 at kernel/kprobes.c:1100 __disarm_kprobe_ftrace.isra.0+0x78/0xa0
>  Modules linked in: trace_printk(-) [..] [last unloaded: trace_printk]
>  CPU: 5 PID: 4852 Comm: rmmod Tainted: G        W         5.9.0-rc4-test+ #506
>  Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
>  RIP: 0010:__disarm_kprobe_ftrace.isra.0+0x78/0xa0
>  Code: 8b 03 eb cb 80 3d 5d 95 58 01 00 75 de 48 8b 75 00 89 c2 89 44 24 04 48 c7 c7 38 e3 33 8b c6 05 43 95 58 01 01 e8 c8 1d ef ff <0f> 0b 8b 44 24 04 eb b9 89 c6 48 c7 c7 08 e3 33 8b 89 44 24 04 e8
>  RSP: 0018:ffff971ce04b7e38 EFLAGS: 00010282
>  RAX: 0000000000000000 RBX: ffffffff8c900b30 RCX: 0000000000000000
>  RDX: 0000000000000001 RSI: ffffffff8a16c5af RDI: ffffffff8a16c5af
>  RBP: ffff971cf2722440 R08: 0000000000000001 R09: 0000000000000001
>  R10: 0000000000000000 R11: 0000000000000046 R12: ffffffff8b7b33a0
>  R13: ffffffff8c901eb0 R14: 0000000000000000 R15: 0000000000000000
>  FS:  00007f4fe349b740(0000) GS:ffff971d5ab40000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000055d07b0148b8 CR3: 00000000b76cc006 CR4: 00000000001706e0
>  Call Trace:
>   kprobes_module_callback+0x1b3/0x3c0
>   notifier_call_chain+0x47/0x70
>   blocking_notifier_call_chain+0x43/0x60
>   __x64_sys_delete_module+0x161/0x2a0
>   do_syscall_64+0x33/0x40
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>  RIP: 0033:0x7f4fe35cb00b
>  Code: 73 01 c3 48 8b 0d 7d fe 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d fe 0b 00 f7 d8 64 89 01 48
>  RSP: 002b:00007ffe820f9888 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
>  RAX: ffffffffffffffda RBX: 000055d07b00a800 RCX: 00007f4fe35cb00b
>  RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055d07b00a868
>  RBP: 00007ffe820f98e8 R08: 0000000000000000 R09: 0000000000000000
>  R10: 00007f4fe363eac0 R11: 0000000000000206 R12: 00007ffe820f9ab0
>  R13: 00007ffe820fb223 R14: 000055d07b00a2a0 R15: 000055d07b00a800
>  irq event stamp: 7463
>  hardirqs last  enabled at (7489): [<ffffffff8a1ab4cd>] __tick_nohz_task_switch+0xad/0xc0
>  hardirqs last disabled at (7510): [<ffffffff8a1ab4d4>] __tick_nohz_task_switch+0xb4/0xc0
>  softirqs last  enabled at (7530): [<ffffffff8ae003b4>] __do_softirq+0x3b4/0x501
>  softirqs last disabled at (7545): [<ffffffff8ac01072>] asm_call_on_stack+0x12/0x20
>  ---[ end trace 71f3303cdebb63e3 ]---
> 
> As well as the following two ftrace selftests fail:
> 
>  test.d/kprobe/kprobe_module.tc
>  test.d/kprobe/kretprobe_args.tc
> 
> This is because we are trying to remove a probe that is not enabled or
> registered with ftrace, but exists in the kprobe tables.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler")
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 287b263c9cb9..7557883771f9 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1088,6 +1088,9 @@ static int __disarm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
>  {
>  	int ret = 0;
>  
> +	if (kprobe_disabled(p))
> +		return ret;
> +
>  	if (*cnt == 1) {
>  		ret = unregister_ftrace_function(ops);
>  		if (WARN(ret < 0, "Failed to unregister kprobe-ftrace (%d)\n", ret))


-- 
Masami Hiramatsu <mhiramat@kernel.org>
