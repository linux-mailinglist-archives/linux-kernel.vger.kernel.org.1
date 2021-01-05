Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B82C52EAFAE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 17:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbhAEQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 11:09:05 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53306 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbhAEQJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 11:09:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105FswP6031230;
        Tue, 5 Jan 2021 16:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : references :
 from : subject : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=a7lazw+o5bG1BG1FvcfTi39pguOq+bPDtfgcTIrdSV0=;
 b=Y7T+UnwpjZjFG83EyPV6Bcpx8ilTUZKzVi82GDIKVN8pPxzu3Om9UHZx1hQWoWd+kpQ2
 g9KEhwcKlTlo9iCgF5drBgH4lkO10naIO/+0cfhoUyadFwoY/5TUDodi84vKgppaDkZi
 5Z/muc2AbR3GqSDw1JDNEEza68kNYzWxuQ3j/uqzOwz471m3rwikAxV5XQDq5Ock+8Jp
 v/QyP0rUU3w1DZiGYf3vGqeepWExwV3uqQs750+Z2Z1N3WwHk46FtEGp08QyeniKmoUi
 kszQLr/72FAnaejDxgIcfpxQyMNGDgmzoCXGHKDZBSc4VdEHkrMPLx3Ls+B6vFYTUsP1 WQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35tgsksfx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 16:08:02 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 105FuNlu029088;
        Tue, 5 Jan 2021 16:08:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35uxnsv9g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 16:08:01 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 105G80pg017620;
        Tue, 5 Jan 2021 16:08:00 GMT
Received: from [192.168.0.190] (/68.201.65.98)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 16:08:00 +0000
To:     syzbot <syzbot+d0d8d1bfd19a85de7703@syzkaller.appspotmail.com>,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com,
        Randy Dunlap <rdunlap@infradead.org>
References: <00000000000059589a05b826cdad@google.com>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: Re: UBSAN: shift-out-of-bounds in diReadSpecial
Message-ID: <384c40c7-9dfd-db1f-1eca-3da42cac4af7@oracle.com>
Date:   Tue, 5 Jan 2021 10:07:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <00000000000059589a05b826cdad@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050099
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9855 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I suspect Randy Dunlap's fix for
https://syzkaller.appspot.com/bug?extid=36315852ece4132ec193
will take care of this one as well:
https://github.com/kleikamp/linux-shaggy/commit/3bef198f1b17d1bb89260bad947ef084c0a2d1a6

sbi->l2nbperpage is derived from sbi->l2bsize, which is sanity checked
by Randy's patch.

#syz dup: UBSAN: shift-out-of-bounds in chkSuper

Shaggy

On 1/5/21 7:01 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    614cb589 Merge tag 'acpi-5.11-rc1-2' of git://git.kernel.o..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10e4ffbd500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf519e1e96191576
> dashboard link: https://syzkaller.appspot.com/bug?extid=d0d8d1bfd19a85de7703
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d0d8d1bfd19a85de7703@syzkaller.appspotmail.com
> 
> ================================================================================
> UBSAN: shift-out-of-bounds in fs/jfs/jfs_imap.c:445:7
> shift exponent -19 is negative
> CPU: 0 PID: 11254 Comm: syz-executor.2 Not tainted 5.10.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:79 [inline]
>   dump_stack+0x107/0x163 lib/dump_stack.c:120
>   ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
>   __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
>   diReadSpecial.cold+0x1b/0x3e fs/jfs/jfs_imap.c:445
>   jfs_mount+0x83/0x3d0 fs/jfs/jfs_mount.c:86
>   jfs_fill_super+0x5b1/0xbc0 fs/jfs/super.c:562
>   mount_bdev+0x34d/0x410 fs/super.c:1366
>   legacy_get_tree+0x105/0x220 fs/fs_context.c:592
>   vfs_get_tree+0x89/0x2f0 fs/super.c:1496
>   do_new_mount fs/namespace.c:2875 [inline]
>   path_mount+0x13ad/0x20c0 fs/namespace.c:3205
>   do_mount fs/namespace.c:3218 [inline]
>   __do_sys_mount fs/namespace.c:3426 [inline]
>   __se_sys_mount fs/namespace.c:3403 [inline]
>   __x64_sys_mount+0x27f/0x300 fs/namespace.c:3403
>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x460b9a
> Code: b8 a6 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 ad 89 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 8a 89 fb ff c3 66 0f 1f 84 00 00 00 00 00
> RSP: 002b:00007f2ed35f4a78 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007f2ed35f4b10 RCX: 0000000000460b9a
> RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f2ed35f4ad0
> RBP: 00007f2ed35f4ad0 R08: 00007f2ed35f4b10 R09: 0000000020000000
> R10: 0000000000000000 R11: 0000000000000202 R12: 0000000020000000
> R13: 0000000020000100 R14: 0000000020000200 R15: 000000002006d200
> ================================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
