Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA8C2F35DD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404871AbhALQdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:33:47 -0500
Received: from foss.arm.com ([217.140.110.172]:49454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388991AbhALQdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:33:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9014F101E;
        Tue, 12 Jan 2021 08:33:01 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.57.147])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F0683F719;
        Tue, 12 Jan 2021 08:32:57 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:32:54 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Lecopzer Chen <lecopzer.chen@mediatek.com>, sumit.garg@linaro.org,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        alexandru.elisei@arm.com, catalin.marinas@arm.com,
        jolsa@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, mingo@redhat.com, namhyung@kernel.org,
        oliver.sang@intel.com, peterz@infradead.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v2] arm64: perf: Fix access percpu variables in
 preemptible context
Message-ID: <20210112163254.GB36306@C02TD0UTHF1T.local>
References: <CAFA6WYNepUP=SeHWnDDbxx=ggwPq2jDd5JmrcXD5GoMC5dYH2g@mail.gmail.com>
 <20210108125527.14175-1-lecopzer.chen@mediatek.com>
 <20210112150735.GC9689@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112150735.GC9689@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 03:07:36PM +0000, Will Deacon wrote:
> On Fri, Jan 08, 2021 at 08:55:27PM +0800, Lecopzer Chen wrote:
> > > On Mon, 21 Dec 2020 at 21:53, Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
> > > >
> > > > commit 367c820ef08082 ("arm64: Enable perf events based hard lockup detector")
> > > > reinitilizes lockup detector after arm64 PMU is initialized and open
> > > > a window for accessing smp_processor_id() in preemptible context.
> > > > Since hardlockup_detector_perf_init() always called in init stage
> > > > with a single cpu, but we initialize lockup detector after the init task
> > > > is migratable.
> > > >
> > > > Fix this by utilizing lockup detector reconfiguration which calls
> > > > softlockup_start_all() on each cpu and calls watatchdog_nmi_enable() later.
> > > > Because softlockup_start_all() use IPI call function to make sure
> > > > watatchdog_nmi_enable() will bind on each cpu and fix this issue.
> > > 
> > > IMO, this just creates unnecessary dependency for hardlockup detector
> > > init via softlockup detector (see the alternative definition of
> > > lockup_detector_reconfigure()).
> > 
> > 
> > The arm64/Kconfig select HAVE_HARDLOCKUP_DETECTOR_PERF if we have NMI:
> > 	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> > 
> > And in lib/Kconfig.debug HARDLOCKUP_DETECTOR select SOFTLOCKUP_DETECTOR automatically.
> > 	config HARDLOCKUP_DETECTOR_PERF
> > 		bool
> > 		select SOFTLOCKUP_DETECTOR
> > 
> > So we don't need to explicitly select softlockup.
> > And actually this patch is not a perfect solution like you said
> > (hardlockup depends on softlockup),
> > but the key point is that lockup_detector_init() seems only design for
> > using in early init stage and not for calling in later deffered initial process.
> 
> I agree; the current usage in armv8_pmu_driver_init() looks very broken to
> me, and bodging it with raw_smp_processor_id() isn't the right solution.
> 
> Maybe we should just revert 367c820ef08082, as this looks like a design
> issue rather than something with a simple fix?

I think that would make sense for now, then we can reconsider the whole
thing rather than looking for a point-fix.

Thanks,
Mark.
