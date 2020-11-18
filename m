Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32A102B8401
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgKRSoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:44:06 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41936 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgKRSoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:44:06 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIIhfdQ061670;
        Wed, 18 Nov 2020 18:43:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=SL22lGGVpKno+/uHpGKGIJnK6X8Tldkc1ill4oT2NE8=;
 b=FE59WBZlOMjuY9q4kIArWoGE6DVKBOeqHXKmMPcQ90nx1PfsJYH3obIG9B3oMm8hhRSJ
 FYntKWygafq3M+OMiaP9SribXfIuvloRlIKOfipP9tNypA8BNekLWXEMUWlC4y8b2B92
 eW1nTTwvsZ1WnpMyvktPhIffDrB17MxcjQzcHHTLp0seiQV4IqLlwiFgx3CDyWd0PH+h
 CFnwvd0JiboGRqU4I8XAonBL2IjISB8wmhCdXfRcC3Erv20hxII9lncLp9Htos/9hrL6
 FsifPqNo8aIjyDmGqkrObVnSEmEUWz3/qq4NLRsSljd5DvNScxVuJKEwnri9mXOA3+vI Kg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34t7vn9jvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 18:43:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AIIfNkC035313;
        Wed, 18 Nov 2020 18:41:56 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 34umd0xcba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Nov 2020 18:41:56 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AIIfrs6020208;
        Wed, 18 Nov 2020 18:41:53 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Nov 2020 10:41:52 -0800
Subject: Re: [PATCH] mm: hugetlb: fix type of delta parameter in
 gather_surplus_pages()
To:     Liu Xiang <liu.xiang@zlingsmart.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, Pan Jiagen <pan.jiagen@zlingsmart.com>
References: <1605705241-3561-1-git-send-email-liu.xiang@zlingsmart.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <51fbc8e7-7e9d-4070-f8d5-83b33d2d4607@oracle.com>
Date:   Wed, 18 Nov 2020 10:41:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1605705241-3561-1-git-send-email-liu.xiang@zlingsmart.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9809 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011180130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/20 5:14 AM, Liu Xiang wrote:
> On 64-bit machine, delta variable in hugetlb_acct_memory() may be larger
> than 0xffffffff, but gather_surplus_pages() can only use the low 32-bit
> value now.
> 
> Reported-by: Ma Chenggong <ma.chenggong@zlingsmart.com>
> Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
> Signed-off-by: Pan Jiagen <pan.jiagen@zlingsmart.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 37f15c3..293b36d 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1943,7 +1943,7 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>   * Increase the hugetlb pool such that it can accommodate a reservation
>   * of size 'delta'.
>   */
> -static int gather_surplus_pages(struct hstate *h, int delta)
> +static int gather_surplus_pages(struct hstate *h, long delta)
>  	__must_hold(&hugetlb_lock)
>  {
>  	struct list_head surplus_list;

Thank you for noticing the type difference.

However, if the parameter delta is changed to long then we should also change
the local variables in gather_surplus_pages that are used with delta.
Specifically, the local variables 'needed', 'allocated' and 'i' should also be
of type long.
-- 
Mike Kravetz
