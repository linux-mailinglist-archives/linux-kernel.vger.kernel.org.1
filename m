Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFCA1E9696
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 11:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgEaJd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 05:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgEaJd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 05:33:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00F620707;
        Sun, 31 May 2020 09:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590917606;
        bh=kbhIhCTvdYW4T4mcknrnXd2owAVuTRk+XLhdT0D6n/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVgLaPjKeNPKoDEZ3JzbTnF18GnJA5ji6Z7/k7XbKT9vyhxZX0am6CiqSmG5G8xZI
         7zfxuddxUHbu/04/SOXjg60iwuTMZ7iRTiNMsfUUDqhvDbx+undYop7J56Az0Pg51r
         VZkcNB7+Mx+HVp74Zo3tw7nyo3RS3y9l7eaESOFY=
Date:   Sun, 31 May 2020 10:33:21 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kyle Huey <khuey@pernos.co>, Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: arm64: Register modification during syscall entry/exit stop
Message-ID: <20200531093320.GA30204@willie-the-truck>
References: <CABV8kRz0mKSc=u1LeonQSLroKJLOKWOWktCoGji2nvEBc=e7=w@mail.gmail.com>
 <20200519081551.GA9980@willie-the-truck>
 <CABV8kRzYzBrdzC1_opmmdpW63N2htfOsAUZ+RjiSDsy=SJW6Yg@mail.gmail.com>
 <20200520174149.GB27629@willie-the-truck>
 <CABV8kRzjCCsjVeRsBD7U_Lo0==sBw9EKm=1z7g=60KyJvJLZBQ@mail.gmail.com>
 <CABV8kRxfet2RXXNcUoTKwfVzFWEQfxAkXUX4M5XhkP3nc-0+rQ@mail.gmail.com>
 <20200527095528.GC11111@willie-the-truck>
 <20200527101929.GT5031@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527101929.GT5031@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:19:29AM +0100, Dave Martin wrote:
> On Wed, May 27, 2020 at 10:55:29AM +0100, Will Deacon wrote:
> > On Sun, May 24, 2020 at 02:56:35AM -0400, Keno Fischer wrote:
> > > Just ran into this issue again, with what I think may be most compelling
> > > example yet why this is problematic:
> > > 
> > > The tracee incurred a signal, we PTRACE_SYSEMU'd to the rt_sigreturn,
> > > which the tracer tried to emulate by applying the state from the signal frame.
> > > However, the PTRACE_SYSEMU stop is a syscall-stop, so the tracer's write
> > > to x7 was ignored and x7 retained the value it had in the signal handler,
> > > which broke the tracee.
> > 
> > Yeah, that sounds like a good justification to add a way to stop this. Could
> > you send a patch, please?
> > 
> > Interestingly, I *thought* the current behaviour was needed by strace, but I
> > can't find anything there that seems to require it. Oh well, we're stuck
> > with it anyway.
> 
> The fact that PTRACE_SYSEMU is only implemented for a few arches makes
> we wonder whether it was a misguided addition that should not be ported
> to new arches... i.e., why does hardly anyone need it?  But I haven't
> attempted to understand the history.
> 
> Can't PTRACE_SYSEMU be emulated by using PTRACE_SYSCALL, cancelling the
> syscall at the syscall enter stop, then modifying the regs at the
> syscall exit stop?
> 
> 
> If SYSEMU was obviously always broken, perhaps we can withdraw support
> for it.  Assuming nobody is crazy enough to try to emulate execve() I
> can't see anything other than sigreturn that would be affected by this
> issue though.  So maybe SYSEMU isn't broken enough to justify
> withdrawal.

Indeed, my preference on another thread [1] was to remove it, but it would
need agreement from Arm, since it was added by them (Sudeep).

But setting that aside, Keno has convinced me that the clobbering of x7
on syscall enter/exit can cause some problems for userspace, so I think
that having a way to disable that seems like a good idea. We can't change
the current default behaviour, but having an explicit opt-in seems
worthwhile.

Keno -- are you planning to send out a patch? You previously spoke about
implementing this using PTRACE_SETOPTIONS.

Will

[1] https://lore.kernel.org/r/20200515121346.GA22919@willie-the-truck
