Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D9D288664
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 11:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbgJIJxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 05:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgJIJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 05:53:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F4C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/ClJchKp0ikj2wNIM+u+4iC4WzNwd2ei6WliGpK0apI=; b=c7i9Yo8NOF+jporKly0ZFFUffi
        XmNjqy56fbFatcBuFMJPFsiBaO3UrG0H3IZ/tzxzuDwWSedBFCs3foE8BZ8As6e5kmrAbmXG338Vs
        BOgtVfUX6SBxhDrUSrn79iJIeXJFfOdJ+ysWZSh7YOmvZKP24rxNc34kcXhspSfQkEmSXTr7wCq8/
        KHQSTuPEKfx4c8mhmq8ue/6iIQF6DRCjXPnb8tMJRqurbv9ZDBSvY/xShPczWTWNX1BUuKru2yOSB
        6p0SkVTRoAzxRjOyvwi4PTf+OSUwCRPn5Kht28zAucz4+wiGKrLNOR5p44JsqqDM/CEOnUe24gh6r
        dSoSFiig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQp5C-0005ck-08; Fri, 09 Oct 2020 09:53:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12F52300B22;
        Fri,  9 Oct 2020 11:53:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0162829E787A9; Fri,  9 Oct 2020 11:53:00 +0200 (CEST)
Date:   Fri, 9 Oct 2020 11:53:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     kan.liang@linux.intel.com, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        eranian@google.com, ak@linux.intel.com, dave.hansen@intel.com,
        kirill.shutemov@linux.intel.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201009095300.GI2628@hirez.programming.kicks-ass.net>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <20201009093750.GD29594@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009093750.GD29594@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 10:37:51AM +0100, Will Deacon wrote:
> On Fri, Oct 09, 2020 at 11:09:27AM +0200, Peter Zijlstra wrote:

> > Patch 4 makes it all far worse by exposing it to pretty much everybody.
> > 
> > Now, I think we can fix at least the user mappings with the below delta,
> > but if archs are using non-page-table MMU sizes we'll need arch helpers.
> > 
> > ARM64 is in that last boat.
> > 
> > Will, can you live with the below, if not, what would you like to do,
> > make the entire function __weak so that you can override it, or hook
> > into it somewhere?
> 
> Hmm, so I don't think we currently have any PMUs that set 'data->addr'
> on arm64, in which case maybe none of this currently matters for us.
> 
> However, I must admit that I couldn't figure out exactly what gets exposed
> to userspace when the backend drivers don't look at the sample_type or
> do anything with the addr field.

Patch 4:

  https://lkml.kernel.org/r/20201001135749.2804-5-kan.liang@linux.intel.com

is the one that exposes this to everybody with perf support. It will
then report the page-size for the code address (SAMPLE_IP).

