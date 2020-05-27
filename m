Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201581E46D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 17:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbgE0PEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 11:04:04 -0400
Received: from foss.arm.com ([217.140.110.172]:39754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388922AbgE0PED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:04:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5650D30E;
        Wed, 27 May 2020 08:04:02 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.7.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F37C13F52E;
        Wed, 27 May 2020 08:03:59 -0700 (PDT)
Date:   Wed, 27 May 2020 16:03:57 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Jiping Ma <jiping.ma2@windriver.com>, zhe.he@windriver.com,
        bruce.ashfield@gmail.com, yue.tao@windriver.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paul.gortmaker@windriver.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
Message-ID: <20200527150357.GB59947@C02TD0UTHF1T.local>
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
 <20200526195419.GB2206@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526195419.GB2206@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 08:54:19PM +0100, Will Deacon wrote:
> On Tue, May 26, 2020 at 11:26:11AM +0100, Mark Rutland wrote:
> > On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
> > > Modified the patch subject and the change description.
> > > 
> > > PC value is get from regs[15] in REGS_ABI_32 mode, but correct PC
> > > is regs->pc(regs[PERF_REG_ARM64_PC]) in arm64 kernel, which caused
> > > that perf can not parser the backtrace of app with dwarf mode in the 
> > > 32bit system and 64bit kernel.
> > > 
> > > Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> > 
> > Thanks for this.
> > 
> > 
> > > ---
> > >  arch/arm64/kernel/perf_regs.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
> > > index 0bbac61..0ef2880 100644
> > > --- a/arch/arm64/kernel/perf_regs.c
> > > +++ b/arch/arm64/kernel/perf_regs.c
> > > @@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
> > >  	if ((u32)idx == PERF_REG_ARM64_PC)
> > >  		return regs->pc;
> > >  
> > > +	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
> > > +		&& idx == 15)
> > > +		return regs->pc;
> > 
> > I think there are some more issues here, and we may need a more
> > substantial rework. For a compat thread, we always expose
> > PERF_SAMPLE_REGS_ABI_32 via per_reg_abi(), but for some reason
> > perf_reg_value() also munges the compat SP/LR into their ARM64
> > equivalents, which don't exist in the 32-bit sample ABI. We also don't
> > zero the regs that don't exist in 32-bit (including the aliasing PC).
> 
> I think this was for the case where you have a 64-bit perf profiling a
> 32-bit task, and it was passing the registers off to libunwind. Won't that
> break if we follow your suggestion?

Oh yuck; have we messed up the ABI here, or have I misunderstood?

Is arm64's PERF_SAMPLE_REGS_ABI_32 supposed to be the same as the 32-bit
arm's PERF_SAMPLE_REGS_ABI_32?

If yes, and the differences are being relied upon by 64-bit consumers,
that's a nasty ABI issue we've introduced for compat tasks, and I don't
think this patch alone is quite right.

If no, then I don't see that any change is necessary, as we already
expose the information, and it's a userspace bug to expect the PC in a
place where the kernel has never exposed it.

Thanks,
Mark.
