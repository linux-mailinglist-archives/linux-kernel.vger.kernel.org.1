Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1805027F2C8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgI3T7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3T7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:59:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:59:19 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b2so2302981qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mks6MDDi7yd2BTIhsdl1J0SEYReN39X9Xain+N3ujOI=;
        b=qXSW8xAyWH6AITCQBMSHRXNtKxIr0eMBihnFPkxj99/WpekGD/dJEojQbo0Spax5ZG
         pS2lNrulQBXK7G6GV6i0IaXQAK3t1t/REBwPaKma2cD99x2toetx7t3GaakFsU3LCx3d
         o1QKtk3Ow7Hry5ywCOc3tQhLD1hI/bWwlhSx1dHOBFaPuVgnk0PVidzyXIA6pXyIlpCI
         HYMi7pT3jHL9GuPZ1AqAC66TQosRFL5Nb2zLij0XU4M/Ci+Vegf5Sd3iESimzSi+zpMd
         xDS13GBLKLASmaCEusY8G72x7o7jP6fMBuuAld5NtgOUADk9jqoOxJxB2CsvO5XqZKnT
         6lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mks6MDDi7yd2BTIhsdl1J0SEYReN39X9Xain+N3ujOI=;
        b=hnmliS40fZ0RYAotrs5V9KK1afyAV19c250Z8IA3VZDm3gI13qd4S2wpq9YjYA8C/f
         sljWkYpSsI1SK4edQYBreBbyD+z/MAXM4g5Z98TQHJjsXcqvLn67oLPl6NrfpMaJUvwd
         oxBpi76bMXOyjFpS+0g7BtJ+9eLpAhGOsvtvnU9dqENbG7tpbLHaIwYwO4Wy83Y7RAWz
         oiBwB4aykHbj3rruqeIIDbAeRbedvGbzuoMvFQ3zlKzRRPraYtgnIpk9Ug6Sg9X31NHD
         dBEg1giXeyjP8JeHdqX2DEewfsL8ngVNz2r6QeX/yLyk89pHUPCtaGk98CUT8wWLIY+f
         rnsg==
X-Gm-Message-State: AOAM531iQk1iERdOe0ykDHwLDUi2t2q+O8SziviPC5gKqMfKuUmF+ed8
        BrxZIfDCkZN5x1uS/RQE738=
X-Google-Smtp-Source: ABdhPJyX3E8io/dokgHaIDQyplmBOmhxwUd5BLgYw9sU+NGA7bfcvsAfUHEitJ/8hJ82k0tgx/nHMg==
X-Received: by 2002:ac8:4442:: with SMTP id m2mr4011127qtn.73.1601495958370;
        Wed, 30 Sep 2020 12:59:18 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z29sm3699419qtj.79.2020.09.30.12.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 12:59:17 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 30 Sep 2020 15:59:15 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20200930195915.GA3180913@rani.riverdale.lan>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
 <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
 <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
 <20200930161036.GY28786@gate.crashing.org>
 <20200930171346.GC2628@hirez.programming.kicks-ass.net>
 <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 12:14:03PM -0700, Nick Desaulniers wrote:
> On Wed, Sep 30, 2020 at 10:13 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Sep 30, 2020 at 11:10:36AM -0500, Segher Boessenkool wrote:
> >
> > > Since this variable is a local register asm, on entry to the asm the
> > > compiler guarantees that the value lives in the assigned register (the
> > > "r8" hardware register in this case).  This all works completely fine.
> > > This is the only guaranteed behaviour for local register asm (well,
> > > together with analogous behaviour for outputs).

How strict is the guarantee? This is an inline function -- could the
compiler decide to reorder some other code in between the r8 assignment
and the asm statement when it gets inlined?

> >
> > Right, that's what they're trying to achieve. The hypervisor calling
> > convention needs that variable in %r8 (which is somewhat unfortunate).
> >
> > AFAIK this is the first such use in the kernel, but at least the gcc-4.9
> > (our oldest supported version) claims to support this.
> >
> > So now we need to know if clang will actually do this too..
> 
> Does clang support register local storage? Let's use godbolt.org to find out:
> https://godbolt.org/z/YM45W5
> Looks like yes. You can even check different GCC versions via the
> dropdown in the top right.
> 
> The -ffixed-* flags are less well supported in Clang; they need to be
> reimplemented on a per-backend basis. aarch64 is relatively well
> supported, but other arches not so much IME.
> 
> Do we need register local storage here?
> 
> static inline long bar(unsigned long hcall_id)
> {
>   long result;
>   asm volatile("movl %1, %%r8d\n\t"
>   "vmcall\n\t"
>     : "=a" (result)
>     : "ir" (hcall_id)
>     : );
>   return result;
> }

This seems more robust, though you probably need an r8 clobber in there?
Is hcall_id actually just 32 bits or can it be >=2^32?
