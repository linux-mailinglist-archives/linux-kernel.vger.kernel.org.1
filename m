Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C48A293A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 13:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393883AbgJTLvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 07:51:15 -0400
Received: from mail-bn8nam11on2081.outbound.protection.outlook.com ([40.107.236.81]:14112
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393628AbgJTLvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 07:51:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=My0E6ZgwSnYLxw+7tjk+hBD5WZHPNKUSWOEvD2pLY/CIxtOtt4ofIzwLBHY4Lzo1BIGml5hNYOrongtUNlTa1dN/S32WGjvVJGbmt3/bH1VXybFyakqLUuqDj6YzFqxkMo9uWb/QDg38uui68Z/H9DwhxtDhzX4aWvOCg9zAodt2Mrhj6hm8nmyXLnmlAApCCABr8gxFFo8tXbqzqnkmHHuGQkisfbGO011PSLcHFUDK8kVWkPootigLvJ56u2+UdVDdKQ8ZTNy41nLSm61gkeKjbw9IrOGzJCxHh2jHBuO2zUh29G4o6BfM0Nh3z1xjcGunONxLmaAwGOSFz85/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZKaeRAiqrQOkRITs12acbNwstZzN/mH4XuNomTsEWk=;
 b=gAwOjtz2erG58BdjIQn9QwjyiJLXLQfHY1HAOwDsDGr0e3Kis2VqSNWH/H8EqsVUArtB2lQsIHymPwIclJ7XVX16qSb3LaaC/IxT2WrPnBOCtsqpgE1jPwplxvpY+XimRxsBu6CHwBG3E9tLbwdEikn3r5Cdc+pPZzqi9YXQuxEHOpYlAQFe3I/PUUq5yfy0KtbsRTvL5bxMCMjv974+hmWVpR+pO40TvTzlOS2FfnlejLrBMZ7keQFDCQK+hIgQT6WFPldrdTl1RPNjDJ1ZVDuEvwcQhBxpy41OHTQEWLwzPerPJCg4zULg8VHe0UuM0XsL7R/T53yJrfnMTbIOyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZKaeRAiqrQOkRITs12acbNwstZzN/mH4XuNomTsEWk=;
 b=mISZd5O07Zy0soijTL5GhyBR31wzBRqyUBxtmqFkw8OPVvYBhsNwZSP9nwSbJD+ySFr862GkxGqJCiSESWCm0HfrBDZN+jb7WNmOoRSX/v636n83iXH3mFWSbdagC5rOFm0cHrR+nzDUAv46t84WSwMnRu+V9YT4RxYHocjiidc=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3190.namprd11.prod.outlook.com (2603:10b6:a03:7b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.28; Tue, 20 Oct
 2020 11:50:42 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b%6]) with mapi id 15.20.3477.028; Tue, 20 Oct 2020
 11:50:41 +0000
Subject: Re: [External] Re: [PATCH] mm/memory.c: Introduce non-atomic
 __{Set,Clear}PageSwapCache
To:     Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, osalvador@suse.de,
        alexander.h.duyck@linux.intel.com, yang.shi@linux.alibaba.com,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <20201019101520.12283-1-songmuchun@bytedance.com>
 <20201019123137.GG27114@dhcp22.suse.cz>
 <CAMZfGtVa7n_W2QYA1a8xM3HFtPne8XcWDObytEujO47CBkwYWw@mail.gmail.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <1b5198a5-247c-23aa-3be7-f5821a672cc2@windriver.com>
