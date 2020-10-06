Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA152843F3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 04:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgJFCLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 22:11:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14803 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgJFCLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:11:06 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 879D627ED37AAE9DC2C4;
        Tue,  6 Oct 2020 10:11:04 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Tue, 6 Oct 2020 10:10:55 +0800
Subject: Re: [PATCH v12 9/9] kdump: update Documentation about crashkernel
To:     Catalin Marinas <catalin.marinas@arm.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-10-chenzhou10@huawei.com> <20201005171936.GD14576@gaia>
CC:     <will@kernel.org>, <james.morse@arm.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <dyoung@redhat.com>, <bhe@redhat.com>,
        <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <prabhakar.pkin@gmail.com>, <bhsharma@redhat.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <8644712d-1331-1efc-1cd2-6da8640145b7@huawei.com>
Date:   Tue, 6 Oct 2020 10:10:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201005171936.GD14576@gaia>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,


On 2020/10/6 1:19, Catalin Marinas wrote:
> On Mon, Sep 07, 2020 at 09:47:45PM +0800, Chen Zhou wrote:
>> diff --git a/Documentation/admin-guide/kdump/kdump.rst b/Documentation/admin-guide/kdump/kdump.rst
>> index 2da65fef2a1c..549611abc581 100644
>> --- a/Documentation/admin-guide/kdump/kdump.rst
>> +++ b/Documentation/admin-guide/kdump/kdump.rst
> [...]
>> @@ -316,8 +325,18 @@ Boot into System Kernel
>>     kernel will automatically locate the crash kernel image within the
>>     first 512MB of RAM if X is not given.
>>  
>> -   On arm64, use "crashkernel=Y[@X]".  Note that the start address of
>> -   the kernel, X if explicitly specified, must be aligned to 2MiB (0x200000).
>> +   On arm64, use "crashkernel=X" to try low allocation in DMA zone, and
>> +   fall back to high allocation if it fails. And go for high allocation
>> +   directly if the required size is too large.
>> +   We can also use "crashkernel=X,high" to select a high region above
>> +   DMA zone, which also tries to allocate at least 256M low memory in
>> +   DMA zone automatically.
>> +   "crashkernel=Y,low" can be used to allocate specified size low memory
>> +   in DMA zone.
>> +   For non-RPi4 platforms, change DMA zone memtioned above to DMA32 zone.
> I don't think we should mention non-RPi4 explicitly here. I don't even
> understand what the suggestion is since the only way is to disable
> ZONE_DMA in the kernel config. I'd just stick to ZONE_DMA description
> here.
How about like this:
If the kernel config ZONE_DMA is disabled, just try low allocation in DMA32 zone
and high allocation above DMA32 zone.

Thanks,
Chen Zhou
>
>> +   Use "crashkernel=Y@X" if you really have to reserve memory from
>> +   specified start address X. Note that the start address of the kernel,
>> +   X if explicitly specified, must be aligned to 2MiB (0x200000).
>>  
>>  Load the Dump-capture Kernel
>>  ============================
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index a1068742a6df..f7df572d8f64 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -727,6 +727,10 @@
>>  			[KNL, X86-64] Select a region under 4G first, and
>>  			fall back to reserve region above 4G when '@offset'
>>  			hasn't been specified.
>> +			[KNL, arm64] Try low allocation in DMA zone, fall back
>> +			to high allocation if it fails when '@offset' hasn't been
>> +			specified. For non-RPi4 platforms, change DMA zone to
>> +			DMA32 zone.
> Same here, unclear what "change DMA zone to DMA32 zone" means.
>
>>  			See Documentation/admin-guide/kdump/kdump.rst for further details.
>>  
>>  	crashkernel=range1:size1[,range2:size2,...][@offset]
>> @@ -743,6 +747,8 @@
>>  			Otherwise memory region will be allocated below 4G, if
>>  			available.
>>  			It will be ignored if crashkernel=X is specified.
>> +			[KNL, arm64] range in high memory.
>> +			Allow kernel to allocate physical memory region from top.
>>  	crashkernel=size[KMG],low
>>  			[KNL, X86-64] range under 4G. When crashkernel=X,high
>>  			is passed, kernel could allocate physical memory region
>> @@ -751,13 +757,16 @@
>>  			requires at least 64M+32K low memory, also enough extra
>>  			low memory is needed to make sure DMA buffers for 32-bit
>>  			devices won't run out. Kernel would try to allocate at
>> -			at least 256M below 4G automatically.
>> +			least 256M below 4G automatically.
>>  			This one let user to specify own low range under 4G
>>  			for second kernel instead.
>>  			0: to disable low allocation.
>>  			It will be ignored when crashkernel=X,high is not used
>>  			or memory reserved is below 4G.
>> -
>> +			[KNL, arm64] range in low memory.
>> +			This one let user to specify a low range in DMA zone for
>> +			crash dump kernel. For non-RPi4 platforms, change DMA zone
>> +			to DMA32 zone.
> And again here.
>

