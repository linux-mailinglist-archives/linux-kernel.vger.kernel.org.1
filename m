Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2972AD5C5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 12:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgKJL7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 06:59:07 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50202 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726861AbgKJL7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:59:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UEspu5m_1605009541;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEspu5m_1605009541)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Nov 2020 19:59:02 +0800
Subject: Re: [PATCH] mm/filemap: add static for function
 __add_to_page_cache_locked
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e93696ed-e4e1-879f-2c63-655aae18dbda@linux.alibaba.com>
Date:   Tue, 10 Nov 2020 19:58:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/10 上午11:09, Souptick Joarder 写道:
> On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>
>> Otherwise it cause gcc warning:
>>           ^~~~~~~~~~~~~~~
>> ../mm/filemap.c:830:14: warning: no previous prototype for
>> ‘__add_to_page_cache_locked’ [-Wmissing-prototypes]
>>  noinline int __add_to_page_cache_locked(struct page *page,
>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?

Sorry, I tried to buld the configure with bzImage, but failed on pahole version too low,
and compiled pahole still can not run in  git://git.kernel.org/pub/scm/devel/pahole/pahole.git
#pahole
pahole: symbol lookup error: pahole: undefined symbol: tabs

> 
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  mm/filemap.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index d90614f501da..249cf489f5df 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
>>  }
>>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
>>
>> -noinline int __add_to_page_cache_locked(struct page *page,
>> +static noinline int __add_to_page_cache_locked(struct page *page,
>>                                         struct address_space *mapping,
>>                                         pgoff_t offset, gfp_t gfp,
>>                                         void **shadowp)
>> --
>> 1.8.3.1
>>
>>