Date:   Tue, 20 Oct 2020 19:50:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <CAMZfGtVa7n_W2QYA1a8xM3HFtPne8XcWDObytEujO47CBkwYWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::13) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK0PR01CA0049.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Tue, 20 Oct 2020 11:50:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea6f4ffa-1bbb-42e5-7332-08d874ee5ee9
X-MS-TrafficTypeDiagnostic: BYAPR11MB3190:
X-Microsoft-Antispam-PRVS: <BYAPR11MB31903D0A66F6EC95DE426E1DE41F0@BYAPR11MB3190.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBqvBslRIwWoRj9hG955A7oCUkJPOlxZ4CahvJVJVESvFhd0XLfu0Y+/oLonCYfJWga+z2bCySrz2cuk+7VsD4SsqjqBSjfg0Y20K1Hc1SXAQjALMtJh09GLMFwsLi+Tb1gpUBWdwbEYirDRHzfc3mhCz/bHAzr6c+YH5Qcyovk/J6ai1QTlM9k4KixYUhPyllx7PH4DS9gXKp3nL+GzgjLrSXR+ZAwiTcX7g+SH1AlO14kCNVdQHzTDgyPv2pOa4Me2TahP9doqU4WvXUgmpo2YSBj16EB1Zsl2jOJ1OcHNV9PLgFBIHxL9f/i6ui3iXA2c4mloqjRzpjA7nAzu7Q3pJ1nboGNLSD6UY10wGHZ6mKFxnTWx3CCLF4k/2dQRDvwZ2ZyuQ9JJlNj97WCA/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(52116002)(316002)(31686004)(478600001)(5660300002)(956004)(2616005)(31696002)(186003)(6666004)(110136005)(54906003)(86362001)(7416002)(36756003)(53546011)(26005)(83380400001)(8676002)(66476007)(66556008)(16576012)(16526019)(6486002)(8936002)(2906002)(4326008)(6706004)(66946007)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: h7f9St4KxliN7JmwUu9K7S4qMRtxg2Dw+MercfpOL8JZWlYsH3ZaVgxviQOVc3RiIQyWpI3l7NgPKg8k6r/M68eIV8iYbyRvocLT4lxFxxF+YYsufApm7mK6cBzXPl60U4h6RYYcWeV2KG0s31A6eXLtjoMd+OS7OBRZXsakd5kcUh3zZeXcnjbyjod9KF6PdEW8fo5TpdiUz+OgGqqywrBIwVoV4yhq6CLEywTbclu2M7JuOWhfixIjz9FKrMmoahFofaGofyR2QKIvskuKUgE3TsZsa7Q9Lz7g5CMtjKdVYjyuXVVb4qa7zy1HNICdK3hKvDNvzbNcTwZCflCE7EPrTlVPGN6C6WqOFp/BA+O/RM8UBsZVReuXd1Vkrvb9Jqj2aQdId/OX9CvxAaIYyaMAhX4L5AETSUYOgHeEBhVuS6+jeL1WMnNKqxQbpILBb3gxt7c0xUUVUSWxiLvz/dxuVTJfIfpK4Y6RbTNps/nO6+QQIuKyrE7M/pQywutgDngy3nrxxxG4Is6wF9k5ioYkA4cKt5g0QBBZ5O7cbYnziEI6pi47OAgKVzbExE3+fYO2twdwgLt3YytuVuNPR/x9nPM5mDW74yez4QYUD87B0zRQ8NUJjo2YsEYtVIxOJDOYQ113AYYzVw00Nxm5Mw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6f4ffa-1bbb-42e5-7332-08d874ee5ee9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2020 11:50:41.8200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAw+1RqVb7+qlvsEU4cGTf/myZRjR7ybHbnnMIHu7f0smWfiF2bxGbBunXg7q4EdELb3t8SaquqYCnI5raG1RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3190
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/20 10:58 PM, Muchun Song wrote:
> On Mon, Oct 19, 2020 at 8:31 PM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Mon 19-10-20 18:15:20, Muchun Song wrote:
>>> For the exclusive reference page, the non-atomic operations is enough,
>>> so replace them to non-atomic operations.
>>
>> I do expect you do not see any difference in runtime and this is mostly
>> driven by the code reading, right? Being explicit about this in the code
>> would be preferred.
> 
> Yeah, just code reading.And the set_bit and __set_bit is actually different
> on some architectures. Thanks.
> 
>>
>> No objection to the change.
>>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>
>> With an improved changelog
>> Acked-by: Michal Hocko <mhocko@suse.com>
>>
>>> ---
>>>   include/linux/page-flags.h | 2 ++
>>>   mm/memory.c                | 4 ++--
>>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>> index fbbb841a9346..ec039dde5e4b 100644
>>> --- a/include/linux/page-flags.h
>>> +++ b/include/linux/page-flags.h
>>> @@ -401,6 +401,8 @@ static __always_inline int PageSwapCache(struct page *page)
>>>   }
>>>   SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>>>   CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>>> +__SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>>> +__CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>>>   #else
>>>   PAGEFLAG_FALSE(SwapCache)
>>>   #endif
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 2d267ef6621a..02dd62da26e0 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3128,10 +3128,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>                                set_page_private(page, entry.val);
>>>
>>>                                /* Tell memcg to use swap ownership records */
>>> -                             SetPageSwapCache(page);
>>> +                             __SetPageSwapCache(page);

Good evening, Muchun. I found there are still some places could be 
replaced with __SetPageSwapCache（）. Such as shmem_replace_page（）, why 
PG_locked has been set before SetPageSwapCache（） is involved.

Would you please to check the rest places? :)

Thanks

Acked-by: Yanfei Xu <yanfei.xu@windriver.com>

>>>                                err = mem_cgroup_charge(page, vma->vm_mm,
>>>                                                        GFP_KERNEL);
>>> -                             ClearPageSwapCache(page);
>>> +                             __ClearPageSwapCache(page);
>>>                                if (err) {
>>>                                        ret = VM_FAULT_OOM;
>>>                                        goto out_page;
>>> --
>>> 2.20.1
>>>
>>
>> --
>> Michal Hocko
>> SUSE Labs
> 
> 
> 
