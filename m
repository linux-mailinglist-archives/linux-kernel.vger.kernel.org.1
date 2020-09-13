Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC28268036
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 18:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgIMQTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 12:19:36 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58072 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIMQTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 12:19:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kHUih-00514F-NR; Sun, 13 Sep 2020 10:19:15 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:55736 helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kHUig-0008H6-Jy; Sun, 13 Sep 2020 10:19:15 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <christian.brauner@ubuntu.com>, <akpm@linux-foundation.org>,
        <peterz@infradead.org>, <mingo@kernel.org>, <christian@kellner.me>,
        <surenb@google.com>, <areber@redhat.com>, <shakeelb@google.com>,
        <cyphar@cyphar.com>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>
References: <20200913092415.24408-1-linmiaohe@huawei.com>
Date:   Sun, 13 Sep 2020 11:18:55 -0500
In-Reply-To: <20200913092415.24408-1-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Sun, 13 Sep 2020 05:24:15 -0400")
Message-ID: <87r1r5wsy8.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kHUig-0008H6-Jy;;;mid=<87r1r5wsy8.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/l0hTNb5Jm3CMgXlcvB1n4k4tpgaYsOQo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
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
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miaohe Lin <linmiaohe@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 572 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (2.4%), b_tie_ro: 12 (2.0%), parse: 0.90
        (0.2%), extract_message_metadata: 12 (2.0%), get_uri_detail_list: 0.82
        (0.1%), tests_pri_-1000: 5 (0.9%), tests_pri_-950: 1.29 (0.2%),
        tests_pri_-900: 1.11 (0.2%), tests_pri_-90: 228 (39.9%), check_bayes:
        225 (39.3%), b_tokenize: 4.4 (0.8%), b_tok_get_all: 114 (19.9%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 99 (17.4%), b_finish: 1.52
        (0.3%), tests_pri_0: 296 (51.8%), check_dkim_signature: 0.46 (0.1%),
        check_dkim_adsp: 157 (27.5%), poll_dns_idle: 145 (25.3%),
        tests_pri_10: 2.1 (0.4%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH] fork: Use helper function mapping_allow_writable() in dup_mmap()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> Use helper function mapping_allow_writable() to atomic_inc
> i_mmap_writable.

Why?


> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4b328aecabb2..a0586716e327 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -558,7 +558,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  				atomic_dec(&inode->i_writecount);
>  			i_mmap_lock_write(mapping);
>  			if (tmp->vm_flags & VM_SHARED)
> -				atomic_inc(&mapping->i_mmap_writable);
> +				mapping_allow_writable(mapping);
>  			flush_dcache_mmap_lock(mapping);
>  			/* insert tmp into the share list, just after mpnt */
>  			vma_interval_tree_insert_after(tmp, mpnt,
