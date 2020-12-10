Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1A42D6393
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:33:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392694AbgLJRb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30688 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389090AbgLJRbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607621378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WPix3SP1rka7hQ8hX1oDzx6oTaknX+t6svbdYJaNdNE=;
        b=d340LjI+kdEo3hNqi4jO0xGB2HcgQ2PIzNFFMEJ+p75W5/CvOB7Zpbdfeov6DOqPcEAVpC
        GDilRAYt3UtAcZXeoWeX+asY5iRNczJyFHrKiAVaCcK3gxuVltxIlphUzguPO9APpEBmxk
        jGQ/DVwmIl9tKQvd4JHVa0RGExPetlk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-IDzTsYr_MZ66UWQ79EeS1A-1; Thu, 10 Dec 2020 12:29:36 -0500
X-MC-Unique: IDzTsYr_MZ66UWQ79EeS1A-1
Received: by mail-qt1-f197.google.com with SMTP id 99so4454638qte.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:29:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=WPix3SP1rka7hQ8hX1oDzx6oTaknX+t6svbdYJaNdNE=;
        b=lQlrnEdUc48HIKfSDeFdTwP0gpXjUitQHlIHYf3Ft+fkdZt8XGmUU5cq+FAxtSRXRK
         hKG2kKMTNRnGwqudPGK15OQJnepL7h6ZiMCMIiS5bML74a2defC/rsnReAH7i018nPfx
         QXC68vI7p2byBUgMdjQ4nFLBAErcL+Sj4WGMeq5UMYcwVvpnvk0m6nYU6U3ea/Kmqekv
         72eMovN8ViYCr5xBcFV0vJASsSwRKIS+fldQmU7kc/NzdHOCnyFCvP+iU3Ca96hsgvbN
         2NvRUBpJscZ/lYHJNMfPIBrQDHBI98UmPh77XMfXkBnYiy+VXcfKa9R7EWzAiD6Uw0Y5
         AvMQ==
X-Gm-Message-State: AOAM531emOfYELbW21iRuYehcJROREAgutsoQ1cmARLBx1IhxA5pjf86
        4vFHYfoEMufoGsxjHAlt/H0gt/K2G4q1Zboc9FS8U/VSw8EivpYSjE2p8oCsl3+gRE34LRKeIVn
        FD9n3hW7luKCZ7p3NZ3B6bZy7
X-Received: by 2002:ac8:3417:: with SMTP id u23mr10346807qtb.80.1607621375934;
        Thu, 10 Dec 2020 09:29:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyGU7fOjrqhiru2xOMuaLAkJpPXTV9UI0NjLAQmB/TsAVRPeqAVrpXoWFrEyVFjP/UZJwy8gQ==
X-Received: by 2002:ac8:3417:: with SMTP id u23mr10346777qtb.80.1607621375681;
        Thu, 10 Dec 2020 09:29:35 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id h26sm3807343qkj.96.2020.12.10.09.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:29:35 -0800 (PST)
References: <20201210162436.126321-1-suravee.suthikulpanit@amd.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, will@kernel.org, Jon.Grimm@amd.com,
        thomas.lendacky@amd.com
Subject: Re: [PATCH] iommu/amd: Add sanity check for interrupt remapping
 table length macros
In-reply-to: <20201210162436.126321-1-suravee.suthikulpanit@amd.com>
Date:   Thu, 10 Dec 2020 10:29:31 -0700
Message-ID: <871rfxtvr8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Suravee Suthikulpanit @ 2020-12-10 09:24 MST:

