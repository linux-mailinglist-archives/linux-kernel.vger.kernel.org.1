Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96827A08A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 12:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgI0KxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 06:53:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgI0KxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 06:53:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21E1823977;
        Sun, 27 Sep 2020 10:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601203984;
        bh=Ja8fwudHZ9eSuZpOp+5arGBMAbcMtZTQI8S29vEhwoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GfXB/WJDgnR0j1zfklNPUTd8RjWhUpRA8k1jJ/RsF12rTP6VwqW7D0komSjNGLxXc
         fzB5FsL4REyxdaVBbFvCKCFKUlNEaTzOvh+02XU+ntGmIWHxfGP54G+ezHOvmjL2YQ
         nkWHTtShowx7Wu95siVyrRRRRX5gqCUrv9ePPomk=
Date:   Sun, 27 Sep 2020 12:53:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20200927105314.GH88650@kroah.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927105152.GG88650@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 12:51:52PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 22, 2020 at 07:42:58PM +0800, shuo.a.liu@intel.com wrote:
> > From: Shuo Liu <shuo.a.liu@intel.com>
> > 
> > The Service VM communicates with the hypervisor via conventional
> > hypercalls. VMCALL instruction is used to make the hypercalls.
> > 
> > ACRN hypercall ABI:
> >   * Hypercall number is in R8 register.
> >   * Up to 2 parameters are in RDI and RSI registers.
> >   * Return value is in RAX register.
> > 
> > Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
> > register as direct register constraints, here are two ways to use R8 in
> > extended asm:
> >   1) use explicit register variable as input
> >   2) use supported constraint as input with a explicit MOV to R8 in
> >      beginning of asm
> > 
> > The number of instructions of above two ways are same.
> > Asm code from 1)
> >   38:   41 b8 00 00 00 80       mov    $0x80000000,%r8d
> >   3e:   48 89 c7                mov    %rax,%rdi
> >   41:   0f 01 c1                vmcall
> > Here, writes to the lower dword (%r8d) clear the upper dword of %r8 when
> > the CPU is in 64-bit mode.
> > 
> > Asm code from 2)
> >   38:   48 89 c7                mov    %rax,%rdi
> >   3b:   49 b8 00 00 00 80 00    movabs $0x80000000,%r8
> >   42:   00 00 00
> >   45:   0f 01 c1                vmcall
> > 
> > Choose 1) for code simplicity and a little bit of code size
> > optimization.
> > 
> > Originally-by: Yakui Zhao <yakui.zhao@intel.com>
> > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> > Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Fengwei Yin <fengwei.yin@intel.com>
> > Cc: Zhi Wang <zhi.a.wang@intel.com>
> > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> > Cc: Yu Wang <yu1.wang@intel.com>
> > Cc: Reinette Chatre <reinette.chatre@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  arch/x86/include/asm/acrn.h | 57 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> > 
> > diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
> > index a2d4aea3a80d..23a93b87edeb 100644
> > --- a/arch/x86/include/asm/acrn.h
> > +++ b/arch/x86/include/asm/acrn.h
> > @@ -14,4 +14,61 @@ void acrn_setup_intr_handler(void (*handler)(void));
> >  void acrn_remove_intr_handler(void);
> >  bool acrn_is_privileged_vm(void);
> >  
> > +/*
> > + * Hypercalls for ACRN
> > + *
> > + * - VMCALL instruction is used to implement ACRN hypercalls.
> > + * - ACRN hypercall ABI:
> > + *   - Hypercall number is passed in R8 register.
> > + *   - Up to 2 arguments are passed in RDI, RSI.
> > + *   - Return value will be placed in RAX.
> > + */
> > +static inline long acrn_hypercall0(unsigned long hcall_id)
> > +{
> > +	register long r8 asm("r8");
> > +	long result;
> > +
> > +	/* Nothing can come between the r8 assignment and the asm: */
> > +	r8 = hcall_id;
> > +	asm volatile("vmcall\n\t"
> > +		     : "=a" (result)
> > +		     : "r" (r8)
> > +		     : );
> 
> What keeps an interrupt from happening between the r8 assignment and the
> asm: ?
> 
> Is this something that most hypercalls need to handle?  I don't see
> other ones needing this type of thing, is it just because of how these
> are defined?

Ah, the changelog above explains this.  You should put that in the code
itself, as a comment, otherwise we will not know this at all in 5
years, when gcc is changed to allow r8 access :)

thanks,

greg k-h
