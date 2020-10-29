Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067DF29E472
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgJ2HYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgJ2HYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:35 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83238C0613B3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 22:04:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r10so1359155pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 22:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eq6HsCeVIcarFT/RVf4Np213+644MAjZp902ffEzs3w=;
        b=ZmSTC8AmpvEglpUFbt1U8ZdJWK8wFpAOs7QY39Nc5Wxn6AwvGLmUR5ilDJOH0vkaJD
         jjdTbl5EuQQtAlbzyoA+5MFiT/DAXhhGr2E2RD6msfyEaWGiB9ut30PIBmGWBTbLjgNF
         /71opIXMCrE2xsbzJbcS3sKbvQY8I2E3IqL9Y9/ilFMIh2pgOi1FQZKlBpQrLCcpfx/G
         R3KLqO0S6+UKa9kXcj7mzynj7zHAbvzWF+HLcZsaCuZ9nyY674Xz2gXo6xzT7V0IWSZV
         KFSaULMasERm69sA03LH2zqDO2t1hc1dYGW4mVIwrQ0MzNtSB38Y6K+UAeS/1nRzXi8Y
         klaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eq6HsCeVIcarFT/RVf4Np213+644MAjZp902ffEzs3w=;
        b=cF+fLlErT9UiM0lzNgH2fk+se28G405XlLlFeXqoo03yduwUziRXk9hWURwo2x5EPY
         uAY05/Vo6wPhHpIfeZczdLUxqSIQ6gB9gJpSxD7GQWryjU9Ps0AV3T8UQLWUpYZaTHqM
         b/x+u5qFAVsFdVV6XfD06wumNtt92+ZJL5pgFBCrSgXxFsfK1ao4jae/48MFFfiINaWf
         BBmXAfhWsJHbgLrZJx+dibyZzKG3E/y04wcW/NDp3ZP+nPgqAKq9lrBw9VXly2DNmc8V
         W4fDfOcJK5Ft1PEJRSOfhjO/N9FAB7tuY6XqM0yRAeXRDgQ0tyiXy+NWLGXih1r3zgt3
         V79Q==
X-Gm-Message-State: AOAM533mIU6PbhivOgGoUf2CKNrzY9EAdXVsOug/LHS6bjb+IMkoUSq0
        yKrEUjLyZbecCRe082Jgi2xWxjAvbbCIgw==
X-Google-Smtp-Source: ABdhPJwTqHvM6v1ZaAiCuRdo73rBKwXlZkkFAKtICsxd7j1jSRDwrx7fwmL4ofYd78K5T3DkgO2+dA==
X-Received: by 2002:a17:90b:148c:: with SMTP id js12mr2415798pjb.175.1603947863730;
        Wed, 28 Oct 2020 22:04:23 -0700 (PDT)
Received: from [192.168.10.88] (124-171-72-187.dyn.iinet.net.au. [124.171.72.187])
        by smtp.gmail.com with UTF8SMTPSA id z24sm1036190pgi.7.2020.10.28.22.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 22:04:22 -0700 (PDT)
Subject: Re: [RFC PATCH kernel 1/2] irq: Add reference counting to IRQ
 mappings
To:     Marc Zyngier <maz@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <20201027090655.14118-1-aik@ozlabs.ru>
 <20201027090655.14118-2-aik@ozlabs.ru>
 <415025f93a2b93e8ae62cba57ca1a8a7@kernel.org>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <cda3c451-54f4-ebea-f58e-bd13b79451ff@ozlabs.ru>
