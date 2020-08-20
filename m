Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1724ACC6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 03:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHTB4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 21:56:35 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37660 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726362AbgHTB4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:56:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 22F38C665B61BDFEEC86;
        Thu, 20 Aug 2020 09:56:31 +0800 (CST)
Received: from [10.174.179.61] (10.174.179.61) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Thu, 20 Aug 2020 09:56:23 +0800
Subject: Re: [PATCH] mm/slub: make add_full() condition more explicit
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <liu.xiang6@zte.com.cn>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hewenliang4@huawei.com>, <hushiyuan@huawei.com>
References: <20200811020240.1231-1-wuyun.wu@huawei.com>
 <20200819123713.38a2509a2b7651f14db33e61@linux-foundation.org>
From:   Abel Wu <wuyun.wu@huawei.com>
Message-ID: <85259217-3805-92d8-3be1-8279d8a6a85b@huawei.com>
Date:   Thu, 20 Aug 2020 09:56:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <20200819123713.38a2509a2b7651f14db33e61@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/20 3:37, Andrew Morton wrote:
> On Tue, 11 Aug 2020 10:02:36 +0800 <wuyun.wu@huawei.com> wrote:
> 
>> From: Abel Wu <wuyun.wu@huawei.com>
>>
>> The commit below is incomplete, as it didn't handle the add_full() part.
>> commit a4d3f8916c65 ("slub: remove useless kmem_cache_debug() before remove_full()")
>>
>> This patch checks for SLAB_STORE_USER instead of kmem_cache_debug(),
>> since that should be the only context in which we need the list_lock for
>> add_full().
>>
> 
> Does this contradict what the comment tells us?
> 
> * This also ensures that the scanning of full
> * slabs from diagnostic functions will not see
> * any frozen slabs.
> 
I don't think so. If the flag SLAB_STORE_USER is not set, the slab won't
be added to the full list no matter this patch is applied or not, since
the check inside add_full() will guard for that. Am I missing something
here?
Regards,
	Abel
