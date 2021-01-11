Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BF32F11B6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729812AbhAKLou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:44:50 -0500
Received: from foss.arm.com ([217.140.110.172]:55194 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729660AbhAKLou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:44:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5236831B;
        Mon, 11 Jan 2021 03:44:04 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.41.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73303F719;
        Mon, 11 Jan 2021 03:44:02 -0800 (PST)
Date:   Mon, 11 Jan 2021 11:44:00 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Tingwei Zhang <tingweiz@codeaurora.org>
Cc:     tingwei@codeaurora.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Set DBGCLAIM when self-host debug is enabled
Message-ID: <20210111114400.GB49295@C02TD0UTHF1T.local>
References: <512a30e6cc6877687c10c0f9ccc3c4c5@codeaurora.org>
 <20210106122356.GC26994@C02TD0UTHF1T.local>
 <20210108040055.GA11529@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108040055.GA11529@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:00:55PM +0800, Tingwei Zhang wrote:
> On Wed, Jan 06, 2021 at 08:23:56PM +0800, Mark Rutland wrote:
> > On Wed, Jan 06, 2021 at 06:29:53PM +0800, tingwei@codeaurora.org wrote:
> > > Hi Will and Mark,
> > 
> > Hi Tingwei,
> > 
> > > In recent implementation of save/restore ARM debug registers in
> > > EL2/EL3, we found it's necessary to know whether self-host debug is
> > > enabled so EL2/EL3 can avoid saving/restoring debug registers but no
> > > one is using debug.
> > 
> > In what situation are you considering? I assume you mean idle sequences
> > using CPU_SUSPEND?
> > 
> > Generally our expectation for CPU_SUSPEND is:
> > 
> > * Where StateType==0, the debug state is preserved with all other
> >   PE state.
> > 
> > * Where StateType==1 and the PE returns "warm" without having entered a
> >   powerdown state, the debug state is preserved along with all other PE
> >   state.
> > 
> > * Where StateType==1, and the PE returns "cold" after having entered a
> >   powerdown state (i.e. we return via the entry point address), the
> >   debug state is not preserved.
> > 
> > ... and I'm missing where you could avoid saving the state. What
> > situation(s) did you have in mind?
> > 
> In StateType==1 case, EL2/EL3 can save debug registers before PE suspend
> and restore them after PE resume. If EL2/EL3 doesn't know whether external
> debugger or self-host debugger is using debug registers, it can save and
> restore bindly everytime. However, if EL2/EL3 can get the information from
> DBGCLAIM, it can only save/restore debug registers when debug is ongoing
> which means DGBCLAIM[0] is set by external debugger or DGBCLAIM[1] is set
> by self-host debugger.

I think I'm missing something here. Are you tring to enable self-hosted
debug over powerdown events, or are you trying to optimize the
save/restore of debug state?

Linux doesn't support self-hosted debug over powerdown events, since we
lose context anyway, and we need to get through a reasonable portion of
setup code before it's safe to take debug exceptions again. Linux saves
and restores the debug state in this case (e.g. we call
hw_breakpoint_restore(cpu) in __cpu_suspend_exit()).

So AFAICT, Linux never needs to set DBGCLAIM[1]. For "cold" returns we
already have the relevant save/restore in Linux, and for "warm" returns
the debug state must be preserved by the firmware.

> > I was under the impression that this was solely for the benefit of an
> > external debugger, and should have no functional impact on the PSCI
> > implementation from the kernel's PoV, so as above I think we need a
> > better description of the case you're trying to address.
> 
> If self-host debugger like gdb/kgdb is used for debug, Kernel can set
> DBGCLAIM[1] to inform EL2/EL3.

I think there's additional complexity there.

KGDB relies on other CPU state (e.g. MMU, VBARs, TPIDRs, SP_EL0, DAIF.D)
being configured, so there will always be a blackout period over a
power-down events where this is restored. The kernel itself can
save/restore the debug state during this blackout period.

What benefit do you see there being if FW saves/restores this?

I'm very concerned that there are FW implementations out there which do
not save/restore when DBGCLAIM[1] is set, and the spec isn't entirely
clear as to what "debug context" consists of, so I suspect we don't
have reliable behaviour in this area.

Thanks,
Mark.
