Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4A2928C3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgJSOFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgJSOFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:05:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F55C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7cHixztk+aJ6m1DqgkC/D6JVx1lre0juphMCuUXcddk=; b=jZV+CKvoinHX2xUY6LzrRLhwDo
        fX9Y3i+nyQT3gQP4fvZgulqHu/QLnfwJzQIm4gizzw8Pgc0u1h/ZUNSqOk/Vr8M2Ykc3zzywWJYw8
        HA/lC5N3eeu+/ZuXE3s/xuu4ubbMOjeGkT+OP+gTbs0QPQWEAfewltpbFDjh4cBDlstNfE5dBmaXP
        O1L878S+nSp4YSnm2KERc3wiOoFxe9nBO5ZSdN8FMpeZbOxMyLWtcdSwQcH1aRuC8JLQcofR0XrSe
        JI53WHqcoUoJCg85AbXTeCtcUFA+Nu9rLiB7JmUHVBqSyqxizkFZLYp3Fr5pdvILObtn6HKYiq7es
        6a1x2VcA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUVmb-0004C8-2k; Mon, 19 Oct 2020 14:05:05 +0000
Date:   Mon, 19 Oct 2020 15:05:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/test_free_pages: Add basic progress indicators
Message-ID: <20201019140505.GR20115@casper.infradead.org>
References: <20201018140445.20972-1-geert@linux-m68k.org>
 <20201018142508.GJ20115@casper.infradead.org>
 <CAMuHMdVcTx0wVTSh-YaJxXqCMpCxGRe3QH36O5i+McinfdRwDg@mail.gmail.com>
 <20201018150146.GK20115@casper.infradead.org>
 <20201018171252.GA392079@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018171252.GA392079@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 08:12:52PM +0300, Mike Rapoport wrote:
> On Sun, Oct 18, 2020 at 04:01:46PM +0100, Matthew Wilcox wrote:
> > On Sun, Oct 18, 2020 at 04:39:27PM +0200, Geert Uytterhoeven wrote:
> > > Hi Matthew,
> > > 
> > > On Sun, Oct 18, 2020 at 4:25 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > > On Sun, Oct 18, 2020 at 04:04:45PM +0200, Geert Uytterhoeven wrote:
> > > > > The test module to check that free_pages() does not leak memory does not
> > > > > provide any feedback whatsoever its state or progress, but may take some
> > > > > time on slow machines.  Add the printing of messages upon starting each
> > > > > phase of the test, and upon completion.
> > > >
> > > > It's not supposed to take a long time.  Can you crank down that 1000 *
> > > 
> > > It took 1m11s on ARAnyM, running on an i7-8700K.
> > > Real hardware may even take longer.
> > 
> > 71 seconds is clearly too long.  0.7 seconds would be fine, so 10 * 1000
> > would be appropriate, but then that's only 320MB which might not be
> > enough to notice on a modern machine.
> > 
> > > > 1000 to something more appropriate?
> > > 
> > > What would be a suitable value? You do want to see it "leak gigabytes
> > > of memory and probably OOM your system" if something's wrong,
> > > so decreasing the value a lot may not be a good idea?
> > > 
> > > Regardless, if it OOMs, I think you do want to see this happens
> > > while running this test.
> > 
> > How about scaling with the amount of memory on the machine?
> > 
> > This might cause problems on machines with terabytes of memory.
> > Maybe we should cap it at a terabyte?
> 
> On ARAnyM wih 782 MBytes of RAM running on i7-8650U it takes ~1.75
> seconds.

That seems like a somewhat unusual configuration.  I think it's pretty
strange to find an actual m68k with more than 128MB of memory.  I mean,
I can set up my laptop to believe it has 64TB of memory, and this will
run slowly, but I don't think it's any real problem.

> Still, I think adding some verbosity to the test wouldn't hurt ;-)

I prefer the unix philosophy of only emitting messages if something's
wrong.

