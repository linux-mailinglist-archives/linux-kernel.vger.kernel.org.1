Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EB41F7F40
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 00:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFLWvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 18:51:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:52884 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLWvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 18:51:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jjsWY-0001uC-Qj; Fri, 12 Jun 2020 16:51:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jjsWV-0001NB-VW; Fri, 12 Jun 2020 16:51:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
References: <875zc8kxyg.fsf@x220.int.ebiederm.org>
        <87zh9atx0x.fsf@x220.int.ebiederm.org>
        <871rmkozf5.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wh7nZNf81QPcgpDh-0jzt2sOF3rdUEB0UcZvYFHDiMNkw@mail.gmail.com>
        <87v9jwm4s7.fsf@x220.int.ebiederm.org>
        <CAHk-=whEMmvh=gAgo=Ae0zaJ06vfaYrKxa3jV+AgPBz450Rerw@mail.gmail.com>
Date:   Fri, 12 Jun 2020 17:47:34 -0500
In-Reply-To: <CAHk-=whEMmvh=gAgo=Ae0zaJ06vfaYrKxa3jV+AgPBz450Rerw@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 12 Jun 2020 13:16:24 -0700")
Message-ID: <875zbvnbp5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jjsWV-0001NB-VW;;;mid=<875zbvnbp5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194xhfvJgmnqqi/nJq0VfGodOeuQnQXedE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4624]
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2090 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.7 (0.2%), b_tie_ro: 3.3 (0.2%), parse: 1.10
        (0.1%), extract_message_metadata: 15 (0.7%), get_uri_detail_list: 2.1
        (0.1%), tests_pri_-1000: 2.5 (0.1%), tests_pri_-950: 0.98 (0.0%),
        tests_pri_-900: 0.78 (0.0%), tests_pri_-90: 78 (3.7%), check_bayes: 77
        (3.7%), b_tokenize: 6 (0.3%), b_tok_get_all: 8 (0.4%), b_comp_prob:
        1.80 (0.1%), b_tok_touch_all: 59 (2.8%), b_finish: 0.72 (0.0%),
        tests_pri_0: 1975 (94.5%), check_dkim_signature: 0.38 (0.0%),
        check_dkim_adsp: 1687 (80.7%), poll_dns_idle: 1681 (80.4%),
        tests_pri_10: 2.2 (0.1%), tests_pri_500: 7 (0.3%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [GIT PULL] proc fixes v2 for v5.8-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 12, 2020 at 1:06 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> I have a sense that a use after free that anyone can trigger could be a
>> bit dangerous, and despite not being the only virtual filesystem in the
>> kernel proc is the only virtual filesystem that called new_inode_pseudo.
>
> So the reason I pulled that change despite my questions was that I do
> agree with the whole "there's probably little point to use
> new_inode_pseudo() here" argument.
>
> But at the same time, I ghet the feeling that this partly just is
> papering over the problem. If fsnotify causes problems with a
> new_inode_pseudo() inode, then fsnotify should be _checking_ for that
> case.
>
> And if fsnotify were to check for it, then the reason for /proc to use
> it would largely go away. Maybe the debug check for umount matters,
> but honestly it doesn't really seem to be a big deal.
>
> A pseudo-inode is basically independent of the filesystem it was
> mounted as, so the generic_shutdown_super() check not triggering for
> them is sensible, I feel.
>
> But yeah, we could also make the rule go the other way, and simply
> make sure that "new_inode_pseudo()" itself checks that the super-block
> you give it is something fundamenally unmountable and was created with
> 'kern_mount()'.
>
> That would have also figured out that the /proc case was broken.
>
> So the main objection I have here is really that this fix feels
> incomplete, and doesn't really reflect the underlying issue, just
> fixes the symptom.
>
> Either the underlying issue is that you shouldn't call 'fsnotify' on
> /proc, or the underlying issue is that /proc was using a bad inode and
> nobody even noticed until the fsnotify issue.
>
> This is not a huge deal. I think you've fixed the bug, I just have
> this itch that the thing that triggered it shouldn't have happened in
> the first place.

Yeah.  I have a similar feeling.

Especially since it took about 7 years for someone to notice something
was not right.

Still right now I am not up to digging and adding warnings and causing
things to fail.  What energy I have I am going to use to keep sorting
out exec.  I am not ready to page back in the fine details of how all of
the filesystem pieces interact right now.

I am wondering now if there are any crazy corner cases of the unix
domain sockets where fsnotify could latch onto one, and have problems.
It looks like the inode comes from the underlying filesystem so we
should be safe.

Eric
