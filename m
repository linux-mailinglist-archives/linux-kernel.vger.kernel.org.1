Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A802E76EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 09:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgL3IJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 03:09:00 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10008 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL3IJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 03:09:00 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D5P5r4C6gzhsnw;
        Wed, 30 Dec 2020 16:07:28 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.9) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Wed, 30 Dec 2020
 16:08:17 +0800
Subject: Re: [PATCH 1/1] ARM: LPAE: use phys_addr_t instead of unsigned long
 in outercache hooks
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20201225114458.1334-1-thunder.leizhen@huawei.com>
 <20201226121346.GB1551@shell.armlinux.org.uk>
 <3a597586-2bce-66cf-b9f8-4bb667a600d0@huawei.com>
 <20201229105143.GL1551@shell.armlinux.org.uk>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <ca8ad98c-0269-9c44-7704-42ecc700e07e@huawei.com>
Date:   Wed, 30 Dec 2020 16:08:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20201229105143.GL1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.9]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/12/29 18:51, Russell King - ARM Linux admin wrote:
> On Tue, Dec 29, 2020 at 02:30:56PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2020/12/26 20:13, Russell King - ARM Linux admin wrote:
>>> On Fri, Dec 25, 2020 at 07:44:58PM +0800, Zhen Lei wrote:
>>>> The outercache of some Hisilicon SOCs support physical addresses wider
>>>> than 32-bits. The unsigned long datatype is not sufficient for mapping
>>>> physical addresses >= 4GB. The commit ad6b9c9d78b9 ("ARM: 6671/1: LPAE:
>>>> use phys_addr_t instead of unsigned long in outercache functions") has
>>>> already modified the outercache functions. But the parameters of the
>>>> outercache hooks are not changed. This patch use phys_addr_t instead of
>>>> unsigned long in outercache hooks: inv_range, clean_range, flush_range.
>>>>
>>>> To ensure the outercache that does not support LPAE works properly, do
>>>> cast phys_addr_t to unsigned long by adding a middle-tier function.
>>>
>>> Please don't do that. The cast can be done inside the L2 functions
>>> themselves without needing all these additional functions.
>>
>> OK. At first, I wanted to fit in like this:
>>
>> -static void l2c220_inv_range(unsigned long start, unsigned long end)
>> +static void l2c220_inv_range(phys_addr_t lpae_start, phys_addr_t lpae_end)
>>  {
>> +  unsigned long start = lpae_start;
>> +  unsigned long end = lpae_end;
> 
> It sounds like there should be a "but..." clause here. This is exactly
> what I'm suggesting you should be doing. Currently, there's a silent
> narrowing cast in every single caller of the outer_.*_range() functions
> and you're only moving it from the callsites to inside the called
> functions.

Okay, I will send v2 based on this idea.

> 
>>> We probably ought to also add some protection against addresses > 4GB,
>>> although these are hot paths, so we don't want to add tests in these
>>> functions. Maybe instead checking whether the system has memory above
>>> 4GB while the L2 cache is being initialised would be a good idea?
>>
>> I'm sorry, I didn't quite understand what you meant. Currently, the
>> biggest problem is the compilation problem. The sizeof(long) may be
>> 32, and the 64-bit physical address cannot be transferred from outcache
>> functions to outcache hooks.
> 
> What I mean is that we really ought to warn if the L2C310 code tries to
> initialise on a system where memory is above 4GB. However, it's very
> unlikely that such a system exists, so it's probably fine not implement
> a check, but it just feels fragile to be truncating the 64-bit address
> to 32-bit on a kernel that _could_ support higher addresses, even though
> that's exactly what is happening today (kind of by accident - I don't
> think anyone realised.)
> 

