Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4762882B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 08:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgJIGjY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Oct 2020 02:39:24 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3566 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729440AbgJIGjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:39:08 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id AD46ABF5970B7BBD8726;
        Fri,  9 Oct 2020 14:39:04 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 9 Oct 2020 14:39:04 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Fri, 9 Oct 2020 14:39:04 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mmap: Fix general protection fault in
 unlink_file_vma()
Thread-Topic: [PATCH] mm: mmap: Fix general protection fault in
 unlink_file_vma()
Thread-Index: AdaeAjdrBFGByg+WTS2nogBIdhwMBg==
Date:   Fri, 9 Oct 2020 06:39:04 +0000
Message-ID: <4dcf86d0a9ac474c8dcb903aa6341b9f@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.177.16]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 8 Oct 2020 07:17:18 +0000 linmiaohe <linmiaohe@huawei.com> wrote:
>
>> Andrew Morton <akpm@linux-foundation.org> wrote:
>> > On Wed, 16 Sep 2020 05:07:33 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:
>> >
>> >> The syzbot reported the below general protection fault:
>>
>> >
>> >is this using the correct file?  I think it is, but please do check.
>> >
>> 
>> Many thanks for your reply.
>> 
>> Yes, I think so too. We do deny_write_access and mapping_map_writable on @file, so we should undo all of this on @file.
>> Since @file is unchanged over the second vma_merge() time, we'are using the correct @file to undo our temporary denial count.
>> 
>> But how should I check this explicitly ? I can't find out a way to do this. Could you please figure it out for me?
>
>I meant "please check (review) the code as it now is", not "please add a check" ;)
>

Oh, I see. I have reviewed the code carefully. The @file should be right one as I explained in previous email. ;)

Have a good day! ^_^

