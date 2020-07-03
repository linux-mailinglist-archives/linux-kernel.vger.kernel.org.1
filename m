Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F54213CEA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 17:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgGCPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jul 2020 11:44:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCPob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:44:31 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14AD1221E6;
        Fri,  3 Jul 2020 15:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593791071;
        bh=cPfzhzo/Hz8MPemSNhXCJzqXELqB4+AkCWomN/ytEDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v07gbwihtl5CN4DnMO7gLoEvCltFpuYSTUtmTFU+VnCsiCZ/f9f2AICd9wdmzphWj
         rfeyeFC0Qzh/+iOaMXhaTT2ZKrBikWX8xOMltitLsywf4VntSfCyH1RGEC1DY3HsZO
         QdkLUBbJQEStZMSsvx+/ykTQOQxLVX23Dn0TyoWU=
Date:   Fri, 3 Jul 2020 16:44:27 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <20200703154426.GA19406@willie-the-truck>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
 <202007030815.744AAB35D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007030815.744AAB35D@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 08:17:19AM -0700, Kees Cook wrote:
> On Fri, Jul 03, 2020 at 09:39:14AM +0100, Will Deacon wrote:
> > diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> > index 5f5b868292f5..a13661f44818 100644
> > --- a/arch/arm64/kernel/syscall.c
> > +++ b/arch/arm64/kernel/syscall.c
> > @@ -121,12 +121,10 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
> >  	user_exit();
> >  
> >  	if (has_syscall_work(flags)) {
> > -		/* set default errno for user-issued syscall(-1) */
> > -		if (scno == NO_SYSCALL)
> > -			regs->regs[0] = -ENOSYS;
> > -		scno = syscall_trace_enter(regs);
> > -		if (scno == NO_SYSCALL)
> > +		if (syscall_trace_enter(regs))
> >  			goto trace_exit;
> > +
> > +		scno = regs->syscallno;
> >  	}
> >  
> >  	invoke_syscall(regs, scno, sc_nr, syscall_table);
> 
> What effect do either of these patches have on the existing seccomp
> selftests: tools/testing/selftests/seccomp/seccomp_bpf ?

Tests! Thanks, I'll have a look.

Will
