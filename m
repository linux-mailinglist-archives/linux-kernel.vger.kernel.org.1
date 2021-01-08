Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F452EEAFF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbhAHBlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:41:46 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9725 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbhAHBlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:41:46 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DBm4S6m0Lzl11j;
        Fri,  8 Jan 2021 09:39:52 +0800 (CST)
Received: from [10.174.179.174] (10.174.179.174) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Fri, 8 Jan 2021 09:41:01 +0800
Subject: Re: [PATCH] mm/hugetlb: Fix potential double free in
 hugetlb_register_node() error path
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20210107123249.36964-1-linmiaohe@huawei.com>
 <a8753475-e9a8-a730-c095-086530ecdd17@oracle.com>
 <20210107151502.7c581d98078ba90e63553dd4@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <0c53d7a7-df61-9187-676b-6ba5d0829394@huawei.com>
Date:   Fri, 8 Jan 2021 09:41:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210107151502.7c581d98078ba90e63553dd4@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/8 7:15, Andrew Morton wrote:
> On Thu, 7 Jan 2021 11:59:38 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:
> 
>> On 1/7/21 4:32 AM, Miaohe Lin wrote:
>>> In hugetlb_sysfs_add_hstate(), we would do kobject_put() on hstate_kobjs
>>> when failed to create sysfs group but forget to set hstate_kobjs to NULL.
>>> Then in hugetlb_register_node() error path, we may free it again via
>>> hugetlb_unregister_node().
>>>
>>> Fixes: a3437870160c ("hugetlb: new sysfs interface")
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>>  mm/hugetlb.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> Thanks, this is a potential issue that should be fixed.
>>
>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>
>> This has been around for a long time (more than 12 years).  I suspect
>> nobody actually experienced this issue.  You just discovered via code
>> inspection.  Correct?

Yes, I found this by code inspection.

>> At one time cc stable would not be accepted for this type of issue,
>> not sure about today.
> 
> sysfs_create_group() will only fail if something is terribly messed up
> - probably it has never happened to anyone.  I don't think the
> cc:stable is justified here.
> 
> .
> 

I would take care of more when cc stable. Many thanks for both of you!
