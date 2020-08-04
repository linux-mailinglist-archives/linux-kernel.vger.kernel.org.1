Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB77123BCC6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 16:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgHDO6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 10:58:02 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:55488 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgHDO56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:57:58 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2vqc-00CdQ1-77; Tue, 04 Aug 2020 06:15:14 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1k2vqb-0005cg-A8; Tue, 04 Aug 2020 06:15:14 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
        <20200804115649.kzea757e5wwpk4k3@wittgenstein>
Date:   Tue, 04 Aug 2020 07:11:59 -0500
In-Reply-To: <20200804115649.kzea757e5wwpk4k3@wittgenstein> (Christian
        Brauner's message of "Tue, 4 Aug 2020 13:56:49 +0200")
Message-ID: <87d046sj8w.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1k2vqb-0005cg-A8;;;mid=<87d046sj8w.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/3BFn/F3Z7azq2BHX2jvvEfVaZ9j5kYhs=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4267]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 472 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.8%), b_tie_ro: 2.6 (0.5%), parse: 0.60
        (0.1%), extract_message_metadata: 8 (1.7%), get_uri_detail_list: 0.67
        (0.1%), tests_pri_-1000: 3.7 (0.8%), tests_pri_-950: 1.02 (0.2%),
        tests_pri_-900: 0.79 (0.2%), tests_pri_-90: 53 (11.1%), check_bayes:
        51 (10.9%), b_tokenize: 3.9 (0.8%), b_tok_get_all: 6 (1.2%),
        b_comp_prob: 1.44 (0.3%), b_tok_touch_all: 38 (8.0%), b_finish: 0.59
        (0.1%), tests_pri_0: 157 (33.2%), check_dkim_signature: 0.36 (0.1%),
        check_dkim_adsp: 2.9 (0.6%), poll_dns_idle: 223 (47.3%), tests_pri_10:
        1.79 (0.4%), tests_pri_500: 240 (50.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/8] namespaces: Introduce generic refcount
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> On Mon, Aug 03, 2020 at 01:16:10PM +0300, Kirill Tkhai wrote:
>> Every namespace type has its own counter. Some of them are
>> of refcount_t, some of them are of kref.
>> 
>> This patchset introduces generic ns_common::count for any
>> type of namespaces instead of them.
>> 
>> ---
>
> I was wondering why that series never made it to me turns out there's
> some weird bug in my (neo)mutt where it sometimes marks messages as read
> when I'm deleting completely unrelated messages. That has already cost
> me a talk slot for an event I really wanted to attend and now it seems
> to start costing me patches... I need to figure this out.
>
> Anyway, thanks for sending this. I pulled this into my tree now.

Actually why in the world should the reference count be generic?

What is the point of this patchset?

What problem does it solve.  Name spaces are not the same, and
their refcounting needs are not the same so I don't have a clue how it
helps anything to have a reference count in ns_common.

Eric
