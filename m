Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD5729212F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 04:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgJSCnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 22:43:17 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728791AbgJSCnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 22:43:17 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0E4BB91A978CEDFB0FE2;
        Mon, 19 Oct 2020 10:43:15 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Mon, 19 Oct 2020 10:43:07 +0800
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64
 kdump
To:     Bhupesh Sharma <bhsharma@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
 <20201005170937.GA14576@gaia>
 <CACi5LpMWUmP1df8fB8psJY_cNGHF9MNn+TNK4B4edaRHvOXxGQ@mail.gmail.com>
 <20201006180012.GB31946@C02TF0J2HF1T.local>
 <CACi5LpMmccLX9p0ZXnEbWHgn2LRrVSDQZF9zBGzfZySe3TvXEQ@mail.gmail.com>
CC:     John Donnelly <john.p.donnelly@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, RuiRui Yang <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, <nsaenzjulienne@suse.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <wangkefeng.wang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <ab142d7d-55a7-eca6-4609-147e1605f02d@huawei.com>
Date:   Mon, 19 Oct 2020 10:43:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CACi5LpMmccLX9p0ZXnEbWHgn2LRrVSDQZF9zBGzfZySe3TvXEQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhupesh,


On 2020/10/7 15:07, Bhupesh Sharma wrote:
> Hi Catalin,
>
> On Tue, Oct 6, 2020 at 11:30 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>> On Mon, Oct 05, 2020 at 11:12:10PM +0530, Bhupesh Sharma wrote:
>>> I think my earlier email with the test results on this series bounced
>>> off the mailing list server (for some weird reason), but I still see
>>> several issues with this patchset. I will add specific issues in the
>>> review comments for each patch again, but overall, with a crashkernel
>>> size of say 786M, I see the following issue:
>>>
>>> # cat /proc/cmdline
>>> BOOT_IMAGE=(hd7,gpt2)/vmlinuz-5.9.0-rc7+ root=<..snip..> rd.lvm.lv=<..snip..> crashkernel=786M
>>>
>>> I see two regions of size 786M and 256M reserved in low and high
>>> regions respectively, So we reserve a total of 1042M of memory, which
>>> is an incorrect behaviour:
>>>
>>> # dmesg | grep -i crash
>>> [    0.000000] Reserving 256MB of low memory at 2816MB for crashkernel (System low RAM: 768MB)
>>> [    0.000000] Reserving 786MB of memory at 654158MB for crashkernel (System RAM: 130816MB)
>>> [    0.000000] Kernel command line: BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.9.0-rc7+ root=/dev/mapper/rhel_ampere--hr330a--03-root ro rd.lvm.lv=rhel_ampere-hr330a-03/root rd.lvm.lv=rhel_ampere-hr330a-03/swap crashkernel=786M cma=1024M
>>>
>>> # cat /proc/iomem | grep -i crash
>>>   b0000000-bfffffff : Crash kernel (low)
>>>   bfcbe00000-bffcffffff : Crash kernel
>> As Chen said, that's the intended behaviour and how x86 works. The
>> requested 768M goes in the high range if there's not enough low memory
>> and an additional buffer for swiotlb is allocated, hence the low 256M.
> I understand, but why 256M (as low) for arm64? x86_64 setups usually
> have more system memory available as compared to several commercially
> available arm64 setups. So is the intent, just to keep the behavior
> similar between arm64 and x86_64?
>
> Should we have a CONFIG option / bootarg to help one select the max
> 'low_size'? Currently the ' low_size' value is calculated as:
>
>     /*
>          * two parts from kernel/dma/swiotlb.c:
>          * -swiotlb size: user-specified with swiotlb= or default.
>          *
>          * -swiotlb overflow buffer: now hardcoded to 32k. We round it
>          * to 8M for other buffers that may need to stay low too. Also
>          * make sure we allocate enough extra low memory so that we
>          * don't run out of DMA buffers for 32-bit devices.
>          */
>         low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
>
> Since many arm64 boards ship with swiotlb=0 (turned off) via kernel
> bootargs, the low_size, still ends up being 256M in such cases,
> whereas this 256M can be used for some other purposes - so should we
> be limiting this to 64M and failing the crash kernel allocation
> request (gracefully) otherwise?
>
>> We could (as an additional patch), subtract the 256M from the high
>> allocation so that you'd get a low 256M and a high 512M, not sure it's
>> worth it. Note that with a "crashkernel=768M,high" option, you still get
>> the additional low 256M, otherwise the crashkernel won't be able to
>> boot as there's no memory in ZONE_DMA. In the explicit ",high" request
>> case, I'm not sure subtracted the 256M is more intuitive.
>> In 5.11, we also hope to fix the ZONE_DMA layout for non-RPi4 platforms
>> to cover the entire 32-bit address space (i.e. identical to the current
>> ZONE_DMA32).
>>
>>> IMO, we should test this feature more before including this in 5.11
>> Definitely. That's one of the reasons we haven't queued it yet. So any
>> help with testing here is appreciated.
> Sure, I am running more checks on this series. I will be soon back
> with more updates.

Sorry to bother you. I am looking forward to your review comments.


Thanks,
Chen Zhou
>
> Regards,
> Bhupesh
>
> .
>

