Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310C51F9C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgFOQC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 12:02:59 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:55470 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:02:58 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jkrZX-0000Jz-9p; Mon, 15 Jun 2020 10:02:55 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jkrZS-0006kj-Th; Mon, 15 Jun 2020 10:02:54 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <477ac099-e272-b873-fccf-c68c5b729fe9@infradead.org>
Date:   Mon, 15 Jun 2020 10:58:38 -0500
In-Reply-To: <477ac099-e272-b873-fccf-c68c5b729fe9@infradead.org> (Randy
        Dunlap's message of "Sun, 14 Jun 2020 20:45:07 -0700")
Message-ID: <87a714cocx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jkrZS-0006kj-Th;;;mid=<87a714cocx.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/yVMbGMInvS5dqSamTLx7OYsQlVCtOJTs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,T_TooManySym_04,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_04 7+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Randy Dunlap <rdunlap@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3717 ms - load_scoreonly_sql: 0.10 (0.0%),
        signal_user_changed: 12 (0.3%), b_tie_ro: 11 (0.3%), parse: 1.17
        (0.0%), extract_message_metadata: 19 (0.5%), get_uri_detail_list: 1.63
        (0.0%), tests_pri_-1000: 17 (0.5%), tests_pri_-950: 1.37 (0.0%),
        tests_pri_-900: 1.09 (0.0%), tests_pri_-90: 343 (9.2%), check_bayes:
        341 (9.2%), b_tokenize: 6 (0.2%), b_tok_get_all: 248 (6.7%),
        b_comp_prob: 1.63 (0.0%), b_tok_touch_all: 82 (2.2%), b_finish: 0.92
        (0.0%), tests_pri_0: 271 (7.3%), check_dkim_signature: 0.51 (0.0%),
        check_dkim_adsp: 2.1 (0.1%), poll_dns_idle: 3027 (81.4%),
        tests_pri_10: 1.99 (0.1%), tests_pri_500: 3045 (81.9%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH] <linux/rculist.h>: fix kernel-doc notation & warning
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:

> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix a kernel-doc warning due to missing a beginning '*' on the
> comment line.
>
> ../include/linux/rculist.h:515: warning: bad line:                           [@right ][node2 ... ]
>

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

> Fixes: 35fc0e3b0bd5 ("rculist: Add hlists_swap_heads_rcu")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: rcu@vger.kernel.org
> ---
>  include/linux/rculist.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-58-rc1.orig/include/linux/rculist.h
> +++ lnx-58-rc1/include/linux/rculist.h
> @@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(str
>   * @right: The hlist head on the right
>   *
>   * The lists start out as [@left  ][node1 ... ] and
> -                          [@right ][node2 ... ]
> + *                        [@right ][node2 ... ]
>   * The lists end up as    [@left  ][node2 ... ]
>   *                        [@right ][node1 ... ]
>   */
