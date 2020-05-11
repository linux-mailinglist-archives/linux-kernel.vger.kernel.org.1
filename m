Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F104C1CE17F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 19:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730931AbgEKRUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 13:20:19 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:16849 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730215AbgEKRUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:20:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb988cc0000>; Mon, 11 May 2020 10:18:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 May 2020 10:20:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 May 2020 10:20:18 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 May
 2020 17:20:18 +0000
Subject: Re: [PATCH -next] mm/hmm/test: fix error return code in
 hmm_dmirror_init()
To:     Wei Yongjun <weiyongjun1@huawei.com>, <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20200509030234.14747-1-weiyongjun1@huawei.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <b8da4751-ea8a-7e4d-9a6c-ee6bd7038eb7@nvidia.com>
Date:   Mon, 11 May 2020 10:20:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200509030234.14747-1-weiyongjun1@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589217484; bh=wNAbLk5sDgndY9hDmHmxMZeBtoQPrcvtrpgtPuwit0M=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DWV1hSl5q9MhAU6xNAFYiGni49rK3N2gDogEE1sB6S7uYJY1E8bnF9MzNFAG2+top
         RRx3eL/aLmjj+CsPT99PNpomuBpFpdBzYqvNm2kwLA2ToodCT48Kktx2D9VNEp49J1
         4gUkiE+cBOEeb2qg2GXeCvyDHXghhVh+9mqZHgfzfm8+Hc5eMHpB5PehQL09uBl/aF
         PCUFkj/L7mwwo+s0+oLd+HOjCUS+XUJBeyVFoh0RKzJwOZaFr/qWJ9Yst8fKJiJhoR
         asRSsplrtjNa+v/C6sSv+C7WzpxFANnXhBHvKHMfB8/5XZlWi1Vtqz7vWE+iUkuRvW
         aG9ngH4914iog==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/8/20 8:02 PM, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the alloc_page() error
> handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: 5d5e54be8a1e ("mm/hmm/test: add selftest driver for HMM")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Looks good, thanks!
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   lib/test_hmm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
> index 00bca6116f93..b4d9434e49e7 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -1119,8 +1119,10 @@ static int __init hmm_dmirror_init(void)
>   	 * make the code here simpler (i.e., we need a struct page for it).
>   	 */
>   	dmirror_zero_page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> -	if (!dmirror_zero_page)
> +	if (!dmirror_zero_page) {
> +		ret = -ENOMEM;
>   		goto err_chrdev;
> +	}
>   
>   	pr_info("HMM test module loaded. This is only for testing HMM.\n");
>   	return 0;
> 
> 
> 
