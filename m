Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC28293102
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387964AbgJSWPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbgJSWPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:15:20 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBD1C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:15:19 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h21so1782580iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Gc/ZkIGgkUYPB5yLUGA8z+Z0CCfptmzuUThwcUmA1c=;
        b=s0tbJr5l2nL7cSNQ7TlcK7XeDw87PTfR/Y4orDNKVAh8A0pz0OX2kwAsbOTcm9srW7
         TJwqL9CI7qPnFwuORtRYGoi+e816Z26/ydwFoyQunhEArSXlufTcd5APG49GiqewR21W
         yW6HMpdj0w4DnABng47w6VwGQ4PkvVfQJAuC5CFFKv6RhQ1EklVgRm/H5EZHFotfFRd5
         IU1aO4dxOdwUeesxHAvuuJ8EUgHRaCg8+ifo30ohoXS/0UckAF9BdPFQ2QnmznUGdHaQ
         m1nlqJlzHOd7tlxV2ulVQtP07CffG8RmTny+2OxCIsJBUYEcHiY3vxopMvBd/iqT8BH5
         iryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=6Gc/ZkIGgkUYPB5yLUGA8z+Z0CCfptmzuUThwcUmA1c=;
        b=tWgCLmp4kKKkzSM4r7rgTRCzx+CyxQWLUeoP5uNv1c9eZOVj2iuP5/76/GpVsm9nXq
         xFtejNxDRzc0zvlbDqBgeHJ/awz42xiT8gZVKdtMEkUwQe+D4BaWgmC2Y8fwIcDWEgR9
         JzkggzTuUSKZhWEZYf8itGKGWpPHQsYsuTghqrUOSGmNgEINj9SUUy5P1DMjEp301rKc
         megZsPddTQa0UcIHkbFb6a1YnUtqz+sF3R14c+sUao5bvASvzM63bjvQuEmm7sHcRC+q
         ZNpxQMMKChjYxrwyFPRyXXNiXEcaEKEI/hdT4zqAjC4Lmo7nFZddgiwGyD72Mth32xZP
         ZB2g==
X-Gm-Message-State: AOAM533Uf4hQR9bTjQz6YYNUgQXI/4I9LkynviMm/BV8oxDWilGfE85r
        I9D0LDklc32yWAOsmYNUriU=
X-Google-Smtp-Source: ABdhPJzGaWrpTL1wc0yKRDDiViilDuEslJxw+5vG8Y6SNJd9pm33mln8fxVYlFicSWka8mqqe9XkIA==
X-Received: by 2002:a02:7685:: with SMTP id z127mr1700105jab.45.1603145718335;
        Mon, 19 Oct 2020 15:15:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y3sm1074859ilc.49.2020.10.19.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:15:17 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 19 Oct 2020 18:15:15 -0400
To:     shuo.a.liu@intel.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v5 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201019221515.GA2875488@rani.riverdale.lan>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-5-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019061803.13298-5-shuo.a.liu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 02:17:50PM +0800, shuo.a.liu@intel.com wrote:
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
> 
> +static inline long acrn_hypercall0(unsigned long hcall_id)
> +{
> +	long result;
> +
> +	asm volatile("movl %1, %%r8d\n\t"
> +		     "vmcall\n\t"
> +		     : "=a" (result)
> +		     : "ir" (hcall_id)

Is the hypercall id an unsigned long (64 bits) or an unsigned int (32
bits)? This will generate broken assembly if the "r" option is chosen,
eg something like
	movl %rdi, %r8d

> +		     : "r8", "memory");
> +
> +	return result;
> +}
> +
> +static inline long acrn_hypercall1(unsigned long hcall_id,
> +				   unsigned long param1)
> +{
> +	long result;
> +
> +	asm volatile("movl %1, %%r8d\n\t"
> +		     "vmcall\n\t"
> +		     : "=a" (result)
> +		     : "ir" (hcall_id), "D" (param1)
> +		     : "r8", "memory");
> +
> +	return result;
> +}
> +
> +static inline long acrn_hypercall2(unsigned long hcall_id,
> +				   unsigned long param1,
> +				   unsigned long param2)
> +{
> +	long result;
> +
> +	asm volatile("movl %1, %%r8d\n\t"
> +		     "vmcall\n\t"
> +		     : "=a" (result)
> +		     : "ir" (hcall_id), "D" (param1), "S" (param2)
> +		     : "r8", "memory");
> +
> +	return result;
> +}
> +
>  #endif /* _ASM_X86_ACRN_H */
> -- 
> 2.28.0
> 
