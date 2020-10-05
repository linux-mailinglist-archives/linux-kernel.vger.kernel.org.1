Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 807B0283C95
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgJEQdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgJEQdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:33:14 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F083C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 09:33:14 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07d500f39533324043f5fb.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:d500:f395:3332:4043:f5fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 151311EC02FC;
        Mon,  5 Oct 2020 18:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601915593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=S1Ke8CEgtJH7v+Pl103zCXaYk9IkdKg31DODrYXQFTM=;
        b=kpl3ex9kJQFYzL92Vym/9qZiHltSf/UugWJLs15sqmxGWoCUrX0JkuatI1SFew8WGCdO2V
        BQWIna1k0Qd6jUEBcVAHvJDdBvvS/RsA9NUzJGXAYaAZKD4FQ4RTtIuoa896GeLkRxN/gj
        eB+k70tKOBc6gZDhoBXTqfS0adPCCYI=
Date:   Mon, 5 Oct 2020 18:33:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] x86/mce: Change fault_in_kernel_space() from
 static to global
Message-ID: <20201005163309.GF21151@zn.tnic>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
 <20200930232611.15355-6-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930232611.15355-6-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 04:26:09PM -0700, Tony Luck wrote:
> From: Youquan Song <youquan.song@intel.com>
> 
> Machine check code needs to be able to determine if a faulting address
> is in user or kernel space. There is already a function to do this.
> 
> Change from "static int" to "bool" and add declaration to <asm/traps.h>
> 
> No functional change.
> 
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/traps.h | 2 ++
>  arch/x86/mm/fault.c          | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
> index 714b1a30e7b0..df0b7bfc1234 100644
> --- a/arch/x86/include/asm/traps.h
> +++ b/arch/x86/include/asm/traps.h
> @@ -35,6 +35,8 @@ extern int panic_on_unrecovered_nmi;
>  
>  void math_emulate(struct math_emu_info *);
>  
> +bool fault_in_kernel_space(unsigned long address);
> +
>  #ifdef CONFIG_VMAP_STACK
>  void __noreturn handle_stack_overflow(const char *message,
>  				      struct pt_regs *regs,
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index 35f1498e9832..88ae443e4e5f 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -1081,7 +1081,7 @@ access_error(unsigned long error_code, struct vm_area_struct *vma)
>  	return 0;
>  }
>  
> -static int fault_in_kernel_space(unsigned long address)
> +bool fault_in_kernel_space(unsigned long address)
>  {
>  	/*
>  	 * On 64-bit systems, the vsyscall page is at an address above
> -- 

Yeah, merge this one into the last patch where this function is used.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
