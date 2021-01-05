Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480822EA19E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 01:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhAEAtR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Jan 2021 19:49:17 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:56924 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbhAEAtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 19:49:16 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kwaWX-003WP2-Cb; Mon, 04 Jan 2021 17:48:33 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kwaWV-00BFO6-Sp; Mon, 04 Jan 2021 17:48:32 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        X86 ML <x86@kernel.org>
References: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
        <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net>
Date:   Mon, 04 Jan 2021 18:47:38 -0600
In-Reply-To: <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net> (Andy
        Lutomirski's message of "Mon, 4 Jan 2021 15:04:01 -0800")
Message-ID: <87mtxodxat.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1kwaWV-00BFO6-Sp;;;mid=<87mtxodxat.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+zFu0HCC1JL/U/3tpnfUk85qegxAyYd8M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XM_B_Unicode
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4846]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andy Lutomirski <luto@amacapital.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 690 ms - load_scoreonly_sql: 0.16 (0.0%),
        signal_user_changed: 15 (2.1%), b_tie_ro: 12 (1.7%), parse: 2.2 (0.3%),
         extract_message_metadata: 32 (4.6%), get_uri_detail_list: 6 (0.8%),
        tests_pri_-1000: 10 (1.5%), tests_pri_-950: 1.80 (0.3%),
        tests_pri_-900: 1.33 (0.2%), tests_pri_-90: 69 (9.9%), check_bayes: 67
        (9.7%), b_tokenize: 14 (2.0%), b_tok_get_all: 12 (1.8%), b_comp_prob:
        4.5 (0.7%), b_tok_touch_all: 32 (4.7%), b_finish: 1.00 (0.1%),
        tests_pri_0: 454 (65.8%), check_dkim_signature: 0.97 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 71 (10.2%), tests_pri_10:
        3.9 (0.6%), tests_pri_500: 95 (13.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: in_compat_syscall() on x86
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@amacapital.net> writes:

>> On Jan 4, 2021, at 2:36 PM, David Laight <David.Laight@aculab.com> wrote:
>> 
>> ﻿From: Eric W. Biederman
>>> Sent: 04 January 2021 20:41
>>> 
>>> Al Viro <viro@zeniv.linux.org.uk> writes:
>>> 
>>>> On Mon, Jan 04, 2021 at 12:16:56PM +0000, David Laight wrote:
>>>>> On x86 in_compat_syscall() is defined as:
>>>>>    in_ia32_syscall() || in_x32_syscall()
>>>>> 
>>>>> Now in_ia32_syscall() is a simple check of the TS_COMPAT flag.
>>>>> However in_x32_syscall() is a horrid beast that has to indirect
>>>>> through to the original %eax value (ie the syscall number) and
>>>>> check for a bit there.
>>>>> 
>>>>> So on a kernel with x32 support (probably most distro kernels)
>>>>> the in_compat_syscall() check is rather more expensive than
>>>>> one might expect.
>>> 
>>> I suggest you check the distro kernels.  I suspect they don't compile in
>>> support for x32.  As far as I can tell x32 is an undead beast of a
>>> subarchitecture that just enough people use that it can't be removed,
>>> but few enough people use it likely has a few lurking scary bugs.
>> 
>> It is defined in the Ubuntu kernel configs I've got lurking:
>> Both 3.8.0-19_generic (Ubuntu 13.04) and 5.4.0-56_generic (probably 20.04).
>> Which is probably why it is in my test builds (I've just cut out
>> a lot of modules).

Interesting.  That sounds like something a gentle prod to the Ubuntu
kernel team might get them to disable.  Especially if there are not any
x32 binaries in sight.

Maybe Ubuntu has a reason or maybe someone just enabled the option
because it was there and they could.

>>>>> It would be muck better if both checks could be done together.
>>>>> I think this would require the syscall entry code to set a
>>>>> value in both the 64bit and x32 entry paths.
>>>>> (Can a process make both 64bit and x32 system calls?)
>>>> 
>>>> Yes, it bloody well can.
>>>> 
>>>> And I see no benefit in pushing that logics into syscall entry,
>>>> since anything that calls in_compat_syscall() more than once
>>>> per syscall execution is doing the wrong thing.  Moreover,
>>>> in quite a few cases we don't call the sucker at all, and for
>>>> all of those pushing that crap into syscall entry logics is
>>>> pure loss.
>>> 
>>> The x32 system calls have their own system call table and it would be
>>> trivial to set a flag like TS_COMPAT when looking up a system call from
>>> that table.  I expect such a change would be purely in the noise.
>> 
>> Certainly a write of 0/1/2 into a dirtied cache line of 'current'
>> could easily cost absolutely nothing.
>> Especially if current has already been read.
>> 
>> I also wondered about resetting it to zero when an x32 system call
>> exits (rather than entry to a 64bit one).
>> 
>> For ia32 the flag is set (with |=) on every syscall entry.
>> Even though I'm pretty sure it can only change during exec.
>
> It can change for every syscall. I have tests that do this.
>
>>>> What's the point, really?
>>> 
>>> Before we came up with the current games with __copy_siginfo_to_user
>>> and x32_copy_siginfo_to_user I was wondering if we should make such
>>> a change.  The delivery of compat signal frames and core dumps which
>>> do not go through the system call entry path could almost benefit from
>>> a flag that could be set/tested when on those paths.
>> 
>> For signal delivery it should (probably) depend on the system call
>> that setup the signal handler.
>
> I think it has worked this way for some time now.

It always has, but there is code that called as part of signal delivery
that needs to know if it is ia32 or x32 code (namely
copy_siginfo_to_user32).  The code paths are short enough we don't
strictly need the runtime test on that path and we have been able to
remove it, but it is an example of the kind of path that is not a
syscall entry where it would be nice to set the flag.

>> Although I'm sure I remember one kernel where some of it was done
>> in libc (with a single entrypoint for all hadlers).
>> 
>>> The fact that only SIGCHLD (which can not trigger a coredump) is
>>> different saves the coredump code from needing such a test.
>>> 
>>> The fact that the signal frame code is simple enough it can directly
>>> call x32_copy_siginfo_to_user or __copy_siginfo_to_user saves us there.
>>> 
>>> So I don't think we have any cases where we actually need a flag that
>>> is independent of the system call but we have come very close.
>> 
>> If a program can do both 64bit and x32 system calls you probably
>> need to generate a 64bit core dump if it has ever made a 64bit
>> system call??
>
> I think core dump should (and does) depend on the execution mode at
> the time of the crash.

The core dump code is currently tied to what binary you exec.
The code in exec sets mm->binfmt, and the coredump code uses mm->binfmt
to pick the coredump handler.

An x32 binary will make all kinds of 64bit calls where it doesn't need
the compat handling.  And of course x32 binaries run in 64bit mode with
32bit pointers so looking at the current execution mode doesn't help.

Further fun compat_binfmt_elf is shared between x32 and ia32, because
except for a few stray places they do exactly the same thing.

It is lucky that except for SIGCHLD the signals are between x32 and ia32
are exactly the same so that the kernel can encode them exactly the same
way.

> It’s worth noting that GCC’s understanding of mixed bitness is horrible.

Eric
