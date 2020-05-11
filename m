Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6403D1CE197
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgEKRWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 13:22:04 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17014 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730800AbgEKRWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:22:02 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb989330000>; Mon, 11 May 2020 10:19:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 11 May 2020 10:22:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 11 May 2020 10:22:02 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 May
 2020 17:22:02 +0000
Subject: Re: [PATCH -next] mm/hmm/test: fix missing unlock on error in
 dmirror_migrate_finalize_and_map()
To:     Wei Yongjun <weiyongjun1@huawei.com>, <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
References: <20200509030225.14592-1-weiyongjun1@huawei.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <9f5103ac-4b43-3b4b-d48c-be18f9f2c335@nvidia.com>
Date:   Mon, 11 May 2020 10:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200509030225.14592-1-weiyongjun1@huawei.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589217588; bh=oNA9MbxL6Hlt/03m/rKbFkhF2f03OBo10XuHRGPC52Q=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BOYo/G5hmvvsL9AXVzgTOkibU6aGV/CsuntrK+q8pgqjIIdca+KaLOM8xypshBpl7
         gnmtVg+vRT4oH+dNnk/D29A7SnIAHXKui+rHKVHatF6OX3+Y1t0PRONkRNOWhwVqQ4
         n5mRPAzZ3FoWxvtU4/NonT07wKCdktzLvfKNaUPYd4vJUlpqbvqUtSfdbgYQK3FrMz
         dLkaPVf7LD8rgbc+lYzgWGSE7R7M1CNfDtOkhrafTBra7BUoc2JKAOu2GGjl8I00Zo
         ZdDnQNd48JtMT+GEatG1+nfph/AURZ4heWmHPxBTiirJOm7uGrXr5ZhbXffGlZ4+9T
         xxbDY6jC3VQwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/8/20 8:02 PM, Wei Yongjun wrote:
> Add the missing unlock before return from function
> dmirror_migrate_finalize_and_map() in the error
> handling case.
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
> index 00bca6116f93..30462193c4ff 100644
> --- a/lib/test_hmm.c
> +++ b/lib/test_hmm.c
> @@ -647,8 +647,10 @@ static int dmirror_migrate_finalize_and_map(struct migrate_vma *args,
>   		if (*dst & MIGRATE_PFN_WRITE)
>   			entry = xa_tag_pointer(entry, DPT_XA_TAG_WRITE);
>   		entry = xa_store(&dmirror->pt, pfn, entry, GFP_ATOMIC);
> -		if (xa_is_err(entry))
> +		if (xa_is_err(entry)) {
> +			mutex_unlock(&dmirror->mutex);
>   			return xa_err(entry);
> +		}
>   	}
>   
>   	mutex_unlock(&dmirror->mutex);
> 
> 
> 
> 
