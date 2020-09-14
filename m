Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A0626825E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 03:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgINBvr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 21:51:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3162 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbgINBvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 21:51:46 -0400
Received: from dggeme753-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 7A4B516DFC6B8F213783;
        Mon, 14 Sep 2020 09:51:41 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme753-chm.china.huawei.com (10.3.19.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Mon, 14 Sep 2020 09:51:41 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Mon, 14 Sep 2020 09:51:41 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>
Subject: Re: general protection fault in unlink_file_vma
Thread-Topic: general protection fault in unlink_file_vma
Thread-Index: AdaKOSZzeAioeGR0Qvi/fuCv5/iZ+g==
Date:   Mon, 14 Sep 2020 01:51:41 +0000
Message-ID: <a6660196fa5a4b71b8f5d6e1bc2aa262@huawei.com>
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

Hillf Danton <hdanton@sina.com> wrote:
> On Sun, 13 Sep 2020 09:17:26 +0000 linmiaohe wrote:
>> 
>> I reviewed the code carefully these days and I found vma_merge() do only fput() the vm_file of the linked vma in remove_next cases.
>> This gpf is much likely because the ->mmap() callback can change 
>> vma->vm_file and fput the original file. But my previous commit failed to catch this case and always fput() the original file, hence add an extra fput().
>> The below patch would make the things right:
>> 
>
>Take another look at the Cc list and the link below.
>
>https://lore.kernel.org/lkml/20200911120222.GT87483@ziepe.ca/
>

Many thanks for your teach. I think I could send the proposed patch to the syzbot directly.
Thanks again.:)

