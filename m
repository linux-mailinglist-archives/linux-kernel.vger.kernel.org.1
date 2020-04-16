Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5503E1ACF9F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 20:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732460AbgDPS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 14:26:04 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34506 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgDPS0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:26:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07425;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TvjuKXH_1587061557;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TvjuKXH_1587061557)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 17 Apr 2020 02:26:00 +0800
Subject: Re: [PATCHv3, RESEND 8/8] khugepaged: Introduce 'max_ptes_shared'
 tunable
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-9-kirill.shutemov@linux.intel.com>
 <fcbfabac-1837-a4ea-1333-15445587e9fd@linux.alibaba.com>
 <20200416155206.bqpd5p45oud4chg6@box>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <33a19097-5b4f-ea6e-6d6e-3ccda56607f5@linux.alibaba.com>
Date:   Thu, 16 Apr 2020 11:25:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200416155206.bqpd5p45oud4chg6@box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/20 8:52 AM, Kirill A. Shutemov wrote:
> On Wed, Apr 15, 2020 at 02:25:30PM -0700, Yang Shi wrote:
>>> @@ -595,6 +626,12 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>>    		VM_BUG_ON_PAGE(!PageAnon(page), page);
>>> +		if (page_mapcount(page) > 1 &&
>>> +				++shared > khugepaged_max_ptes_shared) {
>>> +			result = SCAN_EXCEED_SHARED_PTE;
>> It may be better to extract the check into a helper? For example, bool
>> exceed_max_ptes_shared(struct page)?
> It might be reasonable as part of wider cleanup: the same has to be done
> to khugepaged_max_ptes_none and khugepaged_max_ptes_swap.
>
> Volunteers? :P

Fine, I will take it. :-)

>

