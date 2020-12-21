Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2832E0168
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgLUUGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:06:01 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:37460 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgLUUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:06:01 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1krRQl-00CHvM-JI; Mon, 21 Dec 2020 13:05:19 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1krRQk-00GYLe-Jk; Mon, 21 Dec 2020 13:05:19 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Pedro Alves <palves@redhat.com>,
        Simon Marchi <simon.marchi@efficios.com>,
        linux-kernel@vger.kernel.org
References: <20201217142931.GA8865@redhat.com>
        <875z50roia.fsf@x220.int.ebiederm.org>
        <20201218141032.GA20989@redhat.com>
Date:   Mon, 21 Dec 2020 14:04:37 -0600
In-Reply-To: <20201218141032.GA20989@redhat.com> (Oleg Nesterov's message of
        "Fri, 18 Dec 2020 15:10:33 +0100")
Message-ID: <87y2hrj57u.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1krRQk-00GYLe-Jk;;;mid=<87y2hrj57u.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/s8ZZXLXlj6CFHb1K5Bn01iz7SJDxMFzc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 482 ms - load_scoreonly_sql: 0.11 (0.0%),
        signal_user_changed: 12 (2.4%), b_tie_ro: 10 (2.1%), parse: 0.99
        (0.2%), extract_message_metadata: 4.3 (0.9%), get_uri_detail_list:
        1.62 (0.3%), tests_pri_-1000: 7 (1.4%), tests_pri_-950: 1.35 (0.3%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 165 (34.3%), check_bayes:
        164 (33.9%), b_tokenize: 7 (1.4%), b_tok_get_all: 16 (3.4%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 135 (28.0%), b_finish: 0.89
        (0.2%), tests_pri_0: 270 (55.9%), check_dkim_signature: 1.15 (0.2%),
        check_dkim_adsp: 2.6 (0.5%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH] ptrace: make ptrace() fail if the tracee changed its pid unexpectedly
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 12/17, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > Suppose we have 2 threads, the group-leader L and a sub-theread T,
>> > both parked in ptrace_stop(). Debugger tries to resume both threads
>> > and does
>> >
>> > 	ptrace(PTRACE_CONT, T);
>> > 	ptrace(PTRACE_CONT, L);
>> >
>> > If the sub-thread T execs in between, the 2nd PTRACE_CONT doesn not
>> > resume the old leader L, it resumes the post-exec thread T which was
>> > actually now stopped in PTHREAD_EVENT_EXEC. In this case the
>> > PTHREAD_EVENT_EXEC event is lost, and the tracer can't know that the
>> > tracee changed its pid.
>>
>> The change seems sensible.  I don't expect this is common but it looks
>> painful to deal with if it happens.
>
> Yes, this is not a bug, but gdb can't handle this case without some help
> from the kernel.

>> I admit this a threaded PTRACE_EVENT_EXEC is the only event we are
>> likely to miss but still.
>
> Yes, this is the only event debugger can miss even if it uses wait()
> correctly.

I think that is my confusion with the patch.  The uniqueness of this
case is not described well.


Eric
