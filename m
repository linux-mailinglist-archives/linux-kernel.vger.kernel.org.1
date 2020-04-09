Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC711A388F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgDIRGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 13:06:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38906 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgDIRGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:06:49 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMadb-0000tW-PT; Thu, 09 Apr 2020 11:06:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMada-0005PU-Py; Thu, 09 Apr 2020 11:06:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
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
        <87y2r4so3i.fsf@x220.int.ebiederm.org>
        <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
        <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
Date:   Thu, 09 Apr 2020 12:03:55 -0500
In-Reply-To: <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 9 Apr 2020 09:24:23 -0700")
Message-ID: <87wo6or3pg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMada-0005PU-Py;;;mid=<87wo6or3pg.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19xiliuIjxQOTWcYhWi4aqPdImDYESOPcY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4848]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 469 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (3.0%), b_tie_ro: 12 (2.6%), parse: 1.28
        (0.3%), extract_message_metadata: 13 (2.7%), get_uri_detail_list: 2.2
        (0.5%), tests_pri_-1000: 13 (2.8%), tests_pri_-950: 1.29 (0.3%),
        tests_pri_-900: 1.16 (0.2%), tests_pri_-90: 210 (44.8%), check_bayes:
        208 (44.3%), b_tokenize: 6 (1.3%), b_tok_get_all: 10 (2.1%),
        b_comp_prob: 2.9 (0.6%), b_tok_touch_all: 184 (39.2%), b_finish: 1.39
        (0.3%), tests_pri_0: 202 (43.1%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 3.1 (0.7%), poll_dns_idle: 1.44 (0.3%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding Oleg to the conversation if for no other reason that he can see
it is happening.

Oleg has had a test case where this can happen for years and nothing
has come out as an obvious proper fix for this deadlock issue.

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 9, 2020 at 9:15 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> may_ptrace_stop() is supposed to stop the blocking exactly so that it
>> doesn't deadlock.
>>
>> I wonder why that doesn't work..
>>
>> [ Goes and look ]
>>
>> Oh. I see.
>>
>> That ptrace_may_stop() only ever considered core-dumping, not execve().
>>
>> But if _that_ is the reason for the deadlock, then it's trivially fixed.
>
> So maybe may_ptrace_stop() should just do something like this
> (ENTIRELY UNTESTED):
>
>         struct task_struct *me = current, *parent = me->parent;
>
>         if (!likely(me->ptrace))
>                 return false;
>
>         /* If the parent is exiting or core-dumping, it's not
> listening to our signals */
>         if (parent->signal->flags & (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_COREDUMP))
>                 return false;
>
>         /* if the parent is going through a execve(), it's not listening */
>         if (parent->signal->group_exit_task)
>                 return false;
>
>         return true;
>
> instead of the fairly ad-hoc tests for core-dumping.
>
> The above is hand-wavy - I didn't think a lot about locking.
> may_ptrace_stop() is already called under the tasklist_lock, so the
> parent won't change, but maybe it should take the signal lock?
>
> So the above very much is *not* meant to be a "do it like this", more
> of a "this direction, maybe"?
>
> The existing code is definitely broken. It special-cases core-dumping
> probably simply because that's the only case people had realized, and
> not thought of the execve() thing.


I don't see how there can be a complete solution in may_ptrace_stop.

a) We must stop in PTRACE_EVENT_EXIT during exec or userspace *breaks*.

   Those are the defined semantics and I believe it is something
   as common as strace that depends on them.

b) Even if we added a test for our ptrace parent blocking in a ptrace
   attach of an ongoing exec, it still wouldn't help.

   That ptrace attach could legitimately come after the thread in
   question has stopped and notified it's parent it is stopped.



None of this is to say I like the semantics of PTRACE_EVENT_EXIT.  It is
just we will violate the no regressions rule if we don't stop there
during exec.

The normal case is that the strace or whomever is already attached to
all of the threads during exec and no deadlock occurs.  So the current
behavior is quite usable.



Maybe my memory is wrong that userspace cares but I really don't think
so.


Eric
