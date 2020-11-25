Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954E32C3ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgKYLNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:13:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:35492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgKYLNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:13:08 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FECF206B7;
        Wed, 25 Nov 2020 11:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606302788;
        bh=rbevIJAsSB/iRPD2vJR1nkW2xROzISyxEwaJMCSnkso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uahWelgQafXjRsuI496JVdUNxkEZm3JksQ9wJ1cwLh6puVI2ye4SNLrtruQL4fU4V
         UwWTo+hCjkW7fqNmMG4Qi6yOj6GcqoKnuediWkLgQ0DfOEXU/BVkN87icfKT45+m8X
         l9QM/ksIyV6ERAwsQpKuBYGIddyhVWQ4oOhKWgaA=
Date:   Wed, 25 Nov 2020 11:13:02 +0000
From:   Will Deacon <will@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     youlin.pei@mediatek.com, anan.sun@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream@mediatek.com, chao.hao@mediatek.com,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu: Improve the performance for direct_mapping
Message-ID: <20201125111301.GB15239@willie-the-truck>
References: <20201120090628.6566-1-yong.wu@mediatek.com>
 <20201123123258.GC10233@willie-the-truck>
 <1606209884.26323.132.camel@mhfsdcap03>
 <20201124110520.GA12980@willie-the-truck>
 <1606302214.26323.141.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1606302214.26323.141.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 07:03:34PM +0800, Yong Wu wrote:
> On Tue, 2020-11-24 at 11:05 +0000, Will Deacon wrote:
> > On Tue, Nov 24, 2020 at 05:24:44PM +0800, Yong Wu wrote:
> > > On Mon, 2020-11-23 at 12:32 +0000, Will Deacon wrote:
> > That said, maybe we could simplify this further by changing the loop bounds
> > to be:
> > 
> > 	for (addr = start; addr <= end; addr += pg_size)
> > 
> > and checking:
> > 
> > 	if (!phys_addr && addr != end) {
> > 		map_size += pg_size;
> > 		continue;
> > 	}
> > 
> > does that work?
> 
> It works but I think we can not check iommu_iova_to_phys(domain, end).
> We should add a "if", like:
> 
> for (addr = start; addr <= end; addr += pg_size) {
> ...
> 	if (addr < end) {
> 		phys_addr = iommu_iova_to_phys(domain, addr);
> 		if (!phys_addr) {
> 			map_size += pg_size;
> 			continue;
> 		}
> 	}
> ...
> 

Oh yes, you're right.

> If you don't like this "if (addr < end)", then we have to add a "goto".
> like this:
> 
> 
> for (addr = start; addr <= end; addr += pg_size) {
>  	phys_addr_t phys_addr;
>  
> 	if (addr == end)
> 		goto map_last;
> 
> 	phys_addr = iommu_iova_to_phys(domain, addr);
> 	if (!phys_addr) {
> 		map_size += pg_size;
> 		continue;
> 	}
> 
> map_last:
> 	if (!map_size)
> 		continue;
> 	ret = iommu_map(domain, addr - map_size,
> 			addr - map_size, map_size, entry->prot);

I think it's cleared to invert this as you had before:

	if (map_size)
		ret = iommu_map(...);

> Which one is better?

The second one is easier to read. I'll stop making suggestions now, thanks.

Will
