Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFFFB1B2AAA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgDUPIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 11:08:18 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39462 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgDUPIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:08:18 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuVU-0005rQ-Qg; Tue, 21 Apr 2020 09:08:16 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jQuVU-000873-0g; Tue, 21 Apr 2020 09:08:16 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Christof Meerwald <cmeerw@cmeerw.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20200419201336.GI22017@edge.cmeerw.net>
        <87sggyytnh.fsf@x220.int.ebiederm.org>
        <20200421090426.GA6787@redhat.com> <20200421101904.GA9358@redhat.com>
Date:   Tue, 21 Apr 2020 10:05:10 -0500
In-Reply-To: <20200421101904.GA9358@redhat.com> (Oleg Nesterov's message of
        "Tue, 21 Apr 2020 12:19:04 +0200")
Message-ID: <87mu74517d.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jQuVU-000873-0g;;;mid=<87mu74517d.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19Yjwrl5mq9JkJujsk7jmlVVXuCbMojEnw=
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
        *      [score: 0.4904]
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
X-Spam-Timing: total 475 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (2.0%), b_tie_ro: 8 (1.7%), parse: 1.36 (0.3%),
         extract_message_metadata: 17 (3.5%), get_uri_detail_list: 3.1 (0.7%),
        tests_pri_-1000: 20 (4.2%), tests_pri_-950: 1.85 (0.4%),
        tests_pri_-900: 1.49 (0.3%), tests_pri_-90: 270 (56.9%), check_bayes:
        268 (56.4%), b_tokenize: 8 (1.8%), b_tok_get_all: 217 (45.6%),
        b_comp_prob: 2.0 (0.4%), b_tok_touch_all: 37 (7.8%), b_finish: 1.06
        (0.2%), tests_pri_0: 140 (29.5%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        2.1 (0.4%), tests_pri_500: 8 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] remove the no longer needed pid_alive() check in __task_pid_nr_ns()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@redhat.com> writes:

> Starting from 2c4704756cab ("pids: Move the pgrp and session pid pointers
> from task_struct to signal_struct") __task_pid_nr_ns() doesn't dereference
> task->group_leader, we can remove the pid_alive() check.
>
> pid_nr_ns() has to check pid != NULL anyway, pid_alive() just adds the
> unnecessary confusion.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---

Good catch that does simplify things.

Eric

>  kernel/pid.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index bc21c0fb26d8..47221db038e2 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -475,8 +475,7 @@ pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
>  	rcu_read_lock();
>  	if (!ns)
>  		ns = task_active_pid_ns(current);
> -	if (likely(pid_alive(task)))
> -		nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
> +	nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
>  	rcu_read_unlock();
>  
>  	return nr;
