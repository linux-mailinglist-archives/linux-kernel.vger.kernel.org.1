Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173D927F610
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731803AbgI3XiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbgI3XiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:38:20 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:38:19 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c2so3432997qkf.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AgYc4npDuBt+zck9iEcnIrAixZgVARgELVdpxD0CxxE=;
        b=UsAx/mi1wBYRPuqV0Fh3D/rV4PpBwZ930p4hGKJRcQ8TXU5Tkd/Ufq5HQMG3H1ujMe
         EnFiCNsIPdwswJlV/MqBS1snKMpXArg9EC2KYCdicGto5LSxb9OyJSE4dZm2OCy0Pqif
         7e135aqbtGIiuI/zMWCZGbNZLhl6mPhJ7bmG/J0E2mmdmu10e6Hq2+FUtkdMa/ddLYQB
         gjNrcSFyQ7+5+/fm2Fiq+bweXMxKLnt6Uv/Z4dAxUKIQR9XqarhmErWs4L5dZVK2DLcN
         V7BVZdNFejQYkMg6Kmvm+ZKiv73IQsLLVg7scoFKEWGi4V8ELI9LuyMHoyQ7zZvumU7Q
         gEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AgYc4npDuBt+zck9iEcnIrAixZgVARgELVdpxD0CxxE=;
        b=ZW8FSL41z4UgcTFXufzISBRM71RY2EaiGY7Z1rLwMz+NMlNPbtegzHitB3+HfweNsD
         rG2Kdc89Dpi+mYzagfnsNsLAP//mDUPy21wp6DYEii3Bs4slnMhlApZFSuJQ0PE1N4QX
         FJJbxXRTKV1RC4JV8AqpH7WE5Wh5EWh29JHvmCPcvYTQ7N8Do918khgqUX1VzluxwNrb
         xNa/KlcgWk3+Rb83kf8efuRZIY1drp0S++VJIVRK4tyV8q7JQIdNfeFx7ElxGcKZ48vC
         5Hdzg4qtNDqVFjn+v282AozmJO0KIOezlUTazom6zabSjumgemWN7FSRHeKEiddA0z9L
         898w==
X-Gm-Message-State: AOAM530rdKCyvJBxs+XUsDCyZkwqLItgQXt9HDO4VVzaFO4B0Fka6Qph
        0OKbpFHT79OwkK3j9GZr+lU=
X-Google-Smtp-Source: ABdhPJx9ho9FVOEkSBe6CnqHuC+zibc0iXyQDkl1pk128hJ2sGByNCHwNvhNTq4HQ4dw/u+JZgX2kA==
X-Received: by 2002:ae9:f701:: with SMTP id s1mr5279876qkg.446.1601509098111;
        Wed, 30 Sep 2020 16:38:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z3sm4084723qkj.0.2020.09.30.16.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:38:17 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 30 Sep 2020 19:38:15 -0400
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shuo.a.liu@intel.com, LKML <linux-kernel@vger.kernel.org>,
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
Message-ID: <20200930233815.GA3372783@rani.riverdale.lan>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
 <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
 <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
 <20200930161036.GY28786@gate.crashing.org>
 <20200930171346.GC2628@hirez.programming.kicks-ass.net>
 <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com>
 <20200930232559.GC28786@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930232559.GC28786@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 06:25:59PM -0500, Segher Boessenkool wrote:
> On Wed, Sep 30, 2020 at 12:14:03PM -0700, Nick Desaulniers wrote:
> > Do we need register local storage here?
> 
> Depends what you want.  It looks like you do:
> 
> > static inline long bar(unsigned long hcall_id)
> > {
> >   long result;
> >   asm volatile("movl %1, %%r8d\n\t"
> >   "vmcall\n\t"
> >     : "=a" (result)
> >     : "ir" (hcall_id)
> >     : );
> >   return result;
> > }
> 
> "result" as output from the asm is in %rax, and the compiler will
> shuffle that to wherever it needs it as the function return value.  That
> part will work fine.
> 
> But how you are accessing %r8d is not correct, that needs to be a local
> register asm (or r8 be made a fixed reg, probably not what you want ;-) )
> 

Doesn't it just need an "r8" clobber to allow using r8d?

> 
> Segher
