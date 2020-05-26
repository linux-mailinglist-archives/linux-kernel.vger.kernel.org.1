Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B571E2F78
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 21:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbgEZTy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 15:54:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389038AbgEZTyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:54:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBC37207CB;
        Tue, 26 May 2020 19:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590522864;
        bh=O7cesvgSXf5oQ4fsUxRGrM5IceW++SEodbszIMRcYp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yCRCJqZz1tS/Y0lnOFa/VijoyCHziu5CacMPkJVBM5D5dUWOaIqlU17z11e9MivSR
         QigvKWbzk/C9pvNt3Wp59L2KU46UlCFGPwzf3tU3R32OMASlwFbvEiNKc7lZsDAKxF
         3T6gXLbRJUSoBBkE5daxWb0C6X9bzyaUkYrL9C4E=
Date:   Tue, 26 May 2020 20:54:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Jiping Ma <jiping.ma2@windriver.com>, zhe.he@windriver.com,
        bruce.ashfield@gmail.com, yue.tao@windriver.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        paul.gortmaker@windriver.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH][V3] arm64: perf: Get the wrong PC value in REGS_ABI_32
 mode
Message-ID: <20200526195419.GB2206@willie-the-truck>
References: <1589165527-188401-1-git-send-email-jiping.ma2@windriver.com>
 <20200526102611.GA1363@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526102611.GA1363@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:26:11AM +0100, Mark Rutland wrote:
> On Mon, May 11, 2020 at 10:52:07AM +0800, Jiping Ma wrote:
> > Modified the patch subject and the change description.
> > 
> > PC value is get from regs[15] in REGS_ABI_32 mode, but correct PC
> > is regs->pc(regs[PERF_REG_ARM64_PC]) in arm64 kernel, which caused
> > that perf can not parser the backtrace of app with dwarf mode in the 
> > 32bit system and 64bit kernel.
> > 
> > Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>
> 
> Thanks for this.
> 
> 
> > ---
> >  arch/arm64/kernel/perf_regs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
> > index 0bbac61..0ef2880 100644
> > --- a/arch/arm64/kernel/perf_regs.c
> > +++ b/arch/arm64/kernel/perf_regs.c
> > @@ -32,6 +32,10 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
> >  	if ((u32)idx == PERF_REG_ARM64_PC)
> >  		return regs->pc;
> >  
> > +	if (perf_reg_abi(current) == PERF_SAMPLE_REGS_ABI_32
> > +		&& idx == 15)
> > +		return regs->pc;
> 
> I think there are some more issues here, and we may need a more
> substantial rework. For a compat thread, we always expose
> PERF_SAMPLE_REGS_ABI_32 via per_reg_abi(), but for some reason
> perf_reg_value() also munges the compat SP/LR into their ARM64
> equivalents, which don't exist in the 32-bit sample ABI. We also don't
> zero the regs that don't exist in 32-bit (including the aliasing PC).

I think this was for the case where you have a 64-bit perf profiling a
32-bit task, and it was passing the registers off to libunwind. Won't that
break if we follow your suggestion?

Will
