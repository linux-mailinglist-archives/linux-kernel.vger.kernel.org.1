Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D369D2B2CED
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 12:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgKNLrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 06:47:23 -0500
Received: from z5.mailgun.us ([104.130.96.5]:16028 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbgKNLrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 06:47:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605354439; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2ACjG5AA5nsCiuFuVXOZWR9ZUdK6+vR84LMxY+8aTV0=;
 b=WdKbXwEhhC7d38cej/CEcS38y61lJOhLQzUPrx98y83nSHVmO1EOBzgtS+6xN2HgfJntbYty
 o6xZYoyYv4MJourYGgHu0q64k7caiQcHbWu/FMl994ljufiSNvMmRbU0BRqLLAoKruyllnH9
 rX8MKC1rxC1gnkXrn+LvOqjAY1E=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5fafc3bf8e090a8886916d9f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 14 Nov 2020 11:47:11
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B8A4C43385; Sat, 14 Nov 2020 11:47:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 030CEC433C6;
        Sat, 14 Nov 2020 11:47:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 14 Nov 2020 17:17:09 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        freedreno@lists.freedesktop.org,
        "Kristian H . Kristensen" <hoegsberg@google.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCHv7 2/7] iommu/arm-smmu: Add domain attribute for system
 cache
In-Reply-To: <20201112093547.GA19049@willie-the-truck>
References: <cover.1604048969.git.saiprakash.ranjan@codeaurora.org>
 <a4e454630e57aedd9da6a4ba40c8e1c415bb6836.1604048969.git.saiprakash.ranjan@codeaurora.org>
 <20201110121835.GC16239@willie-the-truck>
 <b12284cce40225274c3b2d9aff7eed3a@codeaurora.org>
 <20201112093547.GA19049@willie-the-truck>
Message-ID: <17b1827f76efc277ae8a9dbfd82fe536@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-12 15:05, Will Deacon wrote:
> On Wed, Nov 11, 2020 at 12:10:50PM +0530, Sai Prakash Ranjan wrote:
>> On 2020-11-10 17:48, Will Deacon wrote:
>> > On Fri, Oct 30, 2020 at 02:53:09PM +0530, Sai Prakash Ranjan wrote:
>> > > Add iommu domain attribute for using system cache aka last level
>> > > cache by client drivers like GPU to set right attributes for caching
>> > > the hardware pagetables into the system cache.
>> > >
>> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> > > ---
>> > >  drivers/iommu/arm/arm-smmu/arm-smmu.c | 17 +++++++++++++++++
>> > >  drivers/iommu/arm/arm-smmu/arm-smmu.h |  1 +
>> > >  include/linux/iommu.h                 |  1 +
>> > >  3 files changed, 19 insertions(+)
>> > >
>> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> > > b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> > > index b1cf8f0abc29..070d13f80c7e 100644
>> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>> > > @@ -789,6 +789,9 @@ static int arm_smmu_init_domain_context(struct
>> > > iommu_domain *domain,
>> > >  	if (smmu_domain->non_strict)
>> > >  		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_NON_STRICT;
>> > >
>> > > +	if (smmu_domain->sys_cache)
>> > > +		pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_SYS_CACHE;
>> > > +
>> > >  	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
>> > >  	if (!pgtbl_ops) {
>> > >  		ret = -ENOMEM;
>> > > @@ -1520,6 +1523,9 @@ static int arm_smmu_domain_get_attr(struct
>> > > iommu_domain *domain,
>> > >  		case DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE:
>> > >  			*(int *)data = smmu_domain->non_strict;
>> > >  			return 0;
>> > > +		case DOMAIN_ATTR_SYS_CACHE:
>> > > +			*((int *)data) = smmu_domain->sys_cache;
>> > > +			return 0;
>> > >  		default:
>> > >  			return -ENODEV;
>> > >  		}
>> > > @@ -1551,6 +1557,17 @@ static int arm_smmu_domain_set_attr(struct
>> > > iommu_domain *domain,
>> > >  			else
>> > >  				smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>> > >  			break;
>> > > +		case DOMAIN_ATTR_SYS_CACHE:
>> > > +			if (smmu_domain->smmu) {
>> > > +				ret = -EPERM;
>> > > +				goto out_unlock;
>> > > +			}
>> > > +
>> > > +			if (*((int *)data))
>> > > +				smmu_domain->sys_cache = true;
>> > > +			else
>> > > +				smmu_domain->sys_cache = false;
>> > > +			break;
>> > >  		default:
>> > >  			ret = -ENODEV;
>> > >  		}
>> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> > > b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> > > index 885840f3bec8..dfc44d806671 100644
>> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
>> > > @@ -373,6 +373,7 @@ struct arm_smmu_domain {
>> > >  	struct mutex			init_mutex; /* Protects smmu pointer */
>> > >  	spinlock_t			cb_lock; /* Serialises ATS1* ops and TLB syncs */
>> > >  	struct iommu_domain		domain;
>> > > +	bool				sys_cache;
>> > >  };
>> > >
>> > >  struct arm_smmu_master_cfg {
>> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> > > index b95a6f8db6ff..4f4bb9c6f8f6 100644
>> > > --- a/include/linux/iommu.h
>> > > +++ b/include/linux/iommu.h
>> > > @@ -118,6 +118,7 @@ enum iommu_attr {
>> > >  	DOMAIN_ATTR_FSL_PAMUV1,
>> > >  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
>> > >  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
>> > > +	DOMAIN_ATTR_SYS_CACHE,
>> >
>> > I think you're trying to make this look generic, but it's really not.
>> > If we need to funnel io-pgtable quirks through domain attributes, then I
>> > think we should be open about that and add something like
>> > DOMAIN_ATTR_IO_PGTABLE_CFG which could take a struct of page-table
>> > configuration data for the domain (this could just be quirks initially,
>> > but maybe it's worth extending to take ias, oas and page size)
>> >
>> 
>> Actually the initial versions used DOMAIN_ATTR_QCOM_SYS_CACHE
>> to make it QCOM specific and not generic, I don't see anyone else
>> using this attribute, would that work?
> 
> No -- I'd prefer to have _one_ domain attribute for funneling all the
> IP_PGTABLE_CFG data. Otherwise, we'll just end up with things like
> DOMAIN_ATTR_QCOM_SYS_CACHE_EXT or DOMAIN_ATTR_QCOM_QUIRKS later on.
> 

Right, that makes sense. I will add this in next version.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
