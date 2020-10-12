Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB99F28AF8D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgJLIBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:01:13 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51021 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgJLIBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:01:12 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MKsf5-1kkuWO4B13-00LHJY for <linux-kernel@vger.kernel.org>; Mon, 12 Oct
 2020 10:01:10 +0200
Received: by mail-lf1-f50.google.com with SMTP id b1so14031360lfp.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 01:01:09 -0700 (PDT)
X-Gm-Message-State: AOAM533HOAtHg5QkZ6kZr+XPsyMZpSC3V1A2oaagD29py+0LOovryQGj
        +51eRs5JgHMGgAygfSD+yFV4qqsGyXLZY7XMY1o=
X-Google-Smtp-Source: ABdhPJzEQADMTdoWVJu2tKB8vHKbi3JliyWHJZBWrnodVca+iMcdNRAt0l9clmueZUYJI2vwBNJhOJfZc4WNwGUFzH4=
X-Received: by 2002:ac2:446b:: with SMTP id y11mr4702662lfl.403.1602489669436;
 Mon, 12 Oct 2020 01:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000903b5c05b1732a75@google.com>
In-Reply-To: <000000000000903b5c05b1732a75@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 12 Oct 2020 10:00:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3p7Ueydagr4yshr8RKGzLivJZwEh0TxfipuHYRkN9Wcw@mail.gmail.com>
Message-ID: <CAK8P3a3p7Ueydagr4yshr8RKGzLivJZwEh0TxfipuHYRkN9Wcw@mail.gmail.com>
Subject: Re: general protection fault in qp_release_pages
To:     syzbot <syzbot+f58fe4bb535845237057@syzkaller.appspotmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5Xp0tjTGBbaabGcgB4uEmDc2S8LtHY4chhf/OTXUC9nsS9dm/3T
 /+2kjcYKAZKddh9JdEWe3WxGjBTiauxnw0nZR7CfBDRAQ/p26HUB5IaxSRi7CKTwBGo8Zc9
 GN89KGaYjPwEMN4QtffWPfpR0+TOqzJ54t9xjUXjwPOTITM2kCN34SAcMr4/Lc4bRr6/S8E
 /BwRjIBScD9Ehs8Su5gsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zkr/KOe92X8=:c0uy1PE4It1Z+X7FQopwPB
 KZOg+1h7zu5b6L8vkkjNy7iNNpkd5IgZGAHfIT3Higu9olvSbfkXz+MAQA5n+bneC+Dz3K8Rh
 HAdCBHflVYxNSVWxTlWcswhrySUTEea8xR2QvP1BhHs2uofsAS+i3HY6GkkYaapyLHKdNH2d3
 ZeBiTEcLJDpIHXAyCC40tusfqRSiSRHZa90dJNqdPYDKfUVb6pWL9eAeUbOBYRRZIDaHx0oiI
 2rug5TZ7C15Dgi+csDsO7hDHfzY4BRe2TfoZePUQ+20lL8EFSxYz8iSrDLGSIOICxoPThnZbX
 eRJnPPP9FF9M2frZueC9i+Q5k0Lv+JC0eT9RSeFUHsJNQ09+7HoJ8m7nnNc54PHude6aYBDB6
 O2fhPWJFcAc6rlcpkIGkaKRr3BoKgKrvSg+CMJbj4E3P9hG26LMPC5PxxnIp7C67BgiioNBRN
 qGztCSs15RjC1VZKU3S9+Z6owoIV/s8zj0C4+ti+y/k9+tx3XJX0Z4GYZaSFSGU0xNxyLMQiz
 u3eWb+opkQhgvlkfsg4mBpTDPEolgBmvzb/IG7lmyIS2NdEQ2g572hPi5ge44D9z2tJ5WpA15
 LXiR6TebeVwBrIq0k6zqZfso6KevC554QztxnL9mOkpoAR9TqBRqTNNMMfCCFQldFrxLnRJbM
 8qgp/qbndpopV2SotGu8sLo+dRvl1M6jgWqYof90f0xHLuCuEg4obSO3NQOlOkMfgicHBwVxl
 Cw337qkiqqr5zFz2zA8BW4l0LMMZv+/LOgOSt+zVUR35xEBIOEg9NtzEpzEkHOiJadr17uDzQ
 wX0M5395zjiZy5iEGMq6ebn+M6LgdxS1Kr6wN5ES48B5CTg8JfW7POHLokd4iWuyEohLVP5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 8:11 AM syzbot
