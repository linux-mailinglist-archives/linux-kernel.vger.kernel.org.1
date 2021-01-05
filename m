Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC0A2EAC8E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbhAEOCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:02:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbhAEOCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:02:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55147229C4;
        Tue,  5 Jan 2021 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609855301;
        bh=PM5wrcMEunK0G/E2FyW9no08DKJewnE04A+cpLTvhkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkOfTcGFApGPMZAkYfQ/5jXCWo6mvXbgeXa5h3Ya231AOl2cG9BUqqzncjb+7tTLB
         RwRVzp4YdagYZpeOY65Nisuf5eepxIduu0MDdij20KDWaBlabIurChE1f+axpZGa2Z
         oQu2zjz3SPuWwVvBCUgdgZdcCLbDPFDpqhubpTuU=
Date:   Tue, 5 Jan 2021 15:03:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v6 06/18] virt: acrn: Introduce VM management interfaces
Message-ID: <X/RxmiUYnhoQvdwz@kroah.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
 <20201201093853.12070-7-shuo.a.liu@intel.com>
 <X8YWa8IUCgOARYMS@kroah.com>
 <20201202021429.GL17702@shuo-intel.sh.intel.com>
 <20201215095259.GN17702@shuo-intel.sh.intel.com>
 <X9iJWXaIUpUq2qia@kroah.com>
 <20201215100251.GO17702@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215100251.GO17702@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 06:02:51PM +0800, Shuo A Liu wrote:
> On Tue 15.Dec'20 at 11:00:57 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Dec 15, 2020 at 05:52:59PM +0800, Shuo A Liu wrote:
> > > On Wed  2.Dec'20 at 10:14:29 +0800, Shuo A Liu wrote:
> > > > On Tue  1.Dec'20 at 11:09:47 +0100, Greg Kroah-Hartman wrote:
> > > > > On Tue, Dec 01, 2020 at 05:38:41PM +0800, shuo.a.liu@intel.com wrote:
> > > > > > +		vm_param->reserved0 = 0;
> > > > > > +		vm_param->reserved1 = 0;
> > > > >
> > > > > NO!
> > > > >
> > > > > This means that userspace can put whatever crud they want in those
> > > > > fields, and you will happily zero it out.  Then, when those reserved
> > > > > fields are wanted to be used in the future, you will take those values
> > > > > from userspace and accept them as a valid value.  But, since userspace
> > > > > was sending crud before, now you will take that crud and do something
> > > > > with it.
> > > > >
> > > > > TEST IT to verify that it is zero, that way userspace gets it right the
> > > > > first time, and you don't get it wrong later, as you can not change it
> > > > > later.
> > > >
> > > > OK. Thanks for the elaboration. I will test it and return -EINVAL if
> > > > it is not zero.
> > > >
> > > 
> > > Hi Greg,
> > > 
> > > Would you like to review other patches in this series on this version?
> > 
> > Nope, it's the middle of the merge window, I can't do anything with any
> > new patches until after 5.11-rc1 is out.  So I suggest you fix up the
> > current issues and send a new patch series once 5.11-rc1 is released.
> 
> Got it, thanks!

Did this ever happen?  I don't see a new series anywhere, do you have a
lore.kernel.org link?

thanks,

greg k-h
