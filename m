Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394B62B8D88
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 09:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgKSIdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 03:33:01 -0500
Received: from mail.loongson.cn ([114.242.206.163]:43642 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726096AbgKSIdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 03:33:00 -0500
Received: from [10.130.0.193] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx73+wLbZfRZ8SAA--.29334S3;
        Thu, 19 Nov 2020 16:32:49 +0800 (CST)
Subject: Re: [PATCH] arm64: vmlinux.lds.S: Drop redundant *.init.rodata.*
To:     Ard Biesheuvel <ardb@kernel.org>
References: <1605750340-910-1-git-send-email-tangyouling@loongson.cn>
 <CAMj1kXFr+1Khbisq2je41j_nFQnFhdYBW9bg+Ka5xbBJXHHkyg@mail.gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        James Morse <james.morse@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Youling Tang <tangyouling@loongson.cn>
Message-ID: <f1c18bdb-69a5-9260-d931-69f6bc926170@loongson.cn>
Date:   Thu, 19 Nov 2020 16:32:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFr+1Khbisq2je41j_nFQnFhdYBW9bg+Ka5xbBJXHHkyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx73+wLbZfRZ8SAA--.29334S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr47ZFWfKw47WF48Zr4rAFb_yoW8Xw4rpF
        WUC34vkr4DKay5G3WftwnY9F1293sIgrW3Gr4UCr4akrnxW34IqrnrKrWIkrZF9r4vkF40
        gFn2vFWa9a4DAa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzlksUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ard

On 11/19/2020 03:18 PM, Ard Biesheuvel wrote:
> On Thu, 19 Nov 2020 at 02:45, Youling Tang <tangyouling@loongson.cn> wrote:
>> We currently try to emit *.init.rodata.* twice, once in INIT_DATA, and once
>> in the line immediately following it. As the two section definitions are
>> identical, the latter is redundant and can be dropped.
>>
>> This patch drops the redundant *.init.rodata.* section definition.
>>
>> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> .init.rodata.* was added to INIT_DATA in
> 266ff2a8f51f02b429a987d87634697eb0d01d6a, so removing it here seems
> reasonable. However, it does conflict with the for-next/lto branch in
> the arm64 tree.
>
The possible causes of the conflict are e35123d83ee submit.

master branch code as follows:
     ...
     INIT_RAM_FS
     *(.init.rodata.* .init.bss)     /* from the EFI stub */

for-next/lto branch code as follows:
     ...
     INIT_RAM_FS
     *(.init.altinstructions .init.rodata.* .init.bss) /* from the EFI 
stub */

Thanks,
Youling
>> ---
>>   arch/arm64/kernel/vmlinux.lds.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 1bda604..7dba3c4 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -201,7 +201,7 @@ SECTIONS
>>                  INIT_CALLS
>>                  CON_INITCALL
>>                  INIT_RAM_FS
>> -               *(.init.rodata.* .init.bss)     /* from the EFI stub */
>> +               *(.init.bss)    /* from the EFI stub */
>>          }
>>          .exit.data : {
>>                  EXIT_DATA
>> --
>> 2.1.0
>>

