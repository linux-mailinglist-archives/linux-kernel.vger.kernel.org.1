Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E59E2EC557
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 21:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbhAFUrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 15:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbhAFUrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 15:47:47 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571D8C061575
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 12:47:06 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxFhr-007VHW-Bg; Wed, 06 Jan 2021 20:46:59 +0000
Date:   Wed, 6 Jan 2021 20:46:59 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: arch/arm64/kernel/topology.c:367:22: sparse: sparse: dereference
 of noderef expression
Message-ID: <20210106204659.GE3579531@ZenIV.linux.org.uk>
References: <202012180512.hxAiUO00-lkp@intel.com>
 <20201218104410.GB5258@gaia>
 <20210106150724.GA16591@arm.com>
 <20210106174758.GD3579531@ZenIV.linux.org.uk>
 <20210106201226.GA25625@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106201226.GA25625@arm.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 06, 2021 at 08:12:27PM +0000, Ionela Voinescu wrote:

> Initially I though it always only makes sense to have a __iomem pointer.
> That is, it only makes sense to have a pointer with a cookie attached
> specifying that it addresses a device memory space that should only be
> accessed using special functions.
> 
> But then you've got something like this in drivers/input/serio/apbps2.c:
> struct apbps2_regs {
> 	u32 __iomem data;	/* 0x00 */
> 	u32 __iomem status;	/* 0x04 */
> 	u32 __iomem ctrl;	/* 0x08 */
> 	u32 __iomem reload;	/* 0x0c */
> };
> struct apbps2_priv {
> 	struct serio		*io;
> 	struct apbps2_regs	*regs;
> };
> [..] (followed by)
> ioread32be(&priv->regs->status)
> 
> which I think is correct despite contradicting my assumption, but it's
> the only example I've found in the kernel.

Frankly, I would rather turn that into
	struct apbps2_regs	__iomem *regs;
and striped the individual field qualifiers...
