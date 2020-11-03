Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3682A3F0B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgKCIiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgKCIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:38:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92E0C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qN0bHUKAHFEL54H3lvuQSCj9tnCx/ESpYXkr6/VPy1E=; b=pdBoEAt6CB5d3scOUIeQioqtKt
        7ysFdZ2jQGKsMhyPfcGGZ5wmkjrksdVUVLxJ3jePEVnwYee6uo0DD8bGGQSPHgn+SLMPC+QomEMKr
        sTwblJDDPD2Od4P76fONdJkUbORtiYRpl2ebO4d+0svUvqRdEDJMrp/0fGn6EHrTkY3NRwRfbZeah
        0u8kuvZu1YVEVZFBW7mXj150YT9yoAxAtexlzSK2Xx0QiUy+6ETjmIUP/0RvdB8aiX2uNAfDS5D0M
        W6Wi2wFODAA0qA+jTa1BRmgDecu9jFPKEHlmYu2HjfDgd89PJu17TAi9kHqX6bpDfJZCXqcCAJ29V
        0/exxXVQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZrpN-0002k0-0U; Tue, 03 Nov 2020 08:38:05 +0000
Date:   Tue, 3 Nov 2020 08:38:04 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: mm/memblock: export memblock_{start/end}_of_DRAM
Message-ID: <20201103083804.GE9092@infradead.org>
References: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
 <20201030083842.GA4319@kernel.org>
 <20201031091846.GA30512@infradead.org>
 <db82e52c-0159-777d-8fa9-7b5cf93eca7f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db82e52c-0159-777d-8fa9-7b5cf93eca7f@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 11:05:45AM +0100, David Hildenbrand wrote:
> On 31.10.20 10:18, Christoph Hellwig wrote:
> > On Fri, Oct 30, 2020 at 10:38:42AM +0200, Mike Rapoport wrote:
> > > What do you mean by "system memory block"? There could be a lot of
> > > interpretations if you take into account memory hotplug, "mem=" option,
> > > reserved and firmware memory.
> > > 
> > > I'd suggest you to describe the entire use case in more detail. Having
> > > the complete picture would help finding a proper solution.
> > 
> > I think we need the code for the driver trying to do this as an RFC
> > submission.  Everything else is rather pointless.
> 
> Sharing RFCs is most probably not what people want when developing advanced
> hypervisor features :)

Well, if they can't even do that it really has no relevance for kernel
development.
