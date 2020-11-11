Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67DA2AEEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgKKK1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:27:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727279AbgKKK1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:27:40 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2B720756;
        Wed, 11 Nov 2020 10:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605090459;
        bh=dqwrum0r6OIMej/Q3/yIothR3ux7ksRfgNuHlUhe6KA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ysomY1iaZLsWU4OoJMnRTdanSU+tMtDf8fGBVOoxLRJWrZcenu3NuD2rsaAc8xx+X
         0LVC7vPU1qdhTdOCacXR7XSfgCe57g7K8lYgEg3oyV9vXALE2I3cDeaRAMFDIjDtwO
         YRT4iUTozU7HmIZBu30plq7CmTcKgcQP0MGqpJrY=
Date:   Wed, 11 Nov 2020 11:28:40 +0100
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
Subject: Re: [PATCH v5 07/17] virt: acrn: Introduce an ioctl to set vCPU
 registers state
Message-ID: <X6u82BylaUR8nZec@kroah.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-8-shuo.a.liu@intel.com>
 <20201109170940.GA2013864@kroah.com>
 <20201110131419.GG17702@shuo-intel.sh.intel.com>
 <X6qpovz2TVpvZjDh@kroah.com>
 <20201111095431.GH17702@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111095431.GH17702@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:54:31PM +0800, Shuo A Liu wrote:
> On Tue 10.Nov'20 at 15:54:26 +0100, Greg Kroah-Hartman wrote:
> > On Tue, Nov 10, 2020 at 09:14:19PM +0800, Shuo A Liu wrote:
> > > > And there really is no validation of
> > > > any fields?
> > > 
> > > Yes. Because HSM driver has little knowledge to do the validation.
> > 
> > What is "HSM driver"?  And you all are ready for fuzzers to break this
> > into small pieces, right?  No validation of any input parameters feels
> > really really wrong.  Best of luck!
> 
> This driver is HSM (Hypervisor Service Module) driver.
> Take this hypercall for example. The register values are set by user, we
> can do nothing to verify them. If the values are wrong, the VM will
> crash and the hypervisor will handle that.

Ah, nice, so you are creating a situation where any user can crash the
VM, what can go wrong :(

> > > >
> > > > Is there a pointer to a public document for all of these structures
> > > > somewhere?
> > > 
> > > Unfortunately, no. I have added some documents for some strutures
> > > in the code via kernel-doc format.
> > 
> > Is this not the hypervisor that this code is for:
> > 	https://projectacrn.org/
> > ?
> > 
> > If not, what is this thing?
> > 
> > If so, how is there not documentation for it?
> 
> Oh, yes. We have the structures documentation on the website. Pls refer
> https://projectacrn.github.io/latest/api/hypercall_api.html#
> I meant that some fields of structures might be lack of explanation.

Please work on the documentation of the fields, otherwise it doesn't
really make much sense what is happening here, right?

Along these lines, where is the userspace code that makes all of these
ioctls?  Surely the fields must be documented there, right?

> > > > > +	struct acrn_regs	vcpu_regs;
> > > > > +} __attribute__((aligned(8)));
> > > >
> > > > What does the alignment do here?
> > > 
> > > The hypervisor wants to access aligned data block to improve the
> > > efficiency. Currently, the hypervisor only runs on x86_64 platform.
> > 
> > That's nice, but what do you think that adding this attribute to a
> > structure provides you?  Have you tested this really is doing what you
> > think it is doing?
> 
> It could make the compiler put the data structure at aligned address.

Are you sure this is the correct way to do that?

> In the kernel the structures are almost from kmalloc, so the attribute
> might be not meaningful. But in the hypervisor, there are many such data
> structures in stack or in static pool, this attribute can make sure the
> data structures are located at the aligned address.

This is kernel data, not hypervisor data, in kernel memory.  If you
require the hypervisor to get the structures at a specific alignment in
memory, you better check that in the kernel code, otherwise how can you
ensure it?

thanks,

greg k-h
