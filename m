Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534D0277E2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 04:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgIYCsB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 24 Sep 2020 22:48:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3560 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726448AbgIYCsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 22:48:01 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 0E2D0C137D03431F3A16;
        Fri, 25 Sep 2020 10:47:59 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 25 Sep 2020 10:47:58 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Fri, 25 Sep 2020 10:47:58 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/mempool: Add 'else' to split mutually exclusive
 case
Thread-Topic: [PATCH v2] mm/mempool: Add 'else' to split mutually exclusive
 case
Thread-Index: AdaS5faxg3FHsPPEQpeRvHY4DCGK8w==
Date:   Fri, 25 Sep 2020 02:47:58 +0000
Message-ID: <3cc5c0cd2eef450ca8d8843ab72edc98@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 24 Sep 2020 07:16:41 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:
>
>> Add else to split mutually exclusive case and avoid some unnecessary check.
>> It doesn't seem to change code generation (compiler is smart), but I 
>> think it helps readability.
>
> OK, I guess.  But the comments are now in the wrong place.
>

Many thanks for kindly reply and fix the wrong comments place.
Have a good day!

> --- a/mm/mempool.c~mm-mempool-add-else-to-split-mutually-exclusive-case-fix
> +++ a/mm/mempool.c
> @@ -60,8 +60,8 @@ static void check_element(mempool_t *poo
>  	/* Mempools backed by slab allocator */
>  	if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
>  		__check_element(pool, element, ksize(element));
> -	/* Mempools backed by page allocator */
>  	} else if (pool->free == mempool_free_pages) {
> +		/* Mempools backed by page allocator */
>  		int order = (int)(long)pool->pool_data;
>  		void *addr = kmap_atomic((struct page *)element);
>  
> @@ -83,8 +83,8 @@ static void poison_element(mempool_t *po
>  	/* Mempools backed by slab allocator */
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc) {
>  		__poison_element(element, ksize(element));
> -	/* Mempools backed by page allocator */
>  	} else if (pool->alloc == mempool_alloc_pages) {
> +		/* Mempools backed by page allocator */
>  		int order = (int)(long)pool->pool_data;
>  		void *addr = kmap_atomic((struct page *)element);
>  
> _
>
>
