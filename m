Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DDA26286F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 09:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgIIHVf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Sep 2020 03:21:35 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728584AbgIIHVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:21:32 -0400
Received: from dggeme701-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id E3AFDEFBD496FBEB8A4A;
        Wed,  9 Sep 2020 15:21:29 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme701-chm.china.huawei.com (10.1.199.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 9 Sep 2020 15:21:29 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 9 Sep 2020 15:21:29 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH] block: Fix potential page reference leak in
 __bio_iov_append_get_pages()
Thread-Topic: [PATCH] block: Fix potential page reference leak in
 __bio_iov_append_get_pages()
Thread-Index: AdaGeYbS4+128GBUdUCUDmTThZkpcw==
Date:   Wed, 9 Sep 2020 07:21:29 +0000
Message-ID: <022b3453c5bf4bbf9fcee79770e0389a@huawei.com>
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

Johannes Thumshirn <Johannes.Thumshirn@wdc.com> wrote:
>On 05/09/2020 11:41, Miaohe Lin wrote:
>> When bio_add_hw_page() failed, we left page reference still held in pages.
>
>I'd add "from iov_iter_get_pages()" to the above sentence.
>

Sounds good. Will add it in v2.

>Otherwise
>Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Many Thanks for review.

