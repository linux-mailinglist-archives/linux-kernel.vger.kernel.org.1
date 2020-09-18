Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A76D26F916
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgIRJVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:21:35 -0400
Received: from foss.arm.com ([217.140.110.172]:36948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726126AbgIRJVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:21:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F0F630E;
        Fri, 18 Sep 2020 02:21:34 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 354E43F68F;
        Fri, 18 Sep 2020 02:21:33 -0700 (PDT)
Date:   Fri, 18 Sep 2020 10:21:28 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Clint Sbisa <csbisa@amazon.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200918092128.GA17967@e121166-lin.cambridge.arm.com>
References: <20200918033312.ddfpibgfylfjpex2@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918033312.ddfpibgfylfjpex2@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 03:33:12AM +0000, Clint Sbisa wrote:
> This change exposes write-combine mappings under sysfs for
> prefetchable PCI resources on arm64.
> 
> Originally, the usage of "write combine" here was driven by the x86
> definition of write combine. This definition is specific to x86 and
> does not generalize to other architectures. However, the usage of WC
> has mutated to "write combine" semantics, which is implemented
> differently on each arch.
> 
> Generally, prefetchable BARs are accepted to allow speculative
> accesses, write combining, and re-ordering-- from the PCI perspective,
> this means there are no read side effects. (This contradicts the PCI
> spec which allows prefetchable BARs to have read side effects, but
> this definition is ill-advised as it is impossible to meet.) On x86,
> prefetchable BARs are mapped as WC as originally defined (with some
> conditionals on arch features). On arm64, WC is taken to mean normal
> non-cacheable memory.
> 
> In practice, write combine semantics are used to minimize write
> operations. A common usage of this is minimizing PCI TLPs which can
> significantly improve performance with PCI devices. In order to
> provide the same benefits to userspace, we need to allow userspace to
> map prefetchable BARs with write combine semantics. The resourceX_wc
> mapping is used today by userspace programs and libraries.
> 
> While this model is flawed as "write combine" is very ill-defined, it
> is already used by multiple non-x86 archs to expose write combine
> semantics to user space. We enable this on arm64 to give userspace on
> arm64 an equivalent mechanism for utilizing write combining with PCI
> devices.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Bjorn Helgaas <helgaas@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> ---
> Changes in v2:
>   - Rewrote the commit message.
> 
>  arch/arm64/include/asm/pci.h | 1 +
>  1 file changed, 1 insertion(+)

It would be great if we can add a link to the thread (sorry I forgot to
tell you) for future reference:

Link: https://lore.kernel.org/linux-pci/20200902113207.GA27676@e121166-lin.cambridge.arm.com

With that:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index 70b323cf8300..b33ca260e3c9 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -17,6 +17,7 @@
>  #define pcibios_assign_all_busses() \
>  	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
>  
> +#define arch_can_pci_mmap_wc() 1
>  #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
>  
>  extern int isa_dma_bridge_buggy;
> -- 
> 2.23.3
> 
