Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0333D2946AD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 04:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411411AbgJUCwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 22:52:23 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:46049
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406511AbgJUCwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 22:52:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib7XwTAPVghVwt6jk4YtaA3WSZlQgSzp/XqigijZxjLZb0q0huzYIhE6PB11m6p6STPlJa9pnYe7czaWYqQI3vPr0Ky75IMRAsnZNd92Fnk5tX4lZIingibKeLcJ9jlE1GizsiAfnc4DIgw3Gp/+6K6UbKtVDiB3CdNIys0driNyaXkIEfOw6HupdSePXSX27aiLPUKaxL1/8t8EVimDSCC5vziUZOZyolZbtnglL0cUoM+8T7YDy/ats1H+3bHgRE/ObQ9dkAMr4xoAFgVaRfgzx2fZv4hOukKGeEOAsl3ZaRw7LKUt7KZNA76kYtKt4O3SXcfLZJ74rCfll6P5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9yFpzZdTtmdv9UTsSeizjA/+6QMavDLbsG1X6luSmg=;
 b=gdZO4wdVrflRbfoHSzJlCI7BGPWT5YrBznMXVnT+mjKwbfEMobixmFpInTZQNJutGIBXpE/ENDK2u7obF49Fg6mOTTQbzJKk2K/ver1qiZW//Mha0D+68SAr+Xb37d2pRvuIP52kRrTxeXLPO1f6jr/pDT4TMqTnPLOpBUeVb6ctN+3u/giDq3eJJV/yO05IrpFq33/6OihsoVlOi+dy5ZYFBCDoNz50NAYmHU9gqDt0tBrx5MBo04NGVCpS799Y6vxzORUSQfkyeKiPVVYIfuYr4R37UxVLZMuBoeGx0HuoQaNo6l9/b1rNxqlss69JqOPY3p7yya85nk3Qx03Kxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9yFpzZdTtmdv9UTsSeizjA/+6QMavDLbsG1X6luSmg=;
 b=Fnbqc6ZQJUm1nWuFFb+7tT4DoNGHv2xpnzxY46LkJwU/dT2dC6+z5C5g9tZ2vNIu7vu/t2PpMZSSKVIQY3zG9WC93Yk5vgcWq2Btp2+P7gQHdReZbDhm+jiXk7RbEugsEvjexpZzyx02EkT71uX4upO9f8wnxEisgnUhMMZGuds=
Authentication-Results: kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BYAPR11MB3623.namprd11.prod.outlook.com (2603:10b6:a03:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 02:52:20 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::adbd:559a:4a78:f09b%6]) with mapi id 15.20.3477.029; Wed, 21 Oct 2020
 02:52:19 +0000
Subject: Re: [External] Re: [PATCH] mm/memory.c: Introduce non-atomic
 __{Set,Clear}PageSwapCache
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
 <1b5198a5-247c-23aa-3be7-f5821a672cc2@windriver.com>
 <CAMZfGtVJb1HJLGEYH2aFgDvjES80UYm11cYadLo0jrmUTsy0eg@mail.gmail.com>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <8a69c987-284c-67c9-5b57-eed684653e4f@windriver.com>
