Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0318C293E6A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407960AbgJTOQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407953AbgJTOQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:16:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD28C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:16:06 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r9so1086501ioo.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=32BE8Lw2EekcRQTEoc+aBUf5ggWGrIHOAoQDVJrUFIs=;
        b=aKKC/WpSNLS0ZloKX1oIt5oU8woPen0JYuAflN051jkQ6QbgEFy5tcwcgeFPOXV2qT
         pGVXiYjFAxsMb8psGma2DWab3CpNpJKePbjO9DISful0WXJHQJB5H5ff9ITRWsbvYrDi
         ugc+rKZ7OubyjB1DaX5ZSgB4GD/WbaVreTO6TqvpxOhT0n45fAyx7+0s5AOpH7WPtYxc
         X1ffmVh7V0z3PErh0l2iRaKThRarIde/lIgUr004meDGYGTjjIfnqQ8LSF0v4bsfNZNp
         sjuFR3m9AcG5kjLaE1hykvTMuzL7mc1KPkjfceZsYrbJ1t5x63h2BJREJwxbtq6siXfw
         XyJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=32BE8Lw2EekcRQTEoc+aBUf5ggWGrIHOAoQDVJrUFIs=;
        b=WvfvarhIIt34COzoyAQ02ow8exGw3Rq4XWcneiriW0ogmNxL01tv84tgRhUy2YtcVC
         X/VZQTFDJcTGorcqijyGeSLVU+8m/tCJcW8ZFqy2dlej9AwdFoJ2DdElwINDoaoxwF/P
         anfSXZeoOOGKg5Uli00YmVeW7PA4z4BcHB2D+PbqxQp+0BL/R/7OlM0SkpOy7FZGxXHV
         7O5bf1jwnfA1n0MelLsD8kh3dBfkziKxZIC2ki4TRd8vNQZICNuvlyu4HIkFXKg99Y3u
         yHcqUKEN1Rw/qgT1CwB/Dut1Ij8tiAkUuYXUyq4a1vhaRsAgvInquyaC3+GAymxT/z1w
         WjiA==
X-Gm-Message-State: AOAM5302zke+rSDtVKDinWJ/ko2WBuJjgEwZ3bLsfHNKNTIWHUyLPqL8
        AxrFg/K5F9XRJJEVpVQ/uSU=
X-Google-Smtp-Source: ABdhPJxBT1shb+gY5zGfOd1rNyTjxgLfEv55JM5ahsBi3iqTKd75ZVqxsbbFVMPrD5WMLe5cABZThg==
X-Received: by 2002:a6b:7947:: with SMTP id j7mr2327233iop.143.1603203365706;
        Tue, 20 Oct 2020 07:16:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p66sm2253630ilb.48.2020.10.20.07.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 07:16:04 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 20 Oct 2020 10:16:02 -0400
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v5 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201020141602.GD2996696@rani.riverdale.lan>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-5-shuo.a.liu@intel.com>
 <20201019221515.GA2875488@rani.riverdale.lan>
 <20201020013809.GA11038@shuo-intel.sh.intel.com>
 <20201020020851.GA2996696@rani.riverdale.lan>
 <20201020023017.GA12408@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020023017.GA12408@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:30:17AM +0800, Shuo A Liu wrote:
> On Mon 19.Oct'20 at 22:08:51 -0400, Arvind Sankar wrote:
> >On Tue, Oct 20, 2020 at 09:38:09AM +0800, Shuo A Liu wrote:
> >> On Mon 19.Oct'20 at 18:15:15 -0400, Arvind Sankar wrote:
> >> >On Mon, Oct 19, 2020 at 02:17:50PM +0800, shuo.a.liu@intel.com wrote:
> >> >> From: Shuo Liu <shuo.a.liu@intel.com>
> >> >>
> >> >> The Service VM communicates with the hypervisor via conventional
> >> >> hypercalls. VMCALL instruction is used to make the hypercalls.
> >> >>
> >> >> ACRN hypercall ABI:
> >> >>   * Hypercall number is in R8 register.
> >> >>   * Up to 2 parameters are in RDI and RSI registers.
> >> >>   * Return value is in RAX register.
> >> >>
> >> >> Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
> >> >> register as direct register constraints, use supported constraint as
> >> >> input with a explicit MOV to R8 in beginning of asm.
> >> >>
> >> >> +static inline long acrn_hypercall0(unsigned long hcall_id)
> >> >> +{
> >> >> +	long result;
> >> >> +
> >> >> +	asm volatile("movl %1, %%r8d\n\t"
> >> >> +		     "vmcall\n\t"
> >> >> +		     : "=a" (result)
> >> >> +		     : "ir" (hcall_id)
> >> >
> >> >Is the hypercall id an unsigned long (64 bits) or an unsigned int (32
> >> >bits)? This will generate broken assembly if the "r" option is chosen,
> >> >eg something like
> >> >	movl %rdi, %r8d
> >>
> >> Yes, it can be an unsigned long. So do MOV explicitly.
> >>
> >> 	asm volatile("movq %1, %%r8\n\t"
> >> 		     "vmcall\n\t"
> >> 		     : "=a" (result)
> >> 		     : "ir" (hcall_id)
> >>
> >> Thanks
> >
> >All the hypercall ID's defined seem to be only 32 bits though?
> 
> Yes, they are.
> The paramter is unsigned long, use movq to align it.

I don't understand what you mean by alignment here, but I was asking why
hcall_id is unsigned long and not unsigned int (or u32) if you only need
32 bits?
