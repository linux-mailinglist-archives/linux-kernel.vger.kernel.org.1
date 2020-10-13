Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E212628D175
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 17:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbgJMPqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgJMPqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 11:46:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D80DC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e1ca2lcllPJTokKsEHB/HwifffWaWqHFIXBdwVUd9OQ=; b=m9PnhgEje+GEWn9NRUX0Y+dUue
        7ZeBKMOfoMZ83ImDgHwPwtJx6Trepnwz/zzANyXXCUhHam8SqP4ItvpT6ebdgHXo0QP4W9TVPHd8z
        aIwE0ROfHSnQrcpSPngqqgOaPHaV6XNh5yW+jpNSCJP9shBFUQt2uvZFhpKec8S909p35xecAzJ8a
        YBmcww0UOXi9CvEJHe90wwQk+VPen8UV0HP1FGs8hTcJBFjUz6dBxjKRQSC4dy6mzRgxaOzrovX3e
        ct5pmSEMxKdauyalGM9aKvnssWha7UTPcaW8VGfgpefGJM7ELZroTxJq7a4kVpHji6QiNN2yfavqv
        vOF5KyTA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kSMVG-0002Og-7H; Tue, 13 Oct 2020 15:46:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9007B304B90;
        Tue, 13 Oct 2020 17:46:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 446CC2BFFEB05; Tue, 13 Oct 2020 17:46:15 +0200 (CEST)
Date:   Tue, 13 Oct 2020 17:46:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201013154615.GE2594@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <877drz1qbc.fsf@mpe.ellerman.id.au>
 <20201012084829.GA1151@willie-the-truck>
 <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de47984b-9a69-733c-3bd1-7b24ceb9b7f0@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 10:57:41AM -0400, Liang, Kan wrote:
> 
> 
> On 10/12/2020 4:48 AM, Will Deacon wrote:
> > On Sat, Oct 10, 2020 at 12:28:39AM +1100, Michael Ellerman wrote:
> > > Peter Zijlstra <peterz@infradead.org> writes:
> > > > Patch 4 makes it all far worse by exposing it to pretty much everybody.
> > > > 
> > > > Now, I think we can fix at least the user mappings with the below delta,
> > > > but if archs are using non-page-table MMU sizes we'll need arch helpers.
> > > > 
> > > > ARM64 is in that last boat.
> > > 
> > > I think we probably need it to be weak so we can provide our own
> > > version.
> > 
> > I guess the same thing applies to us, but I can't really tell how accurate
> > this stuff needs to be for userspace. If it's trying to use the page-table
> > configuration to infer properties of the TLB, that's never going to be
> > reliable because the TLB can choose both to split and coalesce entries
> > as long as software can't tell.
> > 
> 
> Hi Peter,
> 
> It looks like everybody wants a __weak function. If so, I guess we should
> drop the generic code in this patch. For X86, we have existing functions to
> retrieve the page level and the page size. I think we don't need the generic
> code either.
> https://lkml.kernel.org/r/1549648509-12704-2-git-send-email-kan.liang@linux.intel.com/
> 
> Should I send a V10 patch to drop the generic code and implement an X86
> specific perf_get_page_size()? Will, Michael, and others can implement their
> version later separately.

Nah, that generic function, should work for 90% of all archs, it's just
a few oddballs that need something else.

Also, if we add that hugetlb exception, we'll even get the usermap for
those oddballs right.

I'll take this version after the merge window, I'll add __weak for the
oddballs and also add the hugetlb userspace thing on top.
