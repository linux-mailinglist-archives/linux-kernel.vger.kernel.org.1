Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442D72D0DF7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgLGKZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:25:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLGKZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:25:43 -0500
Date:   Mon, 7 Dec 2020 10:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607336703;
        bh=D4jvLiuo5MBwNTSdal71W3VOvzvsyAS1r5K6BlDOzNU=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cy4Whju3D3VrIcAcqnFEQuLw3LvJoXbI4U4WtTfD47xpDQx2xYnP3hkF8/mIWL/sA
         YFZ+iaFHLh3pPvHkebEHDl+19UwZPL3UdCY1ofbUv1jqxV82sTg4sqwArY5IPTVSQj
         lnE6ntCsmo7KEz2WvbKkOn4nAPEZXdUQk9oFz8m33uQ23C09LcTvU3lsCBfP0BM29X
         kSj8wmY73QVOHVJuR2t2exNhVEL3sSPa289ORAx7hb4CuJex5SFKjY08S1xJVPfVCH
         mgzoLMcwigRd0mA8vMs67wnu5wCeT5IJmf2r6/QK3OOKMoP3DhFDi2n3YDBuRzzGrm
         4L3LjjjFHgytA==
From:   Will Deacon <will@kernel.org>
To:     Kunkun Jiang <jiangkunkun@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        wanghaibin.wang@huawei.com, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH] iommu/io-pgtalbe-arm: Remove "iopte_type(pte, l)" extra
 parameter "l"
Message-ID: <20201207102458.GB3825@willie-the-truck>
References: <20201207081404.1699-1-jiangkunkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207081404.1699-1-jiangkunkun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 04:14:04PM +0800, Kunkun Jiang wrote:
> Knowing from the code, the macro "iopte_type(pte, l)" doesn't use the
> parameter "l" (level). So we'd better to remove it.
> 
> Fixes: e1d3c0fd701df(iommu: add ARM LPAE page table allocator)
> Signed-off-by: Kunkun Jiang <jiangkunkun@huawei.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a7a9bc08dcd1..925ae2b713d6 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -130,7 +130,7 @@
>  /* IOPTE accessors */
>  #define iopte_deref(pte,d) __va(iopte_to_paddr(pte, d))
>  
> -#define iopte_type(pte,l)					\
> +#define iopte_type(pte)					\
>  	(((pte) >> ARM_LPAE_PTE_TYPE_SHIFT) & ARM_LPAE_PTE_TYPE_MASK)

Shouldn't we update all the users of the macro too?

Will
