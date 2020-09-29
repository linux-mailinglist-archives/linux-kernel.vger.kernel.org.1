Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 905B827BB30
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 04:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbgI2CyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 22:54:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbgI2CyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 22:54:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 064EE769C7531CDE4280;
        Tue, 29 Sep 2020 10:54:03 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.253) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 10:53:54 +0800
Subject: Re: [PATCH 2/2] ARM: decompressor: relax the loading restriction of
 the decompressed kernel
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
References: <20200928092641.2070-1-thunder.leizhen@huawei.com>
 <20200928092641.2070-3-thunder.leizhen@huawei.com>
 <CAMj1kXGK8x4eBL55mLMWVQWpFZKa+FSCaQj9_gieWCQSgG=xAQ@mail.gmail.com>
 <e2d45592-ffc3-395e-0657-dcff0e094c1f@huawei.com>
 <CAMj1kXEXziNDWxKNmD9nPWCmhpAPO--vWvJvr2nioQL+QJBfBQ@mail.gmail.com>
 <CAMuHMdWHa-o=-a8VM+NCpxGoTEeTcm4v1FSrA17xVKzyuZDj9g@mail.gmail.com>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2038e40f-cc08-83ac-2660-b5459f580488@huawei.com>
Date:   Tue, 29 Sep 2020 10:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdWHa-o=-a8VM+NCpxGoTEeTcm4v1FSrA17xVKzyuZDj9g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/28 20:57, Geert Uytterhoeven wrote:
> Hi Zhen,
> 
> On Mon, Sep 28, 2020 at 2:15 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> On Mon, 28 Sep 2020 at 13:57, Leizhen (ThunderTown)
>> <thunder.leizhen@huawei.com> wrote:
>>> On 2020/9/28 18:14, Ard Biesheuvel wrote:
>>>> On Mon, 28 Sep 2020 at 11:27, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>>>>>
>>>>> mov     r4, pc
>>>>> and     r4, r4, #0xf8000000     //truncated to 128MiB boundary
>>>>> add     r4, r4, #TEXT_OFFSET    //PA(_start)
>>>>>
>>>>> Currently, the decompressed kernel must be placed at the position: 128MiB
>>>>> boundary + TEXT_OFFSET. This limitation is just because we masked PC with
>>>>> 0xf80000000. Actually, we can directly obtain PA(_start) by using formula
>>>>> : VA(_start) + (PHYS_OFFSET - PAGE_OFFSET).
>>>>>
>>>>> So the "PA(_start) - TEXT_OFFSET" can be 2MiB boundary, 1MiB boundary,
>>>>> and so on.
>>>>>
>>>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>>>
>>>> No, this won't work.
>>>
>>> But it works well on my board.
>>>
>>
>> That is because you load zImage at the base of DRAM.
>>
>>>>
>>>> The whole reason for rounding to a multiple of 128 MB is that we
>>>> cannot infer the start of DRAM from the placement of the zImage (which
>>>> provides _start).
>>>
>>> Maybe this is further guaranteed by the following code:
>>>         /*
>>>          * Set up a page table only if it won't overwrite ourself.
>>>          * That means r4 < pc || r4 - 16k page directory > &_end.
>>>          * Given that r4 > &_end is most unfrequent, we add a rough
>>>          * additional 1MB of room for a possible appended DTB.
>>>          */
>>>
>>> In addition, the Image has already been loaded when this position is reached.
>>>
>>> ----------- <--128MiB boundary
>>> |          |
>>> ----------- <--TEXT_OFFSET <--
>>> | (1)Image |                 |
>>> ------------                 |
>>> |          |                 |
>>> -----------  (2)--copyto-----
>>> | (2)Image |
>>> -----------
>>>
>>> I don't think it's the case of (2), but (1). Because no code modification is
>>> required for the case (2).
>>>
>>> By the way, I'm not familiar with the arm32 code, so I'm just speculating.
>>>
>>
>> The zImage code that runs has not received *any* information from the
>> platform on where DRAM starts, so the only info it has is the current
>> placement of zImage.
>>
>> So when zImage is loaded at the intended base of DRAM, things work fine.
>>
>> If the zImage is loaded close to the end of a 128 MB region, the
>> rounding would pick the start of that 128 MB region. However, the
>> _start symbol you are using will point to an address that is close to
>> the end of the 128 MB [given that it is inside zImage] so your logic
>> will pick an address that is much higher in memory.
> 
> https://people.kernel.org/linusw/how-the-arm32-linux-kernel-decompresses
> https://people.kernel.org/linusw/how-the-arm32-kernel-starts
> are good reads.

Thanks for your information.

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
> .
> 

