Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D9C27EAD3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgI3OWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45989 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726680AbgI3OWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:22:34 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601475752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZTGXibmvJL+VjNuTgse4l3qkl9TQ0cSPX9Y584SYbI=;
        b=bydjViYI7FRWDbhRQwnJaevTSUinNa+VftWxInXiSqdJDNC93QZmaH6MI4zD7m+RvR/m5/
        g3OtzTFdnQGkvV2XGbzjcaqEzkiN91K0FpghojTg/XEeOP0C+w9LzdSNaH+xPfX/BUHBzM
        woD1NKxVzIzR3bF2WWiXoE/HiV3il9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-VyNxiaxON62uL_YfobeqGg-1; Wed, 30 Sep 2020 10:22:23 -0400
X-MC-Unique: VyNxiaxON62uL_YfobeqGg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 262601006701;
        Wed, 30 Sep 2020 14:22:22 +0000 (UTC)
Received: from [10.33.36.138] (unknown [10.33.36.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C61A9100239A;
        Wed, 30 Sep 2020 14:22:17 +0000 (UTC)
Subject: Re: [Cluster-devel] KASAN: slab-out-of-bounds Write in
 gfs2_fill_super
To:     syzbot <syzbot+af90d47a37376844e731@syzkaller.appspotmail.com>,
        agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
References: <0000000000006903b205b0873061@google.com>
From:   Andrew Price <anprice@redhat.com>
Message-ID: <21b7b508-c8f2-4730-7a1d-b4376effcce0@redhat.com>
Date:   Wed, 30 Sep 2020 15:22:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0000000000006903b205b0873061@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2020 13:39, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13458c0f900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=adebb40048274f92
> dashboard link: https://syzkaller.appspot.com/bug?extid=af90d47a37376844e731
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c307d3900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353d58d900000
> 
> Bisection is inconclusive: the issue happens on the oldest tested release.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106acbbb900000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126acbbb900000
> console output: https://syzkaller.appspot.com/x/log.txt?x=146acbbb900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+af90d47a37376844e731@syzkaller.appspotmail.com
> 
> gfs2: fsid=loop0: Trying to join cluster "lock_nolock", "loop0"
> gfs2: fsid=loop0: Now mounting FS...
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in gfs2_read_sb fs/gfs2/ops_fstype.c:342 [inline]
> BUG: KASAN: slab-out-of-bounds in init_sb fs/gfs2/ops_fstype.c:479 [inline]
> BUG: KASAN: slab-out-of-bounds in gfs2_fill_super+0x1db5/0x3fe0 fs/gfs2/ops_fstype.c:1096
> Write of size 8 at addr ffff88809073d548 by task syz-executor940/6853

Bug filed for this:

https://bugzilla.redhat.com/show_bug.cgi?id=1883929

Andy

> CPU: 1 PID: 6853 Comm: syz-executor940 Not tainted 5.9.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x1d6/0x29e lib/dump_stack.c:118
>   print_address_description+0x66/0x620 mm/kasan/report.c:383
>   __kasan_report mm/kasan/report.c:513 [inline]
>   kasan_report+0x132/0x1d0 mm/kasan/report.c:530
>   gfs2_read_sb fs/gfs2/ops_fstype.c:342 [inline]
>   init_sb fs/gfs2/ops_fstype.c:479 [inline]
>   gfs2_fill_super+0x1db5/0x3fe0 fs/gfs2/ops_fstype.c:1096
>   get_tree_bdev+0x3e9/0x5f0 fs/super.c:1342
>   gfs2_get_tree+0x4c/0x1f0 fs/gfs2/ops_fstype.c:1201
>   vfs_get_tree+0x88/0x270 fs/super.c:1547
>   do_new_mount fs/namespace.c:2875 [inline]
>   path_mount+0x179d/0x29e0 fs/namespace.c:3192
>   do_mount fs/namespace.c:3205 [inline]
>   __do_sys_mount fs/namespace.c:3413 [inline]
>   __se_sys_mount+0x126/0x180 fs/namespace.c:3390
>   do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x446dba
> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007fff4c56e748 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007fff4c56e7a0 RCX: 0000000000446dba
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff4c56e760
> RBP: 00007fff4c56e760 R08: 00007fff4c56e7a0 R09: 00007fff00000015
> R10: 0000000002200000 R11: 0000000000000293 R12: 0000000000000001
> R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
> 
> Allocated by task 6853:
>   kasan_save_stack mm/kasan/common.c:48 [inline]
>   kasan_set_track mm/kasan/common.c:56 [inline]
>   __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
>   kmem_cache_alloc_trace+0x1e4/0x2e0 mm/slab.c:3554
>   kmalloc include/linux/slab.h:554 [inline]
>   kzalloc include/linux/slab.h:666 [inline]
>   init_sbd fs/gfs2/ops_fstype.c:77 [inline]
>   gfs2_fill_super+0xb6/0x3fe0 fs/gfs2/ops_fstype.c:1018
>   get_tree_bdev+0x3e9/0x5f0 fs/super.c:1342
>   gfs2_get_tree+0x4c/0x1f0 fs/gfs2/ops_fstype.c:1201
>   vfs_get_tree+0x88/0x270 fs/super.c:1547
>   do_new_mount fs/namespace.c:2875 [inline]
>   path_mount+0x179d/0x29e0 fs/namespace.c:3192
>   do_mount fs/namespace.c:3205 [inline]
>   __do_sys_mount fs/namespace.c:3413 [inline]
>   __se_sys_mount+0x126/0x180 fs/namespace.c:3390
>   do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> The buggy address belongs to the object at ffff88809073c000
>   which belongs to the cache kmalloc-8k of size 8192
> The buggy address is located 5448 bytes inside of
>   8192-byte region [ffff88809073c000, ffff88809073e000)
> The buggy address belongs to the page:
> page:00000000bd4b0b2d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9073c
> head:00000000bd4b0b2d order:2 compound_mapcount:0 compound_pincount:0
> flags: 0xfffe0000010200(slab|head)
> raw: 00fffe0000010200 ffffea00028e5608 ffff8880aa441b50 ffff8880aa440a00
> raw: 0000000000000000 ffff88809073c000 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
>   ffff88809073d400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   ffff88809073d480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff88809073d500: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>                                                ^
>   ffff88809073d580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>   ffff88809073d600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> ==================================================================
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
> 

