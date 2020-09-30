Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2304727F2D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 22:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729847AbgI3UBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 16:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3UBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 16:01:22 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBBB7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:01:21 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o21so2330169qtp.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W59D4U8i0w4iou4tn88HJDACfWCvLQJG/SIeb1TRPB8=;
        b=mcrZOZZwDMfCFMq7rlZCWz3nwTfdrFPCcihYx8scO1CSt3aaltdQ2RzKCIYpIcbZ/R
         4KFXwrmYEPpVi//MnsCGx7x2FTeySIA3QMN37W534664YnbidAVqsaawVteogSfX03/h
         hx+SH0SVKWfd40q/31g6+EIM6lZmLTls1U1sLdLdkie4Z8GLdFmrUgy7tO4ilw6mLsDu
         At/C7u6cMzMUOD2Adrh44rDkWhG72EKWCsWLq+1UAV2Y8jRQ1iEh0cxU0jMjk7YMS7/l
         U6tHbRzTEX7m9mlvyDoiMAYcJ7M3uOE04oxlSF1ILOmKoMVpUTJvetdoVKpfq22T5iQp
         ezmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=W59D4U8i0w4iou4tn88HJDACfWCvLQJG/SIeb1TRPB8=;
        b=CT3O48drdZi1I1nduFDsjb7Z7AkgQWasJukyZm1SpUX0IOp2Ww/KjkWm50Hqg38hrF
         022y1NGbZjN5q3s5NZVhMDWb+G0pZOtuz4U9VX7Eco84inXcLHW8erDRLr+OdO8EOxk5
         3Hq12iUdWobGWpbPv8USM5e5hzzkj7G9rpS83I3dH8IzbBn1ZlYJCNjU6AzqLw13ZL0/
         AHQgbuOylpzg5sboXEJZUlMKtfuOxkKX54LJSW2lYb7DYkTXE5MSaYsaQi2+ZKKP4Thm
         LtJp4Ldz4k3tIWr1HHLkFqPFazjrj88JhoegjBKooNknQL/qlbZFCYi9FEfpJasWs5ms
         eUow==
X-Gm-Message-State: AOAM532uuPTciu0RW4KIN13h2L/Z5SEcMbqF4cS4sJbeiPHY2jWLGt1N
        S2c5hMh7Od4uHVsfL4uBYeE=
X-Google-Smtp-Source: ABdhPJxTfH/G/nYvdeOWI2v2MiYi+uFE+QT3YL6HRASk+FjSKxiWfCwoZSegXnv0Gcrxeavw0qc99g==
X-Received: by 2002:ac8:320c:: with SMTP id x12mr4108973qta.122.1601496081100;
        Wed, 30 Sep 2020 13:01:21 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v90sm3710021qtd.66.2020.09.30.13.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 13:01:19 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 30 Sep 2020 16:01:18 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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
Message-ID: <20200930200118.GA3185118@rani.riverdale.lan>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
 <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
 <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
 <20200930161036.GY28786@gate.crashing.org>
 <20200930171346.GC2628@hirez.programming.kicks-ass.net>
 <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com>
 <20200930195915.GA3180913@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200930195915.GA3180913@rani.riverdale.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 03:59:15PM -0400, Arvind Sankar wrote:
> On Wed, Sep 30, 2020 at 12:14:03PM -0700, Nick Desaulniers wrote:
> > On Wed, Sep 30, 2020 at 10:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Sep 30, 2020 at 11:10:36AM -0500, Segher Boessenkool wrote:
> > >
> > > > Since this variable is a local register asm, on entry to the asm the
> > > > compiler guarantees that the value lives in the assigned register (the
> > > > "r8" hardware register in this case).  This all works completely fine.
> > > > This is the only guaranteed behaviour for local register asm (well,
> > > > together with analogous behaviour for outputs).
> 
> How strict is the guarantee? This is an inline function -- could the
> compiler decide to reorder some other code in between the r8 assignment
> and the asm statement when it gets inlined?
> 
> > >
> > > Right, that's what they're trying to achieve. The hypervisor calling
> > > convention needs that variable in %r8 (which is somewhat unfortunate).
> > >
> > > AFAIK this is the first such use in the kernel, but at least the gcc-4.9
> > > (our oldest supported version) claims to support this.
> > >
> > > So now we need to know if clang will actually do this too..
> > 
> > Does clang support register local storage? Let's use godbolt.org to find out:
> > https://godbolt.org/z/YM45W5
> > Looks like yes. You can even check different GCC versions via the
> > dropdown in the top right.
> > 
> > The -ffixed-* flags are less well supported in Clang; they need to be
> > reimplemented on a per-backend basis. aarch64 is relatively well
> > supported, but other arches not so much IME.
> > 
> > Do we need register local storage here?
> > 
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
> This seems more robust, though you probably need an r8 clobber in there?
> Is hcall_id actually just 32 bits or can it be >=2^32?

Also, I think you need memory clobbers for all of these in either case, no?
