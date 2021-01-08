Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E253F2EFB38
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbhAHWZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:25:13 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33650 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAHWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:25:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108MF4Ww149384;
        Fri, 8 Jan 2021 22:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jJ8etmteWZ41HBD6qWBhSf930GsQVHkwZKhpGCrLnFc=;
 b=P4lPF61soEzFuhkoW5IsYuM4vTwcWI7HL9KU08NK8XqoFBnq4KsaB6M+w/MRNvZn+PMt
 AWjWEbumeaVeh+kmHIv7F5umyBgcRPZ/LJEXjSc0iZsIXxhTNFbBXK5IDbA2zyLILt0f
 MpjvJUIMoXPaqmS1QIEWCwcbKm6kwJ3eX1lOU8HT9exnR4xmfNlOPkRYl/IbM36bcHZ3
 XD9ovz08IwS/W+sIGo/kuEkRMlg7zAEwqqtITgYKP/gyvPA9wl3aiRRxaDPxejIHFHRk
 2A12aYDcsKa3eB6faHrkmkBuL62WQ1mHdKw2i6p9earXtd6nka2UYP0eET+6b8KYK1kq 1g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35wepmk6ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 08 Jan 2021 22:24:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 108MExoU137164;
        Fri, 8 Jan 2021 22:24:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35v1fd3bey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Jan 2021 22:24:21 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 108MOH5S025417;
        Fri, 8 Jan 2021 22:24:18 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 08 Jan 2021 22:24:17 +0000
Subject: Re: [PATCH v2 6/6] mm: hugetlb: remove VM_BUG_ON_PAGE from
 page_huge_active
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210106084739.63318-1-songmuchun@bytedance.com>
 <20210106084739.63318-7-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b4777be4-fa76-4e71-8659-7d0820005028@oracle.com>
Date:   Fri, 8 Jan 2021 14:24:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210106084739.63318-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101080114
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9858 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101080114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/21 12:47 AM, Muchun Song wrote:
> The page_huge_active() can be called from scan_movable_pages() which
> do not hold a reference count to the HugeTLB page. So when we call
> page_huge_active() from scan_movable_pages(), the HugeTLB page can
> be freed parallel. Then we will trigger a BUG_ON which is in the
> page_huge_active() when CONFIG_DEBUG_VM is enabled. Just remove the
> VM_BUG_ON_PAGE.
> 
> Fixes: 7e1f049efb86 ("mm: hugetlb: cleanup using paeg_huge_active()")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 67200dd25b1d..7a24ed28ec4f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1372,7 +1372,6 @@ struct hstate *size_to_hstate(unsigned long size)
>   */
>  bool page_huge_active(struct page *page)
>  {
> -	VM_BUG_ON_PAGE(!PageHuge(page), page);
>  	return PageHead(page) && PagePrivate(&page[1]);
>  }

After more thought, should that return statement be changed to?
	return PageHeadHuge(page) && PagePrivate(&page[1]);

We only want to test that PagePrivate flag for hugetlb head pages.
Although, the possibility that the hugetlb page was freed and turned
into another compound page in this race window is REALLY small.
-- 
Mike Kravetz
