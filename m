Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B0227F811
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730117AbgJAC6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgJAC6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:58:09 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA0EC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:58:07 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y17so4686493lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 19:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iR/Mw2FU5eNmwUnYn5+R34Uf+yHfaGyXBBfb6KHHCA8=;
        b=d3Xt1Guga7g6I8bxY0sJGefRm+WriJp0HkCjQVkpXHXTMBVikLgCdH2f3jgU55qj6Q
         3qhY1NpgVmCEq//0XiWlZbfw/90mt3DLmCh6ajWFvD95f1RgiJBH2CvC0pMWzf5xTO48
         Y4f9BMUYY/sLYr9w80GZo263lVO6LYUAxT5vWYUXTVu9fzY6DdJncPPx/JRVoWBy5fiN
         xI2tbb2M9p5L++v76wc0lwOAwMXRL5XR67gUJYKbgVufWOvm+ae3hWulPTQ0xh5d6Msq
         WLtbzLHrgM6DQar+Ocoq3cTmaLstclkuubUKYkKng5Fvz45r4tjskh2ln3+5975qywkf
         4v/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iR/Mw2FU5eNmwUnYn5+R34Uf+yHfaGyXBBfb6KHHCA8=;
        b=AxLszUpJzNWNJ3MDoOaXBPBIOGIl3otuiSmJZ2MAXOeZfnvf8A204cEO/EN6yj/4cq
         wX5CG/sGgnUnMzROmxKnpX4GJAVIRZAqi7tkqjHbYJQvyAfYvWHf9TtNJ2FIQtrpeLRr
         42nP6ZBCIjoEppdV62wJbBFEuGIIv7U84LzDc3QQkpYnAxlVfsQh36C9LjUYs3ZjHUmf
         7nqGrg7uRaI2gxtjF0QVwlcqIbrebWARYBO2n2/xYp+HPMYtG7IM0WW7XzaPOB/SQXZo
         DzPqDtSIxhuL3HzSkKxLQSrS8XLx9manQiNjvvs2fad76ydhjbM3DFbv/j504CsR7+vR
         oxlg==
X-Gm-Message-State: AOAM532y5WVsso1vTuSvE0mSrod13ZrLSvnTiEc8SO9NxX+fP8EeEHjF
        bxOEIzESl5jRAIvxHuxj7bSxIn0tUKDHldv1+7XGdNnrRYBJZw==
X-Google-Smtp-Source: ABdhPJyKLxvFWZrSumrgUCG6DziN6GKV1qo/6hUJqeg+1q/d67ZOsGftkVfqaiXvUXa2HyZM1c1dm/K0UAf9lejY3Ag=
X-Received: by 2002:a19:c8ce:: with SMTP id y197mr1681727lff.74.1601521085832;
 Wed, 30 Sep 2020 19:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000074bbdd05ae6d7d35@google.com>
