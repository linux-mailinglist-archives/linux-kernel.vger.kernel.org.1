Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9555928E06E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 14:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgJNMT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 08:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgJNMT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 08:19:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA152C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 05:19:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y1so1662589plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 05:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Ve/v8piMzqFu7KYIiysFR2gpEUcBzvnVZs3QFeAtO5Q=;
        b=rHI9L28iIsYGSWloPvvJrQ0QKtLRDfGHLdeLSlJm6B7O/vru5ircH+PpC8QhXRKthA
         bTc1APdl9ns2ts4EaXTsSyUg7YLmId3nTpjkoK3eHN5Nw/n1uOyvjariE0DvbUpm8Aq6
         kEquCAKX/CzLHUsyCrC1WwTcJB4Hbd3jTrob8e+3k3UXpaec/WfQFuu7B3kJNVJx+1/5
         lAm8+oSqkqZzhr8QKPUvNcP8lv1KqZklLXSp9tJ0A05QWA6yuYFpvZbpm2JZbD9bDa1x
         m4XnMOIyCG1VSnnZznKbzrb7Cw9opUYnEHOdTldR07TUGBfIdxmFXWKIYw72vvOz3OVc
         ePVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Ve/v8piMzqFu7KYIiysFR2gpEUcBzvnVZs3QFeAtO5Q=;
        b=plSSv9reeCXjgihTitB9KjWaoiG+ZEbCaDL1Iru0xVoPGHAxa3dkjelPXyQdtCv/q1
         1GdmMf27Vdum4Xqy64JsiSluszcnHdmYflDvEbYPqd/jNonzcJv4qRtY5GTNWZRgsGSi
         uAQ1pHdpGqbNULSc0Ek3Mx2owPIhe5eBsX9m+kUUYnzJ6ZdQY5mC0W7qEYPJZnN/kSLv
         Xlr01rUJnWpIsuKOtF2lK/mixRG2Z30L3Kj0AAL5XvMIbY4Dwr3milcmuUxjyRllB1yf
         qStT9x0cGy8bQvYPh9m9u3nUBGffNbP41NPYCasfB+Te0wcL638nwZiICR7jgaqUJUtg
         f3tw==
X-Gm-Message-State: AOAM533mQhRLjIH9UD2kuBeyIRZK8C6R1Dcdn0vtRkW64G4NSqu4jbFY
        /SnxPjsuNer+AHnvWDhvtktb8HUTvFOrjEaXPMc=
X-Google-Smtp-Source: ABdhPJxL2Ssjx3vb62ViibmCk/QK7U06j7qaVJBPg5S1eTxEVyWpdU2Z2ZUkI1n71Rp/C1Dj+445BQ==
X-Received: by 2002:a17:902:7c8c:b029:d4:e5b2:fba4 with SMTP id y12-20020a1709027c8cb02900d4e5b2fba4mr4000089pll.82.1602677967023;
        Wed, 14 Oct 2020 05:19:27 -0700 (PDT)
Received: from [192.168.0.104] ([49.207.205.44])
        by smtp.gmail.com with ESMTPSA id e186sm3311416pfh.60.2020.10.14.05.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 05:19:26 -0700 (PDT)
Subject: Re: [Cluster-devel] KASAN: slab-out-of-bounds Write in
 gfs2_fill_super
To:     Andrew Price <anprice@redhat.com>
References: <0000000000006903b205b0873061@google.com>
 <21b7b508-c8f2-4730-7a1d-b4376effcce0@redhat.com>
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     syzbot <syzbot+af90d47a37376844e731@syzkaller.appspotmail.com>,
        agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
        syzkaller-bugs@googlegroups.com
