Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4A27B006
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgI1OgJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Sep 2020 10:36:09 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:57624 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726461AbgI1OgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 10:36:09 -0400
X-Greylist: delayed 1649 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Sep 2020 10:36:08 EDT
Received: from DGGEML403-HUB.china.huawei.com (unknown [172.30.72.54])
        by Forcepoint Email with ESMTP id DE89442FCA1814698BE7;
        Mon, 28 Sep 2020 22:08:36 +0800 (CST)
Received: from DGGEML529-MBS.china.huawei.com ([169.254.5.156]) by
 DGGEML403-HUB.china.huawei.com ([fe80::74d9:c659:fbec:21fa%31]) with mapi id
 14.03.0487.000; Mon, 28 Sep 2020 22:08:29 +0800
From:   "chenjun (AM)" <chenjun102@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Xiangrui (Euler)" <rui.xiang@huawei.com>,
        "weiyongjun (A)" <weiyongjun1@huawei.com>
Subject: Re: [PATCH -next 3/5] mm/kmemleak: Add support for percpu memory
 leak detect
Thread-Topic: [PATCH -next 3/5] mm/kmemleak: Add support for percpu memory
 leak detect
Thread-Index: AQHWkMbbj+H4aShTD0uutUryxnjBNQ==
Date:   Mon, 28 Sep 2020 14:08:29 +0000
Message-ID: <CE1E7D7EFA066443B6454A6A5063B502209EB04F@DGGEML529-MBS.china.huawei.com>
References: <20200921020007.35803-1-chenjun102@huawei.com>
 <20200921020007.35803-4-chenjun102@huawei.com> <20200922095736.GB15643@gaia>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.179.194]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin

Thanks for your opinions.

在 2020/9/22 17:58, Catalin Marinas 写道:
> On Mon, Sep 21, 2020 at 02:00:05AM +0000, Chen Jun wrote:
>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>
>> Currently the reporting of the percpu chunks leaking problem
>> are not supported. This patch introduces this function.
>>
>> Since __percpu pointer is not pointing directly to the actual chunks,
>> this patch creates an object for __percpu pointer, but marks it as no
>> scan block, only check whether this pointer is referenced by other
>> blocks.
> 
> OK, so you wanted NO_SCAN to not touch the block at all, not even update
> the checksum. Maybe better add a new flag, NO_ACCESS (and we could use
> it to track ioremap leaks, it's been on my wishlist for years).
>

I will add a new OBJECT_NO_ACCESS.
The checksum of the object will not be updated and its memory block will 
not be scanned if the object marked with OBJECT_NO_ACCESS.

>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index c09c6b59eda6..feedb72f06f2 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -283,6 +288,9 @@ static void hex_dump_object(struct seq_file *seq,
>>   	const u8 *ptr = (const u8 *)object->pointer;
>>   	size_t len;
>>   
>> +	if (object->flags & OBJECT_PERCPU)
>> +		ptr = this_cpu_ptr((void __percpu *)object->pointer);
> 
> You may want to print the CPU number as well since the information is
> likely different on another CPU. Also, I think this context is
> preemptable, so it's better with a get_cpu/put_cpu().
> 

I will print cpu number when dump the percpu object.

>> @@ -651,6 +672,19 @@ static void create_object(unsigned long ptr, size_t size, int min_count,
>>   	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
>>   }
>>   
>> +static void create_object(unsigned long ptr, size_t size, int min_count,
>> +			  gfp_t gfp)
>> +{
>> +	__create_object(ptr, size, min_count, 0, gfp);
>> +}
>> +
>> +static void create_object_percpu(unsigned long ptr, size_t size, int min_count,
>> +				 gfp_t gfp)
>> +{
>> +	__create_object(ptr, size, min_count, OBJECT_PERCPU | OBJECT_NO_SCAN,
>> +			gfp);
>> +}
>> +
>>   /*
>>    * Mark the object as not allocated and schedule RCU freeing via put_object().
>>    */
>> @@ -912,10 +946,12 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
>>   	 * Percpu allocations are only scanned and not reported as leaks
>>   	 * (min_count is set to 0).
>>   	 */
>> -	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
>> +	if (kmemleak_enabled && ptr && !IS_ERR(ptr)) {
>>   		for_each_possible_cpu(cpu)
>>   			create_object((unsigned long)per_cpu_ptr(ptr, cpu),
>>   				      size, 0, gfp);
>> +		create_object_percpu((unsigned long)ptr, size, 1, gfp);
>> +	}
>>   }
> 
> A concern I have here is that ptr may overlap with an existing object
> and the insertion in the rb tree will fail. For example, with !SMP,
> ptr == per_cpu_ptr(ptr, 0), so create_object() will fail and kmemleak
> gets disabled.
> 
> An option would to figure out how to allow overlapping ranges with rb
> tree (or find a replacement for it if not possible).
> 
> Another option would be to have an additional structure to track the
> __percpu pointers since they have their own range. If size is not
> relevant, maybe go for an xarray, otherwise another rb tree (do we have
> any instance of pointers referring some inner member of a __percpu
> object?). The scan_object() function will have to search two trees.
> 

I would like to use CONFIG_SMP to seprate code:
if SMP, we will create some objects for per_cpu_ptr(ptr, cpu) and an 
object with OBJECT_NO_ACCESS for ptr.
if !SMP, we will not create object for per_cpu_ptr(ptr,cpu), but an 
object without OBJECT_NO_ACCESS for ptr will be created.
What do you think about this opinion.

Waiting for your reply

Best wishes
Jun

