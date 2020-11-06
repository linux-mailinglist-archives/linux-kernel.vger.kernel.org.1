Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAB682A8D53
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 04:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725899AbgKFDGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 22:06:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgKFDGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:06:11 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56816C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 19:06:11 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 10so6314pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 19:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8V4cSs3rWkuF+gYxB7BC2x1tDJYrLpAmsaSiEaj+nog=;
        b=zrrT9mZNtqC4FMOAlbSAXotT5gHFis8OUIbVn8tBOkQn/VgKMRT8aU3nTqeuF2lOB7
         otMG+0NdgXWnCfTImpobt8XrE7pX3nRsfhZJzHMX8gOQk0XiTHFGZ+b93mZFim7ZX1or
         MwIzcJJZZznL4cRFmq7zBn9nbHqvi/PR2130vWGFcngGoFGkcaLGM1Cav2IlTPKMMOy0
         9sw/GwMcNuN8gfNQDb/7HRYSSCQecDkaLQot4nZ2MD4ErJrhylfBORhtYFAvWVeJ0KNM
         o7NLXu2bzDy5KhVSEBh4A+m79FxGe4EgaHVy2XqsMNfgJ9OjRk4/ZSPMLCvPyWSBo2au
         rgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8V4cSs3rWkuF+gYxB7BC2x1tDJYrLpAmsaSiEaj+nog=;
        b=GFCfvfqyafkxblS+Lue85Nl0giBhE+u4bTOzX5NKg3gut5hKCZXIxoqfUTy0lOEAo7
         jbq34hIzQd9H0A3XCaoYmbV4zZipNP8koSfCq9FZFCJ49Inq7rtosnVft0CAMNO7UlEy
         qb2PmkEKX6lFvi5WovD0InIrD8o8Ze9B56+8BT0DD65xwoShxoi6Xo0I+Ul2XBADhHw8
         hA0Jn9AMFG13Lg3B5K3nd3M1DUjKL3HIrHfWAtabvavcGuiSCN8N+Z/KanlapB0a82x7
         6RpWA5lMvjqDfejMFQBI27BNGq+w8Ia5wMiCTDLYs9VbUieGW/+8omg9ib/g/zsJruMl
         X1kw==
X-Gm-Message-State: AOAM5333D0WlEW9Ae4qG3EUFNrmaPggMjEpya2zQRdZoOQ3PXRZTee0n
        FP2YzDi7Q7Yn/QmYguvLulUgDVLiyRkT8Q==
X-Google-Smtp-Source: ABdhPJx0R8LmbK5vty5YBieNw4n6EX37p++ZgVDMTVnbxPLNlsZ+d0l7htGKAjAF0Yxt13GPCrtCYQ==
X-Received: by 2002:a62:3704:0:b029:18b:9bad:522c with SMTP id e4-20020a6237040000b029018b9bad522cmr3059804pfa.5.1604631970066;
        Thu, 05 Nov 2020 19:06:10 -0800 (PST)
Received: from [192.168.10.88] (124-171-134-245.dyn.iinet.net.au. [124.171.134.245])
        by smtp.gmail.com with UTF8SMTPSA id b67sm4201878pfa.151.2020.11.05.19.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 19:06:08 -0800 (PST)
Subject: Re: [PATCH kernel v2] irq: Add reference counting to IRQ mappings
To:     linuxppc-dev@lists.ozlabs.org
Cc:     =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        David Gibson <david@gibson.dropbear.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
References: <20201029110141.94304-1-aik@ozlabs.ru>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4ed56f8d-3fe4-2d5d-6ec4-139efc742cb2@ozlabs.ru>
Date:   Fri, 6 Nov 2020 14:06:02 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <20201029110141.94304-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This one seems to be broken in the domain associating part so please 
ignore it, I'll post v3 soon. Thanks,


