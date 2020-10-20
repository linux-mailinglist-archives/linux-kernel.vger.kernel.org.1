Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD384283F91
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 21:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729371AbgJETYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 15:24:51 -0400
Received: from foss.arm.com ([217.140.110.172]:56354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgJETYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 15:24:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1D2C113E;
        Mon,  5 Oct 2020 12:24:49 -0700 (PDT)
Received: from [192.168.122.166] (unknown [10.119.48.41])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E999A3F71F;
        Mon,  5 Oct 2020 12:24:48 -0700 (PDT)
Subject: Re: [BUG][PATCH] arm64: bti: fix BTI to handle local indirect
 branches
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201005181804.1331237-1-jeremy.linton@arm.com>
 <CAMj1kXEkrRvp5Xd_+D_V7Nr1uiKnfAEdZU4kciC5R7_H8aRNZA@mail.gmail.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <c7959ca7-5212-0dfb-2ebc-6247083d356b@arm.com>
Date:   Mon, 5 Oct 2020 14:24:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEkrRvp5Xd_+D_V7Nr1uiKnfAEdZU4kciC5R7_H8aRNZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/5/20 1:54 PM, Ard Biesheuvel wrote:
> On Mon, 5 Oct 2020 at 20:18, Jeremy Linton <jeremy.linton@arm.com> wrote:
>>
>> The AES code uses a 'br x7' as part of a function called by
>> a macro, that ends up needing a BTI_J as a target.
> 
> Could we instead just drop the tail call, i.e, replace it with a ret
> and do a 'bl' after it returns? The indirect call does not really
> serve a purpose here anyway

Yes, that is an option, it adds an extra ret. Which probably doesn't 
mean much in most cases. I assumed this code was optimized this way 
because it mattered somewhere.

> 
> 
>> Lets
>> define SYN_CODE_START_LOCAL() for this and replace the
>> SYM_FUNC_START_LOCAL with a SYM_FUNC_CODE_LOCAL in the AES block.
                                ^ That should have read 
SYM_CODE_START_LOCAL.
>>
>> Without this kernels compiled with the aes_neon_bs will OOPS
>> at boot.
>>
>>    Bad mode in Synchronous Abort handler detected on CPU1, code 0x34000003 -- BTI
>>    CPU: 1 PID: 265 Comm: cryptomgr_test Not tainted 5.8.11-300.fc33.aarch64 #1
>>    pstate: 20400c05 (nzCv daif +PAN -UAO BTYPE=j-)
>>    pc : aesbs_encrypt8+0x0/0x5f0 [aes_neon_bs]
>>    lr : aesbs_xts_encrypt+0x48/0xe0 [aes_neon_bs]
>>    sp : ffff80001052b730
>>    x29: ffff80001052b730 x28: 0000000000000001
>>    x27: ffff0001ec8f4000 x26: ffff0001ec5d27b0
>>    x25: ffff0001ec8f4000 x24: ffff80001052bc00
>>    x23: 0000000000000018 x22: 000000000000000a
>>    x21: ffff0001ec5d2100 x20: ffff0001ec8f4080
>>    x19: ffff0001ec8f4000 x18: 0000000000000004
>>    x17: 0000000000000000 x16: ffffadb4db85d310
>>    x15: 0000000000000200 x14: 0000000000000010
>>    x13: 0000000000000200 x12: ffff0001ec5d2100
>>    x11: 000000000000000a x10: 0000020000200000
>>    x9 : ffffadb4db7e7488 x8 : 0000000000000000
>>    x7 : ffffadb4614fb110 x6 : 0000000000000000
>>    x5 : ffff80001052bc00 x4 : 0000000000000020
>>    x3 : 000000000000000a x2 : ffff0001ec5d2100
>>    x1 : ffff0001ec8f4000 x0 : ffff0001ec8f4000
>>    Kernel panic - not syncing: bad mode
>>    CPU: 1 PID: 265 Comm: cryptomgr_test Not tainted 5.8.11-300.fc33.aarch64 #1
>>    Call trace:
>>     dump_backtrace+0x0/0x1c0
>>     show_stack+0x24/0x30
>>     dump_stack+0xc0/0x118
>>     panic+0x144/0x358
>>     arm64_serror_panic+0x0/0x98
>>     el1_sync_handler+0x60/0x110
>>     el1_sync+0xb4/0x180
>>     aesbs_encrypt8+0x0/0x5f0 [aes_neon_bs]
>>     __xts_crypt+0xb0/0x2dc [aes_neon_bs]
>>     xts_encrypt+0x28/0x3c [aes_neon_bs]
>>    crypto_skcipher_encrypt+0x50/0x84
>>    simd_skcipher_encrypt+0xc8/0xe0
>>    crypto_skcipher_encrypt+0x50/0x84
>>    test_skcipher_vec_cfg+0x224/0x5f0
>>    test_skcipher+0xbc/0x120
>>    alg_test_skcipher+0xa0/0x1b0
>>    alg_test+0x3dc/0x47c
>>    cryptomgr_test+0x38/0x60
>>    kthread+0x11c/0x120
>>    ret_from_fork+0x10/0x18
>>   SMP: stopping secondary CPUs
>>   Kernel Offset: 0x2db4cb7e0000 from 0xffff800010000000
>>   PHYS_OFFSET: 0xffffcf2440000000
>>   CPU features: 0x7e0152,20c02020
>>   Memory Limit: none
>>   ---[ end Kernel panic - not syncing: bad mode ]---
>>
>> Fixes: commit 0e89640b640d ("crypto: arm64 - Use modern annotations for assembly functions")
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/crypto/aes-neonbs-core.S | 8 ++++----
>>   arch/arm64/include/asm/linkage.h    | 6 +++++-
>>   2 files changed, 9 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/crypto/aes-neonbs-core.S b/arch/arm64/crypto/aes-neonbs-core.S
>> index b357164379f6..76de87ee80e1 100644
>> --- a/arch/arm64/crypto/aes-neonbs-core.S
>> +++ b/arch/arm64/crypto/aes-neonbs-core.S
>> @@ -428,7 +428,7 @@ SYM_FUNC_START(aesbs_convert_key)
>>   SYM_FUNC_END(aesbs_convert_key)
>>
>>          .align          4
>> -SYM_FUNC_START_LOCAL(aesbs_encrypt8)
>> +SYM_CODE_START_LOCAL(aesbs_encrypt8)
>>          ldr             q9, [bskey], #16                // round 0 key
>>          ldr             q8, M0SR
>>          ldr             q24, SR
>> @@ -488,10 +488,10 @@ SYM_FUNC_START_LOCAL(aesbs_encrypt8)
>>          eor             v2.16b, v2.16b, v12.16b
>>          eor             v5.16b, v5.16b, v12.16b
>>          ret
>> -SYM_FUNC_END(aesbs_encrypt8)
>> +SYM_END(aesbs_encrypt8)
>>
>>          .align          4
>> -SYM_FUNC_START_LOCAL(aesbs_decrypt8)
>> +SYM_CODE_START_LOCAL(aesbs_decrypt8)
>>          lsl             x9, rounds, #7
>>          add             bskey, bskey, x9
>>
>> @@ -553,7 +553,7 @@ SYM_FUNC_START_LOCAL(aesbs_decrypt8)
>>          eor             v3.16b, v3.16b, v12.16b
>>          eor             v5.16b, v5.16b, v12.16b
>>          ret
>> -SYM_FUNC_END(aesbs_decrypt8)
>> +SYM_END(aesbs_decrypt8)
>>
>>          /*
>>           * aesbs_ecb_encrypt(u8 out[], u8 const in[], u8 const rk[], int rounds,
>> diff --git a/arch/arm64/include/asm/linkage.h b/arch/arm64/include/asm/linkage.h
>> index ba89a9af820a..92c81ae8ac1e 100644
>> --- a/arch/arm64/include/asm/linkage.h
>> +++ b/arch/arm64/include/asm/linkage.h
>> @@ -11,7 +11,8 @@
>>    * set the architecture version to v8.5 we use the hint instruction
>>    * instead.
>>    */
>> -#define BTI_C hint 34 ;
>> +#define BTI_C  hint 34 ;
>> +#define BTI_JC hint 38 ;
>>
>>   /*
>>    * When using in-kernel BTI we need to ensure that PCS-conformant assembly
>> @@ -42,6 +43,9 @@
>>          SYM_START(name, SYM_L_WEAK, SYM_A_NONE)         \
>>          BTI_C
>>
>> +#define SYM_CODE_START_LOCAL(name)                     \
>> +       SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)       \
>> +       BTI_JC
>>   #endif
>>
>>   /*
>> --
>> 2.25.4
>>

