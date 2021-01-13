Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F202F516D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbhAMRu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:50:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33772 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbhAMRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:50:58 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DHYPmG054016;
        Wed, 13 Jan 2021 17:50:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wo8LZ7eA6a5WktVrAu4Z2fQye1mJht9qUOWl/ksXaI0=;
 b=lPm0AyYKPvYM1GVU6r3aTkCvNHisCuFiktsGUswyw8YdLRkKtGMDJzYN5TcY/aI5IWvS
 bPJnAY2MeWTNtNGtiXPUf6yqrAW9V4T94xRoQzcJm1NuQir9s46Az113b4SN3Quiqtdd
 JlrkDVCV47ouiF0D+BZDlteiANxYZqnRponNB4jpymsb4Dm2f23PEpXyUWhpAuk7Q0BY
 NwJYKmQbxAIGaVpVQp3l5ESTCUG4dhI+EPhkPQkce52Ds27hHCdQsQzUc4BRONpPJwTu
 PUfGHdhTqd/S16nmf5k6dqOMD9ft6lccJWyxqG8hLh8xMufPFrzUbrLeWRzxwpwdmmUu ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 360kcyvqwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 17:50:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10DHZfom031149;
        Wed, 13 Jan 2021 17:50:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 360ke8rwnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jan 2021 17:50:04 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10DHnxs6002288;
        Wed, 13 Jan 2021 17:49:59 GMT
Received: from [192.168.2.112] (/50.38.35.18) by default (Oracle Beehive
 Gateway v4.0) with ESMTP ; Wed, 13 Jan 2021 09:49:47 -0800
USER-AGENT: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
Content-Language: en-US
MIME-Version: 1.0
Message-ID: <14c4f841-efd2-e5ac-ba6e-567dc2a3461c@oracle.com>
Date:   Wed, 13 Jan 2021 09:49:46 -0800 (PST)
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@kernel.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/3] hugetlb: use page.private for hugetlb specific
 page flags
References: <20210111210152.118394-1-mike.kravetz@oracle.com>
 <20210111210152.118394-2-mike.kravetz@oracle.com>
 <20210113135439.GA29271@linux>
In-Reply-To: <20210113135439.GA29271@linux>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130106
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9863 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/21 5:54 AM, Oscar Salvador wrote:
> On Mon, Jan 11, 2021 at 01:01:50PM -0800, Mike Kravetz wrote:
>> As hugetlbfs evolved, state information about hugetlb pages was added.
>> One 'convenient' way of doing this was to use available fields in tail
>> pages.  Over time, it has become difficult to know the meaning or contents
>> of fields simply be looking at a small bit of code.  Sometimes, the
>> naming is just confusing.  For example: The PagePrivate flag indicates
>> a huge page reservation was consumed and needs to be restored if an error
>> is encountered and the page is freed before it is instantiated.  The
>> page.private field contains the pointer to a subpool if the page is
>> associated with one.
>>
>> In an effort to make the code more readable, use page.private to contain
>> hugetlb specific flags.  These flags will have test, set and clear functions
>> similar to those used for 'normal' page flags.  More importantly, the
>> flags will have names which actually reflect their purpose.
>>
>> In this patch,
>> - Create infrastructure for huge page flag functions
>> - Move subpool pointer to page[1].private to make way for flags
>>   Create routines with meaningful names to modify subpool field
>> - Use new HPageRestoreReserve reserve flag instead of PagePrivate
>>
>> Conversion of other state information will happen in subsequent patches.
> 
> I like this idea, it would make the code much easier to follow, and together
> with Muchun's gathering indiscrete index hugetlb code will start looking less
> scarier.

Thanks for taking a look.

> 
> I do have a question below:
> 
>> +enum htlb_page_flags {
>> +	HPAGE_RestoreReserve = 0,
>> +};
>> +
>> +/*
>> + * Macros to create function definitions for hpage flags
>> + */
>> +#define TESTHPAGEFLAG(flname)					\
>> +static inline int HPage##flname(struct page *page)		\
>> +	{ return test_bit(HPAGE_##flname, &(page->private)); }
>> +
>> +#define SETHPAGEFLAG(flname)					\
>> +static inline void SetHPage##flname(struct page *page)		\
>> +	{ set_bit(HPAGE_##flname, &(page->private)); }
>> +
>> +#define CLEARHPAGEFLAG(flname)					\
>> +static inline void ClearHPage##flname(struct page *page)	\
>> +	{ clear_bit(HPAGE_##flname, &(page->private)); }
>> +
>> +#define HPAGEFLAG(flname)					\
>> +	TESTHPAGEFLAG(flname)					\
>> +	SETHPAGEFLAG(flname)					\
>> +	CLEARHPAGEFLAG(flname)
>> +
>> +HPAGEFLAG(RestoreReserve)
> 
> I have mixed feelings about this.
> Could we have a single function that sets/clears the bit/flag?
> e.g:
> 
>  static inline void hugetlb_set_flag(struct page *p, page_flag)
>  {
>          set_bit(flag, &(page->private));
>  }
> 
> etc.
> It would look less of an overkill?

Sure, we could do this.  As noted, I simply patterned this after the
page flag routines in page-flags.h.  If we go to single functions as
you suggest, I would perhaps change the name a bit to indicate the flags
were associated with the page.  Invoking code comparison would be:

SetHPageRestoreReserve(page)
	-vs-
hugetlb_set_pageflag(page, HP_Restore_Reserve)

In either case, code would be more readable and you can easily grep for
a specific flag.

If we do go with single functions as above, then they would certainly be
moved to hugetlb.h as some flags need to be accessed outside hugetlb.c.
Muchun has already suggested this movement.
-- 
Mike Kravetz
