Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 633302930CF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgJSVxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJSVxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:53:42 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99A2C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:53:41 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id n189so398291vkb.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXy81KDT4uXNFt1CF5rF8K+jFhFvxIhTYzgpCRcBcc8=;
        b=h2QvJjVfSHCK8wLN1+QlQCTYSqisu2DVOiCYLwOL6bUfGZUakLFAHX4bF183yCDnVn
         BMuuNylrHkdx84UtnLarVEb+tW2t6Rr0XMGV3U3nhdabfh/I/LdAPFjTTwphMVIhfv5+
         A12q4M32lzI68E8lmoIwrwIiJVe0qesCGi4Lr0BNH5qy5ASFRVcF6Er0v7CH7nn9/vr5
         G2UdXQsqEbVmsJUrvdRaPdis5vMfpBQWk+3c2eAOfHm3Eqa7wgJx0gtwRzCMU50EtFY9
         RvoScoUv7usmBPyAtgPlEJWBsw5QGXM+z9v7uTdPc0cUQyHkCK2rXvYxDSyRneYgZOLv
         aG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXy81KDT4uXNFt1CF5rF8K+jFhFvxIhTYzgpCRcBcc8=;
        b=RtB+8pExA13em+xtqlhEfz7GT6DdPkKMkubG2OkAojyxnsqtaYcoyxYrlKSZaoKWxl
         HwyhhrvpZgiSHiuZp2QMQ9bigNaBSP94biQnjXuiafQdGWe49+84Z7Jo9OyP3k9ZyWvh
         TgZ7V7t503uJpxkOkYRIQrgnl3SdkO384VaQRHV8nofrQJOIq7PmwZ9uPkPdldjW5H07
         f7smVAwpKX492SPpkiQ4nzeg30Gz9f27S5b+DN+2BMlZfLFc4Fo33K2huVSP+QhO+tGP
         4hpl/vG9YQ5VziBMvW49JazuVOMbDdZGT0cQ1nGCnmpiQSX0a8vf2WASkE/7ZlRDaRk2
         cJ9w==
X-Gm-Message-State: AOAM530nDtXzm6KSlPPg6EVqZW2uO7ndItvZWK2y0rFYzzFnSNwMj1X9
        RwUd9fGTPj95MNGdDL+FtitU+KzjPBX4Y6Kt/OCClA==
X-Google-Smtp-Source: ABdhPJzuudi8vIeauL/8P7hI3Yxo3jQRU9lLVKtBF7uDSXH0u5AAbwAYaYKRq31JnSvOBXvE34D1iazvzcTWXfuFTtI=
X-Received: by 2002:a1f:a2cc:: with SMTP id l195mr1910479vke.15.1603144420766;
 Mon, 19 Oct 2020 14:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201019061803.13298-1-shuo.a.liu@intel.com> <20201019061803.13298-5-shuo.a.liu@intel.com>
In-Reply-To: <20201019061803.13298-5-shuo.a.liu@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 19 Oct 2020 14:53:29 -0700
Message-ID: <CAKwvOd=8L-7v=amcj4bchyOv1i4n5t-HPBCH0zY8G66taz_PYQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/17] x86/acrn: Introduce hypercall interfaces
To:     shuo.a.liu@intel.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 11:18 PM <shuo.a.liu@intel.com> wrote:
>
> From: Shuo Liu <shuo.a.liu@intel.com>
>
> The Service VM communicates with the hypervisor via conventional
> hypercalls. VMCALL instruction is used to make the hypercalls.
>
> ACRN hypercall ABI:
>   * Hypercall number is in R8 register.
>   * Up to 2 parameters are in RDI and RSI registers.
>   * Return value is in RAX register.
>
> Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
> register as direct register constraints, use supported constraint as
> input with a explicit MOV to R8 in beginning of asm.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Originally-by: Yakui Zhao <yakui.zhao@intel.com>
> Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Fengwei Yin <fengwei.yin@intel.com>
> Cc: Zhi Wang <zhi.a.wang@intel.com>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: Yu Wang <yu1.wang@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>
> ---
>  arch/x86/include/asm/acrn.h | 54 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>
> diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
> index a2d4aea3a80d..03e420245505 100644
> --- a/arch/x86/include/asm/acrn.h
> +++ b/arch/x86/include/asm/acrn.h
> @@ -14,4 +14,58 @@ void acrn_setup_intr_handler(void (*handler)(void));
>  void acrn_remove_intr_handler(void);
>  bool acrn_is_privileged_vm(void);
>
> +/*
> + * Hypercalls for ACRN
> + *
> + * - VMCALL instruction is used to implement ACRN hypercalls.
> + * - ACRN hypercall ABI:
> + *   - Hypercall number is passed in R8 register.
> + *   - Up to 2 arguments are passed in RDI, RSI.
> + *   - Return value will be placed in RAX.
> + *
> + * Because GCC doesn't support R8 register as direct register constraints, use
> + * supported constraint as input with a explicit MOV to R8 in beginning of asm.
> + */
> +static inline long acrn_hypercall0(unsigned long hcall_id)
> +{
> +       long result;
> +
> +       asm volatile("movl %1, %%r8d\n\t"
> +                    "vmcall\n\t"
> +                    : "=a" (result)
> +                    : "ir" (hcall_id)
> +                    : "r8", "memory");
> +
> +       return result;
> +}
> +
> +static inline long acrn_hypercall1(unsigned long hcall_id,
> +                                  unsigned long param1)
> +{
> +       long result;
> +
> +       asm volatile("movl %1, %%r8d\n\t"
> +                    "vmcall\n\t"
> +                    : "=a" (result)
> +                    : "ir" (hcall_id), "D" (param1)
> +                    : "r8", "memory");
> +
> +       return result;
> +}
> +
> +static inline long acrn_hypercall2(unsigned long hcall_id,
> +                                  unsigned long param1,
> +                                  unsigned long param2)
> +{
> +       long result;
> +
> +       asm volatile("movl %1, %%r8d\n\t"
> +                    "vmcall\n\t"
> +                    : "=a" (result)
> +                    : "ir" (hcall_id), "D" (param1), "S" (param2)
> +                    : "r8", "memory");
> +
> +       return result;
> +}
> +
>  #endif /* _ASM_X86_ACRN_H */
> --
> 2.28.0
>


-- 
Thanks,
~Nick Desaulniers
