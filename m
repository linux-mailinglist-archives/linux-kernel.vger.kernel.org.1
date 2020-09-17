Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785DC26D084
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 03:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIQBU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 21:20:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44052 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726011AbgIQBUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 21:20:54 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C82E18A2BAD876DB442E;
        Thu, 17 Sep 2020 09:05:30 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Sep
 2020 09:05:28 +0800
Subject: Re: [PATCH] erofs: remove unneeded parameter
To:     Gao Xiang <hsiangkao@redhat.com>, Chao Yu <chao@kernel.org>
CC:     <linux-erofs@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20200916140604.3799-1-chao@kernel.org>
 <20200916143304.GA23176@xiangao.remote.csb>
 <20200916143648.GA23921@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <72eab76b-0b05-2e0e-d711-8961a254a49a@huawei.com>
Date:   Thu, 17 Sep 2020 09:05:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200916143648.GA23921@xiangao.remote.csb>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiang,

On 2020/9/16 22:36, Gao Xiang wrote:
> On Wed, Sep 16, 2020 at 10:33:04PM +0800, Gao Xiang wrote:
>> Hi Chao,
>>
>> On Wed, Sep 16, 2020 at 10:06:04PM +0800, Chao Yu wrote:
>>> From: Chao Yu <yuchao0@huawei.com>
>>>
>>> In below call path, no page will be cached into @pagepool list
>>> or grabbed from @pagepool list:
>>> - z_erofs_readpage
>>>   - z_erofs_do_read_page
>>>    - preload_compressed_pages
>>>    - erofs_allocpage
>>>
>>> Let's get rid of this unneeded parameter.
>>
>> That would be unneeded after .readahead() is introduced recently
>> (so add_to_page_cache_lru() is also moved to mm code), so I agree
>> with you on it.
> 
> (cont.)
> 
> ... also it'd be better to add such historical reason to the commit
> message... since it was of some use before...

No problem, let me revise it in v2. :)

Thanks,

> 
> Thanks,
> Gao Xiang
> 
> .
> 
