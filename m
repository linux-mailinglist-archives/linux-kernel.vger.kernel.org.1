Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686F12A792F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgKEIZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:25:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbgKEIZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:25:56 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E7D8206ED;
        Thu,  5 Nov 2020 08:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604564755;
        bh=ong/5uAOzEPzvvkf24FqAzmWCt2WwE06vxIZsyxBPc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vP9KXdx5k5SLy8dxikoStWRPdzZpUnXGbSNqhTu2Ymg+eD7ZimDK5qFaY1LQf595R
         lE5w0dD8PtjFtFKD/9VL8j0FMSeSwJSpigdZ1E75M1iCL5GHVhs4/x2mE/l+xfa3xy
         IlSzW9oabzBTl1TBGdilxMiZNH/O8tpjLNk1g1m8=
Date:   Thu, 5 Nov 2020 09:26:39 +0100
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
Subject: Re: [PATCH v5 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20201105082639.GB3426404@kroah.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-7-shuo.a.liu@intel.com>
 <20201104190235.GA2855400@kroah.com>
 <20201105031029.GB17702@shuo-intel.sh.intel.com>
 <20201105062907.GA693781@kroah.com>
 <20201105073545.GD17702@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105073545.GD17702@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 03:35:45PM +0800, Shuo A Liu wrote:
> On Thu  5.Nov'20 at  7:29:07 +0100, Greg Kroah-Hartman wrote:
> > On Thu, Nov 05, 2020 at 11:10:29AM +0800, Shuo A Liu wrote:
> > > On Wed  4.Nov'20 at 20:02:35 +0100, Greg Kroah-Hartman wrote:
> > > > On Mon, Oct 19, 2020 at 02:17:52PM +0800, shuo.a.liu@intel.com wrote:
> > > > > --- /dev/null
> > > > > +++ b/include/uapi/linux/acrn.h
> > > > > @@ -0,0 +1,56 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > +/*
> > > > > + * Userspace interface for /dev/acrn_hsm - ACRN Hypervisor Service Module
> > > > > + *
> > > > > + * This file can be used by applications that need to communicate with the HSM
> > > > > + * via the ioctl interface.
> > > > > + */
> > > > > +
> > > > > +#ifndef _UAPI_ACRN_H
> > > > > +#define _UAPI_ACRN_H
> > > > > +
> > > > > +#include <linux/types.h>
> > > > > +
> > > > > +/**
> > > > > + * struct acrn_vm_creation - Info to create a User VM
> > > > > + * @vmid:		User VM ID returned from the hypervisor
> > > > > + * @reserved0:		Reserved
> > > > > + * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
> > > > > + * @reserved1:		Reserved
> > > > > + * @uuid:		UUID of the VM. Pass to hypervisor directly.
> > > > > + * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
> > > > > + * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
> > > > > + *			hypervisor directly.
> > > > > + * @cpu_affinity:	CPU affinity of the VM. Pass to hypervisor directly.
> > > > > + * @reserved2:		Reserved
> > > >
> > > > Reserved and must be 0?
> > > 
> > > Not a must.
> > 
> > That's guaranteed to come back and bite you in the end.
> 
> OK. I can fill them with zero before passing them to hypervisor.
> 
> > You all have read the "how to write a good api" document, right?
> 
> Is it Documentation/driver-api/ioctl.rst? Or i missed..

That's one good document, but no, not what I was referring to.  I was
thinking of Documentation/process/adding-syscalls.rst, which is what you
are doing here implicitly with these new ioctls (every ioctl is a brand
new syscall.)

> > > > What are they reserved for?
> > > >
> > > > Same for all of the reserved fields, why?
> > > 
> > > Some reserved fields are to map layout in the hypervisor side, others
> > > are for future use.
> > 
> > ioctls should not have these, again, please read the documentation.  If
> > you need something new in the future, just make a new ioctl.
> 
> OK. I will remove some reserved fields for scalability.

"scalability" should have nothing to do with any of this, right?  What
am I missing?

> Though i can
> keep some reserved fields for alignment (and to keep same data structure
> layout with the hypervisor), right?
> Documentation/driver-api/ioctl.rst says that explicit reserved fields
> could be used.

If you need alignment, yes, that is fine, but that's not what you are
saying these are for.  And if you need alignment, why not move things
around so they are properly aligned.

And this structure has nothing to do with the hypervisor structure,
that's a internal-kernel structure, not a userspace-visable thing if you
are doing things correctly.

As an example of all of this type of review and conversation, please
refer to the review of the recent nitro_enclaves code that got merged.
All of the discussions there about ioctls are also relevant here.

thanks,

greg k-h
