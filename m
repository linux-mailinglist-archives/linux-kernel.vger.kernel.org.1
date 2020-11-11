Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 085C92AEEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgKKKqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:46:35 -0500
Received: from foss.arm.com ([217.140.110.172]:46860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgKKKqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:46:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAC27101E;
        Wed, 11 Nov 2020 02:46:33 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B73893F7BB;
        Wed, 11 Nov 2020 02:46:32 -0800 (PST)
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
References: <20201105152944.16953-1-ardb@kernel.org>
 <CAMj1kXGtxWk3Z4fxm=b5YMU1Dy2HfaOAynaMiMGKZx9vLArpmg@mail.gmail.com>
 <0b0d47d9-76a5-723f-6642-d5ddadce7f94@arm.com>
 <CAMj1kXHBcb_UxeLs23XZt0VvNM-8JqchutU+qDwdWJm-WQpt5Q@mail.gmail.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Autocrypt: addr=andre.przywara@arm.com; prefer-encrypt=mutual; keydata=
 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
 i4aIXCH3Wv6K
Organization: ARM Ltd.
Message-ID: <fe355153-a718-4259-9ff3-26170b385353@arm.com>
Date:   Wed, 11 Nov 2020 10:46:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXHBcb_UxeLs23XZt0VvNM-8JqchutU+qDwdWJm-WQpt5Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2020 10:05, Ard Biesheuvel wrote:

Hi,

> On Wed, 11 Nov 2020 at 10:45, André Przywara <andre.przywara@arm.com> wrote:
>>
>> On 11/11/2020 08:19, Ard Biesheuvel wrote:
>>
>> Hi,
>>
>>> (+ Eric)
>>>
>>> On Thu, 5 Nov 2020 at 16:29, Ard Biesheuvel <ardb@kernel.org> wrote:
>>>>
>>>> When reseeding the CRNG periodically, arch_get_random_seed_long() is
>>>> called to obtain entropy from an architecture specific source if one
>>>> is implemented. In most cases, these are special instructions, but in
>>>> some cases, such as on ARM, we may want to back this using firmware
>>>> calls, which are considerably more expensive.
>>>>
>>>> Another call to arch_get_random_seed_long() exists in the CRNG driver,
>>>> in add_interrupt_randomness(), which collects entropy by capturing
>>>> inter-interrupt timing and relying on interrupt jitter to provide
>>>> random bits. This is done by keeping a per-CPU state, and mixing in
>>>> the IRQ number, the cycle counter and the return address every time an
>>>> interrupt is taken, and mixing this per-CPU state into the entropy pool
>>>> every 64 invocations, or at least once per second. The entropy that is
>>>> gathered this way is credited as 1 bit of entropy. Every time this
>>>> happens, arch_get_random_seed_long() is invoked, and the result is
>>>> mixed in as well, and also credited with 1 bit of entropy.
>>>>
>>>> This means that arch_get_random_seed_long() is called at least once
>>>> per second on every CPU, which seems excessive, and doesn't really
>>>> scale, especially in a virtualization scenario where CPUs may be
>>>> oversubscribed: in cases where arch_get_random_seed_long() is backed
>>>> by an instruction that actually goes back to a shared hardware entropy
>>>> source (such as RNDRRS on ARM), we will end up hitting it hundreds of
>>>> times per second.
>>
>> May I ask why this should be a particular problem? Form what I gathered
>> on the web, it seems like most h/w RNGs have a capacity of multiple
>> MBit/s. Wikipedia [1] suggests that the x86 CPU instructions generate at
>> least 20 Mbit/s (worst case: AMD's 2500 cycles @ 800 MHz), and I
>> measured around 78 Mbit/s with the raw entropy source on my Juno
>> (possibly even limited by slow MMIO).
>> So it seems unlikely that a few kbit/s drain the hardware entropy source.
>>
>> If we consider this interface comparably cheap, should we then not try
>> to plug the Arm firmware interface into this?
>>
> 
> I'm not sure I follow. Are you saying we should not wire up a
> comparatively expensive firmware interface to
> arch_get_random_seed_long() because we currently assume it is backed
> by something cheap?

Yes. I wanted to (ab)use this patch to clarify this. x86 and arm64 use
CPU instructions (so far), S390 copies from some buffer. PPC uses either
a CPU instruction or an MMIO access. All of these I would consider
comparably cheap, especially when compared to a firmware call with
unknown costs. In fact the current Trusted Firmware implementation[1] is
not really terse, also the generic SMC dispatcher calls a platform
defined routine, which could do anything.
So to also guide the implementation in TF-A, it would be good to
establish what arch_get_random expects to be. The current
implementations and the fact that it lives in a header file suggests
that it's meant as a slim wrapper around something cheap.

> Because doing so would add significantly to the cost. Also note that a
> firmware interface would permit other ways of gathering entropy that
> are not necessarily backed by a dedicated high bandwidth noise source
> (and we already have examples of this)

Yes, agreed.
So I have a hwrng driver for the Arm SMCCC TRNG interface ready. I would
post this, but would like to know if we should drop the proposed
arch_get_random implementation [2][3] of this interface.

>> I am not against this patch, actually am considering this a nice
>> cleanup, to separate interrupt generated entropy from other sources.
>> Especially since we call arch_get_random_seed_long() under a spinlock here.
>> But I am curious about the expectations from arch_get_random in general.
>>
> 
> I think it is reasonable to clean this up a little bit. A random
> *seed* is not the same thing as a random number, and given that we
> expose both interfaces, it makes sense to permit the seed variant to
> be more costly, and only use it as intended (i.e., to seed a random
> number generator)

That's true, it seems we chickened out on the arm64 implementation
already, by not using the intended stronger instruction for seed
(RNDRRS), and not implementing arch_get_random_long() at all.
But I guess that's another story.

Cheers,
Andre.

[1] https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/5585/3
[2]
http://lists.infradead.org/pipermail/linux-arm-kernel/2020-November/615375.html
[3]
http://lists.infradead.org/pipermail/linux-arm-kernel/2020-November/615376.html

>>>> So let's drop the call to arch_get_random_seed_long() from
>>>> add_interrupt_randomness(), and instead, rely on crng_reseed() to call
>>>> the arch hook to get random seed material from the platform.
>>
>> So I tested this and it works as expected: I see some calls on
>> initialisation, then a handful of calls every few seconds from the
>> periodic reseeding. The large number of calls every second are gone.
>>
> 
> Excellent, thanks for confirming.
> 
>>>>
>>>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
>>
>> Since the above questions are unrelated to this particular patch:
>>
>> Reviewed-by: Andre Przywara <andre.przywara@arm.com>
>> Tested-by: Andre Przywara <andre.przywara@arm.com>
>>
>> Cheers,
>> Andre
>>
>> [1] https://en.wikipedia.org/wiki/RDRAND#Performance
>>
>>>> ---
>>>>  drivers/char/random.c | 15 +--------------
>>>>  1 file changed, 1 insertion(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/char/random.c b/drivers/char/random.c
>>>> index 2a41b21623ae..a9c393c1466d 100644
>>>> --- a/drivers/char/random.c
>>>> +++ b/drivers/char/random.c
>>>> @@ -1261,8 +1261,6 @@ void add_interrupt_randomness(int irq, int irq_flags)
>>>>         cycles_t                cycles = random_get_entropy();
>>>>         __u32                   c_high, j_high;
>>>>         __u64                   ip;
>>>> -       unsigned long           seed;
>>>> -       int                     credit = 0;
>>>>
>>>>         if (cycles == 0)
>>>>                 cycles = get_reg(fast_pool, regs);
>>>> @@ -1298,23 +1296,12 @@ void add_interrupt_randomness(int irq, int irq_flags)
>>>>
>>>>         fast_pool->last = now;
>>>>         __mix_pool_bytes(r, &fast_pool->pool, sizeof(fast_pool->pool));
>>>> -
>>>> -       /*
>>>> -        * If we have architectural seed generator, produce a seed and
>>>> -        * add it to the pool.  For the sake of paranoia don't let the
>>>> -        * architectural seed generator dominate the input from the
>>>> -        * interrupt noise.
>>>> -        */
>>>> -       if (arch_get_random_seed_long(&seed)) {
>>>> -               __mix_pool_bytes(r, &seed, sizeof(seed));
>>>> -               credit = 1;
>>>> -       }
>>>>         spin_unlock(&r->lock);
>>>>
>>>>         fast_pool->count = 0;
>>>>
>>>>         /* award one bit for the contents of the fast pool */
>>>> -       credit_entropy_bits(r, credit + 1);
>>>> +       credit_entropy_bits(r, 1);
>>>>  }
>>>>  EXPORT_SYMBOL_GPL(add_interrupt_randomness);
>>>>
>>>> --
>>>> 2.17.1
>>>>
>>

