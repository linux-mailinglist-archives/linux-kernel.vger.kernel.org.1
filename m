Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 251EB27F2AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgI3TnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgI3TnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:43:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9C4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 12:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fNwR4loJpOcPOqvCFr9iQ71IjS6ECyG0OPT2OhU3Mk0=; b=mA7GDdq/pfaseO3lyFp3G31rIH
        7xJhuZkz1hnF2WWzjqfCxFhC5RB+gWNqSx0sC6FxkJ52ZGgz9vzhOhp8RBzmRNHW6uE884eMjTMYC
        rHSiqLlPfXz6lqgugkJ0NR1fQ6WLsKcydkaWHeOGkxotJ47gwOIJP7eq62/mlv7YLtCAXeqYV3abN
        4glmVy19bN+yHUcDZDQxqdc6MPtlmWDcOyKsBDADtOyEJH+qdD5xgBUqJyof4wJDNfwOt+3DOGY+X
        MWKtlqKzodbuZzamKgPYqPEMEZYvfSgyG0LiTiEiqvM3Q2OWITPazEW3WNWMC20jGaVWNjUhO8v0U
        brezIxLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNhzu-0007vv-IK; Wed, 30 Sep 2020 19:42:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DAEAC3011F0;
        Wed, 30 Sep 2020 21:42:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C36B22026833C; Wed, 30 Sep 2020 21:42:40 +0200 (CEST)
Date:   Wed, 30 Sep 2020 21:42:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
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
Message-ID: <20200930194240.GH2628@hirez.programming.kicks-ass.net>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
 <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
 <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
 <20200930161036.GY28786@gate.crashing.org>
 <20200930171346.GC2628@hirez.programming.kicks-ass.net>
 <CAKwvOdnpU=w4uStcP+UUr9wfoE5U-hW0cMt1bizcX4zQ4=-gOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

That only tells me it compiles it, not if that (IMO) weird construct is
actually guaranteed to work as expected.

I'd almost dive into the GCC archives to read the back-story to this
'feature', it just seems to weird to me. A well, for another day that.
