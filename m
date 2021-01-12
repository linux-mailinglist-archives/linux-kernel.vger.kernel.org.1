Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEDF2F339B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389233AbhALPIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:08:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:35124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726440AbhALPIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:08:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D48F23131;
        Tue, 12 Jan 2021 15:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610464062;
        bh=vd1ZvXG086RatWV6CsvEAmO8vQlGfdPVOkxQnQY8NCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C3QqVR5EoAdqbOzlIDyZliIhO7/xH84JOHD+IAM+0LbD6hb39pR2wt8TOtz0jwSD+
         v60Lcv3WAJrNt7L3apqeVmnsT15JxBl/cJMHg5O+Nwk2kAElkwJmpWxUdKiSrzeSj2
         4FJ/JWUFIjC0/AiTy2Og/NOmU0wth4a2g+qU5yfcmKP9khGAxfApwMEXzH3IrHDFKw
         h8k3DLu4ZvTM9sbW9937X/FOojeVj/3lHJJ2K3ZkdTKay1xdiBoUZu8Np5BcqvygNQ
         9fyavni2FQlNzxNbty7lbiGJauGFeJsI2VaKG5ED4lZQz6E4F/aEPNK7bj8cq0GnHU
         cCEY/j1eBlL4Q==
Date:   Tue, 12 Jan 2021 15:07:36 +0000
From:   Will Deacon <will@kernel.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     sumit.garg@linaro.org, acme@kernel.org,
        alexander.shishkin@linux.intel.com, alexandru.elisei@arm.com,
        catalin.marinas@arm.com, jolsa@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, mingo@redhat.com, namhyung@kernel.org,
        oliver.sang@intel.com, peterz@infradead.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v2] arm64: perf: Fix access percpu variables in
 preemptible context
Message-ID: <20210112150735.GC9689@willie-the-truck>
References: <CAFA6WYNepUP=SeHWnDDbxx=ggwPq2jDd5JmrcXD5GoMC5dYH2g@mail.gmail.com>
 <20210108125527.14175-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108125527.14175-1-lecopzer.chen@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 08:55:27PM +0800, Lecopzer Chen wrote:
> > On Mon, 21 Dec 2020 at 21:53, Lecopzer Chen <lecopzer.chen@mediatek.com> wrote:
> > >
> > > commit 367c820ef08082 ("arm64: Enable perf events based hard lockup detector")
> > > reinitilizes lockup detector after arm64 PMU is initialized and open
> > > a window for accessing smp_processor_id() in preemptible context.
> > > Since hardlockup_detector_perf_init() always called in init stage
> > > with a single cpu, but we initialize lockup detector after the init task
> > > is migratable.
> > >
> > > Fix this by utilizing lockup detector reconfiguration which calls
> > > softlockup_start_all() on each cpu and calls watatchdog_nmi_enable() later.
> > > Because softlockup_start_all() use IPI call function to make sure
> > > watatchdog_nmi_enable() will bind on each cpu and fix this issue.
> > 
> > IMO, this just creates unnecessary dependency for hardlockup detector
> > init via softlockup detector (see the alternative definition of
> > lockup_detector_reconfigure()).
> 
> 
> The arm64/Kconfig select HAVE_HARDLOCKUP_DETECTOR_PERF if we have NMI:
> 	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
> 
> And in lib/Kconfig.debug HARDLOCKUP_DETECTOR select SOFTLOCKUP_DETECTOR automatically.
> 	config HARDLOCKUP_DETECTOR_PERF
> 		bool
> 		select SOFTLOCKUP_DETECTOR
> 
> So we don't need to explicitly select softlockup.
> And actually this patch is not a perfect solution like you said
> (hardlockup depends on softlockup),
> but the key point is that lockup_detector_init() seems only design for
> using in early init stage and not for calling in later deffered initial process.

I agree; the current usage in armv8_pmu_driver_init() looks very broken to
me, and bodging it with raw_smp_processor_id() isn't the right solution.

Maybe we should just revert 367c820ef08082, as this looks like a design
issue rather than something with a simple fix?

Will
