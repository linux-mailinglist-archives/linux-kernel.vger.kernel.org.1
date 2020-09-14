Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9022693FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgINRrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:47:20 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:41740 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgINMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:03:57 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kHnCe-006GOo-TE; Mon, 14 Sep 2020 06:03:24 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kHnCd-0004kn-Vt; Mon, 14 Sep 2020 06:03:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "christian.brauner\@ubuntu.com" <christian.brauner@ubuntu.com>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz\@infradead.org" <peterz@infradead.org>,
        "mingo\@kernel.org" <mingo@kernel.org>,
        "christian\@kellner.me" <christian@kellner.me>,
        "surenb\@google.com" <surenb@google.com>,
        "areber\@redhat.com" <areber@redhat.com>,
        "shakeelb\@google.com" <shakeelb@google.com>,
        "cyphar\@cyphar.com" <cyphar@cyphar.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <23352bc3a9914e79a0aa29bc63f830bd@huawei.com>
Date:   Mon, 14 Sep 2020 07:03:03 -0500
In-Reply-To: <23352bc3a9914e79a0aa29bc63f830bd@huawei.com> (linmiaohe's
        message of "Mon, 14 Sep 2020 01:38:24 +0000")
Message-ID: <87h7s0va4o.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kHnCd-0004kn-Vt;;;mid=<87h7s0va4o.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19DUNV8SW3I069vNxB+YtPgPAYKB1GiTRI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4464]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;linmiaohe <linmiaohe@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 473 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 10 (2.1%), b_tie_ro: 9 (1.9%), parse: 0.75 (0.2%),
         extract_message_metadata: 12 (2.5%), get_uri_detail_list: 0.76 (0.2%),
         tests_pri_-1000: 13 (2.7%), tests_pri_-950: 1.06 (0.2%),
        tests_pri_-900: 0.80 (0.2%), tests_pri_-90: 109 (23.0%), check_bayes:
        107 (22.6%), b_tokenize: 4.9 (1.0%), b_tok_get_all: 4.2 (0.9%),
        b_comp_prob: 1.37 (0.3%), b_tok_touch_all: 93 (19.7%), b_finish: 0.95
        (0.2%), tests_pri_0: 310 (65.6%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 2.3 (0.5%), poll_dns_idle: 0.71 (0.1%), tests_pri_10:
        3.8 (0.8%), tests_pri_500: 10 (2.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fork: Use helper function mapping_allow_writable() in dup_mmap()
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> Eric W. Biederman <ebiederm@xmission.com> wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>
>>> Use helper function mapping_allow_writable() to atomic_inc 
>>> i_mmap_writable.
>>
>>Why?
>>
>
> Because I think it's better to use the wrapper function instead of the
> open hard code.

My point is there is no context in this commit message.

What makes it better to use the wrapper function?
What makes the wrapper function the appropriate function to use?
Why just this location?
Why wasn't this change made when the wrapper function was introduced?

I could probably read through the code and figure these things out
but the description of the change should really include these things.

Eric
