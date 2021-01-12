Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08A82F2D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbhALLLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:11:17 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39110 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbhALLLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:11:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id E9E9A1F45284
Subject: Re: kernelci/staging-next bisection: sleep.login on
 rk3288-rock2-square #2286-staging
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        kernelci-results-staging@groups.io,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>, Baoquan He <bhe@redhat.com>
References: <5fd3e5d9.1c69fb81.f9e69.5028@mx.google.com>
 <127999c4-7d56-0c36-7f88-8e1a5c934cae@collabora.com>
 <20201213082314.GA198221@linux.ibm.com>
 <0633d44a-3796-8a1b-e5dc-99fc62aa4dc7@collabora.com>
 <20210103134753.GC832698@linux.ibm.com> <X/Ikalm2CLln2alz@redhat.com>
 <20210105091330.GD832698@linux.ibm.com>
 <28e59120-f8b9-7256-325a-1e4ca90887b5@collabora.com>
Message-ID: <b5b8d24d-0386-9fd5-775e-f73db03fbb40@collabora.com>
Date:   Tue, 12 Jan 2021 11:10:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <28e59120-f8b9-7256-325a-1e4ca90887b5@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2021 10:53, Guillaume Tucker wrote:
> On 05/01/2021 09:13, Mike Rapoport wrote:
>> On Sun, Jan 03, 2021 at 03:09:14PM -0500, Andrea Arcangeli wrote:
>>> Hello Mike,
>>>
>>> On Sun, Jan 03, 2021 at 03:47:53PM +0200, Mike Rapoport wrote:
>>>> Thanks for the logs, it seems that implicitly adding reserved regions to
>>>> memblock.memory wasn't that bright idea :)
>>>
>>> Would it be possible to somehow clean up the hack then?
>>>
>>> The only difference between the clean solution and the hack is that
>>> the hack intended to achieved the exact same, but without adding the
>>> reserved regions to memblock.memory.
>>
>> I didn't consider adding reserved regions to memblock.memory as a clean
>> solution, this was still a hack, but I didn't think that things are that
>> fragile.
>>
>> I still think we cannot rely on memblock.reserved to detect
>> memory/zone/node sizes and the boot failure reported here confirms this.
>>  
>>> The comment on that problematic area says the reserved area cannot be
>>> used for DMA because of some unexplained hw issue, and that doing so
>>> prevents booting, but since the area got reserved, even with the clean
>>> solution, it shouldn't have never been used for DMA?
>>>
>>> So I can only imagine that the physical memory region is way more
>>> problematic than just for DMA. It sounds like that anything that
>>> touches it, including the CPU, will hang the system, not just DMA. It
>>> sounds somewhat similar to the other e820 direct mapping issue on x86?
>>
>> My understanding is that the boot failed because when I implicitly added
>> the reserved region to memblock.memory the memory size seen by
>> free_area_init() jumped from 2G to 4G because the reserved area was close
>> to 4G. The very first allocation would get a chunk from slightly below of
>> 4G and as there is no real memory there, the kernel would crash.
>>  
>>> If you want to test the hack on the arm board to check if it boots you
>>> can use the below commit:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/andrea/aa.git/commit/?id=c3ea2633015104ce0df33dcddbc36f57de1392bc
>>
>> My take is your solution would boot with this memory configuration, but I
>> still don't think that using memblock.reserved for zone/node sizing is
>> correct.
> 
> The rk3288 platform has now been failing to boot for nearly a
> month on linux-next:
> 
>   https://kernelci.org/test/case/id/5ffbed0a31ad81239bc94cdb/
> 
> Until a fix or a new version of this patch is made, would it be
> possible to drop it or revert it so the platform become usable
> again?
> 
> Or if you want, I can make a cleaned-up version of my hack to
> ignore the problematic region if you still need your patch to be
> on linux-next, but that would probably be less than ideal.

By the way, another bisection found that this commit is also
breaking tegra124-nyan-big but only with both CONFIG_EFI=y
CONFIG_ARM_LPAE=y enabled:

  https://kernelci.org/test/case/id/5ff6b1e26cf19f3b10c94cc5/

The plain multi_v7_defconfig is booting fine:

  https://kernelci.org/test/plan/id/5ff6b0a1db91b8a2b9c94cba/

I haven't looked into this one or tried to make it boot like
rk3288, but please let me know if there's anything there that can
be done to help.

Thanks,
Guillaume
