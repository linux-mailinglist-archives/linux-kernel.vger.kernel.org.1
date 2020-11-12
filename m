Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161152B00ED
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgKLIMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:12:21 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7210 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLIMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 03:12:20 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CWvTK3PVczkjYb;
        Thu, 12 Nov 2020 16:12:05 +0800 (CST)
Received: from [10.174.176.61] (10.174.176.61) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 12 Nov 2020 16:12:08 +0800
Subject: Re: [PATCH v13 1/8] x86: kdump: replace the hard-coded alignment with
 macro CRASH_ALIGN
To:     Mike Rapoport <rppt@kernel.org>
References: <20201031074437.168008-1-chenzhou10@huawei.com>
 <20201031074437.168008-2-chenzhou10@huawei.com>
 <20201112075810.GJ4758@kernel.org>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <bhsharma@redhat.com>, <prabhakar.pkin@gmail.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <james.morse@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>, <wangkefeng.wang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <3beb3c41-5b58-e108-55bd-550c852d9eb2@huawei.com>
Date:   Thu, 12 Nov 2020 16:12:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20201112075810.GJ4758@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.61]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/11/12 15:58, Mike Rapoport wrote:
> Hi,
>
> On Sat, Oct 31, 2020 at 03:44:30PM +0800, Chen Zhou wrote:
>> Move CRASH_ALIGN to header asm/kexec.h and replace the hard-coded
>> alignment with macro CRASH_ALIGN in function reserve_crashkernel().
>>
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
> Please update the comment to match the code.
Ok, thanks for pointing this mistake.

Thanks,
Chen Zhou
>
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
>>  		if (start != crash_base) {
>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>> -- 
>> 2.20.1
>>