In-Reply-To: <00000000000074bbdd05ae6d7d35@google.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 1 Oct 2020 08:27:54 +0530
Message-ID: <CAFqt6zbXQLrjHK6wAZ+C3TodEE__6sgVDWvrn2o=mzP_WbKT5A@mail.gmail.com>
Subject: Re: kernel BUG at mm/mmap.c:LINE!
To:     syzbot <syzbot+721b657f8f01708b291b@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 12:39 AM syzbot
<syzbot+721b657f8f01708b291b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    1127b219 Merge tag 'fallthrough-fixes-5.9-rc3' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=136d098e900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
> dashboard link: https://syzkaller.appspot.com/bug?extid=721b657f8f01708b291b
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+721b657f8f01708b291b@syzkaller.appspotmail.com
>
> start_brk 558decf56000 brk 558ded160000 start_stack 7ffd20847a70
> arg_start 7ffd20847e89 arg_end 7ffd20847ea4 env_start 7ffd20847ea4 env_end 7ffd20847fdd
> binfmt ffffffff89cdcb60 flags 200cd core_state 0000000000000000
> ioctx_table 0000000000000000
> ------------[ cut here ]------------
> kernel BUG at mm/mmap.c:427!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 28867 Comm: systemd-udevd Not tainted 5.9.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:validate_mm+0x617/0x800 mm/mmap.c:427
> Code: cf f5 cd ff 44 89 e6 bf ff ff ff ff e8 42 f2 cd ff 41 83 fc ff 0f 85 86 1b 01 00 e8 b3 f5 cd ff 48 8b 7c 24 18 e8 d9 59 fc ff <0f> 0b e8 a2 f5 cd ff 48 8b 54 24 28 48 b8 00 00 00 00 00 fc ff df
> RSP: 0018:ffffc90015d6fd98 EFLAGS: 00010286
> RAX: 000000000000038d RBX: 000000000000004f RCX: 0000000000000000
> RDX: ffff8880475ac380 RSI: ffffffff815dafc7 RDI: fffff52002badf52
> RBP: 0000000000000000 R08: 000000000000038d R09: ffff8880ae6318e7
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007fb1b935a8c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd20959990 CR3: 0000000217691000 CR4: 00000000001526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  remove_vma_list mm/mmap.c:2616 [inline]
>  __do_munmap+0x899/0x1170 mm/mmap.c:2869
>  __vm_munmap+0xe6/0x180 mm/mmap.c:2889
>  __do_sys_munmap mm/mmap.c:2915 [inline]
>  __se_sys_munmap mm/mmap.c:2911 [inline]
>  __x64_sys_munmap+0x62/0x80 mm/mmap.c:2911
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7fb1b81d66e7
> Code: c7 c0 ff ff ff ff eb 8d 48 8b 15 ac 47 2b 00 f7 d8 64 89 02 e9 5b ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 81 47 2b 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd20846cd8 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
> RAX: ffffffffffffffda RBX: 0000558decf56100 RCX: 00007fb1b81d66e7
> RDX: 0000000000000080 RSI: 000000000080ccec RDI: 00007fb1b7064000
> RBP: 0000558debda4d18 R08: 0000558decf6a3c0 R09: 0000000000000000
> R10: 00000000ffffffff R11: 0000000000000206 R12: 0000558decf560e0
> R13: 0000000000000000 R14: 0000000000000003 R15: 000000000000000e
> Modules linked in:
> ---[ end trace 76a00ebdfa09cc52 ]---
> RIP: 0010:validate_mm+0x617/0x800 mm/mmap.c:427
> Code: cf f5 cd ff 44 89 e6 bf ff ff ff ff e8 42 f2 cd ff 41 83 fc ff 0f 85 86 1b 01 00 e8 b3 f5 cd ff 48 8b 7c 24 18 e8 d9 59 fc ff <0f> 0b e8 a2 f5 cd ff 48 8b 54 24 28 48 b8 00 00 00 00 00 fc ff df
> RSP: 0018:ffffc90015d6fd98 EFLAGS: 00010286
> RAX: 000000000000038d RBX: 000000000000004f RCX: 0000000000000000
> RDX: ffff8880475ac380 RSI: ffffffff815dafc7 RDI: fffff52002badf52
> RBP: 0000000000000000 R08: 000000000000038d R09: ffff8880ae6318e7
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000001
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> FS:  00007fb1b935a8c0(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fad09fed000 CR3: 0000000217691000 CR4: 00000000001526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>

CONFIG_DEBUG_VM_RB=y is set.

[ 1882.597004][T28867] mmap: backwards 1, forwards 3
[ 1882.605532][T28867] mm ffff88804eeff640 mmap ffff888094849318
seqnum 1 task_size 140737488351232

Looks like we hit panic due to below code.

static int browse_rb(struct mm_struct *mm) {
...
if (i != j) {
pr_emerg("backwards %d, forwards %d\n", j, i);
bug = 1;
}
...
}
