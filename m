Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE52E28DB84
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgJNI3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgJNI3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:29:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A4DC051125
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:52:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d23so1329335pll.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:subject:cc:from:in-reply-to:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8dTw1vdHe05pw7PwZ6jgowSrJqqbe0weLTZIFqcmFiI=;
        b=tDmwgwNSsEMcpJim7gwfRmCEiX3G9cYDSv3OTAKxhVvsmJEE1WP3V1aYgRvPm7l7PB
         DYNgS4j6iuuXyvxtkCitKl5gr67+dQzJdjrr5wLF3Nc0Q+NTdCjjcVT8+odz8U9uBmGJ
         icwB1TkhzfMxxlMyy0N6jm2B/JzMvLLzXI1pl4bfanA6y5wVXQPxAOg05Tvh0NPZPJ14
         i4ajrPWTCD3PWUVKwUuUieY21t2VouzvJFlDdqlAMoGlPOv0STprVen80DPUGVyPyy3N
         z3gN4HC6n3tkcDd5xlN5u0MRa+GvtEzlSirkTPm3Ra77XL4fDqNGV+I+W7v+FataJs0C
         yRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:cc:from:in-reply-to:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=8dTw1vdHe05pw7PwZ6jgowSrJqqbe0weLTZIFqcmFiI=;
        b=R6f83/Z5PcboirqtymCt7k9Vl/Cc1fUI43QU01C3eEgcyilpXPA8rG6aOsyv4xMbAs
         BNQiU+QwbAdTKqgf/7DhHuNsegUVy6IUMShjqogCpcLZ7Us1AobTQMLTvgPih5hsflob
         C1+IfRseRHBvd9OKY96eW2DkEALOvoAePgF/spZWAsM3ldRJMaSkYm2s+ln7bMgtyIqs
         bmqxTql/SPf5p4KDZz1VnKillwl64FY+oLa8+YPN5T0jA+WM0Gyzjs83pR+TQQslrfZ9
         NOdcm7vaIAALXzMFftQyqAM7aNjHfL02Xs+DsZXC90ASyLhFRjTThGo07gzngPqCzWi0
         qBEQ==
X-Gm-Message-State: AOAM533rXGOq1dqBG+D5cq2uvgwQudkG9InNwzuuI99GWpCptpDOWKAc
        OMXXe0nnh9ODKPlosPRcBmXq/7z0mYNniw==
X-Google-Smtp-Source: ABdhPJxaSQeVs6ZWyYu2mb8WLo8H+b0T7fe/8bQho7I9qGEwHL4QEv5BAvtmwp5nVeMGELbiNteclA==
X-Received: by 2002:a17:90a:b287:: with SMTP id c7mr2334114pjr.141.1602661940853;
        Wed, 14 Oct 2020 00:52:20 -0700 (PDT)
Received: from fox-laptop.local ([162.216.240.138])
        by smtp.gmail.com with ESMTPSA id k127sm2241140pgk.10.2020.10.14.00.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 00:52:20 -0700 (PDT)
To:     phillip@squashfs.org.uk, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: slab-out-of-bounds Read in squashfs_get_id
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
From:   Fox Chen <foxhlchen@gmail.com>
In-Reply-To: <0000000000002954fa05b02468d7@google.com>
Message-ID: <ac68c9ef-5475-b248-9dbf-0bae7cde738a@gmail.com>
Date:   Wed, 14 Oct 2020 15:52:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I found this bug was caused by either uid/gid info in superblocks or 
id_index_table is corrupted. The uid/gid index is larger than the size 
of msblk->id_table.

Should I add a sanity check to squashfs_get_id??

The complete solution is to record the size of msblk->id_table in msblk 
and check uid/gid index each time in squashfs_get_id. However, this 
requires a change to msblk struct.

A simple solution is to calculate the max available room for uid/gid 
table by doing msblk->xattr_table - msblk->id_table[0] and check if 
index is larger than this. While this provides some sort of check, it is 
imperfect because id_table can be smaller than that.
Both of them work out for this bug.


thanks,
fox

