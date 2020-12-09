Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9438E2D3D03
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgLIICc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgLIICW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:02:22 -0500
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EC8C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 00:01:40 -0800 (PST)
Received: by mail-qv1-xf43.google.com with SMTP id a13so201295qvv.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 00:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=2ipbFz3QMr0/xWp6RobQtyDVjSogGPWtNBaUhHk98bc=;
        b=MrCPcfMxW1DWU5/S+BLMNJPNdcVvci9nFtanPQqbClmMh9ia9qJkivgTkF1rWXf/oP
         TgB4K5JPAXzoAGFkXDBDQPgRkqxwJZv/mnb6bBiVNZn7XBKRms1bRdPGSBInmM0AduXW
         KZGMSwbJoRscGS+Pbb+iYbRVVQ7bnk4XwcWFStg34ETvspb4Lcwo6ZX/p1t108YsFcMx
         QrEVufGa82LXRGa17RCUlOJdkbHLElJg6kSqKodQ8wdDWAQM2gvIuyWyhLW3uqlek3ZG
         s2tKVRk66s5wcHBFl6unp2eetvs1jBYbSwJsJW8jEwb8SR91sLY+9jxoIxoU13+BGupT
         l6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=2ipbFz3QMr0/xWp6RobQtyDVjSogGPWtNBaUhHk98bc=;
        b=QvqV9+ylaYIw2rN8spAMHs0BVohoMvQcEOrvtTl4MSymF3WtXv8W03XNdPIi96Nl87
         qKHnnCH1Nyha+SX5XNLOpV8ReDAlg/MYVYywlEbEuk52N+hGSjUNLujAZandBw+MEp/Z
         CGp9JBAQWEXqw/MVpmjdDrodr3a6Ma/xwQJh0HhJIPvRm9d3F2VhouMMrXM1DQhAvgKa
         EHT+delphxdSu2gHA9dltVJjxDpgBrWOBExd0sSdqqC72ItQlZFMm4wO8i9kn5o/v3a5
         H/4pj83wptY8Gq5IXAUBFYv4cDhJmUJk/nBndvRpyDoIpn6TZEcmYdJZr0BxtvdtIQOt
         UfBg==
X-Gm-Message-State: AOAM531VhZZNvTZgZqQlpm+Zkd8nQ3ycC1mtcWVBa0CKiH+39fi9WswM
        PZh5bz65vudtwVCbH4RdEujnJ1qNqxmbhmLAwPa8kA==
X-Google-Smtp-Source: ABdhPJy/bDUsKLLIkOQfEZdJ5xCTpuXY05aNCkpcxB3hVFg3wwhEy7saeDLBEzh8UvjEDtvEFpp709X7/7chV/O/FcY=
X-Received: by 2002:a0c:edab:: with SMTP id h11mr1958804qvr.23.1607500899578;
 Wed, 09 Dec 2020 00:01:39 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009ea5720595dc03a3@google.com>
In-Reply-To: <0000000000009ea5720595dc03a3@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 9 Dec 2020 09:01:28 +0100
Message-ID: <CACT4Y+avvqLabSr+4GL-GSah5YMxvM+u2_yTcjT=xtA14YXS_w@mail.gmail.com>
Subject: Re: BUG: MAX_LOCKDEP_KEYS too low!
To:     syzbot <syzbot+692f39f040c1f415567b@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 27, 2019 at 4:31 AM syzbot
<syzbot+692f39f040c1f415567b@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    65921376 Merge branch 'net-fix-nested-device-bugs'
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=1637fdc0e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0ac4d9b35046343
> dashboard link: https://syzkaller.appspot.com/bug?extid=692f39f040c1f415567b
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+692f39f040c1f415567b@syzkaller.appspotmail.com

This stopped happening a while ago, let's close this to get
notifications about new instances.
One of likely candidates:

#syz fix: net: partially revert dynamic lockdep key changes