Message-ID: <ceed2e5f-c03e-721f-ba2f-a581d6214e5c@gmail.com>
Date:   Wed, 14 Oct 2020 17:49:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <21b7b508-c8f2-4730-7a1d-b4376effcce0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/09/20 7:52 pm, Andrew Price wrote:
> On 30/09/2020 13:39, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    fb0155a0 Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13458c0f900000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=adebb40048274f92
>> dashboard link: https://syzkaller.appspot.com/bug?extid=af90d47a37376844e731
>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c307d3900000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1353d58d900000
>>
>> Bisection is inconclusive: the issue happens on the oldest tested release.
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=106acbbb900000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=126acbbb900000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=146acbbb900000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+af90d47a37376844e731@syzkaller.appspotmail.com
>>
>> gfs2: fsid=loop0: Trying to join cluster "lock_nolock", "loop0"
>> gfs2: fsid=loop0: Now mounting FS...
>> ==================================================================
>> BUG: KASAN: slab-out-of-bounds in gfs2_read_sb fs/gfs2/ops_fstype.c:342 [inline]
>> BUG: KASAN: slab-out-of-bounds in init_sb fs/gfs2/ops_fstype.c:479 [inline]
>> BUG: KASAN: slab-out-of-bounds in gfs2_fill_super+0x1db5/0x3fe0 fs/gfs2/ops_fstype.c:1096
>> Write of size 8 at addr ffff88809073d548 by task syz-executor940/6853
>
> Bug filed for this:
>
> https://bugzilla.redhat.com/show_bug.cgi?id=1883929
>
> Andy
>
>> CPU: 1 PID: 6853 Comm: syz-executor940 Not tainted 5.9.0-rc7-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:77 [inline]
>>   dump_stack+0x1d6/0x29e lib/dump_stack.c:118
>>   print_address_description+0x66/0x620 mm/kasan/report.c:383
>>   __kasan_report mm/kasan/report.c:513 [inline]
>>   kasan_report+0x132/0x1d0 mm/kasan/report.c:530
>>   gfs2_read_sb fs/gfs2/ops_fstype.c:342 [inline]
>>   init_sb fs/gfs2/ops_fstype.c:479 [inline]
>>   gfs2_fill_super+0x1db5/0x3fe0 fs/gfs2/ops_fstype.c:1096
>>   get_tree_bdev+0x3e9/0x5f0 fs/super.c:1342
>>   gfs2_get_tree+0x4c/0x1f0 fs/gfs2/ops_fstype.c:1201
>>   vfs_get_tree+0x88/0x270 fs/super.c:1547
>>   do_new_mount fs/namespace.c:2875 [inline]
>>   path_mount+0x179d/0x29e0 fs/namespace.c:3192
>>   do_mount fs/namespace.c:3205 [inline]
>>   __do_sys_mount fs/namespace.c:3413 [inline]
>>   __se_sys_mount+0x126/0x180 fs/namespace.c:3390
>>   do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> RIP: 0033:0x446dba
>> Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00
>> RSP: 002b:00007fff4c56e748 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5
>> RAX: ffffffffffffffda RBX: 00007fff4c56e7a0 RCX: 0000000000446dba
>> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007fff4c56e760
>> RBP: 00007fff4c56e760 R08: 00007fff4c56e7a0 R09: 00007fff00000015
>> R10: 0000000002200000 R11: 0000000000000293 R12: 0000000000000001
>> R13: 0000000000000004 R14: 0000000000000003 R15: 0000000000000003
>>
>> Allocated by task 6853:
>>   kasan_save_stack mm/kasan/common.c:48 [inline]
>>   kasan_set_track mm/kasan/common.c:56 [inline]
>>   __kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461
>>   kmem_cache_alloc_trace+0x1e4/0x2e0 mm/slab.c:3554
>>   kmalloc include/linux/slab.h:554 [inline]
>>   kzalloc include/linux/slab.h:666 [inline]
>>   init_sbd fs/gfs2/ops_fstype.c:77 [inline]
>>   gfs2_fill_super+0xb6/0x3fe0 fs/gfs2/ops_fstype.c:1018
>>   get_tree_bdev+0x3e9/0x5f0 fs/super.c:1342
>>   gfs2_get_tree+0x4c/0x1f0 fs/gfs2/ops_fstype.c:1201
>>   vfs_get_tree+0x88/0x270 fs/super.c:1547
>>   do_new_mount fs/namespace.c:2875 [inline]
>>   path_mount+0x179d/0x29e0 fs/namespace.c:3192
>>   do_mount fs/namespace.c:3205 [inline]
>>   __do_sys_mount fs/namespace.c:3413 [inline]
>>   __se_sys_mount+0x126/0x180 fs/namespace.c:3390
>>   do_syscall_64+0x31/0x70 arch/x86/entry/common.c:46
>>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> The buggy address belongs to the object at ffff88809073c000
>>   which belongs to the cache kmalloc-8k of size 8192
>> The buggy address is located 5448 bytes inside of
>>   8192-byte region [ffff88809073c000, ffff88809073e000)
>> The buggy address belongs to the page:
>> page:00000000bd4b0b2d refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9073c
>> head:00000000bd4b0b2d order:2 compound_mapcount:0 compound_pincount:0
>> flags: 0xfffe0000010200(slab|head)
>> raw: 00fffe0000010200 ffffea00028e5608 ffff8880aa441b50 ffff8880aa440a00
>> raw: 0000000000000000 ffff88809073c000 0000000100000001 0000000000000000
>> page dumped because: kasan: bad access detected
>>
>> Memory state around the buggy address:
>>   ffff88809073d400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>   ffff88809073d480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>> ffff88809073d500: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
>>                                                ^
>>   ffff88809073d580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff88809073d600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>> ==================================================================
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
>> syzbot can test patches for this issue, for details see:
>> https://goo.gl/tpsmEJ#testing-patches
>>
>

Just saw this report.
This seems to be the same as
    https://syzkaller.appspot.com/bug?extid=a5e2482a693e6b1e444b ,
for which I have recently sent in a fix (https://lkml.org/lkml/2020/10/13/588).

Since the "Reported-by" tag in the patch sent is for the other instance of the
same crash, can we close this one as a duplicate?

Thanks,
Anant

