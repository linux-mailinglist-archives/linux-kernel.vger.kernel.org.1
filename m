Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71CFD2C8D52
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbgK3Sxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:53:44 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:44612 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387915AbgK3Sxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:53:43 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjoIG-004rYv-H6; Mon, 30 Nov 2020 11:53:00 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjoIF-0003ON-BM; Mon, 30 Nov 2020 11:53:00 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     syzbot <syzbot+71c4697e27c99fddcf17@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, bernd.edlinger@hotmail.de,
        chris@chrisdown.name, dhowells@redhat.com, guro@fb.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, Jens Axboe <axboe@kernel.dk>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
References: <0000000000000a440b05b522a284@google.com>
Date:   Mon, 30 Nov 2020 12:52:29 -0600
In-Reply-To: <0000000000000a440b05b522a284@google.com> (syzbot's message of
        "Fri, 27 Nov 2020 19:47:15 -0800")
Message-ID: <87pn3uisnm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kjoIF-0003ON-BM;;;mid=<87pn3uisnm.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+ILnQS2NT47RlK147nvBnj3528Nk+k3Us=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;syzbot <syzbot+71c4697e27c99fddcf17@syzkaller.appspotmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 684 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 10 (1.4%), parse: 1.41
        (0.2%), extract_message_metadata: 26 (3.8%), get_uri_detail_list: 5
        (0.8%), tests_pri_-1000: 6 (0.9%), tests_pri_-950: 1.26 (0.2%),
        tests_pri_-900: 1.04 (0.2%), tests_pri_-90: 143 (21.0%), check_bayes:
        131 (19.2%), b_tokenize: 11 (1.6%), b_tok_get_all: 10 (1.4%),
        b_comp_prob: 4.1 (0.6%), b_tok_touch_all: 103 (15.0%), b_finish: 0.95
        (0.1%), tests_pri_0: 480 (70.2%), check_dkim_signature: 0.88 (0.1%),
        check_dkim_adsp: 2.9 (0.4%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 6 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: memory leak in prepare_creds
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+71c4697e27c99fddcf17@syzkaller.appspotmail.com> writes:

> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    99c710c4 Merge tag 'platform-drivers-x86-v5.10-2' of git:/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12a77ddd500000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=c7a27a77f20fbc95
> dashboard link: https://syzkaller.appspot.com/bug?extid=71c4697e27c99fddcf17
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12d6161d500000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16f15e65500000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+71c4697e27c99fddcf17@syzkaller.appspotmail.com

My guess is someones error cleanup somewhere did the wrong thing.

It looks like there was one forced failure in tomoyo and the rest were
in io_uring.  Adding the relevant maintainers perhaps one of them can
see the problem.

>
> BUG: memory leak
> unreferenced object 0xffff888101401300 (size 168):
>   comm "syz-executor355", pid 8461, jiffies 4294953658 (age 32.400s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000caa0de2b>] prepare_creds+0x25/0x390 kernel/cred.c:258
>     [<000000001821b99d>] copy_creds+0x3a/0x230 kernel/cred.c:358
>     [<0000000022c32914>] copy_process+0x661/0x24d0 kernel/fork.c:1971
>     [<00000000d3adca2d>] kernel_clone+0xf3/0x670 kernel/fork.c:2456
>     [<00000000d11b7286>] __do_sys_clone+0x76/0xa0 kernel/fork.c:2573
>     [<000000008280baad>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>     [<00000000685d8cf0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff88810b0a6f20 (size 32):
>   comm "syz-executor355", pid 8461, jiffies 4294953658 (age 32.400s)
>   hex dump (first 32 bytes):
>     b0 6e 93 00 81 88 ff ff 00 00 00 00 00 00 00 00  .n..............
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<000000007d750ba1>] kmalloc include/linux/slab.h:557 [inline]
>     [<000000007d750ba1>] kzalloc include/linux/slab.h:664 [inline]
>     [<000000007d750ba1>] lsm_cred_alloc security/security.c:533 [inline]
>     [<000000007d750ba1>] security_prepare_creds+0xa5/0xd0 security/security.c:1632
>     [<00000000ba63fcc7>] prepare_creds+0x277/0x390 kernel/cred.c:285
>     [<000000001821b99d>] copy_creds+0x3a/0x230 kernel/cred.c:358
>     [<0000000022c32914>] copy_process+0x661/0x24d0 kernel/fork.c:1971
>     [<00000000d3adca2d>] kernel_clone+0xf3/0x670 kernel/fork.c:2456
>     [<00000000d11b7286>] __do_sys_clone+0x76/0xa0 kernel/fork.c:2573
>     [<000000008280baad>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>     [<00000000685d8cf0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> BUG: memory leak
> unreferenced object 0xffff888101ea2200 (size 256):
>   comm "syz-executor355", pid 8470, jiffies 4294953658 (age 32.400s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     20 59 03 01 81 88 ff ff 80 87 a8 10 81 88 ff ff   Y..............
>   backtrace:
>     [<000000002e0a7c5f>] kmem_cache_zalloc include/linux/slab.h:654 [inline]
>     [<000000002e0a7c5f>] __alloc_file+0x1f/0x130 fs/file_table.c:101
>     [<000000001a55b73a>] alloc_empty_file+0x69/0x120 fs/file_table.c:151
>     [<00000000fb22349e>] alloc_file+0x33/0x1b0 fs/file_table.c:193
>     [<000000006e1465bb>] alloc_file_pseudo+0xb2/0x140 fs/file_table.c:233
>     [<000000007118092a>] anon_inode_getfile fs/anon_inodes.c:91 [inline]
>     [<000000007118092a>] anon_inode_getfile+0xaa/0x120 fs/anon_inodes.c:74
>     [<000000002ae99012>] io_uring_get_fd fs/io_uring.c:9198 [inline]
>     [<000000002ae99012>] io_uring_create fs/io_uring.c:9377 [inline]
>     [<000000002ae99012>] io_uring_setup+0x1125/0x1630 fs/io_uring.c:9411
>     [<000000008280baad>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>     [<00000000685d8cf0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

Eric
