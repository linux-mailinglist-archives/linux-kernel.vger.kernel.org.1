Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDF29F099
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgJ2Pzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgJ2Pzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:55:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49800C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:55:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s7so3982765iol.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGtliy7VbPDqvRf66jgO8aJRTxLDK5wgVtmzIOeAeWQ=;
        b=gq40u1rBao/eHnvvfgDJG47u3PWI9Hz8wnm4PQZZBz+Jh+lo1gq5gRmcA513QQbBev
         sDWtPHIlKfbp7WT+tzt958R4dGa8o6DeuYTnx1WrMLba59CPCwLuTQfReh9juu1A3NOj
         CR0UZWMGZ8vXU3PfcHX2xsy6slrlAn59O7XCD3zXJPefxfWARG6r2T+caPznDPq/QWV0
         ZLgVezM0JwiKgcIRDIpTX4gRsvJN2OQ3/WYu3yOnAZFf4AdPP28/dLkgFFi++hDdZFTj
         MZ0GFTtbxyBYRbbwK5oSzWJnMagwqD9l399xN0pnIXu+i6UZy5fbLB3JNVZYfpGb7HZl
         CZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BGtliy7VbPDqvRf66jgO8aJRTxLDK5wgVtmzIOeAeWQ=;
        b=C8uvdqjfm7yXNi4uvZ/nC+Xh5H/6FmbPZZ8SYza8+4wDNJV1VWJ/gTzPYwc2tqeL3T
         kkuTI17+z8rmEFU3WZJhfdoS+pgb9GDF3CN/XCh3qw9mV9OR9OCne6dRYR4p8hWSkymr
         7wJ5asilDpwTVL4OEJ9WLCeSvozYfcQLGdAeM4Rl3GZD2cqP10tU8KGjzs5Nmd7v9IsP
         lFckXvemniBjUGt+GzNkMHIl72I8iHC3GzmOmpK7hEcmMUuIN+cuOUToElZX0vGIbfxL
         L7qsaDOntx/sHIwObRM5GPljsl+ayETMeLeb6md4co63C7e3Bn3nPd0Eh66+pD3mDCcJ
         AVFQ==
X-Gm-Message-State: AOAM531t7pJaS6udFSk/1NeGtyWduyt+1vwn+wjmDbgN8ritMA5Cteno
        8E3w3wFLpPfY2o6LHBc0DU4=
X-Google-Smtp-Source: ABdhPJzYY8pa27RFtec4/dspQPw/u3GsTwCfoWzltwxNc7C70k+CqXNF4hRyZ/2usQvSex9X1Oklvw==
X-Received: by 2002:a02:a10f:: with SMTP id f15mr4073738jag.62.1603986952450;
        Thu, 29 Oct 2020 08:55:52 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j85sm2996422ilg.82.2020.10.29.08.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 08:55:51 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 29 Oct 2020 11:55:49 -0400
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/entry/64: Use TEST %reg,%reg instead of CMP $0,%reg
Message-ID: <20201029155549.GA2503344@rani.riverdale.lan>
References: <20201029142915.131752-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201029142915.131752-1-ubizjak@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 03:29:15PM +0100, Uros Bizjak wrote:
> Use TEST %reg,%reg which sets the zero flag in the same way
> as CMP $0,%reg, but the encoding uses one byte less.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

Please use x86/boot/64 or x86/boot/compressed/64 for the commit subject.
x86/entry is used for syscall/exception handler entries in the main
kernel.

> ---
>  arch/x86/boot/compressed/head_64.S | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 017de6cc87dc..e94874f4bbc1 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -241,12 +241,12 @@ SYM_FUNC_START(startup_32)
>  	leal	rva(startup_64)(%ebp), %eax
>  #ifdef CONFIG_EFI_MIXED
>  	movl	rva(efi32_boot_args)(%ebp), %edi
> -	cmp	$0, %edi
> +	testl	%edi, %edi
>  	jz	1f
>  	leal	rva(efi64_stub_entry)(%ebp), %eax
>  	movl	rva(efi32_boot_args+4)(%ebp), %esi
>  	movl	rva(efi32_boot_args+8)(%ebp), %edx	// saved bootparams pointer
> -	cmpl	$0, %edx
> +	testl	%edx, %edx
>  	jnz	1f
>  	/*
>  	 * efi_pe_entry uses MS calling convention, which requires 32 bytes of
> @@ -592,7 +592,7 @@ SYM_CODE_START(trampoline_32bit_src)
>  	movl	%eax, %cr0
>  
>  	/* Check what paging mode we want to be in after the trampoline */
> -	cmpl	$0, %edx
> +	testl	%edx, %edx
>  	jz	1f
>  
>  	/* We want 5-level paging: don't touch CR3 if it already points to 5-level page tables */
> @@ -622,7 +622,7 @@ SYM_CODE_START(trampoline_32bit_src)
>  
>  	/* Enable PAE and LA57 (if required) paging modes */
>  	movl	$X86_CR4_PAE, %eax
> -	cmpl	$0, %edx
> +	testl	%edx, %edx
>  	jz	1f
>  	orl	$X86_CR4_LA57, %eax
>  1:
> -- 
> 2.26.2
> 
