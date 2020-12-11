Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25212D6CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394292AbgLKBFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388115AbgLKBEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:04:33 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2929DC0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:03:53 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t3so5965520pgi.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gRAABGxDXNyht01AwqCVen+VNx8koj/AyEw1DNWfeno=;
        b=GuoAZ3c4sxU7UvhZHwNyRUy5ZjQsJCbKDH5620MPq6gLNEzGtVgKY6J+PC7MohqgzW
         y+1Q0TvAtvzUekzDwER2GDzHor1oQErJ7MVgN+nxBUmuIaOEwIBUflDr0VzphSQQt3YX
         PwK/mJ2G3Mwj0MP5hyNNnAHt9+pgli9xEXq+Eki13zXSr5GYtZeOLcc1XKDneTPnnmfp
         RLNGsIfevifvpGpMsQv5pLlBxJOx0nYzN32ryqqLZXHjtsQYe8dSePTsZTVyGXvTk1xY
         uFT7KyplABRCEzHUmYM0pTjmP93B4ucgR5ick/sab9BhroTIPXbyshNQ196cpr6W3yKw
         MvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gRAABGxDXNyht01AwqCVen+VNx8koj/AyEw1DNWfeno=;
        b=GN65ClSdRzAqBQlJSGOUTreo5F5hdpG00hpw54uq6E5tWVfYwTz68aBkj5Vs2Rsg3T
         B5Nk9ipYuOXKjRkT77BDO/7IeCS8b7BDdZ8tpjepNvbMjqa2jZP9lCLzktbaG1/8G1mJ
         JxxzwTckevhEAea2iNMubknpuP7dq8qe8Ci0G/9dKgNRR2EE4+uS/5Z2giaXPJJgQ0iT
         8lvRVVcfxcvjH4KZ8lB0hPJJ87ifnWS44rzMdkH1DzQwl11PKDZXMRmxZ7UG+BH4CT7E
         GUWJ4RYaXqHCwIoI8O2HxYyw0ybQ2mFb50NfUDNUKIvVqA5RPxJIyp3aCrouSlPIyEV3
         yQ/Q==
X-Gm-Message-State: AOAM533XbG4T8ODwZfENZ7FaGIYXuV72fe9vtyNrK5RNQktQrpGgsHMg
        dVtud/gu7P6rP49BCN6klZQxrw==
X-Google-Smtp-Source: ABdhPJz+WKhv8QQj14gUd83tiDTU+7RfRXK8FIopxaby6kdMc73H/THdo1/M6DGmch6ftnRMeTfqbA==
X-Received: by 2002:a62:1506:0:b029:19e:aca2:4ed8 with SMTP id 6-20020a6215060000b029019eaca24ed8mr6425373pfv.27.1607648632566;
        Thu, 10 Dec 2020 17:03:52 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id j8sm8061240pji.1.2020.12.10.17.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 17:03:51 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:03:44 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        pbonzini@redhat.com, sean.j.christopherson@intel.com,
        jmattson@google.com, joro@8bytes.org, vkuznets@redhat.com,
        wanpengli@tencent.com, cathy.zhang@intel.com
Subject: Re: [PATCH 2/2] x86: Expose AVX512_FP16 for supported CPUID
Message-ID: <X9LFcPchzKA4cTMF@google.com>
References: <20201208033441.28207-1-kyung.min.park@intel.com>
 <20201208033441.28207-3-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208033441.28207-3-kyung.min.park@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shortlog should use "KVM: x86: ...", and probably s/for/in.  It currently reads
like the kernel is exposing the flag to KVM for KVM's supported CPUID, e.g.:

  KVM: x86: Expose AVX512_FP16 in supported CPUID

On Mon, Dec 07, 2020, Kyung Min Park wrote:
> From: Cathy Zhang <cathy.zhang@intel.com>
> 
> AVX512_FP16 is supported by Intel processors, like Sapphire Rapids.
> It could gain better performance for it's faster compared to FP32
> while meets the precision or magnitude requirement. It's availability
> is indicated by CPUID.(EAX=7,ECX=0):EDX[bit 23].
> 
> Expose it in KVM supported CPUID, then guest could make use of it.

For new features like this that don't require additional KVM enabling, it would
be nice to explicitly state as much in the changelog, along with a brief
explanation of why additional KVM enabling is not necessary.  It doesn't have to
be much, just something to help people that aren't already familiar with FP16
understand what this patch actually exposes to the guest.  E.g. I assume there
are new instructions that are available with FP16?

> Signed-off-by: Cathy Zhang <cathy.zhang@intel.com>
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e83bfe2daf82..d7707cfc9401 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -416,7 +416,7 @@ void kvm_set_cpu_caps(void)
>  		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
>  		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
>  		F(MD_CLEAR) | F(AVX512_VP2INTERSECT) | F(FSRM) |
> -		F(SERIALIZE) | F(TSXLDTRK)
> +		F(SERIALIZE) | F(TSXLDTRK) | F(AVX512_FP16)
>  	);
>  
>  	/* TSC_ADJUST and ARCH_CAPABILITIES are emulated in software. */
> -- 
> 2.17.1
> 
