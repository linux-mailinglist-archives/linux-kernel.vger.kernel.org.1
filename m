Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A728B25A2BA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 03:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIBBri convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Sep 2020 21:47:38 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:38226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726131AbgIBBqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:46:34 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id D79D9F063F2F68CEF4D7;
        Wed,  2 Sep 2020 09:46:32 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 2 Sep 2020 09:46:32 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 2 Sep 2020 09:46:32 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] block: Fix potential page reference leak in
 __bio_iov_iter_get_pages()
Thread-Topic: [PATCH] block: Fix potential page reference leak in
 __bio_iov_iter_get_pages()
Thread-Index: AdaAytm+sluc9YAIwkeuWIOV/GEP+w==
Date:   Wed, 2 Sep 2020 01:46:32 +0000
Message-ID: <7fa19b78076e400f8f51c563746d697d@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>On Tue, Sep 01, 2020 at 08:00:06AM -0400, Miaohe Lin wrote:
>> When bio is full, __bio_iov_iter_get_pages() would return error 
>> directly while left page reference still held in pages. Release these references.
>> Also advance the iov_iter according to what we have done successfully.
>> 
>> Fixes: 576ed9135489 ("block: use bio_add_page in 
>> bio_iov_iter_get_pages")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>
>The WARN_ON means something is fundamentally wrong here.  I think a few leaked pages are the least of our problems in this case.

Yes, WARN_ON means something is fundamentally wrong here. But IMO it's not really a big problem when bio is full.
We should not simply rely on this WARN_ON and we can handle this gracefully.
Thanks.

