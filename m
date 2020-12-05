Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5389C2CFE08
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgLETAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:00:23 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:49668 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgLETAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:00:21 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1klbwd-00Eu6P-VZ; Sat, 05 Dec 2020 11:06:08 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1klbwd-0008UB-49; Sat, 05 Dec 2020 11:06:07 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
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
        Waiman Long <longman@redhat.com>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
        <87ft4mbqen.fsf@x220.int.ebiederm.org>
        <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
        <875z5h4b7a.fsf@x220.int.ebiederm.org>
        <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
        <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
        <20201204214836.3rncqw5kox42b4i2@linux-p48b.lan>
Date:   Sat, 05 Dec 2020 12:05:32 -0600
In-Reply-To: <20201204214836.3rncqw5kox42b4i2@linux-p48b.lan> (Davidlohr
        Bueso's message of "Fri, 4 Dec 2020 13:48:36 -0800")
Message-ID: <878sacyvpv.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1klbwd-0008UB-49;;;mid=<878sacyvpv.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/w+l6vurjxcEGLPmREBqp3weX4WFHRCJY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_SB_Phish,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels,XMSubLong,XMSubPhish11,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.5 XMSubPhish11 Phishy Language Subject
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
        *  0.0 TR_XM_SB_Phish Phishing flag in subject of message
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Davidlohr Bueso <dave@stgolabs.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 479 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 10 (2.0%), parse: 1.59
        (0.3%), extract_message_metadata: 25 (5.1%), get_uri_detail_list: 3.3
        (0.7%), tests_pri_-1000: 7 (1.5%), tests_pri_-950: 1.27 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 105 (21.9%), check_bayes:
        101 (21.2%), b_tokenize: 9 (1.9%), b_tok_get_all: 8 (1.7%),
        b_comp_prob: 2.8 (0.6%), b_tok_touch_all: 77 (16.1%), b_finish: 0.97
        (0.2%), tests_pri_0: 314 (65.6%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 3.3 (0.7%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/3] exec: Transform exec_update_mutex into a rw_semaphore
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso <dave@stgolabs.net> writes:

> On Fri, 04 Dec 2020, Linus Torvalds wrote:
>
>>On Fri, Dec 4, 2020 at 12:30 PM Bernd Edlinger
>><bernd.edlinger@hotmail.de> wrote:
>>>>
>>> >    perf_event_open  (exec_update_mutex -> ovl_i_mutex)
>>
>>Side note: this one looks like it should be easy to fix.
>>
>>Is there any real reason why exec_update_mutex is actually gotten that
>>early, and held for that long in the perf event code?
>
> afaict just to validate the whole operation early. Per 79c9ce57eb2 the
> mutex will guard the check and the perf_install_in_context vs exec.
>
>>
>>I _think_ we could move the ptrace check to be much later, to _just_ before that
>>
>>         * This is the point on no return; we cannot fail hereafter.
>>
>>point in the perf event install chain..
>
> Peter had the idea of doing the ptrace_may_access() check twice: first
> lockless and early, then under exec_update_mutex when it mattered right
> before perf_install_in_context():
>
> https://lore.kernel.org/linux-fsdevel/20200828123720.GZ1362448@hirez.programming.kicks-ass.net/
>
>>
>>I don't think it needs to be moved down even that much, I think it
>>would be sufficient to move it down below the "perf_event_alloc()",
>>but I didn't check very much.
>
> Yeah we could just keep a single ptrace_may_access() check just further
> down until it won't deadlock.

I am trying to understand why the permission check is there.

The ptrace_may_access check came in with the earliest version of the
code I can find.  So going down that path hasn't helped.

There are about 65 calls of perf_pmu_register so it definitely makes me
nervous holding a semaphore over perf_event_alloc.

What is truly silly in all of this is perf_uprobe_event_init fails if
!perfmon_capable().   Which means the ptrace_may_access check and
holding exec_update_mutex is completely irrelevant to the function of
create_local_trace_uprobe.  Which is strange in and of itself.  I would
have thought uprobes would have been the kind of probe that it would
be safe for ordinary users to use.

This is a much deeper rabit hole than I had anticipated when I started
looking and I will have to come back to this after the weekend.

If at all possible I would love to be able to move the grabbing of
exec_update_mutex after perf_event_alloc and the pluggable functions it
calls.  It doesn't feel possible to audit that.

On the flip side the task is passed in as hw.target.  So it may not be
possible to move the permission check.  It is chaos.

Eric




