Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06A729C9BC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 21:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1830916AbgJ0UIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 16:08:13 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55130 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504820AbgJ0UIM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 16:08:12 -0400
Received: from zn.tnic (p200300ec2f0dae0027de8a0d2c2515c8.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:ae00:27de:8a0d:2c25:15c8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AF33A1EC03C1;
        Tue, 27 Oct 2020 21:08:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1603829290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+i5e7y4zrzzXLxL+wnxdCVox1HHvWMsATZ7U/XZnHdA=;
        b=Mkla+x/UCwglP/js+4HkoEspPrCtO4l/TZWsSuX3Ywdn1ccMJyrMVZD9U4N4c5p112N5oK
        0DqMjlh8YVSHF9d00O3KRmNHWudyp2quh2erQ4sSFPwOqG98JzKPdwFSYtVo3IhR9UH7+v
        SEk+jvSTfKBhoPhdiBnyMXqGeqvTIoE=
Date:   Tue, 27 Oct 2020 21:08:03 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/build: Fix vmlinux size check on 64-bit
Message-ID: <20201027200803.GL15580@zn.tnic>
References: <20201005151539.2214095-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005151539.2214095-1-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:15:39AM -0400, Arvind Sankar wrote:
> Commit b4e0409a36f4 ("x86: check vmlinux limits, 64-bit") added a check
> that the size of the 64-bit kernel is less than KERNEL_IMAGE_SIZE.
> 
> The check uses (_end - _text), but this is not enough. The initial PMD
> used in startup_64() (level2_kernel_pgt) can only map upto
> KERNEL_IMAGE_SIZE from __START_KERNEL_map, not from _text.
> 
> The correct check is the same as for 32-bit, since LOAD_OFFSET is
> defined appropriately for the two architectures. Just check
> (_end - LOAD_OFFSET) against KERNEL_IMAGE_SIZE unconditionally.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index bf9e0adb5b7e..b38832821b98 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -454,13 +454,12 @@ SECTIONS
>  	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
>  }
>  
> -#ifdef CONFIG_X86_32
>  /*
>   * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
>   */
>  . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
>  	   "kernel image bigger than KERNEL_IMAGE_SIZE");
> -#else
> +#ifdef CONFIG_X86_64
>  /*
>   * Per-cpu symbols which need to be offset from __per_cpu_load
>   * for the boot processor.
> @@ -470,18 +469,12 @@ INIT_PER_CPU(gdt_page);
>  INIT_PER_CPU(fixed_percpu_data);
>  INIT_PER_CPU(irq_stack_backing_store);
>  
> -/*
> - * Build-time check on the image size:
> - */
> -. = ASSERT((_end - _text <= KERNEL_IMAGE_SIZE),
> -	   "kernel image bigger than KERNEL_IMAGE_SIZE");

So we have this:

SECTIONS
{       
#ifdef CONFIG_X86_32
        . = LOAD_OFFSET + LOAD_PHYSICAL_ADDR;
        phys_startup_32 = ABSOLUTE(startup_32 - LOAD_OFFSET);
#else     
        . = __START_KERNEL;
	^^^^^^^^^^

which sets the location counter to

#define __START_KERNEL          (__START_KERNEL_map + __PHYSICAL_START)

which is 	0xffffffff80000000 + ALIGN(CONFIG_PHYSICAL_START, CONFIG_PHYSICAL_ALIGN)

and that second term after the '+' has effect only when
CONFIG_RELOCATABLE=n and that's not really used on modern kernel configs
as RELOCATABLE is selected by EFI_STUB and RANDOMIZE_BASE depends on at
and and ...

So IOW, in a usual .config we have:

__START_KERNEL_map at 0xffffffff80000000
_text		   at 0xffffffff81000000

So practically and for the majority of configs, the kernel image really
does start at _text and not at __START_KERNEL_map and we map 16Mb which
is 4 PMDs of unused pages. So basically you're correcting that here -
that the number tested against KERNEL_IMAGE_SIZE is 16Mb more.

Yes, no?

Or am I missing some more important aspect and this is more than just a
small correctness fixlet?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
