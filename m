Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7181D264639
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgIJMmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 08:42:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35772 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730770AbgIJMfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:35:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 135462F4C83CA4C34600;
        Thu, 10 Sep 2020 20:35:18 +0800 (CST)
Received: from [10.174.178.248] (10.174.178.248) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 10 Sep
 2020 20:35:13 +0800
Subject: Re: [PATCH] drm/mm: prevent a potential null-pointer dereference
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <nirmoy.das@amd.com>
References: <20200910023858.43759-1-jingxiangfeng@huawei.com>
 <f6c93d83-b47d-a004-8da9-92305024c4b7@amd.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F5A1D80.2060902@huawei.com>
Date:   Thu, 10 Sep 2020 20:35:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <f6c93d83-b47d-a004-8da9-92305024c4b7@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.248]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/10 16:58, Christian König wrote:
> Am 10.09.20 um 04:38 schrieb Jing Xiangfeng:
>> The macro 'DECLARE_NEXT_HOLE_ADDR' may hit a potential null-pointer
>> dereference. So use 'entry' after checking it.
>
> I don't see a potential null-pointer dereference here.
>
> Where should that be?

In current code，the "entry" pointer is checked after entry->rb_hole_addr.
	Thanks
>
> Christian.
>
>>
>> Fixes: 5fad79fd66ff ("drm/mm: cleanup and improve next_hole_*_addr()")
>> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
>> ---
>>   drivers/gpu/drm/drm_mm.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_mm.c b/drivers/gpu/drm/drm_mm.c
>> index a4a04d246135..6fcf70f71962 100644
>> --- a/drivers/gpu/drm/drm_mm.c
>> +++ b/drivers/gpu/drm/drm_mm.c
>> @@ -392,11 +392,14 @@ first_hole(struct drm_mm *mm,
>>   #define DECLARE_NEXT_HOLE_ADDR(name, first, last)            \
>>   static struct drm_mm_node *name(struct drm_mm_node *entry, u64
>> size)    \
>>   {                                    \
>> -    struct rb_node *parent, *node = &entry->rb_hole_addr;        \
>> +    struct rb_node *parent, *node;                    \
>>                                       \
>> -    if (!entry || RB_EMPTY_NODE(node))                \
>> +    if (!entry)                            \
>>           return NULL;                        \
>>                                       \
>> +    node = &entry->rb_hole_addr;                    \
>> +    if (RB_EMPTY_NODE(node))                    \
>> +        return NULL;                        \
>>       if (usable_hole_addr(node->first, size)) {            \
>>           node = node->first;                    \
>>           while (usable_hole_addr(node->last, size))        \
>
> .
>