On Friday, September 25, 2020 at 10:48:18 PM UTC+8 syzbot wrote:
Hello,
syzbot found the following issue on:
HEAD commit: 171d4ff7 Merge tag 'mmc-v5.9-rc4-2' of 
git://git.kernel.or.. git tree: upstream console output: 
https://syzkaller.appspot.com/x/log.txt?x=1597ead3900000 kernel config: 
https://syzkaller.appspot.com/x/.config?x=af502ec9a451c9fc dashboard 
link: https://syzkaller.appspot.com/bug?extid=8e28bba73ed1772a6802 
compiler: clang version 10.0.0 (https://github.com/llvm/llvm-project/ 
c2443155a0fb245c8f17f2c1c72b6ea391e86e81) syz repro: 
https://syzkaller.appspot.com/x/repro.syz?x=172ff481900000 C reproducer: 
https://syzkaller.appspot.com/x/repro.c?x=17c3e6c5900000
IMPORTANT: if you fix the issue, please add the following tag to the 
commit: Reported-by: syzbot+8e28bb...@syzkaller.appspotmail.com
================================================================== BUG: 
KASAN: slab-out-of-bounds in squashfs_get_id+0xb9/0x1c0 
fs/squashfs/id.c:38 Read of size 8 at addr ffff8880a9684b98 by task 
syz-executor329/6836
CPU: 1 PID: 6836 Comm: syz-executor329 Not tainted 5.9.0-rc6-syzkaller 
#0 Hardware name: Google Google Compute Engine/Google Compute Engine, 
BIOS Google 01/01/2011 Call Trace: __dump_stack lib/dump_stack.c:77 
[inline] dump_stack+0x1d6/0x29e lib/dump_stack.c:118 
print_address_description+0x66/0x620 mm/kasan/report.c:383 
__kasan_report mm/kasan/report.c:513 [inline] kasan_report+0x132/0x1d0 
mm/kasan/report.c:530 squashfs_get_id+0xb9/0x1c0 fs/squashfs/id.c:38 
squashfs_new_inode fs/squashfs/inode.c:51 [inline] 
squashfs_read_inode+0x155/0x2170 fs/squashfs/inode.c:120 
squashfs_fill_super+0x1478/0x1790 fs/squashfs/super.c:310 
get_tree_bdev+0x3e9/0x5f0 fs/super.c:1342 vfs_get_tree+0x88/0x270 
fs/super.c:1547 do_new_mount fs/namespace.c:2875 [inline] 
path_mount+0x179d/0x29e0 fs/namespace.c:3192 do_mount 
fs/namespace.c:3205 [inline] __do_sys_mount fs/namespace.c:3413 [inline] 
__se_sys_mount+0x126/0x180 fs/namespace.c:3390 do_syscall_64+0x31/0x70 
arch/x86/entry/common.c:46 entry_SYSCALL_64_after_hwframe+0x44/0xa9 RIP: 
0033:0x446d1a Code: b8 08 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 fd ad 
fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 
05 <48> 3d 01 f0 ff ff 0f 83 da ad fb ff c3 66 0f 1f 84 00 00 00 00 00 
RSP: 002b:00007ffd7dd4f8b8 EFLAGS: 00000293 ORIG_RAX: 00000000000000a5 
RAX: ffffffffffffffda RBX: 00007ffd7dd4f910 RCX: 0000000000446d1a RDX: 
0000000020000000 RSI: 0000000020000100 RDI: 00007ffd7dd4f8d0 RBP: 
00007ffd7dd4f8d0 R08: 00007ffd7dd4f910 R09: 00007ffd00000015 R10: 
0000000000000000 R11: 0000000000000293 R12: 0000000000000001 R13: 
0000000000000004 R14: 0000000000000003 R15: 0000000000000003
Allocated by task 3913: kasan_save_stack mm/kasan/common.c:48 [inline] 
kasan_set_track mm/kasan/common.c:56 [inline] 
__kasan_kmalloc+0x100/0x130 mm/kasan/common.c:461 kmalloc_node 
include/linux/slab.h:577 [inline] __vmalloc_area_node mm/vmalloc.c:2429 
[inline] __vmalloc_node_range+0x2c7/0x870 mm/vmalloc.c:2511 
module_alloc+0x7e/0x90 arch/x86/kernel/module.c:75 
bpf_jit_binary_alloc+0x123/0x230 kernel/bpf/core.c:871 
bpf_int_jit_compile+0x7995/0x8920 arch/x86/net/bpf_jit_comp.c:1911 
bpf_prog_select_runtime+0x76d/0xa60 kernel/bpf/core.c:1807 
bpf_migrate_filter net/core/filter.c:1290 [inline] 
bpf_prepare_filter+0xec2/0x1140 net/core/filter.c:1338 
bpf_prog_create_from_user+0x2ad/0x3e0 net/core/filter.c:1432 
seccomp_prepare_filter kernel/seccomp.c:567 [inline] 
seccomp_prepare_user_filter kernel/seccomp.c:604 [inline] 
seccomp_set_mode_filter kernel/seccomp.c:1546 [inline] 
do_seccomp+0x852/0x20b0 kernel/seccomp.c:1661 do_syscall_64+0x31/0x70 
arch/x86/entry/common.c:46 entry_SYSCALL_64_after_hwframe+0x44/0xa9
The buggy address belongs to the object at ffff8880a9684b80 which 
belongs to the cache kmalloc-32 of size 32 The buggy address is located 
24 bytes inside of 32-byte region [ffff8880a9684b80, ffff8880a9684ba0) 
The buggy address belongs to the page: page:00000000f697ca3d refcount:1 
mapcount:0 mapping:0000000000000000 index:0xffff8880a9684fc1 pfn:0xa9684 
flags: 0xfffe0000000200(slab) raw: 00fffe0000000200 ffffea0002a5d5c8 
ffffea0002a98588 ffff8880aa440100 raw: ffff8880a9684fc1 ffff8880a9684000 
000000010000003f 0000000000000000 page dumped because: kasan: bad access 
detected
Memory state around the buggy address: ffff8880a9684a80: fa fb fb fb fc 
fc fc fc fa fb fb fb fc fc fc fc ffff8880a9684b00: 00 fc fc fc fc fc fc 
fc fa fb fb fb fc fc fc fc >ffff8880a9684b80: 00 fc fc fc fc fc fc fc fa 
fb fb fb fc fc fc fc ^ ffff8880a9684c00: fa fb fb fb fc fc fc fc fa fb 
fb fb fc fc fc fc ffff8880a9684c80: 00 00 01 fc fc fc fc fc fa fb fb fb 
fc fc fc fc 
==================================================================

--- This report is generated by a bot. It may contain errors. See 
https://goo.gl/tpsmEJ for more information about syzbot. syzbot 
engineers can be reached at syzk...@googlegroups.com.
syzbot will keep track of this issue. See: https://goo.gl/tpsmEJ#status 
for how to communicate with syzbot. syzbot can test patches for this 
issue, for details see: https://goo.gl/tpsmEJ#testing-patches
