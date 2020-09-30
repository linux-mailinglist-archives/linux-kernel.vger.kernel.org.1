Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2062327F003
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730946AbgI3ROC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgI3ROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:14:02 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40749C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jHJKA7hRgaPNpuVo+JQEXlbcePRjLmXaQK6+uYVPf5U=; b=xUv1tuP0GJfvVAp8Hu1FBevrZ1
        wVjQl9bChDFftl9Mvl98meYy7quCy+XLCzzyZZPkxXgXbOQL/BXiGfAZSaNDMPywr2MFc71nYoJ+8
        81F8aEu1BiPr9fWZ2IboibRUbVTlwE6lai0tR9A3XRSVOyEW4Zmq89GcSHk4NGc3DUsTsJgAcB3xU
        w8aBp4gBPlYOemJmqSbaTvnZS9tHXVeOenogaJ4C7G7fUorMCreyqNrQv5CpiHbuF1v8/zRAtXFFW
        s5gFiKBj5e3iKAbu1SjLoIeQpOpJ+unhjtZICX25qeix6NcaGjdYVM+t7MgOfUvoB9aY3tfGrxCBI
        5RHUhG1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNffo-0004i1-Ef; Wed, 30 Sep 2020 17:13:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CBD783003D8;
        Wed, 30 Sep 2020 19:13:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B2DA120419079; Wed, 30 Sep 2020 19:13:46 +0200 (CEST)
Date:   Wed, 30 Sep 2020 19:13:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        shuo.a.liu@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
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
        Zhenyu Wang <zhenyuw@linux.intel.com>, ndesaulniers@google.com
Subject: Re: [PATCH v4 04/17] x86/acrn: Introduce hypercall interfaces
Message-ID: <20200930171346.GC2628@hirez.programming.kicks-ass.net>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-5-shuo.a.liu@intel.com>
 <20200927105152.GG88650@kroah.com>
 <6f9a2b83-6904-2290-6c4f-526672390beb@intel.com>
 <20200930111612.GZ2628@hirez.programming.kicks-ass.net>
 <20200930161036.GY28786@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930161036.GY28786@gate.crashing.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 11:10:36AM -0500, Segher Boessenkool wrote:

> Since this variable is a local register asm, on entry to the asm the
> compiler guarantees that the value lives in the assigned register (the
> "r8" hardware register in this case).  This all works completely fine.
> This is the only guaranteed behaviour for local register asm (well,
> together with analogous behaviour for outputs).

Right, that's what they're trying to achieve. The hypervisor calling
convention needs that variable in %r8 (which is somewhat unfortunate).

AFAIK this is the first such use in the kernel, but at least the gcc-4.9
(our oldest supported version) claims to support this.

So now we need to know if clang will actually do this too..
