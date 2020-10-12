Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC3D28AF04
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgJLHZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:25:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726413AbgJLHZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:25:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87AE0207FF;
        Mon, 12 Oct 2020 07:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602487528;
        bh=J36sJhtxzl7UwDAHdCIhtRxDUhNjAfyMJ6sQVGj2UnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rz8Dixp3suYOT7a8hu+OOevIejnYpmmTdGf5ZZj8ZPLrdKko+VmwJJGyEgYwc2B7t
         Y7jWAO+7YDnhpdyCPoQEuBMrNVSJmAjAP3ReZ81/jaq307ryq9bw5qeMzP2MTxYTFw
         LvH+oUGgFHopPkeH6S7uG53orHm43gayluIGXKV4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kRsD0-000Qzd-EX; Mon, 12 Oct 2020 08:25:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 12 Oct 2020 08:25:26 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     l00484210 <limingwang@huawei.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, fanhenglong@huawei.com,
        wanghaibin.wang@huawei.com, tangnianyao@huawei.com,
        jiangyifei@huawei.com, dengkai1@huawei.com,
        zhang.zhanghailiang@huawei.com, victor.zhangxiaofeng@huawei.com
Subject: Re: [PATCH] arm64: KVM: marking pages as XN in Stage-2 does not care
 about CTR_EL0.DIC
In-Reply-To: <20201012010852.15932-1-limingwang@huawei.com>
References: <20201012010852.15932-1-limingwang@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <47f80f46b9bac66846871b2db32a3f92@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: limingwang@huawei.com, catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, fanhenglong@huawei.com, wanghaibin.wang@huawei.com, tangnianyao@huawei.com, jiangyifei@huawei.com, dengkai1@huawei.com, zhang.zhanghailiang@huawei.com, victor.zhangxiaofeng@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On 2020-10-12 02:08, l00484210 wrote:
> From: MingWang Li <limingwang@huawei.com>
> 
> When testing the ARMv8.2-TTS2UXN feature, setting bits of XN is 
> unavailable.
> Because the control bit CTR_EL0.DIC is set by default on system.
> 
> But when CTR_EL0.DIC is set, software does not need to flush icache 
> actively,
> instead of clearing XN bits.The patch, the commit id of which
> is 6ae4b6e0578886eb36cedbf99f04031d93f9e315, has implemented the 
> function
> of CTR_EL0.DIC.
> 
> Signed-off-by: MingWang Li <limingwang@huawei.com>
> Signed-off-by: Henglong Fan <fanhenglong@huawei.com>
> ---
>  arch/arm64/include/asm/pgtable-prot.h | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable-prot.h
> b/arch/arm64/include/asm/pgtable-prot.h
> index 4d867c6446c4..5feb94882bf7 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -79,17 +79,7 @@ extern bool arm64_use_ng_mappings;
>  		__val;							\
>  	 })
> 
> -#define PAGE_S2_XN							\
> -	({								\
> -		u64 __val;						\
> -		if (cpus_have_const_cap(ARM64_HAS_CACHE_DIC))		\
> -			__val = 0;					\
> -		else							\
> -			__val = PTE_S2_XN;				\
> -		__val;							\
> -	})
> -
> -#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) |
> PTE_S2_RDONLY | PAGE_S2_XN)
> +#define PAGE_S2			__pgprot(_PROT_DEFAULT | PAGE_S2_MEMATTR(NORMAL) |
> PTE_S2_RDONLY | PTE_S2_XN)
>  #define PAGE_S2_DEVICE		__pgprot(_PROT_DEFAULT |
> PAGE_S2_MEMATTR(DEVICE_nGnRE) | PTE_S2_RDONLY | PTE_S2_XN)
> 
>  #define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) |
> PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)

I don't understand what you are trying to achieve here.

This whole point of not setting XN in the page tables when DIC is 
present
is to avoid a pointless permission fault at run time. At you noticed
above, no icache invalidation is necessary. So why would you ever want
to take a fault on exec the first place?

         M.
-- 
Jazz is not dead. It just smells funny...
