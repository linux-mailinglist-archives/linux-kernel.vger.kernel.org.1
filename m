Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630CE2D0E8C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 12:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbgLGK7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:59:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbgLGK7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:59:48 -0500
Date:   Mon, 7 Dec 2020 10:59:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607338747;
        bh=5X4Wa2tCGKFImboi89kNZo+q4agi1Sa5rC9nKY4bhJQ=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=jrzTGziG9p7kWufm4+jEWs1AcM3mYrffolvbVjt22y4jw6bR3+ct20YSRnbiynHtY
         ZKE4tl6T1gvC3TKkkMTo/b8kXbzkCoXXHxURN09nnRyqZFNrEPrEn83Z41+TK1Zqwk
         G/615OmtLz2u9VS2i5XQ0/7GIGsucMsjONeks3mxeOu1f+arJCjNu3kaZUeUFxelQr
         DNGxIeO6iSofrDL7Ns3ta0vdln1BnNkwvVlXYvmKDJTZ/qSrzCa6t+mACfEOgZYdQH
         frsrxtr2ZGwh5MPOQK6sc+0eE+hXtrY1f3UI29nQvj6YO4X00Zq/0NUDIJzW2ji1UD
         dX4ymbMZkAhKg==
From:   Will Deacon <will@kernel.org>
To:     Keqian Zhu <zhukeqian1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, Marc Zyngier <maz@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20201207105900.GB4198@willie-the-truck>
References: <20201205082957.12544-1-zhukeqian1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205082957.12544-1-zhukeqian1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 05, 2020 at 04:29:57PM +0800, Keqian Zhu wrote:
> ... then we have more chance to detect wrong code logic.

This could do with being a bit more explicit. Something like:

	Although handling a mapping request with no permissions is a
	trivial no-op, defer the early return until after the size/range
	checks so that we are consistent with other mapping requests.

> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index a7a9bc08dcd1..8ade72adab31 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -444,10 +444,6 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	arm_lpae_iopte prot;
>  	long iaext = (s64)iova >> cfg->ias;
>  
> -	/* If no access, then nothing to do */
> -	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> -		return 0;
> -
>  	if (WARN_ON(!size || (size & cfg->pgsize_bitmap) != size))
>  		return -EINVAL;
>  
> @@ -456,6 +452,10 @@ static int arm_lpae_map(struct io_pgtable_ops *ops, unsigned long iova,
>  	if (WARN_ON(iaext || paddr >> cfg->oas))
>  		return -ERANGE;
>  
> +	/* If no access, then nothing to do */
> +	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> +		return 0;

This looks sensible to me, but please can you make the same change for
io-pgtable-arm-v7s.c so that the behaviour is consistent across the two
formats?

Thanks,

Will
