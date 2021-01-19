Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9702E2FC01E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbhASThG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbhASTfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:35:46 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F402C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:35:05 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id b3so12927139pft.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eXqV9fARKuqk4sDqyWfCKvyY10Fzq1Iziw7iD+TDihI=;
        b=HMXEgmC8wQCFb/kC8Erg3nYF6JeRPUiTGjxGTsTdjXz5Xh79WL1qzUL4KxKlHK7pxQ
         8GNXaa4VhFTwE6LdIYJ0aPxHNBGjLwDc8ZsdKAdNKBjGb7avxVH8uU0MgoIwMIckg107
         qbRTSJBzkVI3Cluys8+xngZ70aho0F5XQB7VY6MLe0oq0bpQQAkOmccq+zDYJGSvD+nR
         vh8VeCXBSc+xlt+nEWFh59JTeFotScDAQ/3wc+WCwVRvwdesI/C3Jq9D6Z3CKi/rlqD1
         CYZfDrPenf579MvMlyS9AKIBF6fJqIGnlz8+lpLPU1QJWU1PIBLROJdu7z2ctQVoKeAk
         mWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eXqV9fARKuqk4sDqyWfCKvyY10Fzq1Iziw7iD+TDihI=;
        b=gVOiCJ3nBNC6dt/+Nwp7wCBeGF+cfUHGxv4LDwGRopix/e3njKl13lZMZV9mVT4xNg
         2fTG004JKbg9Qlu9w6lG3eBQwwcemdH8t9aDJQdyCQSVcaV65i9sEcTobpjNVuFEFFz6
         p4nTNkiIGZhaHIAem3EaY7SJTIYn/+iYsPr7l+JGpMbgcZ0XV+Ak7mHJDeXF7VK46oCD
         jDGYhlwXdGXYSoJ+jnjKH0O7bN2rp2zNTaM69Sn+kTSoTL0fD1gar5cVmpXAA1BKg3Gz
         M2AxURO94CYXR1q9fJKuWNCR1lFkE+mnNGdLPNQtNd3yfVyWqAvdfbYRkxaZSiH2GWFJ
         tT1Q==
X-Gm-Message-State: AOAM530k/maHDAxtBN/H3W4bWdus5XjZHbW8bihKnIxEFLha8DsjhNT4
        HDRRfjYDKz2+FCz9mzFyrs+evg==
X-Google-Smtp-Source: ABdhPJyVaUMi3QM5fgunw34SWHPdUjFvccvZwpUY2X24xSPN+9uw382QeTI2RaCTvwGaXQYr6tJHZg==
X-Received: by 2002:a62:75d0:0:b029:1b8:ae4d:620c with SMTP id q199-20020a6275d00000b02901b8ae4d620cmr5646338pfc.80.1611084904912;
        Tue, 19 Jan 2021 11:35:04 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id u68sm19484064pfu.195.2021.01.19.11.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:35:04 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:34:57 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Mazur <krzysiek@podlesie.net>,
        Krzysztof =?utf-8?Q?Ol=C4=99dzki?= <ole@ans.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/4] x86/fpu: Add kernel_fpu_begin_mask() to
 selectively initialize state
Message-ID: <YAc0YRGHc5OFw+c/@google.com>
References: <cover.1611077835.git.luto@kernel.org>
 <d3197b2d887dab3bf3d9984e2b74b0146d3568fb.1611077835.git.luto@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3197b2d887dab3bf3d9984e2b74b0146d3568fb.1611077835.git.luto@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021, Andy Lutomirski wrote:
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index eb86a2b831b1..d4a71596c41e 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -121,7 +121,7 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
>  }
>  EXPORT_SYMBOL(copy_fpregs_to_fpstate);
>  
> -void kernel_fpu_begin(void)
> +void kernel_fpu_begin_mask(unsigned int kfpu_mask)
>  {
>  	preempt_disable();
>  
> @@ -141,13 +141,18 @@ void kernel_fpu_begin(void)
>  	}
>  	__cpu_invalidate_fpregs_state();
>  
> -	if (boot_cpu_has(X86_FEATURE_XMM))
> -		ldmxcsr(MXCSR_DEFAULT);
> +	/* Put sane initial values into the control registers. */
> +	if (likely(kfpu_mask & KFPU_MXCSR)) {
> +		if (boot_cpu_has(X86_FEATURE_XMM))
> +			ldmxcsr(MXCSR_DEFAULT);
> +	}
>  
> -	if (boot_cpu_has(X86_FEATURE_FPU))
> -		asm volatile ("fninit");
> +	if (unlikely(kfpu_mask & KFPU_387)) {
> +		if (boot_cpu_has(X86_FEATURE_FPU))
> +			asm volatile ("fninit");
> +	}

Why not combine these into a single if statement?  Easier on the eyes (IMO), and
would generate a smaller diff.

	if (likely(kfpu_mask & KFPU_MXCSR) && boot_cpu_has(X86_FEATURE_XMM))
		ldmxcsr(MXCSR_DEFAULT);

	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
		asm volatile ("fninit");

>  }
> -EXPORT_SYMBOL_GPL(kernel_fpu_begin);
> +EXPORT_SYMBOL_GPL(kernel_fpu_begin_mask);
>  
>  void kernel_fpu_end(void)
>  {
> -- 
> 2.29.2
> 
