Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B9027F08A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgI3RbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 13:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3RbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:31:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F12C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 10:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H/zddBw5k8rRBltxjmAh+W4FcRk20ISTJSk1L1Vh3e8=; b=CUAyCeifPauQ9JnJsE3BU2OT5L
        jkALRWP1iK0oLH7Pxa/zMy16Y/I9jBxDE0yvzSFSmWurL3Tmu2xnuLIcwtoGS2Si0L81AFlEZ/6Cf
        7rzvUuD+mH4nQbhF2kfLLQo33NliZCY0hTLilpHsSnDVkNySBeLAyK2jM88+Q1NgXmWEmdKY0FCJV
        U1alxKhIPIttGmo99XCbs9Hec1uy7flhPCRJNfLR8fM/T8PzUBqc3QnXV3yVimWo7Ak+RA2aajo0L
        pmhIm6vc5E9YpOzC0bzifgIXkDKEaWjD0PwHjh08OjmPvmZg/sGA/ykKWRqR4dUqr8akZzvphBsWD
        T45MO74A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNfwC-0006Or-9Y; Wed, 30 Sep 2020 17:30:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 64B4E301179;
        Wed, 30 Sep 2020 19:30:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B65C2026833C; Wed, 30 Sep 2020 19:30:42 +0200 (CEST)
Date:   Wed, 30 Sep 2020 19:30:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        kirill.shutemov@linux.intel.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH V8 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20200930173042.GD2628@hirez.programming.kicks-ass.net>
References: <20200921152653.3924-1-kan.liang@linux.intel.com>
 <20200921152653.3924-2-kan.liang@linux.intel.com>
 <CABPqkBRYzXH-76BZ3DdxYp7bdyPcr3_WxuxOsJw=1YPE9EwZaw@mail.gmail.com>
 <4e974520-6d0f-68af-7eb8-fa52d95ba77b@linux.intel.com>
 <35e875ba-2c04-8452-5105-ccacf72840d8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35e875ba-2c04-8452-5105-ccacf72840d8@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 07:48:48AM -0700, Dave Hansen wrote:
> On 9/30/20 7:42 AM, Liang, Kan wrote:
> >> When I tested on my kernel, it panicked because I suspect
> >> current->active_mm could be NULL. Adding a check for NULL avoided the
> >> problem. But I suspect this is not the correct solution.
> > 
> > I guess the NULL active_mm should be a rare case. If so, I think it's
> > not bad to add a check and return 0 page size.
> 
> I think it would be best to understand why ->active_mm is NULL instead
> of just papering over the problem.  If it is papered over, and this is
> common, you might end up effectively turning off your shiny new feature
> inadvertently.

context_switch() can set prev->active_mm to NULL when it transfers it to
@next. It does this before @current is updated. So an NMI that comes in
between this active_mm swizzling and updating @current will see
!active_mm.

In general though; I think using ->active_mm is a mistake though. That
code should be doing something like:


	mm = current->mm;
	if (!mm)
		mm = &init_mm;


