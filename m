Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655AE284411
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 04:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725931AbgJFC3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 22:29:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:57393 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgJFC3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 22:29:16 -0400
IronPort-SDR: hvu42kXXUsQZy7mQaZEH0RaFplRZ14iDIFlDqugrHZkVOtk8BhS1+/cHdvpyurZno7lD7Fpbgy
 XyBzpv+VS4ZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="164387625"
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="164387625"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 19:29:13 -0700
IronPort-SDR: vs8xCKhROVLb50SbSUgy0uxm/NVBMI9e9oSq+aKd9cjYQG8pw7FT9rmT5WH3zAynjymWyZptPc
 nfcqeb9foqRQ==
X-IronPort-AV: E=Sophos;i="5.77,341,1596524400"; 
   d="scan'208";a="526994819"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.160])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2020 19:29:13 -0700
Date:   Mon, 5 Oct 2020 19:29:11 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] x86/stackprotector/32: Make the canary into a
 regular percpu variable
Message-ID: <20201006022910.GF15803@linux.intel.com>
References: <cover.1601925251.git.luto@kernel.org>
 <4b3b4fbf8e9806840135e95cef142a0adefc3455.1601925251.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b3b4fbf8e9806840135e95cef142a0adefc3455.1601925251.git.luto@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 12:30:03PM -0700, Andy Lutomirski wrote:
> On 32-bit kernels, the stackprotector canary is quite nasty -- it is
> stored at %gs:(20), which is nasty because 32-bit kernels use %fs for
> percpu storage.  It's even nastier because it means that whether %gs
> contains userspace state or kernel state while running kernel code
> sepends on whether stackprotector is enabled (this is

  depends

> CONFIG_X86_32_LAZY_GS), and this setting radically changes the way
> that segment selectors work.  Supporting both variants is a
> maintenance and testing mess.
> 
> Merely rearranging so that percpu and the stack canary
> share the same segment would be messy as the 32-bit percpu address
> layout isn't currently compatible with putting a variable at a fixed
> offset.
> 
> Fortunately, GCC 8.1 added options that allow the stack canary to be
> accessed as %fs:stack_canary, effectively turning it into an ordinary
> percpu variable.  This lets us get rid of all of the code to manage
> the stack canary GDT descriptor and the CONFIG_X86_32_LAZY_GS mess.
> 
> This patch forcibly disables stackprotector on older compilers that
> don't support the new options and makes the stack canary into a
> percpu variable.

It'd be helpful to explicitly state that the so called "lazy GS" approach is
now always used for i386.

> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---

...

> diff --git a/arch/x86/include/asm/suspend_32.h b/arch/x86/include/asm/suspend_32.h
> index fdbd9d7b7bca..eb872363ca82 100644
> --- a/arch/x86/include/asm/suspend_32.h
> +++ b/arch/x86/include/asm/suspend_32.h
> @@ -16,9 +16,7 @@ struct saved_context {
>  	 * On x86_32, all segment registers, with the possible exception of

Is this still a "possible" exception, or is it now always an exception?

>  	 * gs, are saved at kernel entry in pt_regs.
>  	 */
> -#ifdef CONFIG_X86_32_LAZY_GS
>  	u16 gs;
> -#endif
>  	unsigned long cr0, cr2, cr3, cr4;
>  	u64 misc_enable;
>  	bool misc_enable_saved;

...

> diff --git a/arch/x86/kernel/tls.c b/arch/x86/kernel/tls.c
> index 64a496a0687f..3c883e064242 100644
> --- a/arch/x86/kernel/tls.c
> +++ b/arch/x86/kernel/tls.c
> @@ -164,17 +164,11 @@ int do_set_thread_area(struct task_struct *p, int idx,
>  		savesegment(fs, sel);
>  		if (sel == modified_sel)
>  			loadsegment(fs, sel);
> -
> -		savesegment(gs, sel);
> -		if (sel == modified_sel)
> -			load_gs_index(sel);
>  #endif
>  
> -#ifdef CONFIG_X86_32_LAZY_GS
>  		savesegment(gs, sel);
>  		if (sel == modified_sel)
> -			loadsegment(gs, sel);
> -#endif
> +			load_gs_index(sel);

Side topic, the "index" part of this is super confusing.  I had to reread
this entire patch after discovering load_gs_index is loadsegment on i386.

Maybe also worth a shout out in the changelog?

>  	} else {
>  #ifdef CONFIG_X86_64
>  		if (p->thread.fsindex == modified_sel)
