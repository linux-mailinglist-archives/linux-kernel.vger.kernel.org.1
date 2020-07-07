Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31B0216CE2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 14:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGGMeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 08:34:10 -0400
Received: from foss.arm.com ([217.140.110.172]:46118 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbgGGMeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:34:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 973AC1FB;
        Tue,  7 Jul 2020 05:34:08 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DE2C3F71E;
        Tue,  7 Jul 2020 05:34:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] iommu/arm-smmu: Add auxiliary domain support for
 arm-smmuv2
To:     Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        John Stultz <john.stultz@linaro.org>,
        freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20200626200414.14382-1-jcrouse@codeaurora.org>
 <20200626200414.14382-2-jcrouse@codeaurora.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9943752c-9e0b-3d11-cba9-ee579d449e30@arm.com>
Date:   Tue, 7 Jul 2020 13:34:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200626200414.14382-2-jcrouse@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-26 21:04, Jordan Crouse wrote:
> Support auxiliary domains for arm-smmu-v2 to initialize and support
> multiple pagetables for a single SMMU context bank. Since the smmu-v2
> hardware doesn't have any built in support for switching the pagetable
> base it is left as an exercise to the caller to actually use the pagetable.

Hmm, I've still been thinking that we could model this as supporting 
exactly 1 aux domain iff the device is currently attached to a primary 
domain with TTBR1 enabled. Then supporting multiple aux domains with 
magic TTBR0 switching is the Adreno-specific extension on top of that.

And if we don't want to go to that length, then - as I think Will was 
getting at - I'm not sure it's worth bothering at all. There doesn't 
seem to be any point in half-implementing a pretend aux domain interface 
while still driving a bus through the rest of the abstractions - it's 
really the worst of both worlds. If we're going to hand over the guts of 
io-pgtable to the GPU driver then couldn't it just use 
DOMAIN_ATTR_PGTABLE_CFG bidirectionally to inject a TTBR0 table straight 
into the TTBR1-ified domain?

Much as I like the idea of the aux domain abstraction and making this 
fit semi-transparently into the IOMMU API, if an almost entirely private 
interface will be the simplest and cleanest way to get it done then at 
this point also I'm starting to lean towards just getting it done. But 
if some other mediated-device type case then turns up that doesn't quite 
fit that private interface, we revisit the proper abstraction again and 
I reserve the right to say "I told you so" ;)

Robin.

