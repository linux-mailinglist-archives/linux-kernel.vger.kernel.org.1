Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA94D2F6AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbhANTRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:17:07 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46848 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhANTRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:17:06 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10EJE4ue013147;
        Thu, 14 Jan 2021 19:16:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=W8xArUkCjxBmZ8x/Oydz945GnUtSXMcioOXYuDzOlT0=;
 b=WBBpG+5mRJWKXyN4GAV3YivEHfNc0FXg7TRb5DtWs1GqRyzYVkCe87V3DrIcOzwS1mgt
 gRe/UUvllQUKwKUczX6FJLGa9tjkWSRYvdMyhsM/ZLLo7M5IEwZhWeJx/q7o9/MoBt1c
 qBoP0KIOSVGNItyTrzaUeiQ6V9xbiYVdtyMzCInd6R/6DFKaQiDmnpiwnxLkOO6Ko8LT
 SM9sR8Cvp0/zTbp7K8xD9igSSteioYhkr+9kzzSqCT4Db4WGR8DjRi16r11lXuOSPDaJ
 WRKtIC+2lHy3UYseuXIYI7a/zk6nHgPp4iIzODWVN5mK6I85T4wOz/RD2jPY+LN08B08 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kd01sr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 19:16:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10EJBmfX006237;
        Thu, 14 Jan 2021 19:16:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 360keaa1n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 19:16:09 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10EJG6U0028547;
        Thu, 14 Jan 2021 19:16:06 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 Jan 2021 11:16:06 -0800
Subject: Re: [PATCH] mm/hugetlb: avoid unnecessary hugetlb_acct_memory() call
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210114113140.23069-1-linmiaohe@huawei.com>
 <853d6aa4-b84c-7ac2-00d4-402893fcf6b3@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b7587d72-fb5b-4e0f-4fa0-d63e035e521c@oracle.com>
Date:   Thu, 14 Jan 2021 11:16:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <853d6aa4-b84c-7ac2-00d4-402893fcf6b3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101140109
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9864 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140109
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/21 4:32 AM, David Hildenbrand wrote:
> On 14.01.21 12:31, Miaohe Lin wrote:
>> When gbl_reserve is 0, hugetlb_acct_memory() will do nothing except holding
>> and releasing hugetlb_lock.
> 
> So, what's the deal then? Adding more code?
> 
> If this is a performance improvement, we should spell it out. Otherwise
> I don't see a real benefit of this patch.
> 

Thanks for finding/noticing this.

As David points out, the commit message should state that this is a
performance improvement.  Mention that such a change avoids an unnecessary
hugetlb_lock lock/unlock cycle.  You can also mention that this unnecessary
lock cycle is happening on 'most' hugetlb munmap operations.

>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/hugetlb.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 737b2dce19e6..fe2da9ad6233 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -5241,7 +5241,8 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>>  	 * reservations to be released may be adjusted.
>>  	 */
>>  	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
>> -	hugetlb_acct_memory(h, -gbl_reserve);
>> +	if (gbl_reserve)
>> +		hugetlb_acct_memory(h, -gbl_reserve);

It is true that gbl_reserve is likely to be 0 in this code path.  However,
there are other code paths where hugetlb_acct_memory is called with a delta
value of 0 as well.  I would rather see a simple check at the beginning of
hugetlb_acct_memory like.

	if (!delta)
		return 0;

-- 
Mike Kravetz

>>  
>>  	return 0;
>>  }
>>
> 
> 
