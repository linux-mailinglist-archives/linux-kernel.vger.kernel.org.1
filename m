Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A8F2F8CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 10:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbhAPJpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 04:45:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:11413 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbhAPJo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 04:44:58 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DHtQj07Znzhsl1;
        Sat, 16 Jan 2021 17:43:25 +0800 (CST)
Received: from [10.174.176.197] (10.174.176.197) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 16 Jan 2021 17:44:10 +0800
Subject: Re: [PATCH] hugetlbfs: correct obsolete function name
 hugetlbfs_read_iter()
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux-MM <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210116093245.47472-1-linmiaohe@huawei.com>
 <CAFqt6zZG_6CVcTEPT2yRcXP6_L+cAfM79Hkx6_5=o5o-yQUExA@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4548039d-2ba4-5df3-95ae-e945fdd3dc34@huawei.com>
Date:   Sat, 16 Jan 2021 17:44:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZG_6CVcTEPT2yRcXP6_L+cAfM79Hkx6_5=o5o-yQUExA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On 2021/1/16 17:36, Souptick Joarder wrote:
> On Sat, Jan 16, 2021 at 3:03 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>>
>> The func do_generic_mapping_read() is killed by commit 36e789144267 ("kill
>> do_generic_mapping_read"). So replace it with do_generic_mapping_read to
>> keep comment uptodate.
> 
> s/func/function
> 
> replace it with generic_file_buffered_read()  ?
> 

Many thanks for your review. I'am going to resend this patch as I forgot to mention the
second commit that rename do_generic_file_read to generic_file_buffered_read. But it looks
I should send a v2 now to fix above comment.

Thanks again.

>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  fs/hugetlbfs/inode.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
>> index 23ad6ed8b75f..d02616513b43 100644
>> --- a/fs/hugetlbfs/inode.c
>> +++ b/fs/hugetlbfs/inode.c
>> @@ -310,7 +310,7 @@ hugetlbfs_read_actor(struct page *page, unsigned long offset,
>>
>>  /*
>>   * Support for read() - Find the page attached to f_mapping and copy out the
>> - * data. Its *very* similar to do_generic_mapping_read(), we can't use that
>> + * data. Its *very* similar to generic_file_buffered_read(), we can't use that
>>   * since it has PAGE_SIZE assumptions.
>>   */
>>  static ssize_t hugetlbfs_read_iter(struct kiocb *iocb, struct iov_iter *to)
>> --
>> 2.19.1
>>
>>
> .
> 
