Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF651EE71A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 16:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgFDO6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 10:58:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40761 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729082AbgFDO6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591282713;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=bKjfRbkiXnB0X7JTc9dbYoDxbJmg/pWYB9UpMRhI24U=;
        b=MZDIsPQ3aUVmbWui1UE/LD606jZPnxi8sTfrzQ5UYA4crXeEjNwBguCP7Rt1YL1F+kIf8s
        FNuGl420Fxf6r0GXEI63uB75KLauGusLJI7f0ZcetWGyCCvjMDf8NRAu8sSyvU5XXJ4dDO
        ZaDZrtChJUlfmPR8gcfyIYQIdfVoYV8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-V3vTVmwBNxWSKFFBJLxlVw-1; Thu, 04 Jun 2020 10:58:29 -0400
X-MC-Unique: V3vTVmwBNxWSKFFBJLxlVw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B43E1005512;
        Thu,  4 Jun 2020 14:58:24 +0000 (UTC)
Received: from [10.36.112.96] (ovpn-112-96.ams2.redhat.com [10.36.112.96])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9469410013D5;
        Thu,  4 Jun 2020 14:58:14 +0000 (UTC)
Subject: Re: [RFC v2 7/9] mm/damon: Implement callbacks for physical memory
 monitoring
To:     SeongJae Park <sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        Jonathan.Cameron@Huawei.com, aarcange@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        brendanhiggins@google.com, cai@lca.pw, colin.king@canonical.com,
        corbet@lwn.net, dwmw@amazon.com, foersleo@amazon.de,
        irogers@google.com, jolsa@redhat.com, kirill@shutemov.name,
        mark.rutland@arm.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, sblbir@amazon.com, shakeelb@google.com,
        shuah@kernel.org, sj38.park@gmail.com, snu@amazon.de,
        vbabka@suse.cz, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        ying.huang@intel.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200604072611.11049-1-sjpark@amazon.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <4b5814d8-9626-e71c-9e5d-a4a61fcd12e8@redhat.com>
Date:   Thu, 4 Jun 2020 16:58:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200604072611.11049-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.06.20 09:26, SeongJae Park wrote:
> On Wed, 3 Jun 2020 18:09:21 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
>> On 03.06.20 16:11, SeongJae Park wrote:
>>> From: SeongJae Park <sjpark@amazon.de>
>>>
>>> This commit implements the four callbacks (->init_target_regions,
>>> ->update_target_regions, ->prepare_access_check, and ->check_accesses)
>>> for the basic access monitoring of the physical memory address space.
>>> By setting the callback pointers to point those, users can easily
>>> monitor the accesses to the physical memory.
>>>
>>> Internally, it uses the PTE Accessed bit, as similar to that of the
>>> virtual memory support.  Also, it supports only page frames that
>>> supported by idle page tracking.  Acutally, most of the code is stollen
>>> from idle page tracking.  Users who want to use other access check
>>> primitives and monitor the frames that not supported with this
>>> implementation could implement their own callbacks on their own.
>>>
>>> Signed-off-by: SeongJae Park <sjpark@amazon.de>
>>> ---
>>>  include/linux/damon.h |   5 ++
>>>  mm/damon.c            | 184 ++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 189 insertions(+)
>>>
>>> diff --git a/include/linux/damon.h b/include/linux/damon.h
>>> index 1a788bfd1b4e..f96503a532ea 100644
>>> --- a/include/linux/damon.h
>>> +++ b/include/linux/damon.h
>>> @@ -216,6 +216,11 @@ void kdamond_update_vm_regions(struct damon_ctx *ctx);
>>>  void kdamond_prepare_vm_access_checks(struct damon_ctx *ctx);
>>>  unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx);
>>>  
>>> +void kdamond_init_phys_regions(struct damon_ctx *ctx);
>>> +void kdamond_update_phys_regions(struct damon_ctx *ctx);
>>> +void kdamond_prepare_phys_access_checks(struct damon_ctx *ctx);
>>> +unsigned int kdamond_check_phys_accesses(struct damon_ctx *ctx);
>>> +
>>>  int damon_set_pids(struct damon_ctx *ctx, int *pids, ssize_t nr_pids);
>>>  int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
>>>  		unsigned long aggr_int, unsigned long regions_update_int,
>>> diff --git a/mm/damon.c b/mm/damon.c
>>> index f5cbc97a3bbc..6a5c6d540580 100644
>>> --- a/mm/damon.c
>>> +++ b/mm/damon.c
>>> @@ -19,7 +19,9 @@
>>>  #include <linux/mm.h>
>>>  #include <linux/module.h>
>>>  #include <linux/page_idle.h>
>>> +#include <linux/pagemap.h>
>>>  #include <linux/random.h>
>>> +#include <linux/rmap.h>
>>>  #include <linux/sched/mm.h>
>>>  #include <linux/sched/task.h>
>>>  #include <linux/slab.h>
>>> @@ -480,6 +482,11 @@ void kdamond_init_vm_regions(struct damon_ctx *ctx)
>>>  	}
>>>  }
>>>  
>>> +/* Do nothing.  Users should set the initial regions by themselves */
>>> +void kdamond_init_phys_regions(struct damon_ctx *ctx)
>>> +{
>>> +}
>>> +
>>>  static void damon_mkold(struct mm_struct *mm, unsigned long addr)
>>>  {
>>>  	pte_t *pte = NULL;
>>> @@ -611,6 +618,178 @@ unsigned int kdamond_check_vm_accesses(struct damon_ctx *ctx)
>>>  	return max_nr_accesses;
>>>  }
>>>  
>>> +/* access check functions for physical address based regions */
>>> +
>>> +/* This code is stollen from page_idle.c */
>>> +static struct page *damon_phys_get_page(unsigned long pfn)
>>> +{
>>> +	struct page *page;
>>> +	pg_data_t *pgdat;
>>> +
>>> +	if (!pfn_valid(pfn))
>>> +		return NULL;
>>> +
>>
>> Who provides these pfns? Can these be random pfns, supplied unchecked by
>> user space? Or are they at least mapped into some user space process?
> 
> Your guess is right, users can give random physical address and that will be
> translated into pfn.
> 

Note the difference to idle tracking: "Idle page tracking only considers
user memory pages", this is very different to your use case. Note that
this is why there is no pfn_to_online_page() check in page idle code.

>>
>> IOW, do we need a pfn_to_online_page() to make sure the memmap even was
>> initialized?
> 
> Thank you for pointing out this!  I will use it in the next spin.  Also, this
> code is stollen from page_idle_get_page().  Seems like it should also be
> modified to use it.  I will send the patch for it, either.

pfn_to_online_page() will only succeed for system RAM pages, not
dax/pmem (ZONE_DEVICE). dax/pmem needs special care.

I can spot that you are taking references to random struct pages. This
looks dangerous to me and might mess in complicated ways with page
migration/isolation/onlining/offlining etc. I am not sure if we want that.

-- 
Thanks,

David / dhildenb

