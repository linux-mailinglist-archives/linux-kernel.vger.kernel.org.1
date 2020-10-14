Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5235528E71E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390506AbgJNTPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:15:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33752 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390300AbgJNTPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:15:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EJE1bn064445;
        Wed, 14 Oct 2020 19:15:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=1j42pHq4EBOfSNjwOce1RrdYAJW8XRCP6fCRdcIvTYs=;
 b=RlebGTK0wIPB95/GkFiIN9OXTOQns1DP6DaXgjyb7FWfdPkmjFGu/a7B6qTIAA8GJVPI
 2iKzv7jZq2a+i6pxe/SLdjLMRA97vPbSYtvrdtKzZwPB/4afqYwU7bunBP58+BpZ4OdG
 gmK3c4+kX6VqbwKSbX07ErQCSSDQvoqSWAVXV3Pqq9lfdpnGfonn7mOBe4ZahkoyTXCN
 40w2LB3E4F3SQ0+VQGOr/CTPoQBJ+uMmCT/1nFyW6Hqug3OYdjyvqIlL8Om6YM8nqcKa
 REHJvtR5S/Glx+y6PQkiXMKNPS1N51MZlgDa8GyxBgWoZCjQm1mtgL7+bh5ovbxnX71W jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 343vaefnfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Oct 2020 19:15:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09EJFGUj124227;
        Wed, 14 Oct 2020 19:15:39 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 343pv0s61y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 19:15:39 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09EJFblu020821;
        Wed, 14 Oct 2020 19:15:37 GMT
Received: from [10.159.149.68] (/10.159.149.68)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 14 Oct 2020 12:15:37 -0700
Subject: Re: [PATCH 6/8] mm, clear_huge_page: use clear_page_uncached() for
 gigantic pages
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
 <20201014083300.19077-7-ankur.a.arora@oracle.com>
 <20201014152845.GA1424414@gmail.com>
From:   Ankur Arora <ankur.a.arora@oracle.com>
Message-ID: <fcd99cb8-0ccf-49f3-3450-63b5ca5eac1d@oracle.com>
Date:   Wed, 14 Oct 2020 12:15:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201014152845.GA1424414@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140134
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9774 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1011
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010140134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-14 8:28 a.m., Ingo Molnar wrote:
> 
> * Ankur Arora <ankur.a.arora@oracle.com> wrote:
> 
>> Uncached writes are suitable for circumstances where the region written to
>> is not expected to be read again soon, or the region written to is large
>> enough that there's no expectation that we will find the writes in the
>> cache.
>>
>> Accordingly switch to using clear_page_uncached() for gigantic pages.
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>   mm/memory.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/memory.c b/mm/memory.c
>> index eeae590e526a..4d2c58f83ab1 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5092,7 +5092,7 @@ static void clear_gigantic_page(struct page *page,
>>   	for (i = 0; i < pages_per_huge_page;
>>   	     i++, p = mem_map_next(p, page, i)) {
>>   		cond_resched();
>> -		clear_user_highpage(p, addr + i * PAGE_SIZE);
>> +		clear_user_highpage_uncached(p, addr + i * PAGE_SIZE);
>>   	}
>>   }
> 
> So this does the clearing in 4K chunks, and your measurements suggest that
> short memory clearing is not as efficient, right?
I did not measure that separately (though I should), but the performance numbers
around that were somewhat puzzling.

For MOVNTI, the performance via perf bench (single call to memset_movnti())
is pretty close (within margin of error) to what we see with the page-fault
workload (4K chunks in clear_page_nt().)

With 'REP;STOS' though, there's degradation (~30% Broadwell, ~5% Rome) between
perf bench (single call to memset_erms()) compared to the page-fault workload
(4K chunks in clear_page_erms()).

In the second case, we are executing a lot more 'REP;STOS' loops while the
number of instructions in the first case is pretty much the same, so maybe
that's what accounts for it. But I checked and we are not frontend bound.

Maybe there are high setup costs for 'REP;STOS' on Broadwell? It does advertise
X86_FEATURE_ERMS though...

> 
> I'm wondering whether it would make sense to do 2MB chunked clearing on
> 64-bit CPUs, instead of 512x 4k clearing? Both 2MB and GB pages are
> continuous in memory, so accessible to these instructions in a single
> narrow loop.
Yeah, I think it makes sense to do and should be quite straight-forward
as well. I'll try that out. I suspect it might help the X86_FEATURE_NT_BAD
models more but there's no reason why for it to hurt anywhere.


Ankur

> 
> Thanks,
> 

> 	Ingo
> 
