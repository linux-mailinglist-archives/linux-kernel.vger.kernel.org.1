Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B168328BE6B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403909AbgJLQtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390630AbgJLQtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:49:20 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3CFC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:49:20 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c5so14023783qtw.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 09:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fz3M3Q5lqy4NWQrM9j8DhrLb16fhJdHb2FLUeLIM43A=;
        b=tyLr+AnJTN+n93Xf6AqmS80tnbWWcSVY4YJlbbIkPgfMAvujEcCvWc8R5XcuAhWYbB
         SgK7goWvEUc1c7AEohh4H0oEK1g2qj+oOEILeTijeKtx+hxQKOGn72JMatNtXN5LkeNr
         VEJX7wnEo2GrELZD5I887IXGRP6GH9cIVmimtQ6n6i21O3D9TIfN2UR2wmwxyuqnBPvl
         ImOtqz017pzovTn2F7gPLKnmHRTbZTFQ1ecGcZlFG4viBdD2CRt9LXch75G5MRfZd2H2
         3ELUu/gmay/KAVwZKEH/HicZqOzMcWX7DHjYN70/g0JXY/1oZfyeSDpn/nsqgi45hsmP
         8HyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Fz3M3Q5lqy4NWQrM9j8DhrLb16fhJdHb2FLUeLIM43A=;
        b=IPA4e3Lwdt+eD3nbawuwm1fArZATxCNRekJeA5ly6ArSjKn1hOR2Lqf7Mwbgw+vAAL
         MelJo0czWE+vPE/Cx8itJ1m04ptk4y/8KMq2Vsck3Xh/VXmZfnhHyD+JxlBeOuGE7qgq
         AcX9cI/WDaPQoJKdgD2F8VZMBZ0ZJLlIugo22clJIIweaMTqjOgLNXXzdeKUTeRNcVvq
         4KFHslg9Qqd9KzlQkvKGQNy2lufrg/bTZUIJjJ/XE0SMKfLu3x8UlqOYI3z102qv/mwi
         lxhwtPW5JZ4v0V6nqJfv6f3wgQ3CXyxquMOb1hN3NAjtVRnKT1SMWEWL7mTyM7ge6eKJ
         74kA==
X-Gm-Message-State: AOAM5312SXadoy2wRw+fKbuUQcD+JpJqmQx2WSzszUN3sNAXrSMfdXFU
        CxUijBiQapbaEYmhITMzeE8=
X-Google-Smtp-Source: ABdhPJy8630q4kWGSiHgiN4ymnk6ikpPG0lugJ5jBUYcU4oMHQcrqcQuuAho79B+NtK0Kp7WTMs5aw==
X-Received: by 2002:ac8:1b73:: with SMTP id p48mr10822401qtk.293.1602521359727;
        Mon, 12 Oct 2020 09:49:19 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b12sm12537784qtj.12.2020.10.12.09.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 09:49:18 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 12 Oct 2020 12:49:16 -0400
To:     Shuo A Liu <shuo.a.liu@intel.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yakui Zhao <yakui.zhao@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20201012164916.GA613777@rani.riverdale.lan>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
 <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
 <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
 <20200930161036.GY28786@gate.crashing.org>
 <20200930171346.GC2628@hirez.programming.kicks-ass.net>
 <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com>
 <20201012084431.GK1057@shuo-intel.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012084431.GK1057@shuo-intel.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 04:44:31PM +0800, Shuo A Liu wrote:
> On Wed 30.Sep'20 at 12:14:03 -0700, Nick Desaulniers wrote:
> >On Wed, Sep 30, 2020 at 10:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> On Wed, Sep 30, 2020 at 11:10:36AM -0500, Segher Boessenkool wrote:
> >>
> >> > Since this variable is a local register asm, on entry to the asm the
> >> > compiler guarantees that the value lives in the assigned register (the
> >> > "r8" hardware register in this case).  This all works completely fine.
> >> > This is the only guaranteed behaviour for local register asm (well,
> >> > together with analogous behaviour for outputs).
> >>
> >> Right, that's what they're trying to achieve. The hypervisor calling
> >> convention needs that variable in %r8 (which is somewhat unfortunate).
> >>
> >> AFAIK this is the first such use in the kernel, but at least the gcc-4.9
> >> (our oldest supported version) claims to support this.
> >>
> >> So now we need to know if clang will actually do this too..
> >
> >Does clang support register local storage? Let's use godbolt.org to find out:
> >https://godbolt.org/z/YM45W5
> >Looks like yes. You can even check different GCC versions via the
> >dropdown in the top right.
> >
> >The -ffixed-* flags are less well supported in Clang; they need to be
> >reimplemented on a per-backend basis. aarch64 is relatively well
> >supported, but other arches not so much IME.
> >
> >Do we need register local storage here?
> >
> >static inline long bar(unsigned long hcall_id)
> >{
> >  long result;
> >  asm volatile("movl %1, %%r8d\n\t"
> >  "vmcall\n\t"
> >    : "=a" (result)
> >    : "ir" (hcall_id)
> >    : );
> >  return result;
> >}
> 
> Yeah, this approach is also mentioned in the changelog. I will change to
> this way to follow your preference. With an addtional "r8" clobber what
> Arvind mentioned.
> 
> Thanks
> shuo

Btw, I noticed that arch/x86/xen/hypercall.h uses register-local
variables already for its hypercalls for quite some time, so this
wouldn't be unprecedented. [0]

Do these calls also need a memory clobber? The KVM/xen hypercall functions
all have one.

Thanks.

[0] e74359028d548 ("xen64: fix calls into hypercall page")
