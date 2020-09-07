Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9C625F18E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 03:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgIGBvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 21:51:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48264 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726220AbgIGBvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 21:51:31 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D9344EEC0A19FB7B6FD2;
        Mon,  7 Sep 2020 09:51:29 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.211) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Sep 2020
 09:51:29 +0800
Subject: Re: [PATCH -next] powerpc/book3s64: fix link error with
 CONFIG_PPC_RADIX_MMU=n
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20200905112548.3265530-1-yangyingliang@huawei.com>
 <39a976b8-896c-e878-bac7-50bbf3ccbc4f@csgroup.eu>
From:   Yang Yingliang <yangyingliang@huawei.com>
Message-ID: <af37c513-6232-c35c-33e3-f6d8d82c8175@huawei.com>
Date:   Mon, 7 Sep 2020 09:51:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <39a976b8-896c-e878-bac7-50bbf3ccbc4f@csgroup.eu>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.211]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/9/6 14:50, Christophe Leroy wrote:
>
>
> Le 05/09/2020 à 13:25, Yang Yingliang a écrit :
>> Fix link error when CONFIG_PPC_RADIX_MMU is disabled:
>> powerpc64-linux-gnu-ld: 
>> arch/powerpc/platforms/pseries/lpar.o:(.toc+0x0): undefined reference 
>> to `mmu_pid_bits'
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>> ---
>>   arch/powerpc/mm/book3s64/mmu_context.c | 4 ++++
>
> In your commit log, you are just mentionning 
> arch/powerpc/platforms/pseries/lpar.o, which is right.
>
> You shouldn't need to modify arch/powerpc/mm/book3s64/mmu_context.c at 
> all, see below.
>
>>   arch/powerpc/platforms/pseries/lpar.c  | 2 ++
>>   2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/book3s64/mmu_context.c 
>> b/arch/powerpc/mm/book3s64/mmu_context.c
>> index 0ba30b8b935b..a8e292cd88f0 100644
>> --- a/arch/powerpc/mm/book3s64/mmu_context.c
>> +++ b/arch/powerpc/mm/book3s64/mmu_context.c
>> @@ -152,6 +152,7 @@ void hash__setup_new_exec(void)
>>     static int radix__init_new_context(struct mm_struct *mm)
>>   {
>> +#ifdef CONFIG_PPC_RADIX_MMU
>
> This shouldn't be required. radix__init_new_context() is only called 
> when radix_enabled() returns true.
> As it is a static function, when it is not called it gets optimised 
> away, so you will never get an undefined reference to `mmu_pid_bits` 
> there.
powerpc64-linux-gnu-ld: 
arch/powerpc/mm/book3s64/mmu_context.o:(.toc+0x0): undefined reference 
to `mmu_pid_bits'
powerpc64-linux-gnu-ld: 
arch/powerpc/mm/book3s64/mmu_context.o:(.toc+0x8): undefined reference 
to `mmu_base_pid'


mmu_context.c is always compiled, it uses mmu_pid_bits and mmu_base_pid.

>
>>       unsigned long rts_field;
>>       int index, max_id;
>>   @@ -177,6 +178,9 @@ static int radix__init_new_context(struct 
>> mm_struct *mm)
>>       mm->context.hash_context = NULL;
>>         return index;
>> +#else
>> +    return -ENOTSUPP;
>> +#endif
>>   }
>>     int init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>> diff --git a/arch/powerpc/platforms/pseries/lpar.c 
>> b/arch/powerpc/platforms/pseries/lpar.c
>> index baf24eacd268..e454e218dbba 100644
>> --- a/arch/powerpc/platforms/pseries/lpar.c
>> +++ b/arch/powerpc/platforms/pseries/lpar.c
>> @@ -1726,10 +1726,12 @@ void __init hpte_init_pseries(void)
>>     void radix_init_pseries(void)
>>   {
>> +#ifdef CONFIG_PPC_RADIX_MMU
>
> This function is only called from 
> /arch/powerpc/mm/book3s64/radix_pgtable.c which is only built when 
> CONFIG_PPC_RADIX_MMU is selected.
>
> So the entire function should be encloded in the #ifdef.
OK, I will send a v2 later.
>
>>       pr_info("Using radix MMU under hypervisor\n");
>>         pseries_lpar_register_process_table(__pa(process_tb),
>>                           0, PRTB_SIZE_SHIFT - 12);
>> +#endif
>>   }
>>     #ifdef CONFIG_PPC_SMLPAR
>>
>
> Christophe
> .

