Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2CB2E9EF9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 21:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbhADUmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 15:42:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbhADUmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:42:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3F066216C4;
        Mon,  4 Jan 2021 20:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609792914;
        bh=oRUuEikXDLb/1+VQEWvgN1BTApFFJA3HjL79h09B9qo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=noHD54jr1B6nSKSmiURj189F8T/B92IXxZyt7HJKoumJuhc/zLUVoVOQC/HcyW8wj
         JuBKTjJgDLeKGZpDAuyv4qHiPhAkAEcNZrwaHxTZAlmKixps953ysQ6vlP8FO34k2e
         gzHT8e9oVwuN4K97amEVEJsYIiXvrCGCN5RJ7wHQ=
Date:   Mon, 4 Jan 2021 12:41:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: kernel BUG at mm/page-writeback.c:LINE!
Message-Id: <20210104124153.0992b1f7fd1a145e193a333f@linux-foundation.org>
In-Reply-To: <000000000000886dbd05b7ffa8db@google.com>
References: <000000000000886dbd05b7ffa8db@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 03 Jan 2021 06:19:15 -0800 syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    139711f0 Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11648e93500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f3e74a3fb99ae2c2
> dashboard link: https://syzkaller.appspot.com/bug?extid=2fc0712f8f8b8b8fa0ef
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com
> 
> kernel BUG at mm/page-writeback.c:2241!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 26311 Comm: syz-executor.2 Not tainted 5.11.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:write_cache_pages+0xd06/0x1190 mm/page-writeback.c:2241
> Code: 02 00 00 e8 dc 6e da ff 48 c7 c6 80 64 54 89 4c 89 ef e8 0d 04 0b 00 0f 0b 49 c7 c4 c0 77 f7 8e e9 ce f9 ff ff e8 ba 6e da ff <0f> 0b e8 b3 6e da ff 49 8d 5c 24 ff e9 c5 f8 ff ff e8 a4 6e da ff
> RSP: 0018:ffffc9000931f850 EFLAGS: 00010212
> RAX: 000000000000ac05 RBX: 0000000000008000 RCX: ffffc9000d7c1000
> RDX: 0000000000040000 RSI: ffffffff819805d6 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffea0000c0ce07
> R10: ffffffff8197fee3 R11: 0000000000000000 R12: ffffea0002762cc8
> R13: ffffea0000c0ce00 R14: dffffc0000000000 R15: 0000000000000000
> FS:  00007f653a526700(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000052e94c CR3: 0000000015251000 CR4: 0000000000350ee0
> Call Trace:
>  mpage_writepages+0xd8/0x230 fs/mpage.c:714
>  do_writepages+0xec/0x290 mm/page-writeback.c:2352
>  __filemap_fdatawrite_range+0x2a1/0x380 mm/filemap.c:422
>  fat_cont_expand+0x169/0x230 fs/fat/file.c:235
>  fat_setattr+0xac2/0xf40 fs/fat/file.c:501
>  notify_change+0xb60/0x10a0 fs/attr.c:336
>  do_truncate+0x134/0x1f0 fs/open.c:64
>  do_sys_ftruncate+0x703/0x860 fs/open.c:195
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45e299
> Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007f653a525c68 EFLAGS: 00000246 ORIG_RAX: 000000000000004d
> RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 000000000045e299
> RDX: 0000000000000000 RSI: 0000000000000800 RDI: 0000000000000003
> RBP: 000000000119c060 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000119c034
> R13: 00007fff76bf2e8f R14: 00007f653a5269c0 R15: 000000000119c034
> Modules linked in:
> ---[ end trace 23c7a881902c6de9 ]---
> RIP: 0010:write_cache_pages+0xd06/0x1190 mm/page-writeback.c:2241
> Code: 02 00 00 e8 dc 6e da ff 48 c7 c6 80 64 54 89 4c 89 ef e8 0d 04 0b 00 0f 0b 49 c7 c4 c0 77 f7 8e e9 ce f9 ff ff e8 ba 6e da ff <0f> 0b e8 b3 6e da ff 49 8d 5c 24 ff e9 c5 f8 ff ff e8 a4 6e da ff
> RSP: 0018:ffffc9000931f850 EFLAGS: 00010212
> RAX: 000000000000ac05 RBX: 0000000000008000 RCX: ffffc9000d7c1000
> RDX: 0000000000040000 RSI: ffffffff819805d6 RDI: 0000000000000003
> RBP: 0000000000000000 R08: 0000000000000000 R09: ffffea0000c0ce07
> R10: ffffffff8197fee3 R11: 0000000000000000 R12: ffffea0002762cc8
> R13: ffffea0000c0ce00 R14: dffffc0000000000 R15: 0000000000000000
> FS:  00007f653a526700(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f228000 CR3: 0000000015251000 CR4: 0000000000350ee0

Well that's exciting. write_cache_pages() does:

			if (PageWriteback(page)) {
				if (wbc->sync_mode != WB_SYNC_NONE)
					wait_on_page_writeback(page);
				else
					goto continue_unlock;
			}

bang -->>		BUG_ON(PageWriteback(page));


and filemap_fdatawrite_range() passed WB_SYNC_ALL to
__filemap_fdatawrite_range().

So either wait_on_page_writeback() simply failed to work (returned
without waiting) or someone came in and unexpectedly set PG_writeback a
second time.

And because it isn't reproducible, we don't know if it's a -mm patch or
it it's a mainline bug or whatever.  There isn't much material in -mm
at present and I can't see any which would affect these things, so is
it reasonable to suspect that this is a mainline bug?

Linus, how confident are you in those wait_on_page_bit_common()
changes?
