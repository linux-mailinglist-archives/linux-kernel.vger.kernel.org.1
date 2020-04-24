Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C974D1B7F75
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 21:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbgDXT6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 15:58:07 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48954 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgDXT6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 15:58:07 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS4Sa-0004H3-Qr; Fri, 24 Apr 2020 13:58:04 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jS4Sa-0007oo-3E; Fri, 24 Apr 2020 13:58:04 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christof Meerwald <cmeerw@cmeerw.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20200419201336.GI22017@edge.cmeerw.net>
        <87sggyytnh.fsf@x220.int.ebiederm.org>
        <20200421090426.GA6787@redhat.com> <20200421101904.GA9358@redhat.com>
        <87mu74517d.fsf@x220.int.ebiederm.org>
        <20200424180523.GD26802@redhat.com>
Date:   Fri, 24 Apr 2020 14:54:55 -0500
In-Reply-To: <20200424180523.GD26802@redhat.com> (Oleg Nesterov's message of
        "Fri, 24 Apr 2020 20:05:24 +0200")
Message-ID: <87d07wpskw.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jS4Sa-0007oo-3E;;;mid=<87d07wpskw.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+QVvs3O+peet5LQjScDuiQmGVaCM7O6Wc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMGappySubj_01,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 332 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (3.3%), b_tie_ro: 9 (2.8%), parse: 0.86 (0.3%),
         extract_message_metadata: 11 (3.3%), get_uri_detail_list: 0.83 (0.3%),
         tests_pri_-1000: 14 (4.1%), tests_pri_-950: 1.26 (0.4%),
        tests_pri_-900: 1.01 (0.3%), tests_pri_-90: 166 (49.9%), check_bayes:
        164 (49.5%), b_tokenize: 4.5 (1.4%), b_tok_get_all: 51 (15.4%),
        b_comp_prob: 1.56 (0.5%), b_tok_touch_all: 103 (31.2%), b_finish: 1.04
        (0.3%), tests_pri_0: 116 (34.9%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.4 (0.7%), poll_dns_idle: 0.59 (0.2%), tests_pri_10:
        2.1 (0.6%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] remove the no longer needed pid_alive() check in __task_pid_nr_ns()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> On 04/21, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > Starting from 2c4704756cab ("pids: Move the pgrp and session pid pointers
>> > from task_struct to signal_struct") __task_pid_nr_ns() doesn't dereference
>> > task->group_leader, we can remove the pid_alive() check.
>> >
>> > pid_nr_ns() has to check pid != NULL anyway, pid_alive() just adds the
>> > unnecessary confusion.
>> >
>> > Signed-off-by: Oleg Nesterov <oleg@redhat.com>
>> Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> Thanks, can you take this patch?

I plan to.  Probably on a topic branch for signals.  I am sorting
that out now.

Eric

