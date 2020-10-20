Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4762932F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 04:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbgJTCIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 22:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgJTCIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 22:08:55 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB9C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 19:08:54 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id j17so378854ilr.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 19:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iANPbypi+7I6RH/Qlyh4933i59TIryD2WdsHLQH8ITo=;
        b=csBMIJ2iNQfIE3VuHoMeayKfJq29tYGjnKJOqRHLbf4k40KzOdUNPZVV8ZrCKI9XrM
         XL4X7qfdBI71HNfWOX42Z2cuiUP24uc57IN8U/58gcpUY603KAzFeqxO6GTTlu3dQDEb
         aO80AEmGaiPtGf/u4DWrwhrijeyJrve5XO+fGbgehWrvpZg3A+ngW24Ms3GKKN4KUMjh
         RNYVMaYCAFInD6BmTk3qlqhF/+VdCauxbFs9RB1QcVlUjbT41v5iALBiXkSzLPz9Jfp4
         WQlppKr7YYHcsOfvQHMzuspPiqNUs56j73UO2Nhg39ZlKoFsymTF/vjPkgMz0bBdvIzl
         jkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=iANPbypi+7I6RH/Qlyh4933i59TIryD2WdsHLQH8ITo=;
        b=DdJk7s07wAxjkQB8/ZnQCdM33Xie7XZyy80qUUFiONaQxwOG6Ct8oOqmrPmIvPHpQN
         gzI96F09YOrWjHw/y0KKwC76J+3slC4qgauh927KIdCUdi4fGKiF6jgBwasBPFu3v4Xd
         EcCqIutPu49dQzqLhrBcmqj/01GDo8kqdTqoGZ4yYvT+Q+KU4lXRmqGe8jEKsCTwMhY2
         agsIl9pMWe5QZ84VL7hjoYntfnVcgZY8Nt98hCNtwldYCt7TQONilLVOOE6Oau1Q2KT5
         GFH+kCV9xGVsJAIImtRwjvFpf5Se6fZCl1bZV9sZBcWk8UpJkGZWXKn3+/vXBpYTDCMe
         gW4A==
X-Gm-Message-State: AOAM532na4mXKsb58jTToLZDpd5SW1iGLNPeLswsiiFTbsa2ZevxJqbJ
        bbjtuB3/Siy+2ZcDtCKElzw=
X-Google-Smtp-Source: ABdhPJyPpeX3mfbAXSuXeZsoivN0/7Mo+B0l0qZdkCgt+QkySEXTVVBRbH8qwys++orB90d29bB4UA==
X-Received: by 2002:a92:da0e:: with SMTP id z14mr284809ilm.151.1603159734192;
        Mon, 19 Oct 2020 19:08:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 69sm370333iou.42.2020.10.19.19.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 19:08:53 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 19 Oct 2020 22:08:51 -0400
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
Message-ID: <20201020020851.GA2996696@rani.riverdale.lan>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-5-shuo.a.liu@intel.com>
 <20201019221515.GA2875488@rani.riverdale.lan>
 <20201020013809.GA11038@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201020013809.GA11038@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 09:38:09AM +0800, Shuo A Liu wrote:
> On Mon 19.Oct'20 at 18:15:15 -0400, Arvind Sankar wrote:
> >On Mon, Oct 19, 2020 at 02:17:50PM +0800, shuo.a.liu@intel.com wrote:
> >> From: Shuo Liu <shuo.a.liu@intel.com>
> >>
> >> The Service VM communicates with the hypervisor via conventional
> >> hypercalls. VMCALL instruction is used to make the hypercalls.
> >>
> >> ACRN hypercall ABI:
> >>   * Hypercall number is in R8 register.
> >>   * Up to 2 parameters are in RDI and RSI registers.
> >>   * Return value is in RAX register.
> >>
> >> Introduce the ACRN hypercall interfaces. Because GCC doesn't support R8
> >> register as direct register constraints, use supported constraint as
> >> input with a explicit MOV to R8 in beginning of asm.
> >>
> >> +static inline long acrn_hypercall0(unsigned long hcall_id)
> >> +{
> >> +	long result;
> >> +
> >> +	asm volatile("movl %1, %%r8d\n\t"
> >> +		     "vmcall\n\t"
> >> +		     : "=a" (result)
> >> +		     : "ir" (hcall_id)
> >
> >Is the hypercall id an unsigned long (64 bits) or an unsigned int (32
> >bits)? This will generate broken assembly if the "r" option is chosen,
> >eg something like
> >	movl %rdi, %r8d
> 
> Yes, it can be an unsigned long. So do MOV explicitly.
> 
> 	asm volatile("movq %1, %%r8\n\t"
> 		     "vmcall\n\t"
> 		     : "=a" (result)
> 		     : "ir" (hcall_id)
> 
> Thanks

All the hypercall ID's defined seem to be only 32 bits though?
