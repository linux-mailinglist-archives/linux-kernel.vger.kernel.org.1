Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22526824E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 03:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgINBi2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 21:38:28 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3096 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbgINBi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 21:38:26 -0400
Received: from dggeme751-chm.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id 17F3DFFA6804FE5AFE9E;
        Mon, 14 Sep 2020 09:38:25 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme751-chm.china.huawei.com (10.3.19.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 14 Sep 2020 09:38:24 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 14 Sep 2020 09:38:24 +0800
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
Thread-Index: AdaKN2L/7QxoEIqgoESUKoVD51FRKg==
Date:   Mon, 14 Sep 2020 01:38:24 +0000
Message-ID: <23352bc3a9914e79a0aa29bc63f830bd@huawei.com>
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
> Miaohe Lin <linmiaohe@huawei.com> writes:
>
>> Use helper function mapping_allow_writable() to atomic_inc 
>> i_mmap_writable.
>
>Why?
>

Because I think it's better to use the wrapper function instead of the open hard code.
Thanks.