> Currently, macros related to the interrupt remapping table length are
> defined separately. This has resulted in an oversight in which one of
> the macros were missed when changing the length. To prevent this,
> redefine the macros to add built-in sanity check.
>
> Also, rename macros to use the name of the DTE[IntTabLen] field as
> specified in the AMD IOMMU specification. There is no functional change.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jerry Snitselaar <jsnitsel@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 19 ++++++++++---------
>  drivers/iommu/amd/init.c            |  6 +++---
>  drivers/iommu/amd/iommu.c           |  2 +-
>  3 files changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 494b42a31b7a..899ce62df3f0 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -255,11 +255,19 @@
>  /* Bit value definition for dte irq remapping fields*/
>  #define DTE_IRQ_PHYS_ADDR_MASK	(((1ULL << 45)-1) << 6)
>  #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
> -#define DTE_IRQ_TABLE_LEN_MASK	(0xfULL << 1)
>  #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> -#define DTE_IRQ_TABLE_LEN       (9ULL << 1)
>  #define DTE_IRQ_REMAP_ENABLE    1ULL
>  
> +/*
> + * AMD IOMMU hardware only support 512 IRTEs despite
> + * the architectural limitation of 2048 entries.
> + */
> +#define DTE_INTTAB_ALIGNMENT    128
> +#define DTE_INTTABLEN_VALUE     9ULL
> +#define DTE_INTTABLEN           (DTE_INTTABLEN_VALUE << 1)
> +#define DTE_INTTABLEN_MASK      (0xfULL << 1)
> +#define MAX_IRQS_PER_TABLE      (1 << DTE_INTTABLEN_VALUE)
> +
>  #define PAGE_MODE_NONE    0x00
>  #define PAGE_MODE_1_LEVEL 0x01
>  #define PAGE_MODE_2_LEVEL 0x02
> @@ -409,13 +417,6 @@ extern bool amd_iommu_np_cache;
>  /* Only true if all IOMMUs support device IOTLBs */
>  extern bool amd_iommu_iotlb_sup;
>  
> -/*
> - * AMD IOMMU hardware only support 512 IRTEs despite
> - * the architectural limitation of 2048 entries.
> - */
> -#define MAX_IRQS_PER_TABLE	512
> -#define IRQ_TABLE_ALIGNMENT	128
> -
>  struct irq_remap_table {
>  	raw_spinlock_t lock;
>  	unsigned min_index;
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 23a790f8f550..6bec8913d064 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -989,10 +989,10 @@ static bool copy_device_table(void)
>  
>  		irq_v = old_devtb[devid].data[2] & DTE_IRQ_REMAP_ENABLE;
>  		int_ctl = old_devtb[devid].data[2] & DTE_IRQ_REMAP_INTCTL_MASK;
> -		int_tab_len = old_devtb[devid].data[2] & DTE_IRQ_TABLE_LEN_MASK;
> +		int_tab_len = old_devtb[devid].data[2] & DTE_INTTABLEN_MASK;
>  		if (irq_v && (int_ctl || int_tab_len)) {
>  			if ((int_ctl != DTE_IRQ_REMAP_INTCTL) ||
> -			    (int_tab_len != DTE_IRQ_TABLE_LEN)) {
> +			    (int_tab_len != DTE_INTTABLEN)) {
>  				pr_err("Wrong old irq remapping flag: %#x\n", devid);
>  				return false;
>  			}
> @@ -2674,7 +2674,7 @@ static int __init early_amd_iommu_init(void)
>  			remap_cache_sz = MAX_IRQS_PER_TABLE * (sizeof(u64) * 2);
>  		amd_iommu_irq_cache = kmem_cache_create("irq_remap_cache",
>  							remap_cache_sz,
> -							IRQ_TABLE_ALIGNMENT,
> +							DTE_INTTAB_ALIGNMENT,
>  							0, NULL);
>  		if (!amd_iommu_irq_cache)
>  			goto out;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index b9cf59443843..f7abf16d1e3a 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3191,7 +3191,7 @@ static void set_dte_irq_entry(u16 devid, struct irq_remap_table *table)
>  	dte	&= ~DTE_IRQ_PHYS_ADDR_MASK;
>  	dte	|= iommu_virt_to_phys(table->table);
>  	dte	|= DTE_IRQ_REMAP_INTCTL;
> -	dte	|= DTE_IRQ_TABLE_LEN;
> +	dte	|= DTE_INTTABLEN;
>  	dte	|= DTE_IRQ_REMAP_ENABLE;
>  
>  	amd_iommu_dev_table[devid].data[2] = dte;


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

