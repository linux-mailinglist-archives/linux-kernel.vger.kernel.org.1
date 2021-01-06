Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B482EC023
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbhAFPIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 10:08:12 -0500
Received: from foss.arm.com ([217.140.110.172]:42342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbhAFPIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 10:08:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB469D6E;
        Wed,  6 Jan 2021 07:07:26 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D2423F719;
        Wed,  6 Jan 2021 07:07:26 -0800 (PST)
Date:   Wed, 6 Jan 2021 15:07:24 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: arch/arm64/kernel/topology.c:367:22: sparse: sparse: dereference
 of noderef expression
Message-ID: <20210106150724.GA16591@arm.com>
References: <202012180512.hxAiUO00-lkp@intel.com>
 <20201218104410.GB5258@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218104410.GB5258@gaia>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday 18 Dec 2020 at 10:44:10 (+0000), Catalin Marinas wrote:
> On Fri, Dec 18, 2020 at 05:00:16AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   74f602dc96dd854c7b2034947798c1e2a6b84066
> > commit: 68c5debcc06d6d24f15dbf978780fc5efc147d5e arm64: implement CPPC FFH support using AMUs
> > date:   5 weeks ago
> > config: arm64-randconfig-s032-20201217 (attached as .config)
> > compiler: aarch64-linux-gcc (GCC) 9.3.0
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # apt-get install sparse
> >         # sparse version: v0.6.3-184-g1b896707-dirty
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68c5debcc06d6d24f15dbf978780fc5efc147d5e
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout 68c5debcc06d6d24f15dbf978780fc5efc147d5e
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > 
> > "sparse warnings: (new ones prefixed by >>)"
> > >> arch/arm64/kernel/topology.c:367:22: sparse: sparse: dereference of noderef expression
> > 
> > vim +367 arch/arm64/kernel/topology.c
> > 
> >    362	
> >    363	int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
> >    364	{
> >    365		int ret = -EOPNOTSUPP;
> >    366	
> >  > 367		switch ((u64)reg->address) {
> 
> That's not a dereference but I guess sparse complains of dropping the
> __iomem. We could change the cast to (__force u64) to silence sparse.
> 
> Thanks for the report.
> 

Nothing I've tried seemed to silence sparse here, including casting to
(__force u64). I think all error checks in the kernel for __iomem
addresses result in the same warning, or at least the ones in
cppc_acpi.c, which I've checked at the time. I'm not sure if this is
something that should be improved in sparse or that can be made better
in the kernel. I'll take another look.

Thank you,
Ionela.

> -- 
> Catalin
