Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACFD28173D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbgJBP4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:56:54 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:50006 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387869AbgJBP4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:56:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kONQS-006hA3-Ex; Fri, 02 Oct 2020 09:56:52 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kONQR-0002tx-7y; Fri, 02 Oct 2020 09:56:52 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     syzbot <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, christian@brauner.io,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        oleg@redhat.com, syzkaller-bugs@googlegroups.com,
        Tejun Heo <tj@kernel.org>
References: <000000000000da06e405b0b20f1e@google.com>
Date:   Fri, 02 Oct 2020 10:56:08 -0500
In-Reply-To: <000000000000da06e405b0b20f1e@google.com> (syzbot's message of
        "Fri, 02 Oct 2020 08:48:20 -0700")
Message-ID: <87zh54bp0n.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kONQR-0002tx-7y;;;mid=<87zh54bp0n.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX196hOFya/wySqHa6u192rm/IRZtAuTnIvg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,SORTED_RECIPS,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  2.5 SORTED_RECIPS Recipient list is sorted by address
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;syzbot
        <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 778 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 10 (1.3%), b_tie_ro: 9 (1.2%), parse: 0.90 (0.1%),
         extract_message_metadata: 20 (2.6%), get_uri_detail_list: 4.1 (0.5%),
        tests_pri_-1000: 15 (2.0%), tests_pri_-950: 1.19 (0.2%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 297 (38.2%), check_bayes:
        293 (37.6%), b_tokenize: 12 (1.5%), b_tok_get_all: 9 (1.1%),
        b_comp_prob: 3.3 (0.4%), b_tok_touch_all: 265 (34.0%), b_finish: 0.83
        (0.1%), tests_pri_0: 421 (54.1%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.4 (0.3%), poll_dns_idle: 0.70 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 6 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: WARNING in get_signal
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com> writes:

> Hello,
>
> syzbot found the following issue on:

So this is:

static void do_jobctl_trap(void)
{
	struct signal_struct *signal = current->signal;
	int signr = current->jobctl & JOBCTL_STOP_SIGMASK;

	if (current->ptrace & PT_SEIZED) {
		if (!signal->group_stop_count &&
		    !(signal->flags & SIGNAL_STOP_STOPPED))
			signr = SIGTRAP;
		WARN_ON_ONCE(!signr);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		ptrace_do_notify(signr, signr | (PTRACE_EVENT_STOP << 8),
				 CLD_STOPPED);
	} else {
		WARN_ON_ONCE(!signr);
		ptrace_stop(signr, CLD_STOPPED, 0, NULL);
		current->exit_code = 0;
	}
}

I have the state of this paged out of my head at the moment.

Oleg or Tejun do you remember what is supposed to keep signr from being
NULL?


It looks like this code was introduced in commit 73ddff2bee15 ("job
control: introduce JOBCTL_TRAP_STOP and use it for group stop trap").

Eric


> HEAD commit:    fcadab74 Merge tag 'drm-fixes-2020-10-01-1' of git://anong..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=116865bd900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=89ab6a0c48f30b49
> dashboard link: https://syzkaller.appspot.com/bug?extid=3485e3773f7da290eecc
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1211120b900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16474c67900000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3485e3773f7da290eecc@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6899 at kernel/signal.c:2431 do_jobctl_trap kernel/signal.c:2431 [inline]
> WARNING: CPU: 1 PID: 6899 at kernel/signal.c:2431 get_signal+0x1b5c/0x1f00 kernel/signal.c:2621
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 6899 Comm: syz-executor116 Not tainted 5.9.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x198/0x1fd lib/dump_stack.c:118
>  panic+0x382/0x7fb kernel/panic.c:231
>  __warn.cold+0x20/0x4b kernel/panic.c:600
>  report_bug+0x1bd/0x210 lib/bug.c:198
>  handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> RIP: 0010:do_jobctl_trap kernel/signal.c:2431 [inline]
> RIP: 0010:get_signal+0x1b5c/0x1f00 kernel/signal.c:2621
> Code: 00 48 c7 c2 40 da 8a 88 be d1 09 00 00 48 c7 c7 a0 da 8a 88 c6 05 09 8c 09 0a 01 e8 43 97 11 00 e9 42 f5 ff ff e8 14 78 2b 00 <0f> 0b 41 bc 00 80 00 00 e9 49 f9 ff ff 4c 89 ef e8 bf 4d 6c 00 e9
> RSP: 0018:ffffc90005537ce8 EFLAGS: 00010093
> RAX: 0000000000000000 RBX: 0000000100000000 RCX: ffffffff814abfc3
> RDX: ffff88809315c580 RSI: ffffffff814ac67c RDI: 0000000000000005
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffff88809315ca0f
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000008000
> R13: 0000000000000000 R14: 0000000000000000 R15: dffffc0000000000
>  arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
>  exit_to_user_mode_loop kernel/entry/common.c:161 [inline]
>  exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:192
>  syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:267
>  ret_from_fork+0x15/0x30 arch/x86/entry/entry_64.S:287
> RIP: 0033:0x446809
> Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 8b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fbb8cdd1db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
> RAX: 0000000000000000 RBX: 00000000006dbc28 RCX: 0000000000446809
> RDX: 9999999999999999 RSI: 0000000000000000 RDI: 000000000007a900
> RBP: 00000000006dbc20 R08: ffffffffffffffff R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
> R13: 00007ffeca1e9fef R14: 00007fbb8cdd29c0 R15: 20c49ba5e353f7cf
> Shutting down cpus with NMI
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches
