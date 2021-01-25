Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45A7030222C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 07:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbhAYGhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 01:37:52 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11487 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbhAYGfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 01:35:24 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPKnQ5sZTzjCyN;
        Mon, 25 Jan 2021 14:33:30 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 14:34:37 +0800
Subject: Re: [PATCH] mm/filemap: Adding missing mem_cgroup_uncharge() to
 __add_to_page_cache_locked()
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alex.shi@linux.alibaba.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Waiman Long <longman@redhat.com>
References: <20210125042441.20030-1-longman@redhat.com>
 <20210125043631.GD308988@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2e0f5b6d-6928-48f9-74b4-89a026b38f2c@huawei.com>
Date:   Mon, 25 Jan 2021 14:34:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210125043631.GD308988@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/25 12:36, Matthew Wilcox wrote:
> On Sun, Jan 24, 2021 at 11:24:41PM -0500, Waiman Long wrote:
>> diff --git a/mm/filemap.c b/mm/filemap.c
>> index 5c9d564317a5..aa0e0fb04670 100644
>> --- a/mm/filemap.c
>> +++ b/mm/filemap.c
>> @@ -835,6 +835,7 @@ noinline int __add_to_page_cache_locked(struct page *page,
>>  	XA_STATE(xas, &mapping->i_pages, offset);
>>  	int huge = PageHuge(page);
>>  	int error;
>> +	bool charged = false;
> 
> I don't think we need this extra bool.
> 
>> @@ -896,6 +898,8 @@ noinline int __add_to_page_cache_locked(struct page *page,
>>  
>>  	if (xas_error(&xas)) {
>>  		error = xas_error(&xas);
>> +		if (charged)
>> +			mem_cgroup_uncharge(page);
>>  		goto error;
>>  	}
> 
> Better:
> 
> -		goto error;
> +		goto uncharge;
> ...
> +uncharge:
> +	if (!huge)

Since commit 7a02fa97b897 ("secretmem: add memcg accounting"), this may be:
	if (!huge && !page_is_secretmem(page))
Or just bool charged is better?
Many thanks.
> +		mem_cgroup_uncharge(page);
>  error:
> ...
> 
> .
> 
