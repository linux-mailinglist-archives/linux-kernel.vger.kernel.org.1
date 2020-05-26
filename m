Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDF201ACEA4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392691AbgDPRYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 13:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgDPRYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:24:32 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FC712076D;
        Thu, 16 Apr 2020 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587057871;
        bh=UxgHHt2NeWIhftpv8xNENijT4Gukwwyzyg1IRpvLXzs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g1SBH/S1xjhAVDsIoJ0zw1ZDNL0B3F+hLnuVxkY0fnxebNuSDImVx3u6mOare9YCA
         4B8XIu+02w2z06xNZ3ECpop9c9DrFCr6MsrodIv2FEw++3Tiw2obZ+NiGHxKOlH1C8
         IixQNKpOrpGBopT59Ex7iKaDWHehGvM/AxMQqaoY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jP8FZ-003x8f-Od; Thu, 16 Apr 2020 18:24:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Apr 2020 18:24:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Zenghui Yu <yuzenghui@huawei.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] KVM: arm64: Drop PTE_S2_MEMATTR_MASK
In-Reply-To: <20200416170539.GC32685@willie-the-truck>
References: <20200415105746.314-1-yuzenghui@huawei.com>
 <20200416163605.091fa6eb@why> <20200416170539.GC32685@willie-the-truck>
Message-ID: <1248b9b0922a2c2886650f5bacadf1af@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, catalin.marinas@arm.com, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-16 18:05, Will Deacon wrote:
> On Thu, Apr 16, 2020 at 04:36:05PM +0100, Marc Zyngier wrote:
>> On Wed, 15 Apr 2020 18:57:46 +0800
>> Zenghui Yu <yuzenghui@huawei.com> wrote:
>> 
>> > The only user of PTE_S2_MEMATTR_MASK macro had been removed since
>> > commit a501e32430d4 ("arm64: Clean up the default pgprot setting").
>> > It has been about six years and no one has used it again.
>> >
>> > Let's drop it.
>> >
>> > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> > ---
>> >  arch/arm64/include/asm/pgtable-hwdef.h | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/include/asm/pgtable-hwdef.h b/arch/arm64/include/asm/pgtable-hwdef.h
>> > index 6bf5e650da78..99315bdca0e6 100644
>> > --- a/arch/arm64/include/asm/pgtable-hwdef.h
>> > +++ b/arch/arm64/include/asm/pgtable-hwdef.h
>> > @@ -190,7 +190,6 @@
>> >   * Memory Attribute override for Stage-2 (MemAttr[3:0])
>> >   */
>> >  #define PTE_S2_MEMATTR(t)	(_AT(pteval_t, (t)) << 2)
>> > -#define PTE_S2_MEMATTR_MASK	(_AT(pteval_t, 0xf) << 2)
>> >
>> >  /*
>> >   * EL2/HYP PTE/PMD definitions
>> 
>> Looks good to me. Catalin, Will: do you want to take this directly? If
>> so please add my:
>> 
>> Acked-by: Marc Zyngier <maz@kernel.org>
>> 
>> Otherwise, I'll route it via the KVM tree.
> 
> I can take it for 5.8 if it's not urgent.

It has been there 6 years, I think we can cope with another few 
months... ;-)

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