On 29/10/2020 22:01, Alexey Kardashevskiy wrote:
> PCI devices share 4 legacy INTx interrupts from the same PCI host bridge.
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
> Quick grep shows no sign of irq reference counting in drivers. Drivers
> typically request mapping when probing and dispose it when removing;
> platforms tend to dispose only if setup failed and the rest seems
> calling one dispose per one mapping. Except (at least) PPC/pseries
> which needs https://lkml.org/lkml/2020/10/27/259
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> 
> What is the easiest way to get irq-hierarchical hardware?
> I have a bunch of powerpc boxes (no good) but also a raspberry pi,
> a bunch of 32/64bit orange pi's, an "armada" arm box,
> thinkpads - is any of this good for the task?
> 
> 
> ---
> Changes:
> v2:
> * added more get/put, including irq_domain_associate/irq_domain_disassociate
> ---
>   kernel/irq/irqdesc.c   | 36 ++++++++++++++++++++-----------
>   kernel/irq/irqdomain.c | 49 +++++++++++++++++++++++++++++-------------
>   2 files changed, 58 insertions(+), 27 deletions(-)
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 1a7723604399..bc8f62157ffa 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -419,20 +419,40 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
>   	return NULL;
>   }
>   
> +static void delayed_free_desc(struct rcu_head *rhp);
>   static void irq_kobj_release(struct kobject *kobj)
>   {
>   	struct irq_desc *desc = container_of(kobj, struct irq_desc, kobj);
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
> +	/*
> +	 * We free the descriptor, masks and stat fields via RCU. That
> +	 * allows demultiplex interrupts to do rcu based management of
> +	 * the child interrupts.
> +	 * This also allows us to use rcu in kstat_irqs_usr().
> +	 */
> +	call_rcu(&desc->rcu, delayed_free_desc);
>   }
>   
>   static void delayed_free_desc(struct rcu_head *rhp)
>   {
>   	struct irq_desc *desc = container_of(rhp, struct irq_desc, rcu);
>   
> -	kobject_put(&desc->kobj);
> +	free_masks(desc);
> +	free_percpu(desc->kstat_irqs);
> +	kfree(desc);
>   }
>   
>   static void free_desc(unsigned int irq)
> @@ -453,14 +473,6 @@ static void free_desc(unsigned int irq)
>   	 */
>   	irq_sysfs_del(desc);
>   	delete_irq_desc(irq);
> -
> -	/*
> -	 * We free the descriptor, masks and stat fields via RCU. That
> -	 * allows demultiplex interrupts to do rcu based management of
> -	 * the child interrupts.
> -	 * This also allows us to use rcu in kstat_irqs_usr().
> -	 */
> -	call_rcu(&desc->rcu, delayed_free_desc);
>   }
>   
>   static int alloc_descs(unsigned int start, unsigned int cnt, int node,
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index cf8b374b892d..5fb060e077e3 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -487,6 +487,7 @@ static void irq_domain_set_mapping(struct irq_domain *domain,
>   
>   void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
>   {
> +	struct irq_desc *desc = irq_to_desc(irq);
>   	struct irq_data *irq_data = irq_get_irq_data(irq);
>   	irq_hw_number_t hwirq;
>   
> @@ -514,11 +515,14 @@ void irq_domain_disassociate(struct irq_domain *domain, unsigned int irq)
>   
>   	/* Clear reverse map for this hwirq */
>   	irq_domain_clear_mapping(domain, hwirq);
> +
> +	kobject_put(&desc->kobj);
>   }
>   
>   int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
>   			 irq_hw_number_t hwirq)
>   {
> +	struct irq_desc *desc = irq_to_desc(virq);
>   	struct irq_data *irq_data = irq_get_irq_data(virq);
>   	int ret;
>   
> @@ -530,6 +534,8 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
>   	if (WARN(irq_data->domain, "error: virq%i is already associated", virq))
>   		return -EINVAL;
>   
> +	kobject_get(&desc->kobj);
> +
>   	mutex_lock(&irq_domain_mutex);
>   	irq_data->hwirq = hwirq;
>   	irq_data->domain = domain;
> @@ -548,6 +554,7 @@ int irq_domain_associate(struct irq_domain *domain, unsigned int virq,
>   			irq_data->domain = NULL;
>   			irq_data->hwirq = 0;
>   			mutex_unlock(&irq_domain_mutex);
> +			kobject_put(&desc->kobj);
>   			return ret;
>   		}
>   
> @@ -638,6 +645,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>   {
>   	struct device_node *of_node;
>   	int virq;
> +	struct irq_desc *desc;
>   
>   	pr_debug("irq_create_mapping(0x%p, 0x%lx)\n", domain, hwirq);
>   
> @@ -655,7 +663,9 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>   	/* Check if mapping already exists */
>   	virq = irq_find_mapping(domain, hwirq);
>   	if (virq) {
> +		desc = irq_to_desc(virq);
>   		pr_debug("-> existing mapping on virq %d\n", virq);
> +		kobject_get(&desc->kobj);
>   		return virq;
>   	}
>   
> @@ -674,6 +684,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
>   	pr_debug("irq %lu on domain %s mapped to virtual irq %u\n",
>   		hwirq, of_node_full_name(of_node), virq);
>   
> +	desc = irq_to_desc(virq);
>   	return virq;
>   }
>   EXPORT_SYMBOL_GPL(irq_create_mapping);
> @@ -751,6 +762,7 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>   	irq_hw_number_t hwirq;
>   	unsigned int type = IRQ_TYPE_NONE;
>   	int virq;
> +	struct irq_desc *desc;
>   
>   	if (fwspec->fwnode) {
>   		domain = irq_find_matching_fwspec(fwspec, DOMAIN_BUS_WIRED);
> @@ -787,8 +799,15 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>   		 * current trigger type then we are done so return the
>   		 * interrupt number.
>   		 */
> -		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq))
> +		if (type == IRQ_TYPE_NONE || type == irq_get_trigger_type(virq)) {
> +			desc = irq_to_desc(virq);
> +			kobject_get(&desc->kobj);
> +
> +			pr_err("___K___ (%u) %s %u: virq %d counter %d\n",
> +				smp_processor_id(),
> +			       __func__, __LINE__, virq, kref_read(&desc->kobj.kref));
>   			return virq;
> +		}
>   
>   		/*
>   		 * If the trigger type has not been set yet, then set
> @@ -800,6 +819,8 @@ unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec)
>   				return 0;
>   
>   			irqd_set_trigger_type(irq_data, type);
> +			desc = irq_to_desc(virq);
> +			kobject_get(&desc->kobj);
>   			return virq;
>   		}
>   
> @@ -852,22 +873,12 @@ EXPORT_SYMBOL_GPL(irq_create_of_mapping);
>    */
>   void irq_dispose_mapping(unsigned int virq)
>   {
> -	struct irq_data *irq_data = irq_get_irq_data(virq);
> -	struct irq_domain *domain;
> +	struct irq_desc *desc = irq_to_desc(virq);
>   
> -	if (!virq || !irq_data)
> +	if (!virq || !desc)
>   		return;
>   
> -	domain = irq_data->domain;
> -	if (WARN_ON(domain == NULL))
> -		return;
> -
> -	if (irq_domain_is_hierarchy(domain)) {
> -		irq_domain_free_irqs(virq, 1);
> -	} else {
> -		irq_domain_disassociate(domain, virq);
> -		irq_free_desc(virq);
> -	}
> +	kobject_put(&desc->kobj);
>   }
>   EXPORT_SYMBOL_GPL(irq_dispose_mapping);
>   
> @@ -1413,6 +1424,7 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
>   			    bool realloc, const struct irq_affinity_desc *affinity)
>   {
>   	int i, ret, virq;
> +	bool get_ref = false;
>   
>   	if (domain == NULL) {
>   		domain = irq_default_domain;
> @@ -1422,6 +1434,7 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
>   
>   	if (realloc && irq_base >= 0) {
>   		virq = irq_base;
> +		get_ref = true;
>   	} else {
>   		virq = irq_domain_alloc_descs(irq_base, nr_irqs, 0, node,
>   					      affinity);
> @@ -1453,8 +1466,14 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
>   		}
>   	}
>   	
> -	for (i = 0; i < nr_irqs; i++)
> +	for (i = 0; i < nr_irqs; i++) {
>   		irq_domain_insert_irq(virq + i);
> +		if (get_ref) {
> +			struct irq_desc *desc = irq_to_desc(virq + i);
> +
> +			kobject_get(&desc->kobj);
> +		}
> +	}
>   	mutex_unlock(&irq_domain_mutex);
>   
>   	return virq;
> 

-- 
Alexey
