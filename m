Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40AD31F7DF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgFLUG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 16:06:29 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:37340 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgFLUG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:06:28 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jjpwY-0006O0-FH; Fri, 12 Jun 2020 14:06:26 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jjpwX-0004KZ-Jw; Fri, 12 Jun 2020 14:06:26 -0600
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
Date:   Fri, 12 Jun 2020 15:02:16 -0500
In-Reply-To: <CAHk-=wh7nZNf81QPcgpDh-0jzt2sOF3rdUEB0UcZvYFHDiMNkw@mail.gmail.com>
        (Linus Torvalds's message of "Fri, 12 Jun 2020 12:46:25 -0700")
Message-ID: <87v9jwm4s7.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jjpwX-0004KZ-Jw;;;mid=<87v9jwm4s7.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19rI2YLtPTLE+FOTW0jPO8xz0tK2h1ERYk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4880]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 454 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (2.5%), b_tie_ro: 10 (2.2%), parse: 1.62
        (0.4%), extract_message_metadata: 23 (5.0%), get_uri_detail_list: 2.6
        (0.6%), tests_pri_-1000: 37 (8.1%), tests_pri_-950: 1.90 (0.4%),
        tests_pri_-900: 1.60 (0.4%), tests_pri_-90: 146 (32.1%), check_bayes:
        142 (31.3%), b_tokenize: 10 (2.2%), b_tok_get_all: 11 (2.4%),
        b_comp_prob: 4.3 (0.9%), b_tok_touch_all: 112 (24.7%), b_finish: 1.00
        (0.2%), tests_pri_0: 218 (48.1%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.19 (0.0%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] proc fixes v2 for v5.8-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Jun 12, 2020 at 12:34 PM Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>
> What happened to that first version of the email? I never got it..

A little distracted I think.  I forgot to edit the above line out,
and v2 because it is my second pull request for a proc fix into
v5.8-rc1.

>> Looking at the code the fsnotify watch should have been removed by
>> fsnotify_sb_delete in generic_shutdown_super.
>
> Hmm. Correct. The new_inode_pseudo() is for things that don't have
> quotas, fsnotify or writeback.
>
> That was used somewhat intentionally on /proc, though. /proc certainly
> doesn't have quotas or writeback.

It also means we break our debugging by not putting inodes on the s_inodes list.

AKA this line in generic_shutdown_super is also depent on that behavior.
	if (!list_empty(&sb->s_inodes)) {
		printk("VFS: Busy inodes after unmount of %s. "
		   "Self-destruct in 5 seconds.  Have a nice day...\n",
		   sb->s_id);
	}

> And fsnotify on /proc seems a bit questionably too. Do people actually
> _do_ this and depend on it, or is this just about syzbot doing
> something odd and thus showing the problem?
>
> Anyway, I have pulled your fix, because I think it's reasonable and
> safe, but I do wonder if we should have kept the new_inode_pseudo(),
> and instead just make fsnotify say "you can't notify on an inode that
> isn't on the superblock list". Hmm?
>
> Is fsnotify on /proc really sensible? Do we actually generate any
> useful notifications?

I don't know of any proc code that does anything to make
fsnotify/inotify work.  Since changes to proc are not initialiated
through the vfs that probably means fsnotify is pretty much useless.

I have a sense that a use after free that anyone can trigger could be a
bit dangerous, and despite not being the only virtual filesystem in the
kernel proc is the only virtual filesystem that called new_inode_pseudo.

Eric

