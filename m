Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B82CFC62
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 19:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgLERxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 12:53:16 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:39170 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgLERov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 12:44:51 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1klbb1-00BDEo-Vt; Sat, 05 Dec 2020 10:43:48 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1klbb0-00GEQ7-U5; Sat, 05 Dec 2020 10:43:47 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
        <87ft4mbqen.fsf@x220.int.ebiederm.org>
        <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
        <875z5h4b7a.fsf@x220.int.ebiederm.org>
        <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
Date:   Sat, 05 Dec 2020 11:43:11 -0600
In-Reply-To: <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 4 Dec 2020 12:10:58 -0800")
Message-ID: <87r1o4174g.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1klbb0-00GEQ7-U5;;;mid=<87r1o4174g.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+p05mRAYNOc2PihEt9CL8XP0T2aKuv61k=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *****
X-Spam-Status: No, score=5.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_PhishingBody,TR_XM_SB_Phish,
        T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,XMSubLong,
        XMSubPhish11,XM_B_Phish66 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  2.0 XM_B_Phish66 BODY: Obfuscated XMission
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.5 XMSubPhish11 Phishy Language Subject
        *  0.0 TR_XM_SB_Phish Phishing flag in subject of message
        *  0.0 TR_XM_PhishingBody Phishing flag in body of message
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 456 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.5%), b_tie_ro: 10 (2.2%), parse: 1.17
        (0.3%), extract_message_metadata: 17 (3.7%), get_uri_detail_list: 2.4
        (0.5%), tests_pri_-1000: 16 (3.4%), tests_pri_-950: 1.31 (0.3%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 66 (14.5%), check_bayes:
        64 (14.1%), b_tokenize: 9 (2.0%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 2.6 (0.6%), b_tok_touch_all: 41 (8.9%), b_finish: 0.96
        (0.2%), tests_pri_0: 330 (72.4%), check_dkim_signature: 0.53 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.65 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Dec 4, 2020 at 11:35 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> From a deadlock perspective the change is strictly better than what we
>> have today.  The readers will no longer block on each other.
>
> No, agreed, it's better regardless.
>
>> For the specific case that syzbot reported it is readers who were
>> blocking on each other so that specific case if fixed.
>
> So the thing is, a reader can still block another reader if a writer
> comes in between them. Which is why I was thinking that the same
> deadlock could happen if somebody does an execve at just the right
> point.

>> On the write side of exec_update_lock we have:
>>
>> cred_guard_mutex -> exec_update_lock
>>
>> Which means that to get an ABBA deadlock cred_guard_mutex would need to
>> be involved
>
> No, see above: you can get a deadlock with
>
>  - first reader gets exec_update_lock
>
>  - writer on exec_update_lock blocks on first reader (this is exec)
>
>  - second reader of exec_update_lock now blocks on the writer.
>
> So if that second reader holds something that the first one wants to
> get (or is the same thread as the first one), you have a deadlock: the
> first reader will never make any progress, will never release the
> lock, and the writer will never get it, and the second reader will
> forever wait for the writer that is ahead of it in the queue.

Oh.  I see what you are saying.  I knew the writer had to be involved
and block, but if the reader comes first all that has to be added to the
situation is that an exec happens and attempts to take the lock.  Any
reader will block the writer.

For some reason I was blind to the fact that a reader could block the
writer, and I was looking for anything else that might block the writer.

> And that deadlock looks very much like what syzcaller detected, in
> exactly that scenario:
>
>   Chain exists of:
>     &sig->exec_update_mutex --> sb_writers#4 --> &p->lock
>
>    Possible unsafe locking scenario:
>
>          CPU0                    CPU1
>          ----                    ----
>     lock(&p->lock);
>                                  lock(sb_writers#4);
>                                  lock(&p->lock);
>     lock(&sig->exec_update_mutex);
>
>    *** DEADLOCK ***
>
> No?  The only thing that is missing is that writer that causes the
> exec_update_mutex readers to block each other - exactly like they did
> when it was a mutex.
>
> But I may be missing something entirely obvious that keeps this from happening.

I don't think so.

It does look like my change makes it one step more difficult to cause
the deadlock, but the deadlock can still happen. :-(

Making it a read/writer lock both makes it more difficult to cause
a deadlock and makes a lot of sense from a documentation standpoint
so I still plan on merging the changes after the weekend.


It looks like we do need to have a close look at perf_event_open and
everything associated with it.

Eric
