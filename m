Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910E926A21C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIOJZl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Sep 2020 05:25:41 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726102AbgIOJZj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:25:39 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 481D8697E6B98C56BB97;
        Tue, 15 Sep 2020 17:25:37 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 15 Sep 2020 17:25:37 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Tue, 15 Sep 2020 17:25:36 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "christian@kellner.me" <christian@kellner.me>,
        "surenb@google.com" <surenb@google.com>,
        "areber@redhat.com" <areber@redhat.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "cyphar@cyphar.com" <cyphar@cyphar.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fork: Use helper function mapping_allow_writable() in
 dup_mmap()
Thread-Topic: [PATCH] fork: Use helper function mapping_allow_writable() in
 dup_mmap()
Thread-Index: AdaLQe567QxoEIqgoESUKoVD51FRKg==
Date:   Tue, 15 Sep 2020 09:25:36 +0000
Message-ID: <df8ee8e7e0ce4a78bd0b6e3599149592@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman <ebiederm@xmission.com> wrote:
> linmiaohe <linmiaohe@huawei.com> writes:
>> Eric W. Biederman <ebiederm@xmission.com> wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> Use helper function mapping_allow_writable() to atomic_inc 
>>>> i_mmap_writable.
>>>
>>>Why?
>>>
>>
>> Because I think it's better to use the wrapper function instead of the 
>> open hard code.
>
>My point is there is no context in this commit message.
>
>What makes it better to use the wrapper function?
>What makes the wrapper function the appropriate function to use?
>Why just this location?
>Why wasn't this change made when the wrapper function was introduced?
>
>I could probably read through the code and figure these things out but the description of the change should really include these things.
>
>Eric

I see. Many thanks for your detailed explaination. :)