Date:   Wed, 21 Oct 2020 10:52:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <CAMZfGtVJb1HJLGEYH2aFgDvjES80UYm11cYadLo0jrmUTsy0eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY5PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::39) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BY5PR16CA0026.namprd16.prod.outlook.com (2603:10b6:a03:1a0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 02:52:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd793236-aa4f-4494-b3fd-08d8756c5342
X-MS-TrafficTypeDiagnostic: BYAPR11MB3623:
X-Microsoft-Antispam-PRVS: <BYAPR11MB362378C7ED2F0EDF8EDDFE77E41C0@BYAPR11MB3623.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kKFaX+Bnr9IDKT1G+kFtV3gcIDnPkkjI4Tz7t9Fzo/5SM2YtSL0ivD/up0vQ4ZvoV3ynm61QWMtWqP7AFpRYps94bwvT9FNCynovE9AvaEsd+uDo53EJYClJexakbX9gvak7TDH46HrAJvw5yX0zP0t2exDpNjWrvADKv2G2/Qf4P6UiJcjJAZyi6PG0wf3yc7hQVKUjCI5klA5spYEK/oGxdHY+2h0Bzo3t6Ccb0YCN9utJNQpxZ1uo1DujlCo2S7gYtSAijhz44meP4BHLTQz2oPya2wzrROjokpyK4masOUEc9tfEFjoRC1H91BceqkAdRGk8UoSBkrO8rcy/0lB93VepekrPiUp0eoQ0F30wiqr6V5c/ZckInnQLj15WkumyjdalnKXw4MvmovEWMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(376002)(136003)(346002)(366004)(83380400001)(5660300002)(2906002)(53546011)(6666004)(31696002)(31686004)(26005)(6916009)(7416002)(66556008)(6706004)(36756003)(2616005)(956004)(66946007)(6486002)(52116002)(54906003)(16576012)(86362001)(16526019)(66476007)(4326008)(316002)(478600001)(186003)(8936002)(8676002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B5jzpdV7mAtcRABki6Ueuxb1JzxaYOo322TUAJf3YWpBqd9PEqgMlIxLhHc+sN4rRR/9HO2sia0szRSHdXrh4ePY2mproJ7vZHv8DD2RCC2EugE5wovjnpVHioL5wGL3fshHWYXZE8B0L2FhtqGKG3YWa9dh+FmZwI6c2uLyaKCREzo4ZnWqzX8sMS0y+22eF9ye7QP+5hx/v0D0ECNRRIiOjRxq5MBd7VNNyo4B/lazkIuTX4V0T6n5aEuThQMjiC8rJo13M+MYyDUFcZfCP5gUNmNJ40QnjrNRg+OQFYx0t/tjYJiX+hTxNKWfCX25YfCOgq2xWggF0Wf2he0hg7BcrVO4nm7Wc3sOXt8/Z1SVic43RjeI4DWYrubchwWfLSgMzRNbc5jX9Hu9iQNfKz3thp2zJNbI9E2866VGyOVAaf53qQAZMtvmlzFq74tUEdg3K8QF+QcESY52ZfApqnZUT1yZzIzUY7Vc5XYPf5vtQax1fQjog9FVmF3spRhBAUqLelQTJrurlPjH5QJSAd7gEicG2XT7I9tRxixgpQTiALEE29j8B9WVvqcDuYKhZhMeV/1cR+KNAnWi8xXgbSRoKaY5/ICZANZncK9GwCSAGoOoIo7YzpRdPFB02kpFbBwBOBAl57CIKfnkPn7wZg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd793236-aa4f-4494-b3fd-08d8756c5342
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 02:52:18.9361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: omDmcfx397nkC4qZLkKRxoygDrG4HA/fRlCmVm7cVuypQUjUhNJ2gHniBlSgG84RIVfwW/1G0bHZ4P7/sahlTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3623
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/20 9:08 PM, Muchun Song wrote:
> On Tue, Oct 20, 2020 at 7:51 PM Xu, Yanfei <yanfei.xu@windriver.com> wrote:
>>
>>
>>
>> On 10/19/20 10:58 PM, Muchun Song wrote:
>>> On Mon, Oct 19, 2020 at 8:31 PM Michal Hocko <mhocko@suse.com> wrote:
>>>>
>>>> On Mon 19-10-20 18:15:20, Muchun Song wrote:
>>>>> For the exclusive reference page, the non-atomic operations is enough,
>>>>> so replace them to non-atomic operations.
>>>>
>>>> I do expect you do not see any difference in runtime and this is mostly
>>>> driven by the code reading, right? Being explicit about this in the code
>>>> would be preferred.
>>>
>>> Yeah, just code reading.And the set_bit and __set_bit is actually different
>>> on some architectures. Thanks.
>>>
>>>>
>>>> No objection to the change.
>>>>
>>>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>>>
>>>> With an improved changelog
>>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>>>
>>>>> ---
>>>>>    include/linux/page-flags.h | 2 ++
>>>>>    mm/memory.c                | 4 ++--
>>>>>    2 files changed, 4 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
>>>>> index fbbb841a9346..ec039dde5e4b 100644
>>>>> --- a/include/linux/page-flags.h
>>>>> +++ b/include/linux/page-flags.h
>>>>> @@ -401,6 +401,8 @@ static __always_inline int PageSwapCache(struct page *page)
>>>>>    }
>>>>>    SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>>>>>    CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>>>>> +__SETPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>>>>> +__CLEARPAGEFLAG(SwapCache, swapcache, PF_NO_TAIL)
>>>>>    #else
>>>>>    PAGEFLAG_FALSE(SwapCache)
>>>>>    #endif
>>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>>> index 2d267ef6621a..02dd62da26e0 100644
>>>>> --- a/mm/memory.c
>>>>> +++ b/mm/memory.c
>>>>> @@ -3128,10 +3128,10 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>>                                 set_page_private(page, entry.val);
>>>>>
>>>>>                                 /* Tell memcg to use swap ownership records */
>>>>> -                             SetPageSwapCache(page);
>>>>> +                             __SetPageSwapCache(page);
>>
>> Good evening, Muchun. I found there are still some places could be
>> replaced with __SetPageSwapCache（）. Such as shmem_replace_page（）, why
> 
> Yeah, thanks for your suggestion.
> 
>> PG_locked has been set before SetPageSwapCache（） is involved.
> 
> In this case, It doesn't matter whether PG_locked is set before
> SetPageSwapCache.
> 
Sorry for this mistake. PG_locked is used for disk I/O.
>>
>> Would you please to check the rest places? :)
> 
> Ok, I'll take a look. Thanks.
> 
>>
>> Thanks
>>
>> Acked-by: Yanfei Xu <yanfei.xu@windriver.com>
>>
>>>>>                                 err = mem_cgroup_charge(page, vma->vm_mm,
>>>>>                                                         GFP_KERNEL);
>>>>> -                             ClearPageSwapCache(page);
>>>>> +                             __ClearPageSwapCache(page);
>>>>>                                 if (err) {
>>>>>                                         ret = VM_FAULT_OOM;
>>>>>                                         goto out_page;
>>>>> --
>>>>> 2.20.1
>>>>>
>>>>
>>>> --
>>>> Michal Hocko
>>>> SUSE Labs
>>>
>>>
>>>
> 
> 
> 
> --
> Yours,
> Muchun
> 