> Aux domains are supported if split pagetable (TTBR1) support has been
> enabled on the master domain.  Each auxiliary domain will reuse the
> configuration of the master domain. By default the a domain with TTBR1
> support will have the TTBR0 region disabled so the first attached aux
> domain will enable the TTBR0 region in the hardware and conversely the
> last domain to be detached will disable TTBR0 translations.  All subsequent
> auxiliary domains create a pagetable but not touch the hardware.
> 
> The leaf driver will be able to query the physical address of the
> pagetable with the DOMAIN_ATTR_PTBASE attribute so that it can use the
> address with whatever means it has to switch the pagetable base.
> 
> Following is a pseudo code example of how a domain can be created
> 
>   /* Check to see if aux domains are supported */
>   if (iommu_dev_has_feature(dev, IOMMU_DEV_FEAT_AUX)) {
> 	 iommu = iommu_domain_alloc(...);
> 
> 	 if (iommu_aux_attach_device(domain, dev))
> 		 return FAIL;
> 
> 	/* Save the base address of the pagetable for use by the driver
> 	iommu_domain_get_attr(domain, DOMAIN_ATTR_PTBASE, &ptbase);
>   }
> 
> Then 'domain' can be used like any other iommu domain to map and
> unmap iova addresses in the pagetable.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>   drivers/iommu/arm-smmu.c | 219 ++++++++++++++++++++++++++++++++++++---
>   drivers/iommu/arm-smmu.h |   1 +
>   2 files changed, 204 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
> index 060139452c54..ce6d654301bf 100644
> --- a/drivers/iommu/arm-smmu.c
> +++ b/drivers/iommu/arm-smmu.c
> @@ -91,6 +91,7 @@ struct arm_smmu_cb {
>   	u32				tcr[2];
>   	u32				mair[2];
>   	struct arm_smmu_cfg		*cfg;
> +	atomic_t			aux;
>   };
>   
>   struct arm_smmu_master_cfg {
> @@ -667,6 +668,86 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
>   	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>   }
>   
> +/*
> + * Update the context context bank to enable TTBR0. Assumes AARCH64 S1
> + * configuration.
> + */
> +static void arm_smmu_context_set_ttbr0(struct arm_smmu_cb *cb,
> +		struct io_pgtable_cfg *pgtbl_cfg)
> +{
> +	u32 tcr = cb->tcr[0];
> +
> +	/* Add the TCR configuration from the new pagetable config */
> +	tcr |= arm_smmu_lpae_tcr(pgtbl_cfg);
> +
> +	/* Make sure that both TTBR0 and TTBR1 are enabled */
> +	tcr &= ~(ARM_SMMU_TCR_EPD0 | ARM_SMMU_TCR_EPD1);
> +
> +	/* Udate the TCR register */
> +	cb->tcr[0] = tcr;
> +
> +	/* Program the new TTBR0 */
> +	cb->ttbr[0] = pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
> +	cb->ttbr[0] |= FIELD_PREP(ARM_SMMU_TTBRn_ASID, cb->cfg->asid);
> +}
> +
> +/*
> + * Thus function assumes that the current model only allows aux domains for
> + * AARCH64 S1 configurations
> + */
> +static int arm_smmu_aux_init_domain_context(struct iommu_domain *domain,
> +		struct arm_smmu_device *smmu, struct arm_smmu_cfg *master)
> +{
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct io_pgtable_ops *pgtbl_ops;
> +	struct io_pgtable_cfg pgtbl_cfg;
> +
> +	mutex_lock(&smmu_domain->init_mutex);
> +
> +	/* Copy the configuration from the master */
> +	memcpy(&smmu_domain->cfg, master, sizeof(smmu_domain->cfg));
> +
> +	smmu_domain->flush_ops = &arm_smmu_s1_tlb_ops;
> +	smmu_domain->smmu = smmu;
> +
> +	pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.pgsize_bitmap = smmu->pgsize_bitmap,
> +		.ias = smmu->va_size,
> +		.oas = smmu->ipa_size,
> +		.coherent_walk = smmu->features & ARM_SMMU_FEAT_COHERENT_WALK,
> +		.tlb = smmu_domain->flush_ops,
> +		.iommu_dev = smmu->dev,
> +		.quirks = 0,
> +	};
> +
> +	if (smmu_domain->non_strict)
> +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
> +
> +	pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1, &pgtbl_cfg,
> +		smmu_domain);
> +	if (!pgtbl_ops) {
> +		mutex_unlock(&smmu_domain->init_mutex);
> +		return -ENOMEM;
> +	}
> +
> +	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
> +
> +	domain->geometry.aperture_end = (1UL << smmu->va_size) - 1;
> +	domain->geometry.force_aperture = true;
> +
> +	/* enable TTBR0 when the the first aux domain is attached */
> +	if (atomic_inc_return(&smmu->cbs[master->cbndx].aux) == 1) {
> +		arm_smmu_context_set_ttbr0(&smmu->cbs[master->cbndx],
> +			&pgtbl_cfg);
> +		arm_smmu_write_context_bank(smmu, master->cbndx);
> +	}
> +
> +	smmu_domain->pgtbl_ops = pgtbl_ops;
> +	mutex_unlock(&smmu_domain->init_mutex);
> +
> +	return 0;
> +}
> +
>   static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   					struct arm_smmu_device *smmu,
>   					struct device *dev)
> @@ -871,36 +952,70 @@ static int arm_smmu_init_domain_context(struct iommu_domain *domain,
>   	return ret;
>   }
>   
> +static void
> +arm_smmu_destroy_aux_domain_context(struct arm_smmu_domain *smmu_domain)
> +{
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	int ret;
> +
> +	/*
> +	 * If this is the last aux domain to be freed, disable TTBR0 by turning
> +	 * off translations and clearing TTBR0
> +	 */
> +	if (atomic_dec_return(&smmu->cbs[cfg->cbndx].aux) == 0) {
> +		/* Clear out the T0 region */
> +		smmu->cbs[cfg->cbndx].tcr[0] &= ~GENMASK(15, 0);
> +		/* Disable TTBR0 translations */
> +		smmu->cbs[cfg->cbndx].tcr[0] |= ARM_SMMU_TCR_EPD0;
> +		/* Clear the TTBR0 pagetable address */
> +		smmu->cbs[cfg->cbndx].ttbr[0] =
> +			FIELD_PREP(ARM_SMMU_TTBRn_ASID, cfg->asid);
> +
> +		ret = arm_smmu_rpm_get(smmu);
> +		if (!ret) {
> +			arm_smmu_write_context_bank(smmu, cfg->cbndx);
> +			arm_smmu_rpm_put(smmu);
> +		}
> +	}
> +
> +}
> +
>   static void arm_smmu_destroy_domain_context(struct iommu_domain *domain)
>   {
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct arm_smmu_device *smmu = smmu_domain->smmu;
>   	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> -	int ret, irq;
>   
>   	if (!smmu || domain->type == IOMMU_DOMAIN_IDENTITY)
>   		return;
>   
> -	ret = arm_smmu_rpm_get(smmu);
> -	if (ret < 0)
> -		return;
> +	if (smmu_domain->aux)
> +		arm_smmu_destroy_aux_domain_context(smmu_domain);
>   
> -	/*
> -	 * Disable the context bank and free the page tables before freeing
> -	 * it.
> -	 */
> -	smmu->cbs[cfg->cbndx].cfg = NULL;
> -	arm_smmu_write_context_bank(smmu, cfg->cbndx);
> +	/* Check if the last user is done with the context bank */
> +	if (atomic_read(&smmu->cbs[cfg->cbndx].aux) == 0) {
> +		int ret = arm_smmu_rpm_get(smmu);
> +		int irq;
>   
> -	if (cfg->irptndx != ARM_SMMU_INVALID_IRPTNDX) {
> -		irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> -		devm_free_irq(smmu->dev, irq, domain);
> +		if (ret < 0)
> +			return;
> +
> +		/* Disable the context bank */
> +		smmu->cbs[cfg->cbndx].cfg = NULL;
> +		arm_smmu_write_context_bank(smmu, cfg->cbndx);
> +
> +		if (cfg->irptndx != ARM_SMMU_INVALID_IRPTNDX) {
> +			irq = smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
> +			devm_free_irq(smmu->dev, irq, domain);
> +		}
> +
> +		__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> +		arm_smmu_rpm_put(smmu);
>   	}
>   
> +	/* Destroy the pagetable */
>   	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
> -	__arm_smmu_free_bitmap(smmu->context_map, cfg->cbndx);
> -
> -	arm_smmu_rpm_put(smmu);
>   }
>   
>   static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> @@ -1161,6 +1276,74 @@ static int arm_smmu_domain_add_master(struct arm_smmu_domain *smmu_domain,
>   	return 0;
>   }
>   
> +static bool arm_smmu_dev_has_feat(struct device *dev,
> +		enum iommu_dev_features feat)
> +{
> +	if (feat != IOMMU_DEV_FEAT_AUX)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int arm_smmu_dev_enable_feat(struct device *dev,
> +		enum iommu_dev_features feat)
> +{
> +	/* aux domain support is always available */
> +	if (feat == IOMMU_DEV_FEAT_AUX)
> +		return 0;
> +
> +	return -ENODEV;
> +}
> +
> +static int arm_smmu_dev_disable_feat(struct device *dev,
> +		enum iommu_dev_features feat)
> +{
> +	return -EBUSY;
> +}
> +
> +static int arm_smmu_aux_attach_dev(struct iommu_domain *domain,
> +		struct device *dev)
> +{
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +	struct arm_smmu_master_cfg *cfg = dev_iommu_priv_get(dev);
> +	struct arm_smmu_device *smmu = cfg->smmu;
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_cb *cb;
> +	int idx, i, ret, cbndx = -1;
> +
> +	/* Try to find the context bank configured for this device */
> +	for_each_cfg_sme(cfg, fwspec, i, idx) {
> +		if (idx != INVALID_SMENDX) {
> +			cbndx = smmu->s2crs[idx].cbndx;
> +			break;
> +		}
> +	}
> +
> +	if (cbndx == -1)
> +		return -ENODEV;
> +
> +	cb = &smmu->cbs[cbndx];
> +
> +	/* Aux domains are only supported for AARCH64 configurations */
> +	if (cb->cfg->fmt != ARM_SMMU_CTX_FMT_AARCH64)
> +		return -EINVAL;
> +
> +	/* Make sure that TTBR1 is enabled in the hardware */
> +	if ((cb->tcr[0] & ARM_SMMU_TCR_EPD1))
> +		return -EINVAL;
> +
> +	smmu_domain->aux = true;
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = arm_smmu_aux_init_domain_context(domain, smmu, cb->cfg);
> +
> +	arm_smmu_rpm_put(smmu);
> +	return ret;
> +}
> +
>   static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>   {
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> @@ -1653,6 +1836,10 @@ static struct iommu_ops arm_smmu_ops = {
>   	.get_resv_regions	= arm_smmu_get_resv_regions,
>   	.put_resv_regions	= generic_iommu_put_resv_regions,
>   	.def_domain_type	= arm_smmu_def_domain_type,
> +	.dev_has_feat		= arm_smmu_dev_has_feat,
> +	.dev_enable_feat	= arm_smmu_dev_enable_feat,
> +	.dev_disable_feat	= arm_smmu_dev_disable_feat,
> +	.aux_attach_dev		= arm_smmu_aux_attach_dev,
>   	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>   };
>   
> diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
> index c417814f1d98..79d441024043 100644
> --- a/drivers/iommu/arm-smmu.h
> +++ b/drivers/iommu/arm-smmu.h
> @@ -346,6 +346,7 @@ struct arm_smmu_domain {
>   	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>   	struct iommu_domain		domain;
>   	struct device			*dev;	/* Device attached to this domain */
> +	bool				aux;
>   };
>   
>   static inline u32 arm_smmu_lpae_tcr(struct io_pgtable_cfg *cfg)
> 
