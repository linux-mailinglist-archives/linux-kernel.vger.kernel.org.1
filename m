Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4422B2D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 13:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgKNMpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 07:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbgKNMpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 07:45:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2BC0613D1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Nov 2020 04:45:20 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605357918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AwHqBJ1A0pSeDB52pzpfXWyhp1imACv42f9AV+4q3Js=;
        b=aq10CgPaijfLuI0NJN8nwZdIW2OwWxCQDDAfuiB//dADb2WDTlDja6q+nHVPB3TOKDkery
        ByrtJBcopCZ8Qu/D1V1byIjBMFHVyw2t74fQv/UPeL+yuABr2gdraK5dlFSrSrlM7vX61Y
        biF3+JOFa9Y9h/pDosdYTB5xi08nlKf3LSXmLgXGulbeMXQZ687N/+TlTLcosqevJKAfnw
        fN/NI0W5R6J1DBE4ptk3lgMW+uCkxsuXNj9gt3II80k42fxLtk/z9WQNG7lrYxwj6FmR3v
        LKzhqCpdPGMKC2ACbBJqwiQ/Jm+wPp1abmGcwuY7y9XFhoAXFnWGaND8oqq7WQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605357918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AwHqBJ1A0pSeDB52pzpfXWyhp1imACv42f9AV+4q3Js=;
        b=b0bx2a4UYahvxeh+WrFhQcEFNnv9qBUov+dgXwWyYPDNadYXfJLNYNiSS1GWAInugMxox6
        3zmGIBSETp9+uxAQ==
To:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        Marc Zyngier <maz@kernel.org>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: [PATCH kernel v3] genirq/irqdomain: Add reference counting to IRQs
In-Reply-To: <20201109094646.71565-1-aik@ozlabs.ru>
References: <20201109094646.71565-1-aik@ozlabs.ru>
Date:   Sat, 14 Nov 2020 13:45:18 +0100
Message-ID: <87a6vkayzl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09 2020 at 20:46, Alexey Kardashevskiy wrote:
> PCI devices share 4 legacy INTx interrupts from the same PCI host bridge.
> Device drivers map/unmap hardware interrupts via irq_create_mapping()/
> irq_dispose_mapping(). The problem with that these interrupts are
> shared and when performing hot unplug, we need to unmap the interrupt
> only when the last device is released.
>
> There was a comment about whether hierarchical IRQ domains should
> contribute to this reference counter and I need some help here as
> I cannot see why.
> It is reverse now - IRQs contribute to domain->mapcount and
> irq_domain_associate/irq_domain_disassociate take necessary steps to
> keep this counter in order.

I'm not yet convinced that this change is correct under all
circumstances. See below.

> What might be missing is that if we have cascade of IRQs (as in the
> IOAPIC example from Documentation/core-api/irq/irq-domain.rst ), then
> a parent IRQ should contribute to the children IRQs and it is up to

No. Hierarchical irq domains handle ONE interrupt and have nothing to do
with parent/child interrupts. They represent the various layers of
hardware involved in delivering one particular interrupt. Just looking
at this example:

  Device --> IOAPIC -> Interrupt remapping Controller -> Local APIC -> CPU

There are 3 interrupt chips involved: IOAPIC - REMAP - APIC and each of
them has to do configuration and/or resource allocation when setting up
an interrupt. Also during handling the various chip levels might be
involved.

So now if you remove interrupt remapping (config, commandline, lack of
HW) the delivery chain looks like this:

  Device --> IOAPIC -> Local APIC -> CPU

So we only have two chips involved.

Hierarchical domains handle that at boot time by associating the
relevant parent domains to the involved chips.

> Documentation/core-api/irq/irq-domain.rst also suggests there is a lot
> to see in debugfs about IRQs but on my thinkpad there nothing about
> hierarchy.

Enable GENERIC_IRQ_DEBUGFS and surf around in
/sys/kernel/debug/irq/domains.

cat /sys/kernel/debug/irq/domains/IO-APIC-240 
name:   IO-APIC-240
 size:   24
 mapped: 15
 flags:  0x00000003
 parent: AMD-IR-3
    name:   AMD-IR-3
     size:   0
     mapped: 28
     flags:  0x00000003
     parent: VECTOR
        name:   VECTOR
         size:   0
         mapped: 295
         flags:  0x00000003

