Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9CC2F75B7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbhAOJo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:44:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11162 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbhAOJoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:44:54 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DHGSV2jP3zl4qj;
        Fri, 15 Jan 2021 17:42:50 +0800 (CST)
Received: from [10.174.176.197] (10.174.176.197) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 17:44:08 +0800
Subject: Re: [PATCH v2] mm/hugetlb: avoid unnecessary hugetlb_acct_memory()
 call
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210115092013.61012-1-linmiaohe@huawei.com>
 <20210115092849.GC4092@linux>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8f7b7e94-f803-11e4-6fc8-f510e01d2305@huawei.com>
Date:   Fri, 15 Jan 2021 17:44:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115092849.GC4092@linux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.197]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

On 2021/1/15 17:28, Oscar Salvador wrote:
> On Fri, Jan 15, 2021 at 04:20:13AM -0500, Miaohe Lin wrote:
>> When gbl_reserve is 0, hugetlb_acct_memory() will do nothing except holding
>> and releasing hugetlb_lock. We should avoid this unnecessary hugetlb_lock
>> lock/unlock cycle which is happening on 'most' hugetlb munmap operations by
>> check delta against 0 at the beginning of hugetlb_acct_memory.
>>
>> Reviewed-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> I would avoid mentioning gbl_reserve as not all callers use it, and focus
> on what delta means:
> 
> "When reservation accounting remains unchanged..", but anyway:

Sounds good. Maybe Andrew could kindly do this if this patch is picked up ?

> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> 
> 

Many thanks for your review.
