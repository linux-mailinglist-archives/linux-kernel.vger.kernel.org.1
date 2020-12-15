Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06312DB663
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 23:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgLOWNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 17:13:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgLOWNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 17:13:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9658AC0613D6;
        Tue, 15 Dec 2020 14:12:42 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608070360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IXES4CJtys4C59hgPJOT9TUKf5MwFxNN9K1OfuDE6aE=;
        b=vBEo+9C8S5e36A6ZGMNwl9+qyBXpIMgQ73CsLa5aPY+OCBVBtZKxT0GaEioe4c1jH6dTgO
        PWTpNKS/UWyIrl1BexTEcsYPsFrt+YimFT53OCFmpHBSXw+7upJ7GElMnSMHqndtWENlq8
        K5+/nu9pCTl3TyMBERLahJiuday7tibC+tt/VBoK9GhqQvZgdqHt8JO3+gir1fif9zDbDc
        4dUz0mBiU5rxw4Fzmep5Bik8DuG06tJjZuAKTuyNb1S+e6k9i8ihwtlqCooazYwUJH7a4+
        DbvtDc3IFoAHhz/SZ7xFa+/wbHuREZUFRwvUcE2BTG3nO6JijxwQ7Fvmz5zrsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608070360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IXES4CJtys4C59hgPJOT9TUKf5MwFxNN9K1OfuDE6aE=;
        b=DDmz+6YvLnFwKnkzWLg65QmW9e/zDO4pgrEpgkoou8XgDn5Hxh2FPHaqr5kVtgRHrWRL2t
        mgxTM11UDl1A8lBw==
To:     "Enrico Weigelt\, metux IT consult" <lkml@metux.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Enrico Weigelt\, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     James.Bottomley@HansenPartnership.com, deller@gmx.de,
        benh@kernel.crashing.org, paulus@samba.org, jdike@addtoit.com,
        richard@nod.at, anton.ivanov@cambridgegreys.com, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-um@lists.infradead.org
Subject: Re: [PATCH] arch: fix 'unexpected IRQ trap at vector' warnings
In-Reply-To: <33001e60-cbfc-f114-55bf-f347f21fee9b@metux.net>
References: <20201207143146.30021-1-info@metux.net> <877dptt5av.fsf@mpe.ellerman.id.au> <87y2i7298s.fsf@nanos.tec.linutronix.de> <33001e60-cbfc-f114-55bf-f347f21fee9b@metux.net>
Date:   Tue, 15 Dec 2020 23:12:40 +0100
Message-ID: <87a6ueu3af.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15 2020 at 21:12, Enrico Weigelt wrote:
> On 09.12.20 00:01, Thomas Gleixner wrote:
>>   3) It's invoked from __handle_domain_irq() when the 'hwirq' which is
>>      handed in by the caller does not resolve to a mapped Linux
>>      interrupt which is pretty much the same as the x86 situation above
>>      in #1, but it prints useless data.
>> 
>>      It prints 'irq' which is invalid but it does not print the really
>>      interesting 'hwirq' which was handed in by the caller and did
>>      not resolve.
>
> I wouldn't say the irq-nr isn't interesting. In my particular case it
> was quite what I've been looking for. But you're right, hwirq should
> also be printed.

The number is _not_ interesting in this case. It's useless because the
function does:

    irq = hwirq;

    if (lookup)
        irq = find_mapping(hwirq);

    if (!irq || irq >= nr_irqs)
       -> BAD

So irq is completely useless because find_mapping() returns 0 if there
is no mapping and if irq >= nr_irqs then there was no lookup and the
hwirq number is bogus.

In both cases the only interesting information is that hwirq does not
resolve to a valid Linux interrupt number and which hwirq number caused
that.

>>      In this case the Linux irq number is uninteresting as it is known
>>      to be invalid and simply is not mapped and therefore does not
>>      exist.
>
> In my case it came in from generic_handle_irq(), and in this case this
> irq number (IMHO) has been valid, but nobody handled it, so it went to
> ack_bad_irq.

generic_handle_irq() _is_ a different function which is only invoked
when there is a valid Linux interrupt number and then the ack_bad_irq()
is invoked from a different place. See below.

> Of course, if this function is meant as a fallback to ack some not
> otherwise handled IRQ on the hw, the linux irq number indeed isn't quite
> helpful (unless we expect that code to do a lookup to the hw irq).

If there is no valid linux irq number then there is no lookup. And you
can't look it up from the hardware either.

If you look really then you find out that there is exactly _ONE_
architecture which does anything else than incrementing a counter and/or
printing stuff: X86, which has a big fat comment explaining why. The
only way to ack an interrupt on X86 is to issue EOI on the local APIC,
i.e. it does _not_ need any further information.

> ... rethinking this further ... shouldn't we also pass in even more data
> (eg. irq_desc, irqchip, ...), so this function can check which hw to
> actually talk to ?

There are 3 ways to get there:

      1) via dummy chip which obviously has no hardware associated

      2) via handle_bad_irq() which prints the info already

      3) __handle_domain_irq() which cannot print anything and obviously
         cannot figure out the hw to talk to because there is no irq
         descriptor associated.

>>   4) It's invoked from the dummy irq chip which is installed for a
>>      couple of truly virtual interrupts where the invocation of
>>      dummy_irq_chip::irq_ack() is indicating wreckage.
>> 
>>      In that case the Linux irq number is the thing which is printed.
>> 
>> So no. It's not just inconsistent it's in some places outright
>> wrong. What we really want is:
>> 
>> ack_bad_irq(int hwirq, int virq)
>
> is 'int' correct here ?

This was just for illustration.

> BTW: I also wonder why the virq is unsigned int, while hwirq (eg. in
> struct irq_data) is unsigned long. shouldn't the virtual number space
> be at least as big (or even bigger) than the hw one ?

Only if there are no irqdomain mappings and the virq space is 1:1 mapped
to the hwirq space. Systems with > 4G interrupts are pretty unlikely.

Also hwirq can be completely artificial and encode information about
interrupts which are composed, i.e. PCI/MSI. See pci_msi_domain_calc_hwirq().

>  {
>>         if (hwirq >= 0)
>>            print_useful_info(hwirq);
>>         if (virq > 0)
>>            print_useful_info(virq);
>>         arch_try_to_ack(hwirq, virq);
>> }
>>     
>> for this to make sense. Just fixing the existing printk() to be less
>> wrong is not really an improvement.
>
> Okay, makes sense.
>
> OTOH: since both callers (dummychip.c, handle.c) already dump out before
> ack_bad_irq(), do we need to print out anything at all ?

Not all callers print something, but yes this could do with some general
cleanup.

> I've also seen that many archs increase a counter (some use long, others
> atomic_t) - should we also consolidate this in an arch-independent way
> in handle.c (or does kstat_incr_irqs_this_cpu already do this) ?

kstat_incr_irqs_this_cpu(desc) operates on the irq descriptor which
requires that an irq descriptor exists in the first place.

The error counter is independent of that, but yes there is room for
consolidation.

Thanks,

        tglx
