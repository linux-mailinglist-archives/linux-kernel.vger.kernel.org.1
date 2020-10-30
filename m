Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D49B2A0CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 18:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgJ3Rpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 13:45:45 -0400
Received: from foss.arm.com ([217.140.110.172]:41196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgJ3Rpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 13:45:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 859C51063;
        Fri, 30 Oct 2020 10:45:43 -0700 (PDT)
Received: from bogus (unknown [10.57.13.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D21C43F719;
        Fri, 30 Oct 2020 10:45:40 -0700 (PDT)
Date:   Fri, 30 Oct 2020 17:45:31 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Elliot Berman <eberman@codeaurora.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Trilok Soni <tsoni@codeaurora.org>,
        linux-kernel@vger.kernel.org, psodagud@codeaurora.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] smp: Add bootcpus parameter to boot subset of CPUs
Message-ID: <20201030174531.ywwkcntq4ge33lrh@bogus>
References: <1603404243-5536-1-git-send-email-eberman@codeaurora.org>
 <87v9f04n8r.fsf@nanos.tec.linutronix.de>
 <a6d7f84679240fcf580520230a88c058@codeaurora.org>
 <20201026171224.GV2611@hirez.programming.kicks-ass.net>
 <a9fa1f8d-52c7-adca-9087-160b1ecda6b8@codeaurora.org>
 <20201028145516.23lm66mora5b3wqr@e107158-lin>
 <20201028151558.odxwolnwbes2gihi@bogus>
 <cb175d84-7a89-344d-0dd8-76bf4ece9e3b@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb175d84-7a89-344d-0dd8-76bf4ece9e3b@codeaurora.org>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 02:37:06PM -0700, Elliot Berman wrote:
> On 10/28/2020 8:15 AM, Sudeep Holla wrote:
> > > > > > Hi Thomas and Peter,
> > > > > >
> > > > > > Based on my understanding with maxcpus option provides, maximum no of CPUs
> > > > > > are brough up during the device boot up. There is a different case, in which
> > > > > > we want to restrict which CPUs to be brough up.
> > > > > > On a system with 8 cpus, if we set maxcpus as 3, cpu0, cpu1, and cpu2 are
> > > > > > brough up during the bootup.  For example, if we want to bring core0, core3
> > > > > > and core4 current maxcpu(as 3) setting would not help us.
> > > > > > On some platform we want the flexibility on which CPUs to bring up during
> > > > > > the device bootup. bootcpus command line is helping to bring specific CPUs
> > > > > > and these patches are working downstream.
> > > > >
> >
> > Either offline "unwanted" CPUs from user space. If that is not possible
> > for whatever thermal reasons, we need to check if we can disable them in
> > the DT like ACPI does. IIUC, it is not supported for some reasons I need
> > to recall/check, can't remember that now. If that is not possible, make
> > those nodes disappear in the bootloader ?
> >
>
> If I disappear the cpu nodes in bootloader, then I can't later online these
> cpus back up when policy permits.

No I meant, to have policy in bootloader and manage device nodes based on
what you need in that boot.

> In our experience, there is a performance hit of ~100ms to modify any
> devicetree node in bootloader, which is significant on a commercial
> device wanting to disable bootup of certain cores for thermal.
>

I bet that performance hit is nowhere close to what you may have when you
offline a bunch of big cores, so I dismiss that, sorry.

> > > > > That's a lot of words, but exactly 0 on _WHY_ you would want to do that.
> > > > >
> > > >
> > > > We find the ability to limit the number of cpus brought online at bootup
> > > > useful, and to possibly later enable those cores. One use case is when
> > > > device is undergoing initial testing is to use bootcpus to limit bootup to
> > > > only a couple cores and later bring up the other cores for a controlled
> > > > stress test. A core brought up during boot is also running device
> > > > initialization. Besides being useful for SoC vendor bringup which typically
> > > > occurs downstream, this particular use case could be exercised by developer
> > > > of upstream support for a SoC when initial CPU settings are being
> > > > determined.
> > > >
> >
> > Why not try single core instead of couple of core and add the needed ones
> > for the user-space ?
>
> In some instances, we have seen that further debugging is needed from
> firmware or hardware teams. In these instances, we wanted device to still be
> able to do SMP boot, but with a few cores disabled.
>

Still manageable with different configuration in the bootloader.

> In the case where commercial device is using feature for thermal, device
> should boot multiple small cores. Booting only one core means we would not
> be able to use all possible cores to maximum extent possible in this thermal
> case.
>


I understood that point. But you haven't responded on my logical vs physical
number argument. I am clearly NACKing this patch as is for just usage of
logical CPU IDs in the command line while your intention is to control
the physical CPUs. So once again, NACK for that reason.

> > > > Another use case is if user wishes to limit bootup only to the smaller or
> > > > bigger cores. maxcpus= is not sufficient here to ensure that only those
> > > > cores are booted since it limits only to the first N cores, which may not be
> > > > the desired small or big cores. User may want to bring up only the smaller
> > > > cores during bootup for thermal reasons. For instance, device may be later
> > > > sufficiently charged such that boot up of the bigger cores is now
> > > > permissible. Relying on thermal drivers to later take care of putting core
> > > > into lower power idle may not occur until much later in boot (for instance,
> > > > if the governor is a module).
> > >
> > > I would have thought that FW/SCP would have the power to block booting up the
> > > CPUs if it deemed that to be unsafe.
> > >
> >
> > I think it is more like *desire* to run with whatever battery life is left
> > rather than *unsafe* to bring up the core.
> >
> > Also not sure if we can put such battery life related policies in the
> > firmware. If there is a thermal constraint, I am sure f/w will and must
> > refuse to boot the core. I doubt if we are talking about that here. It is
> > more a policy to extract max out of the battery life left, at-least the way
> > I see this issue. I may not have full context here, sorry.
>
> This is correct, FW here does not actually prevent core from starting since
> it is not a significant enough thermal issue.

Thanks for confirming.

--
Regards,
Sudeep
