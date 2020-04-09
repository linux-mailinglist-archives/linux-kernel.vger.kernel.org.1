Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBA801A3676
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 17:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgDIPBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 11:01:03 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47558 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgDIPBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:01:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMYft-0006Ep-WE; Thu, 09 Apr 2020 09:01:02 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMYft-00016T-3C; Thu, 09 Apr 2020 09:01:01 -0600
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
        <87v9maxb5q.fsf@x220.int.ebiederm.org>
        <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
Date:   Thu, 09 Apr 2020 09:58:09 -0500
In-Reply-To: <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 8 Apr 2020 09:34:47 -0700")
Message-ID: <87y2r4so3i.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMYft-00016T-3C;;;mid=<87y2r4so3i.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/wmCXIWdycpFYe9E/5SZbgXSc0P7Notj0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: ****
X-Spam-Status: No, score=4.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMGppyBdWords,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  2.5 XMGppyBdWords BODY: Gappy or l33t words
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 512 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.0%), b_tie_ro: 9 (1.7%), parse: 0.97 (0.2%),
         extract_message_metadata: 14 (2.7%), get_uri_detail_list: 2.3 (0.5%),
        tests_pri_-1000: 20 (3.8%), tests_pri_-950: 1.07 (0.2%),
        tests_pri_-900: 0.88 (0.2%), tests_pri_-90: 78 (15.2%), check_bayes:
        76 (14.9%), b_tokenize: 8 (1.6%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 3.2 (0.6%), b_tok_touch_all: 52 (10.1%), b_finish: 1.05
        (0.2%), tests_pri_0: 375 (73.2%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.24 (0.0%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, Apr 8, 2020 at 8:17 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Yes.  I missed the fact that we could take the lock killable.
>> We still unfortunately have the deadlock with ptrace.
>
> That, I feel, is similarly trivial.
>
> Again, anybody who takes the lock for writing should just do so
> killably. So you have three cases:
>
>  - ptrace wins the race and gets the lock.
>
>    Fine, the execve will wait until afterwards.
>
>  - ptrace loses the race and is not a thread with execve.
>
>    Fine, the execve() won, and the ptrace will wait until after execve.
>
>  - ptrace loses the race and is a thread with execve.
>
>    Fine, the execve() will kill the thing in dethread() and the ptrace
> thread will release the lock and die.

That would be nice.

That is unfortunately not how ptrace_event(PTRACE_EVENT_EXIT, ...) works.

When a thread going about it's ordinary business receives the SIGKILL
from de_thread the thread changes course and finds it's way to do_exit.
In do_exit the thread calls ptrace_event(PTRACE_EVENT_EXIT, ...) and
blocks waiting for the tracer to let it continue.

Further from previous attempts to fix this we know that there
are pieces of userspace expect that stop to happen.  So if the
PTRACE_EVENT_EXIT stop does not happen userspace which is already
attached breaks.

Further this case with ptrace is something we know userspace
does and is is just a matter of bad timing of attaching to the
threads when one thread is exec'ing.  So we don't even need to wonder if
userspace would do such a silling thing.



There are a lot similar cases that can happen if userspace inserts
itself into the path of page faults, directly or indirectly,
as long as some wait somewhere ultimately waits for a ptrace attach.


> So all three cases are fine, and none of them have any behavioral
> differences (as mentioned, the killing is "invisible" to users since
> it's fundamentally a race, and you can consider the kill to have
> happened before the ptrace started).

See above.


>> It might be simpler to make whichever lock we are dealing with per
>> task_struct instead of per signal_struct.  Then we don't even have to
>> think about what de_thread does or if the lock is taken killable.
>
> Well, yes, but I think the dethread behavior of killing threads is
> required anyway, so..

It is, but it is actually part of the problem.

I think making some of this thread local might solve another easy case
and let us focus more on the really hard problem.

>> I keep wondering if we could do something similar to vfork.  That is
>> allocate an new task_struct and fully set it up for the post exec
>> process, and then make it visible under tasklist_lock.  Finally we could
>> free the old process.
>>
>> That would appear as if everything happened atomically from
>> the point of view of the rest of the kernel.
>
> I do think that would have been a lovely design originally, and would
> avoid a lot of things. So "execve()" would basically look like an exit
> and a thread creation with the same pid (without the SIGCHILD to the
> parent, obviously)
>
> That would also naturally handle the "flush pending signals" etc issues.
>
> The fact that we created a whole new mm-struct ended up fixing a lot
> of problems (even if it was painful to do). This might be similar.
>
> But it's not what we've ever done, and I do suspect you'd run into a
> lot of odd small special cases if we were to try to do it now.

I completely agree, which is why I haven't been rushing to do that.
But this remains the only idea that I have thought of that would solve all
of the issues.

> So I think it's simpler to just start making the "cred lock waiters
> have to be killable" rule. It's not like that's a very complex rule.

I just looked at the remaining users of cred_guard_mutex and they are
all killable or interruptible.  Further all of the places that have been
converted to use the exec_update_mutex are also all killable or
interruptible.

So where we came in is that we had the killable rule and that has what
has allowed this to remain on the backburner for so long.  At least you
could kill the affected process from userspace.   Unfortunately the
deadlocks still happen.

Eric
