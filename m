Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38D2AFC74
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgKLBhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:37:13 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:38782 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728047AbgKLATr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:19:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UF0rPRQ_1605140382;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UF0rPRQ_1605140382)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Nov 2020 08:19:43 +0800
Subject: Re: [PATCH] mm/filemap: add static for function
 __add_to_page_cache_locked
To:     Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Josef Bacik <josef@toxicpanda.com>
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
 <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <ddca2a9e-ed89-5dec-b1af-4f2fd2c99b57@linux.alibaba.com>
Date:   Thu, 12 Nov 2020 08:18:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201110115037.f6a53faec8d65782ab65d8b4@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/11/11 上午3:50, Andrew Morton 写道:
> On Tue, 10 Nov 2020 08:39:24 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
> 
>> On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>>>
>>> Otherwise it cause gcc warning:
>>>           ^~~~~~~~~~~~~~~
>>> ../mm/filemap.c:830:14: warning: no previous prototype for
>>> ‘__add_to_page_cache_locked’ [-Wmissing-prototypes]
>>>  noinline int __add_to_page_cache_locked(struct page *page,
>>>               ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?
> 
> hm, yes.

When the config enabled, compiling looks good untill pahole tool
used to get BTF info, but I still failed on a right version pahole
> 1.16. Sorry.

> 
>>>
>>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kernel@vger.kernel.org
>>> ---
>>>  mm/filemap.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/mm/filemap.c b/mm/filemap.c
>>> index d90614f501da..249cf489f5df 100644
>>> --- a/mm/filemap.c
>>> +++ b/mm/filemap.c
>>> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old, struct page *new, gfp_t gfp_mask)
>>>  }
>>>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
>>>
>>> -noinline int __add_to_page_cache_locked(struct page *page,
>>> +static noinline int __add_to_page_cache_locked(struct page *page,
>>>                                         struct address_space *mapping,
>>>                                         pgoff_t offset, gfp_t gfp,
>>>                                         void **shadowp)
> 
> It's unclear to me whether BTF_ID() requires that the target symbol be
> non-static.  It doesn't actually reference the symbol:
> 
> #define BTF_ID(prefix, name) \
>         __BTF_ID(__ID(__BTF_ID__##prefix##__##name##__))
> 

The above usage make me thought BTF don't require the symbol, though
the symbol still exist in vmlinux with 'static'.

So any comments of this, Alexei? 

> Alexei, can you please comment?
> 
