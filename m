Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26D62CECD8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgLDLOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:56490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730007AbgLDLOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:14:33 -0500
Date:   Fri, 4 Dec 2020 11:13:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607080433;
        bh=enaPqvFSZYwkrwi8cQ39U611krzuHcmjaLAOJCcEdWA=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=LWQeM+hqSApsA1cwu0COKWySugNBlvgRlsWxKmwcwZIuXPNEaFAZInavrkcLxgPBi
         bNyDR/tLUNP5UdFyuFe9R5Bc5G14yZvSgAfDo1f3rX59sWjLCEy5qrO+c01VZ2pfrJ
         1Kng5b0RiV3oufAgQFjIUCwkAJwBsHc5bc4HThK8LADEqHv9aTi1cb24mf/FvNURmR
         JTmh97mcCHygtuYJVkLTLBc2v8oizzFdE7mXhi9+pfVEHQ+FKgPAET4vWSt+l1SgzE
         YeBoQtG8uPD8/xaRP5pv4AyQzc+pxUjGMp1fAGm/G05/z1oODBoS3sy+WJYvk2Qela
         PKBmzxlnQvheA==
From:   Will Deacon <will@kernel.org>
To:     Wei Li <liwei213@huawei.com>
Cc:     catalin.marinas@arm.com, rppt@linux.ibm.com,
        fengbaopeng2@hisilicon.com, nsaenzjulienne@suse.de,
        steve.capper@arm.com, song.bao.hua@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        butao@hisilicon.com
Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the
 memory reserved for the page map
Message-ID: <20201204111347.GA844@willie-the-truck>
References: <20201204014443.43329-1-liwei213@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201204014443.43329-1-liwei213@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:44:43AM +0800, Wei Li wrote:
> For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> do not free the reserved memory for the page map, decrease the section
> size can reduce the waste of reserved memory.
> 
> Signed-off-by: Wei Li <liwei213@huawei.com>
> Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
> Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
> ---
>  arch/arm64/include/asm/sparsemem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
> index 1f43fcc79738..8963bd3def28 100644
> --- a/arch/arm64/include/asm/sparsemem.h
> +++ b/arch/arm64/include/asm/sparsemem.h
> @@ -7,7 +7,7 @@
> 
>  #ifdef CONFIG_SPARSEMEM
>  #define MAX_PHYSMEM_BITS	CONFIG_ARM64_PA_BITS
> -#define SECTION_SIZE_BITS	30
> +#define SECTION_SIZE_BITS	27

We chose '30' to avoid running out of bits in the page flags. What changed?

With this patch, I can trigger:

./include/linux/mmzone.h:1170:2: error: Allocator MAX_ORDER exceeds SECTION_SIZE
#error Allocator MAX_ORDER exceeds SECTION_SIZE

if I bump up NR_CPUS and NODES_SHIFT.

Will
