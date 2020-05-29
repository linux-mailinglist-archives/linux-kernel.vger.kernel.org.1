Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21DA21E8633
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 20:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgE2SF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 14:05:26 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:49390 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgE2SFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:05:24 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jejNb-00027S-L0; Fri, 29 May 2020 12:05:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jejNa-0002Wf-GF; Fri, 29 May 2020 12:05:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     liuchao <liuchao173@huawei.com>
Cc:     <mingo@kernel.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <hewenliang4@huawei.com>
References: <20200528040956.30155-1-liuchao173@huawei.com>
Date:   Fri, 29 May 2020 13:01:22 -0500
In-Reply-To: <20200528040956.30155-1-liuchao173@huawei.com> (liuchao's message
        of "Thu, 28 May 2020 12:09:56 +0800")
Message-ID: <87mu5qpqml.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jejNa-0002Wf-GF;;;mid=<87mu5qpqml.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Bsta5A7aKpNO8LR4qg/R9Jt9gYrytK9c=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa04 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;liuchao <liuchao173@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 676 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 9 (1.4%), parse: 1.25 (0.2%),
         extract_message_metadata: 14 (2.1%), get_uri_detail_list: 1.38 (0.2%),
         tests_pri_-1000: 5 (0.7%), tests_pri_-950: 1.28 (0.2%),
        tests_pri_-900: 1.00 (0.1%), tests_pri_-90: 145 (21.5%), check_bayes:
        142 (20.9%), b_tokenize: 7 (1.0%), b_tok_get_all: 4.8 (0.7%),
        b_comp_prob: 2.4 (0.3%), b_tok_touch_all: 123 (18.3%), b_finish: 1.14
        (0.2%), tests_pri_0: 479 (70.9%), check_dkim_signature: 0.97 (0.1%),
        check_dkim_adsp: 18 (2.7%), poll_dns_idle: 0.70 (0.1%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 12 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC] decrease tsk->signal->live before profile_task_exit
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

liuchao <liuchao173@huawei.com> writes:

> I want to dermine which thread is the last one to enter
> do_exit in profile_task_exit. But when a lot of threads
> exit, tsk->signal->live is not correct since it decrease
> after profile_task_exit.

I don't think that would be wise.

Any additional code before the sanity checks at the start of do_exit
seems like a bad idea.

We could probably move the decrement of tsk->signal->live a little
earlier, but not that much earlier in the function.

Does profile_task_exit even make sense that early in the code?  If the
code is doing much of anything that is a completely inappopriate
placement of profile_task_exit.

Eric


> Signed-off-by: liuchao <liuchao173@huawei.com>
> ---
>  kernel/exit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index ce2a75bc0ade..1693764bc356 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -708,6 +708,7 @@ void __noreturn do_exit(long code)
>  	struct task_struct *tsk = current;
>  	int group_dead;
>  
> +	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	profile_task_exit(tsk);
>  	kcov_task_exit(tsk);
>  
> @@ -755,7 +756,6 @@ void __noreturn do_exit(long code)
>  	if (tsk->mm)
>  		sync_mm_rss(tsk->mm);
>  	acct_update_integrals(tsk);
> -	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	if (group_dead) {
>  		/*
>  		 * If the last thread of global init has exited, panic