> BUG: MAX_LOCKDEP_KEYS too low!
> turning off the locking correctness validator.
> CPU: 0 PID: 15175 Comm: syz-executor.5 Not tainted 5.4.0-rc3+ #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
>   register_lock_class.cold+0x1b/0x27 kernel/locking/lockdep.c:1222
>   __lock_acquire+0xf4/0x4a00 kernel/locking/lockdep.c:3837
>   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4487
>   __raw_spin_lock_bh include/linux/spinlock_api_smp.h:135 [inline]
>   _raw_spin_lock_bh+0x33/0x50 kernel/locking/spinlock.c:175
>   spin_lock_bh include/linux/spinlock.h:343 [inline]
>   netif_addr_lock_bh include/linux/netdevice.h:4055 [inline]
>   __dev_mc_add+0x2e/0xd0 net/core/dev_addr_lists.c:765
>   dev_mc_add+0x20/0x30 net/core/dev_addr_lists.c:783
>   igmp6_group_added+0x3b5/0x460 net/ipv6/mcast.c:672
>   __ipv6_dev_mc_inc+0x727/0xa60 net/ipv6/mcast.c:931
>   ipv6_dev_mc_inc+0x20/0x30 net/ipv6/mcast.c:938
>   ipv6_add_dev net/ipv6/addrconf.c:456 [inline]
>   ipv6_add_dev+0xa3d/0x10b0 net/ipv6/addrconf.c:363
>   addrconf_notify+0x97d/0x23b0 net/ipv6/addrconf.c:3491
>   notifier_call_chain+0xc2/0x230 kernel/notifier.c:95
>   __raw_notifier_call_chain kernel/notifier.c:396 [inline]
>   raw_notifier_call_chain+0x2e/0x40 kernel/notifier.c:403
>   call_netdevice_notifiers_info+0x3f/0x90 net/core/dev.c:1668
>   call_netdevice_notifiers_extack net/core/dev.c:1680 [inline]
>   call_netdevice_notifiers net/core/dev.c:1694 [inline]
>   register_netdevice+0x950/0xeb0 net/core/dev.c:9114
>   ieee80211_if_add+0xf51/0x1730 net/mac80211/iface.c:1881
>   ieee80211_register_hw+0x36e6/0x3ac0 net/mac80211/main.c:1256
>   mac80211_hwsim_new_radio+0x20d9/0x4360
> drivers/net/wireless/mac80211_hwsim.c:3031
>   hwsim_new_radio_nl+0x9e3/0x1070 drivers/net/wireless/mac80211_hwsim.c:3586
>   genl_family_rcv_msg+0x74b/0xf90 net/netlink/genetlink.c:629
>   genl_rcv_msg+0xca/0x170 net/netlink/genetlink.c:654
>   netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
>   genl_rcv+0x29/0x40 net/netlink/genetlink.c:665
>   netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
>   netlink_unicast+0x531/0x710 net/netlink/af_netlink.c:1328
>   netlink_sendmsg+0x8a5/0xd60 net/netlink/af_netlink.c:1917
>   sock_sendmsg_nosec net/socket.c:637 [inline]
>   sock_sendmsg+0xd7/0x130 net/socket.c:657
>   ___sys_sendmsg+0x803/0x920 net/socket.c:2311
>   __sys_sendmsg+0x105/0x1d0 net/socket.c:2356
>   __do_sys_sendmsg net/socket.c:2365 [inline]
>   __se_sys_sendmsg net/socket.c:2363 [inline]
>   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2363
>   do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x459f39
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fd0af43ac78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000459f39
> RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd0af43b6d4
> R13: 00000000004c82f8 R14: 00000000004de3f0 R15: 00000000ffffffff
> kobject: 'batman_adv' (000000009392522f): kobject_add_internal:
> parent: 'wlan1810', set: '<NULL>'
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000009ea5720595dc03a3%40google.com.
