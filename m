Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54903294632
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 03:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439861AbgJUBQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 21:16:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:13877 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439855AbgJUBQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 21:16:14 -0400
IronPort-SDR: 1Un73EzYBPoyuGbLmdOysyEGk+O/b+5t2F+sjCQ/zD800N2TjoOP4C4mDR9FuKn0g64MhQ6A6Q
 ZlKg/nzdGlYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="228926060"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="228926060"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 18:16:12 -0700
IronPort-SDR: AiWrXrX0loI69n1OxE36AJmNeQ5t0Qrkjk5zopbBUprrLUka6R0q1mTrXXNGEq9R13PD7cpz9N
 sLRjDeyjJeqQ==
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="523720033"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 18:16:08 -0700
Date:   Wed, 21 Oct 2020 09:16:06 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v5 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201021011606.GB12408@shuo-intel.sh.intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-5-shuo.a.liu@intel.com>
 <20201019221515.GA2875488@rani.riverdale.lan>
 <20201020013809.GA11038@shuo-intel.sh.intel.com>
 <20201020020851.GA2996696@rani.riverdale.lan>
 <20201020023017.GA12408@shuo-intel.sh.intel.com>
 <20201020141602.GD2996696@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201020141602.GD2996696@rani.riverdale.lan>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20.Oct'20 at 10:16:02 -0400, Arvind Sankar wrote:
>On Tue, Oct 20, 2020 at 10:30:17AM +0800, Shuo A Liu wrote:
>> On Mon 19.Oct'20 at 22:08:51 -0400, Arvind Sankar wrote:
>> >On Tue, Oct 20, 2020 at 09:38:09AM +0800, Shuo A Liu wrote:
>> >> On Mon 19.Oct'20 at 18:15:15 -0400, Arvind Sankar wrote:
>> >> >On Mon, Oct 19, 2020 at 02:17:50PM +0800, shuo.a.liu@intel.com wrote:
>> >> >> From: Shuo Liu <shuo.a.liu@intel.com>
>> >> >>
>> >> >> The Service VM communicates with the hypervisor via conventional
>> >> >> hypercalls. VMCALL instruction is used to make the hypercalls.
>> >> >>
>> >> >> ACRN hypercall ABI:
>> >> >>   * Hypercall number is in R8 register.
>> >> >>   * Up to 2 parameters are in RDI and RSI registers.
>> >> >>   * Return value is in RAX register.
>> >> >>
>> >> >> Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
>> >> >> register as direct register constraints, use supported constraint as
>> >> >> input with a explicit MOV to R8 in beginning of asm.
>> >> >>
>> >> >> +static inline long acrn_hypercall0(unsigned long hcall_id)
>> >> >> +{
>> >> >> +	long result;
>> >> >> +
>> >> >> +	asm volatile("movl %1, %%r8d\n\t"
>> >> >> +		     "vmcall\n\t"
>> >> >> +		     : "=a" (result)
>> >> >> +		     : "ir" (hcall_id)
>> >> >
>> >> >Is the hypercall id an unsigned long (64 bits) or an unsigned int (32
>> >> >bits)? This will generate broken assembly if the "r" option is chosen,
>> >> >eg something like
>> >> >	movl %rdi, %r8d
>> >>
>> >> Yes, it can be an unsigned long. So do MOV explicitly.
>> >>
>> >> 	asm volatile("movq %1, %%r8\n\t"
>> >> 		     "vmcall\n\t"
>> >> 		     : "=a" (result)
>> >> 		     : "ir" (hcall_id)
>> >>
>> >> Thanks
>> >
>> >All the hypercall ID's defined seem to be only 32 bits though?
>>
>> Yes, they are.
>> The paramter is unsigned long, use movq to align it.
>
>I don't understand what you mean by alignment here, but I was asking why
>hcall_id is unsigned long and not unsigned int (or u32) if you only need
>32 bits?

The hypervisor is using R8 as the input of hcall_id. So i just want to
keep it consistent.
