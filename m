Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583912856C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 04:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgJGCt4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Oct 2020 22:49:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3972 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726627AbgJGCt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 22:49:56 -0400
Received: from dggeme704-chm.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id ECC9AD7A04AD3283F671;
        Wed,  7 Oct 2020 10:49:53 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme704-chm.china.huawei.com (10.1.199.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Wed, 7 Oct 2020 10:49:53 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Wed, 7 Oct 2020 10:49:53 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: Use memset to fill the swap_map with
 SWAP_HAS_CACHE
Thread-Topic: [PATCH] mm: swap: Use memset to fill the swap_map with
 SWAP_HAS_CACHE
Thread-Index: AdacVHOfcvqglLF2RVOhF41KsDdb4w==
Date:   Wed, 7 Oct 2020 02:49:53 +0000
Message-ID: <bd833f513d2a47daaa55099421bd4f7a@huawei.com>
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

Friendly ping.

> We could use helper memset to fill the swap_map with SWAP_HAS_CACHE instead of a direct loop here to simplify the code. Also we can remove the local variable i and map this way.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/swapfile.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c index 8feaab31a3a9..b0b629b24e3a 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -975,8 +975,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)  {
>  	unsigned long idx;
>  	struct swap_cluster_info *ci;
> -	unsigned long offset, i;
> -	unsigned char *map;
> +	unsigned long offset;
>  
>  	/*
>  	 * Should not even be attempting cluster allocations when huge @@ -996,9 +995,7 @@ static int swap_alloc_cluster(struct swap_info_struct *si, swp_entry_t *slot)
>  	alloc_cluster(si, idx);
>  	cluster_set_count_flag(ci, SWAPFILE_CLUSTER, CLUSTER_FLAG_HUGE);
>  
> -	map = si->swap_map + offset;
> -	for (i = 0; i < SWAPFILE_CLUSTER; i++)
> -		map[i] = SWAP_HAS_CACHE;
> +	memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
>  	unlock_cluster(ci);
>  	swap_range_alloc(si, offset, SWAPFILE_CLUSTER);
>  	*slot = swp_entry(si->type, offset);
> --
> 2.19.1
>
