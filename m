Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA12ED059
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbhAGNEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:04:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:54410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728140AbhAGNEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:04:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12F6722D01;
        Thu,  7 Jan 2021 13:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610024604;
        bh=GfXmkqoELy/f9VuG/jwzCEOi96GnRIiD/hBd6Kv7aZs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aNhNwduW7Bg+R6qpPnF4Fq0VsiF2LfWeRBt+esJh1uVeUagrdZBEELfG85NXoiz0z
         thcm7Ygu/Xfdsrw/wLEiIDnrzqFSwb3Y1xwcARMmlx7eNboKJfDRgxZZwsGp1OIH6A
         kE6gmllZqZB1mUNkDOJ6yd3o1EmsL0HANMbACyuIHcD8kgeLC0Qjxc9A99fFdw2fsw
         pOePow6JWtEW5zFXk/zv4Ru4zlnF01wtWh4S/kJovjk4xpYd4vfD13Jspe4kTMsCez
         FTazW/3YzmYXr+9M+7rONP3e/w9T9esoC6PhhM14U1hNOXizdjVRVY067qQnzs7axF
         aHWn0xT9+JCiA==
Date:   Thu, 7 Jan 2021 13:03:19 +0000
From:   Will Deacon <will@kernel.org>
To:     Ajay Kumar <ajaykumar.rs@samsung.com>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, robh+dt@kernel.org, mark.rutland@arm.com,
        robin.murphy@arm.com, john.garry@huawei.com
Subject: Re: [PATCH] iommu/arm-smmu-v3: Handle duplicated Stream IDs from
 other masters
Message-ID: <20210107130319.GA2986@willie-the-truck>
References: <CGME20210107092826epcas5p100f2c57a63715baa2b3fa7219ab58c7b@epcas5p1.samsung.com>
 <20210107093340.15279-1-ajaykumar.rs@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107093340.15279-1-ajaykumar.rs@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 03:03:40PM +0530, Ajay Kumar wrote:
> When PCI function drivers(ex:pci-endpoint-test) are probed for already
> initialized PCIe-RC(Root Complex), and PCIe-RC is already bound to SMMU,
> then we encounter a situation where the function driver tries to attach
> itself to the smmu with the same stream-id as PCIe-RC and re-initialize
> an already initialized STE. This causes ste_live BUG_ON() in the driver.

I don't understand why the endpoint is using the same stream ID as the root
complex in this case. Why is that? Is the grouping logic not working
properly?

> There is an already existing check in the driver to manage duplicated ids
> if duplicated ids are added in same master device, but there can be
> scenarios like above where we need to extend the check for other masters
> using the same stream-id.
> 
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 33 +++++++++++++++++++++
>  1 file changed, 33 insertions(+)

It doesn't feel like the driver is the right place to fix this, as the same
issue could surely occur for other IOMMUs too, right? In which case, I think
we should avoid getting into the situation where different groups have
overlapping stream IDs.

Will
