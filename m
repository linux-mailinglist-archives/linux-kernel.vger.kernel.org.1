Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37CBD1A114A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgDGQYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 12:24:49 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51364 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgDGQYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:24:49 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLr1q-0007kn-CT; Tue, 07 Apr 2020 10:24:46 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jLr1p-00012A-LW; Tue, 07 Apr 2020 10:24:46 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
        <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
        <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
        <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
        <87lfnda3w3.fsf@x220.int.ebiederm.org>
        <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
        <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
        <87imic3wtz.fsf_-_@x220.int.ebiederm.org>
        <20200407161706.l5zfgghwr3p4vz2c@wittgenstein>
Date:   Tue, 07 Apr 2020 11:21:57 -0500
In-Reply-To: <20200407161706.l5zfgghwr3p4vz2c@wittgenstein> (Christian
        Brauner's message of "Tue, 7 Apr 2020 18:17:06 +0200")
Message-ID: <87h7xv1d22.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jLr1p-00012A-LW;;;mid=<87h7xv1d22.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/9gZcSDonlOVUHsWDJfD7KVLL35dBpU6M=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 319 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (3.7%), b_tie_ro: 10 (3.2%), parse: 1.40
        (0.4%), extract_message_metadata: 21 (6.6%), get_uri_detail_list: 1.40
        (0.4%), tests_pri_-1000: 21 (6.7%), tests_pri_-950: 1.26 (0.4%),
        tests_pri_-900: 0.99 (0.3%), tests_pri_-90: 87 (27.2%), check_bayes:
        79 (24.7%), b_tokenize: 9 (2.7%), b_tok_get_all: 6 (2.0%),
        b_comp_prob: 3.0 (0.9%), b_tok_touch_all: 57 (17.9%), b_finish: 1.03
        (0.3%), tests_pri_0: 160 (50.1%), check_dkim_signature: 0.74 (0.2%),
        check_dkim_adsp: 2.5 (0.8%), poll_dns_idle: 0.31 (0.1%), tests_pri_10:
        2.3 (0.7%), tests_pri_500: 9 (2.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/3] exec: Make unlocking exec_update_mutex explict
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Mon, Apr 06, 2020 at 08:31:52PM -0500, Eric W. Biederman wrote:
>> 
>> With install_exec_creds updated to follow immediately after
>> setup_new_exec, the failure of unshare_sighand is the only
>> code path where exec_update_mutex is held but not explicitly
>> unlocked.
>> 
>> Update that code path to explicitly unlock exec_update_mutex.
>> 
>> Remove the unlocking of exec_update_mutex from free_bprm.
>> 
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Yeah, assuming that I didn't miss any subtleties just now.
> By "explicit" I assume you mean not conditionally unlocked, i.e. we
> don't need to check any condition in free_binprm().

Yes.  Not conditionally unlocked is what I meant.

> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

Eric
