Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54FDA2EB6AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbhAFAEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:04:55 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:37490 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFAEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:04:54 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kwwJ9-0096Vf-V8; Tue, 05 Jan 2021 17:04:11 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kwwJ8-00F3C8-UK; Tue, 05 Jan 2021 17:04:11 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        X86 ML <x86@kernel.org>
References: <fe2629460b4e4b44a120a8b56efe0ac1@AcuMS.aculab.com>
        <091174F9-F6E4-468E-83F5-93706D83F9D2@amacapital.net>
        <87mtxodxat.fsf@x220.int.ebiederm.org>
        <20210105005700.GR3579531@ZenIV.linux.org.uk>
Date:   Tue, 05 Jan 2021 18:03:15 -0600
In-Reply-To: <20210105005700.GR3579531@ZenIV.linux.org.uk> (Al Viro's message
        of "Tue, 5 Jan 2021 00:57:00 +0000")
Message-ID: <878s97aq4c.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kwwJ8-00F3C8-UK;;;mid=<878s97aq4c.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX180UoD4z9fnJNpVE49//IpmnCZhCUm1qQk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4674]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 456 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.2%), b_tie_ro: 9 (2.0%), parse: 0.92 (0.2%),
         extract_message_metadata: 12 (2.7%), get_uri_detail_list: 2.2 (0.5%),
        tests_pri_-1000: 10 (2.1%), tests_pri_-950: 1.23 (0.3%),
        tests_pri_-900: 0.98 (0.2%), tests_pri_-90: 109 (24.0%), check_bayes:
        107 (23.6%), b_tokenize: 8 (1.8%), b_tok_get_all: 11 (2.3%),
        b_comp_prob: 3.2 (0.7%), b_tok_touch_all: 81 (17.7%), b_finish: 0.98
        (0.2%), tests_pri_0: 299 (65.7%), check_dkim_signature: 0.51 (0.1%),
        check_dkim_adsp: 2.1 (0.5%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 6 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: in_compat_syscall() on x86
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Mon, Jan 04, 2021 at 06:47:38PM -0600, Eric W. Biederman wrote:
>> >> It is defined in the Ubuntu kernel configs I've got lurking:
>> >> Both 3.8.0-19_generic (Ubuntu 13.04) and 5.4.0-56_generic (probably 20.04).
>> >> Which is probably why it is in my test builds (I've just cut out
>> >> a lot of modules).
>> 
>> Interesting.  That sounds like something a gentle prod to the Ubuntu
>> kernel team might get them to disable.  Especially if there are not any
>> x32 binaries in sight.
>
> What for?

Any code that no one uses is better off disabled or deleted.

There are maintenance and support costs to such code as they cause extra
work when maintaining the kernel, and because the code is practically
never tested inevitably bugs some of which turn into security issues
slip through.

Maybe I am wrong and there are interesting users of x32.  All I remember
is that last time this was discussed someone found a distro that
actually shipped an x32 build to users.  Which was just enough users to
keep x32 alive.  Given that distros are in the process of dropping 32bit
support I suspect that distro may be going if it is not already gone.

There are a lot of weird x32 special cases that it would be nice to get
rid of if no one uses x32, and could certainly be made less of an issue
if distro's that don't actually care about x32 simply stopped compiling
it in.

>> The core dump code is currently tied to what binary you exec.
>> The code in exec sets mm->binfmt, and the coredump code uses mm->binfmt
>> to pick the coredump handler.
>> 
>> An x32 binary will make all kinds of 64bit calls where it doesn't need
>> the compat handling.  And of course x32 binaries run in 64bit mode with
>> 32bit pointers so looking at the current execution mode doesn't help.
>> 
>> Further fun compat_binfmt_elf is shared between x32 and ia32, because
>> except for a few stray places they do exactly the same thing.
>
> FWIW, there's a series cleaning that crap up nicely; as a side benefit,
> it converts both compats on mips (o32 and n32) to regular compat_binfmt_elf.c
> Yes, the current mainline is bloody awful in that area (PRSTATUS_SIZE and
> SET_PR_FPVALID are not for weak stomach), but that's really not hard to
> get into sane shape - -next had that done in last cycle and I'm currently
> testing (well, building the test kernel) of port of that to 5.11-rc1.

That does sound interesting.  Anytime we can clean up arch specific
weirdness so that it simply becomes generic weirdness and it can be
tested and maintained by more people is always nice.

> I really don't see the point of getting rid of x32 - mips n32 is *not*
> going away, and that's an exact parallel.

From what I maintain x32 and n32 are *not* exact parallels.  The change
in size of the timestamps of SIGCHLD is not present on any other
architecture.

The truth is someone years ago royallying messed up struct siginfo and
took a structure that should have been the same on 32bit and 64bit and
would up with a horrible monstrosity of unions.

> PS: if anything, I wonder if we would better off with binfmt_elf{64,32}.o,
> built from fs/binfmt_elf.c; it's not that hard to do.  With arseloads
> of weirdness going away if we do that...

It sounds like we are already on our way to having that.  I suspect you
would need an binfmt_elf_ops to handle the architecture specific bits,
but it should not be too bad.

Eric
