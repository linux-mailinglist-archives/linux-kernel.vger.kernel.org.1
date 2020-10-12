Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6168828B08B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgJLIsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLIsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:48:36 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 125C020773;
        Mon, 12 Oct 2020 08:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602492515;
        bh=cCsb7DHMH1TLtqM3vgMHvWsrDmhMZmW/jNR9XvpQzko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OS0H5doFjiXqph3ehhylpNM+q9XJrnGqdIN80pHFDByD3AYZc+DWrZJ4pSV/XkVci
         HJkzWO57y1hf/VyyeKlmezv5aJukU9xTC6f48H9O/OXC9O8+AhB9HKUkHz+FBtFZDe
         wZFlDx8TXms+Ig6pPm0j0vUlO046LgPdNbXZoZL8=
Date:   Mon, 12 Oct 2020 09:48:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Peter Zijlstra <peterz@infradead.org>, kan.liang@linux.intel.com,
        mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH V9 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
Message-ID: <20201012084829.GA1151@willie-the-truck>
References: <20201001135749.2804-1-kan.liang@linux.intel.com>
 <20201001135749.2804-2-kan.liang@linux.intel.com>
 <20201009090927.GQ2611@hirez.programming.kicks-ass.net>
 <877drz1qbc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877drz1qbc.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 12:28:39AM +1100, Michael Ellerman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> > Patch 4 makes it all far worse by exposing it to pretty much everybody.
> >
> > Now, I think we can fix at least the user mappings with the below delta,
> > but if archs are using non-page-table MMU sizes we'll need arch helpers.
> >
> > ARM64 is in that last boat.
> 
> I think we probably need it to be weak so we can provide our own
> version.

I guess the same thing applies to us, but I can't really tell how accurate
this stuff needs to be for userspace. If it's trying to use the page-table
configuration to infer properties of the TLB, that's never going to be
reliable because the TLB can choose both to split and coalesce entries
as long as software can't tell.

Will
