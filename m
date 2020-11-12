Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3762B0730
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgKLOB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgKLOB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:01:59 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F38AC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 06:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JhjirIMC5IXFXZ5DJcRP5LHWteskyIFYmL94ppbFw2M=; b=FQ6gYCfI8+ZHY7MzIioCbQpTtA
        mEY2SM9c+dz8KBuXfv8kVIV1Mb8zsRzGpUw69J0KEs4MuS49hinSzSmM2YdbZ3tlCwnwigPw+Rf+B
        nw5t9ka6icLH4n5/5VJobHR5i/xMGdEwcc6COHBJ4wb6V3IJRINa9M49qDo05VYSCeSnObOKc1ATk
        hA3LKNJFdh8ZKT4ccMk6P6yKA8W75EkQ4kdXsOXkKkj37aPy033agOcymKAUUlcnQFt6sDZw2GDAO
        QW/GClnfAeH+ixSA9O13pDPkr4+1HRBnVL3C1JKXg8t4FnUMhbWEQn0wAHpjI/e4Apyoca7Uoufbf
        zau71J1Q==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdDAN-00059Q-8A; Thu, 12 Nov 2020 14:01:35 +0000
Date:   Thu, 12 Nov 2020 14:01:35 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>, vbabka@suse.cz
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201112140135.GZ17076@casper.infradead.org>
References: <20201111124357.GS2651@hirez.programming.kicks-ass.net>
 <20201111153022.GT17076@casper.infradead.org>
 <20201111155724.GE2628@hirez.programming.kicks-ass.net>
 <20201111163848.GU17076@casper.infradead.org>
 <20201111172253.GG2628@hirez.programming.kicks-ass.net>
 <20201111182620.GW17076@casper.infradead.org>
 <20201111200000.GL2628@hirez.programming.kicks-ass.net>
 <20201111223344.GX17076@casper.infradead.org>
 <20201112095358.GU2628@hirez.programming.kicks-ass.net>
 <20201112113645.GT2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112113645.GT2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 12:36:45PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 12, 2020 at 10:53:58AM +0100, Peter Zijlstra wrote:
> > You just don't like it because you want me to be purely page-table
> > based.
> 
> How's something like this then? I failed to untangle Power's many MMUs
> though :/

Looks good to me.  Might want to rename

> -__weak u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> +static u64 arch_perf_get_page_size(struct mm_struct *mm, unsigned long addr)

to perf_get_tlb_entry_size() or some such.

