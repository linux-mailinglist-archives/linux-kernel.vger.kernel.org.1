Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7672BBB7E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 02:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgKUBZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 20:25:11 -0500
Received: from mail.loongson.cn ([114.242.206.163]:58908 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727367AbgKUBZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 20:25:11 -0500
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxr9NwbLhfHCAUAA--.41434S3;
        Sat, 21 Nov 2020 09:25:05 +0800 (CST)
Subject: Re: [PATCH] microblaze: Use the common INIT_DATA_SECTION macro in
 vmlinux.lds.S
To:     Michal Simek <monstr@monstr.eu>
References: <1605750037-433-1-git-send-email-tangyouling@loongson.cn>
 <d513f0d1-1cfd-9f71-f12e-1b53689ef073@monstr.eu>
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <10172eb4-2fa3-faba-1700-6f9daff74d86@loongson.cn>
Date:   Sat, 21 Nov 2020 09:25:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <d513f0d1-1cfd-9f71-f12e-1b53689ef073@monstr.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxr9NwbLhfHCAUAA--.41434S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KryDJF45Zw1kGr4DXw1kKrg_yoW8KF1Upr
        sIka97uws5KF18X3Z3K3W8uryYvwn3GF4Dua1jga18Cr17uF92vwnFgrs3GFyDCrWDGa10
        va40qFyaka12yaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        xUcBMKDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michal

On 11/20/2020 09:31 PM, Michal Simek wrote:
> Hi,
>
> On 19. 11. 20 2:40, Youling Tang wrote:
>> Use the common INIT_DATA_SECTION rule for the linker script in an effort
>> to regularize the linker script.
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
>> ---
>>   arch/microblaze/kernel/vmlinux.lds.S | 24 +-----------------------
>>   1 file changed, 1 insertion(+), 23 deletions(-)
>>
>> diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
>> index df07b3d..527ebfc 100644
>> --- a/arch/microblaze/kernel/vmlinux.lds.S
>> +++ b/arch/microblaze/kernel/vmlinux.lds.S
>> @@ -96,10 +96,7 @@ SECTIONS {
>>   	__init_begin = .;
>>   
>>   	INIT_TEXT_SECTION(PAGE_SIZE)
>> -
>> -	.init.data : AT(ADDR(.init.data) - LOAD_OFFSET) {
>> -		INIT_DATA
>> -	}
>> +	INIT_DATA_SECTION(0)
>>   
>>   	. = ALIGN(4);
>>   	.init.ivt : AT(ADDR(.init.ivt) - LOAD_OFFSET) {
>> @@ -107,25 +104,6 @@ SECTIONS {
>>   		*(.init.ivt)
>>   		__ivt_end = .;
>>   	}
>> -
>> -	.init.setup : AT(ADDR(.init.setup) - LOAD_OFFSET) {
>> -		INIT_SETUP(0)
>> -	}
>> -
>> -	.initcall.init : AT(ADDR(.initcall.init) - LOAD_OFFSET ) {
>> -		INIT_CALLS
>> -	}
>> -
>> -	.con_initcall.init : AT(ADDR(.con_initcall.init) - LOAD_OFFSET) {
>> -		CON_INITCALL
>> -	}
>> -
>> -	__init_end_before_initramfs = .;
>> -
>> -	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
>> -		INIT_RAM_FS
>> -	}
>> -
>>   	__init_end = .;
>>   
>>   	.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
>>
> Thanks for the patch but I can't accept it because recently we found
> that there needs to be some resorting in linker to be able to boot.
> The issue is that INIT_RAMFS_FS section is text/data/init and bss.
> But because microblaze in early code is using two TLBs (16M) each for
> early mapping and you have big initramfs bss section is unreachable.
> That's why these sections needs to be swapped.
> Maybe bss section can be moved up before INIT_DATA_SECTION maybe even
> before INIT_TEXT_SECTION and we should be fine.
Thank you for your reply. Do you mean it should be changed as follows:
...
.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
                 /* page aligned when MMU used */
                 __bss_start = . ;
                         *(.bss*)
                         *(COMMON)
                 . = ALIGN (4) ;
                 __bss_stop = . ;
         }
INIT_TEXT_SECTION(PAGE_SIZE)
INIT_DATA_SECTION(0)
...

Thanks,
Youling
> Thanks,
> Michal
>

