Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5F12EC169
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbhAFQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:48:43 -0500
Received: from foss.arm.com ([217.140.110.172]:44110 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727519AbhAFQsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:48:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85248D6E;
        Wed,  6 Jan 2021 08:47:57 -0800 (PST)
Received: from localhost (e108754-lin.cambridge.arm.com [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 274443F70D;
        Wed,  6 Jan 2021 08:47:57 -0800 (PST)
Date:   Wed, 6 Jan 2021 16:47:55 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: arch/arm64/kernel/topology.c:367:22: sparse: sparse: dereference
 of noderef expression
Message-ID: <20210106164755.GA27203@arm.com>
References: <202012180512.hxAiUO00-lkp@intel.com>
 <20201218104410.GB5258@gaia>
 <20210106150724.GA16591@arm.com>
 <20210106152118.GA23403@gaia>
 <20210106155214.GA30892@arm.com>
 <20210106161353.GC3579531@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106161353.GC3579531@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 06 Jan 2021 at 16:13:53 (+0000), Al Viro wrote:
> On Wed, Jan 06, 2021 at 03:52:14PM +0000, Ionela Voinescu wrote:
> > > > > > vim +367 arch/arm64/kernel/topology.c
> > > > > > 
> > > > > >    362	
> > > > > >    363	int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
> > > > > >    364	{
> > > > > >    365		int ret = -EOPNOTSUPP;
> > > > > >    366	
> > > > > >  > 367		switch ((u64)reg->address) {
> > > > > 
> > > > > That's not a dereference but I guess sparse complains of dropping the
> > > > > __iomem. We could change the cast to (__force u64) to silence sparse.
> > > > > 
> > > > > Thanks for the report.
> > > > > 
> > > > 
> > > > Nothing I've tried seemed to silence sparse here, including casting to
> > > > (__force u64).
> > > 
> > > Would it work if we changed the case lines to (u64 __iomem)0x0?
> > > 
> > 
> > No, it does not. We still get the same warning on the switch line even
> > if there is no cast. Same if we directly check for:
> > 
> > if (reg->address == (u64 __iomem)0x0)
> 
> Folks, could you stop with the voodoo?  This u64 __iomem address thing is completely
> wrong.  What it says is "address of that field shall be an iomem pointer",
> which makes no sense whatsoever.
> 
> Just what had been intended?  __iomem is a qualifier of the same sort
> as const or volatile - this mess makes as much sense as
> struct cpc_reg {
>         u8 descriptor;
>         u16 length;
>         u8 space_id;   
>         u8 bit_width;   
>         u8 bit_offset;
>         u8 access_width;
>         u64 const address;
> } __packed;
> 
> Which would *NOT* be read as "reg->address is a numeric representation of
> address of something unmodifiable" - it would be "the value stored in
> reg->address can not be modified".
> 
> This annotation says "reg->address (somehow) lives in iomem", resulting in
> "so why the hell are you trying to read it by plain dereferencing of
> reg + field offset?" from sparse.
> 
> Get rid of this misannotation and don't breed force-cast to confuse
> everything hard enough to STFU.

Thanks, it makes sense, and removing the attribute solves the other
similar warnings in cppc_acpi. I'll double check and submit a patch for
that.

Thanks,
Ionela.
