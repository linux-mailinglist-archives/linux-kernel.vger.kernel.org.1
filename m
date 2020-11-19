Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870D02B9941
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgKSRZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:25:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbgKSRZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:25:30 -0500
Received: from gaia (unknown [2.26.170.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF362468B;
        Thu, 19 Nov 2020 17:25:26 +0000 (UTC)
Date:   Thu, 19 Nov 2020 17:25:24 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        Chen Zhou <chenzhou10@huawei.com>, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        ardb@kernel.org, iommu@lists.linux-foundation.org,
        robh+dt@kernel.org, James Morse <james.morse@arm.com>,
        linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
        will@kernel.org, hch@lst.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
Message-ID: <20201119172523.GG4376@gaia>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
 <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
 <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
 <X6rZRvWyigCJxAVW@trantor>
 <b5336064145a30aadcfdb8920226a8c63f692695.camel@suse.de>
 <20201113112901.GA3212@gaia>
 <ba343af12fc60bce36837cc090a39c9e42457788.camel@suse.de>
 <20201119171048.GD4376@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119171048.GD4376@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 05:10:49PM +0000, Catalin Marinas wrote:
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index ed71b1c305d7..acdec0c67d3b 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -469,6 +469,21 @@ void __init mark_linear_text_alias_ro(void)
>  			    PAGE_KERNEL_RO);
>  }
>  
> +static bool crash_mem_map __initdata;
> +
> +static int __init enable_crash_mem_map(char *arg)
> +{
> +	/*
> +	 * Proper parameter parsing is done by reserve_crashkernel(). We only
> +	 * need to know if the linear map has to avoid block mappings so that
> +	 * the crashkernel reservations can be unmapped later.
> +	 */
> +	crash_mem_map = false;

It should be set to true.

-- 
Catalin
