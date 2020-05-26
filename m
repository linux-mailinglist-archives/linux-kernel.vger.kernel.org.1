Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7E1ACF69
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 20:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgDPSMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 14:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgDPSMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:12:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3ABA21924;
        Thu, 16 Apr 2020 18:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587060728;
        bh=dKS+MG0CSg/HtNkZGsr/L3wWaajOLzH1Y3yCvJSHGCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xUUF9lrCWR6yVbI1xTXNYLK0+Ii7L54BmGYZLumlSKYcxHZYf8JpjLlMCQHNwZ+OU
         eOq0PU0fnjPkw6ZxU2hk5HoIZ05Ascu5Ju5BuZ66j+6k4NXJy1ScW1Xj0I2R0mun8p
         wOEXfVb0pm+hDIVscbNID/It1oZgbhjKIOWY6vxQ=
Date:   Thu, 16 Apr 2020 19:12:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
Subject: Re: [PATCH 8/8] arm64: cpufeature: Add an overview comment for the
 cpufeature framework
Message-ID: <20200416181202.GA3739@willie-the-truck>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-9-will@kernel.org>
 <96dd797d-ccfe-c867-0a70-65eccacde3cd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96dd797d-ccfe-c867-0a70-65eccacde3cd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 03:59:39PM +0100, Suzuki K Poulose wrote:
> On 04/14/2020 10:31 PM, Will Deacon wrote:
> > Now that Suzuki isn't within throwing distance, I thought I'd better add
> > a rough overview comment to cpufeature.c so that it doesn't take me days
> > to remember how it works next time.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >   arch/arm64/kernel/cpufeature.c | 43 ++++++++++++++++++++++++++++++++++
> >   1 file changed, 43 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 680a453ca8c4..421ca99dc8fc 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -3,6 +3,49 @@
> >    * Contains CPU feature definitions
> >    *
> >    * Copyright (C) 2015 ARM Ltd.
> > + *
> > + * A note for the weary kernel hacker: the code here is confusing and hard to
> > + * follow! That's partly because it's solving a nasty problem, but also because
> > + * there's a little bit of over-abstraction that tends to obscure what's going
> > + * on behind a maze of helper functions and macros.
> 
> Thanks for writing this up !

It's purely a selfish thing ;)

> > + * The basic problem is that hardware folks have started gluing together CPUs
> > + * with distinct architectural features; in some cases even creating SoCs where
> > + * user-visible instructions are available only on a subset of the available
> > + * cores. We try to address this by snapshotting the feature registers of the
> > + * boot CPU and comparing these with the feature registers of each secondary
> > + * CPU when bringing them up. If there is a mismatch, then we update the
> > + * snapshot state to indicate the lowest-common denominator of the feature,
> > + * known as the "safe" value. This snapshot state can be queried to view the
> 
> I am not sure if the following is implied above.
> 
>   1) Against the "snapshot" state, where mismatches triggers updating
>      the "snapshot" state to reflect the "safe" value.
> 
>   2) Compared against the CPU feature registers of *the boot CPU* for
>     "FTR_STRICT" fields and any mismatch triggers TAINT_CPU_OUT_OF_SPEC.
>      This makes sure that warning is generated for each OUT_OF_SPEC
>      secondary CPU.

I was trying to avoid talking about the consequences of a mismatch in that
paragraph, and instead cover them below:

> > + * The sanitised register values are used to decide which capabilities we
> > + * have in the system. These may be in the form of traditional "hwcaps"
> > + * advertised to userspace or internal "cpucaps" which are used to configure
> > + * things like alternative patching and static keys. While a feature mismatch
> > + * may result in a TAINT_CPU_OUT_OF_SPEC kernel taint, a capability mismatch
> > + * may prevent a CPU from being onlined at all.

Do you think something is missing here?

> > + *
> > + * Some implementation details worth remembering:
> > + *
> > + * - Mismatched features are *always* sanitised to a "safe" value, which
> > + *   usually indicates that the feature is not supported.
> > + *
> > + * - A mismatched feature marked with FTR_STRICT will cause a "SANITY CHECK"
> > + *   warning when onlining an offending CPU and the kernel will be tainted
> > + *   with TAINT_CPU_OUT_OF_SPEC.
> 
> As mentioned above, this check is against that of the "boot CPU"
> register state, which may not be implicit from the statement.

Hmm, I'm trying to figure out if this matters. I suppose this means you
get a SANITY CHECK warning for every mismatching secondary CPU, but that's
implied by the above. Is there something else I'm missing?

> > + *
> > + * - Features marked as FTR_VISIBLE have their sanitised value visible to
> > + *   userspace. FTR_VISIBLE features in registers that are only visible
> > + *   to EL0 by trapping *must* have a corresponding HWCAP so that late
> > + *   onlining of CPUs cannot lead to features disappearing at runtime.
> > + *
> 
> As you mentioned in the other response we could add information about
> the guest view, something like :
> 
>       - KVM exposes the sanitised value of the feature registers to the
> 	guests and is not affected by the FTR_VISIBLE. However,
> 	depending on the individual feature support in the hypervisor,
> 	some of the fields may be capped/limited.

In light of Marc's comment, I'll add something here along the lines of:

  "KVM exposes its own view of the feature registers to guest operating
   systems regardless of FTR_VISIBLE. This is typically driven from the
   sanitised register values to allow virtual CPUs to be migrated between
   arbitrary physical CPUs, but some features not present on the host are
   also advertised and emulated. Look at sys_reg_descs[] for the gory
   details."

Will
