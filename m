Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341B12CF4D7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 20:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgLDTfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 14:35:53 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:51576 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDTfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 14:35:53 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1klGrE-00DCRa-AU; Fri, 04 Dec 2020 12:35:08 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1klGrD-00DghD-79; Fri, 04 Dec 2020 12:35:08 -0700
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
Date:   Fri, 04 Dec 2020 13:34:33 -0600
In-Reply-To: <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 4 Dec 2020 09:21:49 -0800")
Message-ID: <875z5h4b7a.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1klGrD-00DghD-79;;;mid=<875z5h4b7a.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19JBdc37j8Jc036PygacSLRGrCDpod6tAE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_SB_Phish,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong,XMSubPhish11,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4984]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.5 XMSubPhish11 Phishy Language Subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 TR_XM_SB_Phish Phishing flag in subject of message
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 653 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.9%), b_tie_ro: 11 (1.7%), parse: 1.56
        (0.2%), extract_message_metadata: 23 (3.5%), get_uri_detail_list: 3.2
        (0.5%), tests_pri_-1000: 9 (1.5%), tests_pri_-950: 1.74 (0.3%),
        tests_pri_-900: 1.36 (0.2%), tests_pri_-90: 267 (40.9%), check_bayes:
        247 (37.8%), b_tokenize: 11 (1.8%), b_tok_get_all: 10 (1.5%),
        b_comp_prob: 3.2 (0.5%), b_tok_touch_all: 219 (33.5%), b_finish: 1.12
        (0.2%), tests_pri_0: 322 (49.3%), check_dkim_signature: 0.67 (0.1%),
        check_dkim_adsp: 2.7 (0.4%), poll_dns_idle: 0.72 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Dec 4, 2020 at 8:08 AM Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>
>> >
>> > -static void kcmp_unlock(struct mutex *m1, struct mutex *m2)
>> > +static void kcmp_unlock(struct rw_semaphore *l1, struct rw_semaphore *l2)
>> >  {
>> > -     if (likely(m2 != m1))
>> > -             mutex_unlock(m2);
>> > -     mutex_unlock(m1);
>> > +     if (likely(l2 != l1))
>>
>> is this still necessary ?
>>
>> > +             up_read(l2);
>> > +     up_read(l1);
>> >  }
>> >
>> > -static int kcmp_lock(struct mutex *m1, struct mutex *m2)
>> > +static int kcmp_lock(struct rw_semaphore *l1, struct rw_semaphore *l2)
>> >  {
>> >       int err;
>> >
>> > -     if (m2 > m1)
>> > -             swap(m1, m2);
>> > +     if (l2 > l1)
>> > +             swap(l1, l2);
>>
>> and this is probably also no longer necessary?
>
> These are still necessary, because even a recursive read lock can
> still block on a writer trying to come in between the two read locks
> due to fairness guarantees.
>
> So taking the same read lock twice is still a source of possible deadlocks.
>
> For the same reason, read locks still have ABBA deadlock and need to
> be taken in order.
>
> So switching from a mutex to a rwlock doesn't really change the
> locking rules in this respect.

Thinking about the specific case of down_read on two instances of
exec_update_lock.  If there are two instances of kcmp being called with
the sames two pids, but in opposite order running, and the tasks of that
both of those pids refer to both exec, you could definitely get a
deadlock.

So yes.  We definitely need to keep the swap as well.

> In fact, I'm not convinced this change even fixes the deadlock that
> syzbot reported, for the same reason: it just requires a write lock in
> between two read locks to deadlock.

From a deadlock perspective the change is strictly better than what we
have today.  The readers will no longer block on each other.

For the specific case that syzbot reported it is readers who were
blocking on each other so that specific case if fixed.



On the write side of exec_update_lock we have:

cred_guard_mutex -> exec_update_lock

Which means that to get an ABBA deadlock cred_guard_mutex would need to
be involved and it is only acquired in 3 places: ptrace_attach,
do_seccomp, and proc_pid_attr_write.  In none of the 3 from the syscall
entry point until the code that takes cred_guard_mutex can I find
anything that takes any locks.  Perhaps there is something in io_uring I
did not completely trace that write path.

So given that the exec path would need to be involved, and the exec path
takes exec_update_lock pretty much at the top level.  I am not seeing
how there is any room for deadlocks after this change.

Am I missing something?

Eric








