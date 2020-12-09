Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 788F12D3910
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgLIC5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:57:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:9399 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLIC5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:57:05 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CrM9z2SZLz7BgZ;
        Wed,  9 Dec 2020 10:55:51 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Dec 2020
 10:56:20 +0800
Subject: Re: [PATCH v3] erofs: avoiding using generic_block_bmap
To:     Gao Xiang <hsiangkao@redhat.com>,
        Huang Jianan <huangjianan@oppo.com>
CC:     <linux-erofs@lists.ozlabs.org>, <guoweichao@oppo.com>,
        <zhangshiming@oppo.com>, <linux-kernel@vger.kernel.org>
References: <20201208131108.7607-1-huangjianan@oppo.com>
 <c71fe6a9-06ba-3871-6e0b-104f58df1df7@oppo.com>
 <20201209024415.GA33948@xiangao.remote.csb>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <fd9d991d-c048-500f-ca52-f186c42974b1@huawei.com>
Date:   Wed, 9 Dec 2020 10:56:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20201209024415.GA33948@xiangao.remote.csb>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/12/9 10:44, Gao Xiang wrote:
> Hi Jianan and Chao,
> 
> On Wed, Dec 09, 2020 at 10:34:54AM +0800, Huang Jianan wrote:
>>
>> 在 2020/12/8 21:11, Huang Jianan 写道:
> 
> ...
> 
>>> -
>>>    static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
>>>    {
>>>    	struct inode *inode = mapping->host;
>>> +	struct erofs_map_blocks map = {
>>> +		.m_la = blknr_to_addr(iblock),
>>
>> Sorry for my mistake, it should be:
>>
>> .m_la = blknr_to_addr(block),
>>
> 
> Sigh, since my ro_fsstress doesn't cover bmap interface... I mean do we need
> to add some testcase for this? (But it needs to be fixed anyway, plus this patch
> looks good to me....)
> 
> Hi Chao,
> could you kindly leave some free slot for this patch and
> 
> erofs: force inplace I/O under low memory scenario
> https://lore.kernel.org/r/20201208054600.16302-1-hsiangkao@aol.com

Will review soon. :)

Thanks,

> 
> Since I'd like to merge these all for 5.11-rc1 (so we could have more time to
> test until the next LTS version), since 5.10 is a LTS version, I tend to not
> introduce any big modification (so in the past months, "erofs: force inplace
> I/O under low memory scenario" never upstreamed at all.)
> 
> Thanks,
> Gao Xiang
> 
> 
> .
> 
