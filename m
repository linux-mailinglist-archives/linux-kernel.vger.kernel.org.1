Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC027ED0A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgI3Pcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:32:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60210 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgI3Pcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:32:42 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UFTr4B188903;
        Wed, 30 Sep 2020 15:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=d/eusaO+AEks0iXtWCFRWJ64qkcUPYgw88R7l/46ERQ=;
 b=gFZU59qgDvxOopk2tiRMbok0JGzOwMTmLIt8HN7ThsYPSbPDEUwCH9O/7bfiI1GKqC4A
 XKXQPhDlWeB8XGz2/Pq8MsQ6emFqLTmybE6lq5vLWqma3CXNkCq37aLIrq8sAG5Bq3fy
 XB1nz9uPaeHQdPHBieJm0CfWSs2EG2mx5N6928wGPUjz2d0kXs8lqIaaNjVE3jZVEpAo
 r9tCBOWTN4LjzPCkZY4jcncZhWKATT94RCyGUSdWogtCVTqKS/CmXyYD4Ri/wbJ09uVI
 rSk7qjfAWGhrrVr28dJUkGHNGtgbtx+ktiaj23m/xejnRSbelanG17QvJS4y9WsDR4XN 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33swkm16hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 15:32:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UFUVtn089615;
        Wed, 30 Sep 2020 15:32:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 33tfj09py3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 15:32:24 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UFWNt5000711;
        Wed, 30 Sep 2020 15:32:23 GMT
Received: from localhost (/10.159.225.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Sep 2020 08:32:22 -0700
Date:   Wed, 30 Sep 2020 08:32:21 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix potential memory leak in sys_swapon
Message-ID: <20200930153221.GE49559@magnolia>
References: <20200930101803.53884-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930101803.53884-1-linmiaohe@huawei.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=5 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=5 mlxlogscore=999 clxscore=1011 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 06:18:03AM -0400, Miaohe Lin wrote:
> If we failed to drain inode, we would forget to free the swap address space
> allocated by init_swap_address_space() above.
> 
> Fixes: dc617f29dbe5 ("vfs: don't allow writes to swap files")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

LGTM,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  mm/swapfile.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2b0c5fc1b0e6..4522b458a814 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3342,7 +3342,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  	error = inode_drain_writes(inode);
>  	if (error) {
>  		inode->i_flags &= ~S_SWAPFILE;
> -		goto bad_swap_unlock_inode;
> +		goto free_swap_address_space;
>  	}
>  
>  	mutex_lock(&swapon_mutex);
> @@ -3367,6 +3367,8 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
>  
>  	error = 0;
>  	goto out;
> +free_swap_address_space:
> +	exit_swap_address_space(p->type);
>  bad_swap_unlock_inode:
>  	inode_unlock(inode);
>  bad_swap:
> -- 
> 2.19.1
> 
