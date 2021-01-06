Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2402EC0E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 17:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbhAFQO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 11:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727012AbhAFQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 11:14:59 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E32C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 08:14:18 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxBRZ-007Om9-FG; Wed, 06 Jan 2021 16:13:53 +0000
Date:   Wed, 6 Jan 2021 16:13:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: arch/arm64/kernel/topology.c:367:22: sparse: sparse: dereference
 of noderef expression
Message-ID: <20210106161353.GC3579531@ZenIV.linux.org.uk>
References: <202012180512.hxAiUO00-lkp@intel.com>
 <20201218104410.GB5258@gaia>
 <20210106150724.GA16591@arm.com>
 <20210106152118.GA23403@gaia>
 <20210106155214.GA30892@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106155214.GA30892@arm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 03:52:14PM +0000, Ionela Voinescu wrote:
> > > > > vim +367 arch/arm64/kernel/topology.c
> > > > > 
> > > > >    362	
> > > > >    363	int cpc_read_ffh(int cpu, struct cpc_reg *reg, u64 *val)
> > > > >    364	{
> > > > >    365		int ret = -EOPNOTSUPP;
> > > > >    366	
> > > > >  > 367		switch ((u64)reg->address) {
> > > > 
> > > > That's not a dereference but I guess sparse complains of dropping the
> > > > __iomem. We could change the cast to (__force u64) to silence sparse.
> > > > 
> > > > Thanks for the report.
> > > > 
> > > 
> > > Nothing I've tried seemed to silence sparse here, including casting to
> > > (__force u64).
> > 
> > Would it work if we changed the case lines to (u64 __iomem)0x0?
> > 
> 
> No, it does not. We still get the same warning on the switch line even
> if there is no cast. Same if we directly check for:
> 
> if (reg->address == (u64 __iomem)0x0)

Folks, could you stop with the voodoo?  This u64 __iomem address thing is completely
wrong.  What it says is "address of that field shall be an iomem pointer",
which makes no sense whatsoever.

Just what had been intended?  __iomem is a qualifier of the same sort
as const or volatile - this mess makes as much sense as
struct cpc_reg {
        u8 descriptor;
        u16 length;
        u8 space_id;   
        u8 bit_width;   
        u8 bit_offset;
        u8 access_width;
        u64 const address;
} __packed;

Which would *NOT* be read as "reg->address is a numeric representation of
address of something unmodifiable" - it would be "the value stored in
reg->address can not be modified".

This annotation says "reg->address (somehow) lives in iomem", resulting in
"so why the hell are you trying to read it by plain dereferencing of
reg + field offset?" from sparse.

Get rid of this misannotation and don't breed force-cast to confuse
everything hard enough to STFU.
