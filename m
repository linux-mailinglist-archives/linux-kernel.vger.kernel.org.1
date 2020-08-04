Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6370423BB7E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 15:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgHDNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 09:55:57 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:59612 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgHDNz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 09:55:56 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2xQ1-00CoGG-PV; Tue, 04 Aug 2020 07:55:53 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2xQ1-0005we-3Y; Tue, 04 Aug 2020 07:55:53 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
        <159644977635.604812.1319877322927063560.stgit@localhost.localdomain>
        <875z9ysit5.fsf@x220.int.ebiederm.org>
        <49106051-be26-7b89-f9e8-7c441dbda18a@virtuozzo.com>
Date:   Tue, 04 Aug 2020 08:52:38 -0500
In-Reply-To: <49106051-be26-7b89-f9e8-7c441dbda18a@virtuozzo.com> (Kirill
        Tkhai's message of "Tue, 4 Aug 2020 15:48:34 +0300")
Message-ID: <87sgd2o6vt.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k2xQ1-0005we-3Y;;;mid=<87sgd2o6vt.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+DDYsCTuxeTfwrL2mTkDzmE3hz8kApqFE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kirill Tkhai <ktkhai@virtuozzo.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 335 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.4 (1.3%), b_tie_ro: 3.0 (0.9%), parse: 1.05
        (0.3%), extract_message_metadata: 12 (3.7%), get_uri_detail_list: 1.78
        (0.5%), tests_pri_-1000: 4.0 (1.2%), tests_pri_-950: 1.11 (0.3%),
        tests_pri_-900: 0.86 (0.3%), tests_pri_-90: 92 (27.4%), check_bayes:
        90 (26.9%), b_tokenize: 4.7 (1.4%), b_tok_get_all: 6 (1.8%),
        b_comp_prob: 1.72 (0.5%), b_tok_touch_all: 75 (22.3%), b_finish: 0.73
        (0.2%), tests_pri_0: 207 (61.8%), check_dkim_signature: 0.59 (0.2%),
        check_dkim_adsp: 2.4 (0.7%), poll_dns_idle: 1.08 (0.3%), tests_pri_10:
        2.8 (0.8%), tests_pri_500: 7 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/8] ns: Add common refcount into ns_common add use it as counter for net_ns
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kirill Tkhai <ktkhai@virtuozzo.com> writes:

> On 04.08.2020 15:21, Eric W. Biederman wrote:
>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>> 
>>> Currently, every type of namespaces has its own counter,
>>> which is stored in ns-specific part. Say, @net has
>>> struct net::count, @pid has struct pid_namespace::kref, etc.
>>>
>>> This patchset introduces unified counter for all types
>>> of namespaces, and converts net namespace to use it first.
>> 
>> And the other refcounts on struct net?
>> 
>> How do they play into what you are trying to do?
>
> I just don't understand you. Different refcounters are related to different
> problems, they are introduced to solve. This patchset changes only one refcounter,
> and it does not touch other of them. What do you want to know about others?
>

Why net::count not net::passive?  What problem are you trying to solve?

They both are reference counts on the network namespace.

I don't understand what you are trying to do, other than take a bunch of
things that look similar and squash them all together.

What semantics does this magical common reference count have?
Why is it better for the count to live in ns_common rather than it
it's own dedicated field of struct net?

Given that decrementing still requires code per namespace to handle
the count going to zero.  How does this benefit anyone?

Has the effect of cache line placement of the move of the reference
count been considered?

All I see in the patch in question is switching a location that the
count lives.  Which does not seem useful to me.

I am not fundamentally oppossed but I don't see the point.  At this
point it looks like you are making things harder to maintain by making
things common that are merely similar.

Eric
