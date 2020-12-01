Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA652C9711
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 06:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgLAFex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 00:34:53 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:33578 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLAFex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 00:34:53 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjyIk-005dbU-Dk; Mon, 30 Nov 2020 22:34:10 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kjyIj-0006aZ-Ql; Mon, 30 Nov 2020 22:34:10 -0700
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
Date:   Mon, 30 Nov 2020 23:33:40 -0600
In-Reply-To: <20201201024811.GA72235@ip-172-31-62-0.us-west-2.compute.internal>
        (Alakesh Haloi's message of "Mon, 30 Nov 2020 18:48:11 -0800")
Message-ID: <87wny2f5u3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kjyIj-0006aZ-Ql;;;mid=<87wny2f5u3.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18MtZitCb7QFHjdyg7l4Hg2K0Oh8eToOCY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_12 autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alakesh Haloi <alakesh.haloi@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 304 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 4.2 (1.4%), b_tie_ro: 2.8 (0.9%), parse: 1.04
        (0.3%), extract_message_metadata: 4.3 (1.4%), get_uri_detail_list: 2.1
        (0.7%), tests_pri_-1000: 3.2 (1.0%), tests_pri_-950: 1.15 (0.4%),
        tests_pri_-900: 0.90 (0.3%), tests_pri_-90: 53 (17.6%), check_bayes:
        52 (17.2%), b_tokenize: 5 (1.8%), b_tok_get_all: 6 (2.1%),
        b_comp_prob: 1.90 (0.6%), b_tok_touch_all: 36 (11.8%), b_finish: 0.68
        (0.2%), tests_pri_0: 219 (72.1%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.4 (0.8%), poll_dns_idle: 1.03 (0.3%), tests_pri_10:
        2.4 (0.8%), tests_pri_500: 7 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] pid: add null pointer check in pid_nr_ns()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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

I am still thinking this through.  What called pid_nr_ns with
a NULL pid namespace?  That was not apparent from the backtrace you
provided.

Maybe it is sane to check for NULL but it may be preferable to fix the
caller.

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
