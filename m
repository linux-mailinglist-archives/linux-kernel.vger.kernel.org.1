Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F16252F41
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 15:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbgHZNDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 09:03:34 -0400
Received: from mga11.intel.com ([192.55.52.93]:58717 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgHZNDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:03:32 -0400
IronPort-SDR: ldbRKTFT8cx94CiaAGay96V0daLphAi4irkOhXS6ZzXvLbjlhbM8pJS/T8ZpewKglvVYvazjk6
 hvuxpJOyU1Bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="153855434"
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="153855434"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 06:03:17 -0700
IronPort-SDR: 6TFAJWSJNDf8nkx7WvkeBy4UVUL7d4iJyIpV2fZm7gb/Kv16JpikrZCEdwoZJkFmaTdyE/NUi4
 LNYnveybnF3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,355,1592895600"; 
   d="scan'208";a="331772377"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.73]) ([10.237.72.73])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2020 06:03:10 -0700
Subject: Re: Ftrace regression in v5.9-rc1 due to commit fc0ea795f53c
 ("ftrace: Add symbols for ftrace trampolines")
To:     Miroslav Benes <mbenes@suse.cz>, peterz@infradead.org,
        rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org
References: <alpine.LSU.2.21.2008261104180.7835@pobox.suse.cz>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <3a00c25a-0df0-6d55-2053-14fbd06af1e7@intel.com>
Date:   Wed, 26 Aug 2020 16:02:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.21.2008261104180.7835@pobox.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/08/20 12:30 pm, Miroslav Benes wrote:
> Hi,
> 
> during v5.9-rc1 testing I ran into an issue (BUG dump at the end of the 
> email). I suspected commit fc0ea795f53c ("ftrace: Add symbols for ftrace 
> trampolines") (which git bisect later confirmed) and a missing call to 
> ftrace_remove_trampoline_from_kallsyms() somewhere. And indeed there is an 
> unhandled place in ftrace_startup(). __register_ftrace_function() creates 
> a trampoline and adds its ops to new ftrace_ops_trampoline_list. If 
> ftrace_hash_ipmodify_enable() fails, the ops is not removed from the list. 
> 
> Moreover, the trampoline is not freed anywhere in this case if I am not 
> missing something, which is not a problem of the mentioned patch.
> 
> If that's the case, something like
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 275441254bb5..656d7cb5a78c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2862,6 +2862,8 @@ int ftrace_startup(struct ftrace_ops *ops, int command)
>                 __unregister_ftrace_function(ops);
>                 ftrace_start_up--;
>                 ops->flags &= ~FTRACE_OPS_FL_ENABLED;
> +               if (ops->flags & FTRACE_OPS_FL_DYNAMIC)
> +                       ftrace_trampoline_free(ops);

FWIW it looks ok to me, because AFAICT the trampoline will not be in use
before the call to ftrace_startup_enable(), so it should be safe to free it
here.

>                 return ret;
>         }
> 
> could do the trick. At least it fixes the issue for me, but I tend to get 
> lost in ftrace code, so it might not be a good approach generally.
> 
> If no one sees a problem anywhere, I'll prepare a proper patch and will 
> run some more testing.
> 
> Regards
> Miroslav
> 
> ---
> BUG: unable to handle page fault for address: fffffffffffffff0
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 2216067 P4D 2216067 PUD 2218067 PMD 0 
> Oops: 0000 [#1] SMP PTI
> CPU: 1 PID: 2430 Comm: cat Tainted: G           O  K   5.9.0-rc2-dirty #44
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
> RIP: 0010:ftrace_mod_get_kallsym+0xd4/0x150
> Code: 40 38 39 f8 0f 87 7b ff ff ff eb e1 0f 0b 4c 8b 0d 21 95 0d 01 b8 de ff ff ff 49 81 f9 80 6d 29 82 4d 8d 81 60 fe ff ff 74 2e <49> 8b 80 90 01 00 00 48 85 c0 740
> RSP: 0018:ffffc90000373e00 EFLAGS: 00010203
> RAX: 0000000000000000 RBX: ffff888072952900 RCX: ffff888072952935
> RDX: ffff888072952934 RSI: ffff888072952928 RDI: 0000000000000000
> RBP: ffff8880729529b5 R08: fffffffffffffe60 R09: ffff888037180fc0
> R10: 0000000000000000 R11: 00000000ff6d59b3 R12: ffff8880729529f0
> R13: ffff888072952928 R14: ffff888072952934 R15: ffff8880729529b5
> FS:  00007f543f339500(0000) GS:ffff88807d200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffffffffff0 CR3: 000000007a09e000 CR4: 00000000000006e0
> Call Trace:
>  update_iter+0x189/0x1e0
>  s_next+0x1f/0x30
>  seq_read+0x238/0x420
>  proc_reg_read+0x56/0x70
>  vfs_read+0xb7/0x1c0
>  ksys_read+0xa7/0xe0
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f543ee621a1
> Code: fe ff ff 48 8d 3d 67 a1 09 00 48 83 ec 08 e8 e6 03 02 00 66 0f 1f 44 00 00 8b 05 0a d2 2c 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f9
> RSP: 002b:00007ffd9b8691d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f543ee621a1
> RDX: 0000000000020000 RSI: 00007f543f196000 RDI: 0000000000000003
> RBP: 0000000000020000 R08: ffffffffffffffff R09: 0000000000000000
> R10: 000000000000089f R11: 0000000000000246 R12: 00007f543f196000
> R13: 0000000000000003 R14: 0000000000000fe3 R15: 0000000000020000
> Modules linked in: af_packet iscsi_ibft iscsi_boot_sysfs rfkill ppdev bochs_drm drm_vram_helper drm_ttm_helper ttm drm_kms_helper joydev i2c_piix4 drm pcspkr parport_]
> CR2: fffffffffffffff0
> ---[ end trace 2ad43a0bbf68c2e2 ]---
> RIP: 0010:ftrace_mod_get_kallsym+0xd4/0x150
> Code: 40 38 39 f8 0f 87 7b ff ff ff eb e1 0f 0b 4c 8b 0d 21 95 0d 01 b8 de ff ff ff 49 81 f9 80 6d 29 82 4d 8d 81 60 fe ff ff 74 2e <49> 8b 80 90 01 00 00 48 85 c0 740
> RSP: 0018:ffffc90000373e00 EFLAGS: 00010203
> RAX: 0000000000000000 RBX: ffff888072952900 RCX: ffff888072952935
> RDX: ffff888072952934 RSI: ffff888072952928 RDI: 0000000000000000
> RBP: ffff8880729529b5 R08: fffffffffffffe60 R09: ffff888037180fc0
> R10: 0000000000000000 R11: 00000000ff6d59b3 R12: ffff8880729529f0
> R13: ffff888072952928 R14: ffff888072952934 R15: ffff8880729529b5
> FS:  00007f543f339500(0000) GS:ffff88807d200000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: fffffffffffffff0 CR3: 000000007a09e000 CR4: 00000000000006e0
> note: cat[2430] exited with preempt_count 1
> BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 2430, name: cat
> INFO: lockdep is turned off.
> irq event stamp: 530598
> hardirqs last  enabled at (530597): [<ffffffff819c9a10>] syscall_enter_from_user_mode+0x20/0x250
> hardirqs last disabled at (530598): [<ffffffff819c9ebd>] irqentry_enter+0x1d/0x50
> softirqs last  enabled at (522266): [<ffffffff81c00343>] __do_softirq+0x343/0x463
> softirqs last disabled at (522259): [<ffffffff81a010d2>] asm_call_on_stack+0x12/0x20
> CPU: 1 PID: 2430 Comm: cat Tainted: G      D    O  K   5.9.0-rc2-dirty #44
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812d-rebuilt.opensuse.org 04/01/2014
> Call Trace:
>  dump_stack+0x96/0xdb
>  ___might_sleep+0x16c/0x260
>  exit_signals+0x30/0x2f0
>  do_exit+0xd4/0xc50
>  ? ksys_read+0xa7/0xe0
>  rewind_stack_do_exit+0x17/0x20
> RIP: 0033:0x7f543ee621a1
> Code: fe ff ff 48 8d 3d 67 a1 09 00 48 83 ec 08 e8 e6 03 02 00 66 0f 1f 44 00 00 8b 05 0a d2 2c 00 48 63 ff 85 c0 75 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f9
> RSP: 002b:00007ffd9b8691d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f543ee621a1
> RDX: 0000000000020000 RSI: 00007f543f196000 RDI: 0000000000000003
> RBP: 0000000000020000 R08: ffffffffffffffff R09: 0000000000000000
> R10: 000000000000089f R11: 0000000000000246 R12: 00007f543f196000
> R13: 0000000000000003 R14: 0000000000000fe3 R15: 0000000000020000
> 
> 