<syzbot+f58fe4bb535845237057@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    3dd0130f Merge branch 'akpm' (patches from Andrew)
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1219a8e8500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c06bcf3cc963d91c
> dashboard link: https://syzkaller.appspot.com/bug?extid=f58fe4bb535845237057
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113937fb900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1049031b900000
>
> Bisection is inconclusive: the issue happens on the oldest tested release.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d57007900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d57007900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16d57007900000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f58fe4bb535845237057@syzkaller.appspotmail.com
>

I looked at this for a bit, and I think there is a missing range check
for one of the
members of 'struct vmci_qp_alloc_info' somewhere in the ioctl path.

https://syzkaller.appspot.com/x/repro.c?x=1049031b900000 shows what
arguments get passed, and while all the members are small, my guess is
that something is wrong with the sizes in qp_host_alloc_queue() allocating
an array based on produce_size/consume_size, while
qp_host_register_user_memory() bases the size on the larger
ppn_va/num_ppns.

Adding everyone from the git history that did meaningful changes in the past
for this driver, as there is no specific maintainer file entry for
them to further
investigate.

      Arnd

> general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> CPU: 1 PID: 6894 Comm: syz-executor291 Not tainted 5.9.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
> RIP: 0010:put_page include/linux/mm.h:1172 [inline]
> RIP: 0010:qp_release_pages+0x5a/0x310 drivers/misc/vmw_vmci/vmci_queue_pair.c:635
> Code: 5c ad d1 fc 4d 85 f6 c7 44 24 04 00 00 00 00 0f 85 0f 01 00 00 e9 27 02 00 00 e8 c1 b0 d1 fc 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 62 02 00 00 48 8b 45 08 31 ff 49 89 c4 48 89
> RSP: 0018:ffffc900014e7948 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff8880a06990d0 RCX: ffffffff84a48f81
> RDX: ffff88808e3ec300 RSI: ffffffff84a48e4f RDI: 0000000000000008
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880960634ff
> R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffffd
> R13: dffffc0000000000 R14: fffffffffffffff2 R15: 0000000000000000
> FS:  0000000001e5e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000040 CR3: 00000000a1e74000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  qp_host_get_user_memory+0x249/0x3e0 drivers/misc/vmw_vmci/vmci_queue_pair.c:660
>  qp_host_register_user_memory drivers/misc/vmw_vmci/vmci_queue_pair.c:704 [inline]
>  qp_broker_create drivers/misc/vmw_vmci/vmci_queue_pair.c:1383 [inline]
>  qp_broker_alloc+0x10f9/0x1bf0 drivers/misc/vmw_vmci/vmci_queue_pair.c:1737
>  vmci_qp_broker_alloc+0x48/0x60 drivers/misc/vmw_vmci/vmci_queue_pair.c:1930
>  vmci_host_do_alloc_queuepair.constprop.0+0x1b4/0x400 drivers/misc/vmw_vmci/vmci_host.c:488
>  vmci_host_unlocked_ioctl+0x13cc/0x1e60 drivers/misc/vmw_vmci/vmci_host.c:927
>  vfs_ioctl fs/ioctl.c:48 [inline]
>  __do_sys_ioctl fs/ioctl.c:753 [inline]
>  __se_sys_ioctl fs/ioctl.c:739 [inline]
>  __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
>  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x4402f9
> Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd6af99eb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 00000000004402f9
> RDX: 0000000020000100 RSI: 00000000000007a8 RDI: 0000000000000003
> RBP: 00000000006ca018 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 00000000004002c8 R11: 0000000000000246 R12: 0000000000401b00
> R13: 0000000000401b90 R14: 0000000000000000 R15: 0000000000000000
> Modules linked in:
> ---[ end trace 5d73c037702bf45c ]---
> RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
> RIP: 0010:put_page include/linux/mm.h:1172 [inline]
> RIP: 0010:qp_release_pages+0x5a/0x310 drivers/misc/vmw_vmci/vmci_queue_pair.c:635
> Code: 5c ad d1 fc 4d 85 f6 c7 44 24 04 00 00 00 00 0f 85 0f 01 00 00 e9 27 02 00 00 e8 c1 b0 d1 fc 48 8d 7d 08 48 89 f8 48 c1 e8 03 <42> 80 3c 28 00 0f 85 62 02 00 00 48 8b 45 08 31 ff 49 89 c4 48 89
> RSP: 0018:ffffc900014e7948 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffff8880a06990d0 RCX: ffffffff84a48f81
> RDX: ffff88808e3ec300 RSI: ffffffff84a48e4f RDI: 0000000000000008
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880960634ff
> R10: 0000000000000000 R11: 0000000000000000 R12: 00000000fffffffd
> R13: dffffc0000000000 R14: fffffffffffffff2 R15: 0000000000000000
> FS:  0000000001e5e880(0000) GS:ffff8880ae500000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020000040 CR3: 00000000a1e74000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
