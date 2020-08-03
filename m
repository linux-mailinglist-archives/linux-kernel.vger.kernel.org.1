Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6852523AFCE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 23:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgHCVvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 17:51:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34668 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725863AbgHCVvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596491483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sv2XsTeWz2TVZEta2DR1f3kdqAspwL7XI5PcNC38+D8=;
        b=JqLm+r0wsB4PIQYqbtBEfEHntPIxxa9xlQHggHvyZwY1cGR9ZWuENmWKlowcp22rSZQYRR
        FON9EITMLZUmiM8rn1CL126+w+0VW/eGL73GDmMrQs4w0UypeXObW3p7s8nyqMHbw0WHNK
        pKsgF85xxD8kv5eaV1WARlwZmWcgM+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-OdevD_g0NfyNZB6F7MUszQ-1; Mon, 03 Aug 2020 17:51:20 -0400
X-MC-Unique: OdevD_g0NfyNZB6F7MUszQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C56F80046B;
        Mon,  3 Aug 2020 21:51:19 +0000 (UTC)
Received: from treble (ovpn-113-147.rdu2.redhat.com [10.10.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD0481001901;
        Mon,  3 Aug 2020 21:51:16 +0000 (UTC)
Date:   Mon, 3 Aug 2020 16:51:14 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     syzbot <syzbot+c05e6eff86f7a430fa73@syzkaller.appspotmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk, x86@kernel.org
Subject: Re: BUG: stack guard page was hit in arch_stack_walk
Message-ID: <20200803215114.lyltnm4u7qisyqys@treble>
References: <0000000000000897ba05abd4ce25@google.com>
 <20200803214840.mzjq4gk4o2737leo@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803214840.mzjq4gk4o2737leo@treble>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 04:48:46PM -0500, Josh Poimboeuf wrote:
> Hi Cong,
> 
> This looks similar to the stack overflow which was attempted to be fixed
> by dd912306ff00 ("net: fix a potential recursive NETDEV_FEAT_CHANGE").
> 
> And another syzbot report here:
> 
> https://lkml.kernel.org/r/000000000000cb6afe05ab34e77e@google.com

And another:

https://lkml.kernel.org/r/0000000000000897ba05abd4ce25@google.com

> 
> On Sat, Aug 01, 2020 at 11:09:21AM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    92ed3019 Linux 5.8-rc7
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12c98f28900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=84f076779e989e69
> > dashboard link: https://syzkaller.appspot.com/bug?extid=c05e6eff86f7a430fa73
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+c05e6eff86f7a430fa73@syzkaller.appspotmail.com
> > 
> > BUG: stack guard page was hit at 000000009157a0b1 (stack is 000000007cb00dab..0000000055f9d23d)
> > kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 13871 Comm: syz-executor.4 Not tainted 5.8.0-rc7-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:arch_stack_walk+0x0/0xf0 arch/x86/kernel/stacktrace.c:17
> > Code: 8b eb c0 e6 82 89 fa ee ee 8d 57 01 ee ee eb cd e6 81 eb f1 e6 87 eb ed e6 83 eb e9 cc cc cc cc cc cc cc cc cc cc cc cc cc cc <55> 48 89 e5 41 56 49 89 d6 41 55 49 89 cd 41 54 49 89 f4 53 48 89
> > RSP: 0018:ffffc90008b18000 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: fffff52001163001 RCX: 0000000000000000
> > RDX: ffff88802b30e480 RSI: ffffc90008b18028 RDI: ffffffff8162c090
> > RBP: 0000000000000cc0 R08: ffffed1006f83078 R09: ffffed1006f83094
> > R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000cc0
> > R13: 0000000000000000 R14: ffff88821b77f8c0 R15: 00000000000000e0
> > FS:  00007f7369ba8700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffc90008b17ff8 CR3: 00000000a21ec000 CR4: 00000000001426f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:123
> >  save_stack+0x1b/0x40 mm/kasan/common.c:48
> >  set_track mm/kasan/common.c:56 [inline]
> >  __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:494
> >  slab_post_alloc_hook mm/slab.h:586 [inline]
> >  slab_alloc_node mm/slab.c:3263 [inline]
> >  kmem_cache_alloc_node+0x130/0x3c0 mm/slab.c:3575
> >  __alloc_skb+0x71/0x550 net/core/skbuff.c:198
> >  alloc_skb include/linux/skbuff.h:1083 [inline]
> >  nlmsg_new include/net/netlink.h:940 [inline]
> >  rtmsg_ifinfo_build_skb+0x72/0x1a0 net/core/rtnetlink.c:3702
> >  rtmsg_ifinfo_event net/core/rtnetlink.c:3738 [inline]
> >  rtmsg_ifinfo_event net/core/rtnetlink.c:3729 [inline]
> >  rtnetlink_event+0x123/0x1d0 net/core/rtnetlink.c:5512
> >  notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
> >  call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
> >  call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2053 [inline]
> >  netdev_features_change net/core/dev.c:1443 [inline]
> >  netdev_sync_lower_features net/core/dev.c:9056 [inline]
> >  __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
> >  netdev_change_features+0x61/0xb0 net/core/dev.c:9259
> >  bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
> >  bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
> >  bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
> >  notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
> >  call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
> >  call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2053 [inline]
> >  netdev_features_change net/core/dev.c:1443 [inline]
> >  netdev_sync_lower_features net/core/dev.c:9056 [inline]
> >  __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
> >  netdev_change_features+0x61/0xb0 net/core/dev.c:9259
> >  bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
> >  bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
> >  bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
> >  notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
> >  call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
> >  call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2053 [inline]
> >  netdev_features_change net/core/dev.c:1443 [inline]
> >  netdev_sync_lower_features net/core/dev.c:9056 [inline]
> >  __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
> >  netdev_change_features+0x61/0xb0 net/core/dev.c:9259
> >  bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
> >  bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
> >  bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
> >  notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
> >  call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
> >  call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2053 [inline]
> >  netdev_features_change net/core/dev.c:1443 [inline]
> >  netdev_sync_lower_features net/core/dev.c:9056 [inline]
> >  __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
> >  netdev_change_features+0x61/0xb0 net/core/dev.c:9259
> >  bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
> >  bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
> >  bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
> >  notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
> >  call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
> >  call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2053 [inline]
> >  netdev_features_change net/core/dev.c:1443 [inline]
> >  netdev_sync_lower_features net/core/dev.c:9056 [inline]
> >  __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
> >  netdev_change_features+0x61/0xb0 net/core/dev.c:9259
> >  bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
> >  bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
> >  bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
> >  notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
> >  call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
> >  call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2053 [inline]
> >  netdev_features_change net/core/dev.c:1443 [inline]
> >  netdev_sync_lower_features net/core/dev.c:9056 [inline]
> >  __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
> >  netdev_change_features+0x61/0xb0 net/core/dev.c:9259
> >  bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
> >  bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
> >  bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
> >  notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
> >  call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
> >  call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2053 [inline]
> >  netdev_features_change net/core/dev.c:1443 [inline]
> >  netdev_sync_lower_features net/core/dev.c:9056 [inline]
> >  __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
> >  netdev_change_features+0x61/0xb0 net/core/dev.c:9259
> >  bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
> >  bond_slave_netdev_event drivers/net/bonding/bond_main.c:3237 [inline]
> >  bond_netdev_event+0x81f/0xb30 drivers/net/bonding/bond_main.c:3277
> >  notifier_call_chain+0xb5/0x200 kernel/notifier.c:83
> >  call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:2027
> >  call_netdevice_notifiers_extack net/core/dev.c:2039 [inline]
> >  call_netdevice_notifiers net/core/dev.c:2053 [inline]
> >  netdev_features_change net/core/dev.c:1443 [inline]
> >  netdev_sync_lower_features net/core/dev.c:9056 [inline]
> >  __netdev_update_features+0x88d/0x1360 net/core/dev.c:9187
> >  netdev_change_features+0x61/0xb0 net/core/dev.c:9259
> >  bond_compute_features+0x502/0xa00 drivers/net/bonding/bond_main.c:1188
> > Lost 536 message(s)!
> > ---[ end trace 00f7ed0d29de9cad ]---
> > RIP: 0010:arch_stack_walk+0x0/0xf0 arch/x86/kernel/stacktrace.c:17
> > Code: 8b eb c0 e6 82 89 fa ee ee 8d 57 01 ee ee eb cd e6 81 eb f1 e6 87 eb ed e6 83 eb e9 cc cc cc cc cc cc cc cc cc cc cc cc cc cc <55> 48 89 e5 41 56 49 89 d6 41 55 49 89 cd 41 54 49 89 f4 53 48 89
> > RSP: 0018:ffffc90008b18000 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: fffff52001163001 RCX: 0000000000000000
> > RDX: ffff88802b30e480 RSI: ffffc90008b18028 RDI: ffffffff8162c090
> > RBP: 0000000000000cc0 R08: ffffed1006f83078 R09: ffffed1006f83094
> > R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000cc0
> > R13: 0000000000000000 R14: ffff88821b77f8c0 R15: 00000000000000e0
> > FS:  00007f7369ba8700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: ffffc90008b17ff8 CR3: 00000000a21ec000 CR4: 00000000001426f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> 
> -- 
> Josh

-- 
Josh

