Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D971A3BA6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 23:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbgDIVDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 17:03:37 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:33786 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbgDIVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:03:36 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMeKm-0002v9-0w; Thu, 09 Apr 2020 15:03:36 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMeKl-00061C-6c; Thu, 09 Apr 2020 15:03:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
        <87lfnda3w3.fsf@x220.int.ebiederm.org>
        <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
        <87blo45keg.fsf@x220.int.ebiederm.org>
        <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
        <87v9maxb5q.fsf@x220.int.ebiederm.org>
        <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
        <87y2r4so3i.fsf@x220.int.ebiederm.org>
        <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
        <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
        <87wo6or3pg.fsf@x220.int.ebiederm.org>
        <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
        <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
        <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
        <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
Date:   Thu, 09 Apr 2020 16:00:43 -0500
In-Reply-To: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 9 Apr 2020 13:04:34 -0700")
Message-ID: <87imi8nzlw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMeKl-00061C-6c;;;mid=<87imi8nzlw.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19JRmi+gUReXsDfhEwoU+RTCX9qYs//mhU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMSubMetaSxObfu_03,XMSubMetaSx_00 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3983]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 352 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (2.7%), b_tie_ro: 8 (2.4%), parse: 1.58 (0.4%),
         extract_message_metadata: 24 (6.8%), get_uri_detail_list: 1.86 (0.5%),
         tests_pri_-1000: 35 (10.0%), tests_pri_-950: 1.78 (0.5%),
        tests_pri_-900: 1.26 (0.4%), tests_pri_-90: 71 (20.0%), check_bayes:
        68 (19.4%), b_tokenize: 8 (2.2%), b_tok_get_all: 6 (1.8%),
        b_comp_prob: 2.3 (0.7%), b_tok_touch_all: 47 (13.5%), b_finish: 1.06
        (0.3%), tests_pri_0: 194 (55.1%), check_dkim_signature: 0.73 (0.2%),
        check_dkim_adsp: 2.7 (0.8%), poll_dns_idle: 0.45 (0.1%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 9, 2020 at 12:57 PM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
>>
>> The use case where this may happen with strace
>> when you call strace with lots of -p <pid> arguments,
>> and one of them is a bomb. strace stuck.
>
> Yeah, so from a convenience angle I do agree that it would be nicer to
> just not count dead threads.
>
> You can test that by just moving the
>
>                 /* Don't bother with already dead threads */
>                 if (t->exit_state)
>                         continue;
>
> test in zap_other_threads() to above the
>
>                 count++;
>
> line instead.

That looks like a legitimate race, and something worth addressing.  It
doesn't look like t->exit_state has siglock protection so I don't think
testing it under siglock would fix that race.  But something like that
certainly should.

But no.  While you are goind a good job at spotting odd corner
cases that need to be fixed.  This also is not the cause of the
deadlock.  It is nothing that subtle.

Eric