Date:   Thu, 29 Oct 2020 16:04:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <415025f93a2b93e8ae62cba57ca1a8a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/10/2020 03:09, Marc Zyngier wrote:
> Hi Alexey,
> 
> On 2020-10-27 09:06, Alexey Kardashevskiy wrote:
>> PCI devices share 4 legacy INTx interrupts from the same PCI host bridge.
>> Device drivers map/unmap hardware interrupts via irq_create_mapping()/
>> irq_dispose_mapping(). The problem with that these interrupts are
>> shared and when performing hot unplug, we need to unmap the interrupt
>> only when the last device is released.
>>
>> This reuses already existing irq_desc::kobj for this purpose.
>> The refcounter is naturally 1 when the descriptor is allocated already;
>> this adds kobject_get() in places where already existing mapped virq
>> is returned.
> 
> That's quite interesting, as I was about to revive a patch series that
> rework the irqdomain subsystem to directly cache irq_desc instead of
> raw interrupt numbers. And for that, I needed some form of refcounting...
> 
>>
>> This reorganizes irq_dispose_mapping() to release the kobj and let
>> the release callback do the cleanup.
>>
>> If some driver or platform does its own reference counting, this expects
>> those parties to call irq_find_mapping() and call irq_dispose_mapping()
>> for every irq_create_fwspec_mapping()/irq_create_mapping().
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  kernel/irq/irqdesc.c   | 35 +++++++++++++++++++++++------------
>>  kernel/irq/irqdomain.c | 27 +++++++++++++--------------
>>  2 files changed, 36 insertions(+), 26 deletions(-)
>>
>> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
>> index 1a7723604399..dae096238500 100644
>> --- a/kernel/irq/irqdesc.c
>> +++ b/kernel/irq/irqdesc.c
>> @@ -419,20 +419,39 @@ static struct irq_desc *alloc_desc(int irq, int
>> node, unsigned int flags,
>>      return NULL;
>>  }
>>
>> +static void delayed_free_desc(struct rcu_head *rhp);
>>  static void irq_kobj_release(struct kobject *kobj)
>>  {
>>      struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
>> +    struct irq_domain *domain;
>> +    unsigned int virq = desc->irq_data.irq;
>>
>> -    free_masks(desc);
>> -    free_percpu(desc->kstat_irqs);
>> -    kfree(desc);
>> +    domain = desc->irq_data.domain;
>> +    if (domain) {
>> +        if (irq_domain_is_hierarchy(domain)) {
>> +            irq_domain_free_irqs(virq, 1);
> 
> How does this work with hierarchical domains? Each domain should
> contribute as a reference on the irq_desc. But if you got here,
> it means the refcount has already dropped to 0.
> 
> So either there is nothing to free here, or you don't track the
> references implied by the hierarchy. I suspect the latter.

This is correct, I did not look at hierarchy yet, looking now...



>> +        } else {
>> +            irq_domain_disassociate(domain, virq);
>> +            irq_free_desc(virq);
>> +        }
>> +    }
>> +
>> +    /*
>> +     * We free the descriptor, masks and stat fields via RCU. That
>> +     * allows demultiplex interrupts to do rcu based management of
>> +     * the child interrupts.
>> +     * This also allows us to use rcu in kstat_irqs_usr().
>> +     */
>> +    call_rcu(&desc->rcu, delayed_free_desc);
>>  }
>>
>>  static void delayed_free_desc(struct rcu_head *rhp)
>>  {
>>      struct irq_desc *desc = container_of(rhp, struct irq_desc, rcu);
>>
>> -    kobject_put(&desc->kobj);
>> +    free_masks(desc);
>> +    free_percpu(desc->kstat_irqs);
>> +    kfree(desc);
>>  }
>>
>>  static void free_desc(unsigned int irq)
>> @@ -453,14 +472,6 @@ static void free_desc(unsigned int irq)
>>       */
>>      irq_sysfs_del(desc);
>>      delete_irq_desc(irq);
>> -
>> -    /*
>> -     * We free the descriptor, masks and stat fields via RCU. That
>> -     * allows demultiplex interrupts to do rcu based management of
>> -     * the child interrupts.
>> -     * This also allows us to use rcu in kstat_irqs_usr().
>> -     */
>> -    call_rcu(&desc->rcu, delayed_free_desc);
>>  }
>>
>>  static int alloc_descs(unsigned int start, unsigned int cnt, int node,
>> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
>> index cf8b374b892d..02733ddc321f 100644
>> --- a/kernel/irq/irqdomain.c
>> +++ b/kernel/irq/irqdomain.c
>> @@ -638,6 +638,7 @@ unsigned int irq_create_mapping(struct irq_domain 
>> *domain,
>>  {
>>      struct device_node *of_node;
>>      int virq;
>> +    struct irq_desc *desc;
>>
>>      pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
>>
>> @@ -655,7 +656,9 @@ unsigned int irq_create_mapping(struct irq_domain 
>> *domain,
>>      /* Check if mapping already exists */
>>      virq = irq_find_mapping(domain, hwirq);
>>      if (virq) {
>> +        desc = irq_to_desc(virq);
>>          pr_debug("-> existing mapping on virq %d\n", virq);
>> +        kobject_get(&desc->kobj);
> 
> My worry with this is that there is probably a significant amount of
> code out there that relies on multiple calls to irq_create_mapping()
> with the same parameters not to have any side effects. They would
> expect a subsequent irq_dispose_mapping() to drop the translation
> altogether, and that's obviously not the case here.
> 
> Have you audited the various call sites to see what could break?


The vast majority calls one of irq..create_mapping in init/probe and 
then calls irq_dispose_mapping() right there if probing failed or when 
the driver is unloaded. I could not spot any reference counting 
anywhere, everyone seems to call irq_dispose_mapping() per every 
irq_of_parse_and_map() (or friends).

Then there is a minority (such as the code I am fixing in 
powerpc/pseries) but it is either broken (such as pseries/pci which does 
not call irq_dispose_mapping at all)  or  it is 1 disposal per 1 mapping 
(PPC KVM).

I did not spend awful amount of time though, git grep 
irq_dispose_mapping gives 200 lines...


> 
>>          return virq;
>>      }
>>
>> @@ -751,6 +754,7 @@ unsigned int irq_create_fwspec_mapping(struct
>> irq_fwspec *fwspec)
>>      irq_hw_number_t hwirq;
>>      unsigned int type = IRQ_TYPE_NONE;
>>      int virq;
>> +    struct irq_desc *desc;
>>
>>      if (fwspec->fwnode) {
>>          domain = irq_find_matching_fwspec(fwspec, DOMAIN_BUS_WIRED);
>> @@ -787,8 +791,11 @@ unsigned int irq_create_fwspec_mapping(struct
>> irq_fwspec *fwspec)
>>           * current trigger type then we are done so return the
>>           * interrupt number.
>>           */
>> -        if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
>> +        if (type == IRQ_TYPE_NONE || type == 
>> irq_get_trigger_type(virq)) {
>> +            desc = irq_to_desc(virq);
>> +            kobject_get(&desc->kobj);
>>              return virq;
>> +        }
>>
>>          /*
>>           * If the trigger type has not been set yet, then set
>> @@ -800,6 +807,8 @@ unsigned int irq_create_fwspec_mapping(struct
>> irq_fwspec *fwspec)
>>                  return 0;
>>
>>              irqd_set_trigger_type(irq_data, type);
>> +            desc = irq_to_desc(virq);
>> +            kobject_get(&desc->kobj);
>>              return virq;
>>          }
>>
>> @@ -852,22 +861,12 @@ EXPORT_SYMBOL_GPL(irq_create_of_mapping);
>>   */
>>  void irq_dispose_mapping(unsigned int virq)
>>  {
>> -    struct irq_data *irq_data = irq_get_irq_data(virq);
>> -    struct irq_domain *domain;
>> +    struct irq_desc *desc = irq_to_desc(virq);
>>
>> -    if (!virq || !irq_data)
>> +    if (!virq || !desc)
>>          return;
>>
>> -    domain = irq_data->domain;
>> -    if (WARN_ON(domain == NULL))
>> -        return;
>> -
>> -    if (irq_domain_is_hierarchy(domain)) {
>> -        irq_domain_free_irqs(virq, 1);
>> -    } else {
>> -        irq_domain_disassociate(domain, virq);
>> -        irq_free_desc(virq);
>> -    }
>> +    kobject_put(&desc->kobj);
>>  }
>>  EXPORT_SYMBOL_GPL(irq_dispose_mapping);
> 
> Thanks,
> 
>          M.

-- 
Alexey
