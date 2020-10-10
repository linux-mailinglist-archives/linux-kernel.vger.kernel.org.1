Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2933A28A3D9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbgJJWzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731469AbgJJT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:26:27 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AADEC0613BD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 12:26:27 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d1so10731494qtr.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 12:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=54DVg7MWEoJJAfNQcaZ/koB1922/x9y28JrUy2stPgQ=;
        b=q8WwDAFqzpfgysHwkvDMNdZpKXmnfa4IZfAlw40d1/e+4NN+OxfQSeBPVe8IHMHS1E
         db2djr+Df+VBpwEitRKoMjg4f5yozoaWqMXZczDAMuYKh2J5KfdQd0irfPciu4KVOg8r
         169N7uu5ny4JsiN7ezMWX7LjunPhk0vT7Uu0Rz9HAXY3iyaBDtOZNWNg0Lw3mA0BkFcO
         8Fpm44yqDA9ZyLIgeDdG/jtGHopW4F4n31rxWiuwJnz6m4Ey+q/HS/7mI2Rg4Bw2xc3p
         NVfCnVWbVUwANZznyKJ82gYRsJUZ+Touxy+x5FmHJ22T+mRstN/2j5dbjLp7347IigCJ
         rQyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=54DVg7MWEoJJAfNQcaZ/koB1922/x9y28JrUy2stPgQ=;
        b=q4vWrxfqGBWZ8hljPQYpqVjjbvVWzjDG2sdxv/0Sx9TJsjLWMsf7fmZs/Px7Nnvjff
         5CSNj3KRrnIu4+lafA9N/MLy/aMCf8UF8u+lGuUfMYLwimGE8/EYsnDqjSE55wuL47i+
         Y6NpkDcm2b0WiJQI1siJSsWfeh/KBSv4J5jTrzVwTqEivfUtzuCnFybtN77l1sH4EIwB
         5eJy/XmlOCyFUp7v0Nu1HYeGrymVVEEYCAf7RT2lmDwB/BL/ldbnhY0qYAkSjkjIO/QN
         H7wMwzCIjzhvIMuZgFBTtve8E59r708w9ltS9DKdGLoywkLNV5MP1e/ZWDtTG3mTGHDh
         B0CA==
X-Gm-Message-State: AOAM531i5hkhQhAzp3yiksnNtqizXBe7O+a2HYS8e9fw7uX4p+Y+HvzJ
        qVUwSBxKWRsbX20hFzh4Fhc=
X-Google-Smtp-Source: ABdhPJyXqrPqtqeV9cOdlWcqFMBJGftaqnvcSYW3XjUdq1/EgHu0/YDDGjG+rKRRrRDUjVMqeArH4A==
X-Received: by 2002:ac8:1199:: with SMTP id d25mr3741275qtj.260.1602357986286;
        Sat, 10 Oct 2020 12:26:26 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 29sm8192791qks.28.2020.10.10.12.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 12:26:25 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 10 Oct 2020 15:26:24 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH] x86/boot/64: Initialize 5-level paging variables earlier
Message-ID: <20201010192624.GA4062867@rani.riverdale.lan>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
 <20201010191110.4060905-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201010191110.4060905-1-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 03:11:10PM -0400, Arvind Sankar wrote:
> Commit
>   ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")
> started using a new set of pagetables even without KASLR.
> 
> After that commit, initialize_identity_maps() is called before the
> 5-level paging variables are setup in choose_random_location(), which
> will not work if 5-level paging is actually enabled.

Note that I don't have hardware that supports 5-level paging, so this
is not actually tested with 5-level, but based on code inspection, it
shouldn't work.

> 
> Fix this by moving the initialization of __pgtable_l5_enabled,
> pgdir_shift and ptrs_per_p4d into cleanup_trampoline(), which is called
> immediately after the finalization of whether the kernel is executing
> with 4- or 5-level paging. This will be earlier than anything that might
> require those variables, and keeps the 4- vs 5-level paging code all in
> one place.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/ident_map_64.c |  6 ------
>  arch/x86/boot/compressed/kaslr.c        |  8 --------
>  arch/x86/boot/compressed/pgtable_64.c   | 16 ++++++++++++++++
>  3 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index a3613857c532..505d6299b76e 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -34,12 +34,6 @@
>  #define __PAGE_OFFSET __PAGE_OFFSET_BASE
>  #include "../../mm/ident_map.c"
>  
> -#ifdef CONFIG_X86_5LEVEL
> -unsigned int __pgtable_l5_enabled;
> -unsigned int pgdir_shift = 39;
> -unsigned int ptrs_per_p4d = 1;
> -#endif
> -
>  /* Used by PAGE_KERN* macros: */
>  pteval_t __default_kernel_pte_mask __read_mostly = ~0;
>  
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 489fabc051d7..9eabd8bc7673 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -835,14 +835,6 @@ void choose_random_location(unsigned long input,
>  		return;
>  	}
>  
> -#ifdef CONFIG_X86_5LEVEL
> -	if (__read_cr4() & X86_CR4_LA57) {
> -		__pgtable_l5_enabled = 1;
> -		pgdir_shift = 48;
> -		ptrs_per_p4d = 512;
> -	}
> -#endif
> -
>  	boot_params->hdr.loadflags |= KASLR_FLAG;
>  
>  	if (IS_ENABLED(CONFIG_X86_32))
> diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
> index 46d761f7faa6..0976c2d2ab2f 100644
> --- a/arch/x86/boot/compressed/pgtable_64.c
> +++ b/arch/x86/boot/compressed/pgtable_64.c
> @@ -9,6 +9,13 @@
>  #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
>  #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
>  
> +#ifdef CONFIG_X86_5LEVEL
> +/* __pgtable_l5_enabled needs to be in .data to avoid being cleared along with .bss */
> +unsigned int __section(.data) __pgtable_l5_enabled;
> +unsigned int __section(.data) pgdir_shift = 39;
> +unsigned int __section(.data) ptrs_per_p4d = 1;
> +#endif
> +
>  struct paging_config {
>  	unsigned long trampoline_start;
>  	unsigned long l5_required;
> @@ -195,4 +202,13 @@ void cleanup_trampoline(void *pgtable)
>  
>  	/* Restore trampoline memory */
>  	memcpy(trampoline_32bit, trampoline_save, TRAMPOLINE_32BIT_SIZE);
> +
> +	/* Initialize variables for 5-level paging */
> +#ifdef CONFIG_X86_5LEVEL
> +	if (__read_cr4() & X86_CR4_LA57) {
> +		__pgtable_l5_enabled = 1;
> +		pgdir_shift = 48;
> +		ptrs_per_p4d = 512;
> +	}
> +#endif
>  }
> -- 
> 2.26.2
> 
