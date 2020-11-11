Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDF72AF215
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgKKN0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:26:19 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7172 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgKKN0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:26:18 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CWQV22dcgz15VJj;
        Wed, 11 Nov 2020 21:26:02 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Wed, 11 Nov 2020 21:26:04 +0800
Subject: Re: [PATCH v13 1/8] x86: kdump: replace the hard-coded alignment with
 macro CRASH_ALIGN
To:     Baoquan He <bhe@redhat.com>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201031074437.168008-2-chenzhou10@huawei.com>
 <20201111013815.GC24747@MiWiFi-R3L-srv>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <bhsharma@redhat.com>,
        <prabhakar.pkin@gmail.com>, <wangkefeng.wang@huawei.com>,
        <arnd@arndb.de>, <linux-doc@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <kexec@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <horms@verge.net.au>, <james.morse@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <huawei.libin@huawei.com>,
        <guohanjun@huawei.com>, <nsaenzjulienne@suse.de>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <a72cb0ba-91b9-0bd7-7f61-020ae9269d1a@huawei.com>
Date:   Wed, 11 Nov 2020 21:26:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201111013815.GC24747@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,


On 2020/11/11 9:38, Baoquan He wrote:
> On 10/31/20 at 03:44pm, Chen Zhou wrote:
>> Move CRASH_ALIGN to header asm/kexec.h and replace the hard-coded
>> alignment with macro CRASH_ALIGN in function reserve_crashkernel().
> Seems you tell what you have done in this patch, but don't like adding
> several more words to tell why it's done like that. Please see below
> inline comments.
>
> In other patches, I can also see this similar problem.
Thanks for your review. I will update relevant commit messages.
>
>> Suggested-by: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
>> ---
>>  arch/x86/include/asm/kexec.h | 3 +++
>>  arch/x86/kernel/setup.c      | 5 +----
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index 6802c59e8252..8cf9d3fd31c7 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -18,6 +18,9 @@
>>  
>>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>>  
>> +/* 2M alignment for crash kernel regions */
>> +#define CRASH_ALIGN		SZ_16M
>> +
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <linux/string.h>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 84f581c91db4..bf373422dc8a 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -395,9 +395,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>>  
>>  #ifdef CONFIG_KEXEC_CORE
>>  
>> -/* 16M alignment for crash kernel regions */
>> -#define CRASH_ALIGN		SZ_16M
>> -
>>  /*
>>   * Keep the crash kernel below this limit.
>>   *
>> @@ -515,7 +512,7 @@ static void __init reserve_crashkernel(void)
>>  	} else {
>>  		unsigned long long start;
>>  
>> -		start = memblock_phys_alloc_range(crash_size, SZ_1M, crash_base,
>> +		start = memblock_phys_alloc_range(crash_size, CRASH_ALIGN, crash_base,
>>  						  crash_base + crash_size);
> Here, SZ_1M is replaced with CRASH_ALIGN which is 16M. I remember I ever
> commented that this had better be told in patch log.
got it.

Thanks,
Chen Zhou
>
>>  		if (start != crash_base) {
>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>> -- 
>> 2.20.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> .
>

