Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD1C2D1010
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgLGMGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:06:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:38578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726840AbgLGMGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:06:14 -0500
Date:   Mon, 7 Dec 2020 12:05:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607342733;
        bh=xYecpIocncYbomw151SJIMvBkPsNpdC8hHd472+icVw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6pwNfChCGfEwJgZDaxOPHG38w9DWpq6iTj5WODngrXSZTnR/zZIR1ybJwAKOK96O
         eNVCDCdxh/MFbRkVEtl9g9AuV33pDZpktiuIyX5Us/43J7fpbreJ1InBv01aRopTjJ
         3c2mkN/qfPCqvrReEg4ZOB5vuhhP3EqknFaAkDQ21GTgGAzyQ93a5Fn+TD3uXsjSuu
         wpqNSqiDXWJb3l6nFlgGE1wpC9SlObbPJnBPfu5uNyKrMZw6hYKX1RN6DZ3nyr6fcZ
         uCZo08hhXvMqfzBV4JbKxQpO7GX0/2TBjDGrdG9X/GfDn5jV11ugt4hUQie1cQurUt
         AfkL/90K4KKkg==
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Marc Zyngier <maz@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        wanghaibin.wang@huawei.com, jiangkunkun@huawei.com
Subject: Re: [PATCH] iommu: Up front sanity check in the arm_lpae_map
Message-ID: <20201207120527.GA4474@willie-the-truck>
References: <20201205082957.12544-1-zhukeqian1@huawei.com>
 <b85e98c8-0117-49c5-97ad-896ff88f7b88@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85e98c8-0117-49c5-97ad-896ff88f7b88@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 12:01:09PM +0000, Robin Murphy wrote:
> On 2020-12-05 08:29, Keqian Zhu wrote:
> > ... then we have more chance to detect wrong code logic.
> 
> I don't follow that justification - it's still the same check with the same
> outcome, so how does moving it have any effect on the chance to detect
> errors?
> 
> AFAICS the only difference it would make is to make some errors *less*
> obvious - if a sufficiently broken caller passes an empty prot value
> alongside an invalid size or already-mapped address, this will now quietly
> hide the warnings from the more serious condition(s).
> 
> Yes, it will bail out a bit faster in the specific case where the prot value
> is the only thing wrong, but since when do we optimise for fundamentally
> incorrect API usage?

I thought it was the other way round -- doesn't this patch move the "empty
prot" check later, so we have a chance to check the size and addresses
first?

Will

> > Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index a7a9bc08dcd1..8ade72adab31 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -444,10 +444,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
> >   	arm_lpae_iopte prot;
> >   	long iaext = (s64)iova >> cfg->ias;
> > -	/* If no access, then nothing to do */
> > -	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> > -		return 0;
> > -
> >   	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
> >   		return -EINVAL;
> > @@ -456,6 +452,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
> >   	if (WARN_ON(iaext || paddr >> cfg->oas))
> >   		return -ERANGE;
> > +	/* If no access, then nothing to do */
> > +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> > +		return 0;
> > +
> >   	prot = arm_lpae_prot_to_pte(data, iommu_prot);
> >   	ret = __arm_lpae_map(data, iova, paddr, size, prot, lvl, ptep, gfp);
> >   	/*
> > 
