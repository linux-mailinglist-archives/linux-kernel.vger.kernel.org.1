Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67893290677
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408349AbgJPNmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 09:42:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44696 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407058AbgJPNm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:42:29 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602855747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3qZ3wBDxLlc4y2LdirJcgerLsIDb2RZnNo4XttMjq30=;
        b=LJz8u0pLozePlNZYgZvvpyj/qhL5C+MTWzbqD1eu+aQX3xvB+nIhmh51tGKAbVFdSMSXXn
        bgOI8oFYUBzoQV2R+l6uLsM9+2lhxK6DweO9H6eQGNE7z5ectfb0823f66a9pezbNcg2zO
        enw/POzOO9vGilP73TJDT0qmYRyID39Q0DeUpXBnADcGpy+rnJg6Yoye+HPQbOb/NaLP/Q
        cHlwZKPmNQVKIZfJlA/5XDTOC9Y6Fz86kLHgzEhFatJ70/ZzqEeSjO6FOBmow5gvGXsXbB
        9G7vek0DpCNRR1WoZ3IQk67AHjNsdE8YTrr/1rKFVFQh7COU+hNuvn5Ug2trCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602855747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3qZ3wBDxLlc4y2LdirJcgerLsIDb2RZnNo4XttMjq30=;
        b=p6ALofZGtMZBBzMf1J4rWNqTtXAgvjanZlwcjpEBhrQUzIw/w2upgOl64RezJ32xRpQ8Tn
        9sxasXqA3HsrFyAQ==
To:     Marc Zyngier <maz@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>
Cc:     jason@lakedaemon.net, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] irqchip/sifive-plic: Fix the interrupt was enabled accidentally issue.
In-Reply-To: <5bedfbc723665c979eb73eefadb21970@kernel.org>
References: <20201012135724.110579-1-greentime.hu@sifive.com> <20201012135724.110579-2-greentime.hu@sifive.com> <5bedfbc723665c979eb73eefadb21970@kernel.org>
Date:   Fri, 16 Oct 2020 15:42:27 +0200
Message-ID: <87ft6ethh8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15 2020 at 22:23, Marc Zyngier wrote:
> On 2020-10-12 14:57, Greentime Hu wrote:
>> In commit 2ca0b460bbcb ("genirq/affinity: Make affinity setting if
>> activated opt-in"),

This commit sha does not exist in mainline. Referencing a random stable
kernel tree is useless.

>> it added irqd_affinity_on_activate() checking in the function
>> irq_set_affinity_deactivated() so it will return false here.
>> In that case, it will call irq_try_set_affinity() -> plic_irq_toggle()
>> which will enable the interrupt to cause the CPU hang.
>> @@ -183,10 +183,14 @@ static int plic_irqdomain_map(struct irq_domain
>> *d, unsigned int irq,
>>  			      irq_hw_number_t hwirq)
>>  {
>>  	struct plic_priv *priv = d->host_data;
>> +	struct irq_data *irqd;
>> 
>>  	irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
>>  			    handle_fasteoi_irq, NULL, NULL);
>>  	irq_set_noprobe(irq);
>> +	irqd = irq_get_irq_data(irq);
>> +	irqd_set_single_target(irqd);
>> +	irqd_set_affinity_on_activate(irqd);
>>  	irq_set_affinity(irq, &priv->lmask);
>>  	return 0;
>>  }
>
> How does this fix anything? The plic driver doesn't have an activate
> callback, so how does it make any difference? I get the feeling this
> papers over another issue.

The existence of the activate callback is not really the interesting
part. And of course the analysis is completely bogus.

The referenced commit is a follow up to:

baedb87d1b53 ("genirq/affinity: Handle affinity setting on inactive interrupts correctly")

which was added on Jul 17 and the fix was added on Jul 24:

f0c7baca1800 ("genirq/affinity: Make affinity setting if activated opt-in")

The latter restored the original behaviour within 7 days, except for
x86. And the original behaviour was that the core did not care about the
activated state at all. It just invoked irqchip->irq_set_affinity()
unconditionally, which is still does except when the interrupt is marked
with irqd_set_affinity_on_activate().

So the plic code had this problem before that change already:

 	irq_set_noprobe(irq);
 	irq_set_affinity(irq, &priv->lmask);

Mapping happens way before anything else, so Hu is definitely barking up
the wrong tree.

What the patch works around is the irq_set_affinity() callback which is
completely bogus and still broken even after that duct tape which"
fixes" the boot fail.

irq_set_affinity() can be called on masked interrupts so this:

        plic_irq_toggle(&priv->lmask, d, 0);
        plic_irq_toggle(cpumask_of(cpu), d, 1);

will always unconditionally unmask the interrupt when affinity is
changed.

        plic_irq_toggle(cpumask_of(cpu), d, !irqd_irq_masked(d));

is all it needs to work everywhere. Obvious, right?

The changelog wants to be "...: Fix broken irq_set_affinity() callback"
and the Fixes: tag referencing the commit which introduced that
unconditional unmask. Oh well.

Thanks,

        tglx








