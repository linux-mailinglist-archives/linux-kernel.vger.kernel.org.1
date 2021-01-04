Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3C2EA01D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 23:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbhADWlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 17:41:07 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:40756 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbhADWlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 17:41:06 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104MV3U4145356;
        Mon, 4 Jan 2021 22:40:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=LixbOTy4EF+FNs39RrzUBWIvM+s7f+0XmxarmtWP29Q=;
 b=yjh+g0OSUpXwCRH2z563xoL/PwcarClS0Vz23CE7vnzhzNL4nb7AxfyRJKqXGx8q+69A
 t5WEq7wIjZaqxQcwWfkhQ2+HMDFQ/yO2Y64aCnpDTtejpAP7m2GpvfHe0aGoGZq4AC0s
 HjGq/KMx3dgxbD0L2NswSf4oG4WvIbZTKPBf2HR1mq3/dJ7yBNX824IU8rUwm2VB3qTR
 yPXZMfkmxBie4ZlIsm0PMxL53IcjGWJCuvQLiGSNboWhxvVoIuTNP2poUB1Iy6dtUdJZ
 O5mujCuXdA/4GHfht6zfwyXmB47MjX3QKBgv20FEDUxHmFbaA5OLNKTP7iynUPRDsYCX 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 35tg8qxggx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 04 Jan 2021 22:40:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 104MXd5G031590;
        Mon, 4 Jan 2021 22:38:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 35v4raq1ey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Jan 2021 22:38:10 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 104Mc4BC013030;
        Mon, 4 Jan 2021 22:38:06 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 Jan 2021 14:38:04 -0800
Subject: Re: [PATCH 2/6] hugetlbfs: fix cannot migrate the fallocated HugeTLB
 page
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-2-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <09be227a-4e16-1960-c8e9-609c35a80ef5@oracle.com>
Date:   Mon, 4 Jan 2021 14:38:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210104065843.5658-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101040134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 10:58 PM, Muchun Song wrote:
> Because we only can isolate a active page via isolate_huge_page()
> and hugetlbfs_fallocate() forget to mark it as active, we cannot
> isolate and migrate those pages.
> 
> Fixes: 70c3547e36f5 (hugetlbfs: add hugetlbfs_fallocate())
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  fs/hugetlbfs/inode.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Good catch.  This is indeed an issue.

> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index b5c109703daa..2aceb085d202 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -737,10 +737,11 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  
>  		/*
>  		 * unlock_page because locked by add_to_page_cache()
> -		 * page_put due to reference from alloc_huge_page()
> +		 * put_page() (which is in the putback_active_hugepage())
> +		 * due to reference from alloc_huge_page()

Thanks for fixing the comment.

>  		 */
>  		unlock_page(page);
> -		put_page(page);
> +		putback_active_hugepage(page);

I'm curious why you used putback_active_hugepage() here instead of simply
calling set_page_huge_active() before the put_page()?

When the page was allocated, it was placed on the active list (alloc_huge_page).
Therefore, the hugetlb_lock locking and list movement should not be necessary.

-- 
Mike Kravetz

>  	}
>  
>  	if (!(mode & FALLOC_FL_KEEP_SIZE) && offset + len > inode->i_size)
> 
