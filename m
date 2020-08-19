Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4647324985D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 10:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHSIlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 04:41:39 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725903AbgHSIlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:41:39 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A55D9D5636408194B6C0;
        Wed, 19 Aug 2020 16:41:36 +0800 (CST)
Received: from [10.174.179.61] (10.174.179.61) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 16:41:26 +0800
Subject: Re: [PATCH] mm/slub: sysfs cleanup on cpu partial when
 !SLUB_CPU_PARTIAL
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <hewenliang4@huawei.com>,
        <hushiyuan@huawei.com>,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200813084858.1494-1-wuyun.wu@huawei.com>
 <20200818202619.6f04826a98d845e489890bba@linux-foundation.org>
From:   Abel Wu <wuyun.wu@huawei.com>
Message-ID: <1b6dd6d9-f613-846f-b102-b19df1b2eee8@huawei.com>
Date:   Wed, 19 Aug 2020 16:41:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.0
MIME-Version: 1.0
In-Reply-To: <20200818202619.6f04826a98d845e489890bba@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.61]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/19 11:26, Andrew Morton wrote:
> On Thu, 13 Aug 2020 16:48:54 +0800 <wuyun.wu@huawei.com> wrote:
> 
>> Hide cpu partial related sysfs entries when !CONFIG_SLUB_CPU_PARTIAL to
>> avoid confusion.
>>
> 
> But it changes the userspace interface in ways which might cause
> existing code to misbehave?
Yes, indeed.
> 
> We just had to revert a different commit for this reason :(
> 
> http://lkml.kernel.org/r/20200811075412.12872-1-bhe@redhat.com
> .
> 
OK, just ignore this patch and leave it as is!

Thanks,
	Abel
