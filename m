Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BCB303A94
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404074AbhAZKm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:42:28 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:52867 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730965AbhAZCEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:04:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UMvltN6_1611626603;
Received: from 30.21.164.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UMvltN6_1611626603)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 10:03:23 +0800
Subject: Re: [PATCH] mm/filemap: Remove redundant variable's assignment
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <08dc7237b44b9455ab095b44dc6969a1607b08db.1611544316.git.baolin.wang@linux.alibaba.com>
 <20210125152237.d3cfebac78907fb50ae5cbbc@linux-foundation.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
Message-ID: <59c68a70-4938-709c-77f4-2a2aea5e269d@linux.alibaba.com>
Date:   Tue, 26 Jan 2021 10:03:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210125152237.d3cfebac78907fb50ae5cbbc@linux-foundation.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2021/1/26 7:22, Andrew Morton Ð´µÀ:
> On Mon, 25 Jan 2021 11:20:02 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> We've already set the variable 'i' 's initial value before using it,
>> thus remove redundant previous assignment of variable 'i'.
>>
>> ...
>>
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -2472,7 +2472,6 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
>>   		if ((iocb->ki_flags & IOCB_WAITQ) && written)
>>   			iocb->ki_flags |= IOCB_NOWAIT;
>>   
>> -		i = 0;
>>   		pg_nr = generic_file_buffered_read_get_pages(iocb, iter,
>>   							     pages, nr_pages);
>>   		if (pg_nr < 0) {
> 
> Matthew's patch series "Refactor generic_file_buffered_read "
> (https://lkml.kernel.org/r/20210122160140.223228-1-willy@infradead.org)
> changes all this code - I dont think the patch is relevant after that,
> so I'll skip it.

Ah, right. Thanks for letting me know.
