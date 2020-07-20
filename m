Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A56227281
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 00:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGTWv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 18:51:58 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgGTWv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:51:57 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KMlQTs064857;
        Mon, 20 Jul 2020 22:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=MfVOpGYO+c/8CvGMdsusJbPwlFZUZWWTOqso1rwMQ9Q=;
 b=UZwABRx6F0z4T97rzLd4SqdhyskH9L4VgB5TMtQ/TT3wL8rU+LAFpZZMKgNZs+LwwdcC
 LfNab32vT/CXDQNIVIw1CZltlaKDeH+66gILDJAj/oBW2E4BuCHjphzYBbLT6h9mD+29
 Czrt69chlXss3qoVm7eTvSncKUlbboZ/Sd8YzKYYpytJosz6SFX38n33ti94EifFRI/z
 ExBxWVMzOFP3FG7toLhEH2s7Zdv5GUUx5kxSFUEbdLgCRsvxtoVKqrjabpshhvYtNGqO
 i3ojS5+/QZckihSNc8Wmwcd/U18T+LqjNbvwRHbz5Dj1ce2RZwf+6aCVhZxeUT790mc8 Rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32bs1m9prm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jul 2020 22:51:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06KMmxUn120335;
        Mon, 20 Jul 2020 22:49:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32djyx4qma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 22:49:52 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06KMio1G005378;
        Mon, 20 Jul 2020 22:44:51 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 20 Jul 2020 22:44:50 +0000
Subject: Re: [PATCH 3/5] mm/hugetlb.c: Remove the unnecessary non_swap_entry()
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org
References: <20200720062623.13135-1-bhe@redhat.com>
 <20200720062623.13135-4-bhe@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <c31b8d1f-0cf3-612c-2722-cfdb474da770@oracle.com>
Date:   Mon, 20 Jul 2020 15:44:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200720062623.13135-4-bhe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200142
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9688 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 spamscore=0 mlxscore=0 impostorscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007200142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/20 11:26 PM, Baoquan He wrote:
> The checking is_migration_entry() and is_hwpoison_entry() are stricter
> than non_swap_entry(), means they have covered the conditional check
> which non_swap_entry() is doing.
> 
> Hence remove the unnecessary non_swap_entry() in is_hugetlb_entry_migration()
> and is_hugetlb_entry_hwpoisoned() to simplify code.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Agreed, we can remove the checks for non_swap_entry.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> ---
>  mm/hugetlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a58f976a9dd9..467894d8332a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3748,7 +3748,7 @@ bool is_hugetlb_entry_migration(pte_t pte)
>  	if (huge_pte_none(pte) || pte_present(pte))
>  		return false;
>  	swp = pte_to_swp_entry(pte);
> -	if (non_swap_entry(swp) && is_migration_entry(swp))
> +	if (is_migration_entry(swp))
>  		return true;
>  	else
>  		return false;
> @@ -3761,7 +3761,7 @@ static bool is_hugetlb_entry_hwpoisoned(pte_t pte)
>  	if (huge_pte_none(pte) || pte_present(pte))
>  		return false;
>  	swp = pte_to_swp_entry(pte);
> -	if (non_swap_entry(swp) && is_hwpoison_entry(swp))
> +	if (is_hwpoison_entry(swp))
>  		return true;
>  	else
>  		return false;
> 
