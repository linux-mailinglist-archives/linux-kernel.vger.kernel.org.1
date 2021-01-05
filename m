Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981352EA880
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbhAEKVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:21:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45106 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbhAEKVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:21:42 -0500
Received: from zn.tnic (p200300ec2f103700ba0c0ccd6fae6c32.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:3700:ba0c:ccd:6fae:6c32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 31C911EC0324;
        Tue,  5 Jan 2021 11:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609842060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=EVz+m6gjXCXiRGpAA6hb4FVi0ebUcWmcTwsx9IcT4xo=;
        b=JnGPYAnlDzMEVLWBbPU/lENeQXdyjPwSRwR7qYaKT5NT7lGBIhzD+Bi3NqtG1hbfAnLi40
        cDXVyyU9CJzFP8acQfjIWZmwEsIy3R6NhThLIg4H3556Vqimi+caLoF2c+WoEhdqth6vYg
        UtT01IKy62Nj3CCrnB65BhL6xV4yls0=
Date:   Tue, 5 Jan 2021 11:20:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu/amd: Set iommu->int_enabled consistently when
 interrupts are set up
Message-ID: <20210105102056.GA28649@zn.tnic>
References: <20210104132250.GE32151@zn.tnic>
 <20210104232353.GJ32151@zn.tnic>
 <50cd5f55be8ead0937ac315cd2f5b89364f6a9a5.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50cd5f55be8ead0937ac315cd2f5b89364f6a9a5.camel@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 01:32:51AM +0000, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> When I made the INTCAPXT support stop gratuitously pretending to be MSI,
> I missed the fact that iommu_setup_msi() also sets the ->int_enabled
> flag. I missed this in the iommu_setup_intcapxt() code path, which means
> that a resume from suspend will try to allocate the IRQ domains again,
> accidentally re-enabling interrupts as it does, resulting in much sadness.
> 
> Lift out the bit which sets iommu->int_enabled into the iommu_init_irq()
> function which is also where it gets checked.
> 
> Link: https://lore.kernel.org/r/20210104132250.GE32151@zn.tnic/
> Fixes: d1adcfbb520c ("iommu/amd: Fix IOMMU interrupt generation in X2APIC mode")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> There's a possibility we also need to ensure that the actual
> MMIO_INTCAPXT_xxx_OFFSET registers are restored too. Unless you
> actually trigger something to generate faults, you'll never know.
> I don't see offhand how that was working in the pretend-to-be-MSI case
> either.
> 
>  drivers/iommu/amd/init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f54cd79b43e4..6a1f7048dacc 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1973,8 +1973,6 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
>  		return r;
>  	}
>  
> -	iommu->int_enabled = true;
> -
>  	return 0;
>  }
>  
> @@ -2169,6 +2167,7 @@ static int iommu_init_irq(struct amd_iommu *iommu)
>  	if (ret)
>  		return ret;
>  
> +	iommu->int_enabled = true;
>  enable_faults:
>  	iommu_feature_enable(iommu, CONTROL_EVT_INT_EN);
>  
> -- 

Tested-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
