Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48052A7A43
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 10:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbgKEJQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 04:16:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgKEJP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 04:15:59 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10657206FB;
        Thu,  5 Nov 2020 09:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604567756;
        bh=3tBe0ZzmkljptH5mAbDed2hYFNq91s7DKR0Or9hxKik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnLhQJTdU7QaCdJ1jvoSevluXH1vzEnTZeby+NbVdImoyw7r7JpSbzdCQEA1nOnHo
         CDq9FS7/uXO0S94GWyUzyALEVMyvYe7Ca+GozMe25SM5emEnDBf4HenEfH96dBwZcX
         4VlSjaX4XN+0OEvk/eyr6TGpM83tfCqHQtvtYKAk=
Date:   Thu, 5 Nov 2020 10:16:45 +0100
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
Message-ID: <20201105091645.GA3436809@kroah.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-7-shuo.a.liu@intel.com>
 <20201104190235.GA2855400@kroah.com>
 <20201105031029.GB17702@shuo-intel.sh.intel.com>
 <20201105062907.GA693781@kroah.com>
 <20201105073545.GD17702@shuo-intel.sh.intel.com>
 <20201105082639.GB3426404@kroah.com>
 <20201105090200.GE17702@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105090200.GE17702@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 05:02:00PM +0800, Shuo A Liu wrote:
> On Thu  5.Nov'20 at  9:26:39 +0100, Greg Kroah-Hartman wrote:
> > On Thu, Nov 05, 2020 at 03:35:45PM +0800, Shuo A Liu wrote:
> > > On Thu  5.Nov'20 at  7:29:07 +0100, Greg Kroah-Hartman wrote:
> > > > On Thu, Nov 05, 2020 at 11:10:29AM +0800, Shuo A Liu wrote:
> > > > > On Wed  4.Nov'20 at 20:02:35 +0100, Greg Kroah-Hartman wrote:
> > > > > > On Mon, Oct 19, 2020 at 02:17:52PM +0800, shuo.a.liu@intel.com wrote:
> > > > > > > --- /dev/null
> > > > > > > +++ b/include/uapi/linux/acrn.h
> > > > > > > @@ -0,0 +1,56 @@
> > > > > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > > > +/*
> > > > > > > + * Userspace interface for /dev/acrn_hsm - ACRN Hypervisor Service Module
> > > > > > > + *
> > > > > > > + * This file can be used by applications that need to communicate with the HSM
> > > > > > > + * via the ioctl interface.
> > > > > > > + */
> > > > > > > +
> > > > > > > +#ifndef _UAPI_ACRN_H
> > > > > > > +#define _UAPI_ACRN_H
> > > > > > > +
> > > > > > > +#include <linux/types.h>
> > > > > > > +
> > > > > > > +/**
> > > > > > > + * struct acrn_vm_creation - Info to create a User VM
> > > > > > > + * @vmid:		User VM ID returned from the hypervisor
> > > > > > > + * @reserved0:		Reserved
> > > > > > > + * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
> > > > > > > + * @reserved1:		Reserved
> > > > > > > + * @uuid:		UUID of the VM. Pass to hypervisor directly.
> > > > > > > + * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
> > > > > > > + * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
> > > > > > > + *			hypervisor directly.
> > > > > > > + * @cpu_affinity:	CPU affinity of the VM. Pass to hypervisor directly.
> > > > > > > + * @reserved2:		Reserved
> > > > > >
> > > > > > Reserved and must be 0?
> > > > >
> > > > > Not a must.
> > > >
> > > > That's guaranteed to come back and bite you in the end.
> > > 
> > > OK. I can fill them with zero before passing them to hypervisor.
> > > 
> > > > You all have read the "how to write a good api" document, right?
> > > 
> > > Is it Documentation/driver-api/ioctl.rst? Or i missed..
> > 
> > That's one good document, but no, not what I was referring to.  I was
> > thinking of Documentation/process/adding-syscalls.rst, which is what you
> > are doing here implicitly with these new ioctls (every ioctl is a brand
> > new syscall.)
> 
> I will read it as well. Thanks.
> 
> > 
> > > > > > What are they reserved for?
> > > > > >
> > > > > > Same for all of the reserved fields, why?
> > > > >
> > > > > Some reserved fields are to map layout in the hypervisor side, others
> > > > > are for future use.
> > > >
> > > > ioctls should not have these, again, please read the documentation.  If
> > > > you need something new in the future, just make a new ioctl.
> > > 
> > > OK. I will remove some reserved fields for scalability.
> > 
> > "scalability" should have nothing to do with any of this, right?  What
> > am I missing?
> 
> Sorry, i meant reserved fields for future use.

Again, this is not how you do that at all.  If you need something "in
the future", create it then.  What you are doing here ensures that you
will never be able to do it then either, so don't even pretend :)

Read the syscall document for why this is the case.

> > > Though i can
> > > keep some reserved fields for alignment (and to keep same data structure
> > > layout with the hypervisor), right?
> > > Documentation/driver-api/ioctl.rst says that explicit reserved fields
> > > could be used.
> > 
> > If you need alignment, yes, that is fine, but that's not what you are
> > saying these are for.  And if you need alignment, why not move things
> > around so they are properly aligned.
> > 
> > And this structure has nothing to do with the hypervisor structure,
> > that's a internal-kernel structure, not a userspace-visable thing if you
> > are doing things correctly.
> 
> It's the same structure with the one in hypervisor. HSM driver
> doesn't maintain the VM much, it just pass the data for VM creation from
> userspace to hypervisor.

That sounds ripe for abuse, good luck!

greg k-h
