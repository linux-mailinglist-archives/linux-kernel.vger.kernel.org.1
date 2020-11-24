Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FAE2C2399
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgKXLF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:05:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:32884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731911AbgKXLF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:05:27 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A41B20708;
        Tue, 24 Nov 2020 11:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606215927;
        bh=p7cS0enyaISQXUsFbBkJBL1aoa2MlX33h5/J260iXIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F3SBAmZRTb54N/YAxmPu1vt5vCXgqcUrDxC/I6tq4FoRWdxlhKAXh24e2A3yq6vzm
         BgHxbhukrj9r3LrDIPXIc3Mwe2Guh38i3iRJEe4ZQjjNxebY2oBWMFXYq3afwnmKfK
         THIyImd3gme1xi91jEdzIxGCeTTwpRkoTNsv8iK8=
Date:   Tue, 24 Nov 2020 11:05:21 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
Message-ID: <20201124110520.GA12980@willie-the-truck>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
 <20201123123258.GC10233@willie-the-truck>
 <1606209884.26323.132.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606209884.26323.132.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 05:24:44PM +0800, Yong Wu wrote:
> On Mon, 2020-11-23 at 12:32 +0000, Will Deacon wrote:
> > On Fri, Nov 20, 2020 at 05:06:28PM +0800, Yong Wu wrote:
> > > +				unmapped_sz = 0;
> > > +			}
> > > +			start += pg_size;
> > > +		}
> > > +		if (unmapped_sz) {
> > > +			ret = iommu_map(domain, start, start, unmapped_sz,
> > > +					entry->prot);
> > 
> > Can you avoid this hunk by changing your loop check to something like:
> > 
> > 	if (!phys_addr) {
> > 		map_size += pg_size;
> > 		if (addr + pg_size < end)
> > 			continue;
> > 	}
> 
> Thanks for your quick review. I have fixed and tested it. the patch is
> simple. I copy it here. Is this readable for you now?
> 
> 
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -737,6 +737,7 @@ static int
> iommu_create_device_direct_mappings(struct iommu_group *group,
>  	/* We need to consider overlapping regions for different devices */
>  	list_for_each_entry(entry, &mappings, list) {
>  		dma_addr_t start, end, addr;
> +		size_t map_size = 0;
>  
>  		if (domain->ops->apply_resv_region)
>  			domain->ops->apply_resv_region(dev, domain, entry);
> @@ -752,12 +753,21 @@ static int
> iommu_create_device_direct_mappings(struct iommu_group *group,
>  			phys_addr_t phys_addr;
>  
>  			phys_addr = iommu_iova_to_phys(domain, addr);
> -			if (phys_addr)
> -				continue;
> +			if (!phys_addr) {
> +				map_size += pg_size;
> +				if (addr + pg_size < end)
> +					continue;
> +				else

You don't need the 'else' here  ^^^

> +					addr += pg_size; /*Point to End */

addr = end ?

That said, maybe we could simplify this further by changing the loop bounds
to be:

	for (addr = start; addr <= end; addr += pg_size)

and checking:

	if (!phys_addr && addr != end) {
		map_size += pg_size;
		continue;
	}

does that work?

Will
