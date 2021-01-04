Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189222E9EFA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 21:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbhADUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 15:42:39 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:34346 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbhADUmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:42:39 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kwWfs-003ALS-Ha; Mon, 04 Jan 2021 13:41:56 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kwWfr-00AU8p-E8; Mon, 04 Jan 2021 13:41:56 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
References: <e817cfdc2df3433bb7fb357db89d4d48@AcuMS.aculab.com>
        <20210104165827.GJ3579531@ZenIV.linux.org.uk>
Date:   Mon, 04 Jan 2021 14:41:01 -0600
In-Reply-To: <20210104165827.GJ3579531@ZenIV.linux.org.uk> (Al Viro's message
        of "Mon, 4 Jan 2021 16:58:27 +0000")
Message-ID: <87sg7gfnaa.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kwWfr-00AU8p-E8;;;mid=<87sg7gfnaa.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+scTNiGNXtrfeAZS1zmWGR6aBMcS6Ssb4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3117]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 553 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 9 (1.7%), parse: 1.11 (0.2%),
         extract_message_metadata: 12 (2.1%), get_uri_detail_list: 1.71 (0.3%),
         tests_pri_-1000: 4.4 (0.8%), tests_pri_-950: 1.22 (0.2%),
        tests_pri_-900: 0.95 (0.2%), tests_pri_-90: 113 (20.4%), check_bayes:
        111 (20.1%), b_tokenize: 6 (1.2%), b_tok_get_all: 8 (1.4%),
        b_comp_prob: 2.4 (0.4%), b_tok_touch_all: 91 (16.5%), b_finish: 0.91
        (0.2%), tests_pri_0: 238 (43.0%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 155 (28.1%), tests_pri_10:
        2.0 (0.4%), tests_pri_500: 167 (30.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: in_compat_syscall() on x86
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jan 04, 2021 at 12:16:56PM +0000, David Laight wrote:
>> On x86 in_compat_syscall() is defined as:
>>     in_ia32_syscall() || in_x32_syscall()
>> 
>> Now in_ia32_syscall() is a simple check of the TS_COMPAT flag.
>> However in_x32_syscall() is a horrid beast that has to indirect
>> through to the original %eax value (ie the syscall number) and
>> check for a bit there.
>> 
>> So on a kernel with x32 support (probably most distro kernels)
>> the in_compat_syscall() check is rather more expensive than
>> one might expect.

I suggest you check the distro kernels.  I suspect they don't compile in
support for x32.  As far as I can tell x32 is an undead beast of a
subarchitecture that just enough people use that it can't be removed,
but few enough people use it likely has a few lurking scary bugs.

>> It would be muck better if both checks could be done together.
>> I think this would require the syscall entry code to set a
>> value in both the 64bit and x32 entry paths.
>> (Can a process make both 64bit and x32 system calls?)
>
> Yes, it bloody well can.
>
> And I see no benefit in pushing that logics into syscall entry,
> since anything that calls in_compat_syscall() more than once
> per syscall execution is doing the wrong thing.  Moreover,
> in quite a few cases we don't call the sucker at all, and for
> all of those pushing that crap into syscall entry logics is
> pure loss.

The x32 system calls have their own system call table and it would be
trivial to set a flag like TS_COMPAT when looking up a system call from
that table.  I expect such a change would be purely in the noise.

> What's the point, really?

Before we came up with the current games with __copy_siginfo_to_user
and x32_copy_siginfo_to_user I was wondering if we should make such
a change.  The delivery of compat signal frames and core dumps which
do not go through the system call entry path could almost benefit from
a flag that could be set/tested when on those paths.

The fact that only SIGCHLD (which can not trigger a coredump) is
different saves the coredump code from needing such a test.

The fact that the signal frame code is simple enough it can directly
call x32_copy_siginfo_to_user or __copy_siginfo_to_user saves us there.

So I don't think we have any cases where we actually need a flag that
is independent of the system call but we have come very close.


For people who want to optimize I suggest tracking down the handful of
users of x32 and see if x32 can be made to just go away.

Eric

