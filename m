Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3EAB28AD75
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 07:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgJLFBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 01:01:04 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40362 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgJLFBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 01:01:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kRpx2-006tER-K0; Sun, 11 Oct 2020 23:00:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kRpx1-0005YR-GK; Sun, 11 Oct 2020 23:00:48 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Alexander Mihalicyn <alexander@mihalicyn.com>,
        Mrunal Patel <mpatel@redhat.com>, Wat Lim <watl@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Joseph Christopher Sible <jcsible@cert.org>,
        =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Stephane Graber <stgraber@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200830143959.rhosiunyz5yqbr35@wittgenstein>
        <20201010042606.GA30062@mail.hallyn.com>
        <20201011205306.GC17441@localhost>
        <CALCETrUZcHNwspz315KFvSPxtK8MmLUPfiN=hCBgx+wqeJe4+g@mail.gmail.com>
Date:   Mon, 12 Oct 2020 00:01:09 -0500
In-Reply-To: <CALCETrUZcHNwspz315KFvSPxtK8MmLUPfiN=hCBgx+wqeJe4+g@mail.gmail.com>
        (Andy Lutomirski's message of "Sun, 11 Oct 2020 17:38:41 -0700")
Message-ID: <87h7r0qbqi.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kRpx1-0005YR-GK;;;mid=<87h7r0qbqi.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+R2TJbmPUBT5o1leUsuv79cH+JtdTcZ2U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong,
        XM_B_SpammyWords autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Andy Lutomirski <luto@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 710 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.3 (0.6%), b_tie_ro: 3.1 (0.4%), parse: 1.24
        (0.2%), extract_message_metadata: 12 (1.7%), get_uri_detail_list: 2.2
        (0.3%), tests_pri_-1000: 5 (0.7%), tests_pri_-950: 1.10 (0.2%),
        tests_pri_-900: 0.83 (0.1%), tests_pri_-90: 144 (20.2%), check_bayes:
        142 (20.0%), b_tokenize: 7 (0.9%), b_tok_get_all: 8 (1.2%),
        b_comp_prob: 1.93 (0.3%), b_tok_touch_all: 122 (17.2%), b_finish: 0.74
        (0.1%), tests_pri_0: 280 (39.5%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 241 (33.9%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 257 (36.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: LPC 2020 Hackroom Session: summary and next steps for isolated user namespaces
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Sun, Oct 11, 2020 at 1:53 PM Josh Triplett <josh@joshtriplett.org> wrote:
>>
>> On Fri, Oct 09, 2020 at 11:26:06PM -0500, Serge E. Hallyn wrote:
>> > > 3. Find a way to allow setgroups() in a user namespace while keeping
>> > >    in mind the case of groups used for negative access control.
>> > >    This was suggested by Josh Triplett and Geoffrey Thomas. Their idea was to
>> > >    investigate adding a prctl() to allow setgroups() to be called in a user
>> > >    namespace at the cost of restricting paths to the most restrictive
>> > >    permission. So if something is 0707 it needs to be treated as if it's 0000
>> > >    even though the caller is not in its owning group which is used for negative
>> > >    access control (how these new semantics will interact with ACLs will also
>> > >    need to be looked into).
>> >
>> > I should probably think this through more, but for this problem, would it
>> > not suffice to add a new prevgroups grouplist to the struct cred, maybe
>> > struct group_info *locked_groups, and every time an unprivileged task creates
>> > a new user namespace, add all its current groups to this list?
>>
>> So, effectively, you would be allowed to drop permissions, but
>> locked_groups would still be checked for restrictions?
>>
>> That seems like it'd introduce a new level of complexity (a new facet of
>> permission) to manage. Not opposed, but it does seem more complex than
>> just opting out of using groups for negative permissions.
>
> Is there any context other than regular UNIX DAC in which groups can
> act as negative permissions or is this literally just an issue for
> files with a more restrictive group mode than other mode?

Just that.

The ideas kicked around in the conversation were some variant of having
a sysctl that says "This system never uses groups for negative
permissions".

It was also suggested that if the sysctl was set the the permission
checks would be altered such that even if someone tried to set a
negative permission, the more liberal permissions of other would be used
instead.

Given that creating /etc/subgid is effectively opting out of negative
permissions already have a sysctl that says that upfront feels like a
very clean solution.

Eric
