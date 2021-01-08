Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9E02EF707
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbhAHSJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:09:59 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:45844 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAHSJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:09:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610129378; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0i7L7jWu8aynDM0LkuyTLjoMUIf8WxyfzKh7T7CAFJI=;
 b=XhcN2sQSQXp88dyhNFcFHfT4PuwB/DCLTt3LTkBd7r5LGsQyuwSmyp9fdyXTeojfW/Yl4L4e
 J4o5zvrDibAEgEsH04QbUDaW16yqCY9gyZPa9M299+Ayh9tgEzOqDs6NSbW+LA/MPLTK9AYI
 1L9cd5XL5h8HNVP/32FutdmqKms=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5ff89fc89ee5cdb92c93912e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 08 Jan 2021 18:09:12
 GMT
Sender: isaacm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D5291C43461; Fri,  8 Jan 2021 18:09:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: isaacm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D454EC433C6;
        Fri,  8 Jan 2021 18:09:10 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Jan 2021 10:09:10 -0800
From:   isaacm@codeaurora.org
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Will Deacon <will@kernel.org>, Rob Clark <robdclark@gmail.com>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/io-pgtable-arm: Allow non-coherent masters to use
 system cache
In-Reply-To: <8cfefbff135a5287d177b6ab2ccc3304@codeaurora.org>
References: <20201224064007.2339-1-saiprakash.ranjan@codeaurora.org>
 <20210106115615.GA1763@willie-the-truck>
 <cfced52002337025088a64aa159760b2@codeaurora.org>
 <8cfefbff135a5287d177b6ab2ccc3304@codeaurora.org>
Message-ID: <84ff10c38e99635bc222ca2dd29be2b5@codeaurora.org>
X-Sender: isaacm@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-07 21:47, Sai Prakash Ranjan wrote:
> On 2021-01-07 22:27, isaacm@codeaurora.org wrote:
>> On 2021-01-06 03:56, Will Deacon wrote:
>>> On Thu, Dec 24, 2020 at 12:10:07PM +0530, Sai Prakash Ranjan wrote:
>>>> commit ecd7274fb4cd ("iommu: Remove unused IOMMU_SYS_CACHE_ONLY 
>>>> flag")
>>>> removed unused IOMMU_SYS_CACHE_ONLY prot flag and along with it went
>>>> the memory type setting required for the non-coherent masters to use
>>>> system cache. Now that system cache support for GPU is added, we 
>>>> will
>>>> need to mark the memory as normal sys-cached for GPU to use system 
>>>> cache.
>>>> Without this, the system cache lines are not allocated for GPU. We 
>>>> use
>>>> the IO_PGTABLE_QUIRK_ARM_OUTER_WBWA quirk instead of a page 
>>>> protection
>>>> flag as the flag cannot be exposed via DMA api because of no in-tree
>>>> users.
>>>> 
>>>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>>>> ---
>>>>  drivers/iommu/io-pgtable-arm.c | 3 +++
>>>>  1 file changed, 3 insertions(+)
>>>> 
>>>> diff --git a/drivers/iommu/io-pgtable-arm.c 
>>>> b/drivers/iommu/io-pgtable-arm.c
>>>> index 7c9ea9d7874a..3fb7de8304a2 100644
>>>> --- a/drivers/iommu/io-pgtable-arm.c
>>>> +++ b/drivers/iommu/io-pgtable-arm.c
>>>> @@ -415,6 +415,9 @@ static arm_lpae_iopte 
>>>> arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>>>>  		else if (prot & IOMMU_CACHE)
>>>>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>>>>  				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>> +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
>>>> +			pte |= (ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE
>>>> +				<< ARM_LPAE_PTE_ATTRINDX_SHIFT);
>>>>  	}
>>> 
>> While this approach of enabling system cache globally for both page
>> tables and other buffers
>> works for the GPU usecase, this isn't ideal for other clients that use
>> system cache. For example,
>> video clients only want to cache a subset of their buffers in the
>> system cache, due to the sizing constraint
>> imposed by how much of the system cache they can use. So, it would be
>> ideal to have
>> a way of expressing the desire to use the system cache on a per-buffer
>> basis. Additionally,
>> our video clients use the DMA layer, and since the requirement is for
>> caching in the system cache
>> to be a per buffer attribute, it seems like we would have to have a
>> DMA attribute to express
>> this on a per-buffer basis.
>> 
> 
> I did bring this up initially [1], also where is this video client
> in upstream? AFAIK, only system cache user in upstream is GPU.
> We cannot add any DMA attribute unless there is any user upstream
Right, there wouldn't be an upstream user, which would be problematic,
but I was thinking of having it so that when video or any of our other
clients that use this attribute on a per buffer basis upstreams their
code, it's not too much of a stretch to add the support.
> as per [2], so when the support for such a client is added, wouldn't
> ((data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA) || PROT_FLAG)
> work?
I don't think that will work, because we currently have clients who use 
the
system cache as follows:
-cache only page tables in the system cache
-cache only data buffers in the system cache
-cache both page tables and all buffers in the system cache
-cache both page tables and some buffers in the system cache

The approach you're suggesting doesn't allow for the last case, as 
caching the
page tables in the system cache involves setting 
IO_PGTABLE_QUIRK_ARM_OUTER_WBWA,
so we will end up losing the flexibility to cache some data buffers in 
the system cache.

Ideally, the page table quirk would drive the settings for the TCR, and 
the prot flag
drives the PTE for the mapping, as is done with the page table walker 
being dma-coherent,
while buffers are mapped as cacheable based on IOMMU_CACHE. Thoughts?

Thanks,
Isaac
> 
> [1]
> https://lore.kernel.org/dri-devel/ecfda7ca80f6d7b4ff3d89b8758f4dc9@codeaurora.org/
> [2] 
> https://lore.kernel.org/linux-iommu/20191026053026.GA14545@lst.de/T/
> 
> Thanks,
> Sai
