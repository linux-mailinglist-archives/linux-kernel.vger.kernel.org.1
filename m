Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3D1027A5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 05:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgI1Dix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 23:38:53 -0400
Received: from mga09.intel.com ([134.134.136.24]:2207 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1Diw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 23:38:52 -0400
IronPort-SDR: CwQdDTtLZMSCIC5pEv7rHed8Hm4QCvYq3g8DMYEw6p7kWPNfYJZLX1zdNtdVi6Jo4XVgvAzLZ2
 +FSQqa105loA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="162821908"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="162821908"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 20:38:52 -0700
IronPort-SDR: NV693pBxXF8iAtTv683mtj4ZikTsIhoz1VcR8ga4XDN4ByAE5UIb7frihh+hBsAUEWuF1l7gCU
 xYGFXnpIIerg==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488392698"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 20:38:48 -0700
Date:   Mon, 28 Sep 2020 11:38:46 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20200928033846.GB1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
 <20200927105314.GH88650@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200927105314.GH88650@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 27.Sep'20 at 12:53:14 +0200, Greg Kroah-Hartman wrote:
>On Sun, Sep 27, 2020 at 12:51:52PM +0200, Greg Kroah-Hartman wrote:
>> On Tue, Sep 22, 2020 at 07:42:58PM +0800, shuo.a.liu@intel.com wrote:
>> > From: Shuo Liu <shuo.a.liu@intel.com>
>> >
>> > The Service VM communicates with the hypervisor via conventional
>> > hypercalls. VMCALL instruction is used to make the hypercalls.
>> >
>> > ACRN hypercall ABI:
>> >   * Hypercall number is in R8 register.
>> >   * Up to 2 parameters are in RDI and RSI registers.
>> >   * Return value is in RAX register.
>> >
>> > Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
>> > register as direct register constraints, here are two ways to use R8 in
>> > extended asm:
>> >   1) use explicit register variable as input
>> >   2) use supported constraint as input with a explicit MOV to R8 in
>> >      beginning of asm
>> >
>> > The number of instructions of above two ways are same.
>> > Asm code from 1)
>> >   38:   41 b8 00 00 00 80       mov    $0x80000000,%r8d
>> >   3e:   48 89 c7                mov    %rax,%rdi
>> >   41:   0f 01 c1                vmcall
>> > Here, writes to the lower dword (%r8d) clear the upper dword of %r8 when
>> > the CPU is in 64-bit mode.
>> >
>> > Asm code from 2)
>> >   38:   48 89 c7                mov    %rax,%rdi
>> >   3b:   49 b8 00 00 00 80 00    movabs $0x80000000,%r8
>> >   42:   00 00 00
>> >   45:   0f 01 c1                vmcall
>> >
>> > Choose 1) for code simplicity and a little bit of code size
>> > optimization.
>> >
>> > Originally-by: Yakui Zhao <yakui.zhao@intel.com>
>> > Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
>> > Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> > Cc: Dave Hansen <dave.hansen@intel.com>
>> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
>> > Cc: Dan Williams <dan.j.williams@intel.com>
>> > Cc: Fengwei Yin <fengwei.yin@intel.com>
>> > Cc: Zhi Wang <zhi.a.wang@intel.com>
>> > Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>> > Cc: Yu Wang <yu1.wang@intel.com>
>> > Cc: Reinette Chatre <reinette.chatre@intel.com>
>> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> > ---
>> >  arch/x86/include/asm/acrn.h | 57 +++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 57 insertions(+)
>> >
>> > diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
>> > index a2d4aea3a80d..23a93b87edeb 100644
>> > --- a/arch/x86/include/asm/acrn.h
>> > +++ b/arch/x86/include/asm/acrn.h
>> > @@ -14,4 +14,61 @@ void acrn_setup_intr_handler(void (*handler)(void));
>> >  void acrn_remove_intr_handler(void);
>> >  bool acrn_is_privileged_vm(void);
>> >
>> > +/*
>> > + * Hypercalls for ACRN
>> > + *
>> > + * - VMCALL instruction is used to implement ACRN hypercalls.
>> > + * - ACRN hypercall ABI:
>> > + *   - Hypercall number is passed in R8 register.
>> > + *   - Up to 2 arguments are passed in RDI, RSI.
>> > + *   - Return value will be placed in RAX.
>> > + */
>> > +static inline long acrn_hypercall0(unsigned long hcall_id)
>> > +{
>> > +	register long r8 asm("r8");
>> > +	long result;
>> > +
>> > +	/* Nothing can come between the r8 assignment and the asm: */
>> > +	r8 = hcall_id;
>> > +	asm volatile("vmcall\n\t"
>> > +		     : "=a" (result)
>> > +		     : "r" (r8)
>> > +		     : );
>>
>> What keeps an interrupt from happening between the r8 assignment and the
>> asm: ?

Dave gave a good explanation in another email. I will apply his better
comment that "No other C code can come between this r8 assignment and the
inline asm".

>>
>> Is this something that most hypercalls need to handle?  I don't see
>> other ones needing this type of thing, is it just because of how these
>> are defined?
>
>Ah, the changelog above explains this.  You should put that in the code
>itself, as a comment, otherwise we will not know this at all in 5
>years, when gcc is changed to allow r8 access :)

OK. I will copy that into code as well.

Thanks
shuo
