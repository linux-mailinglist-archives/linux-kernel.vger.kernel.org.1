Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613962D322C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 19:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbgLHS3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 13:29:05 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:48604 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgLHS3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 13:29:05 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kmhin-002dQe-3P; Tue, 08 Dec 2020 11:28:21 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kmhij-007tVT-Fz; Tue, 08 Dec 2020 11:28:20 -0700
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
Date:   Tue, 08 Dec 2020 12:27:39 -0600
In-Reply-To: <20201208145257.GE2414@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Tue, 8 Dec 2020 15:52:57 +0100")
Message-ID: <87tuswup9g.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kmhij-007tVT-Fz;;;mid=<87tuswup9g.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/iGgeJHJE2smz5oxfFAlHTueqe3oPu7oQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
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
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3090 ms - load_scoreonly_sql: 0.08 (0.0%),
        signal_user_changed: 11 (0.4%), b_tie_ro: 10 (0.3%), parse: 1.30
        (0.0%), extract_message_metadata: 16 (0.5%), get_uri_detail_list: 0.83
        (0.0%), tests_pri_-1000: 8 (0.3%), tests_pri_-950: 1.63 (0.1%),
        tests_pri_-900: 1.37 (0.0%), tests_pri_-90: 131 (4.2%), check_bayes:
        128 (4.2%), b_tokenize: 9 (0.3%), b_tok_get_all: 6 (0.2%),
        b_comp_prob: 2.8 (0.1%), b_tok_touch_all: 108 (3.5%), b_finish: 0.95
        (0.0%), tests_pri_0: 157 (5.1%), check_dkim_signature: 0.61 (0.0%),
        check_dkim_adsp: 2.3 (0.1%), poll_dns_idle: 2735 (88.5%),
        tests_pri_10: 2.2 (0.1%), tests_pri_500: 2757 (89.2%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 2/3] rwsem: Implement down_read_interruptible
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Mon, Dec 07, 2020 at 09:56:34AM -0600, Eric W. Biederman wrote:
>
>> Do you want to pull these two into a topic branch in the tip tree
>> based on v10-rc1?
>
> I'll go do that. I'll let the robots chew on it before pushing it out
> though, I'll reply once it's in tip.git.

Thanks,

Eric
