Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0C2304512
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391235AbhAZRWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:22:15 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11591 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731907AbhAZGyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 01:54:05 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DPy866p8FzMPVl;
        Tue, 26 Jan 2021 14:51:50 +0800 (CST)
Received: from [10.174.179.117] (10.174.179.117) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Tue, 26 Jan 2021 14:53:18 +0800
Subject: Re: [PATCH] mm/hugetlb: Simplify the calculation of variables
To:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <1611643468-52233-1-git-send-email-abaci-bugfix@linux.alibaba.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <3378e469-be94-956a-a53c-4067e437e604@huawei.com>
Date:   Tue, 26 Jan 2021 14:53:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611643468-52233-1-git-send-email-abaci-bugfix@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:
On 2021/1/26 14:44, Jiapeng Zhong wrote:
> Fix the following coccicheck warnings:
> 
> ./mm/hugetlb.c:3372:20-22: WARNING !A || A && B is equivalent to
> !A || B.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cbf32d2..5e6a6e7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3367,8 +3367,7 @@ static unsigned int allowed_mems_nr(struct hstate *h)
>  	mpol_allowed = policy_nodemask_current(gfp_mask);
>  
>  	for_each_node_mask(node, cpuset_current_mems_allowed) {
> -		if (!mpol_allowed ||
> -		    (mpol_allowed && node_isset(node, *mpol_allowed)))
> +		if (!mpol_allowed || node_isset(node, *mpol_allowed))
>  			nr += array[node];
>  	}
>  
> 

I'm gonna do this too. :)

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
