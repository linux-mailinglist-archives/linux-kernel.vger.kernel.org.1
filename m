Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0C42D685F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 21:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390124AbgLJUNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 15:13:50 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:33572 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732879AbgLJTmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 14:42:51 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1knRop-006yDH-4C; Thu, 10 Dec 2020 12:41:39 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1knRoo-0000LM-7f; Thu, 10 Dec 2020 12:41:38 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jann Horn <jannh@google.com>,
        Vasiliy Kulikov <segoon@openwall.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Waiman Long <longman@redhat.com>
References: <87ft4mbqen.fsf@x220.int.ebiederm.org>
        <AM6PR03MB5170412C2B0318C40CED55E5E4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wi6inOF5yvQRwUFbqMt0zFJ8S8GhqE2M0judU7RiGru8Q@mail.gmail.com>
        <875z5h4b7a.fsf@x220.int.ebiederm.org>
        <CAHk-=wio3JXxf3fy8tRVzb69u1e5iUru8p-dw+Mnga6yAdz=HQ@mail.gmail.com>
        <AM6PR03MB51704629E50F6280A52D9FAFE4F10@AM6PR03MB5170.eurprd03.prod.outlook.com>
        <CAHk-=wgxe-KAqR_y2jP58GthOYKk0YG=6gNxKHxVUJbG7z2CoQ@mail.gmail.com>
        <20201207090953.GF3040@hirez.programming.kicks-ass.net>
        <CAHk-=wjgG=_-zONkBkKnkOv3uoVRy45hTxx8e-6Ks3j-3TVHKQ@mail.gmail.com>
        <20201208083412.GR2414@hirez.programming.kicks-ass.net>
        <20201210183849.fdgcagdn4pyghtfn@linux-p48b>
Date:   Thu, 10 Dec 2020 13:40:58 -0600
In-Reply-To: <20201210183849.fdgcagdn4pyghtfn@linux-p48b> (Davidlohr Bueso's
        message of "Thu, 10 Dec 2020 10:38:49 -0800")
Message-ID: <87r1nxmotx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1knRoo-0000LM-7f;;;mid=<87r1nxmotx.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ruw/fWoR4wfy7LMN2DCQ9CCMYZQv0YpQ=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_XM_SB_Phish,T_TM2_M_HEADER_IN_MSG,XMSubLong,
        XMSubPhish11 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.5 XMSubPhish11 Phishy Language Subject
        *  0.0 TR_XM_SB_Phish Phishing flag in subject of message
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Davidlohr Bueso <dave@stgolabs.net>
X-Spam-Relay-Country: 
X-Spam-Timing: total 607 ms - load_scoreonly_sql: 0.13 (0.0%),
        signal_user_changed: 12 (1.9%), b_tie_ro: 9 (1.6%), parse: 1.79 (0.3%),
         extract_message_metadata: 19 (3.1%), get_uri_detail_list: 1.15 (0.2%),
         tests_pri_-1000: 10 (1.6%), tests_pri_-950: 1.92 (0.3%),
        tests_pri_-900: 1.59 (0.3%), tests_pri_-90: 298 (49.1%), check_bayes:
        289 (47.6%), b_tokenize: 9 (1.5%), b_tok_get_all: 7 (1.1%),
        b_comp_prob: 2.3 (0.4%), b_tok_touch_all: 267 (44.0%), b_finish: 1.02
        (0.2%), tests_pri_0: 203 (33.4%), check_dkim_signature: 0.69 (0.1%),
        check_dkim_adsp: 2.8 (0.5%), poll_dns_idle: 0.93 (0.2%), tests_pri_10:
        2.3 (0.4%), tests_pri_500: 53 (8.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] perf: Break deadlock involving exec_update_mutex
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Davidlohr Bueso <dave@stgolabs.net> writes:

> On Tue, 08 Dec 2020, Peter Zijlstra wrote:
>
>>I suppose I'll queue the below into tip/perf/core for next merge window,
>>unless you want it in a hurry?
>
> I'm thinking we'd still want Eric's series on top of this for the reader
> benefits of the lock.

We will see shortly what happens when the various branches all make it
into linux-next.   The two changes don't conflict in principle so it
should not be a problem.

Eric

