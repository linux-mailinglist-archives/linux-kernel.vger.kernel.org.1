Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0803E2EA2F8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbhAEBpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 20:45:08 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49112 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbhAEBpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:45:08 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1051ciIj015362;
        Tue, 5 Jan 2021 01:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=oW8m9geiNhUXwGgWY3YLTP6ZYtNxCVVHmT9bUBLzxwY=;
 b=YsOldggDkfI43W6LfvP/87J+fRB+vEQGWWqqA9UbLfNS89sx4bJkvVlmD3WQHQYjklhr
 Dn9wpUFCntE9K3/9bvWbVVd5yIg4eK56rqoPi03/ujxWi5AtGfYoWU9Q+xf9iEHB2uGq
 KdGeMMDgRnn+LtOcN2cLPB7/KwqMyiqW4Xnp3jygAwAjsPbEYNASGGaW/hqjvwVm5lT2
 h+TdUgt2aJniXMwZB17gVLrZoCCQ/72AjK6DYWpPUhtRKDwJ8G559j9Fcb6Z5dNtwRrr
 lzv+Eg7z/bsYx1Z0zqOJGeX6TjrL/+PaW6/BR5Z27ljLKwjzupaP6ECYOX1SMTEnUvgK 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 35tebapwuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 01:44:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1051i6qb147752;
        Tue, 5 Jan 2021 01:44:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 35v1f816p9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 01:44:14 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1051h0BR002793;
        Tue, 5 Jan 2021 01:43:00 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 17:43:00 -0800
Subject: Re: [PATCH 5/6] mm: hugetlb: fix a race between isolating and freeing
 page
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7f19025b-755d-16e2-7cfc-cd9a885bce76@oracle.com>
Date:   Mon, 4 Jan 2021 17:42:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210104065843.5658-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101050007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 10:58 PM, Muchun Song wrote:
> There is a race between isolate_huge_page() and __free_huge_page().
> 
> CPU0:                                       CPU1:
> 
> if (PageHuge(page))
>                                             put_page(page)
>                                               __free_huge_page(page)
>                                                   spin_lock(&hugetlb_lock)
>                                                   update_and_free_page(page)
>                                                     set_compound_page_dtor(page,
>                                                       NULL_COMPOUND_DTOR)
>                                                   spin_unlock(&hugetlb_lock)
>   isolate_huge_page(page)
>     // trigger BUG_ON
>     VM_BUG_ON_PAGE(!PageHead(page), page)
>     spin_lock(&hugetlb_lock)
>     page_huge_active(page)
>       // trigger BUG_ON
>       VM_BUG_ON_PAGE(!PageHuge(page), page)
>     spin_unlock(&hugetlb_lock)
> 
> When we isolate a HugeTLB page on CPU0. Meanwhile, we free it to the
> buddy allocator on CPU1. Then, we can trigger a BUG_ON on CPU0. Because
> it is already freed to the buddy allocator.
> 
> Fixes: c8721bbbdd36 ("mm: memory-hotplug: enable memory hotplug to handle hugepage")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
