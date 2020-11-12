Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18312B0250
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgKLJyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgKLJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:54:43 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E765C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jJejUeKLBULZ8PRU4NtuaT8Pq4mGMISunKtpYvXCAVw=; b=GMZUTCxVhDr8JLf2BZZRLQCY5T
        fOGZyhPCNsyL27fL7m64Pr7XMdJD4X5m7/BYqFhYIvh0vLsfwOJTaWfcOKWP484EH0ny/m7b3S3Rm
        EMM7fp2T3K1xIvl0JhVW6MkzMzmWFmSHL9fAdwkm1of3nHkSugomtDwK1R7dBbKebD7K3ua8zdzwm
        Yf/L1TleO5F/J7P+AXOJm80r/UBc8LHW2bzVoeleI4PVREwS0wgz7cOHKJxagp/KyGnfwWY9Z5Fi1
        KyAsGRzKHmDnGdL5KRMAxL8ZZq3cZJ+XRKUQr4LcEjZRasS2kx6ILaGElFcaywgHoqTj5b1pP2FAW
        0o4SX+ag==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kd9Io-0007JG-Ri; Thu, 12 Nov 2020 09:54:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 921D1301324;
        Thu, 12 Nov 2020 10:53:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 849C72BE31E9C; Thu, 12 Nov 2020 10:53:58 +0100 (CET)
Date:   Thu, 12 Nov 2020 10:53:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <20201112095358.GU2628@hirez.programming.kicks-ass.net>
References: <20201111095750.GS2594@hirez.programming.kicks-ass.net>
 <20201111112246.GR2651@hirez.programming.kicks-ass.net>
 <20201111124357.GS2651@hirez.programming.kicks-ass.net>
 <20201111153022.GT17076@casper.infradead.org>
 <20201111155724.GE2628@hirez.programming.kicks-ass.net>
 <20201111163848.GU17076@casper.infradead.org>
 <20201111172253.GG2628@hirez.programming.kicks-ass.net>
 <20201111182620.GW17076@casper.infradead.org>
 <20201111200000.GL2628@hirez.programming.kicks-ass.net>
 <20201111223344.GX17076@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111223344.GX17076@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 10:33:44PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 11, 2020 at 09:00:00PM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 11, 2020 at 06:26:20PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 11, 2020 at 06:22:53PM +0100, Peter Zijlstra wrote:
> > > > On Wed, Nov 11, 2020 at 04:38:48PM +0000, Matthew Wilcox wrote:
> > > > > 	if (pud_leaf(pud))
> > > > > 		return PUD_SIZE;
> > > > 
> > > > But that doesn't handle non-pagetable aligned hugetlb sizes. Granted,
> > > > that's unlikely at the PUD level, but why be inconsistent..
> > > > 
> > > > So we really want:
> > > > 
> > > > 	if (p*d_leaf(p*d)) {
> > > > 		if (!'special') {
> > > > 			page = p*d_page(p*d);
> > > > 			if (PageHuge(page))
> > > > 				return page_size(compound_head(page));
> > > > 		}
> > > > 		return P*D_SIZE;
> > > > 	}
> > > 
> > > Still doesn't work because pages can be mapped at funny offsets.
> > 
> > Wait, what?! Is there hardware that has unaligned TLB page-sizes?
> 
> No, you can force a 2MB page to be mapped at an address which isn't
> 2MB aligned.

But not a HugeTLB page; AFAICT mmap() will reject if you try and mmap a
hugetlb page out of alignment. So what I wrote above is still valid. If
PageHuge() we can be certain it is aligned properly and using a matching
hardware page size.

You just don't like it because you want me to be purely page-table
based.
