Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807CA2CC36E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389149AbgLBRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:21:02 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:38674 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbgLBRVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:21:01 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkVnf-0097Oh-0Y; Wed, 02 Dec 2020 10:20:19 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kkVnd-0086Cl-6E; Wed, 02 Dec 2020 10:20:18 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alakesh Haloi <alakesh.haloi@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>,
        Minchan Kim <minchan@kernel.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>
References: <20201201024811.GA72235@ip-172-31-62-0.us-west-2.compute.internal>
Date:   Wed, 02 Dec 2020 11:19:46 -0600
In-Reply-To: <20201201024811.GA72235@ip-172-31-62-0.us-west-2.compute.internal>
        (Alakesh Haloi's message of "Mon, 30 Nov 2020 18:48:11 -0800")
Message-ID: <875z5kceh9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kkVnd-0086Cl-6E;;;mid=<875z5kceh9.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1820JkN6MFT05hCDba9I20kjij8AgB5dfE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_12 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alakesh Haloi <alakesh.haloi@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 752 ms - load_scoreonly_sql: 0.09 (0.0%),
        signal_user_changed: 13 (1.7%), b_tie_ro: 11 (1.4%), parse: 1.30
        (0.2%), extract_message_metadata: 5 (0.7%), get_uri_detail_list: 2.4
        (0.3%), tests_pri_-1000: 6 (0.7%), tests_pri_-950: 1.69 (0.2%),
        tests_pri_-900: 1.21 (0.2%), tests_pri_-90: 329 (43.7%), check_bayes:
        327 (43.5%), b_tokenize: 8 (1.0%), b_tok_get_all: 7 (1.0%),
        b_comp_prob: 2.9 (0.4%), b_tok_touch_all: 305 (40.5%), b_finish: 0.99
        (0.1%), tests_pri_0: 375 (49.9%), check_dkim_signature: 0.61 (0.1%),
        check_dkim_adsp: 2.2 (0.3%), poll_dns_idle: 0.45 (0.1%), tests_pri_10:
        1.74 (0.2%), tests_pri_500: 6 (0.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] pid: add null pointer check in pid_nr_ns()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alakesh Haloi <alakesh.haloi@gmail.com> writes:

> There has been at least one occurrence where a null pointer derefernce
> panic was seen with following stack trace.
>
>  #0 [ffffff800bcd3800] machine_kexec at ffffff8008095fb4
>  #1 [ffffff800bcd3860] __crash_kexec at ffffff8008122a30
>  #2 [ffffff800bcd39f0] panic at ffffff80080aa054
>  #3 [ffffff800bcd3ae0] die at ffffff800808aee8
>  #4 [ffffff800bcd3b20] die_kernel_fault at ffffff8008099520
>  #5 [ffffff800bcd3b50] __do_kernel_fault at ffffff8008098e50
>  #6 [ffffff800bcd3b80] do_translation_fault at ffffff800809929c
>  #7 [ffffff800bcd3b90] do_mem_abort at ffffff8008081204
>  #8 [ffffff800bcd3d90] el1_ia at ffffff800808304c
>      PC: ffffff80080c20ec  [pid_nr_ns+4]
>      LR: ffffff80080c231c  [__task_pid_nr_ns+72]
>      SP: ffffff800bcd3da0  PSTATE: 60000005
>     X29: ffffff800bcd3da0  X28: ffffffc00691c380  X27: 0000000000000001
>     X26: 00000000004ce8e8  X25: 00000000004ce8d0  X24: ffffffc00691c3e0
>     X23: ffffffc004e8c000  X22: 0000000000000000  X21: ffffffc00b042ed2
>     X20: ffffff800876a4f0  X19: 0000000000000000  X18: 0000000000000000
>     X17: 0000000000000001  X16: 0000000000000000  X15: 0000000000000000
>     X14: 0000000400000003  X13: 0000000000000008  X12: fefefefefefefeff
>     X11: 0000000000000000  X10: 0000007fffffffff   X9: 00000000004ce8b0
>      X8: 00000000004ce8b0   X7: 0000000000000000   X6: ffffffc00b042ed2
>      X5: ffffffc00b042ed2   X4: 0000000000020008   X3: 53206e69616c702f
>      X2: ffffff800876a4f0   X1: ffffff800876a4f0   X0: 53206e69616c702f
>  #9 [ffffff800bcd3da0] pid_nr_ns at ffffff80080c20e8

I just skimmed through the callers of pid_nr_ns and now I am very
puzzled. I don't see any of them where the namespace can be passed as
NULL.

So I really suspect you have a larger but somewhere in the caller of
pid_nr_ns.  Perhaps the memory was stomped and you were lucky it was
NULL.

Without some more details I really don't think testing for a NULL
namespace is useful or productive.  At best it will mask bugs in the
callers

Eric

> Signed-off-by: Alakesh Haloi <alakesh.haloi@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  kernel/pid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/pid.c b/kernel/pid.c
> index a96bc4bf4f86..3767b9e1431d 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -474,7 +474,7 @@ pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
>  	struct upid *upid;
>  	pid_t nr = 0;
>  
> -	if (pid && ns->level <= pid->level) {
> +	if (pid && ns && ns->level <= pid->level) {
>  		upid = &pid->numbers[ns->level];
>  		if (upid->ns == ns)
>  			nr = upid->nr;
