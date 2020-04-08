Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACEAB1A29F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Apr 2020 21:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728604AbgDHTyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Apr 2020 15:54:04 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:37952 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgDHTyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:54:03 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMGlt-0006MP-M5; Wed, 08 Apr 2020 13:54:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jMGlt-0000Xd-0W; Wed, 08 Apr 2020 13:54:01 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
        <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
        <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
        <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
        <87lfnda3w3.fsf@x220.int.ebiederm.org>
        <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
        <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
        <87o8s43wuq.fsf_-_@x220.int.ebiederm.org>
        <CAHk-=wgy_e1OY=OoPXp+4ZGEsYmRVQW8c_0GPYT-HfK376MKqA@mail.gmail.com>
Date:   Wed, 08 Apr 2020 14:51:10 -0500
In-Reply-To: <CAHk-=wgy_e1OY=OoPXp+4ZGEsYmRVQW8c_0GPYT-HfK376MKqA@mail.gmail.com>
        (Linus Torvalds's message of "Wed, 8 Apr 2020 10:25:17 -0700")
Message-ID: <875ze9ycwh.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jMGlt-0000Xd-0W;;;mid=<875ze9ycwh.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/uIisiQByxQnmMGlkpSKa9gSxUVSdAITo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 299 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (4.0%), b_tie_ro: 10 (3.5%), parse: 1.05
        (0.4%), extract_message_metadata: 16 (5.2%), get_uri_detail_list: 1.47
        (0.5%), tests_pri_-1000: 14 (4.8%), tests_pri_-950: 1.25 (0.4%),
        tests_pri_-900: 0.98 (0.3%), tests_pri_-90: 57 (19.1%), check_bayes:
        55 (18.5%), b_tokenize: 6 (1.9%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 2.2 (0.7%), b_tok_touch_all: 39 (12.9%), b_finish: 0.94
        (0.3%), tests_pri_0: 184 (61.5%), check_dkim_signature: 0.49 (0.2%),
        check_dkim_adsp: 2.1 (0.7%), poll_dns_idle: 0.69 (0.2%), tests_pri_10:
        2.1 (0.7%), tests_pri_500: 8 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/3] binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, Apr 6, 2020 at 6:34 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> In 2016 Linus moved install_exec_creds immediately after
>> setup_new_exec, in binfmt_elf as a cleanup and as part of closing a
>> potential information leak.
>>
>> Perform the same cleanup for the other binary formats
>
> Can we not move it _into_ setup_new_exec() now if you've changed all
> the binfmt handlers?
>
> The fewer cases of "this gets called by the low-level handler at
> different points" that we have, the better off we'd be, I think. One
> of the complexities of our execve() code is that some of it gets
> called directly, and some of it gets called by the binfmt handler, and
> it's often very hard to see the logic when it jumps out to the binfmt
> code and then back to the generic fs/exec.c code..

Yes.  I already have merging of setup_new_exec and install_exec_creds in
my working tree.  I just posted the simplest set of patches to get the
idea across.

We can almost merge those two with flush_old_exec as well except for the
code that sets the personality between flush_old_exec and and
setup_new_exec.  I am wondering if maybe setting the personality should
be a callback.

Eric

