Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85EA2DE2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 13:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgLRMpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 07:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgLRMpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 07:45:16 -0500
Date:   Fri, 18 Dec 2020 21:44:32 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608295476;
        bh=f72NmqWCUcmK5bieddjCnbCo3i4yWZSGAcFJxpcjCL8=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=lOH8I4GQyCHwiHK4N751VPyXBdk3L+xQW352kLOlBs9hYR3OqYdgXN5tiawBBw9W+
         MuUhdqRDF3x+jmwj414y740/tq73mlsTsbPs/4ox5lADyZo6mkLRDE8zBrarSFpIOI
         eyPQNaLbC9p1Ppdr1BNJOiYJlNAA9nhPkmuaBPv450YA19fuex+Ve4rbYxDKGhf4OM
         r3ONGVU3Kuot9fGSbcYl5xEKEl5pXzkArL5A9R38a9Vg9OMdZHt/7SPbN/XqKlvmJt
         3rSYxpp20S0OBwYapIfv1YYFpHt/p7jzrMiIESGsiKbtorLNS4Lssur6iHq/mMHVpQ
         pO3NhrYdJ2wdA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [x86/kprobes]  413d31338f: kernel_BUG_at_mm/vmalloc.c
Message-Id: <20201218214432.b025656de019c64a8f4e2da5@kernel.org>
In-Reply-To: <20201218010221.GA9731@xsang-OptiPlex-9020>
References: <160726389867.3413805.17190350990123597258.stgit@devnote2>
        <20201218010221.GA9731@xsang-OptiPlex-9020>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +
>  static int arch_copy_kprobe(struct kprobe *p)
>  {
>  	struct insn insn;
>  	kprobe_opcode_t buf[MAX_INSN_SIZE];
>  	int len;
>  
> +	memset(&p->ainsn, 0, sizeof(p->ainsn));

Oops, I missed to clear the ainsn.insn here. This must be fixed.

Thanks,

On Fri, 18 Dec 2020 09:02:21 +0800
kernel test robot <oliver.sang@intel.com> wrote:

> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 413d31338fca081133c508bcabc57854765f43df ("[PATCH 1/1] x86/kprobes: Do not decode opcode in resume_execution()")
> url: https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/x86-kprobes-Classify-opcode-while-preparing-kprobe/20201206-221324
> base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git 238c91115cd05c71447ea071624a4c9fe661f970
> 
> in testcase: trinity
> version: trinity-static-i386-x86_64-f93256fb_2019-08-28
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +------------------------------------------+------------+------------+
> |                                          | 238c91115c | 413d31338f |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 8          | 0          |
> | boot_failures                            | 0          | 8          |
> | kernel_BUG_at_mm/vmalloc.c               | 0          | 8          |
> | invalid_opcode:#[##]                     | 0          | 8          |
> | EIP:vmalloc_to_page                      | 0          | 8          |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 8          |
> +------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [    8.468076] kernel BUG at mm/vmalloc.c:364!
> [    8.468257] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [    8.468344] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.9.0-rc7-00002-g413d31338fca08 #2
> [    8.468344] EIP: vmalloc_to_page+0x27/0x107
> [    8.468344] Code: 89 c8 c3 55 89 c2 89 c1 c1 e9 1e 89 e5 57 56 53 53 a1 64 06 cb c1 89 55 f0 8d 1c c8 89 d0 e8 9d ff ff ff 85 c0 8b 55 f0 75 02 <0f> 0b 8b 03 8b 4b 04 89 c6 81 e6 18 0e 00 00 74 02 0f 0b 89 c3 81
> [    8.468344] EAX: 00000000 EBX: c1f6a000 ECX: 00000000 EDX: 00000000
> [    8.468344] ESI: d087bda5 EDI: d087bda5 EBP: d087bce0 ESP: d087bcd0
> [    8.468344] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
> [    8.468344] CR0: 80050033 CR2: 00000000 CR3: 01f6a000 CR4: 000406b0
> [    8.468344] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [    8.468344] DR6: fffe0ff0 DR7: 00000400
> [    8.468344] Call Trace:
> [    8.468344]  __text_poke+0x4c/0x28f
> [    8.468344]  ? insn_get_displacement+0x1b/0xce
> [    8.468344]  ? cmp_ex_sort+0x17/0x17
> [    8.468344]  text_poke+0x35/0x3a
> [    8.468344]  arch_copy_kprobe+0x12b/0x148
> [    8.468344]  arch_prepare_kprobe+0x48/0x6a
> [    8.468344]  register_kprobe+0x27f/0x374
> [    8.468344]  __register_trace_kprobe+0x6e/0x73
> [    8.468344]  register_trace_kprobe+0x140/0x282
> [    8.468344]  ? traceprobe_set_print_fmt+0x40/0x58
> [    8.468344]  trace_kprobe_create+0x33e/0x3c3
> [    8.468344]  ? __kmalloc+0xc1/0xcd
> [    8.468344]  ? argv_split+0x5b/0xb9
> [    8.468344]  ? trace_kprobe_create+0x3c3/0x3c3
> [    8.468344]  create_or_delete_trace_kprobe+0x1b/0x27
> [    8.468344]  trace_run_command+0x48/0x6b
> [    8.468344]  trace_kprobe_run_command+0xf/0x11
> [    8.468344]  dynevent_create+0xb/0xd
> [    8.468344]  kprobe_event_gen_test_init+0x82/0x1e2
> [    8.468344]  ? kprobe_event_cmd_init+0x13/0x13
> [    8.468344]  ? init_trace_printk+0xf/0xf
> [    8.468344]  do_one_initcall+0xaa/0x1d4
> [    8.468344]  ? rdinit_setup+0x21/0x21
> [    8.468344]  ? trace_initcall_level+0x72/0x76
> [    8.468344]  do_initcalls+0xa8/0xc8
> [    8.468344]  kernel_init_freeable+0x94/0xb9
> [    8.468344]  ? rest_init+0xce/0xce
> [    8.468344]  kernel_init+0x8/0xe4
> [    8.468344]  ret_from_fork+0x1c/0x28
> [    8.468344] Modules linked in:
> [    8.476471] ---[ end trace 543d3449d7fd5d3a ]---
> 
> 
> To reproduce:
> 
>         # build kernel
> 	cd linux
> 	cp config-5.9.0-rc7-00002-g413d31338fca08 .config
> 	make HOSTCC=gcc-9 CC=gcc-9 ARCH=i386 olddefconfig prepare modules_prepare bzImage
> 
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Oliver Sang
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
