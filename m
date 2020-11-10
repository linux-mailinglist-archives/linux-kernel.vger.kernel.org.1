Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3ACD2AD94E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgKJOxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:53:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbgKJOxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:53:32 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1C1206B2;
        Tue, 10 Nov 2020 14:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605020010;
        bh=YZY1zDR8MG28ywpvZyCPpiTF/6/QlTEkN5tAH8pKXG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=grzTsR+KZJiNR/rPWbdduOFSX7r0lJAUHYs9y88U8Qcn877DvI8EXNt2f7vtKyQlw
         mgBg3ch/UYQ7NMTpEvScFOV6PKF/903cEB1lQj0g9nu52Vvc6PSS3+9tgnxFVckUVF
         AydmdZioinGTAPi6vpWqtnwq0ehv7/JOREH8Rl60=
Date:   Tue, 10 Nov 2020 15:54:26 +0100
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
Message-ID: <X6qpovz2TVpvZjDh@kroah.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-8-shuo.a.liu@intel.com>
 <20201109170940.GA2013864@kroah.com>
 <20201110131419.GG17702@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110131419.GG17702@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:14:19PM +0800, Shuo A Liu wrote:
> > And there really is no validation of
> > any fields?
> 
> Yes. Because HSM driver has little knowledge to do the validation.

What is "HSM driver"?  And you all are ready for fuzzers to break this
into small pieces, right?  No validation of any input parameters feels
really really wrong.  Best of luck!

> > > +struct acrn_regs {
> > > +	struct acrn_gp_regs		gprs;
> > > +	struct acrn_descriptor_ptr	gdt;
> > > +	struct acrn_descriptor_ptr	idt;
> > > +
> > > +	__u64				rip;
> > 
> > As these are all crossing the user/kernel boundry and then on to
> > somewhere "else", you have to specify the endian of all of these, right?
> > 
> > if not, why not?
> 
> The hypervisor and the driver only support X86_64 platform for now. So, the
> endian should be certain.

Then specify it please.

> > > +	__u16			reserved0[3];
> > 
> > What does the reserved fields do?
> 
> To keep same layout with the hypervisor. Because the structure will be
> passed to hypervisor directly.
> 
> > 
> > Is there a pointer to a public document for all of these structures
> > somewhere?
> 
> Unfortunately, no. I have added some documents for some strutures
> in the code via kernel-doc format.

Is this not the hypervisor that this code is for:
	https://projectacrn.org/
?

If not, what is this thing?

If so, how is there not documentation for it?

> > > +	struct acrn_regs	vcpu_regs;
> > > +} __attribute__((aligned(8)));
> > 
> > What does the alignment do here?
> 
> The hypervisor wants to access aligned data block to improve the
> efficiency. Currently, the hypervisor only runs on x86_64 platform.

That's nice, but what do you think that adding this attribute to a
structure provides you?  Have you tested this really is doing what you
think it is doing?

thanks,

greg k-h
