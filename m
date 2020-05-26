Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911031ACE5F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 19:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405103AbgDPRFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 13:05:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbgDPRFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:05:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E88F20732;
        Thu, 16 Apr 2020 17:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587056744;
        bh=yvKxJ0oqI8tAb7XGYBeopy2h/oK1YUZKnUOgcn1sW7c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=effOu2XiYpIAUEIWQ3do9dPFE/zgnIpN5HBFfHEl1XFwI3GcIBF2htju2SYwTBLtu
         0GqtALsJONiT8hngxN44EXw49w6kRbEHeyskiG39W8gTZizvMt0xUkNi0wESbALG1A
         2JSJFebvJDi0kg/wkOVlvAh9KPgP0Paf2LpAfHJA=
Date:   Thu, 16 Apr 2020 18:05:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] KVM: arm64: Drop PTE_S2_MEMATTR_MASK
Message-ID: <20200416170539.GC32685@willie-the-truck>
References: <20200415105746.314-1-yuzenghui@huawei.com>
 <20200416163605.091fa6eb@why>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416163605.091fa6eb@why>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 04:36:05PM +0100, Marc Zyngier wrote:
> On Wed, 15 Apr 2020 18:57:46 +0800
> Zenghui Yu <yuzenghui@huawei.com> wrote:
> 
> > The only user of PTE_S2_MEMATTR_MASK macro had been removed since
> > commit a501e32430d4 ("arm64: Clean up the default pgprot setting").
> > It has been about six years and no one has used it again.
> > 
> > Let's drop it.
> > 
> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > ---
> >  arch/arm64/include/asm/pgtable-hwdef.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
> > index 6bf5e650da78..99315bdca0e6 100644
> > --- a/arch/arm64/include/asm/pgtable-hwdef.h
> > +++ b/arch/arm64/include/asm/pgtable-hwdef.h
> > @@ -190,7 +190,6 @@
> >   * Memory Attribute override for Stage-2 (MemAttr[3:0])
> >   */
> >  #define PTE_S2_MEMATTR(t)	(_AT(pteval_t, (t)) << 2)
> > -#define PTE_S2_MEMATTR_MASK	(_AT(pteval_t, 0xf) << 2)
> >  
> >  /*
> >   * EL2/HYP PTE/PMD definitions
> 
> Looks good to me. Catalin, Will: do you want to take this directly? If
> so please add my:
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> 
> Otherwise, I'll route it via the KVM tree.

I can take it for 5.8 if it's not urgent.

Will
