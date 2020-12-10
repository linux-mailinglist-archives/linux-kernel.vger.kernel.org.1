Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ADC2D6697
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 20:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390241AbgLJTfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 14:35:09 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:50794 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390231AbgLJTew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:34:52 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1knRhY-003NAB-4c; Thu, 10 Dec 2020 12:34:08 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1knRhV-0007a5-H6; Thu, 10 Dec 2020 12:34:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Christopher Yeoh <cyeoh@au1.ibm.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <87tut2bqik.fsf@x220.int.ebiederm.org>
        <87k0tybqfy.fsf@x220.int.ebiederm.org>
        <620f0908-c70a-9e54-e1b5-71d086b20756@redhat.com>
        <20201207090243.GE3040@hirez.programming.kicks-ass.net>
        <87360hy5hp.fsf@x220.int.ebiederm.org>
        <20201208145257.GE2414@hirez.programming.kicks-ass.net>
        <87tuswup9g.fsf@x220.int.ebiederm.org>
        <20201209183633.GA6190@worktop.programming.kicks-ass.net>
Date:   Thu, 10 Dec 2020 13:33:25 -0600
In-Reply-To: <20201209183633.GA6190@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 9 Dec 2020 19:36:33 +0100")
Message-ID: <877dppo3qy.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1knRhV-0007a5-H6;;;mid=<877dppo3qy.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/X5Z3fy+rdCNkYC/9inMQNAdTICwow29A=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2410 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (0.6%), b_tie_ro: 12 (0.5%), parse: 0.94
        (0.0%), extract_message_metadata: 12 (0.5%), get_uri_detail_list: 1.29
        (0.1%), tests_pri_-1000: 5 (0.2%), tests_pri_-950: 1.36 (0.1%),
        tests_pri_-900: 1.20 (0.0%), tests_pri_-90: 198 (8.2%), check_bayes:
        196 (8.1%), b_tokenize: 7 (0.3%), b_tok_get_all: 8 (0.3%),
        b_comp_prob: 2.3 (0.1%), b_tok_touch_all: 174 (7.2%), b_finish: 1.26
        (0.1%), tests_pri_0: 163 (6.7%), check_dkim_signature: 0.45 (0.0%),
        check_dkim_adsp: 3.6 (0.2%), poll_dns_idle: 1981 (82.2%),
        tests_pri_10: 2.6 (0.1%), tests_pri_500: 2008 (83.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 2/3] rwsem: Implement down_read_interruptible
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Dec 08, 2020 at 12:27:39PM -0600, Eric W. Biederman wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> 
>> > On Mon, Dec 07, 2020 at 09:56:34AM -0600, Eric W. Biederman wrote:
>> >
>> >> Do you want to pull these two into a topic branch in the tip tree
>> >> based on v10-rc1?
>> >
>> > I'll go do that. I'll let the robots chew on it before pushing it out
>> > though, I'll reply once it's in tip.git.
>> 
>> Thanks,
>
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/rwsem

Is that branch supposed to be against 34816d20f173
("Merge tag 'gfs2-v5.10-rc5-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2")

If so I can live with that, but it is a little awkward to work with a
base that recent.  As all of my other branches have an older base.

Eric
