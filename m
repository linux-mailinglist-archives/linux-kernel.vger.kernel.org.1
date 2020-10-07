Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E79F2867FE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgJGTES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:54642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgJGTES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:04:18 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CCE12168B;
        Wed,  7 Oct 2020 19:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602097457;
        bh=llfxpknjIWXGV1PRIAQcxo2wu7p/kw/F31cAdH+5TX0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ldJJe2wFmBaoUuddH8wZ6oJe8RqDmpVZiKmohkPIlhwNvLm9ES6k+23YepXYyBN7q
         Fw83LTzq9fnC391wl9zmtQaY85gHpYkTQPYwUYBCWeonnWwRAIBcLlSyXAG3m7t3CI
         7/ciqTmm3JQf8YwSaOg3J9geHKO4nIPGZ0LLTuU8=
Date:   Wed, 7 Oct 2020 12:04:16 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mmap: Fix general protection fault in
 unlink_file_vma()
Message-Id: <20201007120416.0e826cbb79da76ac9673b9d8@linux-foundation.org>
In-Reply-To: <20200916090733.31427-1-linmiaohe@huawei.com>
References: <20200916090733.31427-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 05:07:33 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:

> The syzbot reported the below general protection fault:
> 
> general protection fault, probably for non-canonical address
> 0xe00eeaee0000003b: 0000 [#1] PREEMPT SMP KASAN
> KASAN: maybe wild-memory-access in range
> [0x00777770000001d8-0x00777770000001df]
> CPU: 1 PID: 10488 Comm: syz-executor721 Not tainted 5.9.0-rc3-syzkaller #0
> RIP: 0010:unlink_file_vma+0x57/0xb0 mm/mmap.c:164
> Code: 4c 8b a5 a0 00 00 00 4d 85 e4 74 4e e8 92 d7 cd ff 49 8d bc 24
> d8 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c
> 02 00 75 3d 4d 8b b4 24 d8 01 00 00 4d 8d 6e 78 4c 89 ef e8
> RSP: 0018:ffffc9000ac0f9b0 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff88800010ceb0 RCX: ffffffff81592421
> RDX: 000eeeee0000003b RSI: ffffffff81a6736e RDI: 00777770000001d8
> RBP: ffff88800010ceb0 R08: 0000000000000001 R09: ffff88801291a50f
> R10: ffffed10025234a1 R11: 0000000000000001 R12: 0077777000000000
> R13: 00007f1eea0da000 R14: 00007f1eea0d9000 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1eea11a9d0 CR3: 000000000007e000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  free_pgtables+0x1b3/0x2f0 mm/memory.c:415
>  exit_mmap+0x2c0/0x530 mm/mmap.c:3184
>  __mmput+0x122/0x470 kernel/fork.c:1076
>  mmput+0x53/0x60 kernel/fork.c:1097
>  exit_mm kernel/exit.c:483 [inline]
>  do_exit+0xa8b/0x29f0 kernel/exit.c:793
>  do_group_exit+0x125/0x310 kernel/exit.c:903
>  get_signal+0x428/0x1f00 kernel/signal.c:2757
>  arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
>  exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
>  exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:167
>  syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> It's because the ->mmap() callback can change vma->vm_file and fput the
> original file. But the commit d70cec898324 ("mm: mmap: merge vma after
> call_mmap() if possible") failed to catch this case and always fput() the
> original file, hence add an extra fput().
> 
> ...
>
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1815,7 +1815,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  			merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
>  				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
>  			if (merge) {
> -				fput(file);
> +				/* ->mmap() can change vma->vm_file and fput the original file. So
> +				 * fput the vma->vm_file here or we would add an extra fput for file
> +				 * and cause general protection fault ultimately.
> +				 */
> +				fput(vma->vm_file);
>  				vm_area_free(vma);
>  				vma = merge;
>  				/* Update vm_flags and possible addr to pick up the change. We don't

What about the case where this code block does its `goto unmap_writable'?

	/* Once vma denies write, undo our temporary denial count */
	if (file) {
unmap_writable:
		if (vm_flags & VM_SHARED)
			mapping_unmap_writable(file->f_mapping);
		if (vm_flags & VM_DENYWRITE)
			allow_write_access(file);
	}
	file = vma->vm_file;

is this using the correct file?  I think it is, but please do check.