You will find something like this on your thinkpad as well. It might be
a two level hierarchy if there is no remapping unit.

name:   IO-APIC-240
 size:   24
 mapped: 15
 flags:  0x00000003
 parent: VECTOR
    name:   VECTOR
     size:   0
     mapped: 292
     flags:  0x00000003

and if you look at an interrupt:

# cat /sys/kernel/debug/irq/irqs/4
handler:  handle_edge_irq
device:   (null)
status:   0x00004000
istate:   0x00000000
ddepth:   0
wdepth:   0
dstate:   0x35408200
            IRQD_ACTIVATED
            IRQD_IRQ_STARTED
            IRQD_SINGLE_TARGET
            IRQD_MOVE_PCNTXT
            IRQD_AFFINITY_ON_ACTIVATE
            IRQD_CAN_RESERVE
            IRQD_HANDLE_ENFORCE_IRQCTX
node:     0
affinity: 0-63,128-191
effectiv: 130
pending:  
domain:  IO-APIC-240
 hwirq:   0x4
 chip:    IR-IO-APIC
  flags:   0x10
             IRQCHIP_SKIP_SET_WAKE
 parent:
    domain:  AMD-IR-3
     hwirq:   0xa00000
     chip:    AMD-IR
      flags:   0x0
     parent:
        domain:  VECTOR
         hwirq:   0x4
         chip:    APIC
          flags:   0x0
         Vector:    33
         Target:   130
         move_in_progress: 0
         is_managed:       0
         can_reserve:      1
         has_reserved:     0
         cleanup_pending:  0

you can see the domain hierarchy as well and the relevant information
per domain. So on the IO-APIC it's hwirq 4, i.e. PIN 4. In the remap
domain it's 0xa00000 which is the relevant table IIRC and the vector
domain has extra information about the target vector (33) and the target
CPU (130).

> So I'll ask again :)
>
> What is the easiest way to get irq-hierarchical hardware?
> I have a bunch of powerpc boxes (no good) but also a raspberry pi,
> a bunch of 32/64bit orange pi's, an "armada" arm box,
> thinkpads - is any of this good for the task?

You have it already. Everything you listed except PPC uses hierarchical
interrupt domains.

> +static void delayed_free_desc(struct rcu_head *rhp);
>  static void irq_kobj_release(struct kobject *kobj)
>  {
>  	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
> +#ifdef CONFIG_IRQ_DOMAIN
> +	struct irq_domain *domain;
> +	unsigned int virq = desc->irq_data.irq;
>  
> -	free_masks(desc);
> -	free_percpu(desc->kstat_irqs);
> -	kfree(desc);
> +	domain = desc->irq_data.domain;
> +	if (domain) {
> +		if (irq_domain_is_hierarchy(domain)) {
> +			irq_domain_free_irqs(virq, 1);
> +		} else {
> +			irq_domain_disassociate(domain, virq);
> +			irq_free_desc(virq);
> +		}
> +	}
> +#endif

This is really a layering violation. While it's smart to reuse the kobj
inside the irq descriptor, you're bolting the refcounting which is
required for handling this irqdomain multi-association case into the irq
descriptor code and invoking stuff from within the irq descriptor code
which absolutely does not belong there at all.

Thereby breaking hierarchical irqdomains completely. Just look at
the following callchain as one example (there are way more):

pci_disable_msi()
  pci_msi_teardown_msi_irqs()
    msi_domain_free_irqs()
      msi_domain->ops->domain_free_irqs()
        __msi_domain_free_irqs()
           irq_domain_free_irqs()
             irq_domain_free_irqs_hierarchy()
               irq_free_descs()
                 free_descs()

Sorry, but it's really not rocket science to find the call chains leading
up to free_desc().

And once you found all of them you'll end up with lots of ugly
constructs like conditional refcounting which is wrong to begin with:

> +		if (get_ref) {
> +			struct irq_desc *desc = irq_to_desc(virq + i);

This is an alarm sign in the first place.

I'm not saying, that reusing the irqdesc::kobj is bad per se, but this
needs way more thought than just moving stuff into the release function
and slapping kobj_get()/put() pairs all over the place.

If at all this needs to be done in small incremental steps and not as a
wholesale rewrite which is pretty much impossible to review.

Thanks,

        tglx
