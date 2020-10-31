Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686502A14A5
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgJaJSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgJaJSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:18:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32979C0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 02:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kYWfALRVcBCFHBQ/RrdwzZwApPa0veZid43YJsFg5rs=; b=J39OokUjROh49fMqP/g9P0k59t
        vy1GzdFhgDsLcq+KKG6sombhhx4enctFBxjAZ9bfNgcFMuIDxVwPqx5drpS5jC8myPifQd5Vd4XZ3
        4TZIOLl/cQJvecYUtu/Pw0IP5xmdCXziqKBLcvvFK9lGpoMsvs/pxLCBH4il4kpqUkZqLZ6qfblI5
        jjrVIcNNdxJK01PzKiV9RyNB98FSHSR8SbOlqC2uT5gUSPjv6h3D/8pG61VhS+t3xzIYsLLplvOgM
        dX9t9Wg5Hf+PK/TQsSE31eD95m3lnEydYWKhNCiKEYczL3VffV2X180mH6m3Pg7g3wJZ61tZu/wMn
        bdoTRjxg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYn26-000842-I3; Sat, 31 Oct 2020 09:18:46 +0000
Date:   Sat, 31 Oct 2020 09:18:46 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, Steven Price <steven.price@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@google.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Pratik Patel <pratikp@codeaurora.org>
Subject: Re: mm/memblock: export memblock_{start/end}_of_DRAM
Message-ID: <20201031091846.GA30512@infradead.org>
References: <d0580051d03df3f3e9f333f6bfe968cf@codeaurora.org>
 <20201030083842.GA4319@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030083842.GA4319@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:38:42AM +0200, Mike Rapoport wrote:
>  
> What do you mean by "system memory block"? There could be a lot of
> interpretations if you take into account memory hotplug, "mem=" option,
> reserved and firmware memory.
> 
> I'd suggest you to describe the entire use case in more detail. Having
> the complete picture would help finding a proper solution.

I think we need the code for the driver trying to do this as an RFC
submission.  Everything else is rather pointless.
