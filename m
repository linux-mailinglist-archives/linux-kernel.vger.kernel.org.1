Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845B02CBB3E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgLBLKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:10:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33398 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLBLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:10:14 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606907372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/o0Ya2ytt0qpgEtW8XeELjEoL4CrZmijfrOfK1xOPyo=;
        b=KDF/IDMf5a4CSsTaTUcDV9k3G+DhomhtyJ4u7beErLXvr+ggjwfC1WCDVSEOIe7whmsvrF
        u7Y1+BiCDqhFO7xtXzFoCVcgD5r/BGMzyURjM+P5W4Ml8OWH6msr4IH3fG7tHSQvJKBH3h
        +7tnR7Iu7TImEC0Xb3kqiLb85eLd3P0JIX5jL6MhlF9Gpg+7SzjlbplVFrDvWOuwIVIhnk
        XxRsaUGPGx0w34/RomS+aCBJ2Jr61bh8fQIiD6XhCq3croDekYSSqA+0wE6XqHc7RX5/LL
        7fdMaDLQJEN1+LipyyZWlvfnmhZgyQIhha2VX4oDR1+tFkvgLjJ3bzmS6v6DVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606907372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/o0Ya2ytt0qpgEtW8XeELjEoL4CrZmijfrOfK1xOPyo=;
        b=/Z15kjCcCnd2dAv+5axCTrJNpEGl33TEMBoG0z707LUeRANX8nTLuq2b6ef+8E3mPK7yYT
        MoDxcdzxWXKLmIAQ==
To:     Hanks Chen <hanks.chen@mediatek.com>, Marc Zyngier <maz@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Loda Chou <loda.chou@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/3] irqchip/gic: enable irq target all
In-Reply-To: <1606830870.6835.45.camel@mtkswgap22>
References: <1606486531-25719-1-git-send-email-hanks.chen@mediatek.com> <1606486531-25719-2-git-send-email-hanks.chen@mediatek.com> <a3bd54fb5fe1c8ea11559d7459710263@kernel.org> <1606830870.6835.45.camel@mtkswgap22>
Date:   Wed, 02 Dec 2020 12:09:31 +0100
Message-ID: <87r1o8ea6s.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hanks,

On Tue, Dec 01 2020 at 21:54, Hanks Chen wrote:
> On Fri, 2020-11-27 at 18:11 +0000, Marc Zyngier wrote:
>> On 2020-11-27 14:15, Hanks Chen wrote:
>> > +	/*
>> > +	 * No move required, if interrupt is 1 of N IRQ.
>> > +	 * write current cpu_online_mask into affinity mask.
>> > +	 */
>> > +	if (cpumask_weight(desc->irq_common_data.affinity) > 1) {
>> > +		cpumask_copy(desc->irq_common_data.affinity, cpu_online_mask);
>> 
>> Again, this is totally bogus.
>> 
>
> If I add the target all flag into irq_common_data stucture to
> distinguish it. Would this be better?
>
> remove #ifdef CONFIG_ARM_IRQ_TARGET_ALL
>
> and
>
> if (desc->irq_common_data.irq_target_all)
> 	cpumask_copy(desc->irq_common_data.affinity, cpu_online_mask);

No. We are not adding random members to irq_common_data just to support
this. If at all this is a flag of the interrupt chip.

Also this copy is wrong to begin with. The affinity mask is only updated
on cpu hot-unplug when the outgoing CPU is the last online CPU in the
mask. Then we break the user/kernel supplied affinity mask and we only
do that when the interrupt is not affinity managed.

We do not remove offline CPUs from the affinity mask. The affinity code
of the irq chip has to ensure that only online CPUs can be
targeted. That's what ends up in effective_affinity.

>> > +#ifdef CONFIG_ARM_IRQ_TARGET_ALL
>> > +	/*
>> > +	 * No restore required, if interrupt is 1 of N IRQ.
>> > +	 */
>> > +	if (cpumask_weight(affinity) > 1) {
>> > +		cpumask_set_cpu(cpu, irq_data_get_affinity_mask(data));
>> > +		return;
>> > +	}

Heck no. This breaks managed interrupts and some more. Fiddling with the
irq affinity mask is wrong to begin with. Don't touch it ever.

>> > --- a/kernel/irq/manage.c
>> > +++ b/kernel/irq/manage.c
>> > @@ -270,7 +270,14 @@ int irq_do_set_affinity(struct irq_data *data,
>> > const struct cpumask *mask,
>> >  	switch (ret) {
>> >  	case IRQ_SET_MASK_OK:
>> >  	case IRQ_SET_MASK_OK_DONE:
>> > +#ifndef CONFIG_ARM_IRQ_TARGET_ALL
>> >  		cpumask_copy(desc->irq_common_data.affinity, mask);
>> > +#else
>> > +		if (cpumask_weight(mask) > 1)
>> > +			cpumask_copy(desc->irq_common_data.affinity, cpu_online_mask);
>> > +		else
>> > +			cpumask_copy(desc->irq_common_data.affinity, mask);

Again, no. Touching the affinity mask is a NONO. The affinity mask is
handed in from either the kernel or from user space. This code has no
business to override that.

The only case where the kernel touches it is on CPU hot-unplug when the
last cpu in the affinity mask goes offline and if the interrupt is not
affinity managed.

>> - You pollute the core code with hacks that should never be there. If 
>> the
>>    current behaviour is a problem, please state what the problem is.
>> 
> We found the RCU warn when IRQs target to a offline CPU without I bit
> masked in CPU hot-plug flow
> I'll reproduce the issue again and show the log analysis for it.

That has absolutely nothing to do with any of the functions where you
fiddle with the affinity mask.

Thanks,

        tglx
