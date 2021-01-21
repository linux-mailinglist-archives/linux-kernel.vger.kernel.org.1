Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F602FEAA0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbhAUMtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:49:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:32858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731458AbhAUMs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:48:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E7A1239FD;
        Thu, 21 Jan 2021 12:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611233268;
        bh=dd4yVlG9KCtejepvHpsxeT3++mxKoHWtZTeivvj2m1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juVxlmLRk3sPnqi2cpCwV8Yh5CyUDKDtHm9bgxeBYtb7PgJ/QYTC2/S7FMVsbGieX
         +p+G+tAXsn3Wpqle6HWrVvXAf81J/hLdQLdkBLHa7g8+MelcuuiHROOMSL10KaUuCZ
         XI11xwu0vo4X9jpN7GY5jfHt2Aw85hD0nFeioehNGfULUNy6qmaVJ+5gV/iBqXABCm
         +RGFeDKDWWXQFGlqqKpCIzpWzNRbLl4otLMlpx5lzLJ34oSuMBP/FtFf9m9TZbuclf
         Cvg+JJmm1O+NVO88bZeg9Fn713WyC6GoeO6bYQWf7CvatkVdCP1510apDJ8fT+KazG
         Kq2DckCKrXzLA==
Date:   Thu, 21 Jan 2021 12:47:43 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        Stan Skowronek <stan@corellium.com>
Subject: Re: [RFC PATCH 3/7] arm64: mm: use nGnRnE instead of nGnRE on Apple
 processors
Message-ID: <20210121124742.GA22123@willie-the-truck>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-4-mohamed.mediouni@caramail.com>
 <20210121112725.GA21750@willie-the-truck>
 <fdc49d125ef9f520254196509f6c0aa2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc49d125ef9f520254196509f6c0aa2@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 11:44:23AM +0000, Marc Zyngier wrote:
> On 2021-01-21 11:27, Will Deacon wrote:
> > On Wed, Jan 20, 2021 at 02:27:13PM +0100, Mohamed Mediouni wrote:
> > > Use nGnRnE instead of nGnRE on Apple SoCs to workaround a serious
> > > hardware quirk.
> > > 
> > > On Apple processors, writes using the nGnRE device memory type get
> > > dropped in flight,
> > > getting to nowhere.
> > > 
> > > Signed-off-by: Stan Skowronek <stan@corellium.com>
> > > Signed-off-by: Mohamed Mediouni <mohamed.mediouni@caramail.com>
> > > ---
> > >  arch/arm64/mm/proc.S | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > > 
> > > diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> > > index 1f7ee8c8b7b8..06436916f137 100644
> > > --- a/arch/arm64/mm/proc.S
> > > +++ b/arch/arm64/mm/proc.S
> > > @@ -51,6 +51,25 @@
> > >  #define TCR_KASAN_HW_FLAGS 0
> > >  #endif
> > > 
> > > +#ifdef CONFIG_ARCH_APPLE
> > > +
> > > +/*
> > > + * Apple cores appear to black-hole writes done with nGnRE.
> > > + * We settled on a work-around that uses MAIR vs changing every
> > > single user of
> > > + * nGnRE across the arm64 code.
> > > + */
> > > +
> > > +#define MAIR_EL1_SET_APPLE						\
> > > +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
> > > +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRE) |	\
> > > +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
> > > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
> > > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
> > > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
> > > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
> > > +
> > > +#endif
> > > +
> > >  /*
> > >   * Default MAIR_EL1. MT_NORMAL_TAGGED is initially mapped as Normal
> > > memory and
> > >   * changed during __cpu_setup to Normal Tagged if the system
> > > supports MTE.
> > > @@ -432,6 +451,13 @@ SYM_FUNC_START(__cpu_setup)
> > >  	 * Memory region attributes
> > >  	 */
> > >  	mov_q	x5, MAIR_EL1_SET
> > > +#ifdef CONFIG_ARCH_APPLE
> > > +	mrs	x0, MIDR_EL1
> > > +	lsr	w0, w0, #24
> > > +	mov_q	x1, MAIR_EL1_SET_APPLE
> > > +	cmp	x0, #0x61			// 0x61 = Implementer: Apple
> > > +	csel	x5, x1, x5, eq
> > 
> > Why does this need to be done so early? It would be a lot cleaner if we
> > could detect this in a similar fashion to other errata and update the
> > MAIR
> > appropriately. If that's not possible because of early IO mappings
> > (which
> > ones?), then we could instead initialise to nGnRnE unconditionally, but
> > relax it to nGnRE if we detect that we _don't_ have the erratum.
> 
> Would that imply another round-trip into the idmap, much like we do
> when we switch to non-global mappings? Or do you expect that we can change
> the MAIR with live mappings?

I think we should be able to change it live and then invalidate the TLB. At
least, my reading of the BBM requirements suggests that it isn't required
for changing between different types of device memory. I can seek
clarification from Arm if necessary.

Will
