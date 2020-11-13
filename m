Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6013A2B23DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 19:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKMSe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 13:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKMSe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 13:34:57 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07DBE206F9;
        Fri, 13 Nov 2020 18:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605292496;
        bh=NjIgaEmcqEk+hSMRlvqRq2+FFxaz59TQCu7jBWCq3/M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dk7SmdanUHZwEU/WTEThter6vvoetvehsyeLAZGWUluC2PFNDTL6lmxm0xvfdMaFC
         AERnaujT/LtPQhGdbSfLwilCwuMt6Ch5CSUxyeDOyXKiNWtOPQnTM+n5s90A3+ME29
         3Hve4pAYPR2UhPC4Cr+N1/4aNspAGCXbWzXOvQBs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kdduP-00AQ40-Tg; Fri, 13 Nov 2020 18:34:54 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 13 Nov 2020 18:34:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Alexey Kardashevskiy <aik@ozlabs.ru>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=C3=A1ne?= =?UTF-8?Q?k?= <msuchanek@suse.de>
Subject: Re: [PATCH kernel v3] genirq/irqdomain: Add reference counting to
 IRQs
In-Reply-To: <20201109094646.71565-1-aik@ozlabs.ru>
References: <20201109094646.71565-1-aik@ozlabs.ru>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <fac73255eabb43242528821888acf2cc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: aik@ozlabs.ru, linux-kernel@vger.kernel.org, tglx@linutronix.de, clg@kaod.org, mpe@ellerman.id.au, cai@lca.pw, robh@kernel.org, fbarrat@linux.ibm.com, msuchanek@suse.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexey,

On 2020-11-09 09:46, Alexey Kardashevskiy wrote:
> PCI devices share 4 legacy INTx interrupts from the same PCI host 
> bridge.
> Device drivers map/unmap hardware interrupts via irq_create_mapping()/
> irq_dispose_mapping(). The problem with that these interrupts are
> shared and when performing hot unplug, we need to unmap the interrupt
> only when the last device is released.
> 
> This reuses already existing irq_desc::kobj for this purpose.
> The refcounter is naturally 1 when the descriptor is allocated already;
> this adds kobject_get() in places where already existing mapped virq
> is returned.
> 
> This reorganizes irq_dispose_mapping() to release the kobj and let
> the release callback do the cleanup.
> 
> As kobject_put() is called directly now (not via RCU), it can also 
> handle
> the early boot case (irq_kobj_base==NULL) with the help of
> the kobject::state_in_sysfs flag and without additional 
> irq_sysfs_del().
> While at this, clean up the comment at where irq_sysfs_del() was 
> called.
> 
> Quick grep shows no sign of irq reference counting in drivers. Drivers
> typically request mapping when probing and dispose it when removing;
> platforms tend to dispose only if setup failed and the rest seems
> calling one dispose per one mapping. Except (at least) PPC/pseries
> which needs https://lkml.org/lkml/2020/10/27/259
> 
> Cc: Cédric Le Goater <clg@kaod.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> Cc: Michal Suchánek <msuchanek@suse.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> This is what it is fixing for powerpc:
> 
> There was a comment about whether hierarchical IRQ domains should
> contribute to this reference counter and I need some help here as
> I cannot see why.
> It is reverse now - IRQs contribute to domain->mapcount and
> irq_domain_associate/irq_domain_disassociate take necessary steps to
> keep this counter in order. What might be missing is that if we have
> cascade of IRQs (as in the IOAPIC example from
> Documentation/core-api/irq/irq-domain.rst ), then a parent IRQ should
> contribute to the children IRQs and it is up to
> irq_domain_ops::alloc/free hooks, and they all seem to be eventually
> calling irq_domain_alloc_irqs_xxx/irq_domain_free_irqs_xxx which seems
> right.
> 
> Documentation/core-api/irq/irq-domain.rst also suggests there is a lot
> to see in debugfs about IRQs but on my thinkpad there nothing about
> hierarchy.
> 
> So I'll ask again :)
> 
> What is the easiest way to get irq-hierarchical hardware?
> I have a bunch of powerpc boxes (no good) but also a raspberry pi,
> a bunch of 32/64bit orange pi's, an "armada" arm box,
> thinkpads - is any of this good for the task?

If your HW doesn't require an interrupt hierarchy, run VMs!
Booting an arm64 guest with virtual PCI devices will result in
hierarchies being created (PCI-MSI -> GIC MSI widget -> GIC).
You can use KVM, or even bare QEMU on x86 if you are so inclined.

I'll try to go through this patch over the week-end (or more probably
early next week), and try to understand where our understandings
differ.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
