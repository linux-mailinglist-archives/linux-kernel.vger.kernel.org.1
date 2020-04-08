Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 017581A24D1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 17:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgDHPRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 11:17:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59702 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgDHPRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:17:02 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMCRo-0003vB-Tz; Wed, 08 Apr 2020 09:17:00 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMCRn-0005Ft-WC; Wed, 08 Apr 2020 09:17:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
        <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
        <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
        <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
        <87lfnda3w3.fsf@x220.int.ebiederm.org>
        <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
        <87blo45keg.fsf@x220.int.ebiederm.org>
        <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
Date:   Wed, 08 Apr 2020 10:14:09 -0500
In-Reply-To: <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 7 Apr 2020 12:50:52 -0700")
Message-ID: <87v9maxb5q.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMCRn-0005Ft-WC;;;mid=<87v9maxb5q.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18IElz77CBQfmTS9aa6PTkXWD7jLB72d6E=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4793]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 535 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 8 (1.6%), b_tie_ro: 7 (1.4%), parse: 0.88 (0.2%),
        extract_message_metadata: 15 (2.9%), get_uri_detail_list: 1.74 (0.3%),
        tests_pri_-1000: 19 (3.5%), tests_pri_-950: 1.25 (0.2%),
        tests_pri_-900: 1.03 (0.2%), tests_pri_-90: 117 (21.9%), check_bayes:
        101 (18.9%), b_tokenize: 11 (2.1%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 4.0 (0.8%), b_tok_touch_all: 72 (13.5%), b_finish: 1.04
        (0.2%), tests_pri_0: 359 (67.1%), check_dkim_signature: 0.83 (0.2%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.66 (0.1%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Apr 6, 2020 at 3:20 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> But fundamentally the only reason we need this information stable
>> before the point of no return is so that we can return a nice error
>> code to the process calling exec.  Instead of terminating the
>> process with SIGSEGV.
>
> I'd suggest doing it the other way around instead: let the thread that
> does the security_setprocattr() die, since execve() is terminating
> other threads anyway.
>
> And the easy way to do that is to just make the rule be that anybody
> who waits for this thing for write needs to use a killable wait.
>
> So if the execve() got started earlier, and already took the cred lock
> (whatever we'll call it) for reading, then zap_other_threads() will
> take care of another thread doing setprocattr().
>
> That sounds like a really simple model, no?

Yes.  I missed the fact that we could take the lock killable.
We still unfortunately have the deadlock with ptrace.

It might be simpler to make whichever lock we are dealing with per
task_struct instead of per signal_struct.  Then we don't even have to
think about what de_thread does or if the lock is taken killable.


Looking at the code in binfmt_elf.c there are about 11 other places
after install_exec_creds where we can fail and would be forced to
terminate the application with SIGSEGV instead of causing fork to fail.




I keep wondering if we could do something similar to vfork.  That is
allocate an new task_struct and fully set it up for the post exec
process, and then make it visible under tasklist_lock.  Finally we could
free the old process.

That would appear as if everything happened atomically from
the point of view of the rest of the kernel.

As well as fixing all of the deadlocks and making it easy
to ensure we don't have any more weird failures in the future.

Eric

p.s. For tasklist_lock I suspect we can put a lock in struct pid
and use that to guard the task lists in struct pid.  Which would
allow for tasklist_lock to be take much less.  Then we would
just need a solution for task->parent and task->real_parent and
I think all of the major users of tasklist_lock would be gone.


