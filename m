Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52AB6269261
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgINRBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:01:45 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:44174 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgINQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 12:47:02 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kHrct-0099jm-CF; Mon, 14 Sep 2020 10:46:47 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:35912 helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kHrcr-0002hV-MR; Mon, 14 Sep 2020 10:46:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Joerg Vehlow <lkml@jv-coder.de>
Cc:     peterz@infradead.org, Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>,
        Kexec Mailing List <kexec@lists.infradead.org>
References: <20200528084614.0c949e8d@gandalf.local.home>
        <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
        <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
        <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
        <20200821110848.6c3183d1@oasis.local.home>
        <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
        <20200821170334.73b52fdd@oasis.local.home>
        <95d7a489-a295-1c11-ac62-83e941ed3a87@jv-coder.de>
        <20200907114618.GR2674@hirez.programming.kicks-ass.net>
        <5c3a502f-2255-5aae-3599-5220aa4b8328@jv-coder.de>
        <20200907162338.GN1362448@hirez.programming.kicks-ass.net>
        <5600c9f8-2c9d-7776-161a-5f5c1be62c10@jv-coder.de>
        <51f3b288-260b-a800-6a47-51d93f892c3d@jv-coder.de>
        <87sgbo3p5w.fsf@x220.int.ebiederm.org>
        <22bad750-ef5d-82a5-527c-5213346dd280@jv-coder.de>
Date:   Mon, 14 Sep 2020 11:46:25 -0500
In-Reply-To: <22bad750-ef5d-82a5-527c-5213346dd280@jv-coder.de> (Joerg
        Vehlow's message of "Mon, 14 Sep 2020 08:03:27 +0200")
Message-ID: <87k0wws3vi.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kHrcr-0002hV-MR;;;mid=<87k0wws3vi.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+pVwL3FzXqBXvS2YTcly7qju+FY3BZhmg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong,XM_B_SpammyWords
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4660]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Joerg Vehlow <lkml@jv-coder.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1291 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.3%), b_tie_ro: 2.5 (0.2%), parse: 1.23
        (0.1%), extract_message_metadata: 12 (0.9%), get_uri_detail_list: 1.99
        (0.2%), tests_pri_-1000: 4.1 (0.3%), tests_pri_-950: 1.04 (0.1%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 55 (4.3%), check_bayes: 54
        (4.2%), b_tokenize: 6 (0.5%), b_tok_get_all: 6 (0.4%), b_comp_prob:
        1.91 (0.1%), b_tok_touch_all: 37 (2.9%), b_finish: 0.58 (0.0%),
        tests_pri_0: 322 (24.9%), check_dkim_signature: 0.42 (0.0%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 870 (67.4%), tests_pri_10:
        2.6 (0.2%), tests_pri_500: 887 (68.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in interrupt context
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Adding the kexec list as well.

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi Eric,
>> What is this patch supposed to be doing?
>>
>> What bug is it fixing?
> This information is part in the first message of this mail thread.
> The patch was intendedfor the active discussion in this thread,
> not for a broad review.

> A short summary: In the rt kernel, a panic in an interrupt context does
> not start the dump-capture kernel, because there is a mutex_trylock in
> __crash_kexe. If this is called in interrupt context, it always fails.
> In the non-rt kernel calling mutex_trylock is not allowed according to
> the comment of the function, but it still works.

Thanks.  For whatever reason I did not see the rest of this thread
when I was replying to your patch.

I get the feeling the rt kernel is breaking this case deliberately.
I don't know of any reason why a trylock couldn't work.

That said I won't propose fixing up the locks that way.

>> A BUG_ON that triggers inside of BUG_ONs seems not just suspect but
>> outright impossible to make use of.
> I am not entirely sure what would happen here. But even if it gets in
> some kind ofendless loop, I guess this is ok, because it allows finding
> the problem. A piece of code in the function, that ensures the precondition
> is a lot better than relying on only a comment.
> If this was in mtex_trylock, the bug described above wouldn't have sneaked
> in 12 years ago...

BUG_ON's are more likely to hide a problem then to show it.
Sometimes they are appropriate but the should be avoided as much as
possible.


>> I get the feeling skimming this that it is time to sort out and simplify
>> the locking here, rather than make it more complex, and more likely to
>> fail.
> I would very much like that, but sadly it looks like it is not possible.
> Either it wouldrequire blocking locks, that may fail, or not locking at
> all, that may also fail.Using a different kind of lock (like spinlock)
> is also not possible, becausespinlock_trylock again uses mutex_trylock
> in the rt kernel.

I think it is possible but the locking needs to be relooked at.

>> I get the feeling that over the years somehow the assumption that the
>> rest of the kernel is broken and that we need to get out of the broken
>> kernel as fast and as simply as possible has been lost.
> Yes I also have the feeling, that the mutexes need fixing, but I wouldn't
> to post any patch for that. At the moment, given the interface of the mutex,
> this is clearly a bug in kexec, even if it works in the non-rt kernel.

Cleanups that break the code. Sigh.

The code was written correctly for this case and was fine until
8c5a1cf0ad3a ("kexec: use a mutex for locking rather than xchg()").

Mostly because I didn't trust locks given their comparatively high level
of abstraction and what do you know that turned out to be correct in
this case.

It definitely looks time to see how the locking can be improved on the
kexec on panic code path.

Eric
