Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C591F19C3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgFHNRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 09:17:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5869 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728938AbgFHNRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 09:17:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48AF61A9D3AE874509E3;
        Mon,  8 Jun 2020 21:17:02 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.10) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 21:16:55 +0800
Subject: Re: [RESEND PATCH] sys_personality: Add optional arch hook
 arch_check_personality
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>,
        <xiexiuqi@huawei.com>, <mark.rutland@arm.com>, <hch@infradead.org>,
        <wcohen@redhat.com>, <linux-kernel@vger.kernel.org>,
        <mtk.manpages@gmail.com>, <wezhang@redhat.com>,
        <gregkh@linuxfoundation.org>, Will Deacon <will@kernel.org>
References: <20200608024925.42510-1-bobo.shaobowang@huawei.com>
 <20200608094640.GA13596@gaia>
From:   "Wangshaobo (bobo)" <bobo.shaobowang@huawei.com>
Message-ID: <bc50de19-86db-5eed-2112-6772850a5cd5@huawei.com>
Date:   Mon, 8 Jun 2020 21:16:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200608094640.GA13596@gaia>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.10]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


�� 2020/6/8 17:46, Catalin Marinas д��:
> On Mon, Jun 08, 2020 at 10:49:25AM +0800, Wang ShaoBo wrote:
>> Currently arm64 personality syscall uses wrapper __arm64_sys_personality
>> to redirect to __arm64_sys_arm64_personality, it's easily confused,
>> Whereas using an normal hook arch_check_personality() can reject
>> additional settings like this for special case of different architectures.
>>
>> This makes code clean and easier for subsequent modification.
> Do you plan to add more stuff here? Curious what triggered this patch.
>
>> diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
>> index d5ffaaab31a7..5c01816d7a77 100644
>> --- a/arch/arm64/kernel/sys.c
>> +++ b/arch/arm64/kernel/sys.c
>> @@ -28,12 +28,13 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>>   	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
>>   }
>>   
>> -SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
>> +int arch_check_personality(unsigned int personality)
>>   {
>>   	if (personality(personality) == PER_LINUX32 &&
>>   		!system_supports_32bit_el0())
>>   		return -EINVAL;
>> -	return ksys_personality(personality);
>> +
>> +	return 0;
>>   }
> We use the ksys_* pattern in other places as well, so this wouldn't be
> something new.
>
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index 1815065d52f3..3dbbad498027 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -1393,16 +1393,6 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
>>   	return do_sys_truncate(pathname, length);
>>   }
>>   
>> -static inline unsigned int ksys_personality(unsigned int personality)
>> -{
>> -	unsigned int old = current->personality;
>> -
>> -	if (personality != 0xffffffff)
>> -		set_personality(personality);
>> -
>> -	return old;
>> -}
>> -
>>   /* for __ARCH_WANT_SYS_IPC */
>>   long ksys_semtimedop(int semid, struct sembuf __user *tsops,
>>   		     unsigned int nsops,
>> diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
>> index 33f07c5f2515..f3682f4bf205 100644
>> --- a/kernel/exec_domain.c
>> +++ b/kernel/exec_domain.c
>> @@ -35,9 +35,21 @@ static int __init proc_execdomains_init(void)
>>   module_init(proc_execdomains_init);
>>   #endif
>>   
>> +int __weak arch_check_personality(unsigned int personality)
>> +{
>> +	return 0;
>> +}
>> +
>>   SYSCALL_DEFINE1(personality, unsigned int, personality)
>>   {
>> -	unsigned int old = current->personality;
>> +	int err;
>> +	unsigned int old;
>> +
>> +	err = arch_check_personality(personality);
>> +	if (err)
>> +		return err;
>> +
>> +	old = current->personality;
> I'm surprised that the generic sys_personality() doesn't call
> ksys_personality() directly but rather duplicates the code.
>
> Anyway, without knowing what else you plan to do with
> arch_check_personality(), I don't think it's worth changing. Calling
> ksys_personality() directly from sys_personality() would be a good
> clean-up though.

Hi catalin,

I have sent a version just calling ksys_personality() directly from 
sys_personality() before:

https://lore.kernel.org/patchwork/patch/1158872/

thanks,

Wang ShaoBo

>

