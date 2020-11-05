Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7941A2A7771
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 07:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgKEG3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 01:29:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728966AbgKEG3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 01:29:13 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F3BB2071A;
        Thu,  5 Nov 2020 06:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604557751;
        bh=vCmoc8vxQM+VgnPBpDMozp8+JRj5jr+dIEAwtCGJzgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uB4J/ovFYj/4NbogG5hGA6Q1mu+Dhn2XLKhDqw3mn+Xt4a2jktWaAULQcurI7lIoy
         AUeHxcXowcBTDiCPuLrK64VIJ58rdWM2UR0/0L7IOVXuusRZJa9Ky36WyNzuSINfSV
         3s3jkT+qXEe14a5SDr9smnazYoXU5JdVKio5H/CY=
Date:   Thu, 5 Nov 2020 07:29:07 +0100
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
Message-ID: <20201105062907.GA693781@kroah.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-7-shuo.a.liu@intel.com>
 <20201104190235.GA2855400@kroah.com>
 <20201105031029.GB17702@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105031029.GB17702@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 11:10:29AM +0800, Shuo A Liu wrote:
> On Wed  4.Nov'20 at 20:02:35 +0100, Greg Kroah-Hartman wrote:
> > On Mon, Oct 19, 2020 at 02:17:52PM +0800, shuo.a.liu@intel.com wrote:
> > > --- /dev/null
> > > +++ b/include/uapi/linux/acrn.h
> > > @@ -0,0 +1,56 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > +/*
> > > + * Userspace interface for /dev/acrn_hsm - ACRN Hypervisor Service Module
> > > + *
> > > + * This file can be used by applications that need to communicate with the HSM
> > > + * via the ioctl interface.
> > > + */
> > > +
> > > +#ifndef _UAPI_ACRN_H
> > > +#define _UAPI_ACRN_H
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +/**
> > > + * struct acrn_vm_creation - Info to create a User VM
> > > + * @vmid:		User VM ID returned from the hypervisor
> > > + * @reserved0:		Reserved
> > > + * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
> > > + * @reserved1:		Reserved
> > > + * @uuid:		UUID of the VM. Pass to hypervisor directly.
> > > + * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
> > > + * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
> > > + *			hypervisor directly.
> > > + * @cpu_affinity:	CPU affinity of the VM. Pass to hypervisor directly.
> > > + * @reserved2:		Reserved
> > 
> > Reserved and must be 0?
> 
> Not a must.

That's guaranteed to come back and bite you in the end.  You all have
read the "how to write a good api" document, right?

> > What are they reserved for?
> > 
> > Same for all of the reserved fields, why?
> 
> Some reserved fields are to map layout in the hypervisor side, others
> are for future use.

ioctls should not have these, again, please read the documentation.  If
you need something new in the future, just make a new ioctl.

> > > + */
> > > +struct acrn_vm_creation {
> > > +	__u16	vmid;
> > > +	__u16	reserved0;
> > > +	__u16	vcpu_num;
> > > +	__u16	reserved1;
> > > +	__u8	uuid[16];
> > 
> > We have a userspace-visable uid structure in include/uapi/uuid.h, why
> > not use that?
> 
> we just pass the uuid data from user space to hypervisor. So, we can
> remove a header dependeny with using raw data format.

I do not understand this, please use the built-in kernel types we have.

thanks,

greg k-h
