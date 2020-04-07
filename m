Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488E61A0484
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 03:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgDGBcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 21:32:42 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:45564 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:32:41 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLd6V-0006Ks-P8; Mon, 06 Apr 2020 19:32:39 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLd6U-0002DM-UE; Mon, 06 Apr 2020 19:32:39 -0600
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
Date:   Mon, 06 Apr 2020 20:29:50 -0500
In-Reply-To: <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 2 Apr 2020 16:44:15 -0700")
Message-ID: <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jLd6U-0002DM-UE;;;mid=<87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX184byi13ef/CS87u25sW0tA2GELSHaMHJI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4973]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 431 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.1 (0.9%), b_tie_ro: 2.9 (0.7%), parse: 0.65
        (0.2%), extract_message_metadata: 1.80 (0.4%), get_uri_detail_list:
        0.45 (0.1%), tests_pri_-1000: 2.1 (0.5%), tests_pri_-950: 1.05 (0.2%),
        tests_pri_-900: 0.81 (0.2%), tests_pri_-90: 272 (63.0%), check_bayes:
        270 (62.6%), b_tokenize: 3.9 (0.9%), b_tok_get_all: 199 (46.1%),
        b_comp_prob: 1.36 (0.3%), b_tok_touch_all: 63 (14.5%), b_finish: 0.79
        (0.2%), tests_pri_0: 136 (31.5%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.89 (0.2%), tests_pri_10:
        1.73 (0.4%), tests_pri_500: 5 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: [RFC][PATCH 0/3] exec_update_mutex related cleanups
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Since you rightly pointed out the code in fs/exec.c is less readable
than it should be right now.  Here is where I currently sit on making
that code static where possible and as obvious as possible.

I will resend this after the merge window for a proper review when
people are less likely to be distrcacted but I figured I might as well
send this out now so I can see if anyone runs screaming from this code.

Eric W. Biederman (3):
      binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
      exec: Make unlocking exec_update_mutex explict
      exec: Rename the flag called_exec_mmap point_of_no_return

 arch/x86/ia32/ia32_aout.c |  3 +--
 fs/binfmt_aout.c          |  2 +-
 fs/binfmt_elf_fdpic.c     |  2 +-
 fs/binfmt_flat.c          |  3 +--
 fs/exec.c                 | 18 +++++++++---------
 include/linux/binfmts.h   |  7 +++----
 6 files changed, 16 insertions(+), 19 deletions(-)


Eric
