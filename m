Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFFF28012D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgJAOXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732096AbgJAOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:23:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92853C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L/OioBrAnE72vE7NNKjJat9jlRhf3Pd5b76Z1cXoMBs=; b=AqOnIz+JxjKzA9r3V819wAxu2G
        cWLI7tWRyoRsBvEit7CQ8Uck/XifqK/6Swk30G1KVDOrzdprvWLvvdvPDqvzQLOEFcQqI0Gw4UmXN
        enJEZXmLbUDxzkJRP/Q1y4gvps4RvDj8SAtR3CbRDc0T3JOODufkrGfW8dOJBBhktKs6KQhpAXlCt
        3wMSVYXmWOx3Qi+HqFhxXvQ1knW96Jmk8Gl4dol32iOUksDXZLGE7gttV+w3346yBlYrMooX3sPLu
        0xqV4m/nqnlPpKMlcqLzEDRpTFbeL2t7ynvK4qTMYS4gmoA0xTi3JLfVG6RJzVyY0O/+LQ57vMwwi
        II3MppYg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kNzUF-0008KO-PW; Thu, 01 Oct 2020 14:23:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B1C6300446;
        Thu,  1 Oct 2020 16:23:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 56CB02038FB7D; Thu,  1 Oct 2020 16:23:08 +0200 (CEST)
Date:   Thu, 1 Oct 2020 16:23:08 +0200
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
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH V8 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201001142308.GR2628@hirez.programming.kicks-ass.net>
References: <20200921152653.3924-1-kan.liang@linux.intel.com>
 <20200921152653.3924-2-kan.liang@linux.intel.com>
 <CABPqkBRYzXH-76BZ3DdxYp7bdyPcr3_WxuxOsJw=1YPE9EwZaw@mail.gmail.com>
 <4e974520-6d0f-68af-7eb8-fa52d95ba77b@linux.intel.com>
 <35e875ba-2c04-8452-5105-ccacf72840d8@intel.com>
 <20200930173042.GD2628@hirez.programming.kicks-ass.net>
 <641fa138-23b7-8fdd-27f9-87e2fdd9fa91@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <641fa138-23b7-8fdd-27f9-87e2fdd9fa91@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 06:49:36AM -0700, Dave Hansen wrote:
> On 9/30/20 10:30 AM, Peter Zijlstra wrote:
> > In general though; I think using ->active_mm is a mistake though. That
> > code should be doing something like:
> > 
> > 
> > 	mm = current->mm;
> > 	if (!mm)
> > 		mm = &init_mm;
> > 
> 
> I was hoping that using ->active_mm would give us the *actual* copy of
> the page tables that's loaded in CR3 for kernel thraeds.  But, there are
> few if any practical advantages of doing that at the moment.

Some of us hate active_mm with a passion and want to remove it entirely
(/me waves at amluto).

Also, if !current->mm, it had better not be accessing anything outside
of the kernel map, so &init_mm should cover that just fine. And given
the kernel maps are shared between all CR3s, they'll see the exact same
pagetables.
